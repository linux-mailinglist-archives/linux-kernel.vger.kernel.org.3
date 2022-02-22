Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A64BFA70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiBVOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiBVOJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:09:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1CA515F620;
        Tue, 22 Feb 2022 06:08:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8075A139F;
        Tue, 22 Feb 2022 06:08:56 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A4D23F5A1;
        Tue, 22 Feb 2022 06:08:54 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [[PATCH v2 2/2] OPP: Add 'opp-microwatt' parsing for advanced EM registration
Date:   Tue, 22 Feb 2022 14:07:46 +0000
Message-Id: <20220222140746.12293-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222140746.12293-1-lukasz.luba@arm.com>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
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
registration callback. The new mechanism parses OPP node in DT which
contains the power expressed in micro-Watts. It also allows to register
'advanced' EM, which models total power (static + dynamic), so better
reflects real HW.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/opp/of.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2f40afa4e65c..94059408fa39 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1395,6 +1395,40 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
 
+/*
+ * Callback function provided to the Energy Model framework upon registration.
+ * It provides the power based on DT by @dev at @kHz if it is the frequency
+ * of an existing OPP, or at the frequency of the first OPP above @kHz otherwise
+ * (see dev_pm_opp_find_freq_ceil()). This function updates @kHz to the ceiled
+ * frequency and @mW to the associated power.
+ *
+ * Returns 0 on success or a proper -EINVAL value in case of error.
+ */
+static int __maybe_unused
+_get_dt_power(unsigned long *mW, unsigned long *kHz, struct device *dev)
+{
+	struct dev_pm_opp *opp;
+	unsigned long opp_freq;
+	u32 opp_power;
+	int ret;
+
+	/* Find the right frequency and related OPP */
+	opp_freq = *kHz * 1000;
+	opp = dev_pm_opp_find_freq_ceil(dev, &opp_freq);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	ret = of_property_read_u32(opp->np, "opp-microwatt", &opp_power);
+	dev_pm_opp_put(opp);
+	if (ret)
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
@@ -1445,6 +1479,33 @@ static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
 	return 0;
 }
 
+static int _of_find_opp_microwatt_property(struct device *dev)
+{
+	unsigned long freq = 0;
+	struct dev_pm_opp *opp;
+	struct device_node *np;
+	struct property *prop;
+
+	/* We only support "operating-points-v2" */
+	np = dev_pm_opp_of_get_opp_desc_node(dev);
+	if (!np)
+		return -EINVAL;
+
+	of_node_put(np);
+
+	/* Check if an OPP has needed property */
+	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	prop = of_find_property(opp->np, "opp-microwatt", NULL);
+	dev_pm_opp_put(opp);
+	if (!prop)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
  * @dev		: Device for which an Energy Model has to be registered
@@ -1474,6 +1535,15 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
 		goto failed;
 	}
 
+	/* First, try to find more precised Energy Model in DT */
+	if (!_of_find_opp_microwatt_property(dev)) {
+		struct em_data_callback em_dt_cb = EM_DATA_CB(_get_dt_power);
+
+		ret = em_dev_register_perf_domain(dev, nr_opp, &em_dt_cb,
+						  cpus, true);
+		return ret;
+	}
+
 	np = of_node_get(dev->of_node);
 	if (!np) {
 		ret = -EINVAL;
-- 
2.17.1

