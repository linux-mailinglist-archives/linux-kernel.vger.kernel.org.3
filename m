Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98B55A846
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiFYJIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiFYJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:07:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C46B638BF3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:07:45 -0700 (PDT)
Received: from li-amd.loongson.cn (unknown [10.20.42.157])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP9hH0LZiccpYAA--.3313S5;
        Sat, 25 Jun 2022 17:07:22 +0800 (CST)
From:   Chenyang Li <lichenyang@loongson.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devel@linuxdriverproject.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] drm/loongson: Use acpi to get video bios.
Date:   Sat, 25 Jun 2022 17:07:15 +0800
Message-Id: <20220625090715.3663-4-lichenyang@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220625090715.3663-1-lichenyang@loongson.cn>
References: <20220625090715.3663-1-lichenyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxP9hH0LZiccpYAA--.3313S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4UuryfAr45Ar13AF1UKFg_yoW7Cw45pF
        43A34F9r45JF4a9wn5JayrAF45Za45uF97WFW7Jw15u39rCw1Uu345JFWUtFZrAryUGFyI
        qF97KFW8GF1j9w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI
        1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
        W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
        U56KZtUUUUU==
X-CM-SenderInfo: xolfxvxq1d0wo6or00hjvr0hdfq/1tbiAQAIA13QvPp0bgAFse
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add get video bios from the ACPI table.
Define new acpi table "VIAT" for loongson video bios.

Signed-off-by: Chenyang Li <lichenyang@loongson.cn>
---
 drivers/gpu/drm/loongson/Makefile         |  3 +-
 drivers/gpu/drm/loongson/loongson_drv.c   | 21 +++++++-
 drivers/gpu/drm/loongson/loongson_drv.h   |  1 +
 drivers/gpu/drm/loongson/loongson_vbios.c | 62 +++++++++++++++++++++++
 drivers/gpu/drm/loongson/loongson_vbios.h | 29 +++++++++++
 5 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/loongson/loongson_vbios.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_vbios.h

diff --git a/drivers/gpu/drm/loongson/Makefile b/drivers/gpu/drm/loongson/Makefile
index b083854d789b..b774a91003d9 100644
--- a/drivers/gpu/drm/loongson/Makefile
+++ b/drivers/gpu/drm/loongson/Makefile
@@ -11,5 +11,6 @@ loongson-y := loongson_connector.o \
 	loongson_encoder.o \
 	loongson_i2c.o \
 	loongson_irq.o \
-	loongson_plane.o
+	loongson_plane.o \
+	loongson_vbios.o
 obj-$(CONFIG_DRM_LOONGSON) += loongson.o
diff --git a/drivers/gpu/drm/loongson/loongson_drv.c b/drivers/gpu/drm/loongson/loongson_drv.c
index 1d6f35e78813..1c212200f088 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.c
+++ b/drivers/gpu/drm/loongson/loongson_drv.c
@@ -19,14 +19,28 @@
 #include <drm/drm_probe_helper.h>

 #include "loongson_drv.h"
+#include "loongson_vbios.h"
+
+/*
+ * Completed
+ * 1.Displays controller device initialization and display funcitons
+ * 2.I2c bus driver and DDC functions
+ * 3.Vblank and vsync interrupt support
+ * 4.Use acpi to get video bios
+ * Todo
+ * 1.Video bios parse functions
+ * 2.Hardware cursor driver
+ * 3.New device support as well as Loongson GPU
+ */

 /* Interface history:
  * 0.1 - original.
  * 0.2 - add i2c and connector detect.
  * 0.3 - Vblank and vsync interrupt support.
+ * 0.4 - Use acpi to get vbios.
  */
 #define DRIVER_MAJOR 0
