Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1820758EA60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiHJKSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHJKSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:18:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072BB6F563;
        Wed, 10 Aug 2022 03:18:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x23so13840813pll.7;
        Wed, 10 Aug 2022 03:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XB+XqKHbpNMS7fnvlhelkSlDSr5r2pbQ+tbkKgP7v+c=;
        b=AYC2RdzGxVPY/FfVdja26JsXpaXU5giPb18iVq/Ui2bIIf6HYvnl9dcNEJrC23qK2d
         0kkvIm4P2lQeA5S92DPXl5bJ/r+7vo6x4SmSjXG1qP4eWdmLoXvQ6Rk88kbAay1x7SVf
         IF022QVmFD2uY+HFLofxz+uD6AmBYdWL0fNrP02noGWx05jFL6tVdgM7w1nHJcyFsQNn
         4KzsBBop9hv4vrv4s1prBaQz+yRcox33rF6LcrhluFDlMNaSE3P2ltI8X0GiaFS4eBBg
         LRaxgddQZ8y1BI4dNjsSt7xDk39OkAjoXkhkAK2Fud1e7JNdOzT7x+3rz4M3YsgfQfj1
         8lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XB+XqKHbpNMS7fnvlhelkSlDSr5r2pbQ+tbkKgP7v+c=;
        b=obN1x35N8Jvk5qjUIujwGbmupPv9nJpkEgRdGxqaePS+Dc7Ig27rWUKWCUda7ruUfW
         pFrHnVN4pszviKxJwBjoFo2jwLvf7e/bNtqzOEsQHL8VkH/nsDHgJHm3d+7kBknfL6uf
         Au2tEIMpU4VEga3akL7GSHhMdghjQhoFHqByPtaGyhO7y6zppW/lu1TN2f9l1TCvXONG
         JQgoc7CgS6h4bHb1KPBEggt5e06dwec7iBDxEoezSKrD4SC3JJG92eWFFS7YG051kzw0
         ovJ3h4QXqIpRRXZ6RwL99Dg/w1BKwHO6alN5QnaUt9ud+tg+VZsIu9iQu3EJ/mP8kQok
         pM0w==
X-Gm-Message-State: ACgBeo2KiZxA0lPKlXegOyrZMSUSKYUKbHN0blSJF78Rirp+5MZDjdxw
        P/SN7Nz997VycwlBMUlNO5s=
X-Google-Smtp-Source: AA6agR4eWDA14qJ3bh3ygXze00gIyn+w2HIqklz+mg4yOVJchQczP360bEpp2jU9lvdIlENEGc+V0w==
X-Received: by 2002:a17:902:d54f:b0:16f:843d:efcb with SMTP id z15-20020a170902d54f00b0016f843defcbmr27020383plf.55.1660126680391;
        Wed, 10 Aug 2022 03:18:00 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id g74-20020a62524d000000b0052d40c4c06esm1542201pfb.39.2022.08.10.03.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:18:00 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw, Szuying Chen <chensiying21@gmail.com>
Subject: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Date:   Wed, 10 Aug 2022 18:17:43 +0800
Message-Id: <20220810101743.11214-1-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch add tb_nvm_quirks() contain an array that has functions
pointers to tb_nvm_vendor_apply().
And tb_nvm_vendor_apply() that recognize supported vendor works in one
of the following cases:
Case NvmUpgradeSuppport: enable nvm's attribute by setting
no_nvm_upgrade flag to create nvm_authenticate file node.
Case NvmAdd:add active/non-active NVM devices.
Case NvmWrite:update firmware to non-ative NVM device.

Signed-off-by: Szuying Chen <chensiying21@gmail.com>
---
 drivers/thunderbolt/nvm.c    | 59 ++++++++++++++----------------------
 drivers/thunderbolt/switch.c | 19 +++++++-----
 drivers/thunderbolt/tb.h     | 18 +++++++----
 3 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index d5f283889da8..2aae8b3fa5dc 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -14,6 +14,7 @@
 #include "tb.h"

 static DEFINE_IDA(nvm_ida);
