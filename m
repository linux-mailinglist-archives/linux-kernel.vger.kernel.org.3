Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212085AAB9F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiIBJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiIBJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:40:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A581C45980;
        Fri,  2 Sep 2022 02:40:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x23so1334193pll.7;
        Fri, 02 Sep 2022 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xU9ZEgidRYqKlk7ba0nApS/DeMLjPjtAszT+pZz9hpY=;
        b=jTRy3SYw8SZK4VpzFcG02d/pUeoPWn6rHu9p/0GjOy1mj5AQnyHSr+QfjLU6DTonwc
         TTJzUSMpYEVBPwyzlK+QSK0HCgD/rK5yDx4EXOlFWRXwjiPWnlt4x1zWGWvaEq2Wgd4q
         92UrQP65MVXJ/wJM2eAUmG2RXCBjaKR5fg4scrduC9SQEw1mQHciJDVdqwvGM6rkXY0u
         HwOiyRjD3V2KANq8wsDI1gzL+zrn2q2zoLALOWchMw/W8TPcQR/VmhUrW24bZrQAsr/h
         ImTo4t7FA49VaYfQEn8HYDho/tmHQgzKZns4DaxBe0cl8KLpTUlfNU/ZN0JMa3cUkTT6
         nfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xU9ZEgidRYqKlk7ba0nApS/DeMLjPjtAszT+pZz9hpY=;
        b=VZKbbWJN3SrrToD74u0Ecg8+JPh+3Mis30qLQkcUACQbX0u4TIz3WKGrKTpNcvhEio
         kxgmNnNsyZyhK+jfQbioG7H0tb4uYomYwNv84LP0pmRRGbEUlJ2+Wo7IG2lP0PZ1R0+M
         AmE1YFKWkyVBDVUg27c9XIAnaF2PdKg7J/CUWgVMZxjpqOl8Lt/ZEAwIMxrEZHVMcaW/
         ONPj64qPDxC4XHUA2+IwHE278ANfwp+qc2Zp/cOi1C4krZWW/ZDMliiyZYx0cVNWzxEz
         zw6wL164c+ImU+tEs2paXVDkZvcNDTc4X+kg1DeO20zRGSLknbHbFKdrJO5itkOK9ILq
         CC2A==
X-Gm-Message-State: ACgBeo3N5OUNXInt9BE+cb8HWXln76FPlcL/PRFKNY2MiHlUmjOvkNt5
        Ymv2gGagLAoGKF8O1QQ/vSQ=
X-Google-Smtp-Source: AA6agR4Mv7xD84uRc1TL39B94V6sWM6dibW99ASX1jI/zPBXDp9O4QTi5CMrCbxsv51bjHewl1Flhw==
X-Received: by 2002:a17:90a:8911:b0:1fa:c8f7:1450 with SMTP id u17-20020a17090a891100b001fac8f71450mr3770452pjn.123.1662111630987;
        Fri, 02 Sep 2022 02:40:30 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id z14-20020a655a4e000000b0041d9e78de05sm971855pgs.73.2022.09.02.02.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:40:30 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v8 1/3] thunderbolt: Add vendor's specific operations of NVM
Date:   Fri,  2 Sep 2022 17:40:08 +0800
Message-Id: <20220902094010.2170-2-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902094010.2170-1-chensiying21@gmail.com>
References: <20220902094010.2170-1-chensiying21@gmail.com>
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

The current code only supports the Intel NVM format and we hope vendors
can easily add their NVM formats. We provide an array to find vendors
that support NVM, it will set nvm->vops to point the vendor specific
operations.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
v7->v8: As suggestion by Mika, the nvm_read() defined in tb.h
and modify the return value of tb_switch_nvm_validate().

 drivers/thunderbolt/nvm.c    | 194 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c | 104 ++++---------------
 drivers/thunderbolt/tb.h     |   8 ++
 3 files changed, 220 insertions(+), 86 deletions(-)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index b3f310389378..878d705bd0cb 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -12,8 +12,202 @@

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
+	return vops->validate?vops->validate(sw):0;
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
index 244f8cd38b25..6df6553da4c7 100644
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
@@ -300,7 +255,7 @@ static inline bool nvm_upgradeable(struct tb_switch *sw)
 	return nvm_readable(sw);
 }

-static inline int nvm_read(struct tb_switch *sw, unsigned int address,
+inline int nvm_read(struct tb_switch *sw, unsigned int address,
 			   void *buf, size_t size)
 {
 	if (tb_switch_is_usb4(sw))
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
index 5db76de40cc1..7ef571f88606 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -42,6 +42,8 @@
  *		   image
  * @authenticating: The device is authenticating the new NVM
  * @flushed: The image has been flushed to the storage area
+ * @nvm_size: Size in bytes of the activate NVM
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
@@ -736,6 +740,8 @@ static inline void tb_domain_put(struct tb *tb)
 	put_device(&tb->dev);
 }

+inline int nvm_read(struct tb_switch *sw, unsigned int address,
+			   void *buf, size_t size);
 struct tb_nvm *tb_nvm_alloc(struct device *dev);
 int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
 int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
@@ -759,6 +765,7 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, struct device *parent,
 				  u64 route);
 struct tb_switch *tb_switch_alloc_safe_mode(struct tb *tb,
 			struct device *parent, u64 route);
+struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw);
 int tb_switch_configure(struct tb_switch *sw);
 int tb_switch_add(struct tb_switch *sw);
 void tb_switch_remove(struct tb_switch *sw);
@@ -767,6 +774,7 @@ int tb_switch_resume(struct tb_switch *sw);
 int tb_switch_reset(struct tb_switch *sw);
 int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
 			   u32 value, int timeout_msec);
+int tb_switch_nvm_validate(struct tb_switch *sw);
 void tb_sw_set_unplugged(struct tb_switch *sw);
 struct tb_port *tb_switch_find_port(struct tb_switch *sw,
 				    enum tb_port_type type);
--
2.34.1