-#define DRIVER_MINOR 3
+#define DRIVER_MINOR 4

 static const struct drm_mode_config_funcs loongson_mode_funcs = {
 	.fb_create = drm_gem_fb_create,
@@ -88,7 +102,10 @@ static int loongson_device_init(struct drm_device *dev)
 	if (!ldev->io)
 		return -ENOMEM;

-	ldev->num_crtc = 2;
+	if (!loongson_vbios_init(ldev)) {
+		DRM_WARN("Get vbios failed, enable two crtc\n");
+		ldev->num_crtc = 2;
+	}

 	ret = loongson_dc_gpio_init(ldev);
 	if (ret)
diff --git a/drivers/gpu/drm/loongson/loongson_drv.h b/drivers/gpu/drm/loongson/loongson_drv.h
index af47e68487fd..4e5cb5977c9a 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.h
+++ b/drivers/gpu/drm/loongson/loongson_drv.h
@@ -109,6 +109,7 @@ struct loongson_device {
 	u32 num_crtc;
 	struct loongson_mode_info mode_info[2];
 	struct pci_dev *gpu_pdev; /* LS7A gpu device info */
+	void *vbios;

 	struct loongson_i2c i2c_bus[DC_MAX_I2C_BUS];
 };
diff --git a/drivers/gpu/drm/loongson/loongson_vbios.c b/drivers/gpu/drm/loongson/loongson_vbios.c
new file mode 100644
index 000000000000..2b3a2757102a
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_vbios.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include "loongson_drv.h"
+#include "loongson_vbios.h"
+
+#ifdef CONFIG_ACPI
+static bool read_bios_from_acpi(struct loongson_device *ldev)
+{
+	void *vaddr;
+	struct acpi_table_header *hdr;
+	struct acpi_viat_table *viat;
+	acpi_size tbl_size;
+
+	if (!ACPI_SUCCESS(acpi_get_table("VIAT", 1, &hdr)))
+		return false;
+
+	tbl_size = hdr->length;
+	if (tbl_size != sizeof(struct acpi_viat_table)) {
+		DRM_WARN("ACPI viat table present but broken(too short #1)\n");
+		return false;
+	}
+
+	viat = (struct acpi_viat_table *)hdr;
+	ldev->vbios = kmalloc(VBIOS_SIZE, GFP_KERNEL);
+	if (!ldev->vbios) {
+		kfree(ldev->vbios);
+		return false;
+	}
+
+	vaddr = phys_to_virt(viat->vbios_addr);
+	memcpy(ldev->vbios, vaddr, VBIOS_SIZE);
+	DRM_INFO("Get vbios from ACPI success!\n");
+
+	return true;
+}
+#else
+static bool read_bios_from_acpi(struct loongson_device *ldev)
+{
+	return false;
+}
+#endif
+
+bool loongson_vbios_init(struct loongson_device *ldev)
+{
+	int ret;
+	struct loongson_vbios *header;
+
+	ret = read_bios_from_acpi(ldev);
+	if (!ret)
+		return ret;
+
+	header = ldev->vbios;
+	ldev->num_crtc = header->crtc_num;
+
+	DRM_INFO("Loongson vbios version %d.%d crtc num %d.\n",
+		 header->version_major, header->version_minor, ldev->num_crtc);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/loongson/loongson_vbios.h b/drivers/gpu/drm/loongson/loongson_vbios.h
new file mode 100644
index 000000000000..b7d8ce15c6c5
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_vbios.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef __LOONGSON_VBIOS_H__
+#define __LOONGSON_VBIOS_H__
+
+#include <linux/acpi.h>
+
+#define VBIOS_SIZE 0x40000
+
+struct loongson_vbios {
+	uint32_t version_major;
+	uint32_t version_minor;
+	uint32_t crtc_num;
+} __packed;
+
+#ifdef CONFIG_ACPI
+/* VBOIS INFO ADDRESS TABLE */
+struct acpi_viat_table {
+	struct acpi_table_header header;
+	u64 vbios_addr;
+} __packed;
+#endif
+
+bool loongson_vbios_init(struct loongson_device *ldev);
+
+#endif /* __LOONGSON_VBIOS_H__ */
--
2.25.1

