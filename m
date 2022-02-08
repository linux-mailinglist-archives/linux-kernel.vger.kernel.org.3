Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFBA4AE0E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384956AbiBHSfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384952AbiBHSfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:35:36 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BCC061576;
        Tue,  8 Feb 2022 10:35:34 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.16.183])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 0319AE36D6DD;
        Tue,  8 Feb 2022 19:35:33 +0100 (CET)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 19:35:32 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <linux-renesas-soc@vger.kernel.org>, <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Phil Edworthy <phil.edworthy@renesas.com>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH v2 5/6] watchdog: Add Renesas RZ/N1 Watchdog driver
Date:   Tue, 8 Feb 2022 19:35:09 +0100
Message-ID: <20220208183511.2925304-6-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208183511.2925304-1-jjhiblot@traphandler.com>
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 13255501081818446164
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeefueeggfeiuedthfdvgeevtedvueevgfevgeelieelveevheefjeejfffguddukeenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfigrthgthhguohhgsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
very limited timeout capabilities. However, it can reset the device.
To do so, the corresponding bits in the SysCtrl RSTEN register need to
be enabled. This is not done by this driver.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/watchdog/Kconfig    |   8 ++
 drivers/watchdog/Makefile   |   1 +
 drivers/watchdog/rzn1_wdt.c | 208 ++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/watchdog/rzn1_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c8fa79da23b3..ba6e4ebef404 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -883,6 +883,14 @@ config RENESAS_RZAWDT
 	  This driver adds watchdog support for the integrated watchdogs in the
 	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
 
+config RENESAS_RZN1WDT
+	tristate "Renesas RZ/N1 watchdog"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This driver adds watchdog support for the integrated watchdogs in the
+	  Renesas RZ/N1 SoCs. These watchdogs can be used to reset a system.
+
 config RENESAS_RZG2LWDT
 	tristate "Renesas RZ/G2L WDT Watchdog"
 	depends on ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f7da867e8782..38d38564f47b 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
 obj-$(CONFIG_RENESAS_RZAWDT) += rza_wdt.o
+obj-$(CONFIG_RENESAS_RZN1WDT) += rzn1_wdt.o
 obj-$(CONFIG_RENESAS_RZG2LWDT) += rzg2l_wdt.o
 obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
 obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
