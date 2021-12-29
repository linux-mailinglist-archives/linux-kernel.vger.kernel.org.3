Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE184816C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhL2Uvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhL2Uvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59686C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k18so9843388wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ojJ4j4//AO5Rz4sVjfDfB1jNJW9hmVXlfKBbtGGo1LM=;
        b=fU43jDiBTm7L3q9lV8Hivc+5mTbM1lVRyiX3glNLwFkA23yx/dj3ojD5sgyz792fqe
         okfZuBFNK2K7srdu3WHeGZXbMgfR9M4HwQXQ/xvcCBnK91FOpMLKh2ahT74nH21sAhAQ
         NaVrS/6xtP9RbaKR/tfbfOQgf4i1rtB7nn1PMWtdHDdvtdseea0O1XRR2ZtDMEalXaWw
         lJte50sI4vtHx1mpk9PIU1Fh4bn8ltMR2NIUBP3vkJ+NZJQOoQE+gd+2rV+HT5o5MV1S
         cgUSVDyog61qSHVV8dpSP+XFYodH2VK+ta0DEuxvAFYLt71Z1sH4O9q6ufoL7w3M0ua5
         kV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ojJ4j4//AO5Rz4sVjfDfB1jNJW9hmVXlfKBbtGGo1LM=;
        b=aFgh7Ejp4CPLsuDdnAEsyGiYIXRd6IML874Ules1gWg7Aey3L4XSVXhz+d+E2DmWLl
         jRKdYfN29gDsYA324l9J2nQLbmEQYCBmNLd2Bt00L3F0BNrW6lRGWBUpVuFegaPDZRc0
         dvMcRGx92C2Cj1nrJD8v9NOOhGfQVwlY7erh7xI8gu3AmoL80XnIJNgciEwn3V/6Wbb4
         FNcZJHVjUFAkqYNbmcAaLmdV9X0esBNQOc1wtKc3HKa133flqPX/a+kQ3myJaUEI4IWx
         paa03yXhPPF23qCEwZz3JJFTfwwyBs8ynnD7Wm4u7GaUG1X/ctwebCvqjBelH/wbzng0
         Iaew==
X-Gm-Message-State: AOAM5339JPJxuKTtt0vCjYykvtKnRo4Y7FhdNnniCMCNY1FsasPy79nZ
        75Rl3zk6SiF17jNJH+01Gfg=
X-Google-Smtp-Source: ABdhPJxP3tbKbtoinxyHyhfQi4uiSZZjzpwc7yWWyZv4Y0ssytyNN3DfkbKYAePOX+wUZwvTru6SfQ==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr22409981wrd.81.1640811090712;
        Wed, 29 Dec 2021 12:51:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:30 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/32] staging: r8188eu: remove ODM_SetBBReg()
Date:   Wed, 29 Dec 2021 21:50:42 +0100
Message-Id: <20211229205108.26373-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_SetBBReg() is just a wrapper around rtl8188e_PHY_SetBBReg().
Remove ODM_SetBBReg() and call rtl8188e_PHY_SetBBReg() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 142 ++++++++----------
 drivers/staging/r8188eu/hal/odm.c             |  35 ++---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  90 +++++------
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |   4 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |   6 -
 .../staging/r8188eu/include/odm_interface.h   |   3 -
 6 files changed, 131 insertions(+), 149 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 5f28ed3b9231..24e653eb5321 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -329,17 +329,17 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 						/* wtite new elements A, C, D to regC88 and regC9C, element B is always 0 */
 						value32 = (ele_D << 22) | ((ele_C & 0x3F) << 16) | ele_A;
-						ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord, value32);
+						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_XBTxIQImbalance, bMaskDWord, value32);
 
 						value32 = (ele_C & 0x000003C0) >> 6;
-						ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, bMaskH4Bits, value32);
+						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_XDTxAFE, bMaskH4Bits, value32);
 
 						value32 = ((X * ele_D) >> 7) & 0x01;
