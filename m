Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF14AB09B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbiBFQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiBFQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:18:24 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E9BC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:18:21 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGkEz-0001bS-U3; Sun, 06 Feb 2022 17:18:17 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/14] staging: r8188eu: only OFDM_index_old[0] is used
Date:   Sun,  6 Feb 2022 17:17:56 +0100
Message-Id: <20220206161809.423031-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206161809.423031-1-martin@kaiser.cx>
References: <20220206161809.423031-1-martin@kaiser.cx>
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

The odm_TXPowerTrackingCallback_ThermalMeter_8188E function uses only
OFDM_index_old[0]. Use a single variable instead of an array.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 5df8371a44fb..08db24614ed1 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -104,7 +104,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	u32 ThermalValue_AVG = 0;
 	s32 ele_D, TempCCk;
 	s8 OFDM_index[2], CCK_index = 0;
-	s8 OFDM_index_old[2] = {0, 0}, CCK_index_old = 0;
+	s8 OFDM_index_old = 0, CCK_index_old = 0;
 	u32 i = 0, j = 0;
 
 	u8 OFDM_min_index = 6; /* OFDM BB Swing should be less than +3.0dB, which is required by Arthur */
@@ -139,7 +139,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 		ele_D = rtl8188e_PHY_QueryBBReg(Adapter, rOFDM0_XATxIQImbalance, bMaskDWord) & bMaskOFDM_D;
 		for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
 			if (ele_D == (OFDMSwingTable[i] & bMaskOFDM_D)) {
-				OFDM_index_old[0] = (u8)i;
+				OFDM_index_old = (u8)i;
 				dm_odm->BbSwingIdxOfdmBase = (u8)i;
 				break;
 			}
@@ -169,7 +169,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			dm_odm->RFCalibrateInfo.ThermalValue_LCK = ThermalValue;
 			dm_odm->RFCalibrateInfo.ThermalValue_IQK = ThermalValue;
 
-			dm_odm->RFCalibrateInfo.OFDM_index[0] = OFDM_index_old[0];
+			dm_odm->RFCalibrateInfo.OFDM_index[0] = OFDM_index_old;
 			dm_odm->RFCalibrateInfo.CCK_index = CCK_index_old;
 		}
 
-- 
2.30.2

