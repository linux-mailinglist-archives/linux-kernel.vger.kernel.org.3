Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646AB4ED6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiCaJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiCaJ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:28:49 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 02:27:01 PDT
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CBF1FDFEE;
        Thu, 31 Mar 2022 02:27:00 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="46896822"
X-IronPort-AV: E=Sophos;i="5.90,224,1643641200"; 
   d="scan'208";a="46896822"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 31 Mar 2022 18:25:54 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E7E6AC68A4;
        Thu, 31 Mar 2022 18:25:53 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2A4BA30147;
        Thu, 31 Mar 2022 18:25:53 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id CB929400C07B8;
        Thu, 31 Mar 2022 18:25:52 +0900 (JST)
From:   Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
To:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-serial@vger.kernel.org, sumit.garg@linaro.org
Cc:     arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, peterz@infradead.org,
        hasegawa-hitomi@fujitsu.com
Subject: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
Date:   Thu, 31 Mar 2022 18:22:35 +0900
Message-Id: <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable diagnostic interrupts for the A64FX.
This is done using a pseudo-NMI.

Signed-off-by: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
---
 MAINTAINERS                      |   5 +
 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/fujitsu/Kconfig      |  13 +++
 drivers/soc/fujitsu/Makefile     |   3 +
 drivers/soc/fujitsu/a64fx-diag.c | 151 +++++++++++++++++++++++++++++++
 6 files changed, 174 insertions(+)
 create mode 100644 drivers/soc/fujitsu/Kconfig
 create mode 100644 drivers/soc/fujitsu/Makefile
 create mode 100644 drivers/soc/fujitsu/a64fx-diag.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cd0f68d4a34a..dc35c81ba917 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -241,6 +241,11 @@ F:	include/trace/events/9p.h
 F:	include/uapi/linux/virtio_9p.h
 F:	net/9p/
 
+A64FX DIAG DRIVER
+M:	Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
+S:	Supported
+F:	drivers/soc/fujitsu/a64fx-diag.c
+
 A8293 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index a8562678c437..e10eb27e1e7e 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,7 @@ source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
 source "drivers/soc/fsl/Kconfig"
+source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index adb30c2d4fea..b12b0b03ad47 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SOC_CANAAN)	+= canaan/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
+obj-y				+= fujitsu/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-y				+= imx/
 obj-y				+= ixp4xx/