-						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(28), value32);
+						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_ECCAThreshold, BIT(28), value32);
 					} else {
-						ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord, OFDMSwingTable[(u8)OFDM_index[1]]);
-						ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, bMaskH4Bits, 0x00);
-						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(28), 0x00);
+						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_XBTxIQImbalance, bMaskDWord, OFDMSwingTable[(u8)OFDM_index[1]]);
+						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_XDTxAFE, bMaskH4Bits, 0x00);
+						rtl8188e_PHY_SetBBReg(Adapter, rOFDM0_ECCAThreshold, BIT(28), 0x00);
 					}
 				}
 			}
@@ -365,22 +365,20 @@ phy_PathA_IQK_8188E(struct adapter *adapt)
 {
 	u32 regeac, regE94, regE9C;
 	u8 result = 0x00;
-	struct hal_data_8188e *pHalData = &adapt->haldata;
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	/* 1 Tx IQK */
 	/* path-A IQK setting */
-	ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x10008c1c);
-	ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x30008c1c);
-	ODM_SetBBReg(dm_odm, rTx_IQK_PI_A, bMaskDWord, 0x8214032a);
-	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160000);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK_Tone_A, bMaskDWord, 0x10008c1c);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK_Tone_A, bMaskDWord, 0x30008c1c);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK_PI_A, bMaskDWord, 0x8214032a);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK_PI_A, bMaskDWord, 0x28160000);
 
 	/* LO calibration setting */
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x00462911);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Rsp, bMaskDWord, 0x00462911);
 
 	/* One shot, path A LOK & IQK */
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
@@ -403,12 +401,10 @@ phy_PathA_RxIQK(struct adapter *adapt)
 {
 	u32 regeac, regE94, regE9C, regEA4, u4tmp;
 	u8 result = 0x00;
-	struct hal_data_8188e *pHalData = &adapt->haldata;
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	/* 1 Get TXIMR setting */
 	/* modify RXIQK mode table */
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x00000000);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
@@ -418,24 +414,24 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x980);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0x56, bRFRegOffsetMask, 0x51000);
 
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x80800000);
 
 	/* IQK setting */
-	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, 0x01007c00);
-	ODM_SetBBReg(dm_odm, rRx_IQK, bMaskDWord, 0x81004800);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK, bMaskDWord, 0x01007c00);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK, bMaskDWord, 0x81004800);
 
 	/* path-A IQK setting */
-	ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x10008c1c);
-	ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x30008c1c);
-	ODM_SetBBReg(dm_odm, rTx_IQK_PI_A, bMaskDWord, 0x82160c1f);
-	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160000);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK_Tone_A, bMaskDWord, 0x10008c1c);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK_Tone_A, bMaskDWord, 0x30008c1c);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK_PI_A, bMaskDWord, 0x82160c1f);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK_PI_A, bMaskDWord, 0x28160000);
 
 	/* LO calibration setting */
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
 
 	/* One shot, path A LOK & IQK */
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
 	ODM_delay_ms(IQK_DELAY_TIME_88E);
@@ -453,32 +449,32 @@ phy_PathA_RxIQK(struct adapter *adapt)
 		return result;
 
 	u4tmp = 0x80007C00 | (regE94 & 0x3FF0000)  | ((regE9C & 0x3FF0000) >> 16);
-	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, u4tmp);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK, bMaskDWord, u4tmp);
 
 	/* 1 RX IQK */
 	/* modify RXIQK mode table */
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x00000000);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7ffa);
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x80800000);
 
 	/* IQK setting */
-	ODM_SetBBReg(dm_odm, rRx_IQK, bMaskDWord, 0x01004800);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK, bMaskDWord, 0x01004800);
 
 	/* path-A IQK setting */
