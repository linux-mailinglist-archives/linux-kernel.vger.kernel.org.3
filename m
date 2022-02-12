Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D34B365C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiBLQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:18:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiBLQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:17:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1AF240A6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:17:56 -0800 (PST)
Received: from dslb-188-097-215-215.188.097.pools.vodafone-ip.de ([188.97.215.215] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nIv5s-0007YM-7b; Sat, 12 Feb 2022 17:17:52 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/10] staging: r8188eu: remove path parameter from phy_RFSerialRead
Date:   Sat, 12 Feb 2022 17:17:36 +0100
Message-Id: <20220212161737.381841-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220212161737.381841-1-martin@kaiser.cx>
References: <20220212161737.381841-1-martin@kaiser.cx>
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

All callers of phy_RFSerialRead set the eRFPath parameter to
RF_PATH_A. Remove the parameter and use RF_PATH_A directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 2dcd1df58aaa..e2e4443b7414 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -104,7 +104,6 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u3
 *
 * Input:
 *			struct adapter *Adapter,
-*			enum rf_radio_path eRFPath,	Radio path of A/B/C/D
 *			u32			Offset,		The target address to be read
 *
 * Output:	None
@@ -119,13 +118,12 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u3
 static	u32
 phy_RFSerialRead(
 		struct adapter *Adapter,
-		enum rf_radio_path eRFPath,
 		u32 Offset
 	)
 {
 	u32 retValue = 0;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[eRFPath];
+	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[RF_PATH_A];
 	u32 NewOffset;
 	u32 tmplong, tmplong2;
 	u8 	RfPiEnable = 0;
@@ -143,10 +141,7 @@ phy_RFSerialRead(
 	/*  For RF A/B write 0x824/82c(does not work in the future) */
 	/*  We must use 0x824 for RF A and B to execute read trigger */
 	tmplong = rtl8188e_PHY_QueryBBReg(Adapter, rFPGA0_XA_HSSIParameter2, bMaskDWord);
-	if (eRFPath == RF_PATH_A)
-		tmplong2 = tmplong;
-	else
-		tmplong2 = rtl8188e_PHY_QueryBBReg(Adapter, pPhyReg->rfHSSIPara2, bMaskDWord);
+	tmplong2 = tmplong;
 
 	tmplong2 = (tmplong2 & (~bLSSIReadAddress)) | (NewOffset << 23) | bLSSIReadEdge;	/* T65 RF */
 
@@ -158,10 +153,7 @@ phy_RFSerialRead(
 
 	udelay(10);/* PlatformStallExecution(10); */
 
-	if (eRFPath == RF_PATH_A)
-		RfPiEnable = (u8)rtl8188e_PHY_QueryBBReg(Adapter, rFPGA0_XA_HSSIParameter1, BIT(8));
-	else if (eRFPath == RF_PATH_B)
-		RfPiEnable = (u8)rtl8188e_PHY_QueryBBReg(Adapter, rFPGA0_XB_HSSIParameter1, BIT(8));
+	RfPiEnable = (u8)rtl8188e_PHY_QueryBBReg(Adapter, rFPGA0_XA_HSSIParameter1, BIT(8));
 
 	if (RfPiEnable) {	/*  Read from BBreg8b8, 12 bits for 8190, 20bits for T65 RF */
 		retValue = rtl8188e_PHY_QueryBBReg(Adapter, pPhyReg->rfLSSIReadBackPi, bLSSIReadBackData);
@@ -265,7 +257,7 @@ u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 {
 	u32 Original_Value, Readback_Value, BitShift;
 
-	Original_Value = phy_RFSerialRead(Adapter, RF_PATH_A, RegAddr);
+	Original_Value = phy_RFSerialRead(Adapter, RegAddr);
 
 	BitShift =  phy_CalculateBitShift(BitMask);
 	Readback_Value = (Original_Value & BitMask) >> BitShift;
@@ -301,7 +293,7 @@ rtl8188e_PHY_SetRFReg(
 
 	/*  RF data is 12 bits only */
 	if (BitMask != bRFRegOffsetMask) {
-		Original_Value = phy_RFSerialRead(Adapter, RF_PATH_A, RegAddr);
+		Original_Value = phy_RFSerialRead(Adapter, RegAddr);
 		BitShift =  phy_CalculateBitShift(BitMask);
 		Data = ((Original_Value & (~BitMask)) | (Data << BitShift));
 	}
-- 
2.30.2

