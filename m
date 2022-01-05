Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B104F484F66
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiAEIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiAEIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:34:47 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F03C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 00:34:47 -0800 (PST)
Received: from dslb-188-097-046-135.188.097.pools.vodafone-ip.de ([188.97.46.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n51ko-0005mc-Ht; Wed, 05 Jan 2022 09:34:42 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/7] staging: r8188eu: make Index24G_CCK_Base a 1-D array
Date:   Wed,  5 Jan 2022 09:34:21 +0100
Message-Id: <20220105083426.177128-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220105083426.177128-1-martin@kaiser.cx>
References: <20220105083426.177128-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make Index24G_CCK_Base a one-dimensional array. This driver uses only
Index24G_CCK_Base[0].

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c   | 2 +-
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b07ccc27b96b..1a82b2df7f21 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1129,14 +1129,14 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 	for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
 		hal_get_chnl_group_88e(ch, &group);
 
-		pHalData->Index24G_CCK_Base[0][ch] = pwrInfo24G.IndexCCK_Base[0][group];
+		pHalData->Index24G_CCK_Base[ch] = pwrInfo24G.IndexCCK_Base[0][group];
 		if (ch == 14)
 			pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][4];
 		else
 			pHalData->Index24G_BW40_Base[0][ch] = pwrInfo24G.IndexBW40_Base[0][group];
 
 		DBG_88E("======= Path 0, Channel %d =======\n", ch);
-		DBG_88E("Index24G_CCK_Base[0][%d] = 0x%x\n", ch, pHalData->Index24G_CCK_Base[0][ch]);
+		DBG_88E("Index24G_CCK_Base[%d] = 0x%x\n", ch, pHalData->Index24G_CCK_Base[ch]);
 		DBG_88E("Index24G_BW40_Base[0][%d] = 0x%x\n", ch, pHalData->Index24G_BW40_Base[0][ch]);
 	}
 	for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index faabfd61f5b4..de7a2f5caf48 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -589,7 +589,7 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 	u8 index = (channel - 1);
 
 	/*  1. CCK */
-	cckPowerLevel[RF_PATH_A] = pHalData->Index24G_CCK_Base[RF_PATH_A][index];
+	cckPowerLevel[RF_PATH_A] = pHalData->Index24G_CCK_Base[index];
 	/* 2. OFDM */
 	ofdmPowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
 		pHalData->OFDM_24G_Diff[RF_PATH_A][RF_PATH_A];
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 25f3c04e81b7..66b525ca3510 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -178,7 +178,7 @@ struct hal_data_8188e {
 	u8	EEPROMRegulatory;
 	u8	EEPROMThermalMeter;
 
-	u8	Index24G_CCK_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	u8	Index24G_CCK_Base[CHANNEL_MAX_NUMBER];
 	u8	Index24G_BW40_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	/* If only one tx, only BW20 and OFDM are used. */
 	s8	CCK_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
-- 
2.30.2

