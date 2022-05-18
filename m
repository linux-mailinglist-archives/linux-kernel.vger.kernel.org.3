Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887D252C603
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiERWMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiERWMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:12:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B8126999
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:12:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w14so5907174lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dc/njpnQDwmDxaEnDRY1YMHC0MJdNjkPpzUo4YNvYH4=;
        b=EtwRx/AquV/EwG+N+1Jo9phAF7sTMFMMKZ7P3UZ8AN2aFbm5ISpLO1WE9U6t4c4sK2
         mpc6FQtvSt/BXliXjRk2Tk5ukeofrcF7X0ZJ3poga+Z2r45iFja/VlEbTllAXcEmDfBw
         FqmJ3ir9AXGTVHqo2VA3uC49n/OHgBE1DzQnFW4VgZcAxFS8tHKIN7uQ2ZY//pDKjIdR
         J4f0C3ACzeCjOraXUfV8XfDCWdm738JBJytKrIPQLPbmDvU8o7S/EioCNPj4/CwSiclp
         vJlpa1Yd/29ElC9jgLLpoh/ZI05Ceq+RdtXGUoNUvM0f7nSAnXCpIPEFF+AjidtvNAFy
         9kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dc/njpnQDwmDxaEnDRY1YMHC0MJdNjkPpzUo4YNvYH4=;
        b=eeUpxdXWKcVPg7Mvy+E2ttBjRiVvdf+D6dWKHWW8bMNQnE7C9Mf8tT84dgg3MIrCNI
         yM1OS8mSJmZ4wqU4tzbgeTiQ2EQXNBt36uyt9TAzTIlPEgxlpRGzP4TvXjjq6R5IuzW1
         UsgmVmnyRube0ctQd1Q26fjwwKS0F4tSmP3ewJProomypt9RxU5J+UxTFmWPHOEzPtSx
         6ByJPZ0WmWzGeGSaEEuZJgFFE8vp4lN7ffebV69N1nUd31ltt9Xt3cxLehM5kUH6srGQ
         hfBFiqIJsOUzPWuBRck4qKt7Z4mSJbcpfogXlDlUl0mErwXkj5QJqtutSsOhtDhON3VC
         pYrQ==
X-Gm-Message-State: AOAM533RsYsYHN1QwaNAxAo7ZhaAmzu/yx4QZZSh1rp/8TZlA+HILuoP
        kvYkUm4aOXnQgPFk8ye2+7Q=
X-Google-Smtp-Source: ABdhPJwRkjy5KU1rdWHUYMdiVBiZlyA9Ml0GnEHaCg4m2r2r23tYNMCVjdhcDZc4zPJiqTzWvklZlw==
X-Received: by 2002:a05:6512:10cf:b0:473:b735:4fae with SMTP id k15-20020a05651210cf00b00473b7354faemr1081241lfg.93.1652911919230;
        Wed, 18 May 2022 15:11:59 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id y17-20020ac24471000000b0047255d21205sm63006lfl.308.2022.05.18.15.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:11:58 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com, fmdefrancesco@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: add error handling of rtw_read16
Date:   Thu, 19 May 2022 01:11:56 +0300
Message-Id: <fae229ad24be682407c85fb25ea1ce4d79d83fcd.1652911343.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1652911343.git.paskripkin@gmail.com>
References: <cover.1652911343.git.paskripkin@gmail.com>
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
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 21 ++++++++++++---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  8 ++++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 27 ++++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 13 ++++++---
 drivers/staging/r8188eu/include/rtw_io.h      |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 11 +++++---
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  6 ++++-
 7 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index e67ecbd1ba79..22661c66cc18 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -249,11 +249,14 @@ static void efuse_read_phymap_from_txpktbuf(
 		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
 
 		if (i == 0) {
+			int res;
+			u16 reg;
 			/* Although lenc is only used in a debug statement,
 			 * do not remove it as the rtw_read16() call consumes
 			 * 2 bytes from the EEPROM source.
 			 */
-			rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
+			res = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L, &reg);
+			(void) res;
 
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
index 6e3c8af5c4e7..1a68e4f19dc2 100644
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
@@ -630,7 +642,10 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
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
 
@@ -703,7 +718,11 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
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
index 66aac2cbe3a9..1b35951a53cb 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1919,7 +1919,10 @@ static int rtw_wx_read32(struct net_device *dev,
 		sprintf(extra, "0x%02X", data32 & 0xff);
 		break;
 	case 2:
-		data32 = rtw_read16(padapter, addr);
+		ret = rtw_read16(padapter, addr, (u16 *) &data32);
+		if (ret)
+			goto err_free_ptmp;
+
 		sprintf(extra, "0x%04X", data32);
 		break;
 	case 4:
@@ -3441,8 +3444,9 @@ static int rtw_dbg_port(struct net_device *dev,
 			u16 reg = arg;
 			u16 start_value = 200;
 			u32 write_num = extra_arg;
+			u16 val16;
 
-			int i;
+			int i, res;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3456,7 +3460,8 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0) != _SUCCESS)
 				ret = -EPERM;
 
-			rtw_read16(padapter, reg);
+			/* FIXME: is this read necessary? */
+			res = rtw_read16(padapter, reg, &val16);
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

