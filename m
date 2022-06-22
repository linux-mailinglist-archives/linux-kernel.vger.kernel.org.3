Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9421A554E10
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbiFVO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358859AbiFVO60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:58:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA3F635263;
        Wed, 22 Jun 2022 07:58:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D25EC1477;
        Wed, 22 Jun 2022 07:58:23 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.38.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E21DD3F792;
        Wed, 22 Jun 2022 07:58:20 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] cpufreq: scmi: Support the power scale in micro-Watts in SCMI v3.1
Date:   Wed, 22 Jun 2022 15:58:02 +0100
Message-Id: <20220622145802.13032-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622145802.13032-1-lukasz.luba@arm.com>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCMI v3.1 adds support for power values in micro-Watts. They are not
always in milli-Watts anymore (ignoring the bogo-Watts). Thus, the power
must be converted conditionally before sending to Energy Model. Add the
logic which handles the needed checks and conversions.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index bfd35583d653..513a071845c2 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -100,7 +100,7 @@ static int __maybe_unused
 scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 		   unsigned long *KHz)
 {
-	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
+	enum scmi_power_scale power_scale = perf_ops->power_scale_get(ph);
 	unsigned long Hz;
 	int ret, domain;
 
@@ -114,8 +114,8 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	if (ret)
 		return ret;
 
-	/* Provide bigger resolution power to the Energy Model */
-	if (power_scale_mw)
+	/* Convert the power to uW if it is mW (ignore bogoW) */
+	if (power_scale == SCMI_POWER_MILLIWATTS)
 		*power *= MICROWATT_PER_MILLIWATT;
 
 	/* The EM framework specifies the frequency in KHz. */
@@ -255,8 +255,9 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
 {
 	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
-	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
+	enum scmi_power_scale power_scale = perf_ops->power_scale_get(ph);
 	struct scmi_data *priv = policy->driver_data;
+	bool em_power_scale = false;
 
 	/*
 	 * This callback will be called for each policy, but we don't need to
@@ -268,9 +269,13 @@ static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
 	if (!priv->nr_opp)
 		return;
 
+	if (power_scale == SCMI_POWER_MILLIWATTS
+	    || power_scale == SCMI_POWER_MICROWATTS)
+		em_power_scale = true;
+
 	em_dev_register_perf_domain(get_cpu_device(policy->cpu), priv->nr_opp,
 				    &em_cb, priv->opp_shared_cpus,
-				    power_scale_mw);
+				    em_power_scale);
 }
 
 static struct cpufreq_driver scmi_cpufreq_driver = {
-- 
2.17.1