diff --git a/drivers/soc/fujitsu/Kconfig b/drivers/soc/fujitsu/Kconfig
new file mode 100644
index 000000000000..b41cdac67637
--- /dev/null
+++ b/drivers/soc/fujitsu/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "fujitsu SoC drivers"
+
+config A64FX_DIAG
+	bool "A64FX diag driver"
+	depends on ARM64
+	help
+	  Say Y here if you want to enable diag interrupt on A64FX.
+	  This driver uses pseudo-NMI if available.
+
+	  If unsure, say N.
+
+endmenu
diff --git a/drivers/soc/fujitsu/Makefile b/drivers/soc/fujitsu/Makefile
new file mode 100644
index 000000000000..945bc1c14ad0
--- /dev/null
+++ b/drivers/soc/fujitsu/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_A64FX_DIAG)	+= a64fx-diag.o
diff --git a/drivers/soc/fujitsu/a64fx-diag.c b/drivers/soc/fujitsu/a64fx-diag.c
new file mode 100644
index 000000000000..c6f895cf8912
--- /dev/null
+++ b/drivers/soc/fujitsu/a64fx-diag.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A64FX diag driver.
+ */
+
+#include <linux/acpi.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sysrq.h>
+
+#define A64FX_DIAG_IRQ 1
+#define BMC_DIAG_INTERRUPT_STATUS_OFFSET (0x0044)
+#define BMC_INTERRUPT_STATUS_MASK ((1U) << 31)
+#define BMC_DIAG_INTERRUPT_ENABLE_OFFSET (0x0040)
+#define BMC_INTERRUPT_ENABLE_MASK ((1U) << 31)
+
+struct a64fx_diag_priv {
+	int irq;
+	void __iomem *mmsc_reg_base;
+	bool has_nmi;
+};
+
+static irqreturn_t a64fx_diag_handler(int irq, void *dev_id)
+{
+	handle_sysrq('c');
+
+	return IRQ_HANDLED;
+}
+
+static void a64fx_diag_interrupt_clear(struct a64fx_diag_priv *priv)
+{
+	u32 mmsc;
+	const void __iomem *diag_status_reg_addr;
+
+	diag_status_reg_addr = priv->mmsc_reg_base + BMC_DIAG_INTERRUPT_STATUS_OFFSET;
+	mmsc = readl(diag_status_reg_addr);
+	if (mmsc & BMC_INTERRUPT_STATUS_MASK)
+		writel(BMC_INTERRUPT_STATUS_MASK, (void *)diag_status_reg_addr);
+}
+
+static void a64fx_diag_interrupt_enable(struct a64fx_diag_priv *priv)
+{
+	u32 mmsc;
+	const void __iomem *diag_enable_reg_addr;
+
+	diag_enable_reg_addr = priv->mmsc_reg_base + BMC_DIAG_INTERRUPT_ENABLE_OFFSET;
+	mmsc = readl(diag_enable_reg_addr);
+	if (!(mmsc & BMC_INTERRUPT_ENABLE_MASK)) {
+		mmsc |= BMC_INTERRUPT_STATUS_MASK;
+		writel(mmsc, (void *)diag_enable_reg_addr);
+	}
+}
+
+static void a64fx_diag_interrupt_disable(struct a64fx_diag_priv *priv)
+{
+	u32 mmsc;
+	const void __iomem *diag_enable_reg_addr;
+
+	diag_enable_reg_addr = priv->mmsc_reg_base + BMC_DIAG_INTERRUPT_ENABLE_OFFSET;
+	mmsc = readl(diag_enable_reg_addr);
+	if (mmsc & BMC_INTERRUPT_ENABLE_MASK) {
+		mmsc &= ~BMC_INTERRUPT_ENABLE_MASK;
+		writel(mmsc, (void *)diag_enable_reg_addr);
+	}
+}
+
+static int a64fx_diag_probe(struct platform_device *pdev)
+{
+	int ret;
+	unsigned long irq_flags;
+	struct device *dev = &pdev->dev;
+	struct a64fx_diag_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(struct a64fx_diag_priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	priv->mmsc_reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->mmsc_reg_base))
+		return PTR_ERR(priv->mmsc_reg_base);
+
+	priv->irq = platform_get_irq(pdev, A64FX_DIAG_IRQ);
+	if (priv->irq < 0)
+		return priv->irq;
+
+	platform_set_drvdata(pdev, priv);
+
+	a64fx_diag_interrupt_clear(priv);
+	a64fx_diag_interrupt_enable(priv);
+
+	irq_flags = IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
+		   IRQF_NO_THREAD;
+	ret = request_nmi(priv->irq, &a64fx_diag_handler, irq_flags,
+			"a64fx_diag_nmi", NULL);
+	if (ret) {
+		ret = request_irq(priv->irq, &a64fx_diag_handler,
+				irq_flags, "a64fx_diag_irq", NULL);
+		if (ret) {
+			dev_err(dev, "cannot register IRQ %d\n", ret);
+			return ret;
+		}
+		enable_irq(priv->irq);
+		priv->has_nmi = false;
+		dev_info(dev, "registered for IRQ %d\n", priv->irq);
+	} else {
+		enable_nmi(priv->irq);
+		priv->has_nmi = true;
+		dev_info(dev, "registered for NMI %d\n", priv->irq);
+	}
+
+	return 0;
+}
+
+static int __exit a64fx_diag_remove(struct platform_device *pdev)
+{
+	struct a64fx_diag_priv *priv = platform_get_drvdata(pdev);
+
+	a64fx_diag_interrupt_disable(priv);
+	a64fx_diag_interrupt_clear(priv);
+
+	if (priv->has_nmi)
+		free_nmi(priv->irq, NULL);
+	else
+		free_irq(priv->irq, NULL);
+
+	return 0;
+}
+
+static const struct acpi_device_id a64fx_diag_acpi_match[] = {
+	{ "FUJI2007", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, a64fx_diag_acpi_match);
+
+
+static struct platform_driver a64fx_diag_driver = {
+	.driver = {
+		.name = "a64fx_diag_driver",
+		.acpi_match_table = ACPI_PTR(a64fx_diag_acpi_match),
+	},
+	.probe = a64fx_diag_probe,
+	.remove = a64fx_diag_remove,
+};
+
+module_platform_driver(a64fx_diag_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>");
+MODULE_DESCRIPTION("A64FX diag driver");
-- 
2.27.0

