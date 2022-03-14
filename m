Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34094D7A63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiCNFdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiCNFc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:32:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79863D48B;
        Sun, 13 Mar 2022 22:31:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id o26so12793654pgb.8;
        Sun, 13 Mar 2022 22:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n0LQMG7gC/5piVy61gR55y7EqPwWTykg9pEECpdPaEQ=;
        b=pM4aYv96CzFDdVSq5596FG285QxPcqtmAlbN5R3VNwyAua3GvM+iOd864JvrQTy4wS
         rSLIk6ldLASPJSrTN+LCoeM9lhNfnO/G4oTmhWimpPMFbYBRZis7pxTwbBY0brDIB0KU
         LvoeiM3UXgJrP8RREaJEqo/dQoPcqZMAvTLdRqEBvW1yzBe7BxmM1Lbex9B+iDPCQr9m
         olzbR+dBeV62TNKY50LG6hAZXWJm0UizpXp1YFgOP7l5QUEcJ7nK5lqTB4RZAs2KNPe+
         09DLojlcBa03lGhxmG5WXL5ufNntdOZe17Sv9F/gTSV9wDcZQKKMMVL9B/WGuNh5gXhg
         ogoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n0LQMG7gC/5piVy61gR55y7EqPwWTykg9pEECpdPaEQ=;
        b=YwCD/AlVjuQc5M3rzMHXTaAEoHirevPVjXUbX4ZWPqrkGYNdicspquFxAbrnVSFpo9
         6I1/tCiXt5HbHvsurWu1kkaNbEHWIG5jX2QHCr7xeGhiXwdAfbAw6EynY54AIxiGQZCs
         EyQv1sm+yhsIUUdC/UEgCLwefSmIgCHIhV6T/pSh0m6eAKIcnTBGRtiUga6uGyz7oXr6
         iETlx6UxORUiRjIMCotaTXIrH7Rnmi6ZmfpCawsy4NxzgQmmj5hM33bWgP9NpVkqZ2p6
         Ajo9kesnA0Gs8eM/4AIVBy3l8fK5DSQHLz4q/YSHCeL4EQXnHiswV45U4jB3XtjqkNeY
         4LeA==
X-Gm-Message-State: AOAM533TgJuOoX3p/+/csSNA5EjQnjB6DsvbJZMlDGGf1wPThQgYalmW
        ukMkVMSlFyDUBqBR3cTJujw=
X-Google-Smtp-Source: ABdhPJxUbKkJjZ83ZBQZ3fRo8Fr8WWfd/uLWoasWdImX5s6Fk9Kb2BC6vfQI2f3cImoi/rQ7J9mqEQ==
X-Received: by 2002:a05:6a00:1a02:b0:4f7:cb47:7fec with SMTP id g2-20020a056a001a0200b004f7cb477fecmr4011925pfv.85.1647235907459;
        Sun, 13 Mar 2022 22:31:47 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id c7-20020aa78e07000000b004f6e4d8ccc8sm18116376pfr.163.2022.03.13.22.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2022 22:31:46 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v1 1/2] usb: host: ohci-sunplus: Add driver for USB HOST OHCI in Sunplus SP7021 SoC
Date:   Mon, 14 Mar 2022 13:32:03 +0800
Message-Id: <1647235924-15572-2-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
References: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for USB HOST OHCI in Sunplus SP7021 SoC

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
 MAINTAINERS                     |   6 ++
 drivers/usb/host/Kconfig        |  10 ++
 drivers/usb/host/Makefile       |   1 +
 drivers/usb/host/ohci-sunplus.c | 202 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 drivers/usb/host/ohci-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..f7a9ed7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS USB OHCI DRIVER
+M:	Vincent Shih <vincent.sunplus@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/host/ohci-sunplus.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c4736d1..d0670fe 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -500,6 +500,16 @@ config USB_OHCI_HCD_DAVINCI
 	  controller. This driver cannot currently be a loadable
 	  module because it lacks a proper PHY abstraction.
 
+config USB_OHCI_HCD_SUNPLUS
+	tristate "OHCI support for Sunplus SP7021"
+	depends on SOC_SP7021
+	help
+	  Enables support for the on-chip OHCI controller in Sunplus
+	  SoCs. It supports 32-bit AHB/AXI config bus and 64-bit AXI
+	  data bus.
+	  This driver can also be built as a module. If so, the module
+	  will be called ohci-sunplus.
+
 config USB_OHCI_HCD_PPC_OF_BE
 	bool "OHCI support for OF platform bus (big endian)"
 	depends on PPC
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 171de4d..67f44c9 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_USB_OHCI_HCD_S3C2410)	+= ohci-s3c2410.o
 obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
 obj-$(CONFIG_USB_OHCI_HCD_PXA27X)	+= ohci-pxa27x.o
 obj-$(CONFIG_USB_OHCI_HCD_DAVINCI)	+= ohci-da8xx.o
