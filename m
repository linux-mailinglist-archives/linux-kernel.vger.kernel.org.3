Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123BD55A84B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiFYJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiFYJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:07:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7747036E0A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:07:38 -0700 (PDT)
Received: from li-amd.loongson.cn (unknown [10.20.42.157])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP9hH0LZiccpYAA--.3313S2;
        Sat, 25 Jun 2022 17:07:19 +0800 (CST)
From:   Chenyang Li <lichenyang@loongson.cn>
To:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devel@linuxdriverproject.org
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Yi Li <liyi@loongson.cn>
Subject: [PATCH v7 1/4] drm/loongson: Add DRM Driver for Loongson 7A1000 bridge chip
Date:   Sat, 25 Jun 2022 17:07:12 +0800
Message-Id: <20220625090715.3663-1-lichenyang@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxP9hH0LZiccpYAA--.3313S2
X-Coremail-Antispam: 1UD129KBjvAXoWfZrW5JF1kArW8AFy5CFyrtFb_yoW5Zr1Dto
        WxZFnxWw4rXr1xAFZY9rn3JF17ZF4DXanIkrWSkr1DGa1Yy3Z8tF9Igw1fZr1fAF1FyF4U
        A34Ykr4xGF47JrZ5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYh7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
        xVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xolfxvxq1d0wo6or00hjvr0hdfq/1tbiAQAIA13QvPp0bgACsZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an initial DRM driver for the Loongson LS7A1000
bridge chip(LS7A). The Loongson 7A1000 bridge chip is Loongson’s
first dedicated chipset product, providing north-south bridge functionality
for Loongson processors. The bridge chip is connected to the Loongson
Series 3 processor via the HT high-speed bus interface and has an
integrated DisplayController, DDR3 SDRAM memory controller,
and PCIE, SATA, USB, GMAC, I2C, UART, GPIO, and other interfaces.
The display controller supports dual DVO signal output,dual routability
frame buffer. Each display supports up to 1920x1080@60Hz, RGB888 and
RGB565 color depths. And supports hardware cursor, gamma correction,
interrupt, soft reset, etc. The video memory interface uses 16-bit DDR3
SDRAM interface with a maximum data rate of 1333 Mbps.
At present, DC device detection and DRM driver registration are
completed, the crtc/plane/encoder/connector objects has been
implemented.
On Loongson 3A4000 CPU and 7A1000 system, we have achieved the use
of dual screen, and support dual screen clone mode and expansion
mode.
Link: https://loongson.github.io/LoongArch-Documentation/Loongson-7A1000-usermanual-EN.html#display-controller

v12:
- Use drm_bridge_connector in driver.

v11:
- Remove a lot of useless code.
- Add help information.
- Delete unnecessary header files.

v10:
- Replace the drmm_ version functions.
- Replace the simple_encoder version function.
- Alphabetize file names.

v9:
- Optimize the error handling process.
- Remove the useless flags parameter.
- Fix some incorrect use of variables and constructs.

v8:
- Update the atomic_update function interface.

v7:
- The pixel clock is limited to less than 173000.

v6:
- Remove spin_lock in mmio reg read and write.
- TO_UNCAC is replac with ioremap.
- Fix error arguments in crtc_atomic_enable/disable/mode_valid.

v5:
- Change the name of the chip to LS7A.
- Change magic value in crtc to macros.
- Correct mistakes words.
- Change the register operation function prefix to ls7a.

v4:
- Move the mode_valid function to the crtc.

v3:
- Move the mode_valid function to the connector and optimize it.
- Fix num_crtc calculation method.

v2:
- Complete the case of 32-bit color in CRTC.

Signed-off-by: Yi Li <liyi@loongson.cn>
Signed-off-by: Chenyang Li <lichenyang@loongson.cn>
---
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/loongson/Kconfig              |  13 +
 drivers/gpu/drm/loongson/Makefile             |  13 +
 drivers/gpu/drm/loongson/loongson_connector.c |  25 ++
 drivers/gpu/drm/loongson/loongson_crtc.c      | 244 ++++++++++++++++
 drivers/gpu/drm/loongson/loongson_device.c    |  38 +++
 drivers/gpu/drm/loongson/loongson_drv.c       | 275 ++++++++++++++++++
 drivers/gpu/drm/loongson/loongson_drv.h       | 132 +++++++++
 drivers/gpu/drm/loongson/loongson_encoder.c   |  59 ++++
 drivers/gpu/drm/loongson/loongson_plane.c     |  97 ++++++
 11 files changed, 899 insertions(+)
 create mode 100644 drivers/gpu/drm/loongson/Kconfig
 create mode 100644 drivers/gpu/drm/loongson/Makefile
 create mode 100644 drivers/gpu/drm/loongson/loongson_connector.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_crtc.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_device.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_drv.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_drv.h
 create mode 100644 drivers/gpu/drm/loongson/loongson_encoder.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_plane.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f1422bee3dcc..d5547e492a3f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -392,6 +392,8 @@ source "drivers/gpu/drm/vboxvideo/Kconfig"
 
 source "drivers/gpu/drm/lima/Kconfig"
 
