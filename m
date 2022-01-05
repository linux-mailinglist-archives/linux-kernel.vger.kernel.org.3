Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E725E484F68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbiAEIe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbiAEIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:34:52 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A460AC061792
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 00:34:51 -0800 (PST)
Received: from dslb-188-097-046-135.188.097.pools.vodafone-ip.de ([188.97.46.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n51kr-0005mc-Og; Wed, 05 Jan 2022 09:34:45 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/7] staging: r8188eu: make Index24G_BW40_Base a 1-D array
Date:   Wed,  5 Jan 2022 09:34:22 +0100
Message-Id: <20220105083426.177128-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220105083426.177128-1-martin@kaiser.cx>
References: <20220105083426.177128-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Index24G_BW40_Base a one-dimensional array. This driver uses
only Index24G_BW40_Base[0].

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 6 +++---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c   | 6 +++---
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 1a82b2df7f21..3325bc876d38 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1131,13 +1131,13 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 
 		pHalData->Index24G_CCK_Base[ch] = pwrInfo24G.IndexCCK_Base[0][group];
 		if (ch == 14)
-			pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][4];
+			pHalData->Index24G_BW40_Base[ch] = pwrInfo24G.IndexBW40_Base[0][4];
 		else
-			pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][group];
+			pHalData->Index24G_BW40_Base[ch] = pwrInfo24G.IndexBW40_Base[0][group];
 
 		DBG_88E("======= Path 0, Channel %d =======\n", ch);
 		DBG_88E("Index24G_CCK_Base[%d] = 0x%x\n", ch, pHalData->Index24G_CCK_Base[ch]);
-		DBG_88E("Index24G_BW40_Base[0][%d] = 0x%x\n", ch, pHalData->Index24G_BW40_Base[0][ch]);
+		DBG_88E("Index24G_BW40_Base[%d] = 0x%x\n", ch, pHalData->Index24G_BW40_Base[ch]);
 	}
 	for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
 		pHalData->CCK_24G_Diff[0][TxCount] = pwrInfo24G.CCK_Diff[0][TxCount];
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index de7a2f5caf48..650de81b7ed3 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -591,13 +591,13 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 	/*  1. CCK */
 	cckPowerLevel[RF_PATH_A] = pHalData->Index24G_CCK_Base[index];
 	/* 2. OFDM */
-	ofdmPowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+	ofdmPowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[index] +
 		pHalData->OFDM_24G_Diff[RF_PATH_A][RF_PATH_A];
 	/*  1. BW20 */
-	BW20PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
+	BW20PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[index] +
 		pHalData->BW20_24G_Diff[RF_PATH_A][RF_PATH_A];
 	/* 2. BW40 */
-	BW40PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[RF_PATH_A][index];
+	BW40PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[index];
 }
 
 static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 66b525ca3510..3420830396dc 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -179,7 +179,7 @@ struct hal_data_8188e {
 	u8	EEPROMThermalMeter;
 
 	u8	Index24G_CCK_Base[CHANNEL_MAX_NUMBER];
-	u8	Index24G_BW40_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	u8	Index24G_BW40_Base[CHANNEL_MAX_NUMBER];
 	/* If only one tx, only BW20 and OFDM are used. */
 	s8	CCK_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
 	s8	OFDM_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
-- 
2.30.2

