Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6D49E7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbiA0Qh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:37:59 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53915 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiA0Qhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:37:36 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A7A9D223ED;
        Thu, 27 Jan 2022 17:37:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643301454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ev64DGxSvnK1yZphS6yzvPXpxJGjZjwv4zeS/CYmiVg=;
        b=OI7vQXQEZEzzwNgGmt4QSE5H99ePZIeNMeTASTV5OJEFwop/ixZTNXKjNv6u8jqxdEi2PZ
        YUNZExZhfSAA3lyTWYF+H/PV5im1zgcQMqaQHoo+QX6UBm5+OtbLF263e896pBQJVPdZq3
        D2mdLdg/iRC4q4f29DR/gbJIkR4TDH8=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 2/3] nvmem: add driver for Layerscape SFP (Security Fuse Processor)
Date:   Thu, 27 Jan 2022 17:37:27 +0100
Message-Id: <20220127163728.3650648-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127163728.3650648-1-michael@walle.cc>
References: <20220127163728.3650648-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Security Fuse Processor found on Layerscape SoCs.
This driver implements basic read access.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/nvmem/Kconfig          | 12 +++++
 drivers/nvmem/Makefile         |  2 +
 drivers/nvmem/layerscape-sfp.c | 91 ++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/nvmem/layerscape-sfp.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 94dd60b2654e..63792082e476 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -307,4 +307,16 @@ config NVMEM_BRCM_NVRAM
 	  This driver provides support for Broadcom's NVRAM that can be accessed
 	  using I/O mapping.
 
+config NVMEM_LAYERSCAPE_SFP
+	tristate "Layerscape SFP (Security Fuse Processor) support"
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver provides support to read the eFuses on Freescale
+	  Layerscape SoC's. For example, the vendor provides a per part
+	  unique ID there.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called layerscape-sfp.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4e6d877fdfaf..914358fcdb37 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -62,3 +62,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
 nvmem-rmem-y			:= rmem.o
 obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
 nvmem_brcm_nvram-y		:= brcm_nvram.o
+obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
+nvmem-layerscape-sfp-y		:= layerscape-sfp.o
diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
new file mode 100644
index 000000000000..4aa94e03d8d1
--- /dev/null
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Layerscape SFP driver
+ *
+ * Copyright (c) 2022 Michael Walle <michael@walle.cc>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#define LAYERSCAPE_SFP_OTP_OFFSET	0x0200
+
+struct layerscape_sfp_priv {
+	void __iomem *base;
+};
+
+struct layerscape_sfp_data {
+	int size;
+};
+
+static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
+			size_t bytes)
+{
+	struct layerscape_sfp_priv *priv = context;
+
+	memcpy_fromio(val, priv->base + LAYERSCAPE_SFP_OTP_OFFSET + offset, bytes);
+
+	return 0;
+}
+
+static struct nvmem_config layerscape_sfp_nvmem_config = {
+	.name = "fsl-sfp",
+	.reg_read = layerscape_sfp_read,
+};
+
+static int layerscape_sfp_probe(struct platform_device *pdev)
+{
+	const struct layerscape_sfp_data *data;
+	struct layerscape_sfp_priv *priv;
+	struct nvmem_device *nvmem;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	data = device_get_match_data(&pdev->dev);
+
+	layerscape_sfp_nvmem_config.size = data->size;
+	layerscape_sfp_nvmem_config.dev = &pdev->dev;
+	layerscape_sfp_nvmem_config.priv = priv;
+
+	nvmem = devm_nvmem_register(&pdev->dev, &layerscape_sfp_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct layerscape_sfp_data ls1028a_data = {
+	.size = 0x88,
+};
+
+static const struct of_device_id layerscape_sfp_dt_ids[] = {
+	{ .compatible = "fsl,ls1028a-sfp", .data = &ls1028a_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, layerscape_sfp_dt_ids);
+
+static struct platform_driver layerscape_sfp_driver = {
+	.probe	= layerscape_sfp_probe,
+	.driver = {
+		.name	= "layerscape_sfp",
+		.of_match_table = layerscape_sfp_dt_ids,
+	},
+};
+module_platform_driver(layerscape_sfp_driver);
+
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_DESCRIPTION("Layerscape Security Fuse Processor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

