Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30F852DEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245045AbiESVKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245034AbiESVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:10:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CC5ED78E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:09:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w14so11128758lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzsilJYHRtraqFs7CXN4ot5Uvk/kJihQ5Euha9saQvc=;
        b=VK2eTAH49wz0IxmTO7BQvsjcYFF+Z/nk0m+iAs6DM1OtL9qs+/UvATk2V8xWjr5hL+
         0NRbobswDi809mkws3KVXRw9MoXQJgQCApQugeHdJA/zW4Mt5VdTdfM6nGyYxnOWwoAC
         p7iepSZzQyH9ArBd6Smnp9DRnMNFIjLRFNjeTOMANTeQ8hwW0VjtkDgiCNN4Nfo65MkR
         3K29+R7Vh/4nw+7ZVTaBXNMGf8wFseXe6/ILmbtOAmEyd1NpC7NuVEga5L+mnGSEniay
         VsSOYvjRKc39Gjl+fyEMG/zjrP4He3UBMQR7/YP7owrpJXz5NJZoLiTgtRZDx34ibl6T
         iAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzsilJYHRtraqFs7CXN4ot5Uvk/kJihQ5Euha9saQvc=;
        b=oScbpd41bWxuMlwccJ0ccYlojHP+d7081OwKbWidXueHHYXwp1uTaqtgFdu6l0vsX7
         lD9Og9r8lXXqEu24mp7BraZAHvmLy/zHQScVrHmybddh97/F3fkBJrO4AoDO9RJlEKEA
         ZzZAcvpDo9BuK0t9T+MB4LDFsnXgcAfEkwEzoFxKRUYbz+WZbOPANGbu/9ExTcvoKGvF
         zGGWktWGHvC7EEOQIcRVtZOh5rN3jy1pGMDeNcGgaMutKl+Qh5CBHbuS5Ov/z+OTwa52
         jNmbxO3N+c5I9Cg1s6ovb9sr8Va5pZbM0CGm/mP8V/Fs00GNC7X5pumecLG0ZTnJlG7/
         mgxA==
X-Gm-Message-State: AOAM5309tCeGKDNNRCYfiMJQCyWShfdIbLHL7lI5sy9tgVExF0jQ9vPE
        FiZEhJIpL8mxRzgFIYn81aY=
X-Google-Smtp-Source: ABdhPJwxsd+V4zySS3zyLDSkPuMX7SfbQ6+bYF7C/5bSNR5gVSXHO8vIkQZaXy76XVUi4C+ZcLI2ng==
X-Received: by 2002:a05:6512:1151:b0:473:d081:e40e with SMTP id m17-20020a056512115100b00473d081e40emr4760224lfg.186.1652994597679;
        Thu, 19 May 2022 14:09:57 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id 4-20020ac24824000000b0047255d211c8sm398973lft.247.2022.05.19.14.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:09:57 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com, fmdefrancesco@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2 2/4] staging: r8188eu: add error handling of rtw_read16
Date:   Fri, 20 May 2022 00:09:55 +0300
Message-Id: <fd10125ab8f4a64572742ec01d3202af2a79b1d0.1652994483.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652994483.git.paskripkin@gmail.com>
References: <cover.1652994483.git.paskripkin@gmail.com>
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

rtw_read16() reads data from device via USB API which may fail. In case
of any failure previous code returned stack data to callers, which is
wrong.

Fix it by changing rtw_read16() prototype and prevent caller from
touching random stack data

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes since v1:
	- Fixed style issue

