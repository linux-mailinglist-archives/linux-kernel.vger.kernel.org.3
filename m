Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEAE47D7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345196AbhLVTXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345181AbhLVTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:23:33 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26498C061574;
        Wed, 22 Dec 2021 11:23:33 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id p8so5386325ljo.5;
        Wed, 22 Dec 2021 11:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCFi6Q8pBpxmwtXpGyK7AP439ce4VvXx32qzmws3x1E=;
        b=cJjioB/hxUJh2u4hbdtQPn4hjYG0gi6K00gDF3V2XdiQ6mlcRK/ja/dJLi55dbRlbp
         YhnVDmJWU/sto6DcOOTtUo0uHMqRQ6DvQ8J1VeYoho1Ft145DhoV5RtR5KLNaC9zds6K
         MOolsvX2LZJTvua9QY+8b5s2BvZaXNR86APSDtzavnSMd4uLIyDtYPSv1L8PZ4M6/oMz
         fEOpp1aEdHuYSWweMkeH7wBCVmyAQWxNCapdxfrmmdOoLA4ZabJIhXg2U9zrwOzxv6Iq
         5/GRmpXyyIkEI/fC9Ba0+H6DA6eD8NbF2jBJdHWhc9AgOO+GDM/ZfMR2H/l1okbVTkyM
         A7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCFi6Q8pBpxmwtXpGyK7AP439ce4VvXx32qzmws3x1E=;
        b=5ccyO+W3BfjN6OVFTk0IOHKysyK8qfqB+jAe9I3/B5MqZckyX7MC6Ag6gyB7wrBtk6
         kcCyvYCw5RXwU+p6VoYoc820G98vwahGpeLmO4nu1/Q3cmckN7JtztcZKwfWKBxttlPj
         ENMxaYgRWTqaxu4/pQPOpZbl6DXXR1CAUNRBveVKZj0/tAevy3vZCHjcMGqG3aC7ifTY
         9H0FodiY/KJwBz4xKZm7DH3ebHOwSY0M36UAjT6p14dm4s6OwjeiqNG3AHrb7DIFr89J
         rvsi1oMxcJzkAfwr42yzcEJynxcj0Ec7/GDBSKHcS+dJrDdafC8sUiADv6KmZyqTVRVt
         cpSQ==
X-Gm-Message-State: AOAM532j9tUe6FDa7u4kyGjJQF7DbS6qaaUBU6A9gElslQQshHwZoPj/
        5FEoxtfQYneusrgS+sByMnM=
X-Google-Smtp-Source: ABdhPJwp84y8P1DWDVWXYwLYsBSWE/jSSjLctWrdXYF0jAJ1+P8bh0JzGcFJ6J7VjoWD56VLghaADA==
X-Received: by 2002:a2e:a917:: with SMTP id j23mr1851642ljq.317.1640201011450;
        Wed, 22 Dec 2021 11:23:31 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id q10sm242070lfm.163.2021.12.22.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:23:31 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 3/3] nvmem: add driver handling U-Boot environment variables
Date:   Wed, 22 Dec 2021 20:23:20 +0100
Message-Id: <20211222192320.21974-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211222192320.21974-1-zajec5@gmail.com>
References: <20211222192320.21974-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot binary contains a block of environment variables (NVMEM) that
should be parsed and exposed as NVMEM cells.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 MAINTAINERS                |   1 +
 drivers/nvmem/Kconfig      |  10 ++
 drivers/nvmem/Makefile     |   2 +
 drivers/nvmem/u-boot-env.c | 236 +++++++++++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 drivers/nvmem/u-boot-env.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 271c29c84c7d..cc9bdeb33b64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19628,6 +19628,7 @@ U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
 M:	Zhangfei Gao <zhangfei.gao@linaro.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da414617a54d..af9115852412 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -300,4 +300,14 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config NVMEM_U_BOOT_ENV
