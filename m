Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C2D4C25AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiBXINt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiBXIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:12:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E63F33AA7C;
        Thu, 24 Feb 2022 00:11:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D2B2150C;
        Thu, 24 Feb 2022 00:11:45 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.8.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 181903F70D;
        Thu, 24 Feb 2022 00:11:42 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/4] OPP: Add "opp-microwatt" supporting code
Date:   Thu, 24 Feb 2022 08:11:29 +0000
Message-Id: <20220224081131.27282-3-lukasz.luba@arm.com>
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

Add new property to the OPP: power value. The OPP entry in the DT can have
"opp-microwatt". Add the needed code to handle this new property in the
existing infrastructure.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/opp/core.c     | 20 ++++++++++++++++++
 drivers/opp/of.c       | 47 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/pm_opp.h | 12 ++++++++++-
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3057beabd370..5e0cce924ba4 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -113,6 +113,26 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
+/**
+ * dev_pm_opp_get_power() - Gets the power corresponding to an opp
+ * @opp:	opp for which power has to be returned for
+ *
+ * Return: power in micro watt corresponding to the opp, else
+ * return 0
+ *
+ * This is useful only for devices with single power supply.
+ */
+unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
+{
+	if (IS_ERR_OR_NULL(opp)) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->supplies[0].u_watt;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_power);
+
 /**
  * dev_pm_opp_get_freq() - Gets the frequency corresponding to an available opp
  * @opp:	opp for which frequency has to be returned for
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2f40afa4e65c..7bff30f27dc1 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -575,8 +575,9 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			      struct opp_table *opp_table)
 {
-	u32 *microvolt, *microamp = NULL;
-	int supplies = opp_table->regulator_count, vcount, icount, ret, i, j;
+	u32 *microvolt, *microamp = NULL, *microwatt = NULL;
+	int supplies = opp_table->regulator_count;
+	int vcount, icount, pcount, ret, i, j;
 	struct property *prop = NULL;
 	char name[NAME_MAX];
 
@@ -688,6 +689,43 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 		}
 	}
 
+	/* Search for "opp-microwatt" */
+	sprintf(name, "opp-microwatt");
+	prop = of_find_property(opp->np, name, NULL);
+
+	if (prop) {
+		pcount = of_property_count_u32_elems(opp->np, name);
+		if (pcount < 0) {
+			dev_err(dev, "%s: Invalid %s property (%d)\n", __func__,
+				name, pcount);
+			ret = pcount;
+			goto free_microamp;
+		}
+
+		if (pcount != supplies) {
+			dev_err(dev, "%s: Invalid number of elements in %s property (%d) with supplies (%d)\n",
+				__func__, name, pcount, supplies);
+			ret = -EINVAL;
+			goto free_microamp;
+		}
+
+		microwatt = kmalloc_array(pcount, sizeof(*microwatt),
+					  GFP_KERNEL);
+		if (!microwatt) {
+			ret = -EINVAL;
+			goto free_microamp;
+		}
+
+		ret = of_property_read_u32_array(opp->np, name, microwatt,
+						 pcount);
+		if (ret) {
+			dev_err(dev, "%s: error parsing %s: %d\n", __func__,
+				name, ret);
+			ret = -EINVAL;
+			goto free_microwatt;
+		}
+	}
+
 	for (i = 0, j = 0; i < supplies; i++) {
 		opp->supplies[i].u_volt = microvolt[j++];
 
@@ -701,8 +739,13 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 
 		if (microamp)
 			opp->supplies[i].u_amp = microamp[i];
+
+		if (microwatt)
+			opp->supplies[i].u_watt = microwatt[i];
 	}
 
+free_microwatt:
+	kfree(microwatt);
 free_microamp:
 	kfree(microamp);
 free_microvolt:
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 879c138c7b8e..0d85a63a1f78 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -32,14 +32,17 @@ enum dev_pm_opp_event {
  * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
  * @u_volt_max:	Maximum voltage in microvolts corresponding to this OPP
  * @u_amp:	Maximum current drawn by the device in microamperes
+ * @u_watt:	Power used by the device in microwatts
  *
- * This structure stores the voltage/current values for a single power supply.
+ * This structure stores the voltage/current/power values for a single power
+ * supply.
  */
 struct dev_pm_opp_supply {
 	unsigned long u_volt;
 	unsigned long u_volt_min;
 	unsigned long u_volt_max;
 	unsigned long u_amp;
+	unsigned long u_watt;
 };
 
 /**
@@ -94,6 +97,8 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
+
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
@@ -186,6 +191,11 @@ static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.17.1

