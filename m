Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30F4B4F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352073AbiBNL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:56:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352160AbiBNLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:55:54 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075DBC4F;
        Mon, 14 Feb 2022 03:55:47 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8FE99223ED;
        Mon, 14 Feb 2022 12:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644839744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdrWzXvwdyDha3PoHg7ahk1iBkB7OCPIMJ5xDq82tO8=;
        b=UTUYxxQAxs74jboS+0cvb37wr27P1aCq5qAUGy5NVq1pYi1b5T6dz3tXi3vAdz4gehuu2H
        c0XQe9k2v3e/uEV6LQXmX7UhZn9xu+wSfmweZm6XCUl5D/bicHi9fAE3eG2MDSo1eikWf9
        YHPtRFzxCxoaARJBtBTEXJuJv05cyJY=
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/3] nvmem: add driver for Layerscape SFP (Security Fuse Processor)
Date:   Mon, 14 Feb 2022 12:55:28 +0100
Message-Id: <20220214115529.662948-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214115529.662948-1-michael@walle.cc>
References: <20220214115529.662948-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Security Fuse Processor found on Layerscape SoCs.
This driver implements basic read access.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/nvmem/Kconfig          | 12 +++++
 drivers/nvmem/Makefile         |  2 +
 drivers/nvmem/layerscape-sfp.c | 89 ++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
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
index 000000000000..e591c1511e33
--- /dev/null
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Layerscape SFP driver
+ *
+ * Copyright (c) 2022 Michael Walle <michael@walle.cc>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
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
+			       size_t bytes)
+{
+	struct layerscape_sfp_priv *priv = context;
+
+	memcpy_fromio(val, priv->base + LAYERSCAPE_SFP_OTP_OFFSET + offset,
+		      bytes);
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
+MODULE_LICENSE("GPL");
-- 
2.30.2

