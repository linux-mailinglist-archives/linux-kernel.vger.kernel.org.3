Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137054B3652
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiBLQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:18:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiBLQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:17:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEECC20E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:17:55 -0800 (PST)
Received: from dslb-188-097-215-215.188.097.pools.vodafone-ip.de ([188.97.215.215] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nIv5r-0007YM-CF; Sat, 12 Feb 2022 17:17:51 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/10] staging: r8188eu: remove path parameter from rtl8188e_PHY_QueryRFReg
Date:   Sat, 12 Feb 2022 17:17:35 +0100
Message-Id: <20220212161737.381841-9-martin@kaiser.cx>
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

All callers of rtl8188e_PHY_QueryRFReg set the eRFPath parameter
to RF_PATH_A. Remove the parameter and use RF_PATH_A directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c     | 6 +++---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c    | 6 ++----
 drivers/staging/r8188eu/hal/usb_halinit.c        | 2 +-
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 3 +--
 drivers/staging/r8188eu/os_dep/ioctl_linux.c     | 8 ++++----
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index c7aed5ed5fa5..0fcf094ae594 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -132,7 +132,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	/*  <Kordan> RFCalibrateInfo.RegA24 will be initialized when ODM HW configuring, but MP configures with para files. */
 	dm_odm->RFCalibrateInfo.RegA24 = 0x090e1317;
 
-	ThermalValue = (u8)rtl8188e_PHY_QueryRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, 0xfc00); /* 0x42: RF Reg[15:10] 88E */
+	ThermalValue = (u8)rtl8188e_PHY_QueryRFReg(Adapter, RF_T_METER_88E, 0xfc00); /* 0x42: RF Reg[15:10] 88E */
 
 	if (ThermalValue) {
 		/* Query OFDM path A default setting */
@@ -759,7 +759,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt)
 	if ((tmpreg & 0x70) != 0) {
 		/* 1. Read original RF mode */
 		/* Path-A */
-		RF_Amode = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits);
+		RF_Amode = rtl8188e_PHY_QueryRFReg(adapt, RF_AC, bMask12Bits);
 
 		/* 2. Set RF mode = standby mode */
 		/* Path-A */
@@ -767,7 +767,7 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt)
 	}
 
 	/* 3. Read RF reg18 */
-	LC_Cal = rtl8188e_PHY_QueryRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits);
+	LC_Cal = rtl8188e_PHY_QueryRFReg(adapt, RF_CHNLBW, bMask12Bits);
 
 	/* 4. Set LC calibration begin	bit15 */
 	rtl8188e_PHY_SetRFReg(adapt, RF_CHNLBW, bMask12Bits, LC_Cal | 0x08000);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 9e02855c47b2..2dcd1df58aaa 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -253,7 +253,6 @@ phy_RFSerialWrite(
 *
 * Input:
 *			struct adapter *Adapter,
-*			enum rf_radio_path eRFPath,	Radio path of A/B/C/D
 *			u32			RegAddr,	The target address to be read
 *			u32			BitMask		The target bit position in the target address
 *									to be read
@@ -262,12 +261,11 @@ phy_RFSerialWrite(
 * Return:		u32			Readback value
 * Note:		This function is equal to "GetRFRegSetting" in PHY programming guide
 */
-u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, enum rf_radio_path eRFPath,
-			    u32 RegAddr, u32 BitMask)
+u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 {
 	u32 Original_Value, Readback_Value, BitShift;
 
-	Original_Value = phy_RFSerialRead(Adapter, eRFPath, RegAddr);
+	Original_Value = phy_RFSerialRead(Adapter, RF_PATH_A, RegAddr);
 
 	BitShift =  phy_CalculateBitShift(BitMask);
 	Readback_Value = (Original_Value & BitMask) >> BitShift;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 1f2c736c3bc4..63e6337c2344 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -662,7 +662,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write16(Adapter, REG_PKT_BE_BK_LIFE_TIME, 0x0400);	/*  unit: 256us. 256ms */
 
 	/* Keep RfRegChnlVal for later use. */
-	haldata->RfRegChnlVal = rtl8188e_PHY_QueryRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask);
+	haldata->RfRegChnlVal = rtl8188e_PHY_QueryRFReg(Adapter, RF_CHNLBW, bRFRegOffsetMask);
 
 	_BBTurnOnBlock(Adapter);
 
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index e0dff772534d..9e6f2361b090 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -73,8 +73,7 @@ struct bb_reg_def {
 u32 rtl8188e_PHY_QueryBBReg(struct adapter *adapter, u32 regaddr, u32 mask);
 void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr,
 			   u32 mask, u32 data);
-u32 rtl8188e_PHY_QueryRFReg(struct adapter *adapter, enum rf_radio_path rfpath,
-			    u32 regaddr, u32 mask);
+u32 rtl8188e_PHY_QueryRFReg(struct adapter *adapter, u32 regaddr, u32 mask);
 void rtl8188e_PHY_SetRFReg(struct adapter *adapter, u32 regaddr, u32 mask, u32 data);
 
 /*  Initialization related function */
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 4b3134aef917..f6a683cda614 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2067,7 +2067,7 @@ static int rtw_wx_read_rf(struct net_device *dev,
 		return -EINVAL;
 
 	addr = *((u32 *)extra + 1);
-	data32 = rtl8188e_PHY_QueryRFReg(padapter, RF_PATH_A, addr, 0xFFFFF);
+	data32 = rtl8188e_PHY_QueryRFReg(padapter, addr, 0xFFFFF);
 	/*
 	 * IMPORTANT!!
 	 * Only when wireless private ioctl is at odd order,
@@ -3547,7 +3547,7 @@ static void rf_reg_dump(struct adapter *padapter)
 	pr_info("\n ======= RF REG =======\n");
 	pr_info("\nRF_Path(%x)\n", RF_PATH_A);
 	for (i = 0; i < 0x100; i++) {
-		value = rtl8188e_PHY_QueryRFReg(padapter, RF_PATH_A, i, 0xffffffff);
+		value = rtl8188e_PHY_QueryRFReg(padapter, i, 0xffffffff);
 		if (j % 4 == 1)
 			pr_info("0x%02x ", i);
 		pr_info(" 0x%08x ", value);
@@ -3625,7 +3625,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			ret = -EINVAL;
 			break;
 		}
-		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", RF_PATH_A, arg, rtl8188e_PHY_QueryRFReg(padapter, RF_PATH_A, arg, 0xffffffff));
+		DBG_88E("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", RF_PATH_A, arg, rtl8188e_PHY_QueryRFReg(padapter, arg, 0xffffffff));
 		break;
 	case 0x75:/* write_rf */
 		if (minor_cmd != RF_PATH_A) {
@@ -3633,7 +3633,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			break;
 		}
 		rtl8188e_PHY_SetRFReg(padapter, arg, 0xffffffff, extra_arg);
-		DBG_88E("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", RF_PATH_A, arg, rtl8188e_PHY_QueryRFReg(padapter, RF_PATH_A, arg, 0xffffffff));
+		DBG_88E("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", RF_PATH_A, arg, rtl8188e_PHY_QueryRFReg(padapter, arg, 0xffffffff));
 		break;
 
 	case 0x76:
-- 
2.30.2

