Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152CB4A95C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349600AbiBDJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbiBDJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:10:03 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9D5C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:10:02 -0800 (PST)
Received: from dslb-188-096-149-005.188.096.pools.vodafone-ip.de ([188.96.149.5] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nFubO-0002IT-Nh; Fri, 04 Feb 2022 10:09:58 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/4] staging: r8188eu: remove dead code for tx power tracking
Date:   Fri,  4 Feb 2022 10:09:39 +0100
Message-Id: <20220204090941.309900-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204090941.309900-1-martin@kaiser.cx>
References: <20220203203217.252156-1-martin@kaiser.cx>
 <20220204090941.309900-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The odm_TXPowerTrackingCallback_ThermalMeter_8188E contains code
for OFDM paths A and B. It seems that path B is not used, is2t is
always false. Remove resulting dead code.

Without the path B code, the ele_A and ele_C variables are set but
not used. They can be removed. With ele_A and ele_C gone, X and Y
are now set but no longer used. Remove them as well.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2: remove variables which are set but not used

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 72 +-------------------
 1 file changed, 2 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index db87eaafb72f..795320e13e55 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -102,12 +102,10 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	u8 ThermalValue = 0, delta, delta_LCK, delta_IQK, offset;
 	u8 ThermalValue_AVG_count = 0;
 	u32 ThermalValue_AVG = 0;
-	s32 ele_A = 0, ele_D, TempCCk, X, value32;
-	s32 Y, ele_C = 0;
+	s32 ele_D, TempCCk;
 	s8 OFDM_index[2], CCK_index = 0;
 	s8 OFDM_index_old[2] = {0, 0}, CCK_index_old = 0;
 	u32 i = 0, j = 0;
-	bool is2t = false;
 
 	u8 OFDM_min_index = 6, rf; /* OFDM BB Swing should be less than +3.0dB, which is required by Arthur */
 	s8 OFDM_index_mapping[2][index_mapping_NUM_88E] = {
@@ -139,10 +137,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 	ThermalValue = (u8)rtl8188e_PHY_QueryRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, 0xfc00); /* 0x42: RF Reg[15:10] 88E */
 
-	if (is2t)
-		rf = 2;
-	else
-		rf = 1;
+	rf = 1;
 
 	if (ThermalValue) {
 		/* Query OFDM path A default setting */
@@ -155,17 +150,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
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
 
@@ -277,11 +261,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			if (dm_odm->RFCalibrateInfo.TxPowerTrackControl) {
 				dm_odm->RFCalibrateInfo.bDoneTxpower = true;
 
-				/* Adujst OFDM Ant_A according to IQK result */
-				ele_D = (OFDMSwingTable[(u8)OFDM_index[0]] & 0xFFC00000) >> 22;
-				X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][0];
-				Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][1];
-
 				/*  Revse TX power table. */
 				dm_odm->BbSwingIdxOfdm		= (u8)OFDM_index[0];
 				dm_odm->BbSwingIdxCck		= (u8)CCK_index;
@@ -295,53 +274,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 					dm_odm->BbSwingIdxCckCurrent = dm_odm->BbSwingIdxCck;
 					dm_odm->BbSwingFlagCck = true;
 				}
-
-				if (X != 0) {
-					if ((X & 0x00000200) != 0)
-						X = X | 0xFFFFFC00;
-					ele_A = ((X * ele_D) >> 8) & 0x000003FF;
-
-					/* new element C = element D x Y */
-					if ((Y & 0x00000200) != 0)
-						Y = Y | 0xFFFFFC00;
-					ele_C = ((Y * ele_D) >> 8) & 0x000003FF;
-
-					/*  2012/04/23 MH According to Luke's suggestion, we can not write BB digital */
-					/*  to increase TX power. Otherwise, EVM will be bad. */
-				}
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

