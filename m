Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214E8572CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiGME6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiGME5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:57:51 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95162A2EF7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:57:49 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220713045748epoutp04996b8ea2c7e7b3eb7d076c486486ad9e~BSrJyctEX0824508245epoutp04x
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:57:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220713045748epoutp04996b8ea2c7e7b3eb7d076c486486ad9e~BSrJyctEX0824508245epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657688268;
        bh=y1Fx/nvnJxB6EoXS7f+PvQstb/zUJd3CFdH5NVJJ5C8=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Ev+Myu40SM3RK+2xN2yZgZn6dZUDjxnocKnJgvcP3N7vZYUs4uy2uAdL3CFDtRt7/
         ZzpOqaI8yVcRp91tP8RwRjBT7ki/saFKLweiUDbfdjQvflcv0/GrxiGF66GFeFOKvu
         ptHS0ydx60Jf5kh0R22N0o5jt1wvrwapUW0XfIHU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220713045747epcas1p1f2f8a46d26f8efece21c13334e2e3a8c~BSrJMav8P2593225932epcas1p14;
        Wed, 13 Jul 2022 04:57:47 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LjQNV5ymJz4x9Q0; Wed, 13 Jul
        2022 04:57:46 +0000 (GMT)
X-AuditID: b6c32a39-e51ff700000025ce-31-62ce50caed09
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.A9.09678.AC05EC26; Wed, 13 Jul 2022 13:57:46 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 4/4] mfd: Samsung: Add Samsung sysmgr driver
Reply-To: dj76.yang@samsung.com
Sender: Dongjin Yang <dj76.yang@samsung.com>
From:   Dongjin Yang <dj76.yang@samsung.com>
To:     "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
Date:   Wed, 13 Jul 2022 13:57:46 +0900
X-CMS-MailID: 20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmnu6pgHNJBlfb9S1O73/HYvHykKbF
        /CPnWC12z1jOZDFz6hlmi4XTljNaPD80i9ni5ax7bBZH3nxktrj/9Sijxf7jK5ksLu+aw2Zx
        bnGmReveI+wWdw6fZXHg97i+LsBj06pONo871/awebzfd5XNo2/LKkaPz5vkAtiism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnHPp8nqng
        pX3F9oudLA2MDaZdjJwcEgImEuumvmXvYuTiEBLYwShxcfdCIIeDg1dAUOLvDmGQGmEBG4n9
        Bw6AhYUE5CU+T6yECOtIdLx9ygISZhPQkpjdnwgyRUTgM6PE422PwUYyCxxhlmg4MpcNYhev
        xIx2kAYQW1pi+/KtjBC2hsSPZb3MELaoxM3VIPdA2O+PzYeqEZFovXcWqkZQ4sHP3VBxKYlH
        zQeg7GqJc+29YIslBBoYJQ5+3sgGcp2EgL7EjuvGIDW8Ar4S925sYQWxWQRUJX5cvgN1m4vE
        yW0rwWxmoB+3v53DDNLKLKApsX6XPsQUZYkjt1hgPmnY+Jsdnc0swCfx7msPK0x8x7wnTBC2
        ssTn5tdQvZISiyfPZJ7AqDQLEc6zkOydhbB3ASPzKkax1ILi3PTUYsMCU3jUJufnbmIEp1wt
        yx2M099+0DvEyMTBeIhRgoNZSYT3z9lTSUK8KYmVValF+fFFpTmpxYcYTYE+nsgsJZqcD0z6
        eSXxhiaWBiZmRqamhgYWJkrivKumnU4UEkhPLEnNTk0tSC2C6WPi4JRqYEpl2hV1QWvSCuvL
        BYcEjnWVz9j2MsmoTGr6rRcPkyYIlkv6rysU3M23VqcpdsmldP+Fy8vqmzU2/K0+E3tYkZv7
        3TGOa6pGnFpzTd2KtyadLAq26dQPedWwIiv6ycqnjJttbwg2/M6b1dx+16uD4e9SnYjfbd8N
        LV8of7D3PhF//0fnv9vZvFf5XNSfrzB3Wphy6dbP53PzbyxrSAqR//o+I9ttDfeBVuVjnY7T
        2m97n2EK7DSx+XHu27tvB185cO6d2Nf57FpJt6r4bm/zEOkHqyPS/mWZrRdxfFHJv++796ff
        ljw+C9m4tv7Ou/z8w8b45eY+TMdjP0sfiy2tPLv8qsz5hgdXTPc7Lb71i1GJpTgj0VCLuag4
        EQC5fZgXQgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec
