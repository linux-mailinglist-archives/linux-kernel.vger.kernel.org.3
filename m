Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B838F49C0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiAZBnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:43:03 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:5332 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235863AbiAZBnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:43:02 -0500
X-UUID: 0210256d97bd42a4a8887a9e4d1cccef-20220126
X-CPASD-INFO: 88fb96bf2ded4c56ad9dbd597cdd4cbc@gYiggmZokJZehKewg6aAcIGVaZSSkFW
        IeZ2ElGKTjoOVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3h3qggmlkkg==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 88fb96bf2ded4c56ad9dbd597cdd4cbc
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:173.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:113.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4488.0,FROMTO:0,AD:0,FFOB:0.0,CF
        OB:0.0,SPC:0.0,SIG:-5,AUF:104,DUF:31763,ACD:175,DCD:277,SL:0,AG:0,CFC:0.229,C
        FSR:0.148,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: 0210256d97bd42a4a8887a9e4d1cccef-20220126
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: 0210256d97bd42a4a8887a9e4d1cccef-20220126
X-User: yinxiujiang@kylinos.cn
Received: from localhost.localdomain [(118.26.139.139)] by nksmu.kylinos.cn
        (envelope-from <yinxiujiang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1017235085; Wed, 26 Jan 2022 09:55:38 +0800
From:   Yin Xiujiang <yinxiujiang@kylinos.cn>
To:     skashyap@marvell.com, jhasan@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bnx2fc: Make use of the helper macro kthread_run()
Date:   Wed, 26 Jan 2022 09:42:48 +0800
Message-Id: <20220126014248.466806-1-yinxiujiang@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 71fa62bd3083..5edc2b812646 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2723,14 +2723,13 @@ static int __init bnx2fc_mod_init(void)
 
 	bg = &bnx2fc_global;
 	skb_queue_head_init(&bg->fcoe_rx_list);
-	l2_thread = kthread_create(bnx2fc_l2_rcv_thread,
+	l2_thread = kthread_run(bnx2fc_l2_rcv_thread,
 				   (void *)bg,
 				   "bnx2fc_l2_thread");
 	if (IS_ERR(l2_thread)) {
 		rc = PTR_ERR(l2_thread);
 		goto free_wq;
 	}
-	wake_up_process(l2_thread);
 	spin_lock_bh(&bg->fcoe_rx_list.lock);
 	bg->kthread = l2_thread;
 	spin_unlock_bh(&bg->fcoe_rx_list.lock);
-- 
2.30.0