+source "drivers/gpu/drm/loongson/Kconfig"
+
 source "drivers/gpu/drm/panfrost/Kconfig"
 
 source "drivers/gpu/drm/aspeed/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c2ef5f9fce54..173b967e2884 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_DRM_TVE200) += tve200/
 obj-$(CONFIG_DRM_XEN) += xen/
 obj-$(CONFIG_DRM_VBOXVIDEO) += vboxvideo/
 obj-$(CONFIG_DRM_LIMA)  += lima/
+obj-$(CONFIG_DRM_LOONGSON) += loongson/
 obj-$(CONFIG_DRM_PANFROST) += panfrost/
 obj-$(CONFIG_DRM_ASPEED_GFX) += aspeed/
 obj-$(CONFIG_DRM_MCDE) += mcde/
diff --git a/drivers/gpu/drm/loongson/Kconfig b/drivers/gpu/drm/loongson/Kconfig
new file mode 100644
index 000000000000..2484824fb50b
--- /dev/null
+++ b/drivers/gpu/drm/loongson/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_LOONGSON
+	tristate "DRM support for LS7A bridge chipset"
+	depends on DRM && PCI
+	depends on CPU_LOONGSON64 || COMPILE_TEST
+	select DRM_KMS_HELPER
+	select DRM_VRAM_HELPER
+	help
+	  The loongson 7A bridge chip (LS7A) is a special chipset for
+	  loongson CPU. LS7A internal integrated display controllers,
+	  support two display channels.
+	  If compiled as a module it will be called loongson.
diff --git a/drivers/gpu/drm/loongson/Makefile b/drivers/gpu/drm/loongson/Makefile
new file mode 100644
index 000000000000..534a64047fb6
--- /dev/null
+++ b/drivers/gpu/drm/loongson/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for loongson drm drivers.
+# This driver provides support for the
+# Direct Rendering Infrastructure (DRI)
+
+loongson-y := loongson_connector.o \
+	loongson_crtc.o \
+	loongson_device.o \
+	loongson_drv.o \
+	loongson_encoder.o \
+	loongson_plane.o
+obj-$(CONFIG_DRM_LOONGSON) += loongson.o
diff --git a/drivers/gpu/drm/loongson/loongson_connector.c b/drivers/gpu/drm/loongson/loongson_connector.c
new file mode 100644
index 000000000000..22fd2af8b3e6
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_connector.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_bridge_connector.h>
+
+#include "loongson_drv.h"
+
+int loongson_bridge_connector_init(struct loongson_device *ldev, int index)
+{
+	struct drm_device *dev = &ldev->dev;
+	struct drm_connector *connector;
+	struct drm_encoder *encoder = &ldev->mode_info[index].encoder->base;
+
+	connector = drm_bridge_connector_init(dev, encoder);
+	if (IS_ERR(connector)) {
+		dev_err(dev->dev, "Unable to create bridge connector\n");
+		return PTR_ERR(connector);
+	}
+	drm_connector_attach_encoder(connector, encoder);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/loongson/loongson_crtc.c b/drivers/gpu/drm/loongson/loongson_crtc.c
new file mode 100644
index 000000000000..611378cef8e8
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_crtc.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <drm/drm_fourcc.h>
+
+#include "loongson_drv.h"
+
+static void try_each_loopc(u32 clk, u32 pstdiv, u32 frefc,
+			   struct pix_pll *pll_config)
+{
+	u32 loopc;
+	u32 clk_out;
+	u32 precision;
+	u32 min = 1000;
+	u32 base_clk = 100000L;
+
+	for (loopc = LOOPC_MIN; loopc < LOOPC_MAX; loopc++) {
+		if ((loopc < FRE_REF_MIN * frefc) ||
+		    (loopc > FRE_REF_MAX * frefc))
+			continue;
+
+		clk_out = base_clk * loopc / frefc;
+		precision = (clk > clk_out) ? (clk - clk_out) : (clk_out - clk);
+		if (precision < min) {
+			pll_config->l2_div = pstdiv;
+			pll_config->l1_loopc = loopc;
+			pll_config->l1_frefc = frefc;
+		}
+	}
+}
+
+static void cal_freq(u32 pixclock, struct pix_pll *pll_config)
+{
+	u32 pstdiv;
+	u32 frefc;
+	u32 clk;
+
+	for (pstdiv = 1; pstdiv < PST_DIV_MAX; pstdiv++) {
+		clk = pixclock * pstdiv;
+		for (frefc = DIV_REF_MIN; frefc <= DIV_REF_MAX; frefc++)
+			try_each_loopc(clk, pstdiv, frefc, pll_config);
+	}
+}
+
+static void config_pll(struct loongson_device *ldev, unsigned long pll_base,
+		       struct pix_pll *pll_cfg)
+{
+	u32 val;
+	u32 count = 0;
+
+	/* clear sel_pll_out0 */
+	val = ls7a_io_rreg(ldev, pll_base + 0x4);
+	val &= ~(1UL << 8);
+	ls7a_io_wreg(ldev, pll_base + 0x4, val);
+
+	/* set pll_pd */
+	val = ls7a_io_rreg(ldev, pll_base + 0x4);
+	val |= (1UL << 13);
+	ls7a_io_wreg(ldev, pll_base + 0x4, val);
+
+	/* clear set_pll_param */
+	val = ls7a_io_rreg(ldev, pll_base + 0x4);
+	val &= ~(1UL << 11);
+	ls7a_io_wreg(ldev, pll_base + 0x4, val);
+
+	/* clear old value & config new value */
+	val = ls7a_io_rreg(ldev, pll_base + 0x4);
+	val &= ~(0x7fUL << 0);
+	val |= (pll_cfg->l1_frefc << 0); /* refc */
+	ls7a_io_wreg(ldev, pll_base + 0x4, val);
+	val = ls7a_io_rreg(ldev, pll_base + 0x0);
+	val &= ~(0x7fUL << 0);
+	val |= (pll_cfg->l2_div << 0); /* div */
+	val &= ~(0x1ffUL << 21);
+	val |= (pll_cfg->l1_loopc << 21); /* loopc */
+	ls7a_io_wreg(ldev, pll_base + 0x0, val);
+
+	/* set set_pll_param */
+	val = ls7a_io_rreg(ldev, pll_base + 0x4);
+	val |= (1UL << 11);
+	ls7a_io_wreg(ldev, pll_base + 0x4, val);
+	/* clear pll_pd */
+	val = ls7a_io_rreg(ldev, pll_base + 0x4);
+	val &= ~(1UL << 13);
+	ls7a_io_wreg(ldev, pll_base + 0x4, val);
+
+	while (!(ls7a_io_rreg(ldev, pll_base + 0x4) & 0x80)) {
+		cpu_relax();
+		count++;
+		if (count >= 1000) {
+			drm_err(&ldev->dev, "loongson-7A PLL lock failed\n");
+			break;
+		}
+	}
+
+	val = ls7a_io_rreg(ldev, pll_base + 0x4);
+	val |= (1UL << 8);
+	ls7a_io_wreg(ldev, pll_base + 0x4, val);
+}
+
+static void loongson_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct drm_device *dev = crtc->dev;
+	struct loongson_device *ldev = to_loongson_device(dev);
+	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
+	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
+	const struct drm_format_info *format;
+	struct pix_pll pll_cfg;
+	u32 hr, hss, hse, hfl;
+	u32 vr, vss, vse, vfl;
+	u32 pix_freq;
+	u32 reg_offset;
+
+	hr = mode->hdisplay;
+	hss = mode->hsync_start;
+	hse = mode->hsync_end;
+	hfl = mode->htotal;
+
+	vr = mode->vdisplay;
+	vss = mode->vsync_start;
+	vse = mode->vsync_end;
+	vfl = mode->vtotal;
+
+	pix_freq = mode->clock;
+	reg_offset = lcrtc->reg_offset;
+	format = crtc->primary->state->fb->format;
+
+	ls7a_mm_wreg(ldev, FB_DITCFG_REG + reg_offset, 0);
+	ls7a_mm_wreg(ldev, FB_DITTAB_LO_REG + reg_offset, 0);
+	ls7a_mm_wreg(ldev, FB_DITTAB_HI_REG + reg_offset, 0);
+	ls7a_mm_wreg(ldev, FB_PANCFG_REG + reg_offset, FB_PANCFG_DEF);
+	ls7a_mm_wreg(ldev, FB_PANTIM_REG + reg_offset, 0);
+
+	ls7a_mm_wreg(ldev, FB_HDISPLAY_REG + reg_offset, (hfl << 16) | hr);
+	ls7a_mm_wreg(ldev, FB_HSYNC_REG + reg_offset,
+		     FB_HSYNC_PULSE | (hse << 16) | hss);
+
+	ls7a_mm_wreg(ldev, FB_VDISPLAY_REG + reg_offset, (vfl << 16) | vr);
+	ls7a_mm_wreg(ldev, FB_VSYNC_REG + reg_offset,
+		     FB_VSYNC_PULSE | (vse << 16) | vss);
+
+	switch (format->format) {
+	case DRM_FORMAT_RGB565:
+		lcrtc->cfg_reg |= 0x3;
+		break;
+	case DRM_FORMAT_RGB888:
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_ARGB8888:
+	default:
+		lcrtc->cfg_reg |= 0x4;
+		break;
+	}
+
+	ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, lcrtc->cfg_reg);
+
+	cal_freq(pix_freq, &pll_cfg);
+	config_pll(ldev, LS7A_PIX_PLL + reg_offset, &pll_cfg);
+}
+
+static void loongson_crtc_atomic_enable(struct drm_crtc *crtc,
+					struct drm_atomic_state *old_state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct loongson_device *ldev = to_loongson_device(dev);
+	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
+	u32 reg_offset = lcrtc->reg_offset;
+
+	lcrtc->cfg_reg |= CFG_ENABLE;
+	ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, lcrtc->cfg_reg);
+}
+
+static void loongson_crtc_atomic_disable(struct drm_crtc *crtc,
+					 struct drm_atomic_state *old_state)
+{
+	struct drm_device *dev = crtc->dev;
+	struct loongson_device *ldev = to_loongson_device(dev);
+	struct loongson_crtc *lcrtc = to_loongson_crtc(crtc);
+	u32 reg_offset = lcrtc->reg_offset;
+
+	lcrtc->cfg_reg &= ~CFG_ENABLE;
+	ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, lcrtc->cfg_reg);
+}
+
+static enum drm_mode_status loongson_mode_valid(struct drm_crtc *crtc,
+						const struct drm_display_mode *mode)
+{
+	if (mode->hdisplay > 1920)
+		return MODE_BAD;
+	if (mode->vdisplay > 1080)
+		return MODE_BAD;
+	if (mode->hdisplay % 64)
+		return MODE_BAD;
+	if (mode->clock >= 173000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
+static const struct drm_crtc_helper_funcs loongson_crtc_helper_funcs = {
+	.mode_valid = loongson_mode_valid,
+	.atomic_enable = loongson_crtc_atomic_enable,
+	.atomic_disable = loongson_crtc_atomic_disable,
+	.mode_set_nofb = loongson_crtc_mode_set_nofb,
+};
+
+static const struct drm_crtc_funcs loongson_crtc_funcs = {
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+int loongson_crtc_init(struct loongson_device *ldev, int index)
+{
+	struct drm_device *dev = &ldev->dev;
+	struct loongson_plane *plane;
+	struct loongson_crtc *lcrtc;
+
+	plane = loongson_plane_init(dev, index);
+	if (IS_ERR(plane))
+		return PTR_ERR(plane);
+
+	lcrtc = drmm_crtc_alloc_with_planes(dev, struct loongson_crtc, base,
+					    &plane->base, NULL,
+					    &loongson_crtc_funcs, NULL);
+	if (IS_ERR(lcrtc))
+		return PTR_ERR(lcrtc);
+
+	lcrtc->ldev = ldev;
+	lcrtc->reg_offset = index * REG_OFFSET;
+	lcrtc->cfg_reg = CFG_RESET;
+	lcrtc->crtc_id = index;
+	lcrtc->plane = plane;
+
+	drm_crtc_helper_add(&lcrtc->base, &loongson_crtc_helper_funcs);
+
+	ldev->mode_info[index].crtc = lcrtc;
+
+	return 0;
+}
+
diff --git a/drivers/gpu/drm/loongson/loongson_device.c b/drivers/gpu/drm/loongson/loongson_device.c
new file mode 100644
index 000000000000..74089d64f989
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_device.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include "loongson_drv.h"
+
+u32 loongson_gpu_offset(struct drm_plane_state *state,
+			struct loongson_device *ldev)
+{
+	struct drm_gem_vram_object *gbo;
+	u32 gpu_addr;
+
+	gbo = drm_gem_vram_of_gem(state->fb->obj[0]);
+	gpu_addr = ldev->vram_start + drm_gem_vram_offset(gbo);
+
+	return gpu_addr;
+}
+
+u32 ls7a_io_rreg(struct loongson_device *ldev, u32 offset)
+{
+	return readl(ldev->io + offset);
+}
+
+void ls7a_io_wreg(struct loongson_device *ldev, u32 offset, u32 val)
+{
+	writel(val, ldev->io + offset);
+}
+
+u32 ls7a_mm_rreg(struct loongson_device *ldev, u32 offset)
+{
+	return readl(ldev->mmio + offset);
+}
+
+void ls7a_mm_wreg(struct loongson_device *ldev, u32 offset, u32 val)
+{
+	writel(val, ldev->mmio + offset);
+}
diff --git a/drivers/gpu/drm/loongson/loongson_drv.c b/drivers/gpu/drm/loongson/loongson_drv.c
new file mode 100644
index 000000000000..4993b8d9e8ca
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_drv.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+/*
+ * Loongson LS7A1000 bridge chipset drm driver
+ * Author: Yi Li, liyi@loongson.cn
+ *         Chenyang Li, lichenyang@loongson.cn
+ */
+
+#include <linux/console.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_probe_helper.h>
+
+#include "loongson_drv.h"
+
+/* Interface history:
+ * 0.1 - original.
+ */
+#define DRIVER_MAJOR 0
+#define DRIVER_MINOR 1
+
+static const struct drm_mode_config_funcs loongson_mode_funcs = {
+	.fb_create = drm_gem_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+	.output_poll_changed = drm_fb_helper_output_poll_changed,
+	.mode_valid = drm_vram_helper_mode_valid
+};
+
+static int loongson_device_init(struct drm_device *dev)
+{
+	struct loongson_device *ldev = to_loongson_device(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *gpu_pdev;
+	resource_size_t aper_base;
+	resource_size_t aper_size;
+	resource_size_t mmio_base;
+	resource_size_t mmio_size;
+	int ret;
+
+	/* GPU MEM */
+	/* We need get 7A-gpu pci device information for ldev->gpu_pdev */
+	/* dev->pdev save 7A-dc pci device information */
+	gpu_pdev = pci_get_device(PCI_VENDOR_ID_LOONGSON,
+				  PCI_DEVICE_ID_LOONGSON_GPU, NULL);
+	ret = pci_enable_device(gpu_pdev);
+	if (ret)
+		return ret;
+	pci_set_drvdata(gpu_pdev, dev);
+
+	aper_base = pci_resource_start(gpu_pdev, 2);
+	aper_size = pci_resource_len(gpu_pdev, 2);
+	ldev->vram_start = aper_base;
+	ldev->vram_size = aper_size;
+
+	if (!devm_request_mem_region(dev->dev, ldev->vram_start,
+				     ldev->vram_size, "loongson_vram")) {
+		drm_err(dev, "Can't reserve VRAM\n");
+		return -ENXIO;
+	}
+
+	/* DC MEM */
+	mmio_base = pci_resource_start(pdev, 0);
+	mmio_size = pci_resource_len(pdev, 0);
+	ldev->mmio = devm_ioremap(dev->dev, mmio_base, mmio_size);
+	if (!ldev->mmio) {
+		drm_err(dev, "Cannot map mmio region\n");
+		return -ENOMEM;
+	}
+
+	if (!devm_request_mem_region(dev->dev, mmio_base,
+				     mmio_size, "loongson_mmio")) {
+		drm_err(dev, "Can't reserve mmio registers\n");
+		return -ENOMEM;
+	}
+
+	/* DC IO */
+	ldev->io = devm_ioremap(dev->dev, LS7A_CHIPCFG_REG_BASE, 0xf);
+	if (!ldev->io)
+		return -ENOMEM;
+
+	ldev->num_crtc = 2;
+
+	drm_info(dev, "DC mmio base 0x%llx size 0x%llx io 0x%llx\n",
+		 mmio_base, mmio_size, *(u64 *)ldev->io);
+	drm_info(dev, "GPU vram start = 0x%x size = 0x%x\n",
+		 ldev->vram_start, ldev->vram_size);
+
+	return 0;
+}
+
+int loongson_modeset_init(struct loongson_device *ldev)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ldev->num_crtc; i++) {
+		ret = loongson_crtc_init(ldev, i);
+		if (ret) {
+			drm_warn(&ldev->dev, "loongson crtc%d init fail\n", i);
+			continue;
+		}
+
+		ret = loongson_encoder_init(ldev, i);
+		if (ret) {
+			drm_err(&ldev->dev, "loongson_encoder_init failed\n");
+			return ret;
+		}
+
+		ret = loongson_bridge_connector_init(ldev, i);
+		if (ret) {
+			drm_err(&ldev->dev, "loongson_connector_init failed\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int loongson_driver_init(struct drm_device *dev)
+{
+	struct loongson_device *ldev = to_loongson_device(dev);
+	int ret;
+
+	ret = loongson_device_init(dev);
+	if (ret)
+		goto err;
+
+	ret = drmm_vram_helper_init(dev, ldev->vram_start, ldev->vram_size);
+	if (ret) {
+		drm_err(dev, "Error initializing vram %d\n", ret);
+		goto err;
+	}
+
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
+
+	dev->mode_config.min_width = 1;
+	dev->mode_config.min_height = 1;
+	dev->mode_config.max_width = 4096;
+	dev->mode_config.max_height = 4096;
+	dev->mode_config.preferred_depth = 32;
+	dev->mode_config.prefer_shadow = 1;
+	dev->mode_config.fb_base = ldev->vram_start;
+	dev->mode_config.funcs = (void *)&loongson_mode_funcs;
+
+	ret = loongson_modeset_init(ldev);
+	if (ret) {
+		drm_err(dev, "Fatal error during modeset init: %d\n", ret);
+		goto err;
+	}
+
+	drm_kms_helper_poll_init(dev);
+	drm_mode_config_reset(dev);
+
+	return 0;
+
+err:
+	drm_err(dev, "failed to initialize drm driver: %d\n", ret);
+	return ret;
+}
+
+static void loongson_driver_fini(struct drm_device *dev)
+{
+	dev->dev_private = NULL;
+	dev_set_drvdata(dev->dev, NULL);
+}
+
+DEFINE_DRM_GEM_FOPS(fops);
+
+static struct drm_driver loongson_driver = {
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+	.fops = &fops,
+	DRM_GEM_VRAM_DRIVER,
+
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESC,
+	.date = DRIVER_DATE,
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+};
+
+static int loongson_pci_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
+{
+	struct loongson_device *ldev;
+	struct drm_device *dev;
+	int ret;
+
+	DRM_INFO("Start loongson drm probe.\n");
+	ldev = devm_drm_dev_alloc(&pdev->dev, &loongson_driver,
+				  struct loongson_device, dev);
+	if (IS_ERR(ldev))
+		return PTR_ERR(ldev);
+	dev = &ldev->dev;
+
+	pci_set_drvdata(pdev, dev);
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		drm_err(dev, "failed to enable pci device: %d\n", ret);
+		goto err_free;
+	}
+
+	ret = loongson_driver_init(dev);
+	if (ret) {
+		drm_err(dev, "failed to load loongson: %d\n", ret);
+		goto err_pdev;
+	}
+
+	ret = drm_dev_register(dev, 0);
+	if (ret) {
+		drm_err(dev, "failed to register drv for userspace access: %d\n",
+			ret);
+		goto driver_fini;
+	}
+
+	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
+	DRM_INFO("loongson fbdev enabled.\n");
+
+	return 0;
+
+driver_fini:
+	loongson_driver_fini(dev);
+err_pdev:
+	pci_disable_device(pdev);
+err_free:
+	drm_dev_put(dev);
+	return ret;
+}
+
+static void loongson_pci_remove(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+
+	drm_dev_unregister(dev);
+	loongson_driver_fini(dev);
+}
+
+static struct pci_device_id loongson_pci_devices[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC) },
+	{0,}
+};
+
+static struct pci_driver loongson_drm_pci_driver = {
+	.name = DRIVER_NAME,
+	.id_table = loongson_pci_devices,
+	.probe = loongson_pci_probe,
+	.remove = loongson_pci_remove,
+};
+
+static int __init loongson_drm_init(void)
+{
+	return pci_register_driver(&loongson_drm_pci_driver);
+}
+
+static void __exit loongson_drm_exit(void)
+{
+	pci_unregister_driver(&loongson_drm_pci_driver);
+}
+
+module_init(loongson_drm_init);
+module_exit(loongson_drm_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/loongson/loongson_drv.h b/drivers/gpu/drm/loongson/loongson_drv.h
new file mode 100644
index 000000000000..e9e97db00110
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_drv.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef __LOONGSON_DRV_H__
+#define __LOONGSON_DRV_H__
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_bridge.h>
+
+/* General customization:
+ */
+#define DRIVER_AUTHOR "Loongson graphics driver team"
+#define DRIVER_NAME "loongson-drm"
+#define DRIVER_DESC "Loongson LS7A DRM driver"
+#define DRIVER_DATE "20200915"
+
+#define to_loongson_crtc(x) container_of(x, struct loongson_crtc, base)
+#define to_loongson_encoder(x) container_of(x, struct loongson_encoder, base)
+
+#define LS7A_CHIPCFG_REG_BASE (0x10010000)
+#define PCI_DEVICE_ID_LOONGSON_DC 0x7a06
+#define PCI_DEVICE_ID_LOONGSON_GPU 0x7a15
+#define LS7A_PIX_PLL (0x04b0)
+#define REG_OFFSET (0x10)
+#define FB_CFG_REG (0x1240)
+#define FB_ADDR0_REG (0x1260)
+#define FB_ADDR1_REG (0x1580)
+#define FB_STRI_REG (0x1280)
+#define FB_DITCFG_REG (0x1360)
+#define FB_DITTAB_LO_REG (0x1380)
+#define FB_DITTAB_HI_REG (0x13a0)
+#define FB_PANCFG_REG (0x13c0)
+#define FB_PANTIM_REG (0x13e0)
+#define FB_HDISPLAY_REG (0x1400)
+#define FB_HSYNC_REG (0x1420)
+#define FB_VDISPLAY_REG (0x1480)
+#define FB_VSYNC_REG (0x14a0)
+
+#define CFG_FMT GENMASK(2, 0)
+#define CFG_FBSWITCH BIT(7)
+#define CFG_ENABLE BIT(8)
+#define CFG_FBNUM BIT(11)
+#define CFG_GAMMAR BIT(12)
+#define CFG_RESET BIT(20)
+
+#define FB_PANCFG_DEF 0x80001311
+#define FB_HSYNC_PULSE (1 << 30)
+#define FB_VSYNC_PULSE (1 << 30)
+
+/* PIX PLL */
+#define LOOPC_MIN 24
+#define LOOPC_MAX 161
+#define FRE_REF_MIN 12
+#define FRE_REF_MAX 32
+#define DIV_REF_MIN 3
+#define DIV_REF_MAX 5
+#define PST_DIV_MAX 64
+
+struct pix_pll {
+	u32 l2_div;
+	u32 l1_loopc;
+	u32 l1_frefc;
+};
+
+struct loongson_crtc {
+	struct drm_crtc base;
+	struct loongson_device *ldev;
+	u32 crtc_id;
+	u32 reg_offset;
+	u32 cfg_reg;
+	struct loongson_plane *plane;
+};
+
+struct loongson_plane {
+	struct drm_plane base;
+};
+
+struct loongson_encoder {
+	struct drm_encoder base;
+	struct drm_bridge bridge;
+	struct loongson_device *ldev;
+	struct loongson_crtc *lcrtc;
+};
+
+struct loongson_mode_info {
+	struct loongson_crtc *crtc;
+	struct loongson_encoder *encoder;
+};
+
+struct loongson_device {
+	struct drm_device dev;
+	struct drm_atomic_state *state;
+
+	void __iomem *mmio;
+	void __iomem *io;
+	u32 vram_start;
+	u32 vram_size;
+
+	u32 num_crtc;
+	struct loongson_mode_info mode_info[2];
+	struct pci_dev *gpu_pdev; /* LS7A gpu device info */
+};
+
+static inline struct loongson_device *to_loongson_device(struct drm_device *dev)
+{
+	return container_of(dev, struct loongson_device, dev);
+}
+
+/* crtc */
+int loongson_crtc_init(struct loongson_device *ldev, int index);
+
+/* connector */
+int loongson_bridge_connector_init(struct loongson_device *ldev, int index);
+
+/* encoder */
+int loongson_encoder_init(struct loongson_device *ldev, int index);
+
+/* plane */
+struct loongson_plane *loongson_plane_init(struct drm_device *dev, int index);
+
+/* device */
+u32 loongson_gpu_offset(struct drm_plane_state *state,
+			struct loongson_device *dev);
+u32 ls7a_mm_rreg(struct loongson_device *ldev, u32 offset);
+void ls7a_mm_wreg(struct loongson_device *ldev, u32 offset, u32 val);
+u32 ls7a_io_rreg(struct loongson_device *ldev, u32 offset);
+void ls7a_io_wreg(struct loongson_device *ldev, u32 offset, u32 val);
+
+#endif /* __LOONGSON_DRV_H__ */
diff --git a/drivers/gpu/drm/loongson/loongson_encoder.c b/drivers/gpu/drm/loongson/loongson_encoder.c
new file mode 100644
index 000000000000..5b94f707f1a0
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_encoder.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <drm/drm_simple_kms_helper.h>
+
+#include "loongson_drv.h"
+
+static int loongson_bridge_get_modes(struct drm_bridge *bridge,
+				     struct drm_connector *connector)
+{
+	int count;
+
+	count = drm_add_modes_noedid(connector, 1920, 1080);
+	drm_set_preferred_mode(connector, 1024, 768);
+
+	return count;
+}
+
+static const struct drm_bridge_funcs loongson_encoder_bridge_funcs = {
+	.get_modes = loongson_bridge_get_modes,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+};
+
+int loongson_encoder_init(struct loongson_device *ldev, int index)
+{
+	struct drm_device *dev = &ldev->dev;
+	struct loongson_encoder *lencoder;
+	int ret;
+
+	lencoder = drmm_simple_encoder_alloc(dev, struct loongson_encoder,
+					     base, DRM_MODE_ENCODER_DAC);
+	if (IS_ERR(lencoder))
+		return PTR_ERR(lencoder);
+
+	lencoder->base.possible_crtcs = 1 << index;
+	ldev->mode_info[index].encoder = lencoder;
+
+	lencoder->bridge.funcs = &loongson_encoder_bridge_funcs;
+	lencoder->bridge.ops = DRM_BRIDGE_OP_MODES;
+	if (index == 0)
+		lencoder->bridge.type = DRM_MODE_CONNECTOR_VGA;
+	else if (index == 1)
+		lencoder->bridge.type = DRM_MODE_CONNECTOR_DVIA;
+
+	drm_bridge_add(&lencoder->bridge);
+
+	ret = drm_bridge_attach(&lencoder->base, &lencoder->bridge, NULL,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret) {
+		dev_err(dev->dev, "Failed to attach bridge: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/loongson/loongson_plane.c b/drivers/gpu/drm/loongson/loongson_plane.c
new file mode 100644
index 000000000000..04d50bf722f1
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_plane.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <drm/drm_fourcc.h>
+
+#include "loongson_drv.h"
+
+static void loongson_plane_atomic_update(struct drm_plane *plane,
+					 struct drm_atomic_state *state)
+{
+	struct loongson_crtc *lcrtc;
+	struct loongson_device *ldev;
+	struct drm_plane_state *lstate = plane->state;
+	u32 gpu_addr = 0;
+	u32 fb_addr = 0;
+	u32 reg_val = 0;
+	u32 reg_offset;
+	u32 pitch;
+	u8 depth;
+	u32 x, y;
+
+	if (!lstate->crtc || !lstate->fb)
+		return;
+
+	pitch = lstate->fb->pitches[0];
+	lcrtc = to_loongson_crtc(lstate->crtc);
+	ldev = lcrtc->ldev;
+	reg_offset = lcrtc->reg_offset;
+	x = lstate->crtc->x;
+	y = lstate->crtc->y;
+	depth = lstate->fb->format->cpp[0] << 3;
+
+	gpu_addr = loongson_gpu_offset(lstate, ldev);
+	reg_val = (pitch + 255) & ~255;
+	ls7a_mm_wreg(ldev, FB_STRI_REG + reg_offset, reg_val);
+
+	switch (depth) {
+	case 12 ... 16:
+		fb_addr = gpu_addr + y * pitch + ALIGN(x, 64) * 2;
+		break;
+	case 24 ... 32:
+	default:
+		fb_addr = gpu_addr + y * pitch + ALIGN(x, 64) * 4;
+		break;
+	}
+
+	ls7a_mm_wreg(ldev, FB_ADDR0_REG + reg_offset, fb_addr);
+	ls7a_mm_wreg(ldev, FB_ADDR1_REG + reg_offset, fb_addr);
+	reg_val = lcrtc->cfg_reg | CFG_ENABLE;
+	ls7a_mm_wreg(ldev, FB_CFG_REG + reg_offset, reg_val);
+}
+
+static const uint32_t loongson_formats[] = {
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+};
+
+static const uint64_t loongson_format_modifiers[] = { DRM_FORMAT_MOD_LINEAR,
+						      DRM_FORMAT_MOD_INVALID };
+
+static const struct drm_plane_funcs loongson_plane_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.reset = drm_atomic_helper_plane_reset,
+	.update_plane = drm_atomic_helper_update_plane,
+};
+
+static const struct drm_plane_helper_funcs loongson_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_vram_plane_helper_prepare_fb,
+	.cleanup_fb	= drm_gem_vram_plane_helper_cleanup_fb,
+	.atomic_update = loongson_plane_atomic_update,
+};
+
+struct loongson_plane *loongson_plane_init(struct drm_device *dev, int index)
+{
+	struct loongson_plane *plane;
+
+	plane = drmm_universal_plane_alloc(dev, struct loongson_plane, base,
+					   BIT(index), &loongson_plane_funcs,
+					   loongson_formats,
+					   ARRAY_SIZE(loongson_formats),
+					   loongson_format_modifiers,
+					   DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (IS_ERR(plane)) {
+		drm_err(dev, "failed to allocate and initialize plane\n");
+		return plane;
+	}
+
+	drm_plane_helper_add(&plane->base, &loongson_plane_helper_funcs);
+
+	return plane;
+}
-- 
2.25.1

