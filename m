Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05754CE977
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 07:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiCFGLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 01:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCFGLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 01:11:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011B47568;
        Sat,  5 Mar 2022 22:10:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so11429245pjl.4;
        Sat, 05 Mar 2022 22:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CI+8S5A9GH8ZUbygEhTKA5MIlGwP5ObK2Ckszk67zLk=;
        b=Usi10+5oCQSBhsVjRJLhW3EuwcDRSHaCZcMkqJAiDjPw8ycQWtnLaUQu2N7hKJkfi7
         rTvsBW9uzwSj4bMS3zHIbX/aT/e9hPwWZdY0+g7bvUXhz1IdG+4SktNAHAkAWtFKRChq
         6F2rjsy7IRl7aHE+n3S+8EXtulT9cs239WavzqD0QhgG2bycMWfNn8v3X+KE39PYsAZq
         Il1l0vdFV/PQAgOD/EokH0BdUxanbVy0fjl+NluvY6GLrvuWp2buAWCDm/QAqw2j8sYr
         KO3dNQGpbOrXpImsrCOU2qehve0rqxmRfMbHC1Qy4vYSb/tvA/5qth9k0YDKoh6yIrVe
         zCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CI+8S5A9GH8ZUbygEhTKA5MIlGwP5ObK2Ckszk67zLk=;
        b=1IJpPlvRvSJYQDe+gdLH23WdOJFOd0GI8fzOn3IBOIMKoZl+G0FkpRSfcCD0MpU+Kp
         VABz204Zocf2tyTyjumGkwmB6h/pVHG/Z92bpvK/THW4cHQb2FrhbncMsw3Gyz7ou3nA
         r4DWOPFm+PzTstiymHXcud4VmnubfMlj5LfDEiB4/9CVMuhU2euio8qaB/oucv/KABYc
         KUncwqWJk0U7nmsONc6XkBQe4IdNj7RurcAzH4SOVkH0yGzpxdpiBw3p4l8hRJnkRoVm
         bOnAxlK13N39Y4U8E1JatI9Q97GtIqobEnSWQKYy+PYyuOAV0XERDejKvoi0fM0NFMpX
         FdTg==
X-Gm-Message-State: AOAM530gQYUxTepUDTM3fti1ua0/hotjVL05BdFpUI3AFEtQHI8T3o+1
        yq/pZ7Ut6B9j+Ezf+tXZ5CoO5wJgB+jvmA==
X-Google-Smtp-Source: ABdhPJxwsp0qNxo8jULHjhXYP5o61ZILJwLbx/acjPxBzYr33CBms7BXtClqbBWChfB0IdAGRtWV0Q==
X-Received: by 2002:a17:902:8f8b:b0:149:6639:4b86 with SMTP id z11-20020a1709028f8b00b0014966394b86mr6591916plo.60.1646547021001;
        Sat, 05 Mar 2022 22:10:21 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id q13-20020aa7982d000000b004cb98a2ca35sm11994907pfl.211.2022.03.05.22.10.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Mar 2022 22:10:20 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v3 1/2] usb: host: ehci-sunplus: Add driver for ehci in Sunplus SP7021
Date:   Sun,  6 Mar 2022 14:10:35 +0800
Message-Id: <1646547036-14885-2-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646547036-14885-1-git-send-email-vincent.sunplus@gmail.com>
References: <1646547036-14885-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for ehci in Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v2:
  - Address the comments by Alan Stern.
  - Address the comments by Rob Herring.
  - Address the comments by Krzysztof Kozlowski.
  - Implement phy binding.
  - Clean up codes.

 MAINTAINERS                     |   6 +
 drivers/usb/host/Kconfig        |  12 ++
 drivers/usb/host/Makefile       |   1 +
 drivers/usb/host/ehci-sunplus.c | 241 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 260 insertions(+)
 create mode 100644 drivers/usb/host/ehci-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80eebc1..6c2faf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17947,6 +17947,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS USB EHCI DRIVER