-	ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x38008c1c);
-	ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x18008c1c);
-	ODM_SetBBReg(dm_odm, rTx_IQK_PI_A, bMaskDWord, 0x82160c05);
-	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160c1f);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK_Tone_A, bMaskDWord, 0x38008c1c);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK_Tone_A, bMaskDWord, 0x18008c1c);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK_PI_A, bMaskDWord, 0x82160c05);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK_PI_A, bMaskDWord, 0x28160c1f);
 
 	/* LO calibration setting */
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
 
 	/* One shot, path A LOK & IQK */
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
-	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
+	rtl8188e_PHY_SetBBReg(adapt, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
 
 	/*  delay x ms */
 	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
@@ -491,7 +487,7 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	regEA4 = rtl8188e_PHY_QueryBBReg(adapt, rRx_Power_Before_IQK_A_2, bMaskDWord);
 
 	/* reload RF 0xdf */
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x00000000);
 	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x180);
 
 	if (!(regeac & BIT(27)) &&		/* if Tx is OK, check whether Rx is OK */
@@ -506,8 +502,6 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 {
 	u32 Oldval_0, X, TX0_A, reg;
 	s32 Y, TX0_C;
-	struct hal_data_8188e *pHalData = &adapt->haldata;
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	if (final_candidate == 0xFF) {
 		return;
@@ -518,31 +512,31 @@ static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 		if ((X & 0x00000200) != 0)
 			X = X | 0xFFFFFC00;
 		TX0_A = (X * Oldval_0) >> 8;
-		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x3FF, TX0_A);
+		rtl8188e_PHY_SetBBReg(adapt, rOFDM0_XATxIQImbalance, 0x3FF, TX0_A);
 
-		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(31), ((X * Oldval_0 >> 7) & 0x1));
+		rtl8188e_PHY_SetBBReg(adapt, rOFDM0_ECCAThreshold, BIT(31), ((X * Oldval_0 >> 7) & 0x1));
 
 		Y = result[final_candidate][1];
 		if ((Y & 0x00000200) != 0)
 			Y = Y | 0xFFFFFC00;
 
 		TX0_C = (Y * Oldval_0) >> 8;
-		ODM_SetBBReg(dm_odm, rOFDM0_XCTxAFE, 0xF0000000, ((TX0_C & 0x3C0) >> 6));
-		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x003F0000, (TX0_C & 0x3F));
+		rtl8188e_PHY_SetBBReg(adapt, rOFDM0_XCTxAFE, 0xF0000000, ((TX0_C & 0x3C0) >> 6));
+		rtl8188e_PHY_SetBBReg(adapt, rOFDM0_XATxIQImbalance, 0x003F0000, (TX0_C & 0x3F));
 
-		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(29), ((Y * Oldval_0 >> 7) & 0x1));
+		rtl8188e_PHY_SetBBReg(adapt, rOFDM0_ECCAThreshold, BIT(29), ((Y * Oldval_0 >> 7) & 0x1));
 
 		if (txonly)
 			return;
 
 		reg = result[final_candidate][2];
-		ODM_SetBBReg(dm_odm, rOFDM0_XARxIQImbalance, 0x3FF, reg);
+		rtl8188e_PHY_SetBBReg(adapt, rOFDM0_XARxIQImbalance, 0x3FF, reg);
 
 		reg = result[final_candidate][3] & 0x3F;
-		ODM_SetBBReg(dm_odm, rOFDM0_XARxIQImbalance, 0xFC00, reg);
+		rtl8188e_PHY_SetBBReg(adapt, rOFDM0_XARxIQImbalance, 0xFC00, reg);
 
 		reg = (result[final_candidate][3] >> 6) & 0xF;
-		ODM_SetBBReg(dm_odm, rOFDM0_RxIQExtAnta, 0xF0000000, reg);
+		rtl8188e_PHY_SetBBReg(adapt, rOFDM0_RxIQExtAnta, 0xF0000000, reg);
 	}
 }
 
