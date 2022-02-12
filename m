Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623754B3653
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiBLQSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:18:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiBLQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:17:55 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121E0181
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:17:51 -0800 (PST)
Received: from dslb-188-097-215-215.188.097.pools.vodafone-ip.de ([188.97.215.215] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nIv5n-0007YM-9t; Sat, 12 Feb 2022 17:17:47 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/10] staging: r8188eu: remove path parameter from rtl8188e_PHY_SetRFReg
Date:   Sat, 12 Feb 2022 17:17:30 +0100
Message-Id: <20220212161737.381841-4-martin@kaiser.cx>
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

All callers of rtl8188e_PHY_SetRFReg set the eRFPath parameter
to RF_PATH_A. Remove the parameter and use RF_PATH_A directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 28 +++++++++----------
 drivers/staging/r8188eu/hal/odm.c             |  2 +-
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  8 ++----
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  4 +--
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  3 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  4 +--
 7 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 8edae488d998..c7aed5ed5fa5 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -327,14 +327,14 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	/* 1 Get TXIMR setting */
 	/* modify RXIQK mode table */
 	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x00000000);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf117B);
+	rtl8188e_PHY_SetRFReg(adapt, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
+	rtl8188e_PHY_SetRFReg(adapt, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
+	rtl8188e_PHY_SetRFReg(adapt, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
+	rtl8188e_PHY_SetRFReg(adapt, RF_TXPA_G2, bRFRegOffsetMask, 0xf117B);
 
 	/* PA,PAD off */
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x980);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0x56, bRFRegOffsetMask, 0x51000);
+	rtl8188e_PHY_SetRFReg(adapt, 0xdf, bRFRegOffsetMask, 0x980);
+	rtl8188e_PHY_SetRFReg(adapt, 0x56, bRFRegOffsetMask, 0x51000);
 
 	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x80800000);
 
@@ -376,10 +376,10 @@ phy_PathA_RxIQK(struct adapter *adapt)
 	/* 1 RX IQK */
 	/* modify RXIQK mode table */
 	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x00000000);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7ffa);
+	rtl8188e_PHY_SetRFReg(adapt, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
+	rtl8188e_PHY_SetRFReg(adapt, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
+	rtl8188e_PHY_SetRFReg(adapt, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
+	rtl8188e_PHY_SetRFReg(adapt, RF_TXPA_G2, bRFRegOffsetMask, 0xf7ffa);
 	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x80800000);
 
 	/* IQK setting */
@@ -410,7 +410,7 @@ phy_PathA_RxIQK(struct adapter *adapt)
 
 	/* reload RF 0xdf */
 	rtl8188e_PHY_SetBBReg(adapt, rFPGA0_IQK, bMaskDWord, 0x00000000);
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x180);
+	rtl8188e_PHY_SetRFReg(adapt, 0xdf, bRFRegOffsetMask, 0x180);
 
 	if (!(regeac & BIT(27)) &&		/* if Tx is OK, check whether Rx is OK */
 	    (((regEA4 & 0x03FF0000) >> 16) != 0x132) &&
@@ -763,14 +763,14 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt)
 
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
-		rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode & 0x8FFFF) | 0x10000);
+		rtl8188e_PHY_SetRFReg(adapt, RF_AC, bMask12Bits, (RF_Amode & 0x8FFFF) | 0x10000);
 	}
 
 	/* 3. Read RF reg18 */
 	LC_Cal = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits);
 
 	/* 4. Set LC calibration begin	bit15 */
-	rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal | 0x08000);
+	rtl8188e_PHY_SetRFReg(adapt, RF_CHNLBW, bMask12Bits, LC_Cal | 0x08000);
 
 	msleep(100);
 
@@ -779,7 +779,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt)
 		/* Deal with continuous TX case */
 		/* Path-A */
 		rtw_write8(adapt, 0xd03, tmpreg);
-		rtl8188e_PHY_SetRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits, RF_Amode);
+		rtl8188e_PHY_SetRFReg(adapt, RF_AC, bMask12Bits, RF_Amode);
 	} else {
 		/*  Deal with Packet TX case */
 		rtw_write8(adapt, REG_TXPAUSE, 0x00);
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index a759c2fe5d66..b4be706545ff 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -896,7 +896,7 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
 	struct adapter *Adapter = pDM_Odm->Adapter;
 
 	if (!pDM_Odm->RFCalibrateInfo.TM_Trigger) {		/* at least delay 1 sec */
-		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, BIT(17) | BIT(16), 0x03);
+		rtl8188e_PHY_SetRFReg(Adapter, RF_T_METER_88E, BIT(17) | BIT(16), 0x03);
 
 		pDM_Odm->RFCalibrateInfo.TM_Trigger = 1;
 		return;
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 9059f2533b0b..0fa17a99f9e9 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -19,7 +19,7 @@ static void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 	} else if (Addr == 0xf9) {
 		udelay(1);
 	} else {
-		rtl8188e_PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH_A, RegAddr, bRFRegOffsetMask, Data);
+		rtl8188e_PHY_SetRFReg(pDM_Odm->Adapter, RegAddr, bRFRegOffsetMask, Data);
 		/*  Add 1us delay between BB/RF register setting. */
 		udelay(1);
 	}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index cd82452238e0..628cec40db5f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -282,7 +282,6 @@ u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, enum rf_radio_path eRFPath,
 *
 * Input:
 *			struct adapter *Adapter,
