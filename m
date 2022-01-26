Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1049CEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbiAZPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242925AbiAZPf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:35:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E3C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:35:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r25so9758762wrc.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJUDgun1PLvAPHA3RSmZdqi3fdjg+CZfZnMC6yzDH8o=;
        b=OSZotzZhUZQHNXDbIumw3E+KSL+uwcKBC7bKhZPJzKBN1Fx2gmtzvdrZt3LuVIsSJT
         IC0Xey4CkVX9gunIWYMP79J9jC9mhkQAL/wpO6FT8nEUYY4sP7X4iZOxBF6VVVQIH6oX
         vDKSOwtF11w99x2fU/FQ80Vqd2fsdB7LGeFPgyfjte8F0cFM41XFVO/Mccg67Fe4b28b
         sDTNjpMADCkkCLCyYL1P+ccHALwmJY3X47oH9vxqrKd4MSoi6hLm4PoTj58a1ZA89KB5
         62TfTHp15HG5G0BCv1MA5bb+ttXKdEZcccJMK1k9zsGejNtIUR4Cinu4bVD058kSBsdw
         d0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJUDgun1PLvAPHA3RSmZdqi3fdjg+CZfZnMC6yzDH8o=;
        b=zlrCbpD7KksQlLXpZc545eLAJSaP5y7tiClud56k2LI5Ny2uOBYtusME00AM0AUm9G
         B14/ZboMdKdRVx0Bn4GknRJHsahJ54k3orOJk/m5dXMAOJ+pBIJLvTKGFmVEM/7hcsYF
         JrPPgLUo5kg/iywj1AKTIeI6s5bjYT+sywC5UgOqnWSvAr5QryTwbOOrakzXWkasiiR9
         CAMDNGY1CsHznABFh+Sf9UWSyhn/0Ll7KfODq1V3pQElZqtTnkiANZIpAbIe+mSRAwwW
         YluWVdyo2YUSMtDZoWEqk16GxO2FkWGj1bYd4U5qHMN4rXetDu98s6Yka0Lh7R8L+6fS
         nhrQ==
X-Gm-Message-State: AOAM533ZPpPJDXs1mIDDro9v7G14NWACCdPSX7iAy0UizNNeZ3Zzbwp5
        boIsaMH60xsWDg79uxtsHf2hSQ==
X-Google-Smtp-Source: ABdhPJzI8JGDpv93HownSDPxi+RWrMzvlWWWNDdiW4bed7IhZ/59o9QClGz8WC9/StWgDHzGEHD7sA==
X-Received: by 2002:adf:9dc7:: with SMTP id q7mr22748993wre.148.1643211325870;
        Wed, 26 Jan 2022 07:35:25 -0800 (PST)
Received: from mkorpershoek-XPS-13-9370.. (laubervilliers-656-1-151-143.w92-154.abo.wanadoo.fr. [92.154.18.143])
        by smtp.gmail.com with ESMTPSA id n10sm3360958wmr.25.2022.01.26.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:35:25 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v19 2/3] Input: mt6779-keypad - Add MediaTek keypad driver
Date:   Wed, 26 Jan 2022 16:35:18 +0100
Message-Id: <20220126153519.3637496-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220126153519.3637496-1-mkorpershoek@baylibre.com>
References: <20220126153519.3637496-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "fengping.yu" <fengping.yu@mediatek.com>

This patch adds matrix keypad support for Mediatek SoCs.

Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/input/keyboard/Kconfig         |  12 ++
 drivers/input/keyboard/Makefile        |   1 +
 drivers/input/keyboard/mt6779-keypad.c | 218 +++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/input/keyboard/mt6779-keypad.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 0c607da9ee10..03a9530f620e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -779,6 +779,18 @@ config KEYBOARD_BCM
 	  To compile this driver as a module, choose M here: the
 	  module will be called bcm-keypad.
 
