Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF155A850
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiFYJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiFYJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:07:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 418A837BF5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:07:38 -0700 (PDT)
Received: from li-amd.loongson.cn (unknown [10.20.42.157])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP9hH0LZiccpYAA--.3313S4;
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
Subject: [PATCH v7 3/4] drm/loongson: Add interrupt driver for LS7A.
Date:   Sat, 25 Jun 2022 17:07:14 +0800
Message-Id: <20220625090715.3663-3-lichenyang@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220625090715.3663-1-lichenyang@loongson.cn>
References: <20220625090715.3663-1-lichenyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxP9hH0LZiccpYAA--.3313S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKr43GrW7Ww1fGFyftr4xZwb_yoWfJF48pr
        43Aa4F9r45tF47u3s3AFWrAr13u3y3Kas7WFZrG343CryDtw1UXa4rCFW7JF47Zr9rJ342
        qryxKFWrCF1Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI
        1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
        W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
        U5DMa5UUUUU==
X-CM-SenderInfo: xolfxvxq1d0wo6or00hjvr0hdfq/1tbiAQAIA13QvPp0bgAEsf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LS7A DC vsync interrupt enable and close function, and
register irq_handler function interface.
Add vbrank event processing flow.

v4:
- Replace drm_irq_install with devm_request_irq.
- Delete the irq_ hooks in drm_driver.

v3:
- Improve code readability.
- Use the to_pci_dev function to get pci_dev.

v2:
- Added error handling in the loongson_drm_load function.

Signed-off-by: Chenyang Li <lichenyang@loongson.cn>
---
 drivers/gpu/drm/loongson/Makefile        |  1 +
 drivers/gpu/drm/loongson/loongson_crtc.c | 37 +++++++++++
 drivers/gpu/drm/loongson/loongson_drv.c  |  9 ++-
 drivers/gpu/drm/loongson/loongson_drv.h  | 10 +++
 drivers/gpu/drm/loongson/loongson_irq.c  | 84 ++++++++++++++++++++++++
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/loongson/loongson_irq.c

diff --git a/drivers/gpu/drm/loongson/Makefile b/drivers/gpu/drm/loongson/Makefile
index 4a5fab7d000b..b083854d789b 100644
--- a/drivers/gpu/drm/loongson/Makefile
+++ b/drivers/gpu/drm/loongson/Makefile
@@ -10,5 +10,6 @@ loongson-y := loongson_connector.o \
 	loongson_drv.o \
 	loongson_encoder.o \
 	loongson_i2c.o \
+	loongson_irq.o \
 	loongson_plane.o
 obj-$(CONFIG_DRM_LOONGSON) += loongson.o
diff --git a/drivers/gpu/drm/loongson/loongson_crtc.c b/drivers/gpu/drm/loongson/loongson_crtc.c
index 611378cef8e8..6a31ff911ce1 100644
--- a/drivers/gpu/drm/loongson/loongson_crtc.c
+++ b/drivers/gpu/drm/loongson/loongson_crtc.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/drm_fourcc.h>
+#include <drm/drm_vblank.h>
 
 #include "loongson_drv.h"
 
@@ -167,8 +168,14 @@ static void loongson_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
 	u32 reg_offset = lcrtc->reg_offset;
 
+	if (lcrtc->cfg_reg & CFG_ENABLE)
+		goto vblank_on;
+
 	lcrtc->cfg_reg |= CFG_ENABLE;
 	ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, lcrtc->cfg_reg);
