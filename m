Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89056537A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiGDL2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiGDL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:28:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA9176458;
        Mon,  4 Jul 2022 04:28:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1044523A;
        Mon,  4 Jul 2022 04:28:30 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.41.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 626FA3F66F;
        Mon,  4 Jul 2022 04:28:27 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Dietmar.Eggemann@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/4] cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
Date:   Mon,  4 Jul 2022 13:27:36 +0200
Message-Id: <20220704112739.3020516-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704112739.3020516-1-pierre.gondois@arm.com>
References: <20220704112739.3020516-1-pierre.gondois@arm.com>
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

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 36c79580fba2..8e5eeb982ebd 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -445,6 +445,10 @@ static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
 	if (data->throttle_irq <= 0)
 		return 0;
 
+	mutex_lock(&data->throttle_lock);
+	data->cancel_throttle = false;
+	mutex_unlock(&data->throttle_lock);
+
 	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
-- 
2.25.1

