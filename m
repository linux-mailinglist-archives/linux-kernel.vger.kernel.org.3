Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1341A520963
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiEIXlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiEIXka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:40:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E525D11B;
        Mon,  9 May 2022 16:34:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 5FA2B1F44233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652139281;
        bh=Ge1//7i6Q7MuMgcY2ArEpQFOii60ywtSL9zBDeDpHaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H63Tb2tlpLUiWc6ACD6bN74KE3zuMrgz9FpthVYg38IHOdVsOtd5gN8jhFLo+Pa26
         hs3OdXJ/W7jQd8mbRnl7S0Tm0sIYF5zc1kuEqf5uJUQxP7C97twdtSpF0zmaMHFZpP
         ONQppB1vE3Lpbt5fwJ8pEErw8LFPXaCyFxpYTqpIqc9itsfVnIkxxLday9aSt7wpJs
         YxQBKfwJ/Iz+5zQnhlFym5/j9qqEfpuYXBe4Vcz//MAzUbelLYvi5aQm6UbmkDj593
         dwr3JjS/IdqCE0xS5mAXyMmGozEFSLnZzAzFvgIjlivvRPRrzc9t4UYSSRAb0HfzCv
         wv4pCpKHdQ9Jw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v8 25/27] soc/tegra: pmc: Use sys-off handler API to power off Nexus 7 properly
Date:   Tue, 10 May 2022 02:32:33 +0300
Message-Id: <20220509233235.995021-26-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509233235.995021-1-dmitry.osipenko@collabora.com>
References: <20220509233235.995021-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nexus 7 Android tablet can be turned off using a special bootloader
command which is conveyed to bootloader by putting magic value into the
special scratch register and then rebooting normally. This power-off
method should be invoked if USB cable is connected. Bootloader then will
display battery status and power off the device. This behaviour is
borrowed from downstream kernel and matches user expectations, otherwise
it looks like device got hung during power-off and it may wake up on
USB disconnect.

Switch PMC driver to sys-off handler API, which provides drivers with
chained power-off callbacks functionality that is required for powering-off
devices properly. It also brings resource-managed API for the restart
handler registration that makes PMC driver code cleaner.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/soc/tegra/pmc.c | 87 +++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index c77ecf61818b..5611d14d3ba2 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -39,6 +39,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/power_supply.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -108,6 +109,7 @@
 #define PMC_USB_DEBOUNCE_DEL		0xec
 #define PMC_USB_AO			0xf0
 
+#define PMC_SCRATCH37			0x130
 #define PMC_SCRATCH41			0x140
 
 #define PMC_WAKE2_MASK			0x160
@@ -1101,8 +1103,7 @@ static struct notifier_block tegra_pmc_reboot_notifier = {
 	.notifier_call = tegra_pmc_reboot_notify,
 };
 
-static int tegra_pmc_restart_notify(struct notifier_block *this,
-				    unsigned long action, void *data)
+static void tegra_pmc_restart(void)
 {
 	u32 value;
 
@@ -1110,14 +1111,31 @@ static int tegra_pmc_restart_notify(struct notifier_block *this,
 	value = tegra_pmc_readl(pmc, PMC_CNTRL);
 	value |= PMC_CNTRL_MAIN_RST;
 	tegra_pmc_writel(pmc, value, PMC_CNTRL);
+}
+
+static int tegra_pmc_restart_handler(struct sys_off_data *data)
+{
+	tegra_pmc_restart();
 
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block tegra_pmc_restart_handler = {
-	.notifier_call = tegra_pmc_restart_notify,
-	.priority = 128,
-};
+static int tegra_pmc_power_off_handler(struct sys_off_data *data)
+{
+	/*
+	 * Reboot Nexus 7 into special bootloader mode if USB cable is
+	 * connected in order to display battery status and power off.
+	 */
+	if (of_machine_is_compatible("asus,grouper") &&
+	    power_supply_is_system_supplied()) {
+		const u32 go_to_charger_mode = 0xa5a55a5a;
+
+		tegra_pmc_writel(pmc, go_to_charger_mode, PMC_SCRATCH37);
+		tegra_pmc_restart();
+	}
+
+	return NOTIFY_DONE;
+}
 
 static int powergate_show(struct seq_file *s, void *data)
 {
@@ -2879,6 +2897,42 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		pmc->clk = NULL;
 	}
 
+	/*
+	 * PMC should be last resort for restarting since it soft-resets
+	 * CPU without resetting everything else.
+	 */
+	err = devm_register_reboot_notifier(&pdev->dev,
+					    &tegra_pmc_reboot_notifier);
+	if (err) {
+		dev_err(&pdev->dev, "unable to register reboot notifier, %d\n",
+			err);
+		return err;
+	}
+
+	err = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_LOW,
+					    tegra_pmc_restart_handler, NULL);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register sys-off handler: %d\n",
+			err);
+		return err;
+	}
+
+	/*
+	 * PMC should be primary power-off method if it soft-resets CPU,
+	 * asking bootloader to shutdown hardware.
+	 */
+	err = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_FIRMWARE,
+					    tegra_pmc_power_off_handler, NULL);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register sys-off handler: %d\n",
+			err);
+		return err;
+	}
+
 	/*
 	 * PCLK clock rate can't be retrieved using CLK API because it
 	 * causes lockup if CPU enters LP2 idle state from some other
@@ -2910,28 +2964,13 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 			goto cleanup_sysfs;
 	}
 
-	err = devm_register_reboot_notifier(&pdev->dev,
-					    &tegra_pmc_reboot_notifier);
-	if (err) {
-		dev_err(&pdev->dev, "unable to register reboot notifier, %d\n",
-			err);
-		goto cleanup_debugfs;
-	}
-
-	err = register_restart_handler(&tegra_pmc_restart_handler);
-	if (err) {
-		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
-			err);
-		goto cleanup_debugfs;
-	}
-
 	err = tegra_pmc_pinctrl_init(pmc);
 	if (err)
-		goto cleanup_restart_handler;
+		goto cleanup_debugfs;
 
 	err = tegra_pmc_regmap_init(pmc);
 	if (err < 0)
-		goto cleanup_restart_handler;
+		goto cleanup_debugfs;
 
 	err = tegra_powergate_init(pmc, pdev->dev.of_node);
 	if (err < 0)
@@ -2954,8 +2993,6 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 cleanup_powergates:
 	tegra_powergate_remove_all(pdev->dev.of_node);
-cleanup_restart_handler:
-	unregister_restart_handler(&tegra_pmc_restart_handler);
 cleanup_debugfs:
 	debugfs_remove(pmc->debugfs);
 cleanup_sysfs:
-- 
2.35.1

