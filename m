Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC64875B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiAGKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346860AbiAGKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EDEC03400C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a18so19434135edj.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMYHWqCFSH9M/uizkfIzNZgu9MmKxED7nCPx2gMesWg=;
        b=Mdej9xRgxUffx1/Lbpnp/wbrLqclCX0aUH7xhf9Nn9fbTxC6zFwyDchzUUyvOr+yYj
         4RR/bKNKTrjnMU7itOHDJQTPLoaGUCst0z3cLJwxIHPJYx0iKGk86BsMGAVvrBUTEGCI
         FtH4HtA77+WUIMpnYMbL8d/5+aCs4Hk1xcNegBo0ecSQQvks0eE5LoTtuF+iCNKSqE1i
         eygM26Jmi/AyhIiSmIWYoigOIwpzt81gLtyLy0vOQ1yQksuyml66sOGQqayP1Ec04916
         1mmZDLQRQRGAuMNTRJcgEsTUbPQlFtwmXn9lFp6BCOblaDxda+/iH1NQ788Z6SGxcKyf
         QrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMYHWqCFSH9M/uizkfIzNZgu9MmKxED7nCPx2gMesWg=;
        b=os2F9jVInpYyoxGd1oPbIR9zom7lMs6PY3z1OZqL3FM48502YlEawmacKD6TE4hfMk
         DQfZfsCXjB7SgQ//KQR3VGQdotJXk2IIxDBxkRZrAQC6mGgOQxsMwbXbDnASWGTsJHx9
         DX9UlSxLUTFe6uYh5GBXp0oPCuIZTX+kVfmB/SDPwO4GHBt8bgb4wyDiGjiS5RoybMWg
         oehVOEwRbzQCFCD7xQtYV+hG07M0x6QjASKoofDHWg0YOt9P+M3mTGCZmt/aJTzu4DfQ
         MfrgwxqcHQTUK/6glhYMWuCpoPcLYpjKCKLiAZ3kiqWXYwA/cAWmZv5l5pxWXp2bUSH+
         4nXg==
X-Gm-Message-State: AOAM531ARf8QHpBHOhtmAh9yw3bGmuqOXG1HLkBD9duGxcHBM9nhrfur
        xqbcr7eKtXYmzlVmx1s5060=
X-Google-Smtp-Source: ABdhPJwXdZneFaSLKKKYRnHJ1WQJ2LnMSRKuj3G2OSLOA2Kygap/esVigPY6s2599mg61hIIAemQgg==
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr61923238eda.287.1641551801543;
        Fri, 07 Jan 2022 02:36:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:41 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 19/19] staging: r8188eu: move firmware loading code out of the hal layer
Date:   Fri,  7 Jan 2022 11:36:20 +0100
Message-Id: <20220107103620.15648-20-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the firmware loading functions from rtl8188e_hal_init.c into the
new file core/rtw_fw.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/Makefile              |   1 +
 drivers/staging/r8188eu/core/rtw_fw.c         | 284 ++++++++++++++++++
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 283 +----------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   2 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |   4 -
 drivers/staging/r8188eu/include/rtw_fw.h      |  14 +
 6 files changed, 301 insertions(+), 287 deletions(-)
 create mode 100644 drivers/staging/r8188eu/core/rtw_fw.c
 create mode 100644 drivers/staging/r8188eu/include/rtw_fw.h

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index a7a486cc16dd..84627fc89ec9 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -37,6 +37,7 @@ r8188eu-y = \
 		core/rtw_br_ext.o \
 		core/rtw_cmd.o \
 		core/rtw_efuse.o \
+		core/rtw_fw.o \
 		core/rtw_ieee80211.o \
 		core/rtw_ioctl_set.o \
 		core/rtw_iol.o \
diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
new file mode 100644
index 000000000000..fa29d47bf165
--- /dev/null
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
+#include <linux/firmware.h>
+#include "../include/rtw_fw.h"
+
+static void fw_download_enable(struct adapter *padapter, bool enable)
+{
+	u8 tmp;
+
+	if (enable) {
+		/*  MCU firmware download enable. */
+		tmp = rtw_read8(padapter, REG_MCUFWDL);
+		rtw_write8(padapter, REG_MCUFWDL, tmp | 0x01);
+
+		/*  8051 reset */
+		tmp = rtw_read8(padapter, REG_MCUFWDL + 2);
+		rtw_write8(padapter, REG_MCUFWDL + 2, tmp & 0xf7);
+	} else {
+		/*  MCU firmware download disable. */
+		tmp = rtw_read8(padapter, REG_MCUFWDL);
+		rtw_write8(padapter, REG_MCUFWDL, tmp & 0xfe);
+
+		/*  Reserved for fw extension. */
+		rtw_write8(padapter, REG_MCUFWDL + 1, 0x00);
+	}
+}
+
+static int block_write(struct adapter *padapter, void *buffer, u32 buffSize)
+{
+	int ret = _SUCCESS;
+	u32	blockSize_p1 = 4;	/*  (Default) Phase #1 : PCI muse use 4-byte write to download FW */
+	u32	blockSize_p2 = 8;	/*  Phase #2 : Use 8-byte, if Phase#1 use big size to write FW. */
+	u32	blockSize_p3 = 1;	/*  Phase #3 : Use 1-byte, the remnant of FW image. */
+	u32	blockCount_p1 = 0, blockCount_p2 = 0, blockCount_p3 = 0;
+	u32	remainSize_p1 = 0, remainSize_p2 = 0;
+	u8 *bufferPtr	= (u8 *)buffer;
+	u32	i = 0, offset = 0;
+
+	blockSize_p1 = MAX_REG_BOLCK_SIZE;
+
+	/* 3 Phase #1 */
+	blockCount_p1 = buffSize / blockSize_p1;
+	remainSize_p1 = buffSize % blockSize_p1;
+
+	for (i = 0; i < blockCount_p1; i++) {
+		ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + i * blockSize_p1), blockSize_p1, (bufferPtr + i * blockSize_p1));
+		if (ret == _FAIL)
+			goto exit;
+	}
+
+	/* 3 Phase #2 */
+	if (remainSize_p1) {
+		offset = blockCount_p1 * blockSize_p1;
+
+		blockCount_p2 = remainSize_p1 / blockSize_p2;
+		remainSize_p2 = remainSize_p1 % blockSize_p2;
+
+		for (i = 0; i < blockCount_p2; i++) {
+			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i * blockSize_p2), blockSize_p2, (bufferPtr + offset + i * blockSize_p2));
+
+			if (ret == _FAIL)
+				goto exit;
+		}
+	}
+
+	/* 3 Phase #3 */
+	if (remainSize_p2) {
+		offset = (blockCount_p1 * blockSize_p1) + (blockCount_p2 * blockSize_p2);
+
+		blockCount_p3 = remainSize_p2 / blockSize_p3;
+
+		for (i = 0; i < blockCount_p3; i++) {
+			ret = rtw_write8(padapter, (FW_8188E_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
+
+			if (ret == _FAIL)
+				goto exit;
+		}
+	}
+
+exit:
+	return ret;
+}
+
+static int page_write(struct adapter *padapter, u32 page, void *buffer, u32 size)
+{
+	u8 value8;
+	u8 u8Page = (u8)(page & 0x07);
+
+	value8 = (rtw_read8(padapter, REG_MCUFWDL + 2) & 0xF8) | u8Page;
+	rtw_write8(padapter, REG_MCUFWDL + 2, value8);
+
+	return block_write(padapter, buffer, size);
+}
+
+static int write_fw(struct adapter *padapter, void *buffer, u32 size)
+{
+	/*  Since we need dynamic decide method of dwonload fw, so we call this function to get chip version. */
+	/*  We can remove _ReadChipVersion from ReadpadapterInfo8192C later. */
+	int ret = _SUCCESS;
+	u32	pageNums, remainSize;
+	u32	page, offset;
+	u8 *bufferPtr = (u8 *)buffer;
+
+	pageNums = size / MAX_PAGE_SIZE;
+	remainSize = size % MAX_PAGE_SIZE;
+
+	for (page = 0; page < pageNums; page++) {
+		offset = page * MAX_PAGE_SIZE;
+		ret = page_write(padapter, page, bufferPtr + offset, MAX_PAGE_SIZE);
+
+		if (ret == _FAIL)
+			goto exit;
+	}
+	if (remainSize) {
+		offset = pageNums * MAX_PAGE_SIZE;
+		page = pageNums;
+		ret = page_write(padapter, page, bufferPtr + offset, remainSize);
+
+		if (ret == _FAIL)
+			goto exit;
+	}
+exit:
+	return ret;
+}
+
+void rtw_reset_8051(struct adapter *padapter)
+{
+	u8 val8;
+
+	val8 = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
+	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 & (~BIT(2)));
+	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 | (BIT(2)));
+}
+
+static int fw_free_to_go(struct adapter *padapter)
+{
+	u32	counter = 0;
+	u32	value32;
+
+	/*  polling CheckSum report */
+	do {
+		value32 = rtw_read32(padapter, REG_MCUFWDL);
+		if (value32 & FWDL_CHKSUM_RPT)
+			break;
+	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
+
+	if (counter >= POLLING_READY_TIMEOUT_COUNT) {
+		DBG_88E("%s: chksum report fail! REG_MCUFWDL:0x%08x\n", __func__, value32);
+		return _FAIL;
+	}
+	DBG_88E("%s: Checksum report OK! REG_MCUFWDL:0x%08x\n", __func__, value32);
+
+	value32 = rtw_read32(padapter, REG_MCUFWDL);
+	value32 |= MCUFWDL_RDY;
+	value32 &= ~WINTINI_RDY;
+	rtw_write32(padapter, REG_MCUFWDL, value32);
+
+	rtw_reset_8051(padapter);
+
+	/*  polling for FW ready */
+	counter = 0;
+	do {
+		value32 = rtw_read32(padapter, REG_MCUFWDL);
+		if (value32 & WINTINI_RDY) {
+			DBG_88E("%s: Polling FW ready success!! REG_MCUFWDL:0x%08x\n", __func__, value32);
+			return _SUCCESS;
+		}
+		udelay(5);
+	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
+
+	DBG_88E("%s: Polling FW ready fail!! REG_MCUFWDL:0x%08x\n", __func__, value32);
+	return _FAIL;
+}
+
+static int load_firmware(struct rt_firmware *rtfw, struct device *device)
+{
+	int ret = _SUCCESS;
+	const struct firmware *fw;
+	const char *fw_name = "rtlwifi/rtl8188eufw.bin";
+	int err = request_firmware(&fw, fw_name, device);
+
+	if (err) {
+		pr_err("Request firmware failed with error 0x%x\n", err);
+		ret = _FAIL;
+		goto exit;
+	}
+	if (!fw) {
+		pr_err("Firmware %s not available\n", fw_name);
+		ret = _FAIL;
+		goto exit;
+	}
+
+	rtfw->data = kmemdup(fw->data, fw->size, GFP_KERNEL);
+	if (!rtfw->data) {
+		pr_err("Failed to allocate rtfw->data\n");
+		ret = _FAIL;
+		goto exit;
+	}
+	rtfw->size = fw->size;
+	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", rtfw->size);
+
+exit:
+	release_firmware(fw);
+	return ret;
+}
+
+int rtl8188e_firmware_download(struct adapter *padapter)
+{
+	int ret = _SUCCESS;
+	u8 write_fw_retry = 0;
+	u32 fwdl_start_time;
+	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
+	struct device *device = dvobj_to_dev(dvobj);
+	struct rt_firmware_hdr *fwhdr = NULL;
+	u16 fw_version, fw_subversion, fw_signature;
+	u8 *fw_data;
+	u32 fw_size;
+	static int log_version;
+
+	if (!dvobj->firmware.data)
+		ret = load_firmware(&dvobj->firmware, device);
+	if (ret == _FAIL) {
+		dvobj->firmware.data = NULL;
+		goto exit;
+	}
+	fw_data = dvobj->firmware.data;
+	fw_size = dvobj->firmware.size;
+
+	/*  To Check Fw header. Added by tynli. 2009.12.04. */
+	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
+
+	fw_version = le16_to_cpu(fwhdr->Version);
+	fw_subversion = fwhdr->Subversion;
+	fw_signature = le16_to_cpu(fwhdr->Signature);
+
+	if (!log_version++)
+		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
+			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
+
+	if (IS_FW_HEADER_EXIST(fwhdr)) {
+		/*  Shift 32 bytes for FW header */
+		fw_data = fw_data + 32;
+		fw_size = fw_size - 32;
+	}
+
+	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
+	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
+	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
+		rtw_write8(padapter, REG_MCUFWDL, 0x00);
+		rtw_reset_8051(padapter);
+	}
+
+	fw_download_enable(padapter, true);
+	fwdl_start_time = jiffies;
+	while (1) {
+		/* reset the FWDL chksum */
+		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
+
+		ret = write_fw(padapter, fw_data, fw_size);
+
+		if (ret == _SUCCESS ||
+		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && write_fw_retry++ >= 3))
+			break;
+
+		DBG_88E("%s write_fw_retry:%u, time after fwdl_start_time:%ums\n",
+			__func__, write_fw_retry, rtw_get_passing_time_ms(fwdl_start_time)
+		);
+	}
+	fw_download_enable(padapter, false);
+	if (ret != _SUCCESS) {
+		DBG_88E("DL Firmware failed!\n");
+		goto exit;
+	}
+
+	ret = fw_free_to_go(padapter);
+	if (ret != _SUCCESS) {
+		DBG_88E("DL Firmware failed!\n");
+		goto exit;
+	}
+
+exit:
+	return ret;
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 3c9ddbe16754..dd89973928cf 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -3,12 +3,12 @@
 
 #define _HAL_INIT_C_
 
-#include "../include/linux/firmware.h"
 #include "../include/drv_types.h"
 #include "../include/rtw_efuse.h"
 #include "../include/rtl8188e_hal.h"
 #include "../include/rtw_iol.h"
 #include "../include/usb_ops.h"
+#include "../include/rtw_fw.h"
 
 static void iol_mode_enable(struct adapter *padapter, u8 enable)
 {
@@ -336,287 +336,6 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_frame *xmit
 	return ret;
 }
 
-static void fw_download_enable(struct adapter *padapter, bool enable)
-{
-	u8 tmp;
-
-	if (enable) {
-		/*  MCU firmware download enable. */
-		tmp = rtw_read8(padapter, REG_MCUFWDL);
-		rtw_write8(padapter, REG_MCUFWDL, tmp | 0x01);
-
-		/*  8051 reset */
-		tmp = rtw_read8(padapter, REG_MCUFWDL + 2);
-		rtw_write8(padapter, REG_MCUFWDL + 2, tmp & 0xf7);
-	} else {
-		/*  MCU firmware download disable. */
-		tmp = rtw_read8(padapter, REG_MCUFWDL);
-		rtw_write8(padapter, REG_MCUFWDL, tmp & 0xfe);
-
-		/*  Reserved for fw extension. */
-		rtw_write8(padapter, REG_MCUFWDL + 1, 0x00);
-	}
-}
-
-#define MAX_REG_BOLCK_SIZE	196
-
-static int block_write(struct adapter *padapter, void *buffer, u32 buffSize)
-{
-	int ret = _SUCCESS;
-	u32	blockSize_p1 = 4;	/*  (Default) Phase #1 : PCI muse use 4-byte write to download FW */
-	u32	blockSize_p2 = 8;	/*  Phase #2 : Use 8-byte, if Phase#1 use big size to write FW. */
-	u32	blockSize_p3 = 1;	/*  Phase #3 : Use 1-byte, the remnant of FW image. */
-	u32	blockCount_p1 = 0, blockCount_p2 = 0, blockCount_p3 = 0;
-	u32	remainSize_p1 = 0, remainSize_p2 = 0;
-	u8 *bufferPtr	= (u8 *)buffer;
-	u32	i = 0, offset = 0;
-
-	blockSize_p1 = MAX_REG_BOLCK_SIZE;
-
-	/* 3 Phase #1 */
-	blockCount_p1 = buffSize / blockSize_p1;
-	remainSize_p1 = buffSize % blockSize_p1;
-
-	for (i = 0; i < blockCount_p1; i++) {
-		ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + i * blockSize_p1), blockSize_p1, (bufferPtr + i * blockSize_p1));
-		if (ret == _FAIL)
-			goto exit;
-	}
-
-	/* 3 Phase #2 */
-	if (remainSize_p1) {
-		offset = blockCount_p1 * blockSize_p1;
-
-		blockCount_p2 = remainSize_p1 / blockSize_p2;
-		remainSize_p2 = remainSize_p1 % blockSize_p2;
-
-		for (i = 0; i < blockCount_p2; i++) {
-			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i * blockSize_p2), blockSize_p2, (bufferPtr + offset + i * blockSize_p2));
-
-			if (ret == _FAIL)
-				goto exit;
-		}
-	}
-
-	/* 3 Phase #3 */
-	if (remainSize_p2) {
-		offset = (blockCount_p1 * blockSize_p1) + (blockCount_p2 * blockSize_p2);
-
-		blockCount_p3 = remainSize_p2 / blockSize_p3;
-
-		for (i = 0; i < blockCount_p3; i++) {
-			ret = rtw_write8(padapter, (FW_8188E_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
-
-			if (ret == _FAIL)
-				goto exit;
-		}
-	}
-
-exit:
-	return ret;
-}
-
-static int page_write(struct adapter *padapter, u32 page, void *buffer, u32 size)
-{
-	u8 value8;
-	u8 u8Page = (u8)(page & 0x07);
-
-	value8 = (rtw_read8(padapter, REG_MCUFWDL + 2) & 0xF8) | u8Page;
-	rtw_write8(padapter, REG_MCUFWDL + 2, value8);
-
-	return block_write(padapter, buffer, size);
-}
-
-static int write_fw(struct adapter *padapter, void *buffer, u32 size)
-{
-	/*  Since we need dynamic decide method of dwonload fw, so we call this function to get chip version. */
-	/*  We can remove _ReadChipVersion from ReadpadapterInfo8192C later. */
-	int ret = _SUCCESS;
-	u32	pageNums, remainSize;
-	u32	page, offset;
-	u8 *bufferPtr = (u8 *)buffer;
-
-	pageNums = size / MAX_PAGE_SIZE;
-	remainSize = size % MAX_PAGE_SIZE;
-
-	for (page = 0; page < pageNums; page++) {
-		offset = page * MAX_PAGE_SIZE;
-		ret = page_write(padapter, page, bufferPtr + offset, MAX_PAGE_SIZE);
-
-		if (ret == _FAIL)
-			goto exit;
-	}
-	if (remainSize) {
-		offset = pageNums * MAX_PAGE_SIZE;
-		page = pageNums;
-		ret = page_write(padapter, page, bufferPtr + offset, remainSize);
-
-		if (ret == _FAIL)
-			goto exit;
-	}
-exit:
-	return ret;
-}
-
-void rtw_reset_8051(struct adapter *padapter)
-{
-	u8 val8;
-
-	val8 = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
-	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 & (~BIT(2)));
-	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 | (BIT(2)));
-}
-
-static int fw_free_to_go(struct adapter *padapter)
-{
-	u32	counter = 0;
-	u32	value32;
-
-	/*  polling CheckSum report */
-	do {
-		value32 = rtw_read32(padapter, REG_MCUFWDL);
-		if (value32 & FWDL_CHKSUM_RPT)
-			break;
-	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
-
-	if (counter >= POLLING_READY_TIMEOUT_COUNT) {
-		DBG_88E("%s: chksum report fail! REG_MCUFWDL:0x%08x\n", __func__, value32);
-		return _FAIL;
-	}
-	DBG_88E("%s: Checksum report OK! REG_MCUFWDL:0x%08x\n", __func__, value32);
-
-	value32 = rtw_read32(padapter, REG_MCUFWDL);
-	value32 |= MCUFWDL_RDY;
-	value32 &= ~WINTINI_RDY;
-	rtw_write32(padapter, REG_MCUFWDL, value32);
-
-	rtw_reset_8051(padapter);
-
-	/*  polling for FW ready */
-	counter = 0;
-	do {
-		value32 = rtw_read32(padapter, REG_MCUFWDL);
-		if (value32 & WINTINI_RDY) {
-			DBG_88E("%s: Polling FW ready success!! REG_MCUFWDL:0x%08x\n", __func__, value32);
-			return _SUCCESS;
-		}
-		udelay(5);
-	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
-
-	DBG_88E("%s: Polling FW ready fail!! REG_MCUFWDL:0x%08x\n", __func__, value32);
-	return _FAIL;
-}
-
-static int load_firmware(struct rt_firmware *rtfw, struct device *device)
-{
-	int ret = _SUCCESS;
-	const struct firmware *fw;
-	const char *fw_name = "rtlwifi/rtl8188eufw.bin";
-	int err = request_firmware(&fw, fw_name, device);
-
-	if (err) {
-		pr_err("Request firmware failed with error 0x%x\n", err);
-		ret = _FAIL;
-		goto exit;
-	}
-	if (!fw) {
-		pr_err("Firmware %s not available\n", fw_name);
-		ret = _FAIL;
-		goto exit;
-	}
-
-	rtfw->data = kmemdup(fw->data, fw->size, GFP_KERNEL);
-	if (!rtfw->data) {
-		pr_err("Failed to allocate rtfw->data\n");
-		ret = _FAIL;
-		goto exit;
-	}
-	rtfw->size = fw->size;
-	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", rtfw->size);
-
-exit:
-	release_firmware(fw);
-	return ret;
-}
-
-int rtl8188e_firmware_download(struct adapter *padapter)
-{
-	int ret = _SUCCESS;
-	u8 write_fw_retry = 0;
-	u32 fwdl_start_time;
-	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
-	struct device *device = dvobj_to_dev(dvobj);
-	struct rt_firmware_hdr *fwhdr = NULL;
-	u16 fw_version, fw_subversion, fw_signature;
-	u8 *fw_data;
-	u32 fw_size;
-	static int log_version;
-
-	if (!dvobj->firmware.data)
-		ret = load_firmware(&dvobj->firmware, device);
-	if (ret == _FAIL) {
-		dvobj->firmware.data = NULL;
-		goto exit;
-	}
-	fw_data = dvobj->firmware.data;
-	fw_size = dvobj->firmware.size;
-
-	/*  To Check Fw header. Added by tynli. 2009.12.04. */
-	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
-
-	fw_version = le16_to_cpu(fwhdr->Version);
-	fw_subversion = fwhdr->Subversion;
-	fw_signature = le16_to_cpu(fwhdr->Signature);
-
-	if (!log_version++)
-		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
-
-	if (IS_FW_HEADER_EXIST(fwhdr)) {
-		/*  Shift 32 bytes for FW header */
-		fw_data = fw_data + 32;
-		fw_size = fw_size - 32;
-	}
-
-	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
-	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
-	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
-		rtw_write8(padapter, REG_MCUFWDL, 0x00);
-		rtw_reset_8051(padapter);
-	}
-
-	fw_download_enable(padapter, true);
-	fwdl_start_time = jiffies;
-	while (1) {
-		/* reset the FWDL chksum */
-		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
-
-		ret = write_fw(padapter, fw_data, fw_size);
-
-		if (ret == _SUCCESS ||
-		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && write_fw_retry++ >= 3))
-			break;
-
-		DBG_88E("%s write_fw_retry:%u, time after fwdl_start_time:%ums\n",
-			__func__, write_fw_retry, rtw_get_passing_time_ms(fwdl_start_time)
-		);
-	}
-	fw_download_enable(padapter, false);
-	if (ret != _SUCCESS) {
-		DBG_88E("DL Firmware failed!\n");
-		goto exit;
-	}
-
-	ret = fw_free_to_go(padapter);
-	if (ret != _SUCCESS) {
-		DBG_88E("DL Firmware failed!\n");
-		goto exit;
-	}
-
-exit:
-	return ret;
-}
-
 /*  */
 /*			Efuse related code */
 /*  */
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 3dc1c432e8cf..fc62019143ba 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -6,7 +6,7 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/rtw_efuse.h"
-
+#include "../include/rtw_fw.h"
 #include "../include/rtl8188e_hal.h"
 #include "../include/rtw_iol.h"
 #include "../include/usb_ops.h"
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 4b67e11024a1..c614faf188bb 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -249,10 +249,6 @@ struct hal_data_8188e {
 	u8	UsbRxAggPageTimeout;
 };
 
-/*  rtl8188e_hal_init.c */
-int rtl8188e_firmware_download(struct adapter *padapter);
-void rtw_reset_8051(struct adapter *padapter);
-
 s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy);
 
 /*  EFuse */
diff --git a/drivers/staging/r8188eu/include/rtw_fw.h b/drivers/staging/r8188eu/include/rtw_fw.h
new file mode 100644
index 000000000000..749157704251
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_fw.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2007 - 2011 Realtek Corporation. */
+
+#ifndef __RTW_FW_H__
+#define __RTW_FW_H__
+
+#include "drv_types.h"
+
+#define MAX_REG_BOLCK_SIZE 196
+
+int rtl8188e_firmware_download(struct adapter *padapter);
+void rtw_reset_8051(struct adapter *padapter);
+
+#endif
-- 
2.34.1