@@ -572,11 +566,9 @@ static void _PHY_SaveMACRegisters(
 static void reload_adda_reg(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegiesterNum)
 {
 	u32 i;
-	struct hal_data_8188e *pHalData = &adapt->haldata;
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	for (i = 0; i < RegiesterNum; i++)
-		ODM_SetBBReg(dm_odm, ADDAReg[i], bMaskDWord, ADDABackup[i]);
+		rtl8188e_PHY_SetBBReg(adapt, ADDAReg[i], bMaskDWord, ADDABackup[i]);
 }
 
 static void
@@ -600,13 +592,11 @@ _PHY_PathADDAOn(
 		u32 *ADDAReg)
 {
 	u32 i;
-	struct hal_data_8188e *pHalData = &adapt->haldata;
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	ODM_SetBBReg(dm_odm, ADDAReg[0], bMaskDWord, 0x0b1b25a0);
+	rtl8188e_PHY_SetBBReg(adapt, ADDAReg[0], bMaskDWord, 0x0b1b25a0);
 
 	for (i = 1; i < IQK_ADDA_REG_NUM; i++)
-		ODM_SetBBReg(dm_odm, ADDAReg[i], bMaskDWord, 0x0bdb25a0);
+		rtl8188e_PHY_SetBBReg(adapt, ADDAReg[i], bMaskDWord, 0x0bdb25a0);
 }
 
 void
@@ -632,12 +622,10 @@ static void _PHY_PIModeSwitch(
 	)
 {
 	u32 mode;
-	struct hal_data_8188e *pHalData = &adapt->haldata;
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	mode = PIMode ? 0x01000100 : 0x01000000;
-	ODM_SetBBReg(dm_odm, rFPGA0_XA_HSSIParameter1, bMaskDWord, mode);
-	ODM_SetBBReg(dm_odm, rFPGA0_XB_HSSIParameter1, bMaskDWord, mode);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_XA_HSSIParameter1, bMaskDWord, mode);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_XB_HSSIParameter1, bMaskDWord, mode);
 }
 
 static bool phy_SimularityCompare_8188E(
@@ -766,28 +754,28 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 	}
 
 	/* BB setting */
-	ODM_SetBBReg(dm_odm, rFPGA0_RFMOD, BIT(24), 0x00);
-	ODM_SetBBReg(dm_odm, rOFDM0_TRxPathEnable, bMaskDWord, 0x03a05600);
-	ODM_SetBBReg(dm_odm, rOFDM0_TRMuxPar, bMaskDWord, 0x000800e4);
-	ODM_SetBBReg(dm_odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord, 0x22204000);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_RFMOD, BIT(24), 0x00);
+	rtl8188e_PHY_SetBBReg(adapt, rOFDM0_TRxPathEnable, bMaskDWord, 0x03a05600);
+	rtl8188e_PHY_SetBBReg(adapt, rOFDM0_TRMuxPar, bMaskDWord, 0x000800e4);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_XCD_RFInterfaceSW, bMaskDWord, 0x22204000);
 
-	ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFInterfaceSW, BIT(10), 0x01);
-	ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFInterfaceSW, BIT(26), 0x01);
-	ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT(10), 0x00);
-	ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT(10), 0x00);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_XAB_RFInterfaceSW, BIT(10), 0x01);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_XAB_RFInterfaceSW, BIT(26), 0x01);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_XA_RFInterfaceOE, BIT(10), 0x00);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_XB_RFInterfaceOE, BIT(10), 0x00);
 
 	/* MAC settings */
 	_PHY_MACSettingCalibration(adapt, IQK_MAC_REG, dm_odm->RFCalibrateInfo.IQK_MAC_backup);
 
 	/* Page B init */
 	/* AP or IQK */
-	ODM_SetBBReg(dm_odm, rConfig_AntA, bMaskDWord, 0x0f600000);
+	rtl8188e_PHY_SetBBReg(adapt, rConfig_AntA, bMaskDWord, 0x0f600000);
 
 
 	/*  IQ calibration setting */
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
-	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, 0x01007c00);
-	ODM_SetBBReg(dm_odm, rRx_IQK, bMaskDWord, 0x81004800);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x80800000);
+	rtl8188e_PHY_SetBBReg(adapt, rTx_IQK, bMaskDWord, 0x01007c00);
+	rtl8188e_PHY_SetBBReg(adapt, rRx_IQK, bMaskDWord, 0x81004800);
 
 	for (i = 0; i < retryCount; i++) {
 		PathAOK = phy_PathA_IQK_8188E(adapt);
@@ -808,7 +796,7 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 	}
 
 	/* Back to BB mode, load original value */
