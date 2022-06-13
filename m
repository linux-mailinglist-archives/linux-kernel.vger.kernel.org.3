Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2811054A014
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349883AbiFMUsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343763AbiFMUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:46:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C93EA98
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l4so5423573pgh.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G5AngU4fQLL9tjwfd3M8P7vnWfa9NLIJ0sasw1HKwk0=;
        b=mu1MQUUbKSIWTjXFuH9p5fRtMkj/uh3ZnxEfSrme86jAyFfjIy8octcKZ3zNAX4x9c
         wUnkb7Pm31XhRwRRyE6LbmkkeaxcoeBZLDkixXYqfV794DjWNfiz/mGlQTvWSqTEWWtv
         GqC866XldQ6zuRlUQUd+E5wwXlgg7da2ICjTbSTrIUNFOls4Cp/NjO1QggHYfg77Vqmv
         IOItahUEcwJuZw6gpYbkDj2XO+1nM5uvTzeN/Dupw9QpUJ/TRJOBFLDZ2IoP3JOosR4g
         GHdndKKc4nnSC2cdovhjFcFaV5s1rSJBMKihXZMEouUOTHk2CEILhcxWgL9eChYN+kBi
         bBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G5AngU4fQLL9tjwfd3M8P7vnWfa9NLIJ0sasw1HKwk0=;
        b=UwpdR8avLJoDwf3HHAh7AbB6DKWiFO5mW8F7nwvbio3GSzlhn/0rIwkRvrNWeWnfU4
         Xennc6uiO97Vb6MlaoGiWiIr14I8t6ZrETci6AYG7N+QbPPL6xeHICXVum+9dTunzglf
         x/Sn0u4WTMg5QA+BHzrYIDJIwusmXzlHuHo6jRr16aubyub9RQoeIkypIvr0zLNolXDi
         ywufBKDprcyIDvKMxBtyQARo4LcyzQOcX+eL9C/a4MNfLgHlnqkccSy3XijHWYDN6ReJ
         Owu8Fq8gydquIgcxnf2UepOW92MWY9jftuTFpqqPmqB5c209EsVXJ897gPydK+CE7mrr
         +qsQ==
X-Gm-Message-State: AOAM532F8oogkVwYMp01s5dXCejOEhfltgcNb5Ae3NAXNuB5c8B3L5rt
        iSObnrnpvoHqB8/Qqn8HKHIx3A==
X-Google-Smtp-Source: ABdhPJxT9PVmJkPQk+jDaeQ8grX7yokwcmvdH5gzlVI7dBpN2UU5iRmzY3Wcu+fC+042xx6yhf2Z3A==
X-Received: by 2002:a63:2cd7:0:b0:3fe:1c0a:75ce with SMTP id s206-20020a632cd7000000b003fe1c0a75cemr1128278pgs.602.1655150274127;
        Mon, 13 Jun 2022 12:57:54 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:53 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 15/15] reset: elbasr: Add AMD Pensando Elba SR Reset Controller
Date:   Mon, 13 Jun 2022 12:56:58 -0700
Message-Id: <20220613195658.5607-16-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

This patch adds the reset controller functionality for the
AMD Pensando Elba System Resource Chip.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 drivers/reset/Kconfig                         |  9 ++
 drivers/reset/Makefile                        |  1 +
 drivers/reset/reset-elbasr.c                  | 94 +++++++++++++++++++
 .../reset/amd,pensando-elba-reset.h           | 11 +++
 4 files changed, 115 insertions(+)
 create mode 100644 drivers/reset/reset-elbasr.c
 create mode 100644 include/dt-bindings/reset/amd,pensando-elba-reset.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 93c8d07ee328..13f5a8ca0f03 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -66,6 +66,15 @@ config RESET_BRCMSTB_RESCAL
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
 	  BCM7216.
 
