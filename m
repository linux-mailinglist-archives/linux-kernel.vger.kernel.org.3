Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2868C565377
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiGDL2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiGDL2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:28:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A2BD11142;
        Mon,  4 Jul 2022 04:28:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 459D223A;
        Mon,  4 Jul 2022 04:28:39 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.41.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FDD33F66F;
        Mon,  4 Jul 2022 04:28:36 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Dietmar.Eggemann@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 4/4] cpufreq: Change order of online() CB and policy->cpus modification
Date:   Mon,  4 Jul 2022 13:27:39 +0200
Message-Id: <20220704112739.3020516-5-pierre.gondois@arm.com>
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

From a state where all policy->related_cpus are offline, putting one
of the policy's CPU back online re-activates the policy by:
 1. Calling cpufreq_driver->online()
 2. Setting the CPU in policy->cpus

qcom_cpufreq_hw_cpu_online() makes use of policy->cpus. Thus 1. and 2.
should be inverted to avoid having a policy->cpus empty. The
qcom-cpufreq-hw is the only driver affected by this.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2cad42774164..36043be16d8e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1350,15 +1350,15 @@ static int cpufreq_online(unsigned int cpu)
 	}
 
 	if (!new_policy && cpufreq_driver->online) {
+		/* Recover policy->cpus using related_cpus */
+		cpumask_copy(policy->cpus, policy->related_cpus);
+
 		ret = cpufreq_driver->online(policy);
 		if (ret) {
 			pr_debug("%s: %d: initialization failed\n", __func__,
 				 __LINE__);
 			goto out_exit_policy;
 		}
-
-		/* Recover policy->cpus using related_cpus */
-		cpumask_copy(policy->cpus, policy->related_cpus);
 	} else {
 		cpumask_copy(policy->cpus, cpumask_of(cpu));
 
-- 
2.25.1