-	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0);
+	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0);
 
 	if (t != 0) {
 		if (!dm_odm->RFCalibrateInfo.bRfPiEnable) {
@@ -825,11 +813,11 @@ static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t)
 		reload_adda_reg(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup, IQK_BB_REG_NUM);
 
 		/*  Restore RX initial gain */
-		ODM_SetBBReg(dm_odm, rFPGA0_XA_LSSIParameter, bMaskDWord, 0x00032ed3);
+		rtl8188e_PHY_SetBBReg(adapt, rFPGA0_XA_LSSIParameter, bMaskDWord, 0x00032ed3);
 
 		/* load 0xe30 IQC default value */
-		ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x01008c00);
-		ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x01008c00);
+		rtl8188e_PHY_SetBBReg(adapt, rTx_IQK_Tone_A, bMaskDWord, 0x01008c00);
+		rtl8188e_PHY_SetBBReg(adapt, rRx_IQK_Tone_A, bMaskDWord, 0x01008c00);
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 9329ba9057ac..c50f5219df36 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -302,9 +302,10 @@ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
 void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
+	struct adapter *adapter = pDM_Odm->Adapter;
 
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
-		ODM_SetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N, CurrentIGI);
+		rtl8188e_PHY_SetBBReg(adapter, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N, CurrentIGI);
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
 }
@@ -484,8 +485,8 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 		return;
 
 	/* hold ofdm counter */
-	ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 1); /* hold page C counter */
-	ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 1); /* hold page D counter */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 1); /* hold page C counter */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 1); /* hold page D counter */
 
 	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_OFDM_FA_TYPE1_11N, bMaskDWord);
 	FalseAlmCnt->Cnt_Fast_Fsync = (ret_value & 0xffff);
@@ -508,8 +509,8 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 	FalseAlmCnt->Cnt_BW_USC = ((ret_value & 0xffff0000) >> 16);
 
 	/* hold cck counter */
-	ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(12), 1);
-	ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(14), 1);
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_CCK_FA_RST_11N, BIT(12), 1);
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_CCK_FA_RST_11N, BIT(14), 1);
 
 	ret_value = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_CCK_FA_LSB_11N, bMaskByte0);
 	FalseAlmCnt->Cnt_Cck_fail = ret_value;
@@ -620,19 +621,19 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 
 	if (pDM_PSTable->pre_rf_state != pDM_PSTable->cur_rf_state) {
 		if (pDM_PSTable->cur_rf_state == RF_Save) {
-			ODM_SetBBReg(pDM_Odm, 0x874, 0x1C0000, 0x2); /* Reg874[20:18]=3'b010 */
-			ODM_SetBBReg(pDM_Odm, 0xc70, BIT(3), 0); /* RegC70[3]=1'b0 */
-			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, 0x63); /* Reg85C[31:24]=0x63 */
-			ODM_SetBBReg(pDM_Odm, 0x874, 0xC000, 0x2); /* Reg874[15:14]=2'b10 */
-			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, 0x3); /* RegA75[7:4]=0x3 */
-			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x0); /* Reg818[28]=1'b0 */
-			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x1); /* Reg818[28]=1'b1 */
+			rtl8188e_PHY_SetBBReg(adapter, 0x874, 0x1C0000, 0x2); /* Reg874[20:18]=3'b010 */
+			rtl8188e_PHY_SetBBReg(adapter, 0xc70, BIT(3), 0); /* RegC70[3]=1'b0 */
+			rtl8188e_PHY_SetBBReg(adapter, 0x85c, 0xFF000000, 0x63); /* Reg85C[31:24]=0x63 */
+			rtl8188e_PHY_SetBBReg(adapter, 0x874, 0xC000, 0x2); /* Reg874[15:14]=2'b10 */
+			rtl8188e_PHY_SetBBReg(adapter, 0xa74, 0xF000, 0x3); /* RegA75[7:4]=0x3 */
+			rtl8188e_PHY_SetBBReg(adapter, 0x818, BIT(28), 0x0); /* Reg818[28]=1'b0 */
+			rtl8188e_PHY_SetBBReg(adapter, 0x818, BIT(28), 0x1); /* Reg818[28]=1'b1 */
 		} else {
-			ODM_SetBBReg(pDM_Odm, 0x874, 0x1CC000, pDM_PSTable->reg_874);
-			ODM_SetBBReg(pDM_Odm, 0xc70, BIT(3), pDM_PSTable->reg_c70);
-			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, pDM_PSTable->reg_85c);
-			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, pDM_PSTable->reg_a74);
-			ODM_SetBBReg(pDM_Odm, 0x818, BIT(28), 0x0);
+			rtl8188e_PHY_SetBBReg(adapter, 0x874, 0x1CC000, pDM_PSTable->reg_874);
+			rtl8188e_PHY_SetBBReg(adapter, 0xc70, BIT(3), pDM_PSTable->reg_c70);
+			rtl8188e_PHY_SetBBReg(adapter, 0x85c, 0xFF000000, pDM_PSTable->reg_85c);
+			rtl8188e_PHY_SetBBReg(adapter, 0xa74, 0xF000, pDM_PSTable->reg_a74);
+			rtl8188e_PHY_SetBBReg(adapter, 0x818, BIT(28), 0x0);
 		}
 		pDM_PSTable->pre_rf_state = pDM_PSTable->cur_rf_state;
 	}
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 67d0009dcbc5..69babcd7bf87 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -12,17 +12,17 @@ static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 	value32 = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
 	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