+obj-$(CONFIG_USB_OHCI_HCD_SUNPLUS)+= ohci-sunplus.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/usb/host/ohci-sunplus.c b/drivers/usb/host/ohci-sunplus.c
new file mode 100644
index 0000000..46a28ce
--- /dev/null
+++ b/drivers/usb/host/ohci-sunplus.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * The USB HOST OHCI driver for Sunplus SP7021
+ *
+ * Copyright (C) 2021 Sunplus Technology Inc., All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/usb/ohci_pdriver.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ohci.h"
+
+#define hcd_to_sp_ohci_priv(h) \
+	((struct sp_ohci_priv *)hcd_to_ohci(h)->priv)
+
+struct sp_ohci_priv {
+	struct clk *ohci_clk;
+	struct reset_control *ohci_rstc;
+};
+
+static struct hc_driver __read_mostly ohci_sunplus_driver;
+
+static const struct ohci_driver_overrides ohci_sunplus_overrides __initconst = {
+	.extra_priv_size =	sizeof(struct sp_ohci_priv),
+};
+
+static int ohci_sunplus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sp_ohci_priv *sp_priv;
+	struct resource *res_mem;
+	struct usb_hcd *hcd;
+	int irq;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	hcd = usb_create_hcd(&ohci_sunplus_driver, dev, dev_name(&pdev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hcd);
+	sp_priv = hcd_to_sp_ohci_priv(hcd);
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->regs = devm_ioremap_resource(dev, res_mem);
+	if (IS_ERR(hcd->regs)) {
+		ret = PTR_ERR(hcd->regs);
+		goto err_put_hcd;
+	}
+
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = resource_size(res_mem);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		pr_err("no irq provieded\n");
+		ret = irq;
+		goto err_put_hcd;
+	}
+
+	sp_priv->ohci_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(sp_priv->ohci_clk)) {
+		pr_err("not found clk source\n");
+		ret = PTR_ERR(sp_priv->ohci_clk);
+		goto err_put_hcd;
+	}
+
+	sp_priv->ohci_rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(sp_priv->ohci_rstc)) {
+		ret = PTR_ERR(sp_priv->ohci_rstc);
+		goto err_put_hcd;
+	}
+
+	ret = clk_prepare_enable(sp_priv->ohci_clk);
+	if (ret)
+		goto err_clk;
+
+	ret = reset_control_deassert(sp_priv->ohci_rstc);
+	if (ret)
+		goto err_reset;
+
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto err_reset;
+
+	dev_dbg(dev, "hcd_irq:%d,%d\n", hcd->irq, irq);
+
+	return ret;
+
+err_reset:
+	reset_control_assert(sp_priv->ohci_rstc);
+err_clk:
+	clk_disable_unprepare(sp_priv->ohci_clk);
+err_put_hcd:
+	usb_put_hcd(hcd);
+
+	return ret;
+}
+
+static int ohci_sunplus_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct sp_ohci_priv *sp_priv = hcd_to_sp_ohci_priv(hcd);
+
+	usb_remove_hcd(hcd);
+	usb_put_hcd(hcd);
+	platform_set_drvdata(pdev, NULL);
+
+	reset_control_assert(sp_priv->ohci_rstc);
+	clk_disable_unprepare(sp_priv->ohci_clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ohci_sunplus_drv_suspend(struct device *pdev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(pdev);
+	struct sp_ohci_priv *sp_priv = hcd_to_sp_ohci_priv(hcd);
+	bool do_wakeup = device_may_wakeup(pdev);
+	int rc;
+
+	rc = ohci_suspend(hcd, do_wakeup);
+	if (rc)
+		return rc;
+
+	reset_control_assert(sp_priv->ohci_rstc);
+	clk_disable_unprepare(sp_priv->ohci_clk);
+
+	return 0;
+}
+
+static int ohci_sunplus_drv_resume(struct device *pdev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(pdev);
+	struct sp_ohci_priv *sp_priv = hcd_to_sp_ohci_priv(hcd);
+
+	clk_prepare_enable(sp_priv->ohci_clk);
+	reset_control_deassert(sp_priv->ohci_rstc);
+
+	ohci_resume(hcd, false);
+
+	return 0;
+}
+
+struct dev_pm_ops const ohci_sunplus_pm_ops = {
+	.suspend = ohci_sunplus_drv_suspend,
+	.resume = ohci_sunplus_drv_resume,
+};
+#endif
+
+static const struct of_device_id ohci_sunplus_dt_ids[] = {
+	{ .compatible = "sunplus,sp7021-usb-ohci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ohci_sunplus_dt_ids);
+
+static struct platform_driver ohci_hcd_sunplus_driver = {
+	.probe			= ohci_sunplus_probe,
+	.remove			= ohci_sunplus_remove,
+	.shutdown		= usb_hcd_platform_shutdown,
+	.driver = {
+		.name		= "ohci-sunplus",
+		.of_match_table = ohci_sunplus_dt_ids,
+#ifdef CONFIG_PM
+		.pm = &ohci_sunplus_pm_ops,
+#endif
+	}
+};
+
+static int __init ohci_sunplus_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	ohci_init_driver(&ohci_sunplus_driver, &ohci_sunplus_overrides);
+
+	return platform_driver_register(&ohci_hcd_sunplus_driver);
+}
+module_init(ohci_sunplus_init);
+
+static void __exit ohci_sunplus_cleanup(void)
+{
+	platform_driver_unregister(&ohci_hcd_sunplus_driver);
+}
+module_exit(ohci_sunplus_cleanup);
+
+MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
+MODULE_DESCRIPTION("Sunplus USB OHCI driver");
+MODULE_LICENSE("GPL");
+
-- 
2.7.4

