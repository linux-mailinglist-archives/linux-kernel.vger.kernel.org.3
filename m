Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E017C4C2597
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiBXINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiBXIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:12:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06238108757;
        Thu, 24 Feb 2022 00:11:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C85DD1509;
        Thu, 24 Feb 2022 00:11:47 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91EBA3F70D;
        Thu, 24 Feb 2022 00:11:45 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 3/4] OPP: Add support of "opp-microwatt" for advanced EM registration
Date:   Thu, 24 Feb 2022 08:11:30 +0000
Message-Id: <20220224081131.27282-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224081131.27282-1-lukasz.luba@arm.com>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) can be created based on DT entry:
'dynamic-power-coefficient'. It's a 'simple' EM which is limited to the
dynamic power. It has to fit into the math formula which requires also
information about voltage. Some of the platforms don't expose voltage
information, thus it's not possible to use EM registration using DT.

This patch aims to fix it. It introduces new implementation of the EM
registration callback. The new mechanism relies on the new OPP feature
allowing to get power (which is coming from "opp-microwatt" DT property)
expressed in micro-Watts.

The patch also opens new opportunity to better support platforms, which
have a decent static power. It allows to register 'advanced' EM (based
on real power measurements) which models total power (static + dynamic),
so better reflects real HW.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/opp/of.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7bff30f27dc1..af3488779867 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1438,6 +1438,38 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
 
+/*
+ * Callback function provided to the Energy Model framework upon registration.
+ * It provides the power used by @dev at @kHz if it is the frequency of an
+ * existing OPP, or at the frequency of the first OPP above @kHz otherwise
+ * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
+ * frequency and @mW to the associated power.
+ *
+ * Returns 0 on success or a proper -EINVAL value in case of error.
+ */
+static int __maybe_unused
+_get_opp_power(unsigned long *mW, unsigned long *kHz, struct device *dev)
+{
+	struct dev_pm_opp *opp;
+	unsigned long opp_freq, opp_power;
+
+	/* Find the right frequency and related OPP */
+	opp_freq = *kHz * 1000;
+	opp = dev_pm_opp_find_freq_ceil(dev, &opp_freq);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	opp_power = dev_pm_opp_get_power(opp);
+	dev_pm_opp_put(opp);
+	if (!opp_power)
+		return -EINVAL;
+
+	*kHz = opp_freq / 1000;
+	*mW = opp_power / 1000;
+
+	return 0;
+}
+
 /*
  * Callback function provided to the Energy Model framework upon registration.
  * This computes the power estimated by @dev at @kHz if it is the frequency
@@ -1488,6 +1520,24 @@ static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
 	return 0;
 }
 
+static bool _of_has_opp_microwatt_property(struct device *dev)
+{
+	unsigned long power, freq = 0;
+	struct dev_pm_opp *opp;
+
+	/* Check if at least one OPP has needed property */
+	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+	if (IS_ERR(opp))
+		return false;
+
+	power = dev_pm_opp_get_power(opp);
+	dev_pm_opp_put(opp);
+	if (!power)
+		return false;
+
+	return true;
+}
+
 /**
  * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
  * @dev		: Device for which an Energy Model has to be registered
@@ -1517,6 +1567,14 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 		goto failed;
 	}
 
+	/* First, try to find more precised Energy Model in DT */
+	if (_of_has_opp_microwatt_property(dev)) {
+		struct em_data_callback em_dt_cb = EM_DATA_CB(_get_opp_power);
+
+		return em_dev_register_perf_domain(dev, nr_opp, &em_dt_cb,
+						   cpus, true);
+	}
+
 	np = of_node_get(dev->of_node);
 	if (!np) {
 		ret = -EINVAL;
-- 
2.17.1

