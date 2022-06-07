Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC31542592
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiFHDSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347976AbiFHDOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:14:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D54B19DE5B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:26:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id be31so29858291lfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0fAq1OZfMXGOMlvTdqBgiQCv6nP+qklSEl0noDd/+4=;
        b=i7o7OrLCO3ho7ZxyLDs2Ks+3rAI+zk7WqipXi5/XuYzgU/PljUSkZqcW5C64R21w/w
         gJtQrpONRFcnxizHWUQp/M+OUw5zNdICLIl6KFQeqqYaduAm5LY9AagybYtkDL+onrj2
         Nxb733BuWGm4L65rv1od2ozaNcYa/2S65UDNRZFzfPlihkb9eglH8mVsppm+NB81OWiS
         c0YeDu1fSbRE+DVyRYUuMYGD9P1yUkCyCoqg2AdoR4nRhkMxodW0SaY74mUVLt8m73t8
         /O+b8AUTIn81y7F7pUI2XOh05UoNdzsaiczCYc38sy5G07QvWSkwlZ96j7F/TQhHOCu2
         BqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0fAq1OZfMXGOMlvTdqBgiQCv6nP+qklSEl0noDd/+4=;
        b=z4X2yxj+puumfVLC3uT0qwdI6X4u0UF60z50J5rVFIpBbK55mTq1dQVLgvrglOtRdT
         D2JzC9F5nD5er37tBjhq3sZ1T+60n661il4Z7kXYs838TLzDdchN1leiUJGLBBJ6K9Kg
         hcmBiBMjwX+tTzYcpGyCEpQjWxXJooB6iwzIfq4dO90EDoarG5kYUNyjYSFOauv2EuQ6
         IiBD+kCsLJoV+6roH05cnL62jtU7sjM0sb77Lga+pAJExYfUqvLUW/akb3eSwg00jYfS
         +8gOfv0oBC85ywy6jakHSzMpVfD5W3+ffxyHFAJunIamoSc1RyLwixK2xbPz01slnSIq
         XOuw==
X-Gm-Message-State: AOAM533wgdNpbFPQMB7lN7BtOWi/qIfBs+AdCT1oMjcPIS+8Ge6SZbVP
        f4KhT3cNpVO0tP0h46fYwiw=
X-Google-Smtp-Source: ABdhPJzJ4S/JVPK/5v4/MwLbZtaRK6NxZwrmpGToe4VRUIXksYW1euC3jKSkKIWP/METImH2+8EOwA==
X-Received: by 2002:ac2:5599:0:b0:479:747:709b with SMTP id v25-20020ac25599000000b004790747709bmr22197159lfg.615.1654629987234;
        Tue, 07 Jun 2022 12:26:27 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id a5-20020ac25e65000000b0047255d210e8sm982909lfr.23.2022.06.07.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:26:26 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v4 3/4] staging: r8188eu: add error handling of rtw_read32
Date:   Tue,  7 Jun 2022 22:26:21 +0300
Message-Id: <583c3d21c46066275e4fc8da5ba4fd0e3679335b.1654629778.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654629778.git.paskripkin@gmail.com>
References: <cover.1654629778.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_read32() reads data from device via USB API which may fail. In case
of any failure previous code returned stack data to callers, which is
wrong.

