Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6895D4AA85F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 12:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357774AbiBELiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 06:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345131AbiBELh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 06:37:56 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C72C061347
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 03:37:55 -0800 (PST)
Received: from dslb-188-104-059-100.188.104.pools.vodafone-ip.de ([188.104.59.100] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGJO3-0005c9-Op; Sat, 05 Feb 2022 12:37:51 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/8] staging: r8188eu: remove constant rf variable
Date:   Sat,  5 Feb 2022 12:37:38 +0100
Message-Id: <20220205113741.379070-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220205113741.379070-1-martin@kaiser.cx>
References: <20220205113741.379070-1-martin@kaiser.cx>
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

The rf variable in odm_TXPowerTrackingCallback_ThermalMeter_8188E
is always 1. The for loops that use rf will be executed only once.

We can remove the variable and the loops.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index c26c87e5cb78..5df8371a44fb 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -107,7 +107,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	s8 OFDM_index_old[2] = {0, 0}, CCK_index_old = 0;
 	u32 i = 0, j = 0;
 
-	u8 OFDM_min_index = 6, rf; /* OFDM BB Swing should be less than +3.0dB, which is required by Arthur */
+	u8 OFDM_min_index = 6; /* OFDM BB Swing should be less than +3.0dB, which is required by Arthur */
 	s8 OFDM_index_mapping[2][index_mapping_NUM_88E] = {
 		{0, 0, 2, 3, 4, 4, 		/* 2.4G, decrease power */
 		5, 6, 7, 7, 8, 9,
@@ -134,8 +134,6 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 	ThermalValue = (u8)rtl8188e_PHY_QueryRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, 0xfc00); /* 0x42: RF Reg[15:10] 88E */
 
-	rf = 1;
-
 	if (ThermalValue) {
 		/* Query OFDM path A default setting */
 		ele_D = rtl8188e_PHY_QueryBBReg(Adapter, rOFDM0_XATxIQImbalance, bMaskDWord) & bMaskOFDM_D;
@@ -171,8 +169,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			dm_odm->RFCalibrateInfo.ThermalValue_LCK = ThermalValue;
 			dm_odm->RFCalibrateInfo.ThermalValue_IQK = ThermalValue;
 
-			for (i = 0; i < rf; i++)
-				dm_odm->RFCalibrateInfo.OFDM_index[i] = OFDM_index_old[i];
+			dm_odm->RFCalibrateInfo.OFDM_index[0] = OFDM_index_old[0];
 			dm_odm->RFCalibrateInfo.CCK_index = CCK_index_old;
 		}
 
@@ -237,16 +234,13 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			}
 			if (offset >= index_mapping_NUM_88E)
 				offset = index_mapping_NUM_88E - 1;
-			for (i = 0; i < rf; i++)
-				OFDM_index[i] = dm_odm->RFCalibrateInfo.OFDM_index[i] + OFDM_index_mapping[j][offset];
+			OFDM_index[0] = dm_odm->RFCalibrateInfo.OFDM_index[0] + OFDM_index_mapping[j][offset];
 			CCK_index = dm_odm->RFCalibrateInfo.CCK_index + OFDM_index_mapping[j][offset];
 
-			for (i = 0; i < rf; i++) {
-				if (OFDM_index[i] > OFDM_TABLE_SIZE_92D - 1)
-					OFDM_index[i] = OFDM_TABLE_SIZE_92D - 1;
-				else if (OFDM_index[i] < OFDM_min_index)
-					OFDM_index[i] = OFDM_min_index;
-			}
+			if (OFDM_index[0] > OFDM_TABLE_SIZE_92D - 1)
+				OFDM_index[0] = OFDM_TABLE_SIZE_92D - 1;
+			else if (OFDM_index[0] < OFDM_min_index)
+				OFDM_index[0] = OFDM_min_index;
 
 			if (CCK_index > CCK_TABLE_SIZE - 1)
 				CCK_index = CCK_TABLE_SIZE - 1;
-- 
2.30.2

