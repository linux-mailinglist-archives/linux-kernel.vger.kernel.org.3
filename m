Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D73550C2E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiFSQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbiFSQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:50:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD5563A3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so6699307wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4IVWtzGIGF6T142Ol1WYlyrcvd4gV9KicOgInUHMp4=;
        b=fi7iBkKkuE5lWRMzFlkGl9ONXI/rnRp7THWSvCbt0oMVjHWsP/PogJvrdTC0xhYuPI
         G2vJuqusrjZauCPKKn0Z8/oTU0OgTEeH9nLVimEochDedA0t1+JEDWlfTQG/8fKxPlrZ
         VzGNGFNCxWCg2wybkTJ6ShiWP8of4H7gfBwaAr8cPDeJ4IO1F+8dh7jufnvozlTnFdPC
         7JpDsg6OWMimJCXvRrKNDbRI9x6MzTudPZ9ZPTwySNpw3h6TIqMcBO71xK26uVHXHORE
         0GSFiiYkokwDWh49z096UY1jRRdtkxhOtxsO2mdxN48cvbjInzNovP1kkaMZ1hKlm0Or
         Y8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4IVWtzGIGF6T142Ol1WYlyrcvd4gV9KicOgInUHMp4=;
        b=wszS951277+dXE/0gOL6mp8I9n95m4EgM4FUyMWK9Ec/YUTKti3ev63uP96+5/VPkb
         0JFz+cwiM18o+gN++HBvBENHGfN4a5QlQMzyBQE5vHO2zVWx6eXQ/Y6Ke4rXmM6wqSE6
         yXE428Bv/6nC5la+sb33w8Kk8K1pOHGYdwJ0AqijnX/LxNM3XouYiJPrJwv1JkI7tnc9
         4wrJv5uJXMXF+PbnfhCd+h4WThJq81G7VE0XXwyTOahWk4nncgcDTLiSSIWlGai7oTZv
         HBDUChgpYxCs8f7zS9Ub+Y8DMMLRpu+VGLqYEc/3mynCJK2ZOEYX9nXX5RNzDeKvtHtm
         D1rw==
X-Gm-Message-State: AJIora+iiJUgCA3/DsTG0jnGYlwirnMHiuuxDVfp44Hw1ZjkAc9gUceQ
        XLL1lC2FBaQwqXeHYUZovvH4jQ==
X-Google-Smtp-Source: AGRyM1uoTs4zbDrAZOYYa/tC0jlGDutAZWrGhM0SGtfaRxoo30vm5y8mGymmfL7WbNpvzcUmmWDEqA==
X-Received: by 2002:a05:600c:34cc:b0:39c:832c:bd92 with SMTP id d12-20020a05600c34cc00b0039c832cbd92mr20591963wmq.24.1655657421871;
        Sun, 19 Jun 2022 09:50:21 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id m14-20020adfdc4e000000b0021a3c960214sm9189510wrj.6.2022.06.19.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 09:50:21 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC 4/6] reset: add polarfire soc reset support
Date:   Sun, 19 Jun 2022 17:49:34 +0100
Message-Id: <20220619164935.1492823-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619164935.1492823-1-mail@conchuod.ie>
References: <20220619164935.1492823-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add support for the resets on Microchip's PolarFire SoC (MPFS).
Reset control is a single register, wedged in between registers for
clock control. To fit with existed DT etc, the reset controller is
created using the aux device framework & set up in the clock driver.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/reset/Kconfig      |   9 +++
 drivers/reset/Makefile     |   2 +-
 drivers/reset/reset-mpfs.c | 155 +++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/reset/reset-mpfs.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 93c8d07ee328..8f7d7cda690d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -122,6 +122,15 @@ config RESET_MCHP_SPARX5
 	help
 	  This driver supports switch core reset for the Microchip Sparx5 SoC.
 
+config RESET_POLARFIRE_SOC
+	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
+	depends on AUXILIARY_BUS
+	default MCHP_CLK_MPFS
+	help
+	  This driver supports switch core reset for the Microchip PolarFire SoC
+
+	  CONFIG_RESET_MPFS
+
 config RESET_MESON
 	tristate "Meson Reset Driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index a80a9c4008a7..5fac3a753858 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_RESET_K210) += reset-k210.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
+obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
@@ -38,4 +39,3 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
-
diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
new file mode 100644
index 000000000000..6c9c10cd9077
--- /dev/null
+++ b/drivers/reset/reset-mpfs.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PolarFire SoC (MPFS) Peripheral Clock Reset Controller
+ *
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries.
+ *
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <dt-bindings/clock/microchip,mpfs-clock.h>
+#include <soc/microchip/mpfs.h>
+
+/*
+ * The ENVM reset is the lowest bit in the register & I am using the CLK_FOO
+ * defines in the dt to make things easier to configure - so this is accounting
+ * for the offset of 3 there.
+ */
+#define MPFS_PERIPH_OFFSET	CLK_ENVM
+#define MPFS_NUM_RESETS		30u
+
+/*
+ * Peripheral clock resets
+ */
+
+static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	u32 reg;
+
+	reg = mpfs_reset_read(rcdev->dev);
+	reg |= (1u << id);
+	mpfs_reset_write(rcdev->dev, reg);
+
+	dev_dbg(rcdev->dev,
+		"Asserting reset for device with REG_SUBBLK_RESET_CR index: %u\n",
+		id);
+	return 0;
+}
+
+static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	u32 reg, val;
+
+	reg = mpfs_reset_read(rcdev->dev);
+	val = reg & ~(1u << id);
+	mpfs_reset_write(rcdev->dev, val);
+
+	dev_dbg(rcdev->dev,
+		"Deasserting device with REG_SUBBLK_RESET_CR index: %u\n",
+		id);
+
+	return 0;
+}
+
+static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	u32 reg = mpfs_reset_read(rcdev->dev);
+
+	return (reg & (1u << id));
+}
+
+static int mpfs_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	dev_dbg(rcdev->dev,
+		"Resetting device with REG_SUBBLK_RESET_CR index: %u\n",
+		id);
+
+	mpfs_assert(rcdev, id);
+
+	/* Value is stolen from the rcar reset driver, will need changing after RFC */
+	udelay(35);
+
+	mpfs_deassert(rcdev, id);
+
+	return 0;
+}
+
+static const struct reset_control_ops mpfs_reset_ops = {
+	.reset = mpfs_reset,
+	.assert = mpfs_assert,
+	.deassert = mpfs_deassert,
+	.status = mpfs_status,
+};
+
+static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
+			    const struct of_phandle_args *reset_spec)
+{
+	unsigned int index = reset_spec->args[0];
+
+	/*
+	 * CLK_RESERVED does not map to a clock, but it does map to a reset,
+	 * so it has to be accounted for here. It is the reset for the fabric,
+	 * so if this reset gets called - do not reset it.
+	 */
+	if (index == CLK_RESERVED) {
+		dev_err(rcdev->dev, "Resetting the fabric is not supported\n");
+		return -EINVAL;
+	}
+
+	if (index < MPFS_PERIPH_OFFSET || index >= (MPFS_PERIPH_OFFSET + rcdev->nr_resets)) {
+		dev_err(rcdev->dev, "Invalid reset index %u\n", reset_spec->args[0]);
+		return -EINVAL;
+	}
+
+	return index - MPFS_PERIPH_OFFSET;
+}
+
+static int mpfs_reset_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct reset_controller_dev *rcdev;
+	int ret;
+
+	rcdev = devm_kzalloc(dev, sizeof(*rcdev), GFP_KERNEL);
+	if (!rcdev)
+		return -ENOMEM;
+
+	rcdev->dev = dev;
+	rcdev->dev->parent = adev->dev.parent;
+	rcdev->ops = &mpfs_reset_ops;
+	rcdev->of_node = adev->dev.parent->of_node;
+	rcdev->of_reset_n_cells = 1;
+	rcdev->of_xlate = mpfs_reset_xlate;
+	rcdev->nr_resets = MPFS_NUM_RESETS;
+
+	ret = devm_reset_controller_register(dev, rcdev);
+	if (!ret)
+		dev_info(dev, "Registered MPFS reset controller\n");
+
+	return ret;
+}
+
+static const struct auxiliary_device_id mpfs_reset_ids[] = {
+	{
+		.name = "clk_mpfs.reset-mpfs",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, mpfs_reset_ids);
+
+static struct auxiliary_driver mpfs_reset_driver = {
+	.probe		= mpfs_reset_probe,
+	.id_table	= mpfs_reset_ids,
+};
+
+module_auxiliary_driver(mpfs_reset_driver);
+
+MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(MCHP_CLK_MPFS);
-- 
2.36.1