+	tristate "U-Boot environment variables support"
+	depends on ARCH_BCM4908 || COMPILE_TEST
+	depends on OF
+	help
+	  This driver adds support for parsing U-Boot environment variables
+	  stored on flash partition.
+
+	  If compiled as module it will be called nvmem_u-boot-env.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index dcbbde35b6a8..772904cdebdb 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_U_BOOT_ENV)	+= nvmem_u-boot-env.o
+nvmem_u-boot-env-y		:= u-boot-env.o
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
new file mode 100644
index 000000000000..a932b3d3c63b
--- /dev/null
+++ b/drivers/nvmem/u-boot-env.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Rafał Miłecki <rafal@milecki.pl>
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
+	U_BOOT_FORMAT_DEFAULT,
+	U_BOOT_FORMAT_BRCM,
+};
+
+struct u_boot_env {
+	struct device *dev;
+	enum u_boot_env_format format;
+	struct mtd_info *mtd;
+	size_t offset;
+	size_t size;
+	struct nvmem_cell_info *cells;
+	int ncells;
+};
+
+struct u_boot_env_image {
+	__le32 crc32;
+	uint8_t data[0];
+} __packed;
+
+struct u_boot_brcm_header {
+	__le32 unk;
+	__le32 len;
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
+		return err;
+	}
+
+	return 0;
+}
+
+static int u_boot_env_add_cells(struct u_boot_env *priv, size_t data_offset,
+				uint8_t *data, size_t len)
+{
+	struct device *dev = priv->dev;
+	char *var, *value, *eq;
+	int idx;
+
+	priv->ncells = 0;
+	for (var = data; var < (char *)data + len && *var; var += strlen(var) + 1)
+		priv->ncells++;
+
+	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
+	if (!priv->cells)
+		return -ENOMEM;
+
+	for (var = data, idx = 0;
+	     var < (char *)data + len && *var;
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
+		priv->cells[idx].offset = data_offset + value - (char *)data;
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
+	struct u_boot_env_image *image;
+	size_t image_offset;
+	size_t image_len;
+	uint32_t crc32;
+	size_t bytes;
+	uint8_t *buf;
+	int err;
+
+	image_offset = 0;
+	image_len = priv->size;
+	if (priv->format == U_BOOT_FORMAT_BRCM) {
+		struct u_boot_brcm_header header;
+
+		err = mtd_read(priv->mtd, priv->offset, sizeof(header), &bytes,
+			       (uint8_t *)&header);
+		if (err && !mtd_is_bitflip(err)) {
+			dev_err(dev, "Failed to read from mtd: %d\n", err);
+			return err;
+		}
+
+		image_offset = sizeof(header);
+		image_len = le32_to_cpu(header.len);
+	}
+	dev_info(dev, "offset:0x%08x len:0x%08x\n", image_offset, image_len);
+
+	buf = kcalloc(1, image_len, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	image = (struct u_boot_env_image *)buf;
+
+	err = mtd_read(priv->mtd, priv->offset + image_offset, image_len, &bytes, buf);
+	if (err && !mtd_is_bitflip(err)) {
+		dev_err(dev, "Failed to read from mtd: %d\n", err);
+		goto err_kfree;
+	}
+
+	crc32 = crc32(~0, buf + 4, image_len - 4) ^ ~0L;
+	if (crc32 != le32_to_cpu(image->crc32)) {
+		dev_err(dev, "Invalid calculated CRC32: 0x%08x\n", crc32);
+		err = -EINVAL;
+		goto err_kfree;
+	}
+
+	buf[image_len - 1] = '\0';
+	err = u_boot_env_add_cells(priv, image_offset + sizeof(*image),
+				   buf + sizeof(*image),
+				   image_len - sizeof(*image));
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
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_DEFAULT, },
+	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BRCM, },
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
+	if (of_property_read_u32(np, "reg", &priv->offset) ||
+	    of_property_read_u32_index(np, "reg", 1, &priv->size)) {
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
+
+static int __init u_boot_env_init(void)
+{
+	return platform_driver_register(&u_boot_env_driver);
+}
+
+subsys_initcall_sync(u_boot_env_init);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
-- 
2.31.1

