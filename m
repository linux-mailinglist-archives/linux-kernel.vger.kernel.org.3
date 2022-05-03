Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8132F518A94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbiECRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiECRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:00:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BA11B782;
        Tue,  3 May 2022 09:57:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so34608236ejd.9;
        Tue, 03 May 2022 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHOx7X9A4O69jtsSZ/TPAtqhJM5FpsKMfp8Pb614NIs=;
        b=kpa6xdPB66Z62FPAYwyeOOr/1kU+mzsSftXrHsMWebzFxkDFXtAPFZNslSvef83phx
         IDwDi9pj+B4kaEEXraajmLnI5SUXRJoK19Qr1xnyiBzl3oPyvT8kmFFihLQd8twNV9aj
         fTXAeKNftTZ58wath8GKQP5O+xZ6EKs10yr4xmV6/GkR+TJM/5Oij8bn3Shyc/yFCmxF
         Pv5M3g5VOsRgXBk8FZePWDievNIMx2DBEkGs2GdqtrELo+OAytqf5prD53WwmGdXrWa+
         SZlYhCU3ZO4bwJf23vfY9aKE3BZw+cdxO+c5oz3Ak1aL3wnIsoOabMTk04ObEIKJHki1
         Py8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FHOx7X9A4O69jtsSZ/TPAtqhJM5FpsKMfp8Pb614NIs=;
        b=bHG97nbO4jCIozJgHxNWR217Az8iG4hYcKvpSGO+58MPLnvvF+MmmxMMbh1FYyo1UF
         yjFRQIgVcbJXqhf+avA8z3uDxsOhPzDp+LiaXYbQ97ZVz4ASG8yob/lFGAopFMhTmgSe
         qSu0B1+nX7N6HYIIBKrrH3w7uS46fOcSR0ngjC5qT3Kp6p1dSvN/X+7pLlBdfq1V7qNN
         gZhDu9T3mZUV8JVXyXFKX9uBPRf98huHissayE+CYYuKNDC70iHqJtoABfBC2FOlxwcO
         5Xw8fG0COsA5YqiRKxrI/+FgzXpVTPg/dFhOe0GbcIbJJMe/UB2GGWc/aZ9JtI4Lkhc4
         EaMg==
X-Gm-Message-State: AOAM532RXkoTMxSrz3vRn1Udg91q9585XDmdCD+E4RZRucZYOz9ER8qd
        bvOVGd2weBh2ycntLrhN8LQ=
X-Google-Smtp-Source: ABdhPJxle9yAHULrxATXQ/5ww0BYx6fgd2xWckwxu2vZKsb6owvmcyPBDMC86ltVq2jCtbhi9Jlj3g==
X-Received: by 2002:a17:907:608f:b0:6f4:aa0c:2e45 with SMTP id ht15-20020a170907608f00b006f4aa0c2e45mr1276676ejc.111.1651597027943;
        Tue, 03 May 2022 09:57:07 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e31sm4797107ejc.151.2022.05.03.09.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 09:57:07 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] nvmem: add driver handling U-Boot environment variables
Date:   Tue,  3 May 2022 18:56:58 +0200
Message-Id: <20220503165658.13932-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot stores its setup as environment variables. It's a list of
key-value pairs stored on flash device with a custom header.

This commit adds an NVMEM driver that:
1. Provides NVMEM access to environment vars binary data
2. Extracts variables as NVMEM cells

It can be used for:
1. Accessing env variables from user-space
2. Reading NVMEM cells by Linux drivers

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Drop ARCH_BCM4908 dependency as there are plenty architectures using
    U-Boot bootloader. Thanks Srinivas.
---
 MAINTAINERS                |   1 +
 drivers/nvmem/Kconfig      |  11 ++
 drivers/nvmem/Makefile     |   2 +
 drivers/nvmem/u-boot-env.c | 236 +++++++++++++++++++++++++++++++++++++
 4 files changed, 250 insertions(+)
 create mode 100644 drivers/nvmem/u-boot-env.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2869a958f5e4..368e532444d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20193,6 +20193,7 @@ U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
 M:	Zhangfei Gao <zhangfei.gao@linaro.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 967d0084800e..eee3ff668629 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -337,4 +337,15 @@ config NVMEM_APPLE_EFUSES
 	  This driver can also be built as a module. If so, the module will
 	  be called nvmem-apple-efuses.
 
+config NVMEM_U_BOOT_ENV
+	tristate "U-Boot environment variables support"
+	depends on OF && MTD
+	select CRC32
+	help
+	  U-Boot stores its setup as environment variables. This driver adds
+	  support for verifying & exporting such data. It also exposes variables
+	  as NVMEM cells so they can be referenced by other drivers.
+
+	  If compiled as module it will be called nvmem_u-boot-env.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 00e136a0a123..d201a02a09ec 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -67,3 +67,5 @@ obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
 nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 		:= apple-efuses.o