-	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
-	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(22), 1);	/* Regb2c[22]=1'b0	disable CS/CG switch */
-	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_LNA_SWITCH_11N, BIT(22), 1);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
 	/* OFDM Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_ANTDIV_PARA1_11N, bMaskDWord, 0x000000a0);
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTDIV_PARA1_11N, bMaskDWord, 0x000000a0);
 	/* CCK Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_BB_PWR_SAV4_11N, BIT(7), 1); /* Fix CCK PHY status report issue */
-	ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT(4), 1); /* CCK complete HW AntDiv within 64 samples */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_BB_PWR_SAV4_11N, BIT(7), 1); /* Fix CCK PHY status report issue */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT(4), 1); /* CCK complete HW AntDiv within 64 samples */
 	ODM_UpdateRxIdleAnt_88E(dm_odm, MAIN_ANT);
-	ODM_SetBBReg(dm_odm, ODM_REG_ANT_MAPPING1_11N, 0xFFFF, 0x0201);	/* antenna mapping table */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANT_MAPPING1_11N, 0xFFFF, 0x0201);	/* antenna mapping table */
 }
 
 static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
@@ -34,25 +34,25 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 	value32 = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
 	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
-	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
-	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(22), 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
-	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RX_ANT_CTRL_11N, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_LNA_SWITCH_11N, BIT(22), 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_LNA_SWITCH_11N, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
 	/* OFDM Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_ANTDIV_PARA1_11N, bMaskDWord, 0x000000a0);
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTDIV_PARA1_11N, bMaskDWord, 0x000000a0);
 	/* CCK Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_BB_PWR_SAV4_11N, BIT(7), 1); /* Fix CCK PHY status report issue */
-	ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT(4), 1); /* CCK complete HW AntDiv within 64 samples */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_BB_PWR_SAV4_11N, BIT(7), 1); /* Fix CCK PHY status report issue */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT(4), 1); /* CCK complete HW AntDiv within 64 samples */
 	/* Tx Settings */
-	ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 0); /* Reg80c[21]=1'b0		from TX Reg */
+	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 0); /* Reg80c[21]=1'b0		from TX Reg */
 	ODM_UpdateRxIdleAnt_88E(dm_odm, MAIN_ANT);
 
 	/* antenna mapping table */
 	if (!dm_odm->bIsMPChip) { /* testchip */
-		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT(10) | BIT(9) | BIT(8), 1);	/* Reg858[10:8]=3'b001 */
-		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT(13) | BIT(12) | BIT(11), 2);	/* Reg858[13:11]=3'b010 */
+		rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RX_DEFUALT_A_11N, BIT(10) | BIT(9) | BIT(8), 1);	/* Reg858[10:8]=3'b001 */
+		rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RX_DEFUALT_A_11N, BIT(13) | BIT(12) | BIT(11), 2);	/* Reg858[13:11]=3'b010 */
 	} else { /* MPchip */
-		ODM_SetBBReg(dm_odm, ODM_REG_ANT_MAPPING1_11N, bMaskDWord, 0x0201);	/* Reg914=3'b010, Reg915=3'b001 */
+		rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANT_MAPPING1_11N, bMaskDWord, 0x0201);	/* Reg914=3'b010, Reg915=3'b001 */
 	}
 }
 
