Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF74805D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 04:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhL1DDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 22:03:55 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:41483 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234588AbhL1DDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 22:03:54 -0500
X-UUID: 8dc7fd443744488e88793d9421bfb8fe-20211228
X-CPASD-INFO: 9af1861e893444019b80aa99608abe28@grGgUWVoX5VkWXWAg3d7a1mTaGCRjVm
        IeGpYkZCVXliVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3iKOgUWhkYQ==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 9af1861e893444019b80aa99608abe28
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:173.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:147.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4488.0,FROMTO:0,AD:0,FFOB:0.0,CF
        OB:0.0,SPC:0.0,SIG:-5,AUF:102,DUF:28286,ACD:146,DCD:248,SL:0,AG:0,CFC:0.483,C
        FSR:0.052,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: 8dc7fd443744488e88793d9421bfb8fe-20211228
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: 8dc7fd443744488e88793d9421bfb8fe-20211228
X-User: yinxiujiang@kylinos.cn
Received: from localhost.localdomain [(118.26.139.139)] by nksmu.kylinos.cn
        (envelope-from <yinxiujiang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1729494983; Tue, 28 Dec 2021 11:16:21 +0800
From:   Yin Xiujiang <yinxiujiang@kylinos.cn>
To:     skashyap@marvell.com, jhasan@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, yinxiujiang@kylinos.cn
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bnx2fc: fix double free of skb in bnx2fc_rcv
Date:   Tue, 28 Dec 2021 11:03:35 +0800
Message-Id: <20211228030335.1330070-1-yinxiujiang@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In `bnx2fc_rcv`,if skb_share_check() return NULL,
the variable skb would be freed but not set to NULL,
then it would be freed  in `goto err` again.

Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 71fa62bd3083..07a91b1f05a2 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -432,7 +432,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct fcoe_ctlr *ctlr;
 	struct fcoe_rcv_info *fr;
 	struct fcoe_percpu_s *bg;
-	struct sk_buff *tmp_skb;
 
 	interface = container_of(ptype, struct bnx2fc_interface,
 				 fcoe_packet_type);
@@ -444,11 +443,10 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto err;
 	}
 
-	tmp_skb = skb_share_check(skb, GFP_ATOMIC);
-	if (!tmp_skb)
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (unlikely(!skb))
 		goto err;
 
-	skb = tmp_skb;
 
 	if (unlikely(eth_hdr(skb)->h_proto != htons(ETH_P_FCOE))) {
 		printk(KERN_ERR PFX "bnx2fc_rcv: Wrong FC type frame\n");
-- 
2.30.0

