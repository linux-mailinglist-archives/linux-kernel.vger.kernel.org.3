Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B782754631E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348326AbiFJKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347521AbiFJKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:03:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EC20B0A6E;
        Fri, 10 Jun 2022 03:03:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8EE512FC;
        Fri, 10 Jun 2022 03:03:56 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.39.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 865873F766;
        Fri, 10 Jun 2022 03:03:54 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com
Subject: [PATCH 1/3] thermal: cpufreq_cooling: Use a copy of local ops for each cooling device
Date:   Fri, 10 Jun 2022 11:03:41 +0100
Message-Id: <20220610100343.32378-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is very unlikely that one CPU cluster would have the EM and some other
won't have it (because EM registration failed or DT lacks needed entry).
Although, we should avoid modifying global variable with callbacks anyway.
Redesign this and add safety for such situation.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index b8151d95a806..e33183785fac 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -554,7 +554,12 @@ __cpufreq_cooling_register(struct device_node *np,
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
 
-	cooling_ops = &cpufreq_cooling_ops;
+	cooling_ops = kmemdup(&cpufreq_cooling_ops, sizeof(*cooling_ops),
+			      GFP_KERNEL);
+	if (!cooling_ops) {
+		cdev = ERR_PTR(-ENOMEM);
+		goto free_idle_time;
+	}
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	if (em_is_sane(cpufreq_cdev, em)) {
@@ -568,7 +573,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: unsorted frequency tables are not supported\n",
 		       __func__);
 		cdev = ERR_PTR(-EINVAL);
-		goto free_idle_time;
+		goto free_cooling_ops;
 	}
 
 	ret = freq_qos_add_request(&policy->constraints,
@@ -578,7 +583,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
 		       ret);
 		cdev = ERR_PTR(ret);
-		goto free_idle_time;
+		goto free_cooling_ops;
 	}
 
 	cdev = ERR_PTR(-ENOMEM);
@@ -597,6 +602,8 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_qos_req:
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
+free_cooling_ops:
+	kfree(cooling_ops);
 free_idle_time:
 	free_idle_time(cpufreq_cdev);
 free_cdev:
@@ -677,16 +684,19 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
+	const struct thermal_cooling_device_ops *ops;
 	struct cpufreq_cooling_device *cpufreq_cdev;
 
 	if (!cdev)
 		return;
 
 	cpufreq_cdev = cdev->devdata;
+	ops = cdev->ops;
 
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	free_idle_time(cpufreq_cdev);
 	kfree(cpufreq_cdev);
+	kfree(ops);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
-- 
2.17.1

