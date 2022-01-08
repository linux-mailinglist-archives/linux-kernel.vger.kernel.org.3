Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193EC4883A1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiAHMue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiAHMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:23 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18091C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:23 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAp-0005EJ-Dv; Sat, 08 Jan 2022 13:50:19 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/12] staging: r8188eu: CurrentCckTxPwrIdx is set but not used
Date:   Sat,  8 Jan 2022 13:49:56 +0100
Message-Id: <20220108124959.313215-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CurrentCckTxPwrIdx in struct hal_data_8188e is set but not used.
It can be removed.

The phy_PowerIndexCheck88E function is now empty. Remove it as well.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c  | 10 ----------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index a80f40fccf09..c1639df8b1e7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -581,14 +581,6 @@ static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPower
 	BW40PowerLevel[RF_PATH_A] = pHalData->Index24G_BW40_Base[index];
 }
 
-static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
-				   u8 *ofdmPowerLevel, u8 *BW20PowerLevel, u8 *BW40PowerLevel)
-{
-	struct hal_data_8188e *pHalData = &Adapter->haldata;
-
-	pHalData->CurrentCckTxPwrIdx = cckPowerLevel[0];
-}
-
 /*-----------------------------------------------------------------------------
  * Function:    SetTxPowerLevel8190()
  *
@@ -619,8 +611,6 @@ PHY_SetTxPowerLevel8188E(
 
 	getTxPowerIndex88E(Adapter, channel, &cckPowerLevel[0], &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0]);
 
-	phy_PowerIndexCheck88E(Adapter, channel, &cckPowerLevel[0], &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0]);
-
 	rtl8188e_PHY_RF6052SetCckTxPower(Adapter, &cckPowerLevel[0]);
 	rtl8188e_PHY_RF6052SetOFDMTxPower(Adapter, &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0], channel);
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index fd2ee1739f88..a24cdbfa83de 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -176,9 +176,6 @@ struct hal_data_8188e {
 	u8	PwrGroupHT20[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	u8	PwrGroupHT40[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 
-	/*  The current Tx Power Level */
-	u8	CurrentCckTxPwrIdx;
-
 	/*  Read/write are allow for following hardware information variables */
 	u8	pwrGroupCnt;
 	u32	MCSTxPowerLevelOriginalOffset[MAX_PG_GROUP][16];
-- 
2.30.2