---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 21 ++++++++++++---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  8 ++++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 27 ++++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 13 ++++++---
 drivers/staging/r8188eu/include/rtw_io.h      |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  9 ++++---
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  6 ++++-
 7 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index e67ecbd1ba79..6662ebc30f7b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -249,11 +249,14 @@ static void efuse_read_phymap_from_txpktbuf(
 		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
 
 		if (i == 0) {
+			u16 reg;
+
 			/* Although lenc is only used in a debug statement,
 			 * do not remove it as the rtw_read16() call consumes
 			 * 2 bytes from the EEPROM source.
 			 */
-			rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
+			res = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L, &reg);
+			(void)res;
 
 			len = le32_to_cpu(lo32) & 0x0000ffff;
 
@@ -355,25 +358,35 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_frame *xmit
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState)
 {
 	u16	tmpV16;
+	int res;
 
 	if (PwrState) {
 		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
 
 		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), defualt valid */
-		tmpV16 = rtw_read16(pAdapter, REG_SYS_ISO_CTRL);
+		res = rtw_read16(pAdapter, REG_SYS_ISO_CTRL, &tmpV16);
+		if (res)
+			return;
+
 		if (!(tmpV16 & PWC_EV12V)) {
 			tmpV16 |= PWC_EV12V;
 			rtw_write16(pAdapter, REG_SYS_ISO_CTRL, tmpV16);
 		}
 		/*  Reset: 0x0000h[28], default valid */
-		tmpV16 =  rtw_read16(pAdapter, REG_SYS_FUNC_EN);
+		res = rtw_read16(pAdapter, REG_SYS_FUNC_EN, &tmpV16);
+		if (res)
+			return;
+
 		if (!(tmpV16 & FEN_ELDR)) {
 			tmpV16 |= FEN_ELDR;
 			rtw_write16(pAdapter, REG_SYS_FUNC_EN, tmpV16);
 		}
 
 		/*  Clock: Gated(0x0008h[5]) 8M(0x0008h[1]) clock from ANA, default valid */
-		tmpV16 = rtw_read16(pAdapter, REG_SYS_CLKR);
+		res = rtw_read16(pAdapter, REG_SYS_CLKR, &tmpV16);
+		if (res)
+			return;
+
 		if ((!(tmpV16 & LOADER_CLK_EN))  || (!(tmpV16 & ANA8M))) {
 			tmpV16 |= (LOADER_CLK_EN | ANA8M);
 			rtw_write16(pAdapter, REG_SYS_CLKR, tmpV16);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 985339a974fc..298c3d9bc7be 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -484,13 +484,17 @@ PHY_BBConfig8188E(
 {
 	int	rtStatus = _SUCCESS;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	u32 RegVal;
+	u16 RegVal;
 	u8 CrystalCap;
+	int res;
 
 	phy_InitBBRFRegisterDefinition(Adapter);
 
 	/*  Enable BB and RF */
-	RegVal = rtw_read16(Adapter, REG_SYS_FUNC_EN);
+	res = rtw_read16(Adapter, REG_SYS_FUNC_EN, &RegVal);
+	if (res)
+		return _FAIL;
+
 	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal | BIT(13) | BIT(0) | BIT(1)));
 
 	/*  20090923 Joseph: Advised by Steven and Jenyu. Power sequence before init RF. */
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 5daef0117a5c..40d907dd2b58 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -52,6 +52,8 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 {
 	u16 value16;
+	int res;
+
 	/*  HW Power on sequence */
 	struct hal_data_8188e *haldata = &adapt->haldata;
 	if (haldata->bMacPwrCtrlOn)
@@ -65,7 +67,10 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	rtw_write16(adapt, REG_CR, 0x00);  /* suggseted by zhouzhou, by page, 20111230 */
 
 		/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
-	value16 = rtw_read16(adapt, REG_CR);
+	res = rtw_read16(adapt, REG_CR, &value16);
+	if (res)
+		return _FAIL;
+
 	value16 |= (HCI_TXDMA_EN | HCI_RXDMA_EN | TXDMA_EN | RXDMA_EN
 				| PROTOCOL_EN | SCHEDULE_EN | ENSEC | CALTMR_EN);
 	/*  for SDIO - Set CR bit10 to enable 32k calibration. Suggested by SD1 Gimmy. Added by tynli. 2011.08.31. */
@@ -166,7 +171,14 @@ static void _InitNormalChipRegPriority(struct adapter *Adapter, u16 beQ,
 				       u16 bkQ, u16 viQ, u16 voQ, u16 mgtQ,
 				       u16 hiQ)
 {
-	u16 value16	= (rtw_read16(Adapter, REG_TRXDMA_CTRL) & 0x7);
+	u16 value16;
+	int res;
+
+	res = rtw_read16(Adapter, REG_TRXDMA_CTRL, &value16);
+	if (res)
+		return;
+
+	value16 &= 0x7;
 
 	value16 |= _TXDMA_BEQ_MAP(beQ)	| _TXDMA_BKQ_MAP(bkQ) |
 		   _TXDMA_VIQ_MAP(viQ)	| _TXDMA_VOQ_MAP(voQ) |
@@ -631,7 +643,10 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/*  Hw bug which Hw initials RxFF boundary size to a value which is larger than the real Rx buffer size in 88E. */
 	/*  */
 	/*  Enable MACTXEN/MACRXEN block */
-	value16 = rtw_read16(Adapter, REG_CR);
+	res = rtw_read16(Adapter, REG_CR, &value16);
+	if (res)
+		return _FAIL;
+
 	value16 |= (MACTXEN | MACRXEN);
 	rtw_write8(Adapter, REG_CR, value16);
 
@@ -704,7 +719,11 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write16(Adapter, REG_TX_RPT_TIME, 0x3DF0);
 
 	/* enable tx DMA to drop the redundate data of packet */
-	rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK) | DROP_DATA_EN));
+	res = rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK, &value16);
+	if (res)
+		return _FAIL;
+
+	rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (value16 | DROP_DATA_EN));
 
 	/*  2010/08/26 MH Merge from 8192CE. */
 	if (pwrctrlpriv->rf_pwrstate == rf_on) {
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index f399a7fd8b97..7d62f1f3d26e 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -103,16 +103,21 @@ int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data)
 	return usb_read(intf, value, data, 1);
 }
 
