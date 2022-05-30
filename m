Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A845378D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiE3KEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiE3KEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:04:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D4DECE18;
        Mon, 30 May 2022 03:04:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE71153B;
        Mon, 30 May 2022 03:04:40 -0700 (PDT)
Received: from pierre123.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D252D3F73D;
        Mon, 30 May 2022 03:04:38 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     zhangshaokun@hisilicon.com, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH -next v2 1/1] cpufreq: CPPC: Fix unused-function warning
Date:   Mon, 30 May 2022 12:04:24 +0200
Message-Id: <20220530100424.103301-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530100424.103301-1-pierre.gondois@arm.com>
References: <20220530100424.103301-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the cppc_cpufreq driver with for arm64 with
CONFIG_ENERGY_MODEL=n triggers the following warnings:
 drivers/cpufreq/cppc_cpufreq.c:550:12: error: ‘cppc_get_cpu_cost’ defined but not used
[-Werror=unused-function]
   550 | static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
       |            ^~~~~~~~~~~~~~~~~
 drivers/cpufreq/cppc_cpufreq.c:481:12: error: ‘cppc_get_cpu_power’ defined but not used
[-Werror=unused-function]
   481 | static int cppc_get_cpu_power(struct device *cpu_dev,
       |            ^~~~~~~~~~~~~~~~~~

Move the Energy Model related functions into specific guards.
This allows to fix the warning and prevent doing extra work
when the Energy Model is not present.

Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f0a8bb2c59e5..24eaf0ec344d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -441,6 +441,14 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 	}
 	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
 }
+#else
+static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
+{
+	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+}
+#endif
+
+#if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
 
 static DEFINE_PER_CPU(unsigned int, efficiency_class);
 static void cppc_cpufreq_register_em(struct cpufreq_policy *policy);
@@ -621,21 +629,12 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
 }
 
 #else
-
-static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
-{
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
-}
 static int populate_efficiency_class(void)
 {
 	return 0;
 }
-static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
-{
-}
 #endif
 
-
 static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 {
 	struct cppc_cpudata *cpu_data;
-- 
2.25.1