+obj-$(CONFIG_NVMEM_U_BOOT_ENV)	+= nvmem_u-boot-env.o
+nvmem_u-boot-env-y		:= u-boot-env.o
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
new file mode 100644
index 000000000000..c7945d7d5750
--- /dev/null
+++ b/drivers/nvmem/u-boot-env.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/crc32.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+enum u_boot_env_format {
+	U_BOOT_FORMAT_SINGLE,
+	U_BOOT_FORMAT_REDUNDANT,
+};
+
+struct u_boot_env {
+	struct device *dev;
+	enum u_boot_env_format format;
+
+	/* Parent device */
+	struct mtd_info *mtd;
+	size_t offset;
+	size_t size;
+
+	/* Cells */
+	struct nvmem_cell_info *cells;
+	int ncells;
+};
+
+struct u_boot_env_image_single {
+	__le32 crc32;
+	uint8_t data[0];
+} __packed;
+
+struct u_boot_env_image_redundant {
+	__le32 crc32;
+	u8 mark;
+	uint8_t data[0];
+} __packed;
+
+static int u_boot_env_read(void *context, unsigned int offset, void *val,
+			   size_t bytes)
+{
+	struct u_boot_env *priv = context;
+	struct device *dev = priv->dev;
+	size_t bytes_read;
+	int err;
+
+	err = mtd_read(priv->mtd, priv->offset + offset, bytes, &bytes_read, val);
+	if (err && !mtd_is_bitflip(err)) {
+		dev_err(dev, "Failed to read from mtd: %d\n", err);
+		return err;
+	}
+
+	if (bytes_read != bytes) {
+		dev_err(dev, "Failed to read %zd bytes\n", bytes);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
+				size_t data_offset, size_t data_len)
+{
+	struct device *dev = priv->dev;
+	char *data = buf + data_offset;
+	char *var, *value, *eq;
+	int idx;
+
+	priv->ncells = 0;
+	for (var = data; var < data + data_len && *var; var += strlen(var) + 1)
+		priv->ncells++;
+
+	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
+	if (!priv->cells)
+		return -ENOMEM;
+
+	for (var = data, idx = 0;
+	     var < data + data_len && *var;
+	     var = value + strlen(value) + 1, idx++) {
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		*eq = '\0';
+		value = eq + 1;
+
+		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!priv->cells[idx].name)
+			return -ENOMEM;
+		priv->cells[idx].offset = data_offset + value - data;
+		priv->cells[idx].bytes = strlen(value);
+	}
+
+	if (WARN_ON(idx != priv->ncells))
+		priv->ncells = idx;
+
+	return 0;
+}
+
+static int u_boot_env_parse(struct u_boot_env *priv)
+{
+	struct device *dev = priv->dev;
+	size_t crc32_data_offset;
+	size_t crc32_data_len;
+	size_t crc32_offset;
+	size_t data_offset;
+	size_t data_len;
+	uint32_t crc32;
+	uint32_t calc;
+	size_t bytes;
+	uint8_t *buf;
+	int err;
+
+	buf = kcalloc(1, priv->size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = mtd_read(priv->mtd, priv->offset, priv->size, &bytes, buf);
+	if ((err && !mtd_is_bitflip(err)) || bytes != priv->size) {
+		dev_err(dev, "Failed to read from mtd: %d\n", err);
+		goto err_kfree;
+	}
+
+	switch (priv->format) {
+	case U_BOOT_FORMAT_SINGLE:
+		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
+		data_offset = offsetof(struct u_boot_env_image_single, data);
+		break;
+	case U_BOOT_FORMAT_REDUNDANT:
+		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
+		data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		break;
+	}
+	crc32 = le32_to_cpu(*(uint32_t *)(buf + crc32_offset));
+	crc32_data_len = priv->size - crc32_data_offset;
+	data_len = priv->size - data_offset;
+
+	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	if (calc != crc32) {
+		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
+		err = -EINVAL;
+		goto err_kfree;
+	}
+
+	buf[priv->size - 1] = '\0';
+	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
+	if (err)
+		dev_err(dev, "Failed to add cells: %d\n", err);
+
+err_kfree:
+	kfree(buf);
+err_out:
+	return err;
+}
+
+static const struct of_device_id u_boot_env_of_match_table[] = {
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
+	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{},
+};
+
+static int u_boot_env_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.name = "u-boot-env",
+		.reg_read = u_boot_env_read,
+	};
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct of_device_id *of_id;
+	struct u_boot_env *priv;
+	const char *label;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	of_id = of_match_device(u_boot_env_of_match_table, dev);
+	if (!of_id)
+		return -EINVAL;
+	priv->format = (uintptr_t)of_id->data;
+
+	if (of_property_read_u32(np, "reg", (u32 *)&priv->offset) ||
+	    of_property_read_u32_index(np, "reg", 1, (u32 *)&priv->size)) {
+		dev_err(dev, "Failed to read \"reg\" property\n");
+		return -EINVAL;
+	}
+
+	label = of_get_property(np->parent, "label", NULL);
+	if (!label)
+		label = np->parent->name;
+
+	priv->mtd = get_mtd_device_nm(label);
+	if (IS_ERR(priv->mtd)) {
+		dev_err(dev, "Failed to find \"%s\" MTD device: %ld\n", label, PTR_ERR(priv->mtd));
+		return PTR_ERR(priv->mtd);
+	}
+
+	err = u_boot_env_parse(priv);
+	if (err)
+		return err;
+
+	config.dev = dev;
+	config.cells = priv->cells;
+	config.ncells = priv->ncells;
+	config.priv = priv;
+	config.size = priv->size;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static struct platform_driver u_boot_env_driver = {
+	.probe = u_boot_env_probe,
+	.driver = {
+		.name = "u_boot_env",
+		.of_match_table = u_boot_env_of_match_table,
+	},
+};
+module_platform_driver(u_boot_env_driver);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
-- 
2.34.1

