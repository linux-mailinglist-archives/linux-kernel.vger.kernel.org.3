Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5608355A83F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiFYJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiFYJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:07:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB70637BE7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:07:38 -0700 (PDT)
Received: from li-amd.loongson.cn (unknown [10.20.42.157])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP9hH0LZiccpYAA--.3313S3;
        Sat, 25 Jun 2022 17:07:21 +0800 (CST)
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
Subject: [PATCH v7 2/4] drm/loongson: Add GPIO and I2C driver for loongson drm.
Date:   Sat, 25 Jun 2022 17:07:13 +0800
Message-Id: <20220625090715.3663-2-lichenyang@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220625090715.3663-1-lichenyang@loongson.cn>
References: <20220625090715.3663-1-lichenyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxP9hH0LZiccpYAA--.3313S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Cry5Jw17Xw4fWFyxXFWrZrb_yoWkur1xpr
        4fAa4YgrW5AF4293s8AFWrAr15A34akasxGFW7Gw1I9ryDJ34UZr95tFWUtFW7AFWUGry2
        qrykGrWrWF1jgw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x0JU2_M3UUUUU=
X-CM-SenderInfo: xolfxvxq1d0wo6or00hjvr0hdfq/1tbiAQAIA13QvPp0bgADsY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement use GPIO and I2C driver to detect connector
and fetch EDID via DDC.

v5:
- Use braidge->ddc to get EDID and detect connector.

v4:
- Delete the gpio_chip subsystem call.
- Delete some redundant prints.

v3:
- Change some driver log to the drm_ version.

v2:
- Optimize the error handling process.
- Delete loongson_i2c_bus_match and loongson_i2c_add function.
- Optimize part of the code flow.

Signed-off-by: Yi Li <liyi@loongson.cn>
Signed-off-by: Chenyang Li <lichenyang@loongson.cn>
---
 drivers/gpu/drm/loongson/Makefile           |   1 +
 drivers/gpu/drm/loongson/loongson_drv.c     |  13 +-
 drivers/gpu/drm/loongson/loongson_drv.h     |   7 +
 drivers/gpu/drm/loongson/loongson_encoder.c |  31 +++-
 drivers/gpu/drm/loongson/loongson_i2c.c     | 191 ++++++++++++++++++++
 drivers/gpu/drm/loongson/loongson_i2c.h     |  33 ++++
 6 files changed, 266 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/loongson/loongson_i2c.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_i2c.h

diff --git a/drivers/gpu/drm/loongson/Makefile b/drivers/gpu/drm/loongson/Makefile
index 534a64047fb6..4a5fab7d000b 100644
--- a/drivers/gpu/drm/loongson/Makefile
+++ b/drivers/gpu/drm/loongson/Makefile
@@ -9,5 +9,6 @@ loongson-y := loongson_connector.o \
 	loongson_device.o \
 	loongson_drv.o \
 	loongson_encoder.o \
+	loongson_i2c.o \
 	loongson_plane.o
 obj-$(CONFIG_DRM_LOONGSON) += loongson.o
diff --git a/drivers/gpu/drm/loongson/loongson_drv.c b/drivers/gpu/drm/loongson/loongson_drv.c
index 4993b8d9e8ca..2e3ef6193767 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.c
+++ b/drivers/gpu/drm/loongson/loongson_drv.c
@@ -22,9 +22,10 @@
 
 /* Interface history:
  * 0.1 - original.
+ * 0.2 - add i2c and connector detect.
  */
 #define DRIVER_MAJOR 0