+config RESET_ELBASR
+	tristate "Pensando Elba System Resource reset controller"
+	depends on MFD_PENSANDO_ELBASR || COMPILE_TEST
+	help
+	  This option enables support for the external reset functions
+	  on the Pensando Elba System Resource Chip.  Reset control
+	  of peripherals is accessed over SPI to the system resource
+	  chip device registers using CS0.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index a80a9c4008a7..c0fe12b9950e 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
+obj-$(CONFIG_RESET_ELBASR) += reset-elbasr.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
diff --git a/drivers/reset/reset-elbasr.c b/drivers/reset/reset-elbasr.c
new file mode 100644
index 000000000000..6e429cb11466
--- /dev/null
+++ b/drivers/reset/reset-elbasr.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 AMD Pensando
+ */
+
+#include <linux/mfd/pensando-elbasr.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/regmap.h>
+#include <linux/err.h>
+#include <linux/of.h>
+
+#include <dt-bindings/reset/amd,pensando-elba-reset.h>
+
+struct elbasr_reset {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+};
+
+static inline struct elbasr_reset *to_elbasr_rst(struct reset_controller_dev *rc)
+{
+	return container_of(rc, struct elbasr_reset, rcdev);
+}
+
+static inline int elbasr_reset_shift(unsigned long id)
+{
+	switch (id) {
+	case EMMC_HW_RESET:
+		return 6;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int elbasr_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct elbasr_reset *elbar = to_elbasr_rst(rcdev);
+	u32 mask = 1 << elbasr_reset_shift(id);
+
+	return regmap_update_bits(elbar->regmap, ELBASR_CTRL0_REG, mask, mask);
+}
+
+static int elbasr_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct elbasr_reset *elbar = to_elbasr_rst(rcdev);
+	u32 mask = 1 << elbasr_reset_shift(id);
+
+	return regmap_update_bits(elbar->regmap, ELBASR_CTRL0_REG, mask, 0);
+}
+
+static const struct reset_control_ops elbasr_reset_ops = {
+	.assert	= elbasr_reset_assert,
+	.deassert = elbasr_reset_deassert,
+};
+
+static int elbasr_reset_probe(struct platform_device *pdev)
+{
+	struct elbasr_data *elbasr = dev_get_drvdata(pdev->dev.parent);
+	struct elbasr_reset *elbar;
+	int ret;
+
+	elbar = devm_kzalloc(&pdev->dev, sizeof(struct elbasr_reset),
+			     GFP_KERNEL);
+	if (!elbar)
+		return -ENOMEM;
+
+	elbar->rcdev.owner = THIS_MODULE;
+	elbar->rcdev.nr_resets = ELBASR_NR_RESETS;
+	elbar->rcdev.ops = &elbasr_reset_ops;
+	elbar->rcdev.of_node = pdev->dev.of_node;
+	elbar->regmap = elbasr->elbasr_regs;
+
+	platform_set_drvdata(pdev, elbar);
+
+	ret = devm_reset_controller_register(&pdev->dev, &elbar->rcdev);
+
+	return ret;
+}
+
+static const struct of_device_id elba_reset_dt_match[] = {
+	{ .compatible = "amd,pensando-elbasr-reset", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver elbasr_reset_driver = {
+	.probe	= elbasr_reset_probe,
+	.driver = {
+		.name = "pensando_elbasr_reset",
+		.of_match_table	= elba_reset_dt_match,
+	},
+};
+builtin_platform_driver(elbasr_reset_driver);
diff --git a/include/dt-bindings/reset/amd,pensando-elba-reset.h b/include/dt-bindings/reset/amd,pensando-elba-reset.h
new file mode 100644
index 000000000000..68d69a98e750
--- /dev/null
+++ b/include/dt-bindings/reset/amd,pensando-elba-reset.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2022, AMD Pensando
+ */
+
+#ifndef _DT_BINDINGS_RESET_AMD_PENSANDO_ELBA_RESET_H
+#define _DT_BINDINGS_RESET_AMD_PENSANDO_ELBA_RESET_H
+
+#define EMMC_HW_RESET		0
+
+#endif
-- 
2.17.1

