Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96F546173D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbhK2OBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbhK2N7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:59:35 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA0C0A889F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:38:38 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z8so34161590ljz.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTHsrlfM6h6iUIOvMOal4O0WbKNrW8NYpWveqkNoo1U=;
        b=SUYmgsYWbMSTCT07tBYjUKnVzwg6JvShUtTxxwJ61IVrToEK20qoMtjwHg+fPnHm+l
         VM+ovrdQmWn8/WNfHdPai49oMOoGQTlseDbMQWrsQ+s5MH6o62StakGGxdE7F+SlpB94
         Eg7JfWqlksG5UJqPrkliGOPWsULU9PP/lkh9bEC2yz/VJYBs6ijxXuRsNvi5xmPH+Bw4
         4vdCEZSwwQC59IPtsnc3hJLFQVIdtYOrnd+l1rB8Kv/z+6E4hOBsYSYzMdkrQsJxEL9w
         t8ictui/9bmUW+qS6hQRh1pMxWQpouAg1EVU8WKCfXzPJ+mgQd+Y/86g8ohfE2HH8eWd
         zKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTHsrlfM6h6iUIOvMOal4O0WbKNrW8NYpWveqkNoo1U=;
        b=gMwo6o/QYEpkcirfayvJV0vTH3g/zdFn0IHjWsK/hmLPa2+HCeEhvyXHUCchyMVcPH
         L6E2+qJruO4xMd9PTqivVAliMKNGDDWYjZbwyF636ameYt+3JWzCILOeqjwaAdrIDmEp
         5PvmozlJzgGKjwmTjib6p+h/iVmdqGwNLIxjWwLlq7Ar9Etb/BwDyRe/j9Qv1ulNlIQz
         e3zU3rus5hPqj9HkFyVtui5o0TN6UZQkzNmK6TZKydIlrqImBew4kNHakmtkc9ixiPck
         dCKrwfykEOHKVB8cptGLbyPiHy9scNlujdJvxmM/YeylvmxiHopb6wIM0cNKZAe4SwJL
         xVgA==
X-Gm-Message-State: AOAM5338L4l8pfimIy1qhX/h9POXAnljbefPuVQe+muphON7xdZNXE4F
        Hcf28B6+vD/Qi61KTU7VGDA=
X-Google-Smtp-Source: ABdhPJxaJjDyaQ2qKuPUsYYeGvYpdG6dIf8oJV4WAGiuuaEbUKgxz+Oryg1OG39poEYQQ4RbCMSPeQ==
X-Received: by 2002:a2e:8892:: with SMTP id k18mr48360688lji.288.1638189516717;
        Mon, 29 Nov 2021 04:38:36 -0800 (PST)
Received: from inno-pc.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id x17sm1276460lji.96.2021.11.29.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:38:36 -0800 (PST)
From:   Zhi Wang <zhi.wang.linux@gmail.com>
X-Google-Original-From: Zhi Wang <zhi.a.wang@intel.com>
To:     intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Zhi Wang <zhi.wang.linux@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Terrence Xu <terrence.xu@intel.com>
Subject: [PATCH v4 2/2] i915/gvt: save the MMIO snapshot in the early init of GVT-g
Date:   Mon, 29 Nov 2021 07:38:32 -0500
Message-Id: <20211129123832.105196-2-zhi.a.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129123832.105196-1-zhi.a.wang@intel.com>
References: <20211129123832.105196-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhi Wang <zhi.wang.linux@gmail.com>

To support the early init of GVT-g, which will be put in i915, after the
GVT-g is moved into a dedicated module, we need to save the MMIO snapshot
in the early init of GVT-g, when the HW hasn't been touched.

v3:

- Fix errors when CONFIG_DRM_I915_WERROR is turned on. (Jani)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Vivi Rodrigo <rodrigo.vivi@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Tested-by: Terrence Xu <terrence.xu@intel.com>
Signed-off-by: Zhi Wang <zhi.wang.linux@gmail.com>
---
 drivers/gpu/drm/i915/gvt/firmware.c        | 40 +-----------
 drivers/gpu/drm/i915/gvt/handlers.c        | 39 ------------
 drivers/gpu/drm/i915/gvt/mmio_info_table.c | 72 +++++++++++++++++++++-
 drivers/gpu/drm/i915/gvt/mmio_info_table.h |  3 +
 4 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
index 1a8274a3f4b1..28719c2f253f 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -66,12 +66,6 @@ static struct bin_attribute firmware_attr = {
 	.mmap = NULL,
 };
 
