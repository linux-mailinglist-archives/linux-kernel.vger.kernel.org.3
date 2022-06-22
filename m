Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1E554E19
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358871AbiFVO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358802AbiFVO6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:58:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF51D167EC;
        Wed, 22 Jun 2022 07:58:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE974150C;
        Wed, 22 Jun 2022 07:58:17 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.38.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCFD23F792;
        Wed, 22 Jun 2022 07:58:14 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] Documentation: EM: Switch to micro-Watts scale
Date:   Wed, 22 Jun 2022 15:58:00 +0100
Message-Id: <20220622145802.13032-3-lukasz.luba@arm.com>
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

The EM now uses the micro-Watts scale for the power values. Update
related documentation to reflect that fact.

Fix also a problematic sentence in the doc "to:" which triggers test
scripts complaining about wrong email address.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index feb257b7f350..ef341be2882b 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -20,20 +20,20 @@ possible source of information on its own, the EM framework intervenes as an
 abstraction layer which standardizes the format of power cost tables in the
 kernel, hence enabling to avoid redundant work.
 
-The power values might be expressed in milli-Watts or in an 'abstract scale'.
+The power values might be expressed in micro-Watts or in an 'abstract scale'.
 Multiple subsystems might use the EM and it is up to the system integrator to
 check that the requirements for the power value scale types are met. An example
 can be found in the Energy-Aware Scheduler documentation
 Documentation/scheduler/sched-energy.rst. For some subsystems like thermal or
 powercap power values expressed in an 'abstract scale' might cause issues.
 These subsystems are more interested in estimation of power used in the past,
-thus the real milli-Watts might be needed. An example of these requirements can
+thus the real micro-Watts might be needed. An example of these requirements can
 be found in the Intelligent Power Allocation in
 Documentation/driver-api/thermal/power_allocator.rst.
 Kernel subsystems might implement automatic detection to check whether EM
 registered devices have inconsistent scale (based on EM internal flag).
 Important thing to keep in mind is that when the power values are expressed in
-an 'abstract scale' deriving real energy in milli-Joules would not be possible.
+an 'abstract scale' deriving real energy in micro-Joules would not be possible.
 
 The figure below depicts an example of drivers (Arm-specific here, but the
 approach is applicable to any architecture) providing power costs to the EM
@@ -98,7 +98,7 @@ Drivers are expected to register performance domains into the EM framework by
 calling the following API::
 
   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
-		struct em_data_callback *cb, cpumask_t *cpus, bool milliwatts);
+		struct em_data_callback *cb, cpumask_t *cpus, bool microwatts);
 
 Drivers must provide a callback function returning <frequency, power> tuples
 for each performance state. The callback function provided by the driver is free
@@ -106,10 +106,10 @@ to fetch data from any relevant location (DT, firmware, ...), and by any mean
 deemed necessary. Only for CPU devices, drivers must specify the CPUs of the
 performance domains using cpumask. For other devices than CPUs the last
 argument must be set to NULL.
-The last argument 'milliwatts' is important to set with correct value. Kernel
+The last argument 'microwatts' is important to set with correct value. Kernel
 subsystems which use EM might rely on this flag to check if all EM devices use
 the same scale. If there are different scales, these subsystems might decide
-to: return warning/error, stop working or panic.
+to return warning/error, stop working or panic.
 See Section 3. for an example of driver implementing this
 callback, or Section 2.4 for further documentation on this API
 
@@ -137,7 +137,7 @@ The .get_cost() allows to provide the 'cost' values which reflect the
 efficiency of the CPUs. This would allow to provide EAS information which
 has different relation than what would be forced by the EM internal
 formulas calculating 'cost' values. To register an EM for such platform, the
-driver must set the flag 'milliwatts' to 0, provide .get_power() callback
+driver must set the flag 'microwatts' to 0, provide .get_power() callback
 and provide .get_cost() callback. The EM framework would handle such platform
 properly during registration. A flag EM_PERF_DOMAIN_ARTIFICIAL is set for such
 platform. Special care should be taken by other frameworks which are using EM
-- 
2.17.1