+
 static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
 			      size_t bytes)
 {
@@ -22,7 +23,6 @@ static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
 	int ret;

 	pm_runtime_get_sync(&sw->dev);
-
 	if (!mutex_trylock(&sw->tb->lock)) {
 		ret = restart_syscall();
 		goto out;
@@ -60,22 +60,23 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
 	return ret;
 }

 Refer to thunderbolt source: switch.c.

-static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
+static int asm_nvm_apply(struct tb_switch *sw, unsigned int handle)
 {
+	struct tb_nvm *nvm;
+	u32 val;
+	u32 nvm_size;
 	int ret = 0;
+	unsigned int image_size;
+	const u8 *buf = sw->nvm->buf;

 	switch (handle) {
-	case 0:
+	case NvmUpgradeSuppport:
 		if (sw->no_nvm_upgrade)
 			sw->no_nvm_upgrade = false;

 		break;

-	case 1:
-		struct tb_nvm *nvm;
-		u32 val;
-		u32 nvm_size;
-
+	case NvmAdd:
 		nvm = tb_nvm_alloc(&sw->dev);
 		if (IS_ERR(nvm)) {
 			ret = PTR_ERR(nvm);
@@ -86,13 +87,13 @@ static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
 		if (ret)
 			break;

-		nvm->vendor.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
+		nvm->nvm_asm.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
 		ret = usb4_switch_nvm_read(sw, NVM_CUSTOMER_ID, &val, sizeof(val));
 		if (ret)
 			break;

-		nvm->vendor.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
-		nvm->vendor.version = (u8)(val >> 0x10);
+		nvm->nvm_asm.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
+		nvm->nvm_asm.version = (u8)(val >> 0x10);
 		nvm_size = SZ_512K;
 		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
 		if (ret)
@@ -105,10 +106,7 @@ static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
 		sw->nvm = nvm;
 		break;

-	case 2:
-		unsigned int image_size;
-		const u8 *buf = sw->nvm->buf;
-
+	case NvmWrite:
 		if (!buf) {
 			ret = -EINVAL;
 			break;
@@ -128,7 +126,7 @@ static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
 		break;
 	}

-	if ((handle == 1) && (ret != 0))
+	if ((handle == NvmAdd) && (ret != 0))
 		tb_nvm_free(sw->nvm);

 	return ret;
@@ -136,45 +134,32 @@ static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)

 struct tb_nvm_id {
 	u16 hw_vendor_id;
-	u16 hw_device_id;
-	u16 vendor;
-	u16 device;
 	int (*hook)(struct tb_switch *sw, unsigned int handle);
 };

 static const struct tb_nvm_id tb_nvm_vendors[] = {
 	/* ASMedia software CM firmware upgrade */
-	{ 0x174c, 0x2428, 0x174c, 0x0009, tb_nvm_vendor_apply },
+	{ 0x174c, asm_nvm_apply },
 };

 /**
- * tb_nvm_quirks() - support vendor's NVM format
+ * tb_nvm_vendor_handle() - support vendor's NVM format
  * @sw: Thunderbolt switch
+ * @handle: 0:NvmUpgradeSuppport, 1:NvmAdd, 2:NvmWrite
  */
-int tb_nvm_quirks(struct tb_switch *sw, unsigned int handle)
+int tb_nvm_vendor_handle(struct tb_switch *sw, unsigned int handle)
 {
 	int res, i;
-	bool NoVendor = true;

 	for (i = 0; i < ARRAY_SIZE(tb_nvm_vendors); i++) {
-		const struct tb_nvm_id *q = &tb_nvm_vendors[i];
+		const struct tb_nvm_id *id = &tb_nvm_vendors[i];

-		if (q->hw_vendor_id && q->hw_vendor_id != sw->config.vendor_id)
-			continue;
-		if (q->hw_device_id && q->hw_device_id != sw->config.device_id)
-			continue;
-		if (q->vendor && q->vendor != sw->vendor)
-			continue;
-		if (q->device && q->device != sw->device)
+		if (id->hw_vendor_id && id->hw_vendor_id != sw->config.vendor_id)
 			continue;

-		 res = q->hook(sw, handle);
-		 NoVendor = false;
+		 res = id->hook(sw, handle);
 	}
-	if (NoVendor)
-		return -ENODEV;
-	else
-		return res;
+	return res;
 }

 /**
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a654b6951bef..8fa9efa8a900 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -114,8 +114,12 @@ static int nvm_validate_and_write(struct tb_switch *sw)
 	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
 		return -EINVAL;

-	ret = tb_nvm_quirks(sw, 2);
-	if (ret != -ENODEV)
+	/*
+	 * Vendor's nvm write. If the image has been flushed to the
+	 * storage are, nvm write is complete.
+	 */
+	ret = tb_nvm_vendor_handle(sw, NvmWrite);
+	if (sw->nvm->flushed)
 		return ret;

 	/*
@@ -394,9 +398,9 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
 	if (!nvm_readable(sw))
 		return 0;

-	/* Vendor's NVM formats definition */
-	ret = tb_nvm_quirks(sw, 1);
-	if (ret != -ENODEV)
+	/* Vendor's NVM formats add */
+	ret = tb_nvm_vendor_handle(sw, NvmAdd);
+	if (ret)
 		return ret;

 	/*
@@ -1962,8 +1966,9 @@ static ssize_t nvm_version_show(struct device *dev,
 		ret = -ENODATA;
 	else if (!sw->nvm)
 		ret = -EAGAIN;
+	/*ASMedia NVM version show format xxxxxx_xxxx_xx */
 	else if (sw->config.vendor_id == 0x174C)
-		ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->vendor.date, sw->nvm->vendor.customerID, sw->nvm->vendor.version);
+		ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->nvm_asm.date, sw->nvm->nvm_asm.customerID, sw->nvm->nvm_asm.version);
 	else
 		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);