References: <CGME20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used for SoCs produced by Samsung Foundry to provide
Samsung sysmgr API. The read/write request of sysmgr is delivered to
Samsung secure monitor call.

Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
---
 MAINTAINERS                        |   2 +
 drivers/mfd/Kconfig                |  11 +++
 drivers/mfd/Makefile               |   1 +
 drivers/mfd/samsung-sysmgr.c       | 167 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/samsung-sysmgr.h |  30 +++++++
 5 files changed, 211 insertions(+)
 create mode 100644 drivers/mfd/samsung-sysmgr.c
 create mode 100644 include/linux/mfd/samsung-sysmgr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 55cb8901ccdc..44ad4bd406a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1870,9 +1870,11 @@ F:	arch/arm/mach-artpec
 F:	drivers/clk/axis
 F:	drivers/crypto/axis
 F:	drivers/firmware/samsung-smc-svc.c
+F:	drivers/mfd/samsung-sysmgr.c
 F:	drivers/mmc/host/usdhi6rol0.c
 F:	drivers/pinctrl/pinctrl-artpec*
 F:	include/linux/firmware/samsung-smc-svc.h
+F:	include/linux/mfd/samsung-sysmgr.h
 
 ARM/ASPEED I2C DRIVER
 M:	Brendan Higgins <brendanhiggins@google.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..ce6ab5842bf0 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -51,6 +51,17 @@ config MFD_ACT8945A
 	  linear regulators, along with a complete ActivePath battery
 	  charger.
 
+config MFD_SAMSUNG_SYSMGR
+	bool "System Manager for Samsung Foundry platforms"
+	depends on ARCH_ARTPEC && OF
+	select MFD_SYSCON
+	select SAMSUNG_SECURE_SERVICE
+	help
+	  Select this to get System Manager support for SoCs which use
+	  Samsung Foundry platforms.
+	  This System Manager has depedency on Samsung Secure Service
+	  for providing secure service call.
+
 config MFD_SUN4I_GPADC
 	tristate "Allwinner sunxi platforms' GPADC MFD driver"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..490f041d1262 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -248,6 +248,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
 obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
+obj-$(CONFIG_MFD_SAMSUNG_SYSMGR) += samsung-sysmgr.o
 obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