@@ -71,28 +71,28 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	rtl8188e_PHY_SetBBReg(adapter, 0x7b4, 0xFFFF, 0);
 	rtl8188e_PHY_SetBBReg(adapter, 0x7b0, bMaskDWord, 0);
 
-	ODM_SetBBReg(dm_odm, 0x870, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
-	ODM_SetBBReg(dm_odm, 0x864, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
-	ODM_SetBBReg(dm_odm, 0xb2c, BIT(22), 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
-	ODM_SetBBReg(dm_odm, 0xb2c, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
-	ODM_SetBBReg(dm_odm, 0xca4, bMaskDWord, 0x000000a0);
+	rtl8188e_PHY_SetBBReg(adapter, 0x870, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
+	rtl8188e_PHY_SetBBReg(adapter, 0x864, BIT(10), 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	rtl8188e_PHY_SetBBReg(adapter, 0xb2c, BIT(22), 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	rtl8188e_PHY_SetBBReg(adapter, 0xb2c, BIT(31), 1);	/* Regb2c[31]=1'b1	output at CG only */
+	rtl8188e_PHY_SetBBReg(adapter, 0xca4, bMaskDWord, 0x000000a0);
 
 	if (!dm_odm->bIsMPChip) { /* testchip */
-		ODM_SetBBReg(dm_odm, 0x858, BIT(10) | BIT(9) | BIT(8), 1);	/* Reg858[10:8]=3'b001 */
-		ODM_SetBBReg(dm_odm, 0x858, BIT(13) | BIT(12) | BIT(11), 2);	/* Reg858[13:11]=3'b010 */
+		rtl8188e_PHY_SetBBReg(adapter, 0x858, BIT(10) | BIT(9) | BIT(8), 1);	/* Reg858[10:8]=3'b001 */
+		rtl8188e_PHY_SetBBReg(adapter, 0x858, BIT(13) | BIT(12) | BIT(11), 2);	/* Reg858[13:11]=3'b010 */
 	} else { /* MPchip */
-		ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 1);
-		ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 2);
+		rtl8188e_PHY_SetBBReg(adapter, 0x914, bMaskByte0, 1);
+		rtl8188e_PHY_SetBBReg(adapter, 0x914, bMaskByte1, 2);
 	}
 
 	/* Default Ant Setting when no fast training */
-	ODM_SetBBReg(dm_odm, 0x80c, BIT(21), 1); /* Reg80c[21]=1'b1		from TX Info */
-	ODM_SetBBReg(dm_odm, 0x864, BIT(5) | BIT(4) | BIT(3), 0);	/* Default RX */
-	ODM_SetBBReg(dm_odm, 0x864, BIT(8) | BIT(7) | BIT(6), 1);	/* Optional RX */
+	rtl8188e_PHY_SetBBReg(adapter, 0x80c, BIT(21), 1); /* Reg80c[21]=1'b1		from TX Info */
+	rtl8188e_PHY_SetBBReg(adapter, 0x864, BIT(5) | BIT(4) | BIT(3), 0);	/* Default RX */
+	rtl8188e_PHY_SetBBReg(adapter, 0x864, BIT(8) | BIT(7) | BIT(6), 1);	/* Optional RX */
 
 	/* Enter Training state */
-	ODM_SetBBReg(dm_odm, 0x864, BIT(2) | BIT(1) | BIT(0), 1);
-	ODM_SetBBReg(dm_odm, 0xc50, BIT(7), 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
+	rtl8188e_PHY_SetBBReg(adapter, 0x864, BIT(2) | BIT(1) | BIT(0), 1);
+	rtl8188e_PHY_SetBBReg(adapter, 0xc50, BIT(7), 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
 }
 
 void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *dm_odm)
@@ -121,13 +121,13 @@ void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant)
 		}
 
 		if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), DefaultAnt);	/* Default RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8) | BIT(7) | BIT(6), OptionalAnt);		/* Optional RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_ANTSEL_CTRL_11N, BIT(14) | BIT(13) | BIT(12), DefaultAnt);	/* Default TX */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), DefaultAnt);	/* Default RX */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RX_ANT_CTRL_11N, BIT(8) | BIT(7) | BIT(6), OptionalAnt);		/* Optional RX */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTSEL_CTRL_11N, BIT(14) | BIT(13) | BIT(12), DefaultAnt);	/* Default TX */
 			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RESP_TX_11N, BIT(6) | BIT(7), DefaultAnt);	/* Resp Tx */
 		} else if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV) {
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), DefaultAnt);	/* Default RX */
-			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT(8) | BIT(7) | BIT(6), OptionalAnt);		/* Optional RX */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RX_ANT_CTRL_11N, BIT(5) | BIT(4) | BIT(3), DefaultAnt);	/* Default RX */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_RX_ANT_CTRL_11N, BIT(8) | BIT(7) | BIT(6), OptionalAnt);		/* Optional RX */
 		}
 	}
 	dm_fat_tbl->RxIdleAnt = Ant;
