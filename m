Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96213573776
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiGMNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiGMNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:33:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75BB21153
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:33:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 737341424;
        Wed, 13 Jul 2022 06:33:52 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF71B3F73D;
        Wed, 13 Jul 2022 06:33:50 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, conor.dooley@microchip.com
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH -next] arch_topology: Fix cache attributes detection in the CPU hotplug path
Date:   Wed, 13 Jul 2022 14:33:44 +0100
Message-Id: <20220713133344.1201247-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.1
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

init_cpu_topology() is called only once at the boot and all the cache
attributes are detected early for all the possible CPUs. However when
the CPUs are hotplugged out, the cacheinfo gets removed. While the
attributes are added back when the CPUs are hotplugged back in as part
of CPU hotplug state machine, it ends up called quite late after the
update_siblings_masks() are called in the secondary_start_kernel()
resulting in wrong llc_sibling_masks.

Move the call to detect_cache_attributes() inside update_siblings_masks()
to ensure the cacheinfo is updated before the LLC sibling masks are
updated. This will fix the incorrect LLC sibling masks generated when
the CPUs are hotplugged out and hotplugged back in again.

Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

Hi Conor,

Ionela reported an issue with the CPU hotplug and as a fix I need to
move the call to detect_cache_attributes() which I had thought to keep
it there from first but for no reason had moved it to init_cpu_topology().

Wonder if this fixes the -ENOMEM on RISC-V as this one is called on the
cpu in the secondary CPUs init path while init_cpu_topology executed
detect_cache_attributes() for all possible CPUs much earlier. I think
this might help as the percpu memory might be initialised in this case.

Anyways give this a try, also test the CPU hotplug and check if nothing
is broken on RISC-V. We noticed this bug only on one platform while

Regards,
Sudeep

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 441e14ac33a4..0424b59b695e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -732,7 +732,11 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
 void update_siblings_masks(unsigned int cpuid)
 {
 	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
-	int cpu;
+	int cpu, ret;
+
+	ret = detect_cache_attributes(cpuid);
+	if (ret)
+		pr_info("Early cacheinfo failed, ret = %d\n", ret);
 	/* update core and thread sibling masks */
 	for_each_online_cpu(cpu) {
@@ -821,7 +825,7 @@ __weak int __init parse_acpi_topology(void)
 #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void __init init_cpu_topology(void)
 {
-	int ret, cpu;
+	int ret;
 	reset_cpu_topology();
 	ret = parse_acpi_topology();
@@ -836,13 +840,5 @@ void __init init_cpu_topology(void)
 		reset_cpu_topology();
 		return;
 	}
-
-	for_each_possible_cpu(cpu) {
-		ret = detect_cache_attributes(cpu);
-		if (ret) {
-			pr_info("Early cacheinfo failed, ret = %d\n", ret);
-			break;
-		}
-	}
 }
 #endif
--2.37.1

