Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7043E4C5D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiB0Qm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiB0Qmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:42:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB26D192
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:42:14 -0800 (PST)
Received: from ipservice-092-217-088-081.092.217.pools.vodafone-ip.de ([92.217.88.81] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nOMcc-0005Z9-IH; Sun, 27 Feb 2022 17:42:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 4/8] staging: r8188eu: use ieee80211 helper for qos bit
Date:   Sun, 27 Feb 2022 17:41:43 +0100
Message-Id: <20220227164147.1168847-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220227164147.1168847-1-martin@kaiser.cx>
References: <20220218135038.908307-1-martin@kaiser.cx>
 <20220227164147.1168847-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ieee80211_is_data_qos helper function to read the qos bit.

This helper function returns a bool. Change the qos field in struct
rx_pkt_attrib from u8 to bool and fix up the other places where it
is used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c       | 9 +++------
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 2 +-
 drivers/staging/r8188eu/include/rtw_recv.h    | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 364bf78c36e9..3a92d261f7c3 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1012,7 +1012,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	pattrib->amsdu = 0;
 	pattrib->ack_policy = 0;
 	/* parsing QC field */
-	if (pattrib->qos == 1) {
+	if (pattrib->qos) {
 		pattrib->priority = GetPriority((ptr + 24));
 		pattrib->ack_policy = GetAckpolicy((ptr + 24));
 		pattrib->amsdu = GetAMsdu((ptr + 24));
@@ -1057,7 +1057,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 	/* then call check if rx seq/frag. duplicated. */
 
-	u8 subtype;
 	int retval = _FAIL;
 	u8 bDumpRxPkt;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
@@ -1076,8 +1075,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	if (ver != 0)
 		return _FAIL;
 
-	subtype = GetFrameSubType(ptr); /* bit(7)~bit(2) */
-
 	pattrib->to_fr_ds = get_tofr_ds(ptr);
 
 	pattrib->frag_num = GetFragNum(ptr);
@@ -1099,7 +1096,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 		validate_recv_ctrl_frame(adapter, precv_frame);
 	else if (ieee80211_is_data(fc)) {
 		rtw_led_control(adapter, LED_CTL_RX);
-		pattrib->qos = (subtype & BIT(7)) ? 1 : 0;
+		pattrib->qos = ieee80211_is_data_qos(fc);
 		retval = validate_recv_data_frame(adapter, precv_frame);
 		if (retval == _FAIL) {
 			struct recv_priv *precvpriv = &adapter->recvpriv;
@@ -1599,7 +1596,7 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, struct recv_frame
 		/* s1. */
 		wlanhdr_to_ethhdr(prframe);
 
-		if (pattrib->qos != 1) {
+		if (!pattrib->qos) {
 			if (!padapter->bDriverStopped &&
 			    !padapter->bSurpriseRemoved) {
 				rtw_recv_indicatepkt(padapter, prframe);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index bf93ff3af140..101091342e4e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -84,7 +84,7 @@ void update_recvframe_attrib_88e(struct recv_frame *precvframe, struct recv_stat
 		pattrib->bdecrypted = (le32_to_cpu(report.rxdw0) & BIT(27)) ? 0 : 1;/* u8)(prxreport->swdec ? 0 : 1); */
 		pattrib->encrypt = (u8)((le32_to_cpu(report.rxdw0) >> 20) & 0x7);/* u8)prxreport->security; */
 
-		pattrib->qos = (u8)((le32_to_cpu(report.rxdw0) >> 23) & 0x1);/* u8)prxreport->qos; */
+		pattrib->qos = (le32_to_cpu(report.rxdw0) >> 23) & 0x1;/* prxreport->qos; */
 		pattrib->priority = (u8)((le32_to_cpu(report.rxdw1) >> 8) & 0xf);/* u8)prxreport->tid; */
 
 		pattrib->amsdu = (u8)((le32_to_cpu(report.rxdw1) >> 13) & 0x1);/* u8)prxreport->amsdu; */
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 6a6f6373467b..d2f1c71f2262 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -82,7 +82,7 @@ struct rx_pkt_attrib {
 	u8	hdrlen; /* the WLAN Header Len */
 	u8	to_fr_ds;
 	u8	amsdu;
-	u8	qos;
+	bool	qos;
 	u8	priority;
 	u8	pw_save;
 	u8	mdata;
-- 
2.30.2

