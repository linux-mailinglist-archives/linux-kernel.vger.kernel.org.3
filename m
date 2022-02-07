Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B784AB5FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiBGHm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbiBGHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:38:34 -0500
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:38:33 PST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EAF3C043181;
        Sun,  6 Feb 2022 23:38:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC46911D4;
        Sun,  6 Feb 2022 23:30:49 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.15.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9BDAA3F73B;
        Sun,  6 Feb 2022 23:30:47 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, dietmar.eggemann@arm.com, lukasz.luba@arm.com,
        Pierre.Gondois@arm.com
Subject: [PATCH 1/2] thermal: cooling: Check Energy Model type in cpufreq_cooling and devfreq_cooling
Date:   Mon,  7 Feb 2022 07:30:35 +0000
Message-Id: <20220207073036.14901-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220207073036.14901-1-lukasz.luba@arm.com>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model supports power values either in Watts or in some abstract
scale. When the 2nd option is in use, the thermal governor IPA should not
be allowed to operate, since the relation between cooling devices is not
properly defined. Thus, it might be possible that big GPU has lower power
values in abstract scale than a Little CPU. To mitigate a misbehaviour
of the thermal control algorithm, simply not register a cooling device
capable of working with IPA.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c |  2 +-
 drivers/thermal/devfreq_cooling.c | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 43b1ae8a7789..f831ed40b333 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -328,7 +328,7 @@ static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
 	struct cpufreq_policy *policy;
 	unsigned int nr_levels;
 
-	if (!em)
+	if (!em || !(em->flags & EM_PERF_DOMAIN_MILLIWATTS))
 		return false;
 
 	policy = cpufreq_cdev->policy;
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 4310cb342a9f..7e8bd1368cab 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -336,6 +336,14 @@ static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc,
 	return 0;
 }
 
+static inline bool em_is_sane(struct em_perf_domain *em)
+{
+	if (!em || !(em->flags & EM_PERF_DOMAIN_MILLIWATTS))
+		return false;
+	else
+		return true;
+}
+
 /**
  * of_devfreq_cooling_register_power() - Register devfreq cooling device,
  *                                      with OF and power information.
@@ -358,6 +366,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	struct thermal_cooling_device *cdev;
 	struct device *dev = df->dev.parent;
 	struct devfreq_cooling_device *dfc;
+	struct em_perf_domain *em;
 	char *name;
 	int err, num_opps;
 
@@ -367,8 +376,9 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 
 	dfc->devfreq = df;
 
-	dfc->em_pd = em_pd_get(dev);
-	if (dfc->em_pd) {
+	em = em_pd_get(dev);
+	if (em_is_sane(em)) {
+		dfc->em_pd = em;
 		devfreq_cooling_ops.get_requested_power =
 			devfreq_cooling_get_requested_power;
 		devfreq_cooling_ops.state2power = devfreq_cooling_state2power;
@@ -379,7 +389,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 		num_opps = em_pd_nr_perf_states(dfc->em_pd);
 	} else {
 		/* Backward compatibility for drivers which do not use IPA */
-		dev_dbg(dev, "missing EM for cooling device\n");
+		dev_dbg(dev, "missing proper EM for cooling device\n");
 
 		num_opps = dev_pm_opp_get_opp_count(dev);
 
-- 
2.17.1