+config KEYBOARD_MT6779
+	tristate "MediaTek Keypad Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select REGMAP_MMIO
+	select INPUT_MATRIXKMAP
+	help
+	  Say Y here if you want to use the keypad on MediaTek SoCs.
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mt6779-keypad.
+
 config KEYBOARD_MTK_PMIC
 	tristate "MediaTek PMIC keys support"
 	depends on MFD_MT6397
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index e3c8648f834e..721936e90290 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
 obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
 obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
+obj-$(CONFIG_KEYBOARD_MT6779)		+= mt6779-keypad.o
 obj-$(CONFIG_KEYBOARD_MTK_PMIC) 	+= mtk-pmic-keys.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_NOMADIK)		+= nomadik-ske-keypad.o
diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
new file mode 100644
index 000000000000..1564ed529e09
--- /dev/null
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ * Author Fengping Yu <fengping.yu@mediatek.com>
+ */
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MTK_KPD_NAME		"mt6779-keypad"
+#define MTK_KPD_MEM		0x0004
+#define MTK_KPD_DEBOUNCE	0x0018
+#define MTK_KPD_DEBOUNCE_MASK	GENMASK(13, 0)
+#define MTK_KPD_DEBOUNCE_MAX_US	256000
+#define MTK_KPD_NUM_MEMS	5
+#define MTK_KPD_NUM_BITS	136	/* 4*32+8 MEM5 only use 8 BITS */
+
+struct mt6779_keypad {
+	struct regmap *regmap;
+	struct input_dev *input_dev;
+	struct clk *clk;
+	void __iomem *base;
+	u32 n_rows;
+	u32 n_cols;
+	DECLARE_BITMAP(keymap_state, MTK_KPD_NUM_BITS);
+};
+
+static const struct regmap_config mt6779_keypad_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = 36,
+};
+
+static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
+{
+	struct mt6779_keypad *keypad = dev_id;
+	unsigned short *keycode = keypad->input_dev->keycode;
+	DECLARE_BITMAP(new_state, MTK_KPD_NUM_BITS);
+	DECLARE_BITMAP(change, MTK_KPD_NUM_BITS);
+	int bit_nr;
+	int pressed;
+	unsigned short code;
+	int row, col;
+	int row_shift = get_count_order(keypad->n_cols);
+
+	regmap_bulk_read(keypad->regmap, MTK_KPD_MEM,
+			 new_state, MTK_KPD_NUM_MEMS);
+
+	bitmap_xor(change, new_state, keypad->keymap_state, MTK_KPD_NUM_BITS);
+
+	for_each_set_bit(bit_nr, change, MTK_KPD_NUM_BITS) {
+	/* For 32bits register, only bits [15:0] use to indicate key status */
+		if (bit_nr % 32 >= 16)
+			continue;
+
+		/* 1: not pressed, 0: pressed */
+		pressed = !test_bit(bit_nr, new_state);
+		dev_dbg(&keypad->input_dev->dev, "%s",
+			pressed ? "pressed" : "released");
+
+		row = bit_nr / 32;
+		col = bit_nr % 32;
+
+		code = keycode[MATRIX_SCAN_CODE(row, col, row_shift)];
+
+		input_report_key(keypad->input_dev, code, pressed);
+		input_sync(keypad->input_dev);
+
+		dev_dbg(&keypad->input_dev->dev,
+			"report Linux keycode = %d\n", code);
+	}
+
+	bitmap_copy(keypad->keymap_state, new_state, MTK_KPD_NUM_BITS);
+
+	return IRQ_HANDLED;
+}
+
+static void mt6779_keypad_clk_disable(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
+{
+	struct mt6779_keypad *keypad;
+	unsigned int irq;
+	u32 debounce;
+	bool wakeup;
+	int error;
+
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
+	if (!keypad)
+		return -ENOMEM;
+
+	keypad->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(keypad->base))
+		return PTR_ERR(keypad->base);
+
+	keypad->regmap = devm_regmap_init_mmio(&pdev->dev,
+					       keypad->base,
+					       &mt6779_keypad_regmap_cfg);
+	if (IS_ERR(keypad->regmap)) {
+		dev_err(&pdev->dev,
+			"regmap init failed:%pe\n", keypad->regmap);
+		return PTR_ERR(keypad->regmap);
+	}
+
+	bitmap_fill(keypad->keymap_state, MTK_KPD_NUM_BITS);
+
+	keypad->input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!keypad->input_dev) {
+		dev_err(&pdev->dev, "Failed to allocate input dev\n");
+		return -ENOMEM;
+	}
+
+	keypad->input_dev->name = MTK_KPD_NAME;
+	keypad->input_dev->id.bustype = BUS_HOST;
+
+	error = matrix_keypad_parse_properties(&pdev->dev, &keypad->n_rows,
+					       &keypad->n_cols);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to parse keypad params\n");
+		return error;
+	}
+
+	if (device_property_read_u32(&pdev->dev, "mediatek,debounce-us",
+				     &debounce))
+		debounce = 16000;
+
+	if (debounce > MTK_KPD_DEBOUNCE_MAX_US) {
+		dev_err(&pdev->dev, "Debounce time exceeds the maximum allowed time %dus\n",
+			MTK_KPD_DEBOUNCE_MAX_US);
+		return -EINVAL;
+	}
+
+	wakeup = device_property_read_bool(&pdev->dev, "wakeup-source");
+
+	dev_dbg(&pdev->dev, "n_row=%d n_col=%d debounce=%d\n",
+		keypad->n_rows, keypad->n_cols, debounce);
+
+	error = matrix_keypad_build_keymap(NULL, NULL,
+					   keypad->n_rows,
+					   keypad->n_cols,
+					   NULL,
+					   keypad->input_dev);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to build keymap\n");
+		return error;
+	}
+
+	regmap_write(keypad->regmap, MTK_KPD_DEBOUNCE,
+		     debounce * 32 / 1000 & MTK_KPD_DEBOUNCE_MASK);
+
+	keypad->clk = devm_clk_get(&pdev->dev, "kpd");
+	if (IS_ERR(keypad->clk))
+		return PTR_ERR(keypad->clk);
+
+	error = clk_prepare_enable(keypad->clk);
+	if (error) {
+		dev_err(&pdev->dev, "cannot prepare/enable keypad clock\n");
+		return error;
+	}
+
+	error = devm_add_action_or_reset(&pdev->dev, mt6779_keypad_clk_disable, keypad->clk);
+	if (error)
+		return error;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	error = devm_request_threaded_irq(&pdev->dev, irq,
+					  NULL, mt6779_keypad_irq_handler,
+					  IRQF_ONESHOT,
+					  MTK_KPD_NAME, keypad);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to request IRQ#%d:%d\n",
+			irq, error);
+		return error;
+	}
+
+	error = input_register_device(keypad->input_dev);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to register device\n");
+		return error;
+	}
+
+	error =  device_init_wakeup(&pdev->dev, wakeup);
+	if (error)
+		dev_warn(&pdev->dev, "device_init_wakeup fail\n");
+
+	return 0;
+}
+
+static const struct of_device_id mt6779_keypad_of_match[] = {
+	{ .compatible = "mediatek,mt6779-keypad" },
+	{ .compatible = "mediatek,mt6873-keypad" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver mt6779_keypad_pdrv = {
+	.probe = mt6779_keypad_pdrv_probe,
+	.driver = {
+		   .name = MTK_KPD_NAME,
+		   .of_match_table = mt6779_keypad_of_match,
+	},
+};
+module_platform_driver(mt6779_keypad_pdrv);
+
+MODULE_AUTHOR("Mediatek Corporation");
+MODULE_DESCRIPTION("MTK Keypad (KPD) Driver");
+MODULE_LICENSE("GPL");
-- 
2.32.0

