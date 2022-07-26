Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E367B580F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiGZIdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiGZIdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:33:12 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72362DA9A;
        Tue, 26 Jul 2022 01:33:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 50486DFD55;
        Tue, 26 Jul 2022 01:33:11 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L9ens6mJboms; Tue, 26 Jul 2022 01:33:10 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658824390; bh=CtZHJaWb605GvXh6ITYJsJOpwsFY2AdI1ZfEZejnCUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYee2IzqBrFb+coRiZ+mLMST3G8YOOjBKdivuBC+tOe+iE5P1jHPzlC9B5PYjVnPr
         84kVNjFtIaiNBMzpu95e29+0lz7Uj7Sfh2Awaqm477V41HaSe4Bn1Qd6xbRMg7mNGk
         7Lfr+WFZ29JoN98BiJQw7jZT7jS0IpH9ZTRlLaVzGO254/jZoLSPNJGPsyjcSyVoNj
         MmhgDU/+r27L0MAXGVpgtQDD9ET0KnElWu+mXGMI7JFZZPZExqMjuUwQKFjuvZ9UWO
         jgvX7XJU9fLx+kN15K8nk5QEepqPo4jH9CTnjkN1IGYMK0V7e9c2bR/ckRh9gZJJfs
         /F2YGAD6WK7xw==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v6 1/2] power: domain: handle genpd correctly when needing interrupts
Date:   Tue, 26 Jul 2022 10:32:56 +0200
Message-Id: <20220726083257.1730630-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
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
 drivers/base/power/domain.c | 13 +++++++++++--
 include/linux/pm_domain.h   |  5 +++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5a2e0232862e..58376752a4de 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
+#define genpd_irq_on(genpd)		(genpd->flags & GENPD_FLAG_IRQ_ON)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2065,8 +2066,15 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
 	genpd->domain.ops.prepare = genpd_prepare;
-	genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
-	genpd->domain.ops.resume_noirq = genpd_resume_noirq;
+
+	if (genpd_irq_on(genpd)) {
+		genpd->domain.ops.suspend = genpd_suspend_noirq;
+		genpd->domain.ops.resume = genpd_resume_noirq;
+	} else {
+		genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
+		genpd->domain.ops.resume_noirq = genpd_resume_noirq;
+	}
+
 	genpd->domain.ops.freeze_noirq = genpd_freeze_noirq;
 	genpd->domain.ops.thaw_noirq = genpd_thaw_noirq;
 	genpd->domain.ops.poweroff_noirq = genpd_poweroff_noirq;
@@ -2769,6 +2777,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 			goto err;
 		dev_gpd_data(dev)->default_pstate = pstate;
 	}
+
 	return 1;
 
 err:
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ebc351698090..9cdedbc21158 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -60,6 +60,10 @@
  * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
  *				components' next wakeup when determining the
  *				optimal idle state.
+ *
+ * GENPD_FLAG_IRQ_ON:		genpd needs irqs to be able to manage power
+ *				on/off. Use the outer suspend/resume callbacks
+ *				instead of noirq for example.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -68,6 +72,7 @@
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
+#define GENPD_FLAG_IRQ_ON	 (1U << 7)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.30.2

