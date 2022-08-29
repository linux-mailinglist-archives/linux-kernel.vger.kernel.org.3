Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7B95A4997
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiH2L02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiH2LYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:24:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D1D65640;
        Mon, 29 Aug 2022 04:15:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bg22so7697279pjb.2;
        Mon, 29 Aug 2022 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=45g8KLpawTNq0XqaQumJqZXl9LM0ZxYl68pXwMUbeyA=;
        b=T+RCZl6exgRGDtTzN4V1+QPGfnI2WfR7kRIN1LmZEcXEjWQYFFov/8ftXDBvZes7S6
         uT4YgNj4xx7iG24dyjtvq+zF4ziyDnRiSDfEVYgs90R7KsAlAOII/yAajno1YQL8l493
         NgbUEQAAYZzYj8ctAN+VghDckzUjbw4f/jKT8ojQ8MXkyM4MtigaPQ3uI7Gz4xbypX4B
         9p3EiRA7AfYBdI8LK9TTRRfTCf5G/lliPMbb20EyNO/Mer0uoCMp9rcy0Yss8C500q7c
         eixPjIdGiUUegyXhwt5WWFC6nZ7PMYr5CHLKTq6QFQceexD+J7EbWXnFeP/xXRzgjlHr
         oRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=45g8KLpawTNq0XqaQumJqZXl9LM0ZxYl68pXwMUbeyA=;
        b=HogzjmXkfsL1b4j01YxEMf7BN4CbINS/QcgT8vdYFPhmhCN2FFWv1f+0WqFivcwUl5
         YwXaiQ5RhKjSVQgUyUkt+EHFrT/oZdsytfnoPlsmvTq6GIiQdQ8d6fq+NXsBw+huNiZm
         71mIU9sVLZREbzxLDFrFSu6IZLFy5EyN0LqtyxB0kSWu1nKvIFJkEoZl9H1TI95Yn4y1
         jgA+Je4wVat72XUV9/XORkrM7yn3pAMXccYszshZXeR1ZhLj/aB0++OW9p4XMPmKmdVT
         dmFeM7OE83hIQwHFuA+BRSeD3xI9Z4PG7aaTyiso2eO4iqBvB0kYg6/hCxwLgsYrM7Qw
         na+w==
X-Gm-Message-State: ACgBeo0suiWBWUI8VARiQWINobZREN3MZJ9ztGk7/UP4bmW6bZs/NfoD
        wcMm2Npmt+8Cb/0x9YdNKQk=
X-Google-Smtp-Source: AA6agR5XgjkGonT9D0NM2gdeckDN60nRrOh0GcpEtgy7jL/O4GFHsGoFbl+LVukVIEkGdw28Ht4lXw==
X-Received: by 2002:a17:90a:2e0c:b0:1fd:ad5a:21d1 with SMTP id q12-20020a17090a2e0c00b001fdad5a21d1mr7927225pjd.132.1661771646988;
        Mon, 29 Aug 2022 04:14:06 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902680900b0015e8d4eb26esm7177973plk.184.2022.08.29.04.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 04:14:06 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v7 1/3] thunderbolt: Add vendor's specific operations of NVM
Date:   Mon, 29 Aug 2022 19:10:57 +0800
Message-Id: <20220829111059.665305-2-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829111059.665305-1-chensiying21@gmail.com>
References: <20220829111059.665305-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

The patch add tb_switch_nvm_alloc() contain an array that has functions
pointers to vendor_ops that vendor to define.
And moved vendor:intel part of the code to make all the vendors
(includes Intel) support it in nvm.c.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
Fix $subject and add part of kernel-doc.

 drivers/thunderbolt/nvm.c    | 206 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c | 102 +++--------------
 drivers/thunderbolt/tb.h     |   6 +
 3 files changed, 229 insertions(+), 85 deletions(-)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index b3f310389378..91c8848b4d2e 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -12,8 +12,214 @@

 #include "tb.h"

+/* Switch NVM support */
+#define NVM_CSS		0x10
+
 static DEFINE_IDA(nvm_ida);