diff --git a/drivers/mfd/samsung-sysmgr.c b/drivers/mfd/samsung-sysmgr.c
new file mode 100644
index 000000000000..a202e8c4c4f2
--- /dev/null
+++ b/drivers/mfd/samsung-sysmgr.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Samsung Electronics, Co. Ltd.
+ * Copyright (C) 2018-2019, Intel Corporation.
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ * Copyright (C) 2012 Linaro Ltd.
+ *
+ * Inspired by drivers/mfd/altera-sysmgr.c
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mfd/samsung-sysmgr.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/**
+ * struct samsung_sysmgr - Samsung System Manager
+ * @regmap: the regmap used for System Manager accesses.
+ * @base  : the base address for the System Manager
+ */
+struct samsung_sysmgr {
+	struct regmap   *regmap;
+	resource_size_t *base;
+};
+
+static struct platform_driver samsung_sysmgr_driver;
+
+static struct regmap_config mmio_regmap_cfg = {
+	.name = "sysmgr_mmio",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static struct regmap_config samsung_smccc_regmap_cfg = {
+	.name = "samsung_sysmgr_smccc",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.use_single_read = true,
+	.use_single_write = true,
+	.reg_read = samsung_smc_reg_read,
+	.reg_write = samsung_smc_reg_write,
+};
+
+/**
+ * samsung_sysmgr_regmap_lookup_by_phandle
+ * Find the sysmgr previous configured in probe() and return regmap property.
+ * Return: regmap if found or error if not found.
+ */
+struct regmap *samsung_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
+						       const char *property)
+{
+	struct device *dev;
+	struct samsung_sysmgr *sysmgr;
+	struct device_node *sysmgr_np;
+
+	if (property)
+		sysmgr_np = of_parse_phandle(np, property, 0);
+	else
+		sysmgr_np = np;
+
+	if (!sysmgr_np)
+		return ERR_PTR(-ENODEV);
+
+	dev = driver_find_device_by_of_node(&samsung_sysmgr_driver.driver,
+					    (void *)sysmgr_np);
+	of_node_put(sysmgr_np);
+	if (!dev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	sysmgr = dev_get_drvdata(dev);
+
+	return sysmgr->regmap;
+}
+EXPORT_SYMBOL_GPL(samsung_sysmgr_regmap_lookup_by_phandle);
+
+static int sysmgr_probe(struct platform_device *pdev)
+{
+	struct samsung_sysmgr *sysmgr;
+	struct regmap *regmap;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct regmap_config sysmgr_config =
+		*((struct regmap_config *)of_device_get_match_data(dev));
+
+	sysmgr = devm_kzalloc(dev, sizeof(*sysmgr), GFP_KERNEL);
+	if (!sysmgr)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOENT;
+
+	sysmgr_config.max_register = resource_size(res) -
+				     sysmgr_config.reg_stride;
+	if (sysmgr_config.reg_read) {
+		/* Need physical address for SMCC call */
+		sysmgr->base = (resource_size_t *)res->start;
+		regmap = devm_regmap_init(dev, NULL, sysmgr->base,
+					  &sysmgr_config);
+	} else {
+		sysmgr->base = devm_ioremap(dev, res->start,
+					    resource_size(res));
+		if (!sysmgr->base)
+			return -ENOMEM;
+
+		regmap = devm_regmap_init_mmio(dev, sysmgr->base,
+					       &sysmgr_config);
+	}
+
+	if (IS_ERR(regmap)) {
+		pr_err("regmap init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	sysmgr->regmap = regmap;
+
+	platform_set_drvdata(pdev, sysmgr);
+
+	return 0;
+}
+
+static const struct of_device_id samsung_sysmgr_of_match[] = {
+	{ .compatible = "samsung,sys-mgr", .data = &mmio_regmap_cfg },
+	{
+	  .compatible = "samsung,sys-mgr-smccc",
+	  .data = &samsung_smccc_regmap_cfg
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, samsung_sysmgr_of_match);
+
+static struct platform_driver samsung_sysmgr_driver = {
+	.probe =  sysmgr_probe,
+	.driver = {
+		.name = "samsung,system_manager",
+		.of_match_table = samsung_sysmgr_of_match,
+	},
+};
+
+static int __init samsung_sysmgr_init(void)
+{
+	return platform_driver_register(&samsung_sysmgr_driver);
+}
+core_initcall(samsung_sysmgr_init);
+
+static void __exit samsung_sysmgr_exit(void)
+{
+	platform_driver_unregister(&samsung_sysmgr_driver);
+}
+module_exit(samsung_sysmgr_exit);
+
+MODULE_AUTHOR("Dongjin Yang <dj76.yang@samsung.com>");
+MODULE_DESCRIPTION("Samsung System Manager driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/samsung-sysmgr.h b/include/linux/mfd/samsung-sysmgr.h
new file mode 100644
index 000000000000..d6887cb86ea8
--- /dev/null
+++ b/include/linux/mfd/samsung-sysmgr.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Samsung Electronics, Co. Ltd.
+ * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ * Copyright (C) 2012 Linaro Ltd.
+ */
+
+#ifndef __LINUX_MFD_SAMSUNG_SYSMGR_H__
+#define __LINUX_MFD_SAMSUNG_SYSMGR_H__
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/firmware/samsung-smc-svc.h>
+
+struct device_node;
+
+#if defined(CONFIG_MFD_SAMSUNG_SYSMGR)
+struct regmap *samsung_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
+						       const char *property);
+#else
+static inline struct regmap *
+samsung_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
+					const char *property)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif
+
+#endif /* __LINUX_MFD_SAMSUNG_SYSMGR_H__ */
-- 
2.9.5
