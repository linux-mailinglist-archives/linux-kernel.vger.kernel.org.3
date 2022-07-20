Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914A657B6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiGTM4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiGTM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:56:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AD5C3F31A;
        Wed, 20 Jul 2022 05:56:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B593615DB;
        Wed, 20 Jul 2022 05:56:06 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FBD63F70D;
        Wed, 20 Jul 2022 05:56:04 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH v3 3/3] arch_topology: Fix cache attributes detection in the CPU hotplug path
Date:   Wed, 20 Jul 2022 13:55:40 +0100
Message-Id: <20220720-arch_topo_fixes-v3-3-43d696288e84@arm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com>
References: <20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

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

-- 
b4 0.10.0-dev-54fef
