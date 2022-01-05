Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47E484F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiAEIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiAEIe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:34:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328FC061784
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 00:34:56 -0800 (PST)
Received: from dslb-188-097-046-135.188.097.pools.vodafone-ip.de ([188.97.46.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n51kx-0005mc-GU; Wed, 05 Jan 2022 09:34:51 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 7/7] staging: r8188eu: make BW20_24G_Diff a 1-D array
Date:   Wed,  5 Jan 2022 09:34:26 +0100
Message-Id: <20220105083426.177128-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220105083426.177128-1-martin@kaiser.cx>
References: <20220105083426.177128-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make BW20_24G_Diff a one-dimensional array. This driver uses only
BW20_24G_Diff[0].

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c   | 2 +-
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index d07b16ebe936..c9ccd05909e5 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1141,10 +1141,10 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 	}
 	for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
 		pHalData->OFDM_24G_Diff[TxCount] = pwrInfo24G.OFDM_Diff[0][TxCount];
-		pHalData->BW20_24G_Diff[0][TxCount] = pwrInfo24G.BW20_Diff[0][TxCount];
+		pHalData->BW20_24G_Diff[TxCount] = pwrInfo24G.BW20_Diff[0][TxCount];
 		DBG_88E("======= TxCount %d =======\n", TxCount);
 		DBG_88E("OFDM_24G_Diff[%d] = %d\n", TxCount, pHalData->OFDM_24G_Diff[TxCount]);
-		DBG_88E("BW20_24G_Diff[0][%d] = %d\n", TxCount, pHalData->BW20_24G_Diff[0][TxCount]);
+		DBG_88E("BW20_24G_Diff[%d] = %d\n", TxCount, pHalData->BW20_24G_Diff[TxCount]);
 	}
 
 	/*  2010/10/19 MH Add Regulator recognize for CU. */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 3b5ddc00606e..302b15b2874d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -595,7 +595,7 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 		pHalData->OFDM_24G_Diff[RF_PATH_A];
 	/*  1. BW20 */
 	BW20PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[index] +
-		pHalData->BW20_24G_Diff[RF_PATH_A][RF_PATH_A];
+		pHalData->BW20_24G_Diff[RF_PATH_A];
 	/* 2. BW40 */
 	BW40PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[index];
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index e748bdcbd867..8134a173ea07 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -182,7 +182,7 @@ struct hal_data_8188e {
 	u8	Index24G_BW40_Base[CHANNEL_MAX_NUMBER];
 	/* If only one tx, only BW20 and OFDM are used. */
 	s8	OFDM_24G_Diff[MAX_TX_COUNT];
-	s8	BW20_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+	s8	BW20_24G_Diff[MAX_TX_COUNT];
 
 	/*  HT 20<->40 Pwr diff */
 	u8	TxPwrHt20Diff[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
-- 
2.30.2