+/**
+ * struct tb_nvm_vendor_ops - Vendor NVM specific operations
+ * @read_version: Used NVM read get Firmware version.
+ * @validate: Vendors have their validate method before NVM write.
+ */
+struct tb_nvm_vendor_ops {
+	int (*read_version)(struct tb_switch *sw);
+	int (*validate)(struct tb_switch *sw);
+};
+
+static inline int nvm_read(struct tb_switch *sw, unsigned int address,
+			   void *buf, size_t size)
+{
+	if (tb_switch_is_usb4(sw))
+		return usb4_switch_nvm_read(sw, address, buf, size);
+	return dma_port_flash_read(sw->dma_port, address, buf, size);
+}
+
+static int intel_nvm_version(struct tb_switch *sw)
+{
+	struct tb_nvm *nvm = sw->nvm;
+	u32 val;
+	int ret;
+
+	/*
+	 * If the switch is in safe-mode the only accessible portion of
+	 * the NVM is the non-active one where userspace is expected to
+	 * write new functional NVM.
+	 */
+	if (!sw->safe_mode) {
+		u32 nvm_size, hdr_size;
+
+		ret = nvm_read(sw, NVM_FLASH_SIZE, &val, sizeof(val));
+		if (ret)
+			return ret;
+
+		hdr_size = sw->generation < 3 ? SZ_8K : SZ_16K;
+		nvm_size = (SZ_1M << (val & 7)) / 8;
+		nvm_size = (nvm_size - hdr_size) / 2;
+
+		ret = nvm_read(sw, NVM_VERSION, &val, sizeof(val));
+		if (ret)
+			return ret;
+
+		nvm->major = val >> 16;
+		nvm->minor = val >> 8;
+		nvm->nvm_size = nvm_size;
+	}
+
+	return 0;
+}
+
+static int intel_nvm_validate(struct tb_switch *sw)
+{
+	unsigned int image_size, hdr_size;
+	u8 *buf = sw->nvm->buf;
+	u16 ds_size;
+	int ret;
+
+	image_size = sw->nvm->buf_data_size;
+	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
+		return -EINVAL;
+
+	/*
+	 * FARB pointer must point inside the image and must at least
+	 * contain parts of the digital section we will be reading here.
+	 */
+	hdr_size = (*(u32 *)buf) & 0xffffff;
+	if (hdr_size + NVM_DEVID + 2 >= image_size)
+		return -EINVAL;
+
+	/* Digital section start should be aligned to 4k page */
+	if (!IS_ALIGNED(hdr_size, SZ_4K))
+		return -EINVAL;
+
+	/*
+	 * Read digital section size and check that it also fits inside
+	 * the image.
+	 */
+	ds_size = *(u16 *)(buf + hdr_size);
+	if (ds_size >= image_size)
+		return -EINVAL;
+
+	if (!sw->safe_mode) {
+		u16 device_id;
+
+		/*
+		 * Make sure the device ID in the image matches the one
+		 * we read from the switch config space.
+		 */
+		device_id = *(u16 *)(buf + hdr_size + NVM_DEVID);
+		if (device_id != sw->config.device_id)
+			return -EINVAL;
+
+		if (sw->generation < 3) {
+			/* Write CSS headers first */
+			ret = dma_port_flash_write(sw->dma_port,
+				DMA_PORT_CSS_ADDRESS, buf + NVM_CSS,
+				DMA_PORT_CSS_MAX_SIZE);
+			if (ret)
+				return ret;
+		}
+
+		/* Skip headers in the image */
+		sw->nvm->buf = buf + hdr_size;
+		sw->nvm->buf_data_size = image_size - hdr_size;
+	}
+
+	return 0;
+}
+
+static const struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
+	.read_version = intel_nvm_version,
+	.validate = intel_nvm_validate,
+};
+
+struct switch_nvm_vendor {
+	u16 vendor;
+	const struct tb_nvm_vendor_ops *vops;
+};
+
+static const struct switch_nvm_vendor switch_nvm_vendors[] = {
+	{ PCI_VENDOR_ID_INTEL, &intel_switch_nvm_ops },
+	{ 0x8087, &intel_switch_nvm_ops },
+};
+
+/**
+ * tb_switch_nvm_validate() - Validate NVM image
+ * @switch: Switch to NVM write
+ *
+ * The function include vendor's validate before writes data to actual NVM
+ * flash device. Return %0 in success and error otherwise.
+ */
+int tb_switch_nvm_validate(struct tb_switch *sw)
+{
+	const struct tb_nvm_vendor_ops *vops = sw->nvm->vops;
+	const u8 *buf = sw->nvm->buf;
+	unsigned int image_size;
+	int ret = 0;
+
+	if (!buf)
+		return -EINVAL;
+
+	image_size = sw->nvm->buf_data_size;
+	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
+		return -EINVAL;
+
+	if (!vops)
+		return 0;
+
+	if (vops->validate)
+		ret = vops->validate(sw);
+
+	return ret;
+}
+
+/**
+ * tb_switch_nvm_alloc() - Allocate new NVM structure.
+ * @sw: Switch to allocate NVM
+ *
+ * Allocates new NVM structure and returns it. In case of error returns
+ * ERR_PTR().
+ */
+struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw)
+{
+	const struct tb_nvm_vendor_ops *vops = NULL;
+	struct tb_nvm *nvm;
+	int ret;
+	int i;
+
+	/*
+	 * If the vendor matches on the array then set nvm->vops to
+	 * point the vendor specific operations.
+	 */
+	for (i = 0; i < ARRAY_SIZE(switch_nvm_vendors); i++) {
+		const struct switch_nvm_vendor *v = &switch_nvm_vendors[i];
+
+		if (v->vendor == sw->config.vendor_id) {
+			vops = v->vops;
+			break;
+		}
+	}
+
+	if (!vops)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	nvm = tb_nvm_alloc(&sw->dev);
+	if (IS_ERR(nvm))
+		return nvm;
+
+	nvm->vops = vops;
+	sw->nvm = nvm;
+	ret = vops->read_version(sw);
+	if (ret)
+		goto err_nvm;
+
+	return nvm;
+
+err_nvm:
+	tb_nvm_free(nvm);
+	return ERR_PTR(ret);
+}
+
 /**
  * tb_nvm_alloc() - Allocate new NVM structure
  * @dev: Device owning the NVM
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 244f8cd38b25..2dbfd75202bf 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -102,62 +102,17 @@ static void nvm_clear_auth_status(const struct tb_switch *sw)

 static int nvm_validate_and_write(struct tb_switch *sw)
 {
-	unsigned int image_size, hdr_size;
-	const u8 *buf = sw->nvm->buf;
-	u16 ds_size;
+	unsigned int image_size;
+	const u8 *buf;
 	int ret;

-	if (!buf)
-		return -EINVAL;
+	/* validate NVM image before NVM write */
+	ret = tb_switch_nvm_validate(sw);
+	if (ret)
+		return ret;

