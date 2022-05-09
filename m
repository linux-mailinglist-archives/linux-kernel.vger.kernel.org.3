Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B73520944
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiEIXkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiEIXjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:39:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BE25A78C;
        Mon,  9 May 2022 16:34:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 7BE1A1F4422B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652139273;
        bh=XtOxeNpEZBzsEZoOwk1w0xc4u4++IeNM8JHEy/MILRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGGv7NB7YFjR/XyFr6bky/W+z/hPJaeKzOrZp6S3NkKmsspZefTK98eiyR/2PprHF
         SZXwZ9k9uPPdX2japixfTOG/AkmkZ3D+LB7Udgq8t/o13fV+sK+wTnOE/L4HgXdA53
         nvSDO9U/xKP8LpKY1VJetO4hoBC6fW0zfXiuOgG/3L6dFRe9KpmJts3DTUhBhSu7D4
         /z4YOyQOb4V/fbU6Imyw0C5sByK4+txkAyVBFrLWSJ5ovT1rrtNZtFjsKgKayHBUAG
         dYw8SdmUATaBmvB/AvJb06MJ7Bn9SOe65TF2LOFEbL8F4bwXe+OpgmwAQ88g/rheVt
         rGHHW0DMlZ6Ag==
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
Subject: [PATCH v8 23/27] regulator: pfuze100: Use devm_register_sys_off_handler()
Date:   Tue, 10 May 2022 02:32:31 +0300
Message-Id: <20220509233235.995021-24-dmitry.osipenko@collabora.com>
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

Use devm_register_sys_off_handler() that replaces global
pm_power_off_prepare variable and allows to register multiple
power-off handlers.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/regulator/pfuze100-regulator.c | 42 +++++++++++---------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index d60d7d1b7fa2..0322f6b1fb60 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -10,6 +10,7 @@
 #include <linux/of_device.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/pfuze100.h>
@@ -569,10 +570,10 @@ static inline struct device_node *match_of_node(int index)
 	return pfuze_matches[index].of_node;
 }
 
-static struct pfuze_chip *syspm_pfuze_chip;
-
-static void pfuze_power_off_prepare(void)
+static int pfuze_power_off_prepare(struct sys_off_data *data)
 {
+	struct pfuze_chip *syspm_pfuze_chip = data->cb_data;
+
 	dev_info(syspm_pfuze_chip->dev, "Configure standby mode for power off");
 
 	/* Switch from default mode: APS/APS to APS/Off */
@@ -607,28 +608,30 @@ static void pfuze_power_off_prepare(void)
 	regmap_update_bits(syspm_pfuze_chip->regmap, PFUZE100_VGEN6VOL,
 			   PFUZE100_VGENxLPWR | PFUZE100_VGENxSTBY,
 			   PFUZE100_VGENxSTBY);
+
+	return NOTIFY_DONE;
 }
 
 static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip)
 {
+	int err;
+
 	if (pfuze_chip->chip_id != PFUZE100) {
 		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler for not supported chip\n");
 		return -ENODEV;
 	}
 
-	if (pm_power_off_prepare) {
-		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registered.\n");
-		return -EBUSY;
+	err = devm_register_sys_off_handler(pfuze_chip->dev,
+					    SYS_OFF_MODE_POWER_OFF_PREPARE,
+					    SYS_OFF_PRIO_DEFAULT,
+					    pfuze_power_off_prepare,
+					    pfuze_chip);
+	if (err) {
+		dev_err(pfuze_chip->dev, "failed to register sys-off handler: %d\n",
+			err);
+		return err;
 	}
 
-	if (syspm_pfuze_chip) {
-		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
-		return -EBUSY;
-	}
-
-	syspm_pfuze_chip = pfuze_chip;
-	pm_power_off_prepare = pfuze_power_off_prepare;
-
 	return 0;
 }
 
@@ -837,23 +840,12 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int pfuze100_regulator_remove(struct i2c_client *client)
-{
-	if (syspm_pfuze_chip) {
-		syspm_pfuze_chip = NULL;
-		pm_power_off_prepare = NULL;
-	}
-
-	return 0;
-}
-
 static struct i2c_driver pfuze_driver = {
 	.driver = {
 		.name = "pfuze100-regulator",
 		.of_match_table = pfuze_dt_ids,
 	},
 	.probe = pfuze100_regulator_probe,
-	.remove = pfuze100_regulator_remove,
 };
 module_i2c_driver(pfuze_driver);
 
-- 
2.35.1

