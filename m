Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912E35719BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiGLMTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiGLMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:19:10 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F013E13;
        Tue, 12 Jul 2022 05:19:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 27930DFF4B;
        Tue, 12 Jul 2022 05:19:08 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id glJvJPJ7ZNPy; Tue, 12 Jul 2022 05:19:07 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1657628347; bh=acox3CFtKaZJSGeRCEd240f4YrVQ/SjtXIZA6ATfx3M=;
        h=From:To:Cc:Subject:Date:From;
        b=Ws41I4BQ3pcDRYIvcUALYgsYe/hcXaliNlZcmu0vCfUT1LlNCGV73fHtci99eNBm9
         yKRvdCGrNPRaGUm1ZK3daNPRJAY/puFTw0R2XZ7d1MJnq80pt5FCbIsBpqqVn8Hjii
         byHQortrliQlK6Q4tmYCnLWExQCJdFdJGUEp+tVsdFC8A80PVoVQu9cETCN7Ar0ZKO
         3KANVVsQ3NZRYxNpEWztD22AXiBnnxlhdHAT6MtGAkCYdHEPJRDfnteTXLd4zxi8VS
         h4xYk6J4DcGzxkbW0s3lh74cQ1bsRtTpHzy5NnulqwMNeZ5wJiwcsKnJgrVPybopIg
         7Q+BBaEc9LiFQ==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2] power: domain: handle power supplies that need interrupts
Date:   Tue, 12 Jul 2022 14:18:32 +0200
Message-Id: <20220712121832.3659769-1-martin.kepplinger@puri.sm>
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

If the power-domains' power-supply node (regulator) needs
interrupts to work, the current setup with noirq callbacks cannot
work; for example a pmic regulator on i2c, when suspending, usually already
times out during suspend_noirq:

[   41.024193] buck4: failed to disable: -ETIMEDOUT

So fix system suspend and resume for these power-domains by using the
"outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5
board, but by looking at the dts, this will fix imx8mq-evk and possibly
other boards too.

Possibly one can find more changes than suspend/resume for this case. They
can be added later when testing them.

Initially system suspend problems had been discussed at
https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
which led to discussing the pmic that contains the regulators which
serve as power-domain power-supplies:
https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

revision history
----------------
v2: (thank you Krzysztof)
* rewrite: find possible regulators' interrupts property in parents
  instead of inventing a new property.

v1: (initial idea)
https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t


 drivers/base/power/domain.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3e86772d5fac..ca3e3500939d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2298,6 +2298,28 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 	return ret;
 }
 
+/**
+ * of_genpd_get_power_supply_irq() - Adjust if power-supply needs interrupts
+ * @genpd: Pointer to PM domain associated with the PM domain provider.
+ */
+static void of_genpd_get_power_supply_irq(struct generic_pm_domain *pd)
+{
+	struct device_node *dn;
+
+	dn = of_parse_phandle(pd->dev.of_node, "power-supply", 0);
+	if (!dn)
+		return;
+
+	while ((dn = of_get_next_parent(dn))) {
+		if (of_get_property(dn, "interrupts", NULL)) {
+			pd->domain.ops.suspend = genpd_suspend_noirq;
+			pd->domain.ops.resume = genpd_resume_noirq;
+			pd->domain.ops.suspend_noirq = NULL;
+			pd->domain.ops.resume_noirq = NULL;
+		}
+	}
+}
+
 /**
  * of_genpd_add_provider_simple() - Register a simple PM domain provider
  * @np: Device node pointer associated with the PM domain provider.
@@ -2343,6 +2365,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	genpd->provider = &np->fwnode;
 	genpd->has_provider = true;
 
+	of_genpd_get_power_supply_irq(genpd);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
@@ -2394,6 +2418,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		genpd->provider = &np->fwnode;
 		genpd->has_provider = true;
+
+		of_genpd_get_power_supply_irq(genpd);
 	}
 
 	ret = genpd_add_provider(np, data->xlate, data);
-- 
2.30.2

