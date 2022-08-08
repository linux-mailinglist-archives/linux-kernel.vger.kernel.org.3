Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3229A58CEF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbiHHUOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbiHHUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:14:40 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F01A055
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:14:38 -0700 (PDT)
Received: from dslb-188-096-136-209.188.096.pools.vodafone-ip.de ([188.96.136.209] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oL98z-0000V9-54; Mon, 08 Aug 2022 22:14:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: the high prio queue is always selected
Date:   Mon,  8 Aug 2022 22:14:05 +0200
Message-Id: <20220808201405.68966-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808201405.68966-1-martin@kaiser.cx>
References: <20220808201405.68966-1-martin@kaiser.cx>
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

The high priority queue is always selected, regardless of the number of
out endpoints.

Therefore, haldata->OutEpQueueSel & TX_SELE_HQ is always true. We can
remove the check and use a define instead of the numHQ variable.

This check was the last user of TX_SELE_HQ. Rename haldata->OutEpQueueSel
to haldata->out_ep_extra_queues and store only the queues that are selected
in addition to the high priority queue.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c       | 17 ++++++-----------
 drivers/staging/r8188eu/include/rtl8188e_hal.h  |  3 +--
 drivers/staging/r8188eu/include/rtl8188e_spec.h |  2 ++
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 25fd6b46e76d..63c5cec655d5 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -69,15 +69,14 @@ int rtl8188eu_interface_configure(struct adapter *adapt)
 
 	switch (pdvobjpriv->RtNumOutPipes) {
 	case 3:
-		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_LQ | TX_SELE_NQ;
+		haldata->out_ep_extra_queues = TX_SELE_LQ | TX_SELE_NQ;
 		three_out_pipe(adapt, wifi_cfg);
 		break;
 	case 2:
-		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_NQ;
+		haldata->out_ep_extra_queues = TX_SELE_NQ;
 		two_out_pipe(adapt, wifi_cfg);
 		break;
 	case 1:
-		haldata->OutEpQueueSel = TX_SELE_HQ;
 		one_out_pipe(adapt);
 		break;
 	default:
@@ -154,28 +153,24 @@ static void _InitQueueReservedPage(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
-	u8 numHQ = 0;
 	u8 numLQ = 0;
 	u8 numNQ = 0;
 	u8 numPubQ;
 
 	if (pregistrypriv->wifi_spec) {
-		if (haldata->OutEpQueueSel & TX_SELE_HQ)
-			numHQ =  0x29;
-
-		if (haldata->OutEpQueueSel & TX_SELE_LQ)
+		if (haldata->out_ep_extra_queues & TX_SELE_LQ)
 			numLQ = 0x1C;
 
 		/*  NOTE: This step shall be proceed before writing REG_RQPN. */
-		if (haldata->OutEpQueueSel & TX_SELE_NQ)
+		if (haldata->out_ep_extra_queues & TX_SELE_NQ)
 			numNQ = 0x1C;
 
 		rtw_write8(Adapter, REG_RQPN_NPQ, numNQ);
 
-		numPubQ = 0xA8 - numHQ - numLQ - numNQ;
+		numPubQ = 0xA8 - NUM_HQ - numLQ - numNQ;
 
 		/*  TX DMA */
-		rtw_write32(Adapter, REG_RQPN, LD_RQPN | numPubQ << 16 | numLQ << 8 | numHQ);
+		rtw_write32(Adapter, REG_RQPN, LD_RQPN | numPubQ << 16 | numLQ << 8 | NUM_HQ);
 	} else {
 		rtw_write16(Adapter, REG_RQPN_NPQ, 0x0000);/* Just follow MP Team,??? Georgia 03/28 */
 		rtw_write16(Adapter, REG_RQPN_NPQ, 0x0d);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index ff0a4ce19dde..64cdc2fad20e 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -36,7 +36,6 @@
       0x2400 /* 9k for 88E nornal chip , MaxRxBuff=10k-max(TxReportSize(64*8),
 	      * WOLPattern(16*24)) */
 
-#define TX_SELE_HQ			BIT(0)		/*  High Queue */
 #define TX_SELE_LQ			BIT(1)		/*  Low Queue */
 #define TX_SELE_NQ			BIT(2)		/*  Normal Queue */
 
@@ -149,7 +148,7 @@ struct hal_data_8188e {
 	u8	AntDivCfg;
 	u8	TRxAntDivType;
 
-	u8	OutEpQueueSel;
+	u8	out_ep_extra_queues;
 
 	struct P2P_PS_Offload_t	p2p_ps_offload;
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 5d12ba46e205..e34619140e33 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -925,6 +925,8 @@ Current IOREG MAP
 
 /* 	0x0200h ~ 0x027Fh	TXDMA Configuration */
 
+#define NUM_HQ 0x29
+
 #define LD_RQPN				BIT(31)
 
 /* 2TDECTRL */
-- 
2.30.2