@@ -2871,7 +2876,7 @@ int tb_switch_add(struct tb_switch *sw)
 		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);

 		tb_check_quirks(sw);
-		tb_nvm_quirks(sw, 0);
+		tb_nvm_vendor_handle(sw, NvmUpgradeSuppport);

 		ret = tb_switch_set_uuid(sw);
 		if (ret) {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 9dd1ba7b07b6..a8dd0ae04741 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -31,10 +31,16 @@
 #define NVM_Date	0x1C
 #define NVM_CUSTOMER_ID	0x28

-struct tb_nvm_vendor {
-	int	date;
-	u16	customerID;
-	u8	version;
+/* ASMedia specific NVM handle */
+#define NvmUpgradeSuppport 0
+#define NvmAdd 1
+#define NvmWrite 2
+
+struct nvm_asmedia {
+	u32 date;
+	u32 customerID:16;
+	u32 version:8;
+	u32 reserved:8;
 };

 /**
@@ -66,7 +72,7 @@ struct tb_nvm {
 	size_t buf_data_size;
 	bool authenticating;
 	bool flushed;
-	struct tb_nvm_vendor vendor;
+	struct nvm_asmedia nvm_asm;
 };

 enum tb_nvm_write_ops {
@@ -746,7 +752,7 @@ static inline void tb_domain_put(struct tb *tb)
 	put_device(&tb->dev);
 }

-int tb_nvm_quirks(struct tb_switch *sw, unsigned int handle);
+int tb_nvm_vendor_handle(struct tb_switch *sw, unsigned int handle);
 struct tb_nvm *tb_nvm_alloc(struct device *dev);
 int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
 int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
--
2.34.1

