Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E32514435
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355682AbiD2Ibe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355349AbiD2Iba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:31:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BCB10FC1;
        Fri, 29 Apr 2022 01:28:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so6645818pjm.1;
        Fri, 29 Apr 2022 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a+yiwkU9WLavfYVInLC1xuz5SDIL3Icisbjb0pt9dsQ=;
        b=dQQPaHWGk219F/HSFXwwNm5SiyLTDL0UNIS6n6umLqwgR7S/dbUr4TCKGmnKPsnDWi
         8Qtt7Ay2GbkEJgKEG6R0d6UGEugkYvbvnOy65ZIhRs0B88Zum6R31lDRxhwRPtJjt0l4
         jtQjGBc+8qU7e7cwbA0hn/4MaE0vT59rHsTM1ag56SYehdRLGRACTTrMrIYDfmmHVJV9
         ix12YCu/7PVcmh10UUEfRDsHFNfQwzwhqnvQTWHEyk7EDkZqWPzqihAUveqMIEXDXzqF
         QpZDR1rq13gSC24vej16bGH/rP1EK93uDngrn4i++XExN4cRxYy4IC3rh2TeCrAcY9TC
         NWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a+yiwkU9WLavfYVInLC1xuz5SDIL3Icisbjb0pt9dsQ=;
        b=jVcx4iEZuB7jfEPrA0qLSxqTEP81aNZcfsd6duayCtNgjPwfCHOcatuhCBuRq0/xie
         LJg9BSC7uD0RfAkqGQiRAxx+z4QX4UnKP8dmctli2b/Dox6EKbZ1VLF3m59j+TPRJctJ
         0IsJf0si+pKDSnTSFUbKnGtNN74eO1cY+vKhz2NOWJgYdyS6YdT4JNx+7QFSG/qaDxTv
         BLpU/0sN2S7TaJF9xue03sior/UuA4f5nb2mKtBts5VBTcLwe+uXA0NL+k/WFD1C/iOb
         gJM+XFApORCSrR/rFu1bFnQrjcgSMt2UlAr0fq2cnIWhuXRbPJxSAUeqxVrRQmlWc68/
         4vuw==
X-Gm-Message-State: AOAM532cL5bq+yaQVSS+juaZiyl3sY9ixsz0++Qrm5xKUGBxsIdwsd69
        YF5jxudw6S7uKRe0f2effZQ=
X-Google-Smtp-Source: ABdhPJyM5EKO8PphOvDN/FXOA8xutm0iCZpdgPmsqOyGtCGstUlX2aeZl5D7NTGox7NXC+XfizekNg==
X-Received: by 2002:a17:90b:3e82:b0:1c7:2920:7c54 with SMTP id rj2-20020a17090b3e8200b001c729207c54mr2678505pjb.2.1651220892507;
        Fri, 29 Apr 2022 01:28:12 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm2346874pfh.84.2022.04.29.01.28.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:28:11 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, davem@davemloft.net,
        vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v4 1/2] usb: host: ehci-sunplus: Add driver for ehci in Sunplus SP7021
Date:   Fri, 29 Apr 2022 16:27:55 +0800
Message-Id: <1651220876-26705-2-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651220876-26705-1-git-send-email-vincent.sunplus@gmail.com>
References: <1651220876-26705-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for ehci in Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v4:
  - Implement power_on, power_off and power_suspend functions.

 MAINTAINERS                     |   6 +
 drivers/usb/host/Kconfig        |  11 ++
 drivers/usb/host/Makefile       |   1 +
 drivers/usb/host/ehci-sunplus.c | 289 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 drivers/usb/host/ehci-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dd61684..e103afa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18914,6 +18914,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 F:	drivers/tty/serial/sunplus-uart.c
 
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
index 57ca5f9..3103831 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -340,6 +340,17 @@ config USB_OCTEON_EHCI
 	  USB 2.0 device support.  All CN6XXX based chips with USB are
 	  supported.
 
+config USB_EHCI_SUNPLUS
+	tristate "EHCI support for Sunplus SP7021"
+	depends on SOC_SP7021
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
index 2948983..ab49fbb 100644
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
index 0000000..4d8e20d
--- /dev/null
+++ b/drivers/usb/host/ehci-sunplus.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * The EHCI driver for Sunplus SP7021
+ *
+ * Copyright (C) 2022 Sunplus Technology Inc., All rights reserved.
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
+static int sp_ehci_platform_power_on(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
+	int ret;
+
+	ret = clk_prepare_enable(sp_priv->ehci_clk);
+	if (ret)
+		goto err_ehci_clk;
+
+	ret = reset_control_deassert(sp_priv->ehci_rstc);
+	if (ret)
+		goto err_ehci_reset;
+
+	ret = phy_init(sp_priv->phy);
+	if (ret)
+		goto err_ehci_reset;
+
+	ret = phy_power_on(sp_priv->phy);
+	if (ret)
+		goto err_phy_exit;
+
+	return 0;
+
+err_phy_exit:
+	phy_exit(sp_priv->phy);
+err_ehci_reset:
+	reset_control_assert(sp_priv->ehci_rstc);
+err_ehci_clk:
+	clk_disable_unprepare(sp_priv->ehci_clk);
+
+	return ret;
+}
+
+static void sp_ehci_platform_power_off(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
+
+	phy_power_off(sp_priv->phy);
+	phy_exit(sp_priv->phy);
+
+	reset_control_assert(sp_priv->ehci_rstc);
+	clk_disable_unprepare(sp_priv->ehci_clk);
+}
+
+static struct usb_ehci_pdata usb_ehci_pdata = {
+	.has_tt = 1,
+	.has_synopsys_hc_bug = 1,
+	.big_endian_desc = 1,
+	.big_endian_mmio = 1,
+	.power_on = sp_ehci_platform_power_on,
+	.power_suspend = sp_ehci_platform_power_off,
+	.power_off = sp_ehci_platform_power_off,
+
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
+	struct usb_ehci_pdata *pdata = &usb_ehci_pdata;
+	struct usb_hcd *hcd;
+	int irq, ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	pdev->dev.platform_data = pdata;
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
+		dev_err(dev, "no USB phy configured\n");
+		ret = PTR_ERR(sp_priv->phy);
+		goto err_put_hcd;
+	}
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
+	if (pdata->power_on) {
+		ret = pdata->power_on(pdev);
+		if (ret < 0)
+			goto err_put_hcd;
+	}
+
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto err_put_hcd;
+
+	dev_dbg(dev, "hcd_irq:%d,%d\n", hcd->irq, irq);
+
+	return ret;
+
+err_put_hcd:
+	usb_put_hcd(hcd);
+
+	return ret;
+}
+
+static int ehci_sunplus_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct usb_ehci_pdata *pdata = pdev->dev.platform_data;
+
+	usb_remove_hcd(hcd);
+	usb_put_hcd(hcd);
+
+	if (pdata->power_off)
+		pdata->power_off(pdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ehci_sunplus_drv_suspend(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct usb_ehci_pdata *pdata = pdev->dev.platform_data;
+	bool do_wakeup = device_may_wakeup(dev);
+	int rc;
+
+	rc = ehci_suspend(hcd, do_wakeup);
+	if (rc)
+		return rc;
+
+	if (pdata->power_suspend)
+		pdata->power_suspend(pdev);
+
+	return 0;
+}
+
+static int ehci_sunplus_drv_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct usb_ehci_pdata *pdata = pdev->dev.platform_data;
+	int ret;
+
+	if (pdata->power_on) {
+		ret = pdata->power_on(pdev);
+		if (ret < 0)
+			return ret;
+	}
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