+
+vblank_on:
+	drm_crtc_vblank_on(crtc);
 }
 
 static void loongson_crtc_atomic_disable(struct drm_crtc *crtc,
@@ -181,6 +188,33 @@ static void loongson_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	lcrtc->cfg_reg &= ~CFG_ENABLE;
 	ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, lcrtc->cfg_reg);
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (crtc->state->event) {
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+	}
+	spin_unlock_irq(&crtc->dev->event_lock);
+
+	drm_crtc_vblank_off(crtc);
+}
+
+static void loongson_crtc_atomic_flush(struct drm_crtc *crtc,
+				       struct drm_atomic_state *state)
+{
+	struct drm_pending_vblank_event *event = crtc->state->event;
+
+	if (!event)
+		return;
+
+	crtc->state->event = NULL;
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (drm_crtc_vblank_get(crtc) == 0)
+		drm_crtc_arm_vblank_event(crtc, event);
+	else
+		drm_crtc_send_vblank_event(crtc, event);
+	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
 static enum drm_mode_status loongson_mode_valid(struct drm_crtc *crtc,
@@ -200,6 +234,7 @@ static enum drm_mode_status loongson_mode_valid(struct drm_crtc *crtc,
 
 static const struct drm_crtc_helper_funcs loongson_crtc_helper_funcs = {
 	.mode_valid = loongson_mode_valid,
+	.atomic_flush = loongson_crtc_atomic_flush,
 	.atomic_enable = loongson_crtc_atomic_enable,
 	.atomic_disable = loongson_crtc_atomic_disable,
 	.mode_set_nofb = loongson_crtc_mode_set_nofb,
@@ -211,6 +246,8 @@ static const struct drm_crtc_funcs loongson_crtc_funcs = {
 	.reset = drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank = loongson_crtc_enable_vblank,
+	.disable_vblank = loongson_crtc_disable_vblank,
 };
 
 int loongson_crtc_init(struct loongson_device *ldev, int index)
diff --git a/drivers/gpu/drm/loongson/loongson_drv.c b/drivers/gpu/drm/loongson/loongson_drv.c
index 2e3ef6193767..1d6f35e78813 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.c
+++ b/drivers/gpu/drm/loongson/loongson_drv.c
@@ -23,9 +23,10 @@
 /* Interface history:
  * 0.1 - original.
  * 0.2 - add i2c and connector detect.
+ * 0.3 - Vblank and vsync interrupt support.
  */
 #define DRIVER_MAJOR 0
-#define DRIVER_MINOR 2
+#define DRIVER_MINOR 3
 
 static const struct drm_mode_config_funcs loongson_mode_funcs = {
 	.fb_create = drm_gem_fb_create,
@@ -167,6 +168,12 @@ static int loongson_driver_init(struct drm_device *dev)
 		goto err;
 	}
 
+	ret = loongson_irq_init(ldev);
+	if (ret) {
+		dev_err(dev->dev, "Fatal error during irq init: %d\n", ret);
+		goto err;
+	}
+
 	drm_kms_helper_poll_init(dev);
 	drm_mode_config_reset(dev);
 
diff --git a/drivers/gpu/drm/loongson/loongson_drv.h b/drivers/gpu/drm/loongson/loongson_drv.h
index 5be29d2d1a49..af47e68487fd 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.h
+++ b/drivers/gpu/drm/loongson/loongson_drv.h
@@ -40,6 +40,7 @@
 #define FB_HSYNC_REG (0x1420)
 #define FB_VDISPLAY_REG (0x1480)
 #define FB_VSYNC_REG (0x14a0)
+#define FB_INT_REG (0x1570)
 
 #define CFG_FMT GENMASK(2, 0)
 #define CFG_FBSWITCH BIT(7)
@@ -51,6 +52,10 @@
 #define FB_PANCFG_DEF 0x80001311
 #define FB_HSYNC_PULSE (1 << 30)
 #define FB_VSYNC_PULSE (1 << 30)
+#define FB_VSYNC1_ENABLE (1 << 16)
+#define FB_VSYNC0_ENABLE (1 << 18)
+#define FB_VSYNC1_INT (1 << 0)
+#define FB_VSYNC0_INT (1 << 2)
 
 /* PIX PLL */
 #define LOOPC_MIN 24
@@ -128,6 +133,11 @@ struct loongson_plane *loongson_plane_init(struct drm_device *dev, int index);
 /* i2c */
 int loongson_dc_gpio_init(struct loongson_device *ldev);
 
+/* irq */
+int loongson_irq_init(struct loongson_device *ldev);
+int loongson_crtc_enable_vblank(struct drm_crtc *crtc);
+void loongson_crtc_disable_vblank(struct drm_crtc *crtc);
+
 /* device */
 u32 loongson_gpu_offset(struct drm_plane_state *state,
 			struct loongson_device *dev);
diff --git a/drivers/gpu/drm/loongson/loongson_irq.c b/drivers/gpu/drm/loongson/loongson_irq.c
new file mode 100644
index 000000000000..ba215d585dc7
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_irq.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/pci.h>
+
+#include <drm/drm_vblank.h>
+
+#include "loongson_drv.h"
+
+static irqreturn_t loongson_irq_handler(int irq, void *arg)
+{
+	struct drm_device *dev = (struct drm_device *) arg;
+	struct loongson_device *ldev = to_loongson_device(dev);
+	struct loongson_crtc *lcrtc;
+	u32 val;
+
+	val = ls7a_mm_rreg(ldev, FB_INT_REG);
+	ls7a_mm_wreg(ldev, FB_INT_REG, val & (0xffff << 16));
+
+	if (val & FB_VSYNC0_INT)
+		lcrtc = ldev->mode_info[0].crtc;
+	else if (val & FB_VSYNC1_INT)
+		lcrtc = ldev->mode_info[1].crtc;
+
+	drm_crtc_handle_vblank(&lcrtc->base);
+
+	return IRQ_HANDLED;
+}
+
+int loongson_irq_init(struct loongson_device *ldev)
+{
+	int ret;
+	struct drm_device *dev = &ldev->dev;
+	int irq = to_pci_dev(dev->dev)->irq;
+
+	ret = drm_vblank_init(dev, ldev->num_crtc);
+	if (ret) {
+		dev_err(dev->dev, "Fatal error during vblank init: %d\n", ret);
+		return ret;
+	}
+	DRM_INFO("drm vblank init finished\n");
+
+	ret = devm_request_irq(dev->dev, irq, loongson_irq_handler, 0,
+			       "loongson-drm", dev);
+	if (ret) {
+		dev_err(dev->dev, "Fatal error during irq install: %d\n", ret);
+		return ret;
+	}
+	DRM_INFO("loongson irq initialized\n");
+
+	return 0;
+}
+
+int loongson_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
+	struct loongson_device *ldev = lcrtc->ldev;
+	u32 reg_val = ls7a_mm_rreg(ldev, FB_INT_REG);
+
+	if (lcrtc->crtc_id)
+		reg_val |= FB_VSYNC1_ENABLE;
+	else
+		reg_val |= FB_VSYNC0_ENABLE;
+
+	ls7a_mm_wreg(ldev, FB_INT_REG, reg_val);
+
+	return 0;
+}
+
+void loongson_crtc_disable_vblank(struct drm_crtc *crtc)
+{
+	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
+	struct loongson_device *ldev = lcrtc->ldev;
+	u32 reg_val = ls7a_mm_rreg(ldev, FB_INT_REG);
+
+	if (lcrtc->crtc_id)
+		reg_val &= ~FB_VSYNC1_ENABLE;
+	else
+		reg_val &= ~FB_VSYNC0_ENABLE;
+
+	ls7a_mm_wreg(ldev, FB_INT_REG, reg_val);
+}
-- 
2.25.1

