Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641C556FF04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiGKKgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiGKKfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:35:55 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABADB2C8;
        Mon, 11 Jul 2022 02:46:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 986B6E0090;
        Mon, 11 Jul 2022 02:46:24 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uv09orjE0Q0L; Mon, 11 Jul 2022 02:46:23 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1657532783; bh=xRZj8xi+fQlByAMa9+liyCTkl4j540l3J57WaZpwvHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GUw3eCZFeBYWQNkZyl5Jp57hvHC5GlKaA5jVjgVTKMY+0uvJkKJFXHceyGTZ8eOy+
         CZIUVjJdszsYsp+9BOZkSZXdzzVIlmJWUXc7TOa+/fDzwxqbBMkiXKbVBQjB86ShK1
         C0BDP/DGbrSqVzcz3olhT8HONGot8CBLi851YQA64GC0J+/G1kSUS/BEUiQtXryoEU
         j5yfvsymSjfWE5PRiRJxrm6la9cWMVGQ1/aNWCqqMGZT15YewF5YpGQwtDTokTFZzq
         0wxlqpqdDezyVnS48iJt2cmCdqjBDLw9hbGhgtAkfYX+FJvI8hWaok3lQJkrXNu98p
         WJR5Yw1sMy9Hg==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 1/3] power: domain: handle power supplies that need irq
Date:   Mon, 11 Jul 2022 11:45:47 +0200
Message-Id: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle a new DT property power-supply-needs-irq that boards can
use if the power-domains' power-supply node (regulator) needs
interrupts to function. An example is a pmic regulator on i2c.

Since suspend/resume doesn't work in these cases currently, switch
to the normal, outer suspend/resume callbacks.

Usually such a regulator already times out during suspend_noirq:

[   41.024193] buck4: failed to disable: -ETIMEDOUT

Initially systemd suspend problems had been discussed at
https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
which led to discussing the pmic that contains the regulators which
serve as power-domain power-supplies:
https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/

So this enables boards to use power-supply-needs-irq and fix systemd
suspend and resume.

Possibly one can find more changes this property should configure. They
can be added later when testing them.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/base/power/domain.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3e86772d5fac..c8fecba2c191 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2298,6 +2298,16 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 	return ret;
 }
 
+static void of_genpd_get_power_supply_irq(struct generic_pm_domain *pd)
+{
+	if (of_property_read_bool(pd->dev.of_node, "power-supply-needs-irq")) {
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
@@ -2343,6 +2353,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	genpd->provider = &np->fwnode;
 	genpd->has_provider = true;
 
+	of_genpd_get_power_supply_irq(genpd);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
@@ -2394,6 +2406,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		genpd->provider = &np->fwnode;
 		genpd->has_provider = true;
+
+		of_genpd_get_power_supply_irq(genpd);
 	}
 
 	ret = genpd_add_provider(np, data->xlate, data);
-- 
2.30.2

