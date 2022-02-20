Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2004BCF53
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbiBTPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbiBTPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6334BBF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d27so22869294wrb.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KX5uTkgk9W92gKlHSkFsOzce2NpLBrMlSSVzMx4nOs=;
        b=cRGwU1BsgWpldoqsENJ9J08eoraP2joeWa2nNnkg/CeTi1kuXAAI0sDTeUhfUxhge1
         OBEKe8d4FuRAuJlbN1SNz59A8J6UjBaCAQi6PjAwgf/68Ayg8oO2DsUSsUT++CH1mmCc
         x8hnGsljSOmJjyUM7VWVpspnEb4qQAxjzb3HXHi8PCYceXCUvB1HM3aaU8eWxFyjGJr7
         lkH6OYtrnKDbCkPn8kyr2QXDQ8LnTcve1BGi8ihpQqV3W5gXU386re5mVxFRH2h2yUl6
         SkMZ1D5TmxeyoqS9vUNuVvmiTMqpzl7tc1M8qCrC4axvO5318bUwLeiUOjk3E5t1VLHl
         GREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KX5uTkgk9W92gKlHSkFsOzce2NpLBrMlSSVzMx4nOs=;
        b=Zm/2XIFGA3gZ6/CI3KN9x5IFQArfCJssgn/qy7OANfIFGvBvWW106M5Epv8TVR72vd
         AGMw01Pvs9bAr/2CwrODNEhM9VbNmg+Z0HrYc3Tvvlh72FYKlzfgHJSmFU6T1jY5Z5ln
         f2oDlhifd5MlN3xJpqmGcQiHaMA68k+5UKW4VK8hCKO3UBO/BePGVxGcQKHrk5ZQ1mvT
         o/foS6AmPfBh55KRTHW2sGOePuW/rATI+7M8fU5B2QRBnQYdcrGCGjGdw8ZUbkXUvYXg
         6gXWZMcS0waVxLeX0uv18lOmjURYgseJ87FXgxo0QMbthwBbJsgIt0a6zwGBy/qxQHGc
         0Pvg==
X-Gm-Message-State: AOAM532wqb2yg/rloQE2HfwS+LPoRKTe7nqlyqzpTgpdt8cXiC7Qbily
        rMdqLjTLeGDjU6ysWRa3GoIfxBG5X6wgCw==
X-Google-Smtp-Source: ABdhPJz9JJZGINe7AA5kaxjB2L/8l4FKTcx8dZqJ0mTmsf0v4Aqq0RKR/e3smplf8gUjJMEEinjzlg==
X-Received: by 2002:adf:fd4b:0:b0:1e4:9a8a:2ef7 with SMTP id h11-20020adffd4b000000b001e49a8a2ef7mr12874497wrs.659.1645370157784;
        Sun, 20 Feb 2022 07:15:57 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/13] nvmem: add driver for Layerscape SFP (Security Fuse Processor)
Date:   Sun, 20 Feb 2022 15:15:23 +0000
Message-Id: <20220220151527.17216-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
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

From: Michael Walle <michael@walle.cc>

Add support for the Security Fuse Processor found on Layerscape SoCs.
This driver implements basic read access.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig          | 12 +++++
 drivers/nvmem/Makefile         |  2 +
 drivers/nvmem/layerscape-sfp.c | 89 ++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/nvmem/layerscape-sfp.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index da414617a54d..4063ea15f7d2 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
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
index dcbbde35b6a8..d4e1052d2b95 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
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
2.21.0