Fix it by changing rtw_read32() prototype and prevent caller from
touching random stack data

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c        | 15 +++++-
 drivers/staging/r8188eu/core/rtw_efuse.c      | 20 ++++---
 drivers/staging/r8188eu/core/rtw_fw.c         | 16 ++++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 14 ++++-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  9 +++-
 .../r8188eu/hal/Hal8188ERateAdaptive.c        | 21 ++++++--
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  3 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 40 +++++++++-----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 12 ++++-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 53 ++++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 13 +++--
 drivers/staging/r8188eu/include/rtw_io.h      |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 27 ++++++++--
 drivers/staging/r8188eu/os_dep/os_intfs.c     | 13 ++++-
 14 files changed, 202 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 06523d91939a..5b6a891b5d67 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -898,8 +898,12 @@ static void traffic_status_watchdog(struct adapter *padapter)
 static void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 {
 	u32 txdma_status;
+	int res;
+
+	res = rtw_read32(padapter, REG_TXDMA_STATUS, &txdma_status);
+	if (res)
+		return;
 
-	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
 	if (txdma_status != 0x00)
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
 	/* total xmit irp = 4 */
@@ -1177,7 +1181,14 @@ u8 rtw_ps_cmd(struct adapter *padapter)
 
 static bool rtw_is_hi_queue_empty(struct adapter *adapter)
 {
-	return (rtw_read32(adapter, REG_HGQ_INFORMATION) & 0x0000ff00) == 0;
+	int res;
+	u32 reg;
+
+	res = rtw_read32(adapter, REG_HGQ_INFORMATION, &reg);
+	if (res)
+		return false;
+
+	return (reg & 0x0000ff00) == 0;
 }
 
 static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index a2691c7f96f6..8005ed8d3a20 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -46,11 +46,17 @@ ReadEFuseByte(
 	rtw_write8(Adapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
 
 	/* Check bit 32 read-ready */
-	retry = 0;
-	value32 = rtw_read32(Adapter, EFUSE_CTRL);
-	while (!(((value32 >> 24) & 0xff) & 0x80)  && (retry < 10000)) {
-		value32 = rtw_read32(Adapter, EFUSE_CTRL);
-		retry++;
+	res = rtw_read32(Adapter, EFUSE_CTRL, &value32);
+	if (res)
+		return;
+
+	for (retry = 0; retry < 10000; retry++) {
+		res = rtw_read32(Adapter, EFUSE_CTRL, &value32);
+		if (res)
+			continue;
+
+		if (((value32 >> 24) & 0xff) & 0x80)
+			break;
 	}
 
 	/*  20100205 Joseph: Add delay suggested by SD1 Victor. */
@@ -58,7 +64,9 @@ ReadEFuseByte(
 	/*  Designer says that there shall be some delay after ready bit is set, or the */
 	/*  result will always stay on last data we read. */
 	udelay(50);
-	value32 = rtw_read32(Adapter, EFUSE_CTRL);
+	res = rtw_read32(Adapter, EFUSE_CTRL, &value32);
+	if (res)
+		return;
 
 	*pbuf = (u8)(value32 & 0xff);
 
diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index e1fc883a5f7e..95534f9c7a0f 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -194,10 +194,14 @@ static int fw_free_to_go(struct adapter *padapter)
 {
 	u32	counter = 0;
 	u32	value32;
+	int res;
 
 	/*  polling CheckSum report */
 	do {
-		value32 = rtw_read32(padapter, REG_MCUFWDL);
+		res = rtw_read32(padapter, REG_MCUFWDL, &value32);
+		if (res)
+			continue;
+
 		if (value32 & FWDL_CHKSUM_RPT)
 			break;
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
@@ -205,7 +209,10 @@ static int fw_free_to_go(struct adapter *padapter)
 	if (counter >= POLLING_READY_TIMEOUT_COUNT)
 		return _FAIL;
 
-	value32 = rtw_read32(padapter, REG_MCUFWDL);
+	res = rtw_read32(padapter, REG_MCUFWDL, &value32);
+	if (res)
+		return _FAIL;
+
 	value32 |= MCUFWDL_RDY;
 	value32 &= ~WINTINI_RDY;
 	rtw_write32(padapter, REG_MCUFWDL, value32);
@@ -215,9 +222,10 @@ static int fw_free_to_go(struct adapter *padapter)
 	/*  polling for FW ready */
 	counter = 0;
 	do {
-		value32 = rtw_read32(padapter, REG_MCUFWDL);
-		if (value32 & WINTINI_RDY)
+		res = rtw_read32(padapter, REG_MCUFWDL, &value32);
+		if (!res && value32 & WINTINI_RDY)
 			return _SUCCESS;
+
 		udelay(5);
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 2eb9d85e5553..37b1608ed2d1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6000,6 +6000,7 @@ static void mlme_join(struct adapter *adapter, int type)
 {
 	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
 	u8 retry_limit = 0x30, reg;
+	u32 reg32;
 	int res;
 
 	switch (type) {
@@ -6008,8 +6009,12 @@ static void mlme_join(struct adapter *adapter, int type)
 		/* enable to rx data frame, accept all data frame */
 		rtw_write16(adapter, REG_RXFLTMAP2, 0xFFFF);
 
+		res = rtw_read32(adapter, REG_RCR, &reg32);
+		if (res)
+			return;
+
 		rtw_write32(adapter, REG_RCR,
-			    rtw_read32(adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
+			    reg32 | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 
 		if (check_fwstate(mlmepriv, WIFI_STATION_STATE)) {
 			retry_limit = 48;
@@ -6822,9 +6827,14 @@ static u8 chk_ap_is_alive(struct sta_info *psta)
 
 static int rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 {
-	u32 rx_dma_status =  rtw_read32(padapter, REG_RXDMA_STATUS);
+	u32 rx_dma_status;
+	int res;
 	u8 reg;
 
+	res = rtw_read32(padapter, REG_RXDMA_STATUS, &rx_dma_status);
+	if (res)
+		return res;
+
 	if (rx_dma_status != 0x00)
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
 
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 7b816b824947..45e85b593665 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -229,6 +229,9 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 
 static bool lps_rf_on(struct adapter *adapter)
 {
+	int res;
+	u32 reg;
+
 	/* When we halt NIC, we should check if FW LPS is leave. */
 	if (adapter->pwrctrlpriv.rf_pwrstate == rf_off) {
 		/*  If it is in HW/SW Radio OFF or IPS state, we do not check Fw LPS Leave, */
@@ -236,7 +239,11 @@ static bool lps_rf_on(struct adapter *adapter)
 		return true;
 	}
 
-	if (rtw_read32(adapter, REG_RCR) & 0x00070000)
+	res = rtw_read32(adapter, REG_RCR, &reg);
+	if (res)
+		return false;
+
+	if (reg & 0x00070000)
 		return false;
 
 	return true;
diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 57e8f5573846..3cefdf90d6e0 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -279,6 +279,7 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 {  /*  Wilson 2011/10/26 */
 	u32 MaskFromReg;
 	s8 i;
+	int res;
 
 	switch (pRaInfo->RateID) {
 	case RATR_INX_WIRELESS_NGB:
@@ -303,19 +304,31 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x0000000d;
 		break;
 	case 12:
-		MaskFromReg = rtw_read32(dm_odm->Adapter, REG_ARFR0);
+		res = rtw_read32(dm_odm->Adapter, REG_ARFR0, &MaskFromReg);
+		if (res)
+			return res;
+
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 13:
-		MaskFromReg = rtw_read32(dm_odm->Adapter, REG_ARFR1);
+		res = rtw_read32(dm_odm->Adapter, REG_ARFR1, &MaskFromReg);
+		if (res)
+			return res;
+
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 14:
-		MaskFromReg = rtw_read32(dm_odm->Adapter, REG_ARFR2);
+		res = rtw_read32(dm_odm->Adapter, REG_ARFR2, &MaskFromReg);
+		if (res)
+			return res;
+
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 15:
-		MaskFromReg = rtw_read32(dm_odm->Adapter, REG_ARFR3);
+		res = rtw_read32(dm_odm->Adapter, REG_ARFR3, &MaskFromReg);
+		if (res)
+			return res;
+
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index a5b7980dfcee..525deab10820 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -483,7 +483,8 @@ static void _PHY_SaveMACRegisters(
 		MACBackup[i] = reg;
 	}
 
-	MACBackup[i] = rtw_read32(adapt, MACReg[i]);
+	res = rtw_read32(adapt, MACReg[i], MACBackup + i);
+	(void)res;
 }
 
 static void reload_adda_reg(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegiesterNum)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 8215ed8b506d..5549e7be334a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -216,6 +216,7 @@ static int efuse_read_phymap_from_txpktbuf(
 	u16 limit = *size;
 	u8 reg;
 	u8 *pos = content;
+	u32 reg32;
 
 	if (bcnhead < 0) { /* if not valid */
 		res = rtw_read8(adapter, REG_TDECTRL + 1, &reg);
@@ -246,8 +247,17 @@ static int efuse_read_phymap_from_txpktbuf(
 		} while (time_before(jiffies, timeout));
 
 		/* data from EEPROM needs to be in LE */
-		lo32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L));
-		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
+		res = rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L, &reg32);
+		if (res)
+			return res;
+
+		lo32 = cpu_to_le32(reg32);
+
+		res = rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H, &reg32);
+		if (res)
+			return res;
+
+		hi32 = cpu_to_le32(reg32);
 
 		if (i == 0) {
 			u16 reg;
@@ -548,8 +558,12 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 	u32				value32;
 	struct HAL_VERSION		ChipVersion;
 	struct hal_data_8188e *pHalData = &padapter->haldata;
+	int res;
+
+	res = rtw_read32(padapter, REG_SYS_CFG, &value32);
+	if (res)
+		return;
 
-	value32 = rtw_read32(padapter, REG_SYS_CFG);
 	ChipVersion.ChipType = ((value32 & RTL_ID) ? TEST_CHIP : NORMAL_CHIP);
 
 	ChipVersion.VendorType = ((value32 & VENDOR_ID) ? CHIP_VENDOR_UMC : CHIP_VENDOR_TSMC);
@@ -596,26 +610,24 @@ void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 /*  */
 static s32 _LLTWrite(struct adapter *padapter, u32 address, u32 data)
 {
-	s32	status = _SUCCESS;
-	s32	count = 0;
+	s32	count;
 	u32	value = _LLT_INIT_ADDR(address) | _LLT_INIT_DATA(data) | _LLT_OP(_LLT_WRITE_ACCESS);
 	u16	LLTReg = REG_LLT_INIT;
+	int res;
 
 	rtw_write32(padapter, LLTReg, value);
 
 	/* polling */
-	do {
-		value = rtw_read32(padapter, LLTReg);
-		if (_LLT_NO_ACTIVE == _LLT_OP_VALUE(value))
-			break;
+	for (count = 0; count <= POLLING_LLT_THRESHOLD; count++) {
+		res = rtw_read32(padapter, LLTReg, &value);
+		if (res)
+			continue;
 
-		if (count > POLLING_LLT_THRESHOLD) {
-			status = _FAIL;
+		if (_LLT_NO_ACTIVE == _LLT_OP_VALUE(value))
 			break;
-		}
-	} while (count++);
+	}
 
-	return status;
+	return count > POLLING_LLT_THRESHOLD ? _FAIL : _SUCCESS;
 }
 
 s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 298c3d9bc7be..dea6d915a1f4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -56,8 +56,12 @@ rtl8188e_PHY_QueryBBReg(
 	)
 {
 	u32 ReturnValue = 0, OriginalValue, BitShift;
+	int res;
+
+	res = rtw_read32(Adapter, RegAddr, &OriginalValue);
+	if (res)
+		return 0;
 
-	OriginalValue = rtw_read32(Adapter, RegAddr);
 	BitShift = phy_CalculateBitShift(BitMask);
 	ReturnValue = (OriginalValue & BitMask) >> BitShift;
 	return ReturnValue;
@@ -84,9 +88,13 @@ rtl8188e_PHY_QueryBBReg(
 void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
 {
 	u32 OriginalValue, BitShift;
+	int res;
 
 	if (BitMask != bMaskDWord) { /* if not "double word" write */
-		OriginalValue = rtw_read32(Adapter, RegAddr);
+		res = rtw_read32(Adapter, RegAddr, &OriginalValue);
+		if (res)
+			return;
+
 		BitShift = phy_CalculateBitShift(BitMask);
 		Data = ((OriginalValue & (~BitMask)) | (Data << BitShift));
 	}
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 9a7d22960be8..cb9b4bcc536a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -297,8 +297,12 @@ static void _InitQueuePriority(struct adapter *Adapter)
 static void _InitNetworkType(struct adapter *Adapter)
 {
 	u32 value32;
+	int res;
+
+	res = rtw_read32(Adapter, REG_CR, &value32);
+	if (res)
+		return;
 
-	value32 = rtw_read32(Adapter, REG_CR);
 	/*  TODO: use the other function to set network type */
 	value32 = (value32 & ~MASK_NETTYPE) | _NETTYPE(NT_LINK_AP);
 
@@ -338,9 +342,13 @@ static void _InitAdaptiveCtrl(struct adapter *Adapter)
 {
 	u16 value16;
 	u32 value32;
+	int res;
 
 	/*  Response Rate Set */
-	value32 = rtw_read32(Adapter, REG_RRSR);
+	res = rtw_read32(Adapter, REG_RRSR, &value32);
+	if (res)
+		return;
+
 	value32 &= ~RATE_BITMAP_ALL;
 	value32 |= RATE_RRSR_CCK_ONLY_1M;
 	rtw_write32(Adapter, REG_RRSR, value32);
@@ -409,11 +417,15 @@ static void _InitRetryFunction(struct adapter *Adapter)
 static void usb_AggSettingTxUpdate(struct adapter *Adapter)
 {
 	u32 value32;
+	int res;
 
 	if (Adapter->registrypriv.wifi_spec)
 		return;
 
-	value32 = rtw_read32(Adapter, REG_TDECTRL);
+	res = rtw_read32(Adapter, REG_TDECTRL, &value32);
+	if (res)
+		return;
+
 	value32 = value32 & ~(BLK_DESC_NUM_MASK << BLK_DESC_NUM_SHIFT);
 	value32 |= ((USB_TXAGG_DESC_NUM & BLK_DESC_NUM_MASK) << BLK_DESC_NUM_SHIFT);
 
@@ -521,11 +533,17 @@ static void _BBTurnOnBlock(struct adapter *Adapter)
 static void _InitAntenna_Selection(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
+	int res;
+	u32 reg;
 
 	if (haldata->AntDivCfg == 0)
 		return;
 
-	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0) | BIT(23));
+	res = rtw_read32(Adapter, REG_LEDCFG0, &reg);
+	if (res)
+		return;
+
+	rtw_write32(Adapter, REG_LEDCFG0, reg | BIT(23));
 	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
 
 	if (rtl8188e_PHY_QueryBBReg(Adapter, rFPGA0_XA_RFInterfaceOE, 0x300) == Antenna_A)
@@ -555,6 +573,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
+	u32 reg;
 
 	if (Adapter->pwrctrlpriv.bkeepfwalive) {
 		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
@@ -752,7 +771,11 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_USB_HRPWM, 0);
 
 	/* ack for xmit mgmt frames. */
-	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL) | BIT(12));
+	res = rtw_read32(Adapter, REG_FWHW_TXQ_CTRL, &reg);
+	if (res)
+		return _FAIL;
+
+	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, reg | BIT(12));
 
 exit:
 	return status;
@@ -1121,7 +1144,12 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_MLME_SITESURVEY:
 		if (*((u8 *)val)) { /* under sitesurvey */
 			/* config RCR to receive different BSSID & not to receive data frame */
-			u32 v = rtw_read32(Adapter, REG_RCR);
+			u32 v;
+
+			res = rtw_read32(Adapter, REG_RCR, &v);
+			if (res)
+				return;
+
 			v &= ~(RCR_CBSSID_BCN);
 			rtw_write32(Adapter, REG_RCR, v);
 			/* reject all data frame */
@@ -1136,6 +1164,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		} else { /* sitesurvey done */
 			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
 			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+			u32 reg32;
 
 			if ((is_client_associated_to_ap(Adapter)) ||
 			    ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)) {
@@ -1157,7 +1186,12 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 				rtw_write8(Adapter, REG_BCN_CTRL, reg & (~BIT(4)));
 			}
-			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
+
+			res = rtw_read32(Adapter, REG_RCR, &reg32);
+			if (res)
+				return;
+
+			rtw_write32(Adapter, REG_RCR, reg32 | RCR_CBSSID_BCN);
 		}
 		break;
 	case HW_VAR_DM_FLAG:
@@ -1302,7 +1336,10 @@ void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 
 	rtw_write8(adapt, REG_SLOT, 0x09);
 
-	value32 = rtw_read32(adapt, REG_TCR);
+	res = rtw_read32(adapt, REG_TCR, &value32);
+	if (res)
+		return;
+
 	value32 &= ~TSFRST;
 	rtw_write32(adapt,  REG_TCR, value32);
 
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 7d62f1f3d26e..c1a4d023f627 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -120,16 +120,21 @@ int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
 	return 0;
 }
 
-u32 rtw_read32(struct adapter *adapter, u32 addr)
+int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	__le32 data;
+	__le32 le_data;
+	int res;
 
-	usb_read(intf, value, &data, 4);
+	res = usb_read(intf, value, &le_data, 4);
+	if (res)
+		return res;
 
-	return le32_to_cpu(data);
+	*data = le32_to_cpu(le_data);
+
+	return 0;
 }
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index d9db2c1c7a67..925c7967ac04 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -222,7 +222,7 @@ void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
 int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data);
-u32 rtw_read32(struct adapter *adapter, u32 addr);
+int __must_check rtw_read32(struct adapter *adapter, u32 addr, u32 *data);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 rtw_read_port(struct adapter *adapter, u8 *pmem);
 void rtw_read_port_cancel(struct adapter *adapter);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 30aa2a2c0ade..e95cf35949d0 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3126,18 +3126,29 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 static void mac_reg_dump(struct adapter *padapter)
 {
 	int i, j = 1;
+	u32 reg;
+	int res;
+
 	pr_info("\n ======= MAC REG =======\n");
 	for (i = 0x0; i < 0x300; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+
+		res = rtw_read32(padapter, i, &reg);
+		if (!res)
+			pr_info(" 0x%08x ", reg);
+
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
 	for (i = 0x400; i < 0x800; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+
+		res = rtw_read32(padapter, i, &reg);
+		if (!res)
+			pr_info(" 0x%08x ", reg);
+
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
@@ -3145,13 +3156,18 @@ static void mac_reg_dump(struct adapter *padapter)
 
 static void bb_reg_dump(struct adapter *padapter)
 {
-	int i, j = 1;
+	int i, j = 1, res;
+	u32 reg;
+
 	pr_info("\n ======= BB REG =======\n");
 	for (i = 0x800; i < 0x1000; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
 
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+		res = rtw_read32(padapter, i, &reg);
+		if (!res)
+			pr_info(" 0x%08x ", reg);
+
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
@@ -3398,7 +3414,8 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			rtw_read32(padapter, reg);
+			/* FIXME: is this read necessary? */
+			ret = rtw_read32(padapter, reg, &write_num);
 		}
 			break;
 		}
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index d9325ef6ac28..cac9553666e6 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -741,6 +741,7 @@ static void rtw_fifo_cleanup(struct adapter *adapter)
 	struct pwrctrl_priv *pwrpriv = &adapter->pwrctrlpriv;
 	u8 trycnt = 100;
 	int res;
+	u32 reg;
 
 	/* pause tx */
 	rtw_write8(adapter, REG_TXPAUSE, 0xff);
@@ -753,10 +754,18 @@ static void rtw_fifo_cleanup(struct adapter *adapter)
 
 	if (!pwrpriv->bkeepfwalive) {
 		/* RX DMA stop */
+		res = rtw_read32(adapter, REG_RXPKT_NUM, &reg);
+		if (res)
+			return;
+
 		rtw_write32(adapter, REG_RXPKT_NUM,
-			    (rtw_read32(adapter, REG_RXPKT_NUM) | RW_RELEASE_EN));
+			    (reg | RW_RELEASE_EN));
 		do {
-			if (!(rtw_read32(adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
+			res = rtw_read32(adapter, REG_RXPKT_NUM, &reg);
+			if (res)
+				continue;
+
+			if (!(reg & RXDMA_IDLE))
 				break;
 		} while (trycnt--);
 
-- 
2.36.1

