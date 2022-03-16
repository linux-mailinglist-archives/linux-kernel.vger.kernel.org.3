Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFA04DBB65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbiCPXxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCPXxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:53:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE91B1AD89;
        Wed, 16 Mar 2022 16:52:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E5C01515;
        Wed, 16 Mar 2022 16:52:26 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A4F13F766;
        Wed, 16 Mar 2022 16:52:23 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: [[PATCH 1/8] PM: EM: Add .get_cost() callback
Date:   Wed, 16 Mar 2022 23:52:04 +0000
Message-Id: <20220316235211.29370-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316235211.29370-1-lukasz.luba@arm.com>
References: <20220316235211.29370-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) supports devices which report abstract power scale,
not only real Watts. The primary goal for EM is to enable the Energy Aware
Scheduler (EAS) for a given platform. Some of the platforms might not be
able to deliver proper power values. The only information that they might
have is the relative efficiency between CPU types.

Thus, it makes sense to remove some restrictions in the EM framework and
introduce a mechanism which would support those platforms. What is crucial
for EAS to operate is the 'cost' field in the EM. The 'cost' is calculated
internally in EM framework based on knowledge from 'power' values.
The 'cost' values must be strictly increasing. The existing API with its
'power' value size restrictions cannot guarantee that the 'cost' will meet
this requirement.

Since the platform is missing this detailed information, but has only
efficiency details, introduce a new custom callback in the EM framework.
The new callback would allow to provide the 'cost' values which reflect
efficiency of the CPUs. This would allow to provide EAS information which
has different relation than what would be forced by the EM internal
formulas calculating 'cost' values. Thanks to this new callback it is
possible to create a system view for EAS which has no overlapping
performance states across many Performance Domains.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 9f3c400bc52d..0a3a5663177b 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -114,9 +114,30 @@ struct em_data_callback {
 	 */
 	int (*active_power)(unsigned long *power, unsigned long *freq,
 			    struct device *dev);
+
+	/**
+	 * get_cost() - Provide the cost at the given performance state of
+	 *		a device
+	 * @dev		: Device for which we do this operation (can be a CPU)
+	 * @freq	: Frequency at the performance state in kHz
+	 * @cost	: The cost value for the performance state
+	 *		(modified)
+	 *
+	 * In case of CPUs, the cost is the one of a single CPU in the domain.
+	 * It is expected to fit in the [0, EM_MAX_POWER] range due to internal
+	 * usage in EAS calculation.
+	 *
+	 * Return 0 on success, or appropriate error value in case of failure.
+	 */
+	int (*get_cost)(struct device *dev, unsigned long freq,
+			unsigned long *cost);
 };
-#define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
 #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
+#define EM_ADV_DATA_CB(_active_power_cb, _cost_cb)	\
+	{ .active_power = _active_power_cb,		\
+	  .get_cost = _cost_cb }
+#define EM_DATA_CB(_active_power_cb)			\
+		EM_ADV_DATA_CB(_active_power_cb, NULL)
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
@@ -264,6 +285,7 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 
 #else
 struct em_data_callback {};
+#define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
 #define EM_DATA_CB(_active_power_cb) { }
 #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) do { } while (0)
 
-- 
2.17.1