-#define DRIVER_MINOR 1
+#define DRIVER_MINOR 2
 
 static const struct drm_mode_config_funcs loongson_mode_funcs = {
 	.fb_create = drm_gem_fb_create,
@@ -88,6 +89,14 @@ static int loongson_device_init(struct drm_device *dev)
 
 	ldev->num_crtc = 2;
 
+	ret = loongson_dc_gpio_init(ldev);
+	if (ret)
+		return ret;
+
+	ret = loongson_i2c_init(ldev);
+	if (ret)
+		return ret;
+
 	drm_info(dev, "DC mmio base 0x%llx size 0x%llx io 0x%llx\n",
 		 mmio_base, mmio_size, *(u64 *)ldev->io);
 	drm_info(dev, "GPU vram start = 0x%x size = 0x%x\n",
@@ -96,7 +105,7 @@ static int loongson_device_init(struct drm_device *dev)
 	return 0;
 }
 
-int loongson_modeset_init(struct loongson_device *ldev)
+static int loongson_modeset_init(struct loongson_device *ldev)
 {
 	int i;
 	int ret;
diff --git a/drivers/gpu/drm/loongson/loongson_drv.h b/drivers/gpu/drm/loongson/loongson_drv.h
index e9e97db00110..5be29d2d1a49 100644
--- a/drivers/gpu/drm/loongson/loongson_drv.h
+++ b/drivers/gpu/drm/loongson/loongson_drv.h
@@ -10,6 +10,8 @@
 #include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_bridge.h>
 
+#include "loongson_i2c.h"
+
 /* General customization:
  */
 #define DRIVER_AUTHOR "Loongson graphics driver team"
@@ -102,6 +104,8 @@ struct loongson_device {
 	u32 num_crtc;
 	struct loongson_mode_info mode_info[2];
 	struct pci_dev *gpu_pdev; /* LS7A gpu device info */
+
+	struct loongson_i2c i2c_bus[DC_MAX_I2C_BUS];
 };
 
 static inline struct loongson_device *to_loongson_device(struct drm_device *dev)
@@ -121,6 +125,9 @@ int loongson_encoder_init(struct loongson_device *ldev, int index);
 /* plane */
 struct loongson_plane *loongson_plane_init(struct drm_device *dev, int index);
 
+/* i2c */
+int loongson_dc_gpio_init(struct loongson_device *ldev);
+
 /* device */
 u32 loongson_gpu_offset(struct drm_plane_state *state,
 			struct loongson_device *dev);
diff --git a/drivers/gpu/drm/loongson/loongson_encoder.c b/drivers/gpu/drm/loongson/loongson_encoder.c
index 5b94f707f1a0..accf144479f8 100644
--- a/drivers/gpu/drm/loongson/loongson_encoder.c
+++ b/drivers/gpu/drm/loongson/loongson_encoder.c
@@ -7,19 +7,31 @@
 
 #include "loongson_drv.h"
 
-static int loongson_bridge_get_modes(struct drm_bridge *bridge,
-				     struct drm_connector *connector)
+enum drm_connector_status loongson_bridge_detect(struct drm_bridge *bridge)
 {
-	int count;
+	unsigned char start = 0x0;
+	struct i2c_msg msgs = {
+		.addr = DDC_ADDR,
+		.flags = 0,
+		.len = 1,
+		.buf = &start,
+	};
 
-	count = drm_add_modes_noedid(connector, 1920, 1080);
-	drm_set_preferred_mode(connector, 1024, 768);
+	if (i2c_transfer(bridge->ddc, &msgs, 1) != 1)
+		return connector_status_disconnected;
+	else
+		return connector_status_connected;
+}
 
-	return count;
+static struct edid *loongson_bridge_get_edid(struct drm_bridge *bridge,
+					     struct drm_connector *connector)
+{
+	return drm_get_edid(connector, bridge->ddc);
 }
 
 static const struct drm_bridge_funcs loongson_encoder_bridge_funcs = {
-	.get_modes = loongson_bridge_get_modes,
+	.detect = loongson_bridge_detect,
+	.get_edid = loongson_bridge_get_edid,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
@@ -40,7 +52,10 @@ int loongson_encoder_init(struct loongson_device *ldev, int index)
 	ldev->mode_info[index].encoder = lencoder;
 
 	lencoder->bridge.funcs = &loongson_encoder_bridge_funcs;
-	lencoder->bridge.ops = DRM_BRIDGE_OP_MODES;
+	lencoder->bridge.ddc = ldev->i2c_bus[index].adapter;
+	lencoder->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
+			       | DRM_BRIDGE_OP_MODES;
+
 	if (index == 0)
 		lencoder->bridge.type = DRM_MODE_CONNECTOR_VGA;
 	else if (index == 1)
diff --git a/drivers/gpu/drm/loongson/loongson_i2c.c b/drivers/gpu/drm/loongson/loongson_i2c.c
new file mode 100644
index 000000000000..acc50ca3df22
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_i2c.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include "loongson_drv.h"
+#include "loongson_i2c.h"
+
+static inline void dc_gpio_set_dir(struct loongson_device *ldev,
+				   unsigned int pin, int input)
+{
+	u32 temp;
+
+	temp = ls7a_mm_rreg(ldev, LS7A_DC_GPIO_CFG_OFFSET);
+	if (input)
+		temp |= 1UL << pin;
+	else
+		temp &= ~(1UL << pin);
+
+	ls7a_mm_wreg(ldev, LS7A_DC_GPIO_CFG_OFFSET, temp);
+}
+
+static void dc_gpio_set_val(struct loongson_device *ldev, unsigned int pin,
+			    int high)
+{
+	u32 temp;
+
+	temp = ls7a_mm_rreg(ldev, LS7A_DC_GPIO_OUT_OFFSET);
+	if (high)
+		temp |= 1UL << pin;
+	else
+		temp &= ~(1UL << pin);
+
+	ls7a_mm_wreg(ldev, LS7A_DC_GPIO_OUT_OFFSET, temp);
+}
+
+static void loongson_i2c_set_data(void *i2c, int value)
+{
+	struct loongson_i2c *li2c = i2c;
+	struct loongson_device *ldev = li2c->ldev;
+	unsigned int pin = li2c->data;
+
+	if (value)
+		dc_gpio_set_dir(ldev, pin, 1);
+	else {
+		dc_gpio_set_val(ldev, pin, 0);
+		dc_gpio_set_dir(ldev, pin, 0);
+	}
+}
+
+static void loongson_i2c_set_clock(void *i2c, int value)
+{
+	struct loongson_i2c *li2c = i2c;
+	struct loongson_device *ldev = li2c->ldev;
+	unsigned int pin = li2c->clock;
+
+	if (value)
+		dc_gpio_set_dir(ldev, pin, 1);
+	else {
+		dc_gpio_set_val(ldev, pin, 0);
+		dc_gpio_set_dir(ldev, pin, 0);
+	}
+}
+
+static int loongson_i2c_get_data(void *i2c)
+{
+	int val;
+	struct loongson_i2c *li2c = i2c;
+	struct loongson_device *ldev = li2c->ldev;
+	unsigned int pin = li2c->data;
+
+	val = ls7a_mm_rreg(ldev, LS7A_DC_GPIO_IN_OFFSET);
+
+	return (val >> pin) & 1;
+}
+
+static int loongson_i2c_get_clock(void *i2c)
+{
+	int val;
+	struct loongson_i2c *li2c = i2c;
+	struct loongson_device *ldev = li2c->ldev;
+	unsigned int pin = li2c->clock;
+
+	val = ls7a_mm_rreg(ldev, LS7A_DC_GPIO_IN_OFFSET);
+
+	return (val >> pin) & 1;
+}
+
+static int loongson_i2c_create(struct loongson_device *ldev,
+			       struct loongson_i2c *li2c, const char *name)
+{
+	int ret;
+	unsigned int i2c_num;
+	struct drm_device *dev = &ldev->dev;
+	struct i2c_client *i2c_cli;
+	struct i2c_adapter *i2c_adapter;
+	struct i2c_algo_bit_data *i2c_algo_data;
+	const struct i2c_board_info i2c_info = {
+		.type = "ddc-dev",
+		.addr = DDC_ADDR,
+		.flags = I2C_CLASS_DDC,
+	};
+
+	i2c_num = li2c->i2c_id;
+	i2c_adapter = devm_kzalloc(dev->dev, sizeof(*i2c_adapter), GFP_KERNEL);
+	if (!i2c_adapter)
+		return -ENOMEM;
+
+	i2c_algo_data = devm_kzalloc(dev->dev, sizeof(*i2c_algo_data), GFP_KERNEL);
+	if (!i2c_algo_data) {
+		ret = -ENOMEM;
+		goto free_adapter;
+	}
+
+	i2c_adapter->owner = THIS_MODULE;
+	i2c_adapter->class = I2C_CLASS_DDC;
+	i2c_adapter->algo_data = i2c_algo_data;
+	i2c_adapter->dev.parent = dev->dev;
+	i2c_adapter->nr = -1;
+	snprintf(i2c_adapter->name, sizeof(i2c_adapter->name), "%s%d",
+		 name, i2c_num);
+
+	li2c->data = i2c_num * 2;
+	li2c->clock = i2c_num * 2 + 1;
+	DRM_INFO("Created i2c-%d, sda=%d, scl=%d\n",
+		 i2c_num, li2c->data, li2c->clock);
+
+	i2c_algo_data->setsda = loongson_i2c_set_data;
+	i2c_algo_data->setscl = loongson_i2c_set_clock;
+	i2c_algo_data->getsda = loongson_i2c_get_data;
+	i2c_algo_data->getscl = loongson_i2c_get_clock;
+	i2c_algo_data->udelay = DC_I2C_TON;
+	i2c_algo_data->timeout = usecs_to_jiffies(2200);
+
+	ret = i2c_bit_add_numbered_bus(i2c_adapter);
+	if (ret)
+		goto free_algo_data;
+
+	li2c->adapter = i2c_adapter;
+	i2c_algo_data->data = li2c;
+	i2c_set_adapdata(li2c->adapter, li2c);
+	li2c->ldev = ldev;
+	DRM_INFO("Register i2c algo-bit adapter [%s]\n", i2c_adapter->name);
+
+	i2c_cli = i2c_new_client_device(i2c_adapter, &i2c_info);
+	if (IS_ERR(i2c_cli)) {
+		ret = PTR_ERR(i2c_cli);
+		goto remove_i2c_adapter;
+	}
+
+	return 0;
+
+remove_i2c_adapter:
+	drm_err(dev, "Failed to create i2c client\n");
+	i2c_del_adapter(i2c_adapter);
+free_algo_data:
+	drm_err(dev, "Failed to register i2c adapter %s\n", i2c_adapter->name);
+	kfree(i2c_algo_data);
+free_adapter:
+	kfree(i2c_adapter);
+
+	return ret;
+}
+
+int loongson_dc_gpio_init(struct loongson_device *ldev)
+{
+	int pin;
+
+	/* set gpio dir output 0-3 */
+	for (pin = 0; pin < 4; pin++) {
+		dc_gpio_set_val(ldev, pin, 0);
+		dc_gpio_set_dir(ldev, pin, 0);
+	}
+
+	return 0;
+}
+
+int loongson_i2c_init(struct loongson_device *ldev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		ldev->i2c_bus[1].i2c_id = i;
+		ret = loongson_i2c_create(ldev, &ldev->i2c_bus[i], DC_I2C_NAME);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/loongson/loongson_i2c.h b/drivers/gpu/drm/loongson/loongson_i2c.h
new file mode 100644
index 000000000000..9944c838d3e4
--- /dev/null
+++ b/drivers/gpu/drm/loongson/loongson_i2c.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef __LOONGSON_I2C_H__
+#define __LOONGSON_I2C_H__
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <drm/drm_edid.h>
+
+#define DC_I2C_TON 5
+#define DC_I2C_NAME "ls_dc_i2c"
+#define DC_MAX_I2C_BUS 2
+
+#define LS7A_DC_GPIO_CFG_OFFSET (0x1660)
+#define LS7A_DC_GPIO_IN_OFFSET (0x1650)
+#define LS7A_DC_GPIO_OUT_OFFSET (0x1650)
+
+struct loongson_device;
+struct loongson_i2c {
+	struct loongson_device *ldev;
+	struct i2c_adapter *adapter;
+	u32 data;
+	u32 clock;
+	u32 i2c_id;
+};
+
+int loongson_i2c_init(struct loongson_device *ldev);
+
+#endif /* __LOONGSON_I2C_H__ */
-- 
2.25.1

