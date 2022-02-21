Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38B4BED6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiBUWwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:52:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiBUWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:52:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D41092458C;
        Mon, 21 Feb 2022 14:51:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3CCC106F;
        Mon, 21 Feb 2022 14:51:46 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E6623F66F;
        Mon, 21 Feb 2022 14:51:44 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC][PATCH 2/2] opp: Add support for 'advanced' Energy Model in DT
Date:   Mon, 21 Feb 2022 22:51:31 +0000
Message-Id: <20220221225131.15836-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220221225131.15836-1-lukasz.luba@arm.com>
References: <20220221225131.15836-1-lukasz.luba@arm.com>
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
registration callback. The new mechanism parses EM array specified in DT
which contains a set of tuples: frequency (in kHz) and power (uW).
It also allows to register 'advanced' EM, which models total power
(static + dynamic), so better reflects real HW.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/opp/of.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2f40afa4e65c..af879c798934 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1395,6 +1395,85 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
 
+/*
+ * Callback function provided to the Energy Model framework upon registration.
+ * It provides the power based on DT by @dev at @kHz if it is the frequency
+ * of an existing OPP, or at the frequency of the first OPP above @kHz otherwise
+ * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
+ * frequency and @mW to the associated power. The power is a value specified
+ * in DT for a given frequency. It's a total power (static + dynamic), so
+ * better reflects the real HW characteristics.
+ *
+ * Returns 0 on success or a proper -E* value in case of error.
+ */
+static int __maybe_unused
+_get_dt_power(unsigned long *mW, unsigned long *kHz, struct device *dev)
+{
+	struct device_node *np, *em_node;
+	const struct property *prop;
+	struct dev_pm_opp *opp;
+	unsigned long opp_freq;
+	const __be32 *val;
+	int nr;
+
+	np = of_node_get(dev->of_node);
+	if (!np)
+		return -EINVAL;
+
+	/* Find the right frequency and convert it to kHz */
+	opp_freq = *kHz * 1000;
+	opp = dev_pm_opp_find_freq_ceil(dev, &opp_freq);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	opp_freq /= 1000;
+
+	em_node = of_parse_phandle(np, "energy-model", 0);
+	of_node_put(np);
+	if (!em_node) {
+		dev_warn(dev, "%s: No EM phandle found\n", __func__);
+		return -EINVAL;
+	}
+
+	prop = of_find_property(em_node, "energy-model-entries", NULL);
+	of_node_put(em_node);
+	if (!prop) {
+		dev_warn(dev, "%s: No EM entries found\n", __func__);
+		return -ENODEV;
+	}
+
+	if (!prop->value) {
+		dev_warn(dev, "%s: No EM entries value found\n", __func__);
+		return -ENODATA;
+	}
+
+	/*
+	 * Each EM entry is a set of tuples consisting of Frequency and
+	 * Power like <freq-kHz power-uW>.
+	 */
+	nr = prop->length / sizeof(u32);
+	if (nr % 2) {
+		dev_warn(dev, "%s: Invalid EM DT table\n", __func__);
+		return -EINVAL;
+	}
+
+	val = prop->value;
+	while (nr) {
+		unsigned long freq = be32_to_cpup(val++);
+		unsigned long power = be32_to_cpup(val++);
+
+		if (opp_freq == freq) {
+			*kHz = opp_freq;
+			*mW = power / 1000;
+			return 0;
+		}
+
+		nr -= 2;
+	}
+
+	return -EINVAL;
+}
+
 /*
  * Callback function provided to the Energy Model framework upon registration.
  * This computes the power estimated by @dev at @kHz if it is the frequency
@@ -1459,7 +1538,7 @@ static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
 int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 {
 	struct em_data_callback em_cb = EM_DATA_CB(_get_power);
-	struct device_node *np;
+	struct device_node *np, *em_node;
 	int ret, nr_opp;
 	u32 cap;
 
@@ -1480,6 +1559,20 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 		goto failed;
 	}
 
+	/* First, try to find more precised Energy Model array in DT */
+	em_node = of_parse_phandle(np, "energy-model", 0);
+	of_node_put(np);
+	if (em_node) {
+		struct em_data_callback em_dt_cb = EM_DATA_CB(_get_dt_power);
+
+		pr_info("EM: found energy-model phandle node\n");
+		of_node_put(em_node);
+		ret = em_dev_register_perf_domain(dev, nr_opp, &em_dt_cb, cpus, true);
+		if (ret)
+			goto failed;
+		return 0;
+	}
+
 	/*
 	 * Register an EM only if the 'dynamic-power-coefficient' property is
 	 * set in devicetree. It is assumed the voltage values are known if that
-- 
2.17.1

