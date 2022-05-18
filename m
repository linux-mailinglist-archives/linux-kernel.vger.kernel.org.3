Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7896852B6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiERJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiERJeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:34:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D76F8B0400
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:34:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 990A51063;
        Wed, 18 May 2022 02:34:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59D823F66F;
        Wed, 18 May 2022 02:34:00 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 5/8] arch_topology: Check for non-negative value rather than -1 for IDs validity
Date:   Wed, 18 May 2022 10:33:22 +0100
Message-Id: <20220518093325.2070336-6-sudeep.holla@arm.com>
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

Instead of just comparing the cpu topology IDs with -1 to check their
validity, improve that by checking for a valid non-negative value.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 77aab5fea46b..be99a78f5b31 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -662,7 +662,7 @@ static int __init parse_dt_topology(void)
 	 * only mark cores described in the DT as possible.
 	 */
 	for_each_possible_cpu(cpu)
-		if (cpu_topology[cpu].package_id == -1)
+		if (cpu_topology[cpu].package_id < 0)
 			ret = -EINVAL;
 
 out_map:
@@ -688,7 +688,7 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 		/* not numa in package, lets use the package siblings */
 		core_mask = &cpu_topology[cpu].core_sibling;
 	}
-	if (cpu_topology[cpu].llc_id != -1) {
+	if (cpu_topology[cpu].llc_id >= 0) {
 		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
 			core_mask = &cpu_topology[cpu].llc_sibling;
 	}
@@ -719,7 +719,8 @@ void update_siblings_masks(unsigned int cpuid)
 	for_each_online_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {
+		if (cpu_topo->llc_id >= 0 &&
+		    cpuid_topo->llc_id == cpu_topo->llc_id) {
 			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
 		}
@@ -733,7 +734,7 @@ void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
 			continue;
 
-		if (cpuid_topo->cluster_id != -1) {
+		if (cpuid_topo->cluster_id >= 0) {
 			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
 			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
 		}
-- 
2.36.1