+M:	Vincent Shih <vincent.sunplus@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/host/ehci-sunplus.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c4736d1..ad13fdd 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -339,6 +339,18 @@ config USB_OCTEON_EHCI
 	  USB 2.0 device support.  All CN6XXX based chips with USB are
 	  supported.
 
+config USB_EHCI_SUNPLUS
+	tristate "EHCI support for Sunplus USB controller"
+	depends on SOC_SP7021
+	select NVMEM_SUNPLUS_OCOTP
+	select PHY_SUNPLUS_USB
+	help
+	  Enables support for the on-chip EHCI controller in Sunplus
+	  SoCs. It supports 32-bit AHB/AXI config bus and 64-bit AXI
+	  data bus.
+	  This driver can also be built as a module. If so, the module
+	  will be called ehci-sunplus.
+
 endif # USB_EHCI_HCD
 
 config USB_OXU210HP_HCD
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 171de4d..7e9b5f1 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_USB_EHCI_HCD_STI)	+= ehci-st.o
 obj-$(CONFIG_USB_EHCI_EXYNOS)	+= ehci-exynos.o
 obj-$(CONFIG_USB_EHCI_HCD_AT91) += ehci-atmel.o
 obj-$(CONFIG_USB_EHCI_BRCMSTB)	+= ehci-brcm.o
+obj-$(CONFIG_USB_EHCI_SUNPLUS)	+= ehci-sunplus.o
 
 obj-$(CONFIG_USB_OXU210HP_HCD)	+= oxu210hp-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
