Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10834A8DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354960AbiBCUeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354669AbiBCUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:32:38 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA94C0613E7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:32:28 -0800 (PST)
Received: from dslb-188-096-149-005.188.096.pools.vodafone-ip.de ([188.96.149.5] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nFimI-0004W7-Jm; Thu, 03 Feb 2022 21:32:26 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: r8188eu: remove constant parameter of phy_LCCalibrate_8188E
Date:   Thu,  3 Feb 2022 21:32:14 +0100
Message-Id: <20220203203217.252156-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203203217.252156-1-martin@kaiser.cx>
References: <20220203203217.252156-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of phy_LCCalibrate_8188E sets is2t to false.
Remove this parameter and resulting dead code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 5f7a2668cabb..db87eaafb72f 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -821,10 +821,10 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 	}
 }
 
-static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
+static void phy_LCCalibrate_8188E(struct adapter *adapt)
 {
 	u8 tmpreg;
-	u32 RF_Amode = 0, RF_Bmode = 0, LC_Cal;
+	u32 RF_Amode = 0, LC_Cal;
 
 	/* Check continuous TX and Packet TX */
 	tmpreg = rtw_read8(adapt, 0xd03);
@@ -839,17 +839,9 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 		/* Path-A */
 		RF_Amode = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits);
 
-		/* Path-B */
-		if (is2t)
-			RF_Bmode = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_B, RF_AC, bMask12Bits);
-
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
 		rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode & 0x8FFFF) | 0x10000);
-
-		/* Path-B */
-		if (is2t)
-			rtl8188e_PHY_SetRFReg(adapt, RF_PATH_B, RF_AC, bMask12Bits, (RF_Bmode & 0x8FFFF) | 0x10000);
 	}
 
 	/* 3. Read RF reg18 */
@@ -866,10 +858,6 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 		/* Path-A */
 		rtw_write8(adapt, 0xd03, tmpreg);
 		rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits, RF_Amode);
-
-		/* Path-B */
-		if (is2t)
-			rtl8188e_PHY_SetRFReg(adapt, RF_PATH_B, RF_AC, bMask12Bits, RF_Bmode);
 	} else {
 		/*  Deal with Packet TX case */
 		rtw_write8(adapt, REG_TXPAUSE, 0x00);
@@ -999,5 +987,5 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 		timecount += 50;
 	}
 
-	phy_LCCalibrate_8188E(adapt, false);
+	phy_LCCalibrate_8188E(adapt);
 }
-- 
2.30.2

