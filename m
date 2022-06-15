Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4614054CBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354470AbiFOOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353817AbiFOOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:45:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2741C3AA42;
        Wed, 15 Jun 2022 07:44:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ED19153B;
        Wed, 15 Jun 2022 07:44:54 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.5.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 885813F73B;
        Wed, 15 Jun 2022 07:44:51 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Dietmar.Eggemann@arm.com, Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/4] cpufreq: qcom-hw: Disable LMH irq when disabling policy
Date:   Wed, 15 Jun 2022 16:43:19 +0200
Message-Id: <20220615144321.262773-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615144321.262773-1-pierre.gondois@arm.com>
References: <20220615144321.262773-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If LMH (Limits Management Hardware) is available, when a policy is
disabled by unplugging the last online CPU of policy->cpus, the LMH
irq is left enabled.
When the policy is re-enabled with any of the CPU in policy->cpus
being plugged in, qcom_cpufreq_ready() re-enables the irq. This
triggers the following warning:
[  379.160106] Unbalanced enable for IRQ 154
[  379.160120] WARNING: CPU: 7 PID: 48 at kernel/irq/manage.c:774 __enable_irq+0x84/0xc0
Thus disable the irq.

This patch also makes the check against throttle_irq consistent,
0 being theoretically valid.

Fixes: a1eb080a0447 ("cpufreq: qcom-hw: provide online/offline operations")
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 8aba73698eda..8cad3744cff4 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -461,7 +461,7 @@ static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct qcom_cpufreq_data *data = policy->driver_data;
 
-	if (data->throttle_irq <= 0)
+	if (data->throttle_irq < 0)
 		return 0;
 
 	mutex_lock(&data->throttle_lock);
@@ -470,6 +470,7 @@ static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
 
 	cancel_delayed_work_sync(&data->throttle_work);
 	irq_set_affinity_hint(data->throttle_irq, NULL);
+	disable_irq_nosync(data->throttle_irq);
 
 	return 0;
 }
-- 
2.25.1