-static int mmio_snapshot_handler(struct intel_gvt *gvt, u32 offset, void *data)
-{
-	*(u32 *)(data + offset) = intel_uncore_read_notrace(gvt->gt->uncore,
-							    _MMIO(offset));
-	return 0;
-}
 
 static int expose_firmware_sysfs(struct intel_gvt *gvt)
 {
@@ -81,7 +75,7 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 	void *firmware;
 	void *p;
 	unsigned long size, crc32_start;
-	int i, ret;
+	int ret;
 
 	size = sizeof(*h) + info->mmio_size + info->cfg_space_size;
 	firmware = vzalloc(size);
@@ -99,17 +93,11 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 
 	p = firmware + h->cfg_space_offset;
 
-	for (i = 0; i < h->cfg_space_size; i += 4)
-		pci_read_config_dword(pdev, i, p + i);
-
-	memcpy(gvt->firmware.cfg_space, p, info->cfg_space_size);
+	memcpy(p, gvt->firmware.cfg_space, info->cfg_space_size);
 
 	p = firmware + h->mmio_offset;
 
-	/* Take a snapshot of hw mmio registers. */
-	intel_gvt_for_each_tracked_mmio(gvt, mmio_snapshot_handler, p);
-
-	memcpy(gvt->firmware.mmio, p, info->mmio_size);
+	memcpy(p, gvt->firmware.mmio, info->mmio_size);
 
 	crc32_start = offsetof(struct gvt_firmware_header, crc32) + 4;
 	h->crc32 = crc32_le(0, firmware + crc32_start, size - crc32_start);
@@ -142,9 +130,6 @@ void intel_gvt_free_firmware(struct intel_gvt *gvt)
 {
 	if (!gvt->firmware.firmware_loaded)
 		clean_firmware_sysfs(gvt);
-
-	kfree(gvt->firmware.cfg_space);
-	vfree(gvt->firmware.mmio);
 }
 
 static int verify_firmware(struct intel_gvt *gvt,
@@ -204,36 +189,17 @@ static int verify_firmware(struct intel_gvt *gvt,
  */
 int intel_gvt_load_firmware(struct intel_gvt *gvt)
 {
-	struct intel_gvt_device_info *info = &gvt->device_info;
 	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 	struct intel_gvt_firmware *firmware = &gvt->firmware;
 	struct gvt_firmware_header *h;
 	const struct firmware *fw;
 	char *path;
-	void *mem;
 	int ret;
 
 	path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
-	mem = kmalloc(info->cfg_space_size, GFP_KERNEL);
-	if (!mem) {
-		kfree(path);
-		return -ENOMEM;
-	}
-
-	firmware->cfg_space = mem;
-
-	mem = vmalloc(info->mmio_size);
-	if (!mem) {
-		kfree(path);
-		kfree(firmware->cfg_space);
-		return -ENOMEM;
-	}
-
-	firmware->mmio = mem;
-
 	sprintf(path, "%s/vid_0x%04x_did_0x%04x_rid_0x%02x.golden_hw_state",
 		 GVT_FIRMWARE_PATH, pdev->vendor, pdev->device,
 		 pdev->revision);
diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index 2c064da3db6d..ba7b330a2c71 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -2406,45 +2406,6 @@ int intel_gvt_setup_mmio_handlers(struct intel_gvt *gvt)
 	return ret;
 }
 
-/**
- * intel_gvt_for_each_tracked_mmio - iterate each tracked mmio
- * @gvt: a GVT device
- * @handler: the handler
- * @data: private data given to handler
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-int intel_gvt_for_each_tracked_mmio(struct intel_gvt *gvt,
-	int (*handler)(struct intel_gvt *gvt, u32 offset, void *data),
-	void *data)
-{
-	struct gvt_mmio_block *block = gvt->mmio.mmio_block;
-	struct intel_gvt_mmio_info *e;
-	int i, j, ret;
-
-	hash_for_each(gvt->mmio.mmio_info_table, i, e, node) {
-		ret = handler(gvt, e->offset, data);
-		if (ret)
-			return ret;
-	}
-
-	for (i = 0; i < gvt->mmio.num_mmio_block; i++, block++) {
-		/* pvinfo data doesn't come from hw mmio */
-		if (i915_mmio_reg_offset(block->offset) == VGT_PVINFO_PAGE)
-			continue;
-
-		for (j = 0; j < block->size; j += 4) {
-			ret = handler(gvt,
-				      i915_mmio_reg_offset(block->offset) + j,
-				      data);
-			if (ret)
-				return ret;
-		}
-	}
-	return 0;
-}
-
 /**
  * intel_vgpu_default_mmio_read - default MMIO read handler
  * @vgpu: a vGPU
diff --git a/drivers/gpu/drm/i915/gvt/mmio_info_table.c b/drivers/gpu/drm/i915/gvt/mmio_info_table.c
index 913a3503289e..09984952568a 100644
--- a/drivers/gpu/drm/i915/gvt/mmio_info_table.c
+++ b/drivers/gpu/drm/i915/gvt/mmio_info_table.c
@@ -1398,6 +1398,54 @@ void intel_gvt_clean_mmio_info(struct intel_gvt *gvt)
 
 	vfree(gvt->mmio.mmio_attribute);
 	gvt->mmio.mmio_attribute = NULL;
+	kfree(gvt->firmware.cfg_space);
+	vfree(gvt->firmware.mmio);
+}
+
+static int mmio_snapshot_handler(struct intel_gvt *gvt, u32 offset, void *data)
+{
+	*(u32 *)(data + offset) = intel_uncore_read_notrace(gvt->gt->uncore,
+							    _MMIO(offset));
+	return 0;
+}
+
+/**
+ * intel_gvt_for_each_tracked_mmio - iterate each tracked mmio
+ * @gvt: a GVT device
+ * @handler: the handler
+ * @data: private data given to handler
+ *
+ * Returns:
+ * Zero on success, negative error code if failed.
+ */
+int intel_gvt_for_each_tracked_mmio(struct intel_gvt *gvt,
+	int (*handler)(struct intel_gvt *gvt, u32 offset, void *data),
+	void *data)
+{
+	struct gvt_mmio_block *block = gvt->mmio.mmio_block;
+	struct intel_gvt_mmio_info *e;
+	int i, j, ret;
+
+	hash_for_each(gvt->mmio.mmio_info_table, i, e, node) {
+		ret = handler(gvt, e->offset, data);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < gvt->mmio.num_mmio_block; i++, block++) {
+		/* pvinfo data doesn't come from hw mmio */
+		if (i915_mmio_reg_offset(block->offset) == VGT_PVINFO_PAGE)
+			continue;
+
+		for (j = 0; j < block->size; j += 4) {
+			ret = handler(gvt,
+				      i915_mmio_reg_offset(block->offset) + j,
+				      data);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
 }
 
 /**
@@ -1414,8 +1462,10 @@ int intel_gvt_setup_mmio_info(struct intel_gvt *gvt)
 {
 	struct intel_gvt_device_info *info = &gvt->device_info;
 	struct drm_i915_private *i915 = gvt->gt->i915;
+	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	int size = info->mmio_size / 4 * sizeof(*gvt->mmio.mmio_attribute);
-	int ret;
+	void *mem;
+	int i, ret;
 
 	gvt->mmio.mmio_attribute = vzalloc(size);
 	if (!gvt->mmio.mmio_attribute)
@@ -1454,6 +1504,26 @@ int intel_gvt_setup_mmio_info(struct intel_gvt *gvt)
 	gvt->mmio.mmio_block = mmio_blocks;
 	gvt->mmio.num_mmio_block = ARRAY_SIZE(mmio_blocks);
 
+	mem = kzalloc(info->cfg_space_size, GFP_KERNEL);
+	if (!mem)
+		goto err;
+
+	gvt->firmware.cfg_space = mem;
+
+	for (i = 0; i < info->cfg_space_size; i += 4)
+		pci_read_config_dword(pdev, i, mem + i);
+
+	mem = vzalloc(info->mmio_size);
+	if (!mem) {
+		kfree(gvt->firmware.cfg_space);
+		goto err;
+	}
+
+	gvt->firmware.mmio = mem;
+
+	/* Take a snapshot of hw mmio registers. */
+	intel_gvt_for_each_tracked_mmio(gvt, mmio_snapshot_handler, mem);
+
 	return 0;
 err:
 	intel_gvt_clean_mmio_info(gvt);
diff --git a/drivers/gpu/drm/i915/gvt/mmio_info_table.h b/drivers/gpu/drm/i915/gvt/mmio_info_table.h
index 0303fd447330..7572b255d5d0 100644
--- a/drivers/gpu/drm/i915/gvt/mmio_info_table.h
+++ b/drivers/gpu/drm/i915/gvt/mmio_info_table.h
@@ -29,6 +29,9 @@
 
 unsigned long intel_gvt_get_device_type(struct intel_gvt *gvt);
 bool intel_gvt_match_device(struct intel_gvt *gvt, unsigned long device);
+int intel_gvt_for_each_tracked_mmio(struct intel_gvt *gvt,
+	int (*handler)(struct intel_gvt *gvt, u32 offset, void *data),
+	void *data);
 struct intel_gvt_mmio_info *intel_gvt_find_mmio_info(struct intel_gvt *gvt,
 						     unsigned int offset);
 int intel_gvt_setup_mmio_info(struct intel_gvt *gvt);
-- 
2.25.1