diff --git a/drivers/usb/host/ehci-sunplus.c b/drivers/usb/host/ehci-sunplus.c
new file mode 100644
index 0000000..48e270c
--- /dev/null
+++ b/drivers/usb/host/ehci-sunplus.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * The EHCI driver for Sunplus SP7021
+ *
+ * Copyright (C) 2021 Sunplus Technology Inc., All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/usb.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/hcd.h>
+
+#include "ehci.h"
+
+#define hcd_to_sp_ehci_priv(h) \
+		((struct sp_ehci_priv *)hcd_to_ehci(h)->priv)
+
+struct sp_ehci_priv {
+	struct clk *ehci_clk;
+	struct reset_control *ehci_rstc;
+	struct phy *phy;
+	u32 disc_vol_addr_off;
+};
+
+static struct usb_ehci_pdata usb_ehci_pdata = {
+	.has_tt = 1,
+	.has_synopsys_hc_bug = 1,
+	.big_endian_desc = 1,
+	.big_endian_mmio = 1,
+};
+
+static int ehci_sunplus_reset(struct usb_hcd *hcd)
+{
+	struct platform_device *pdev = to_platform_device(hcd->self.controller);
+	struct usb_ehci_pdata *pdata = pdev->dev.platform_data;
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int retval;
+
+	hcd->has_tt = pdata->has_tt;
+	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
+	ehci->big_endian_desc = pdata->big_endian_desc;
+	ehci->big_endian_mmio = pdata->big_endian_mmio;
+	ehci->caps = hcd->regs;
+
+	retval = ehci_setup(hcd);
+
+	return retval;
+}
+
+static struct hc_driver __read_mostly ehci_sunplus_driver;
+
+static const struct ehci_driver_overrides ehci_sunplus_overrides __initconst = {
+	.reset =		ehci_sunplus_reset,
+	.extra_priv_size =	sizeof(struct sp_ehci_priv),
+};
+
+static int ehci_sunplus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sp_ehci_priv *sp_priv;
+	struct resource *res_mem;
+	struct usb_hcd *hcd;
+	int irq, ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	pdev->dev.platform_data = &usb_ehci_pdata;
+
+	/* initialize hcd */
+	hcd = usb_create_hcd(&ehci_sunplus_driver, dev, dev_name(dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hcd);
+	sp_priv = hcd_to_sp_ehci_priv(hcd);
+
+	/* phy */
+	sp_priv->phy = devm_phy_get(dev, "uphy");
+	if (IS_ERR(sp_priv->phy)) {
+		ret = PTR_ERR(sp_priv->phy);
+		goto err_put_hcd;
+	}
+
+	ret = phy_init(sp_priv->phy);
+	if (ret)
+		goto err_put_hcd;
+
+	/* ehci */
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
+		ret = irq;
+		goto err_put_hcd;
+	}
+	dev_dbg(&pdev->dev, "ehci_id:%d,irq:%d\n", pdev->id, irq);
+
+	sp_priv->ehci_clk = devm_clk_get(dev, NULL);
+
+	if (IS_ERR(sp_priv->ehci_clk)) {
+		ret = PTR_ERR(sp_priv->ehci_clk);
+		goto err_put_hcd;
+	}
+
+	sp_priv->ehci_rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(sp_priv->ehci_rstc)) {
+		ret = PTR_ERR(sp_priv->ehci_rstc);
+		goto err_put_hcd;
+	}
+
+	ret = clk_prepare_enable(sp_priv->ehci_clk);
+	if (ret)
+		goto err_ehci_clk;
+
+	ret = reset_control_deassert(sp_priv->ehci_rstc);
+	if (ret)
+		goto err_ehci_reset;
+
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto err_ehci_reset;
+
+	dev_dbg(dev, "hcd_irq:%d,%d\n", hcd->irq, irq);
+
+	return ret;
+
+err_ehci_reset:
+	reset_control_assert(sp_priv->ehci_rstc);
+err_ehci_clk:
+	clk_disable_unprepare(sp_priv->ehci_clk);
+err_put_hcd:
+	usb_put_hcd(hcd);
+
+	return ret;
+}
+
+static int ehci_sunplus_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
+
+	usb_remove_hcd(hcd);
+	usb_put_hcd(hcd);
+
+	reset_control_assert(sp_priv->ehci_rstc);
+	clk_disable_unprepare(sp_priv->ehci_clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ehci_sunplus_drv_suspend(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
+	bool do_wakeup = device_may_wakeup(dev);
+	int rc;
+
+	rc = ehci_suspend(hcd, do_wakeup);
+	if (rc)
+		return rc;
+
+	reset_control_assert(sp_priv->ehci_rstc);
+	clk_disable_unprepare(sp_priv->ehci_clk);
+
+	return 0;
+}
+
+static int ehci_sunplus_drv_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
+
+	clk_prepare_enable(sp_priv->ehci_clk);
+	reset_control_deassert(sp_priv->ehci_rstc);
+
+	ehci_resume(hcd, false);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ehci_sunplus_pm_ops = {
+	.suspend = ehci_sunplus_drv_suspend,
+	.resume = ehci_sunplus_drv_resume,
+};
+#endif
+
+static const struct of_device_id ehci_sunplus_dt_ids[] = {
+	{ .compatible = "sunplus,sp7021-usb-ehci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ehci_sunplus_dt_ids);
+
+static struct platform_driver ehci_hcd_sunplus_driver = {
+	.probe			= ehci_sunplus_probe,
+	.remove			= ehci_sunplus_remove,
+	.shutdown		= usb_hcd_platform_shutdown,
+	.driver = {
+		.name		= "ehci-sunplus",
+		.of_match_table = ehci_sunplus_dt_ids,
+#ifdef CONFIG_PM
+		.pm = &ehci_sunplus_pm_ops,
+#endif
+	}
+};
+
+static int __init ehci_sunplus_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	ehci_init_driver(&ehci_sunplus_driver, &ehci_sunplus_overrides);
+	return platform_driver_register(&ehci_hcd_sunplus_driver);
+}
+module_init(ehci_sunplus_init);
+
+static void __exit ehci_sunplus_cleanup(void)
+{
+	platform_driver_unregister(&ehci_hcd_sunplus_driver);
+}
+module_exit(ehci_sunplus_cleanup);
+
+MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
+MODULE_DESCRIPTION("Sunplus USB EHCI driver");
+MODULE_LICENSE("GPL");
+
-- 
2.7.4