-u16 rtw_read16(struct adapter *adapter, u32 addr)
+int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	__le16 data;
+	__le16 le_data;
+	int res;
 
-	usb_read(intf, value, &data, 2);
+	res = usb_read(intf, value, &le_data, 2);
+	if (res)
+		return res;
 
-	return le16_to_cpu(data);
+	*data = le16_to_cpu(le_data);
+
+	return 0;
 }
 
 u32 rtw_read32(struct adapter *adapter, u32 addr)
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 1198d3850a6d..ce3369e33d66 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -221,7 +221,7 @@ void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 int __must_check rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
-u16 rtw_read16(struct adapter *adapter, u32 addr);
+int __must_check rtw_read16(struct adapter *adapter, u32 addr, u16 *data);
 u32 rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 rtw_read_port(struct adapter *adapter, u8 *pmem);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 6e5ee2a74ee4..6ed1439b940c 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3348,6 +3348,7 @@ static int rtw_dbg_port(struct net_device *dev,
 
 			/* FIXME: is this read necessary? */
 			res = rtw_read8(padapter, reg, &val8);
+			(void)res;
 		}
 			break;
 
@@ -3356,8 +3357,8 @@ static int rtw_dbg_port(struct net_device *dev,
 			u16 reg = arg;
 			u16 start_value = 200;
 			u32 write_num = extra_arg;
-
-			int i;
+			u16 val16;
+			int i, res;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3371,7 +3372,9 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			rtw_read16(padapter, reg);
+			/* FIXME: is this read necessary? */
+			res = rtw_read16(padapter, reg, &val16);
+			(void)res;
 		}
 			break;
 		case 0x08: /* continuous write dword test */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 891c85b088ca..d9325ef6ac28 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -740,12 +740,16 @@ static void rtw_fifo_cleanup(struct adapter *adapter)
 {
 	struct pwrctrl_priv *pwrpriv = &adapter->pwrctrlpriv;
 	u8 trycnt = 100;
+	int res;
 
 	/* pause tx */
 	rtw_write8(adapter, REG_TXPAUSE, 0xff);
 
 	/* keep sn */
-	adapter->xmitpriv.nqos_ssn = rtw_read16(adapter, REG_NQOS_SEQ);
+	/* FIXME: return an error to caller */
+	res = rtw_read16(adapter, REG_NQOS_SEQ, &adapter->xmitpriv.nqos_ssn);
+	if (res)
+		return;
 
 	if (!pwrpriv->bkeepfwalive) {
 		/* RX DMA stop */
-- 
2.36.1

