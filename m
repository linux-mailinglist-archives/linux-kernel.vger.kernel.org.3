Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B054CBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353810AbiFOOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353179AbiFOOow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:44:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE6F03632C;
        Wed, 15 Jun 2022 07:44:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B77CC153B;
        Wed, 15 Jun 2022 07:44:50 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.5.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A244C3F73B;
        Wed, 15 Jun 2022 07:44:47 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Dietmar.Eggemann@arm.com, Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/4] cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
Date:   Wed, 15 Jun 2022 16:43:18 +0200
Message-Id: <20220615144321.262773-2-pierre.gondois@arm.com>
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
disabled by unplugging the last online CPU of policy->cpus,
qcom_cpufreq_hw_cpu_offline() sets cancel_throttle=true.
cancel_throttle is not reset when the policy is re-enabled with any
of the CPU in policy->cpus being plugged in. So reset it.

This patch also adds an early exit check.

Fixes: a1eb080a0447 ("cpufreq: qcom-hw: provide online/offline operations")
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 0253731d6d25..8aba73698eda 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -442,6 +442,13 @@ static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
 	struct platform_device *pdev = cpufreq_get_driver_data();
 	int ret;
 
+	if (data->throttle_irq < 0)
+		return 0;
+
+	mutex_lock(&data->throttle_lock);
+	data->cancel_throttle = false;
+	mutex_unlock(&data->throttle_lock);
+
 	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
-- 
2.25.1

