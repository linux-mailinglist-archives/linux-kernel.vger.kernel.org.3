Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0554D1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346944AbiFOTnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiFOTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:43:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E22CE26;
        Wed, 15 Jun 2022 12:43:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so25208303eja.8;
        Wed, 15 Jun 2022 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJt5W0EU+sFGaIOZbZ00omdFEDMKZn+VKOgfz5mNEys=;
        b=b6ysLzlmtRDwylwJm+veQg5s5/vYYErEooJ/Za89I9oViMbUzDMhBbTkShsSQheCLT
         Ze1sBG5WIQkFwVMq6NgJ9BGXQdNcbFyl74LC5B2CYlPuAje9SLLZB68Um551EM2RMPf/
         Budgdhvy4B+A/OxGLMsVQudyDpCj4T93lsk36tK3MCawYkmCLvOEAIX6ocrMQtxu4niR
         naWZdckq5bJeboip25/FUNax9JBIQ2MgCNOqZs9fOG81GPolMPMTF3Y97P9rKNFQL6j/
         eH2OEfNVSW84FcB8cCuqjF471WIPYOPZsM+41Z9m63xpcjmKNXGiyzMOxeCDpOVGV4Xs
         MjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJt5W0EU+sFGaIOZbZ00omdFEDMKZn+VKOgfz5mNEys=;
        b=QD6nun4YdXE3B/zYsp8h5PRF6NZqe+l4f5S8Bx8zPs+8hcVRLsgA340DpvzPdoVzzk
         2b4IEFOcX6pXCzM5Adw7E9kNRkA0DfpEYD8jbG5C2xYttS660ToRj2QH4B5xxOLhtGH0
         J/xpWvn4l1iRvyaD5BDCO/sZimYgpaLaSPGfCxJoAzaD8XTARLw/gZuT654hOWyfJBz0
         R1rToDx3Bje4hQ+nLYv5F5M+tXzLfG5Fs+w5WMTectdf2PJG3nl1qIYVYUhRO8Myolr4
         d47L6SYp/jbcvR31JWdV8+CBZ330FNNeI0lz2Fowd689R4cIHxuaCrUK2MzhM0nF6p70
         MzKg==
X-Gm-Message-State: AJIora+WavhPHvbIwUq8oggzMsjdqnvsb0mwCWAS0hVaq1MHhn1HXvoQ
        tB0NJbgGmLHlSgSyhjeDJds=
X-Google-Smtp-Source: AGRyM1vuPw3OzAl1eoIW9BvwLnSyUlDJiu+Q9utQNlOZQIXLMbxiEkM/zTeNKNlSxeQt4nmVcpW2/A==
X-Received: by 2002:a17:906:649b:b0:712:24cd:6102 with SMTP id e27-20020a170906649b00b0071224cd6102mr1320880ejm.664.1655322193217;
        Wed, 15 Jun 2022 12:43:13 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d750000000b0042bd6f745fasm18096eds.92.2022.06.15.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 12:43:12 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 2/2] nvmem: add driver handling U-Boot environment variables
Date:   Wed, 15 Jun 2022 21:43:00 +0200
Message-Id: <20220615194300.13358-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220615194300.13358-1-zajec5@gmail.com>
References: <20220615194300.13358-1-zajec5@gmail.com>
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

Current Linux's NVMEM sysfs API allows reading whole NVMEM data block.
It can be used by user-space tools for reading U-Boot env vars block
without the hassle of finding its location. Parsing will still need to
be re-done there.

Kernel-parsed NVMEM cells can be read however by Linux drivers. This may
be useful for Ethernet drivers for reading device MAC address which is
often stored as U-Boot env variable.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V3: Use of_get_mtd_device_by_node() (thanks Ahmad) & update description
V2: Drop ARCH_BCM4908 dependency as there are plenty architectures using
    U-Boot bootloader. Thanks Srinivas.
V4: Mention MTD in Kconfig help
    Use correct MTD device (instead of parent) - simplifies code a lot
    Use flexible arrays syntax ([])
    Use of_device_get_match_data() helper
    Use dev_err_probe()

As noticed by Ahmad a missing NVMEM subsystem feature is user-space
access to parsed NVMEM cells. That is something I started working on
some time ago and I'm planning to get back to at some point, please
check:
[PATCH 2/2] nvmem: expose NVMEM cells in sysfs
https://lore.kernel.org/lkml/20211220064730.28806-2-zajec5@gmail.com/
---
 MAINTAINERS                |   1 +
 drivers/nvmem/Kconfig      |  13 +++
 drivers/nvmem/Makefile     |   2 +
 drivers/nvmem/u-boot-env.c | 218 +++++++++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+)
 create mode 100644 drivers/nvmem/u-boot-env.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 475e28365385..43b427fa76b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20411,6 +20411,7 @@ U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
 M:	Zhangfei Gao <zhangfei.gao@linaro.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d72d879a6d34..bab8a29c9861 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -344,4 +344,17 @@ config NVMEM_APPLE_EFUSES
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
+	  Currently this drivers works only with env variables on top of MTD.
+
+	  If compiled as module it will be called nvmem_u-boot-env.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index c710b64f9fe4..399f9972d45b 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -69,3 +69,5 @@ obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 		:= apple-efuses.o
 obj-$(CONFIG_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
 nvmem-microchip-otpc-y		:= microchip-otpc.o
+obj-$(CONFIG_NVMEM_U_BOOT_ENV)	+= nvmem_u-boot-env.o
+nvmem_u-boot-env-y		:= u-boot-env.o
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
new file mode 100644
index 000000000000..9b9abfb8f187
--- /dev/null
+++ b/drivers/nvmem/u-boot-env.c
@@ -0,0 +1,218 @@
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
+	struct mtd_info *mtd;
+
+	/* Cells */
+	struct nvmem_cell_info *cells;
+	int ncells;
+};
+
+struct u_boot_env_image_single {
+	__le32 crc32;
+	uint8_t data[];
+} __packed;
+
+struct u_boot_env_image_redundant {
+	__le32 crc32;
+	u8 mark;
+	uint8_t data[];
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
+	err = mtd_read(priv->mtd, offset, bytes, &bytes_read, val);
+	if (err && !mtd_is_bitflip(err)) {
+		dev_err(dev, "Failed to read from mtd: %d\n", err);
+		return err;
+	}
+
+	if (bytes_read != bytes) {
+		dev_err(dev, "Failed to read %zu bytes\n", bytes);
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
+	buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
+	if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
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
+	crc32_data_len = priv->mtd->size - crc32_data_offset;
+	data_len = priv->mtd->size - data_offset;
+
+	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	if (calc != crc32) {
+		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
+		err = -EINVAL;
+		goto err_kfree;
+	}
+
+	buf[priv->mtd->size - 1] = '\0';
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
+static int u_boot_env_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.name = "u-boot-env",
+		.reg_read = u_boot_env_read,
+	};
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct u_boot_env *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	priv->format = (uintptr_t)of_device_get_match_data(dev);
+
+	priv->mtd = of_get_mtd_device_by_node(np);
+	if (IS_ERR(priv->mtd)) {
+		dev_err_probe(dev, PTR_ERR(priv->mtd), "Failed to get %pOF MTD\n", np);
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
+	config.size = priv->mtd->size;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static const struct of_device_id u_boot_env_of_match_table[] = {
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
+	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{},
+};
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