+	buf = sw->nvm->buf;
 	image_size = sw->nvm->buf_data_size;
-	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
-		return -EINVAL;
-
-	/*
-	 * FARB pointer must point inside the image and must at least
-	 * contain parts of the digital section we will be reading here.
-	 */
-	hdr_size = (*(u32 *)buf) & 0xffffff;
-	if (hdr_size + NVM_DEVID + 2 >= image_size)
-		return -EINVAL;
-
-	/* Digital section start should be aligned to 4k page */
-	if (!IS_ALIGNED(hdr_size, SZ_4K))
-		return -EINVAL;
-
-	/*
-	 * Read digital section size and check that it also fits inside
-	 * the image.
-	 */
-	ds_size = *(u16 *)(buf + hdr_size);
-	if (ds_size >= image_size)
-		return -EINVAL;
-
-	if (!sw->safe_mode) {
-		u16 device_id;
-
-		/*
-		 * Make sure the device ID in the image matches the one
-		 * we read from the switch config space.
-		 */
-		device_id = *(u16 *)(buf + hdr_size + NVM_DEVID);
-		if (device_id != sw->config.device_id)
-			return -EINVAL;
-
-		if (sw->generation < 3) {
-			/* Write CSS headers first */
-			ret = dma_port_flash_write(sw->dma_port,
-				DMA_PORT_CSS_ADDRESS, buf + NVM_CSS,
-				DMA_PORT_CSS_MAX_SIZE);
-			if (ret)
-				return ret;
-		}
-
-		/* Skip headers in the image */
-		buf += hdr_size;
-		image_size -= hdr_size;
-	}

 	if (tb_switch_is_usb4(sw))
 		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
