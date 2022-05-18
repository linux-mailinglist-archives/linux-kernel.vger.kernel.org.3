Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2152B764
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiERJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiERJeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:34:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D793AFB32
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:34:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F6731042;
        Wed, 18 May 2022 02:34:08 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C4DC83F66F;
        Wed, 18 May 2022 02:34:06 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 8/8] arch_topology: Add support to build llc_sibling on DT platforms
Date:   Wed, 18 May 2022 10:33:25 +0100
Message-Id: <20220518093325.2070336-9-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518093325.2070336-1-sudeep.holla@arm.com>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
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

ACPI PPTT provides cache identifiers and especially the last level cache
identifier is used in obtaining last level cache siblings amongst CPUs.

While we have the cpu map representing all the CPUs sharing last level
cache in the cacheinfo driver, it is populated quite late in the boot
while the information is needed to build scheduler domains quite early.

On DT platforms we can use the pointer to the last level cache as the
firmware identifier for the last level cache and build the cpumap sharing
the last level cache based on the same.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c  | 18 ++++++++++++++----
 include/linux/arch_topology.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 6d3346efe74b..bc57f0f1862e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -661,11 +661,14 @@ static int __init parse_dt_topology(void)
 	 * Check that all cores are in the topology; the SMP code will
 	 * only mark cores described in the DT as possible.
 	 */
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		if (cpu_topology[cpu].package_id < 0) {
 			ret = -EINVAL;
 			break;
 		}
+		cpu_topology[cpu].llc_fw_node =
+					of_find_last_level_cache_node(cpu);
+	}
 
 out_map:
 	of_node_put(map);
@@ -681,6 +684,12 @@ static int __init parse_dt_topology(void)
 struct cpu_topology cpu_topology[NR_CPUS];
 EXPORT_SYMBOL_GPL(cpu_topology);
 
+#define IS_VALID_LLC_ID(x)	\
+	((x)->llc_id >= 0 || (x)->llc_fw_node)
+#define IS_MATCH_LLC_ID(x, y)	\
+	(((x)->llc_id >= 0 && (x)->llc_id == (y)->llc_id) || \
+	 ((x)->llc_fw_node && (x)->llc_fw_node == (y)->llc_fw_node))
+
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
 	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
@@ -690,7 +699,8 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 		/* not numa in package, lets use the package siblings */
 		core_mask = &cpu_topology[cpu].core_sibling;
 	}
-	if (cpu_topology[cpu].llc_id >= 0) {
+
+	if (IS_VALID_LLC_ID(&cpu_topology[cpu])) {
 		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
 			core_mask = &cpu_topology[cpu].llc_sibling;
 	}
@@ -721,8 +731,7 @@ void update_siblings_masks(unsigned int cpuid)
 	for_each_online_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpu_topo->llc_id >= 0 &&
-		    cpuid_topo->llc_id == cpu_topo->llc_id) {
+		if (IS_MATCH_LLC_ID(cpu_topo, cpuid_topo)) {
 			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
 		}
@@ -777,6 +786,7 @@ void __init reset_cpu_topology(void)
 		cpu_topo->cluster_id = -1;
 		cpu_topo->package_id = -1;
 		cpu_topo->llc_id = -1;
+		cpu_topo->llc_fw_node = NULL;
 
 		clear_cpu_topology(cpu);
 	}
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 58cbe18d825c..d8a36b0e27c9 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -69,6 +69,7 @@ struct cpu_topology {
 	int cluster_id;
 	int package_id;
 	int llc_id;
+	void *llc_fw_node;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
 	cpumask_t cluster_sibling;
-- 
2.36.1

