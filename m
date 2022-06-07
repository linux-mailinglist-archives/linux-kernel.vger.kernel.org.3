Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC36553EEB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiFFThO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiFFThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:37:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA96B84A2D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:37:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v9so16838439lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oI4V46VS55pBzT3fiLt9MvPf1vZu4NgtctcCu2LV5hQ=;
        b=IV8xp0Ndp53Z8Srqwn3rNP8dWUtc9nZFovJitTGzvOEe3iNMPGrHhocRHm+MUypm4P
         knJADwPRjfslXhuZuzj2HMYE3/0hK7d+W8i62U7SXQviIQF4GWwbq/i/0GOlb/F8UOSi
         YQElB+ARwL//Be1NiItr5syvebOW1JvxRQo1c0Xb2SpjECKgNYp/FhOkZKA0uNg+5dEA
         OKeF5aFYrSzdg9PEEwfvimL1tstvS89sYYRsRYKOGes19YQLf/PBNxwRBBH6jfOXc8iC
         DLGp7KF9wbVimjHLkOrysFDhdJj7fT2+XkAL8var6LcgxXy+/ajgGn5liAOoQ4g+uy9B
         seUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oI4V46VS55pBzT3fiLt9MvPf1vZu4NgtctcCu2LV5hQ=;
        b=d8954/Io9aabavH6IGSJ0zx2a1XWOT7o3a3tF3VjS51qhrwKy1V1owmCwf+gcXPzBI
         bkVfKsgCQOR1MOnyWiJmnn+XmU0VrBI900yIbr+laPiYk+wMqh83biYU7heXMEaNzmrr
         C6yaZzUpRcEyS3nMKKR1AcHif0ktTQKkLsRBsRnqpjFzZHijydP7n3nUEEb28IMHEKUG
         MWfxXnvFapEVq9z3b98kzMNBWtjGMOlvV2c7TSLScXjYYwWk0lLe6YLmXTCnIGCdYecL
         tOLcAfQsVYKZJ7JZ5TcTKIl8mxfSRqkC+mHgrsWb6VSBvEPf0xDeJ7VclEAy4H5DZn3s
         FUuw==
X-Gm-Message-State: AOAM53312qW1VRWd3TZUf3DqtoI1vW+8vwjw33iq6xKEjnPBnDSSiU+6
        OyEpFbsUWeoR8EP7QQUcOY0=
X-Google-Smtp-Source: ABdhPJxekdIM23cVH4ltz9Lz6avUzfPPr2yhnTc1rdkvOjnPkU89WygATBfb09NTC5ik2ZKCsBKttw==
X-Received: by 2002:a2e:9cda:0:b0:255:6bfd:3bd with SMTP id g26-20020a2e9cda000000b002556bfd03bdmr15034322ljj.302.1654544222112;
        Mon, 06 Jun 2022 12:37:02 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id d26-20020a194f1a000000b0047862287498sm2636001lfb.208.2022.06.06.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:37:01 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 2/4] staging: r8188eu: add error handling of rtw_read16
Date:   Mon,  6 Jun 2022 22:37:00 +0300
Message-Id: <cc5f2312944ffb7ccce572600eb32151b3dd2d88.1654543286.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654543286.git.paskripkin@gmail.com>
References: <cover.1654543286.git.paskripkin@gmail.com>
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
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 29 +++++++++++++++----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  8 +++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 27 ++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 13 ++++++---
 drivers/staging/r8188eu/include/rtw_io.h      |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  9 ++++--
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  6 +++-
 7 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index e67ecbd1ba79..8215ed8b506d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -200,7 +200,8 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	kfree(eFuseWord);
 }
 
-static void efuse_read_phymap_from_txpktbuf(
+/* FIXME: add error handling in callers */
+static int efuse_read_phymap_from_txpktbuf(
 	struct adapter  *adapter,
 	int bcnhead,	/* beacon head, where FW store len(2-byte) and efuse physical map. */
 	u8 *content,	/* buffer to store efuse physical map */
@@ -219,7 +220,7 @@ static void efuse_read_phymap_from_txpktbuf(
 	if (bcnhead < 0) { /* if not valid */
 		res = rtw_read8(adapter, REG_TDECTRL + 1, &reg);
 		if (res)
-			return;
+			return res;
 
 		bcnhead = reg;
 	}
@@ -249,11 +250,15 @@ static void efuse_read_phymap_from_txpktbuf(
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
+			if (res)
+				return res;
 
 			len = le32_to_cpu(lo32) & 0x0000ffff;
 
@@ -280,6 +285,8 @@ static void efuse_read_phymap_from_txpktbuf(
 	}
 	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, DISABLE_TRXPKT_BUF_ACCESS);
 	*size = count;
+
+	return 0;
 }
 
 static s32 iol_read_efuse(struct adapter *padapter, u8 txpktbuf_bndy, u16 offset, u16 size_byte, u8 *logical_map)
@@ -355,25 +362,35 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_frame *xmit
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
index 01422d548748..e7b51b427e8f 100644
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
@@ -640,7 +652,10 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
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
 
@@ -713,7 +728,11 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
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
index 168f4ec99a03..30aa2a2c0ade 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3349,6 +3349,7 @@ static int rtw_dbg_port(struct net_device *dev,
 
 			/* FIXME: is this read necessary? */
 			res = rtw_read8(padapter, reg, &val8);
+			(void)res;
 		}
 			break;
 
@@ -3357,8 +3358,8 @@ static int rtw_dbg_port(struct net_device *dev,
 			u16 reg = arg;
 			u16 start_value = 200;
 			u32 write_num = extra_arg;
-
-			int i;
+			u16 val16;
+			int i, res;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -3372,7 +3373,9 @@ static int rtw_dbg_port(struct net_device *dev,
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