@@ -384,28 +339,22 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
 static int tb_switch_nvm_add(struct tb_switch *sw)
 {
 	struct tb_nvm *nvm;
-	u32 val;
 	int ret;

 	if (!nvm_readable(sw))
 		return 0;

-	/*
-	 * The NVM format of non-Intel hardware is not known so
-	 * currently restrict NVM upgrade for Intel hardware. We may
-	 * relax this in the future when we learn other NVM formats.
-	 */
-	if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL &&
-	    sw->config.vendor_id != 0x8087) {
-		dev_info(&sw->dev,
-			 "NVM format of vendor %#x is not known, disabling NVM upgrade\n",
-			 sw->config.vendor_id);
-		return 0;
-	}
+	nvm = tb_switch_nvm_alloc(sw);
+	if (IS_ERR(nvm)) {
+		if (PTR_ERR(nvm) == -EOPNOTSUPP) {
+			dev_info(&sw->dev,
+				"NVM format of vendor %#x is not known, disabling NVM upgrade\n",
+				sw->config.vendor_id);
+			return 0;
+		}

-	nvm = tb_nvm_alloc(&sw->dev);
-	if (IS_ERR(nvm))
 		return PTR_ERR(nvm);
+	}

 	/*
 	 * If the switch is in safe-mode the only accessible portion of
@@ -413,24 +362,7 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
 	 * write new functional NVM.
 	 */
 	if (!sw->safe_mode) {
-		u32 nvm_size, hdr_size;
-
-		ret = nvm_read(sw, NVM_FLASH_SIZE, &val, sizeof(val));
-		if (ret)
-			goto err_nvm;
-
-		hdr_size = sw->generation < 3 ? SZ_8K : SZ_16K;
-		nvm_size = (SZ_1M << (val & 7)) / 8;
-		nvm_size = (nvm_size - hdr_size) / 2;
-
-		ret = nvm_read(sw, NVM_VERSION, &val, sizeof(val));
-		if (ret)
-			goto err_nvm;
-
-		nvm->major = val >> 16;
-		nvm->minor = val >> 8;
-
-		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
+		ret = tb_nvm_add_active(nvm, nvm->nvm_size, tb_switch_nvm_read);
 		if (ret)
 			goto err_nvm;
 	}
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5db76de40cc1..fc32737fcde4 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -42,6 +42,8 @@
  *		   image
  * @authenticating: The device is authenticating the new NVM
  * @flushed: The image has been flushed to the storage area
+ * @nvm_size: Number of bytes to activate NVM
+ * @vops: Vendor NVM specific operations
  *
  * The user of this structure needs to handle serialization of possible
  * concurrent access.
@@ -57,6 +59,8 @@ struct tb_nvm {
 	size_t buf_data_size;
 	bool authenticating;
 	bool flushed;
+	u32 nvm_size;
+	const struct tb_nvm_vendor_ops *vops;
 };

 enum tb_nvm_write_ops {
@@ -759,6 +763,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 				  u64 route);
 struct tb_switch *tb_switch_alloc_safe_mode(struct tb *tb,
 			struct device *parent, u64 route);
+struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw);
 int tb_switch_configure(struct tb_switch *sw);
 int tb_switch_add(struct tb_switch *sw);
 void tb_switch_remove(struct tb_switch *sw);
@@ -767,6 +772,7 @@ int tb_switch_resume(struct tb_switch *sw);
 int tb_switch_reset(struct tb_switch *sw);
 int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
 			   u32 value, int timeout_msec);
+int tb_switch_nvm_validate(struct tb_switch *sw);
 void tb_sw_set_unplugged(struct tb_switch *sw);
 struct tb_port *tb_switch_find_port(struct tb_switch *sw,
				    enum tb_port_type type);
--
2.34.1

