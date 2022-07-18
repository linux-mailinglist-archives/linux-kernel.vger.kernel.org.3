Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95E3578248
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiGRM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiGRM0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:26:25 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FEF222
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:26:23 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 26ICORKL076857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 18 Jul 2022 20:24:27 +0800 (CST)
        (envelope-from Di.Shen@unisoc.com)
Received: from bj10906pcu1.spreadtrum.com (10.0.74.51) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 18 Jul 2022 20:24:28 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <lukasz.luba@arm.com>, <amitk@kernel.org>, <rui.zhang@intel.com>
CC:     <amit.kachhap@gmail.com>, <daniel.lezcano@linaro.org>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [PATCH] thermal: cpufreq_cooling: Avoid all cluster using global cooling_ops
Date:   Mon, 18 Jul 2022 20:24:19 +0800
Message-ID: <20220718122419.9409-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.51]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 26ICORKL076857
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, all the cooling device use the globle cpufreq_cooling_ops. When the
CONFIG_THERMAL_GOV_POWER_ALLOCATOR is enabled, once one cluster init the
cpufreq_cooling_ops, it would make all cooling device use the power allocator's
ops. If one's em is error because of the "em_is_sane", it would cause the
em NULL, but the cooling device's ops is exist, as a result, it would cause
panic because of the em.

Add cpufreq_power_cooling_ops to avoid this case.

Signed-off-by: Di Shen <di.shen@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/thermal/cpufreq_cooling.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index b8151d95a806..af5cfb458370 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -493,6 +493,17 @@ static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
 	.set_cur_state		= cpufreq_set_cur_state,
 };
 
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
+static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
+	.get_max_state		= cpufreq_get_max_state,
+	.get_cur_state		= cpufreq_get_cur_state,
+	.set_cur_state		= cpufreq_set_cur_state,
+	.get_requested_power	= cpufreq_get_requested_power,
+	.state2power		= cpufreq_state2power,
+	.power2state		= cpufreq_power2state,
+};
+#endif
+
 /**
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
  * @np: a valid struct device_node to the cooling device device tree node
@@ -559,9 +570,7 @@ __cpufreq_cooling_register(struct device_node *np,
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	if (em_is_sane(cpufreq_cdev, em)) {
 		cpufreq_cdev->em = em;
-		cooling_ops->get_requested_power = cpufreq_get_requested_power;
-		cooling_ops->state2power = cpufreq_state2power;
-		cooling_ops->power2state = cpufreq_power2state;
+		cooling_ops = &cpufreq_power_cooling_ops;
 	} else
 #endif
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED) {
-- 
2.17.1

