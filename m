Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1B57B00B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiGTEgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiGTEgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:36:18 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0A371AB;
        Tue, 19 Jul 2022 21:36:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id F3A0DDFF57;
        Tue, 19 Jul 2022 21:35:44 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6iBEMZdunAGx; Tue, 19 Jul 2022 21:35:44 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658291744; bh=jqOo37x4uFbD+zkK8dBPu6T7uX27EbIdMfsNQPA9bLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qX1yNPqQDzcEUzERq3Wbck6SydsQbv6QmMltZMU/2Oogf39Y/lSfwDju+PtmyUNFu
         2S/STXvXerifxRXcZ9AaIkli5IXcWmFRD25v493SMR4FxN4FRND/711mgVJhClrM9k
         fYdsV1NR6uVrCqCWxP2oXdYuN0HCy190UusrrdST2btMeCD37mOCVoBMmVqa3N6vNs
         g+fMEPrYwsY3I1sOz+7TqidEEcYL1JbqNbl5vtE95LfahpFpXU/KfV/UkB3Tzazik2
         zYl04VyPI1uGUqjfB2T5gh43Jb1zvZtrYWzZRxxEFnOghCSA5JpSWVwPItR4+TyrRO
         YnO0mmZqHMayg==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 2/3] power: domain: handle genpd correctly when needing interrupts
Date:   Wed, 20 Jul 2022 06:34:43 +0200
Message-Id: <20220720043444.1289952-3-martin.kepplinger@puri.sm>
In-Reply-To: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
References: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
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

If for example the power-domains' power-supply node (regulator) needs
interrupts to work, the current setup with noirq callbacks cannot
work; for example a pmic regulator on i2c, when suspending, usually already
times out during suspend_noirq:

[   41.024193] buck4: failed to disable: -ETIMEDOUT

So fix system suspend and resume for these power-domains by using the
"outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5 board,
but by looking at the dts, this will fix imx8mq-evk and possibly many other
boards too.

This is designed so that genpd providers just say "this genpd needs
interrupts" (by setting the flag) - without implying an implementation.

Initially system suspend problems had been discussed at
https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
which led to discussing the pmic that contains the regulators which
serve as power-domain power-supplies:
https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/base/power/domain.c | 13 +++++++++++++
 include/linux/pm_domain.h   |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 739e52cd4aba..76ea39e960f3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
+#define genpd_irq_on(genpd)		(genpd->flags & GENPD_FLAG_IRQ_ON)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2076,6 +2077,13 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
+	if (genpd_irq_on(genpd)) {
+		genpd->domain.ops.suspend = genpd_suspend_noirq;
+		genpd->domain.ops.resume = genpd_resume_noirq;
+		genpd->domain.ops.suspend_noirq = NULL;
+		genpd->domain.ops.resume_noirq = NULL;
+	}
+
 	/* The always-on governor works better with the corresponding flag. */
 	if (gov == &pm_domain_always_on_gov)
 		genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
@@ -2766,6 +2774,11 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 			goto err;
 		dev_gpd_data(dev)->default_pstate = pstate;
 	}
+
+	if (pd->domain.ops.suspend_noirq && (pd->flags & GENPD_FLAG_IRQ_ON))
+		dev_err(dev, "PM domain %s needs irqs but uses noirq suspend\n",
+			pd->name);
+
 	return 1;
 
 err:
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 76bc9e3ef5ff..03bb86e43550 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -61,6 +61,10 @@
  * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
  *				components' next wakeup when determining the
  *				optimal idle state.
+ *
+ * GENPD_FLAG_IRQ_ON:		genpd needs irqs to be able to manage power
+ *				on/off. Use the outer suspend/resume callbacks
+ *				instead of noirq for example.
  */
 #define GENPD_FLAG_PM_CLK		BIT(0)
 #define GENPD_FLAG_IRQ_SAFE		BIT(1)
@@ -69,6 +73,7 @@
 #define GENPD_FLAG_CPU_DOMAIN		BIT(4)
 #define GENPD_FLAG_RPM_ALWAYS_ON	BIT(5)
 #define GENPD_FLAG_MIN_RESIDENCY	BIT(6)
+#define GENPD_FLAG_IRQ_ON		BIT(7)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.30.2

