Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5436A525D97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378245AbiEMIed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357776AbiEMIe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:34:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 424A663516
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:34:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B701113E;
        Fri, 13 May 2022 01:34:26 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD0873F73D;
        Fri, 13 May 2022 01:34:24 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, Qing Wang <wangqing@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] arch_topology: Use llc_id instead of package_id
Date:   Fri, 13 May 2022 10:34:00 +0200
Message-Id: <20220513083400.343706-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
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

package_id should represent socket in DT. Free it for possible socket
dts parsing and use the so far unused llc_id / llc_sibling cpumask to
decode 1. level clusters used in pre-DynamIQ big/little systems.

cpu_coregroup_mask() will return llc_sibling isntead of core_mask in
this case.

This will let the cluster_id / cluster_sibling cpumask be available for
2. level clusters (e.g. to map L2 sharing in Armv9 A510 complexes).

The corresponding sched domain CLS is similarly used in ACPI (servers)
to map e.g. Kunpeng920 L3-tags or Ampere Altra's SCU bounderies.

Lighlty tested on qemu-system-aarch64 with 1x8 (cluster-x-core) and
2x4 cpu-map.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

Related to: https://lkml.kernel.org/r/1652361692-13196-1-git-send-email-wangqing@vivo.com

 drivers/base/arch_topology.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index f73b836047cf..ac1488990cc8 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -490,7 +490,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 	return cpu;
 }
 
-static int __init parse_core(struct device_node *core, int package_id,
+static int __init parse_core(struct device_node *core, int llc_id,
 			     int core_id)
 {
 	char name[20];
@@ -506,7 +506,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 			leaf = false;
 			cpu = get_cpu_for_node(t);
 			if (cpu >= 0) {
-				cpu_topology[cpu].package_id = package_id;
+				cpu_topology[cpu].package_id = 0;
+				cpu_topology[cpu].llc_id = llc_id;
 				cpu_topology[cpu].core_id = core_id;
 				cpu_topology[cpu].thread_id = i;
 			} else if (cpu != -ENODEV) {
@@ -527,7 +528,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 			return -EINVAL;
 		}
 
-		cpu_topology[cpu].package_id = package_id;
+		cpu_topology[cpu].package_id = 0;
+		cpu_topology[cpu].llc_id = llc_id;
 		cpu_topology[cpu].core_id = core_id;
 	} else if (leaf && cpu != -ENODEV) {
 		pr_err("%pOF: Can't get CPU for leaf core\n", core);
@@ -543,7 +545,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	bool leaf = true;
 	bool has_cores = false;
 	struct device_node *c;
-	static int package_id __initdata;
+	static int llc_id __initdata;
 	int core_id = 0;
 	int i, ret;
 
@@ -582,7 +584,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 			}
 
 			if (leaf) {
-				ret = parse_core(c, package_id, core_id++);
+				ret = parse_core(c, llc_id, core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -600,7 +602,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 		pr_warn("%pOF: empty cluster\n", cluster);
 
 	if (leaf)
-		package_id++;
+		llc_id++;
 
 	return 0;
 }
@@ -693,14 +695,12 @@ void update_siblings_masks(unsigned int cpuid)
 	for_each_online_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {
-			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
-			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
-		}
-
-		if (cpuid_topo->package_id != cpu_topo->package_id)
+		if (cpuid_topo->llc_id != cpu_topo->llc_id)
 			continue;
 
+		cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
+		cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
+
 		if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
 		    cpuid_topo->cluster_id != -1) {
 			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
-- 
2.25.1

