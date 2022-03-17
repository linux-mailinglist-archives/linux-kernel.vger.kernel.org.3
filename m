Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7F4DC7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiCQNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiCQNhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:37:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14B671DA8EF;
        Thu, 17 Mar 2022 06:35:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C11F61570;
        Thu, 17 Mar 2022 06:35:44 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E0083F766;
        Thu, 17 Mar 2022 06:35:40 -0700 (PDT)
From:   Pierre Gondois <Pierre.Gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        mka@chromium.org, daniel.lezcano@linaro.org,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 1/3] cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data
Date:   Thu, 17 Mar 2022 14:34:15 +0100
Message-Id: <20220317133419.3901736-2-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
References: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppc_cpufreq_get_cpu_data() allocates a new struct cppc_cpudata
for the input CPU at each call.

To search the struct associated with a cpu without allocating
a new one, add cppc_cpufreq_search_cpu_data().
Also add an early prototype.

This will be used in a later patch, when generating artificial
performance states to register an artificial Energy Model in the
cppc_cpufreq driver and enable the Energy Aware Scheduler for ACPI
based systems.

Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 82d370ae6a4a..8f950fe72765 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -41,6 +41,8 @@
  */
 static LIST_HEAD(cpu_data_list);
 
+static struct cppc_cpudata *cppc_cpufreq_search_cpu_data(unsigned int cpu);
+
 static bool boost_supported;
 
 struct cppc_workaround_oem_info {
@@ -479,6 +481,19 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 }
 
+static inline struct cppc_cpudata *
+cppc_cpufreq_search_cpu_data(unsigned int cpu)
+{
+	struct cppc_cpudata *iter, *tmp;
+
+	list_for_each_entry_safe(iter, tmp, &cpu_data_list, node) {
+		if (cpumask_test_cpu(cpu, iter->shared_cpu_map))
+			return iter;
+	}
+
+	return NULL;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
-- 
2.25.1

