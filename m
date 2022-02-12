Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B84B365D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbiBLQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:18:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiBLQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:18:07 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609BB240A6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:17:57 -0800 (PST)
Received: from dslb-188-097-215-215.188.097.pools.vodafone-ip.de ([188.97.215.215] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nIv5t-0007YM-7U; Sat, 12 Feb 2022 17:17:53 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/10] staging: r8188eu: we only need one struct bb_reg_def for path a
Date:   Sat, 12 Feb 2022 17:17:37 +0100
Message-Id: <20220212161737.381841-11-martin@kaiser.cx>
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

The r8188eu driver does no longer access rf path b registers via
PHYRegDef.

Change the PHYRegDef array in struct hal_data_8188e to a single
variable that holds the register addresses for rf path a. Remove
the initialisation of path b register addresses.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 58 +++++++------------
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  2 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 +-
 3 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index e2e4443b7414..b0e5b9f6a005 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -123,7 +123,7 @@ phy_RFSerialRead(
 {
 	u32 retValue = 0;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[RF_PATH_A];
+	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef;
 	u32 NewOffset;
 	u32 tmplong, tmplong2;
 	u8 	RfPiEnable = 0;
@@ -215,7 +215,7 @@ phy_RFSerialWrite(
 {
 	u32 DataAndAddr = 0;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[RF_PATH_A];
+	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef;
 	u32 NewOffset;
 
 	/*  2009/06/17 MH We can not execute IO for power save or other accident mode. */
@@ -358,76 +358,58 @@ phy_InitBBRFRegisterDefinition(
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
 
 	/*  RF Interface Sowrtware Control */
-	pHalData->PHYRegDef[RF_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 LSBs if read 32-bit from 0x870 */
-	pHalData->PHYRegDef[RF_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 MSBs if read 32-bit from 0x870 (16-bit for 0x872) */
+	pHalData->PHYRegDef.rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 LSBs if read 32-bit from 0x870 */
 
 	/*  RF Interface Readback Value */
-	pHalData->PHYRegDef[RF_PATH_A].rfintfi = rFPGA0_XAB_RFInterfaceRB; /*  16 LSBs if read 32-bit from 0x8E0 */
-	pHalData->PHYRegDef[RF_PATH_B].rfintfi = rFPGA0_XAB_RFInterfaceRB;/*  16 MSBs if read 32-bit from 0x8E0 (16-bit for 0x8E2) */
+	pHalData->PHYRegDef.rfintfi = rFPGA0_XAB_RFInterfaceRB; /*  16 LSBs if read 32-bit from 0x8E0 */
 
 	/*  RF Interface Output (and Enable) */
-	pHalData->PHYRegDef[RF_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x860 */
-	pHalData->PHYRegDef[RF_PATH_B].rfintfo = rFPGA0_XB_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x864 */
+	pHalData->PHYRegDef.rfintfo = rFPGA0_XA_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x860 */
 
 	/*  RF Interface (Output and)  Enable */
-	pHalData->PHYRegDef[RF_PATH_A].rfintfe = rFPGA0_XA_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
-	pHalData->PHYRegDef[RF_PATH_B].rfintfe = rFPGA0_XB_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x864 (16-bit for 0x866) */
+	pHalData->PHYRegDef.rfintfe = rFPGA0_XA_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
 
 	/* Addr of LSSI. Wirte RF register by driver */
-	pHalData->PHYRegDef[RF_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter; /* LSSI Parameter */
-	pHalData->PHYRegDef[RF_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
+	pHalData->PHYRegDef.rf3wireOffset = rFPGA0_XA_LSSIParameter; /* LSSI Parameter */
 
 	/*  RF parameter */
-	pHalData->PHYRegDef[RF_PATH_A].rfLSSI_Select = rFPGA0_XAB_RFParameter;  /* BB Band Select */
-	pHalData->PHYRegDef[RF_PATH_B].rfLSSI_Select = rFPGA0_XAB_RFParameter;
+	pHalData->PHYRegDef.rfLSSI_Select = rFPGA0_XAB_RFParameter;  /* BB Band Select */
 
 	/*  Tx AGC Gain Stage (same for all path. Should we remove this?) */
-	pHalData->PHYRegDef[RF_PATH_A].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
-	pHalData->PHYRegDef[RF_PATH_B].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
+	pHalData->PHYRegDef.rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
 
 	/*  Tranceiver A~D HSSI Parameter-1 */
-	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;  /* wire control parameter1 */
-	pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara1 = rFPGA0_XB_HSSIParameter1;  /* wire control parameter1 */
+	pHalData->PHYRegDef.rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;  /* wire control parameter1 */
 
 	/*  Tranceiver A~D HSSI Parameter-2 */
-	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
-	pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;  /* wire control parameter2 */
+	pHalData->PHYRegDef.rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
 
 	/*  RF switch Control */
-	pHalData->PHYRegDef[RF_PATH_A].rfSwitchControl = rFPGA0_XAB_SwitchControl; /* TR/Ant switch control */
-	pHalData->PHYRegDef[RF_PATH_B].rfSwitchControl = rFPGA0_XAB_SwitchControl;
+	pHalData->PHYRegDef.rfSwitchControl = rFPGA0_XAB_SwitchControl; /* TR/Ant switch control */
 
 	/*  AGC control 1 */
-	pHalData->PHYRegDef[RF_PATH_A].rfAGCControl1 = rOFDM0_XAAGCCore1;
-	pHalData->PHYRegDef[RF_PATH_B].rfAGCControl1 = rOFDM0_XBAGCCore1;
+	pHalData->PHYRegDef.rfAGCControl1 = rOFDM0_XAAGCCore1;
 
 	/*  AGC control 2 */
-	pHalData->PHYRegDef[RF_PATH_A].rfAGCControl2 = rOFDM0_XAAGCCore2;
-	pHalData->PHYRegDef[RF_PATH_B].rfAGCControl2 = rOFDM0_XBAGCCore2;
+	pHalData->PHYRegDef.rfAGCControl2 = rOFDM0_XAAGCCore2;
 
 	/*  RX AFE control 1 */
-	pHalData->PHYRegDef[RF_PATH_A].rfRxIQImbalance = rOFDM0_XARxIQImbalance;
-	pHalData->PHYRegDef[RF_PATH_B].rfRxIQImbalance = rOFDM0_XBRxIQImbalance;
+	pHalData->PHYRegDef.rfRxIQImbalance = rOFDM0_XARxIQImbalance;
 
 	/*  RX AFE control 1 */
-	pHalData->PHYRegDef[RF_PATH_A].rfRxAFE = rOFDM0_XARxAFE;
-	pHalData->PHYRegDef[RF_PATH_B].rfRxAFE = rOFDM0_XBRxAFE;
+	pHalData->PHYRegDef.rfRxAFE = rOFDM0_XARxAFE;
 
 	/*  Tx AFE control 1 */
-	pHalData->PHYRegDef[RF_PATH_A].rfTxIQImbalance = rOFDM0_XATxIQImbalance;
-	pHalData->PHYRegDef[RF_PATH_B].rfTxIQImbalance = rOFDM0_XBTxIQImbalance;
+	pHalData->PHYRegDef.rfTxIQImbalance = rOFDM0_XATxIQImbalance;
 
 	/*  Tx AFE control 2 */
-	pHalData->PHYRegDef[RF_PATH_A].rfTxAFE = rOFDM0_XATxAFE;
-	pHalData->PHYRegDef[RF_PATH_B].rfTxAFE = rOFDM0_XBTxAFE;
+	pHalData->PHYRegDef.rfTxAFE = rOFDM0_XATxAFE;
 
 	/*  Tranceiver LSSI Readback SI mode */
-	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
-	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
+	pHalData->PHYRegDef.rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
 
 	/*  Tranceiver LSSI Readback PI mode */
-	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
-	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBackPi = TransceiverB_HSPI_Readback;
+	pHalData->PHYRegDef.rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
 }
 
 void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 4a7a877e4017..d043b7bc4142 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -375,7 +375,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 
 	/* Initialize RF */
 
-	pPhyReg = &pHalData->PHYRegDef[0];
+	pPhyReg = &pHalData->PHYRegDef;
 
 	/*----Store original RFENV control type----*/
 	u4RegValue = rtl8188e_PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5b27bae97e91..44321a53a345 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -141,7 +141,7 @@ struct hal_data_8188e {
 
 	u32	AcParam_BE; /* Original parameter for BE, use for EDCA turbo. */
 
-	struct bb_reg_def PHYRegDef[2];	/* Radio A/B */
+	struct bb_reg_def PHYRegDef;
 
 	u32	RfRegChnlVal;
 
-- 
2.30.2

