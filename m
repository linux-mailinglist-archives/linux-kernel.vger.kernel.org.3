Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1185499FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbiFMR20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiFMR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:27:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C4C9113FB3;
        Mon, 13 Jun 2022 05:43:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4BE41480;
        Mon, 13 Jun 2022 05:43:45 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.35.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9F333F73B;
        Mon, 13 Jun 2022 05:43:43 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH v2 3/4] thermal: cpufreq_cooling: Update outdated comments
Date:   Mon, 13 Jun 2022 13:43:26 +0100
Message-Id: <20220613124327.30766-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613124327.30766-1-lukasz.luba@arm.com>
References: <20220613124327.30766-1-lukasz.luba@arm.com>
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 44 +++++++++++++------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 492a67e267e8..50f8b90abba6 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -206,7 +206,7 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
  * complex code may be needed if experiments show that it's not
  * accurate enough.
  *
- * Return: 0 on success, -E* if getting the static power failed.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 				       u32 *power)
@@ -249,9 +249,8 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
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
@@ -281,15 +280,11 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
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
@@ -401,7 +396,7 @@ static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
  * Callback for the thermal cooling device to return the cpufreq
  * max cooling state.
  *
- * Return: 0 on success, an error code otherwise.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
@@ -420,7 +415,7 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
  * Callback for the thermal cooling device to return the cpufreq
  * current cooling state.
  *
- * Return: 0 on success, an error code otherwise.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
@@ -479,7 +474,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
  * @em: Energy Model of the cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
- * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
+ * "cpufreq-%s". This API can support multiple instances of cpufreq
  * cooling devices. It also gives the opportunity to link the cooling device
  * with a device tree node, in order to bind it via the thermal DT code.
  *
@@ -590,8 +585,8 @@ __cpufreq_cooling_register(struct device_node *np,
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
@@ -608,17 +603,14 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
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
@@ -654,7 +646,7 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
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