@@ -236,24 +236,26 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
 {
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+	struct adapter *adapter = dm_odm->Adapter;
+
 	if (!(dm_odm->SupportAbility & ODM_BB_ANT_DIV))
 		return;
 	if (!dm_odm->bLinked) {
 		if (dm_fat_tbl->bBecomeLinked) {
-			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT(7), 0);	/* RegC50[7]=1'b1		enable HW AntDiv */
-			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT(15), 0); /* Enable CCK AntDiv */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_IGI_A_11N, BIT(7), 0);	/* RegC50[7]=1'b1		enable HW AntDiv */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT(15), 0); /* Enable CCK AntDiv */
 			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
-				ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 0); /* Reg80c[21]=1'b0		from TX Reg */
+				rtl8188e_PHY_SetBBReg(adapter, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 0); /* Reg80c[21]=1'b0		from TX Reg */
 			dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
 		}
 		return;
 	} else {
 		if (!dm_fat_tbl->bBecomeLinked) {
 			/* Because HW AntDiv is disabled before Link, we enable HW AntDiv after link */
-			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT(7), 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
-			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT(15), 1); /* Enable CCK AntDiv */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_IGI_A_11N, BIT(7), 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
+			rtl8188e_PHY_SetBBReg(adapter, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT(15), 1); /* Enable CCK AntDiv */
 			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
-				ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 1); /* Reg80c[21]=1'b1		from TX Info */
+				rtl8188e_PHY_SetBBReg(adapter, ODM_REG_TX_ANT_CTRL_11N, BIT(21), 1); /* Reg80c[21]=1'b1		from TX Info */
 			dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index c5f424c89e36..b5b614686a65 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -41,7 +41,7 @@ void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data)
 
 void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
 {
-	ODM_SetBBReg(pDM_Odm, Addr, Bitmask, Data);
+	rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
 	/*  Add 1us delay between BB/RF register setting. */
 	ODM_delay_us(1);
 }
@@ -82,7 +82,7 @@ void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask
 	} else {
 		if (Addr == 0xa24)
 			pDM_Odm->RFCalibrateInfo.RegA24 = Data;
-		ODM_SetBBReg(pDM_Odm, Addr, Bitmask, Data);
+		rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
 
 		/*  Add 1us delay between BB/RF register setting. */
 		ODM_delay_us(1);
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 90c5f02660d2..f701d8520019 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -4,12 +4,6 @@
 #include "../include/odm_precomp.h"
 /*  ODM IO Relative API. */
 
-void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 Data)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	rtl8188e_PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
-}
-
 /*  ODM Memory relative API. */
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
 {
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index a013ef44f3c4..fa5b8220a8f3 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -12,9 +12,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 /*  =========== EXtern Function Prototype */
 
-void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
-		  u32 BitMask, u32 Data);
-
 /*  Memory Relative Function. */
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
-- 
2.34.1

