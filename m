Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8A556536B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiGDL2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiGDL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:28:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9C8E10FD3;
        Mon,  4 Jul 2022 04:28:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 002E723A;
        Mon,  4 Jul 2022 04:28:36 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.41.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8100F3F66F;
        Mon,  4 Jul 2022 04:28:33 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Dietmar.Eggemann@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 3/4] cpufreq: qcom-hw: Remove deprecated irq_set_affinity_hint() call
Date:   Mon,  4 Jul 2022 13:27:38 +0200
Message-Id: <20220704112739.3020516-4-pierre.gondois@arm.com>
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

commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity hints")
deprecates irq_set_affinity_hint(). Use the new
irq_set_affinity_and_hint() instead.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 729346a62a17..2a21f1a2a2bd 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -428,7 +428,7 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 		return 0;
 	}
 
-	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
+	ret = irq_set_affinity_and_hint(data->throttle_irq, policy->cpus);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
 			data->irq_name, data->throttle_irq);
@@ -449,7 +449,7 @@ static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
 	data->cancel_throttle = false;
 	mutex_unlock(&data->throttle_lock);
 
-	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
+	ret = irq_set_affinity_and_hint(data->throttle_irq, policy->cpus);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
 			data->irq_name, data->throttle_irq);
@@ -469,7 +469,7 @@ static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
 	mutex_unlock(&data->throttle_lock);
 
 	cancel_delayed_work_sync(&data->throttle_work);
-	irq_set_affinity_hint(data->throttle_irq, NULL);
+	irq_set_affinity_and_hint(data->throttle_irq, NULL);
 	disable_irq_nosync(data->throttle_irq);
 
 	return 0;
-- 
2.25.1

