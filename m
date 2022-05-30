Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D451F537633
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiE3IFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiE3IFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:05:39 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD2074DFF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:05:36 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 30 May
 2022 16:05:36 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 30 May
 2022 16:05:34 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: rtl8712: Fix pointer dereferenced before checking
Date:   Mon, 30 May 2022 16:05:32 +0800
Message-ID: <1653897933-25931-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The padapter->recvpriv.signal_qual_data is dereferencing before null
checking, so move it after checking.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 7f1fdd058551..8ed94b259dbe 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -863,10 +863,12 @@ static void process_link_qual(struct _adapter *padapter,
 {
 	u32	last_evm = 0, tmpVal;
 	struct rx_pkt_attrib *pattrib;
-	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
+	struct smooth_rssi_data *sqd;
 
 	if (!prframe || !padapter)
 		return;
+
+	sqd = &padapter->recvpriv.signal_qual_data;
 	pattrib = &prframe->u.hdr.attrib;
 	if (pattrib->signal_qual != 0) {
 		/*
-- 
2.7.4

