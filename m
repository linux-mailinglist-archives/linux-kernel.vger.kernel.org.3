Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0EE578C61
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiGRVEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGRVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:04:08 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0595F9C;
        Mon, 18 Jul 2022 14:04:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 63568DFD98;
        Mon, 18 Jul 2022 14:03:37 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qLf0g0JBxtjg; Mon, 18 Jul 2022 14:03:36 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658178216; bh=coP93VScilORteduQuspHDA/cmepu8F3rCapfkKamXU=;
        h=From:To:Cc:Subject:Date:From;
        b=o8u2lijPpxMwj6UcIJq3GTRFoqULSI+vFOJDaXoGwlPe7jki14OBaFjh0SpWC47I9
         khPQgNpdKMO2zrkwZOs9LqaTO7+q58e0l1hQkrjJeahg7qnDMmINO5tu/wyKNIog8N
         URnKCcYpTetjlOL/JCEqHsaRp93q720uTk1dRAp8e9+8qTGfFKceFPlulyVUG1ib1B
         sDHcwBJ6a/08SztCvvTeEvrfaBHPOBs+BMDn/wIVE/w9p9UrFPDBKPNK4RihF2eMfh
         a6n+PuFKU+DrspB+KayZIORRt58Zccpq3VbtediElkyAuMVFJHvTqzwANUiunFWdGR
         yTOLhz55MAZ8w==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 1/2] power: domain: handle power supplies that need interrupts
Date:   Mon, 18 Jul 2022 23:03:01 +0200
Message-Id: <20220718210302.674897-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the power-domains' power-supply node (regulator) needs
interrupts to work, the current setup with noirq callbacks cannot
work; for example a pmic regulator on i2c, when suspending, usually already
times out during suspend_noirq:

[   41.024193] buck4: failed to disable: -ETIMEDOUT

So fix system suspend and resume for these power-domains by using the
"outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5 board,
but by looking at the dts, this will fix imx8mq-evk and possibly other boards
too.

Possibly one can find more changes than suspend/resume for this case. They
can be added later when testing them: This is designed so that genpd
providers just say "this power-supply" needs interrupts - without implying
what exactly should be configured in genpd.

Initially system suspend problems had been discussed at
https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
which led to discussing the pmic that contains the regulators which
serve as power-domain power-supplies:
https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

revision history
----------------
v3: (thank you Ulf)
* move DT parsing to gpcv2 and create a genpd flag that gets set

v2: (thank you Krzysztof)
* rewrite: find possible regulators' interrupts property in parents
  instead of inventing a new property.
https://lore.kernel.org/linux-arm-kernel/20220712121832.3659769-1-martin.kepplinger@puri.sm/

v1: (initial idea)
https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t


 drivers/base/power/domain.c | 19 +++++++++++++++++++
 drivers/soc/imx/gpcv2.c     |  9 +++++++++
 include/linux/pm_domain.h   |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 739e52cd4aba..1437476c9086 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
+#define genpd_ps_needs_irq(genpd)	(genpd->flags & GENPD_FLAG_IRQ_POWER_SUPPLY)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2298,6 +2299,20 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 	return ret;
 }
 
+/**
+ * of_genpd_get_power_supply_irq() - Adjust if power-supply needs interrupts
+ * @genpd: Pointer to PM domain associated with the PM domain provider.
+ */
+static void of_genpd_config_power_supply_irq(struct generic_pm_domain *pd)
+{
+	if (genpd_ps_needs_irq(pd)) {
+		pd->domain.ops.suspend = genpd_suspend_noirq;
+		pd->domain.ops.resume = genpd_resume_noirq;
+		pd->domain.ops.suspend_noirq = NULL;
+		pd->domain.ops.resume_noirq = NULL;
+	}
+}
+
 /**
  * of_genpd_add_provider_simple() - Register a simple PM domain provider
  * @np: Device node pointer associated with the PM domain provider.
@@ -2343,6 +2358,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	genpd->provider = &np->fwnode;
 	genpd->has_provider = true;
 
+	of_genpd_config_power_supply_irq(genpd);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
@@ -2394,6 +2411,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		genpd->provider = &np->fwnode;
 		genpd->has_provider = true;
+
+		of_genpd_config_power_supply_irq(genpd);
 	}
 
 	ret = genpd_add_provider(np, data->xlate, data);
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 85aa86e1338a..3a22bad07534 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1303,6 +1303,7 @@ static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
+	struct device_node *dn;
 	int ret;
 
 	domain->dev = &pdev->dev;
@@ -1333,6 +1334,14 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		regmap_update_bits(domain->regmap, domain->regs->map,
 				   domain->bits.map, domain->bits.map);
 
+	dn = of_parse_phandle(domain->dev->of_node, "power-supply", 0);
+	if (dn) {
+		while ((dn = of_get_next_parent(dn))) {
+			if (of_get_property(dn, "interrupts", NULL))
+				domain->genpd.flags |= GENPD_FLAG_IRQ_POWER_SUPPLY;
+		}
+	}
+
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ebc351698090..bcceaf376f36 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -60,6 +60,11 @@
  * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
  *				components' next wakeup when determining the
  *				optimal idle state.
+ *
+ * GENPD_FLAG_IRQ_POWER_SUPPLY:	The power-domains' power-supply (regulator)
+ *				needs interrupts to work. Adjust accordingly.
+ *				Use the outer suspend/resume callbacks instead
+ *				of noirq for example.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -68,6 +73,7 @@
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
+#define GENPD_FLAG_IRQ_POWER_SUPPLY (1U << 7)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.30.2

