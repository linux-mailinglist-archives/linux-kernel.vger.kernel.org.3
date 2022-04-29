Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9721A5150D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379146AbiD2Qb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379111AbiD2QbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D185D95DE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e24so11442455wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fMTHSdsVFd99uvEQJ+DUcG1AXQWszBtxSQFK497UfkQ=;
        b=TBh1+9jmwKdoH7zISOSlCGCChLX+5SFhwfAW/s0pd5oL72AyCFK/nUX6D/rrewYSGs
         k+4SeShRSCDgqSQgXBF8ZwlaxlmYCWtHAzTesG7uHQJa0tIZd7ASJsgx7jrnbC8fZl2F
         0qgDKqsr5M69j8MnMuJVrmP5XvheWBtCoROQ8W/ZNLUjGMpXypiYmoClErIEIR13ZUKI
         CvMJSIbR1nBIYfrqgVpCAXHvogN1Fnh6/w965s/tPZpncCU3/A7DCll7z2RSp4w2tfOd
         bvuKSL0muiaa/SCVGLCqWURy37YfbqkLV7Cx6BeNGye/XGycZWJe0/xYxnXS9vwfH1KW
         m73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMTHSdsVFd99uvEQJ+DUcG1AXQWszBtxSQFK497UfkQ=;
        b=x5h0qRxz+n22394O39xp9x7qXhTmTDq6yzuQXYaoW9uYUGZ499a0oR0WbMXHa8zVuX
         Ogc+Nqt9GhkmkWDQ4Bh995y6B6yY1KgFP3Lmmb3v9voPlgAo+6PG7+dfCrzsvFP5Tpdb
         kbDuOXNxdpJlosB6u/zbR3cIeM9tYG/MxTv3peteJLp7cRPnnWkC+SE+Csc34tiX/cbf
         VNOopa26NVBHEKfZXkdA912rdLiKdW4QB8LY1gzZSXEnkEBvqs4kZs7ZrznQFGsbPMZm
         7jLbBwTpcQ2J2cxsTZhWGPFenQXWhSwbiYrMozEy+AWHl6ZILUNBPHocjDiqrhOOu/VQ
         ONBw==
X-Gm-Message-State: AOAM5339mECQgFWGSG1kQ5e1Bj3uYm2/sxnX3GpvBY5PzR6oFaLW7p2F
        XVhyP1Q09WtBicX2WL2RY6sAmg==
X-Google-Smtp-Source: ABdhPJyoK7BUGK4KfNn2zUv3/f0UOihT4V67+sU5fBFqhGpNzML/zqHOMdX+GGrdD6Ib86Llzbn3EA==
X-Received: by 2002:adf:fc52:0:b0:20a:e296:6e8a with SMTP id e18-20020adffc52000000b0020ae2966e8amr16455921wrs.432.1651249678589;
        Fri, 29 Apr 2022 09:27:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:27:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/16] nvmem: Add Apple eFuse driver
Date:   Fri, 29 Apr 2022 17:26:50 +0100
Message-Id: <20220429162701.2222-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Peter <sven@svenpeter.dev>

Apple SoCs contain eFuses used to store factory-programmed data such
as calibration values for the PCIe or the Type-C PHY. They are organized
as 32bit values exposed as MMIO.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig        | 12 ++++++
 drivers/nvmem/Makefile       |  2 +
 drivers/nvmem/apple-efuses.c | 80 ++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/nvmem/apple-efuses.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 555aa77a574d..6283e09cc1e9 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -324,4 +324,16 @@ config NVMEM_SUNPLUS_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sunplus-ocotp.
 
+config NVMEM_APPLE_EFUSES
+	tristate "Apple eFuse support"
+	depends on ARCH_APPLE || COMPILE_TEST
+	default ARCH_APPLE
+	help
+	  Say y here to enable support for reading eFuses on Apple SoCs
+	  such as the M1. These are e.g. used to store factory programmed
+	  calibration data required for the PCIe or the USB-C PHY.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called nvmem-apple-efuses.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 891958e29d25..00e136a0a123 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -65,3 +65,5 @@ obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
 nvmem-layerscape-sfp-y		:= layerscape-sfp.o
 obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
 nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
+obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
+nvmem-apple-efuses-y 		:= apple-efuses.o
diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
new file mode 100644
index 000000000000..9b7c87102104
--- /dev/null
+++ b/drivers/nvmem/apple-efuses.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple SoC eFuse driver
+ *
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+
+struct apple_efuses_priv {
+	void __iomem *fuses;
+};
+
+static int apple_efuses_read(void *context, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct apple_efuses_priv *priv = context;
+	u32 *dst = val;
+
+	while (bytes >= sizeof(u32)) {
+		*dst++ = readl_relaxed(priv->fuses + offset);
+		bytes -= sizeof(u32);
+		offset += sizeof(u32);
+	}
+
+	return 0;
+}
+
+static int apple_efuses_probe(struct platform_device *pdev)
+{
+	struct apple_efuses_priv *priv;
+	struct resource *res;
+	struct nvmem_config config = {
+		.dev = &pdev->dev,
+		.read_only = true,
+		.reg_read = apple_efuses_read,
+		.stride = sizeof(u32),
+		.word_size = sizeof(u32),
+		.name = "apple_efuses_nvmem",
+		.id = NVMEM_DEVID_AUTO,
+		.root_only = true,
+	};
+
+	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->fuses = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->fuses))
+		return PTR_ERR(priv->fuses);
+
+	config.priv = priv;
+	config.size = resource_size(res);
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
+}
+
+static const struct of_device_id apple_efuses_of_match[] = {
+	{ .compatible = "apple,efuses", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, apple_efuses_of_match);
+
+static struct platform_driver apple_efuses_driver = {
+	.driver = {
+		.name = "apple_efuses",
+		.of_match_table = apple_efuses_of_match,
+	},
+	.probe = apple_efuses_probe,
+};
+
+module_platform_driver(apple_efuses_driver);
+
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_LICENSE("GPL");
-- 
2.21.0