new file mode 100644
index 000000000000..bf548b9eca26
--- /dev/null
+++ b/drivers/watchdog/rzn1_wdt.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/N1 Watchdog timer.
+ * This is a 12-bit timer driver from a (62.5/16384) MHz clock. It can't even
+ * cope with 2 seconds.
+ *
+ * Copyright 2018 Renesas Electronics Europe Ltd.
+ *
+ * Derived from Ralink RT288x watchdog timer.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+#define DEFAULT_TIMEOUT		60
+
+#define RZN1_WDT_RETRIGGER			0x0
+#define RZN1_WDT_RETRIGGER_RELOAD_VAL		0
+#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK	0xfff
+#define RZN1_WDT_RETRIGGER_PRESCALE		BIT(12)
+#define RZN1_WDT_RETRIGGER_ENABLE		BIT(13)
+#define RZN1_WDT_RETRIGGER_WDSI			(0x2 << 14)
+
+#define RZN1_WDT_PRESCALER			16384
+#define RZN1_WDT_MAX				4095
+
+struct rzn1_watchdog {
+	struct watchdog_device		wdt;
+	void __iomem			*base;
+	unsigned long			clk_rate;
+};
+
+#define to_rzn1_watchdog(_ptr) \
+	container_of(_ptr, struct rzn1_watchdog, wdt)
+
+static inline uint32_t get_max_heart_beat(uint32_t clk_rate)
+{
+	return (RZN1_WDT_MAX * RZN1_WDT_PRESCALER) / (clk_rate / 1000);
+}
+static inline uint32_t compute_reload_value(uint32_t tick_ms, uint32_t clk)
+{
+	return (tick_ms * (clk / 1000)) / RZN1_WDT_PRESCALER;
+}
+
+static int rzn1_wdt_ping(struct watchdog_device *w)
+{
+	struct rzn1_watchdog *wdt = to_rzn1_watchdog(w);
+
+	/* Any value retrigggers the watchdog */
+	writel(0, wdt->base + RZN1_WDT_RETRIGGER);
+
+	return 0;
+}
+
+static int rzn1_wdt_start(struct watchdog_device *w)
+{
+	struct rzn1_watchdog *wdt = to_rzn1_watchdog(w);
+	u32 val;
+
+	/*
+	 * The hardware allows you to write to this reg only once.
+	 * Since this includes the reload value, there is no way to change the
+	 * timeout once started. Also note that the WDT clock is half the bus
+	 * fabric clock rate, so if the bus fabric clock rate is changed after
+	 * the WDT is started, the WDT interval will be wrong.
+	 */
+	val = RZN1_WDT_RETRIGGER_WDSI;
+	val |= RZN1_WDT_RETRIGGER_ENABLE;
+	val |= RZN1_WDT_RETRIGGER_PRESCALE;
+	val |= compute_reload_value(w->max_hw_heartbeat_ms, wdt->clk_rate);
+	writel(val, wdt->base + RZN1_WDT_RETRIGGER);
+
+	return 0;
+}
+
+static irqreturn_t rzn1_wdt_irq(int irq, void *_wdt)
+{
+	struct rzn1_watchdog *wdt = (struct rzn1_watchdog *)_wdt;
+
+	dev_info(wdt->wdt.parent, "%s triggered\n", __func__);
+	return IRQ_HANDLED;
+}
+
+static struct watchdog_info rzn1_wdt_info = {
+	.identity = "RZ/N1 Watchdog",
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+};
+
+static const struct watchdog_ops rzn1_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = rzn1_wdt_start,
+	.ping = rzn1_wdt_ping,
+};
+
+static const struct watchdog_device rzn1_wdt = {
+	.info = &rzn1_wdt_info,
+	.ops = &rzn1_wdt_ops,
+	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
+};
+
+static void rzn1_wdt_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static int rzn1_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rzn1_watchdog *wdt;
+	struct device_node *np = dev->of_node;
+	struct clk *clk;
+	int ret;
+	int irq;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->wdt = rzn1_wdt;
+	wdt->wdt.parent = dev;
+
+	wdt->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "failed to get the irq\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
+			       np->name, wdt);
+	if (ret) {
+		dev_err(dev, "failed to request irq %d\n", irq);
+		return ret;
+	}
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get the clock\n");
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare/enable the clock\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, rzn1_wdt_clk_disable_unprepare,
+				       clk);
+	if (ret) {
+		dev_err(dev, "failed to register clock unprepare callback\n");
+		clk_disable_unprepare(clk);
+		return ret;
+	}
+
+	wdt->clk_rate = clk_get_rate(clk);
+	if (!wdt->clk_rate) {
+		dev_err(dev, "failed to get the clock rate\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The period of the watchdog cannot be changed once set
+	 * and is limited to a very short period.
+	 * Configure it for a 1s period once and for all, and
+	 * rely on the heart-beat provided by the watchdog core
+	 * to make this usable by the user-space.
+	 */
+	wdt->wdt.max_hw_heartbeat_ms = get_max_heart_beat(wdt->clk_rate);
+	if (wdt->wdt.max_hw_heartbeat_ms > 1000)
+		wdt->wdt.max_hw_heartbeat_ms = 1000;
+
+	wdt->wdt.timeout = DEFAULT_TIMEOUT;
+	ret = watchdog_init_timeout(&wdt->wdt, 0, dev);
+
+	return devm_watchdog_register_device(dev, &wdt->wdt);
+}
+
+
+static const struct of_device_id rzn1_wdt_match[] = {
+	{ .compatible = "renesas,r9a06g032-wdt" },
+	{ .compatible = "renesas,rzn1-wdt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rzn1_wdt_match);
+
+static struct platform_driver rzn1_wdt_driver = {
+	.probe		= rzn1_wdt_probe,
+	.driver		= {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= rzn1_wdt_match,
+	},
+};
+
+module_platform_driver(rzn1_wdt_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/N1 hardware watchdog");
+MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

