Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C1546315
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbiFJKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348445AbiFJKED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:04:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B50063B566;
        Fri, 10 Jun 2022 03:04:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C81912FC;
        Fri, 10 Jun 2022 03:04:01 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.39.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 728343F766;
        Fri, 10 Jun 2022 03:03:59 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com
Subject: [PATCH 3/3] thermal: cpufreq_cooling: Update outdated comments
Date:   Fri, 10 Jun 2022 11:03:43 +0100
Message-Id: <20220610100343.32378-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610100343.32378-1-lukasz.luba@arm.com>
References: <20220610100343.32378-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code has moved and left some comments stale. Update them where
there is a need.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 44 +++++++++++++------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 2ef1dc2b96a3..e72ff85b9d7e 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -204,7 +204,7 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
  * complex code may be needed if experiments show that it's not
  * accurate enough.
  *
- * Return: 0 on success, -E* if getting the static power failed.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 				       u32 *power)
@@ -247,9 +247,8 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
  * milliwatts assuming 100% load.  Store the calculated power in
  * @power.
  *
- * Return: 0 on success, -EINVAL if the cooling device state could not
- * be converted into a frequency or other -E* if there was an error
- * when calculating the static power.
+ * Return: 0 on success, -EINVAL if the cooling device state is bigger
+ * than maximum allowed.
  */
 static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       unsigned long state, u32 *power)
@@ -279,15 +278,11 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
  * Calculate a cooling device state for the cpus described by @cdev
  * that would allow them to consume at most @power mW and store it in
  * @state.  Note that this calculation depends on external factors
- * such as the cpu load or the current static power.  Calling this
- * function with the same power as input can yield different cooling
- * device states depending on those external factors.
- *
- * Return: 0 on success, -ENODEV if no cpus are online or -EINVAL if
- * the calculated frequency could not be converted to a valid state.
- * The latter should not happen unless the frequencies available to
- * cpufreq have changed since the initialization of the cpu cooling
- * device.
+ * such as the CPUs load.  Calling this function with the same power
+ * as input can yield different cooling device states depending on those
+ * external factors.
+ *
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 			       u32 power, unsigned long *state)
@@ -399,7 +394,7 @@ static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
  * Callback for the thermal cooling device to return the cpufreq
  * max cooling state.
  *
- * Return: 0 on success, an error code otherwise.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
@@ -418,7 +413,7 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
  * Callback for the thermal cooling device to return the cpufreq
  * current cooling state.
  *
- * Return: 0 on success, an error code otherwise.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
@@ -485,7 +480,7 @@ static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
  * @em: Energy Model of the cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
- * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
+ * "cpufreq-%s". This API can support multiple instances of cpufreq
  * cooling devices. It also gives the opportunity to link the cooling device
  * with a device tree node, in order to bind it via the thermal DT code.
  *
@@ -600,8 +595,8 @@ __cpufreq_cooling_register(struct device_node *np,
  * @policy: cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
- * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
- * cooling devices.
+ * "cpufreq-%s". This API can support multiple instances of cpufreq cooling
+ * devices.
  *
  * Return: a valid struct thermal_cooling_device pointer on success,
  * on failure, it returns a corresponding ERR_PTR().
@@ -618,17 +613,14 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
  * @policy: cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
- * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
- * cooling devices. Using this API, the cpufreq cooling device will be
- * linked to the device tree node provided.
+ * "cpufreq-%s". This API can support multiple instances of cpufreq cooling
+ * devices. Using this API, the cpufreq cooling device will be linked to the
+ * device tree node provided.
  *
  * Using this function, the cooling device will implement the power
- * extensions by using a simple cpu power model.  The cpus must have
+ * extensions by using the Energy Model (if present).  The cpus must have
  * registered their OPPs using the OPP library.
  *
- * It also takes into account, if property present in policy CPU node, the
- * static power consumed by the cpu.
- *
  * Return: a valid struct thermal_cooling_device pointer on success,
  * and NULL on failure.
  */
@@ -664,7 +656,7 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
  *
- * This interface function unregisters the "thermal-cpufreq-%x" cooling device.
+ * This interface function unregisters the "cpufreq-%x" cooling device.
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-- 
2.17.1

