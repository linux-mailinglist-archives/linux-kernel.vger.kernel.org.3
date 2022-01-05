Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92201484F67
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiAEIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiAEIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:34:51 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6524AC061784
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 00:34:51 -0800 (PST)
Received: from dslb-188-097-046-135.188.097.pools.vodafone-ip.de ([188.97.46.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n51kt-0005mc-6s; Wed, 05 Jan 2022 09:34:47 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/7] staging: r8188eu: CCK_24G_Diff is set but not used
Date:   Wed,  5 Jan 2022 09:34:23 +0100
Message-Id: <20220105083426.177128-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220105083426.177128-1-martin@kaiser.cx>
References: <20220105083426.177128-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CCK_24G_Diff array is set but not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 --
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 3325bc876d38..63467b1d0224 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1140,12 +1140,10 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 		DBG_88E("Index24G_BW40_Base[%d] = 0x%x\n", ch, pHalData->Index24G_BW40_Base[ch]);
 	}
 	for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
-		pHalData->CCK_24G_Diff[0][TxCount] = pwrInfo24G.CCK_Diff[0][TxCount];
 		pHalData->OFDM_24G_Diff[0][TxCount] = pwrInfo24G.OFDM_Diff[0][TxCount];
 		pHalData->BW20_24G_Diff[0][TxCount] = pwrInfo24G.BW20_Diff[0][TxCount];
 		pHalData->BW40_24G_Diff[0][TxCount] = pwrInfo24G.BW40_Diff[0][TxCount];
 		DBG_88E("======= TxCount %d =======\n", TxCount);
-		DBG_88E("CCK_24G_Diff[0][%d] = %d\n", TxCount, pHalData->CCK_24G_Diff[0][TxCount]);
 		DBG_88E("OFDM_24G_Diff[0][%d] = %d\n", TxCount, pHalData->OFDM_24G_Diff[0][TxCount]);
 		DBG_88E("BW20_24G_Diff[0][%d] = %d\n", TxCount, pHalData->BW20_24G_Diff[0][TxCount]);
 		DBG_88E("BW40_24G_Diff[0][%d] = %d\n", TxCount, pHalData->BW40_24G_Diff[0][TxCount]);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 3420830396dc..3f818e97bde0 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -181,7 +181,6 @@ struct hal_data_8188e {
 	u8	Index24G_CCK_Base[CHANNEL_MAX_NUMBER];
 	u8	Index24G_BW40_Base[CHANNEL_MAX_NUMBER];
 	/* If only one tx, only BW20 and OFDM are used. */
-	s8	CCK_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
 	s8	OFDM_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
 	s8	BW20_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
 	s8	BW40_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
-- 
2.30.2

