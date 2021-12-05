Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7926468BA4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhLEPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhLEPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:16:44 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13608C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:13:17 -0800 (PST)
Received: from dslb-188-097-212-203.188.097.pools.vodafone-ip.de ([188.97.212.203] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mttCS-0007gF-JN; Sun, 05 Dec 2021 16:13:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/10] staging: r8188eu: remove empty HAL_INIT_PROFILE_TAG macro
Date:   Sun,  5 Dec 2021 16:12:48 +0100
Message-Id: <20211205151251.6861-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211205151251.6861-1-martin@kaiser.cx>
References: <20211205151251.6861-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the HAL_INIT_PROFILE_TAG macro, which is empty.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 24 -----------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 17d898707f62..6c415e4181cd 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -594,10 +594,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
 	u32 init_start_time = jiffies;
 
-	#define HAL_INIT_PROFILE_TAG(stage) do {} while (0)
-
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_BEGIN);
-
 	if (Adapter->pwrctrlpriv.bkeepfwalive) {
 		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
 			PHY_IQCalibrate_8188E(Adapter, true);
@@ -612,7 +608,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		goto exit;
 	}
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_PW_ON);
 	status = rtl8188eu_InitPowerOn(Adapter);
 	if (status == _FAIL)
 		goto exit;
@@ -635,7 +630,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		txpktbuf_bndy = WMM_NORMAL_TX_PAGE_BOUNDARY_88E;
 	}
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC01);
 	_InitQueueReservedPage(Adapter);
 	_InitQueuePriority(Adapter);
 	_InitPageBoundary(Adapter);
@@ -643,7 +637,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	_InitTxBufferBoundary(Adapter, 0);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_DOWNLOAD_FW);
 	status = rtl8188e_FirmwareDownload(Adapter);
 
 	if (status != _SUCCESS) {
@@ -657,7 +650,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	}
 	rtl8188e_InitializeFirmwareVars(Adapter);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MAC);
 #if (HAL_MAC_ENABLE == 1)
 	status = PHY_MACConfig8188E(Adapter);
 	if (status == _FAIL) {
@@ -669,7 +661,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/*  */
 	/* d. Initialize BB related configurations. */
 	/*  */
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_BB);
 #if (HAL_BB_ENABLE == 1)
 	status = PHY_BBConfig8188E(Adapter);
 	if (status == _FAIL) {
@@ -678,7 +669,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	}
 #endif
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_RF);
 #if (HAL_RF_ENABLE == 1)
 	status = PHY_RFConfig8188E(Adapter);
 	if (status == _FAIL) {
@@ -687,7 +677,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	}
 #endif
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_EFUSE_PATCH);
 	status = rtl8188e_iol_efuse_patch(Adapter);
 	if (status == _FAIL) {
 		DBG_88E("%s  rtl8188e_iol_efuse_patch failed\n", __func__);
@@ -696,12 +685,10 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_LLTT);
 	status =  InitLLTTable(Adapter, txpktbuf_bndy);
 	if (status == _FAIL)
 		goto exit;
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC02);
 	/*  Get Rx PHY status in order to report RSSI and others. */
 	_InitDriverInfoSize(Adapter, DRVINFO_SZ);
 
@@ -746,13 +733,10 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	haldata->RfRegChnlVal[0] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
 	haldata->RfRegChnlVal[1] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)1, RF_CHNLBW, bRFRegOffsetMask);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_TURN_ON_BLOCK);
 	_BBTurnOnBlock(Adapter);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_SECURITY);
 	invalidate_cam_all(Adapter);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC11);
 	/*  2010/12/17 MH We need to set TX power according to EFUSE content at first. */
 	PHY_SetTxPowerLevel8188E(Adapter, haldata->CurrentChannel);
 
@@ -777,7 +761,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/* Nav limit , suggest by scott */
 	rtw_write8(Adapter, 0x652, 0x0);
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_HAL_DM);
 	rtl8188e_InitHalDm(Adapter);
 
 	/*  2010/08/11 MH Merge from 8192SE for Minicard init. We need to confirm current radio status */
@@ -801,7 +784,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/* enable tx DMA to drop the redundate data of packet */
 	rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK) | DROP_DATA_EN));
 
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_IQK);
 	/*  2010/08/26 MH Merge from 8192CE. */
 	if (pwrctrlpriv->rf_pwrstate == rf_on) {
 		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
@@ -811,15 +793,11 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 			haldata->odmpriv.RFCalibrateInfo.bIQKInitialized = true;
 		}
 
-		HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_PW_TRACK);
-
 		ODM_TXPowerTrackingCheck(&haldata->odmpriv);
 
-		HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_LCK);
 		PHY_LCCalibrate_8188E(Adapter);
 	}
 
-/* HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_PABIAS); */
 /*	_InitPABias(Adapter); */
 	rtw_write8(Adapter, REG_USB_HRPWM, 0);
 
@@ -827,8 +805,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL) | BIT(12));
 
 exit:
-	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
-
 	DBG_88E("%s in %dms\n", __func__, rtw_get_passing_time_ms(init_start_time));
 
 	return status;
-- 
2.20.1

