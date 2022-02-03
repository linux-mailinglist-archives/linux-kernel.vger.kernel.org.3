Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BFF4A8DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354718AbiBCUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354665AbiBCUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:32:38 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA42C0613E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:32:29 -0800 (PST)
Received: from dslb-188-096-149-005.188.096.pools.vodafone-ip.de ([188.96.149.5] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nFimJ-0004W7-KH; Thu, 03 Feb 2022 21:32:27 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/4] staging: r8188eu: remove dead code for tx power tracking
Date:   Thu,  3 Feb 2022 21:32:15 +0100
Message-Id: <20220203203217.252156-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203203217.252156-1-martin@kaiser.cx>
References: <20220203203217.252156-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The odm_TXPowerTrackingCallback_ThermalMeter_8188E contains code
for OFDM paths A and B. It seems that path B is not used, is2t is
always false. Remove resulting dead code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 52 +-------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index db87eaafb72f..8bdd02271203 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -102,12 +102,11 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	u8 ThermalValue = 0, delta, delta_LCK, delta_IQK, offset;
 	u8 ThermalValue_AVG_count = 0;
 	u32 ThermalValue_AVG = 0;
-	s32 ele_A = 0, ele_D, TempCCk, X, value32;
+	s32 ele_A = 0, ele_D, TempCCk, X;
 	s32 Y, ele_C = 0;
 	s8 OFDM_index[2], CCK_index = 0;
 	s8 OFDM_index_old[2] = {0, 0}, CCK_index_old = 0;
 	u32 i = 0, j = 0;
-	bool is2t = false;
 
 	u8 OFDM_min_index = 6, rf; /* OFDM BB Swing should be less than +3.0dB, which is required by Arthur */
 	s8 OFDM_index_mapping[2][index_mapping_NUM_88E] = {
@@ -139,10 +138,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 	ThermalValue = (u8)rtl8188e_PHY_QueryRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, 0xfc00); /* 0x42: RF Reg[15:10] 88E */
 
-	if (is2t)
-		rf = 2;
-	else
-		rf = 1;
+	rf = 1;
 
 	if (ThermalValue) {
 		/* Query OFDM path A default setting */
@@ -155,17 +151,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			}
 		}
 
-		/* Query OFDM path B default setting */
-		if (is2t) {
-			ele_D = rtl8188e_PHY_QueryBBReg(Adapter, rOFDM0_XBTxIQImbalance, bMaskDWord) & bMaskOFDM_D;
-			for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
-				if (ele_D == (OFDMSwingTable[i] & bMaskOFDM_D)) {
-					OFDM_index_old[1] = (u8)i;
-					break;
-				}
-			}
-		}
-
 		/* Query CCK default setting From 0xa24 */
 		TempCCk = dm_odm->RFCalibrateInfo.RegA24;
 
@@ -309,39 +294,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 					/*  2012/04/23 MH According to Luke's suggestion, we can not write BB digital */
 					/*  to increase TX power. Otherwise, EVM will be bad. */
 				}
-
-				if (is2t) {
-					ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000) >> 22;
-
-					/* new element A = element D x X */
-					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][4];
-					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][5];
-
-					if (X != 0) {
-						if ((X & 0x00000200) != 0)	/* consider minus */
-							X = X | 0xFFFFFC00;
-						ele_A = ((X * ele_D) >> 8) & 0x000003FF;
-
-						/* new element C = element D x Y */
-						if ((Y & 0x00000200) != 0)
-							Y = Y | 0xFFFFFC00;
-						ele_C = ((Y * ele_D) >> 8) & 0x00003FF;
-
-						/* wtite new elements A, C, D to regC88 and regC9C, element B is always 0 */
-						value32 = (ele_D << 22) | ((ele_C & 0x3F) << 16) | ele_A;
-						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_XBTxIQImbalance, bMaskDWord, value32);
-
-						value32 = (ele_C & 0x000003C0) >> 6;
-						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_XDTxAFE, bMaskH4Bits, value32);
-
-						value32 = ((X * ele_D) >> 7) & 0x01;
-						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_ECCAThreshold, BIT(28), value32);
-					} else {
-						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_XBTxIQImbalance, bMaskDWord, OFDMSwingTable[(u8)OFDM_index[1]]);
-						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_XDTxAFE, bMaskH4Bits, 0x00);
-						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_ECCAThreshold, BIT(28), 0x00);
-					}
-				}
 			}
 		}
 
-- 
2.30.2