-*			enum rf_radio_path eRFPath,	Radio path of A/B/C/D
 *			u32			RegAddr,	The target address to be modified
 *			u32			BitMask		The target bit position in the target address
 *									to be modified
@@ -296,7 +295,6 @@ u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, enum rf_radio_path eRFPath,
 void
 rtl8188e_PHY_SetRFReg(
 		struct adapter *Adapter,
-		enum rf_radio_path eRFPath,
 		u32 RegAddr,
 		u32 BitMask,
 		u32 Data
@@ -306,12 +304,12 @@ rtl8188e_PHY_SetRFReg(
 
 	/*  RF data is 12 bits only */
 	if (BitMask != bRFRegOffsetMask) {
-		Original_Value = phy_RFSerialRead(Adapter, eRFPath, RegAddr);
+		Original_Value = phy_RFSerialRead(Adapter, RF_PATH_A, RegAddr);
 		BitShift =  phy_CalculateBitShift(BitMask);
 		Data = ((Original_Value & (~BitMask)) | (Data << BitShift));
 	}
 
-	phy_RFSerialWrite(Adapter, eRFPath, RegAddr, Data);
+	phy_RFSerialWrite(Adapter, RF_PATH_A, RegAddr, Data);
 }
 
 /*  */
@@ -725,7 +723,7 @@ static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
 	param1 = RF_CHNLBW;
 	param2 = channel;
 	pHalData->RfRegChnlVal = ((pHalData->RfRegChnlVal & 0xfffffc00) | param2);
-	rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal);
+	rtl8188e_PHY_SetRFReg(Adapter, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal);
 }
 
 void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 2d5d04b384d1..4a7a877e4017 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -51,11 +51,11 @@ void rtl8188e_PHY_RF6052SetBandwidth(struct adapter *Adapter,
 	switch (Bandwidth) {
 	case HT_CHANNEL_WIDTH_20:
 		pHalData->RfRegChnlVal = ((pHalData->RfRegChnlVal & 0xfffff3ff) | BIT(10) | BIT(11));
-		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal);
+		rtl8188e_PHY_SetRFReg(Adapter, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal);
 		break;
 	case HT_CHANNEL_WIDTH_40:
 		pHalData->RfRegChnlVal = ((pHalData->RfRegChnlVal & 0xfffff3ff) | BIT(10));
-		rtl8188e_PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal);
+		rtl8188e_PHY_SetRFReg(Adapter, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal);
 		break;
 	default:
 		break;
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 2517a08bc95a..e0dff772534d 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -75,8 +75,7 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr,
 			   u32 mask, u32 data);
 u32 rtl8188e_PHY_QueryRFReg(struct adapter *adapter, enum rf_radio_path rfpath,
 			    u32 regaddr, u32 mask);
-void rtl8188e_PHY_SetRFReg(struct adapter *adapter, enum rf_radio_path rfpath,
-			   u32 regaddr, u32 mask, u32 data);
+void rtl8188e_PHY_SetRFReg(struct adapter *adapter, u32 regaddr, u32 mask, u32 data);
 
 /*  Initialization related function */
 /* MAC/BB/RF HAL config */
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 9d3488c28048..548ed6f965f8 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2088,7 +2088,7 @@ static int rtw_wx_write_rf(struct net_device *dev,
 
 	addr = *((u32 *)extra + 1);
 	data32 = *((u32 *)extra + 2);
-	rtl8188e_PHY_SetRFReg(padapter, RF_PATH_A, addr, 0xFFFFF, data32);
+	rtl8188e_PHY_SetRFReg(padapter, addr, 0xFFFFF, data32);
 
 	return 0;
 }
@@ -3625,7 +3625,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			ret = -EINVAL;
 			break;
 		}
-		rtl8188e_PHY_SetRFReg(padapter, RF_PATH_A, arg, 0xffffffff, extra_arg);
+		rtl8188e_PHY_SetRFReg(padapter, arg, 0xffffffff, extra_arg);
 		DBG_88E("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtl8188e_PHY_QueryRFReg(padapter, minor_cmd, arg, 0xffffffff));
 		break;
 
-- 
2.30.2

