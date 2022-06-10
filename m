Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38128546413
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348300AbiFJKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbiFJKmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:42:18 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD47F4B1DE;
        Fri, 10 Jun 2022 03:37:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C031A1E80D6E;
        Fri, 10 Jun 2022 18:36:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q_szG_0-xxXj; Fri, 10 Jun 2022 18:36:44 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id DD7271E80D24;
        Fri, 10 Jun 2022 18:36:43 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name, rafael@kernel.org,
        len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] x86: Change the return type of acpi_map_cpu2node to void
Date:   Fri, 10 Jun 2022 18:36:44 +0800
Message-Id: <20220610103644.201245-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce eax register calls by removing unused return values.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/ia64/kernel/acpi.c      | 3 +--
 arch/loongarch/kernel/acpi.c | 3 +--
 arch/x86/kernel/acpi/boot.c  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 96d13cb7c19f..2665cc873f0a 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -712,7 +712,7 @@ int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
  *  ACPI based hotplug CPU support
  */
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
+void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
 	/*
@@ -725,7 +725,6 @@ int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 	node_cpuid[cpu].phys_id = physid;
 	node_cpuid[cpu].nid = acpi_get_node(handle);
 #endif
-	return 0;
 }
 
 int additional_cpus __initdata = -1;
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index b16c3dea5eeb..369b49343563 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -282,7 +282,7 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 
 #include <acpi/processor.h>
 
-static int __ref acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
+static void __ref acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
 	int nid;
@@ -295,7 +295,6 @@ static int __ref acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 		cpumask_set_cpu(cpu, cpumask_of_node(nid));
 	}
 #endif
-	return 0;
 }
 
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu)
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..d63ec3ea3be3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -799,7 +799,7 @@ static void __init acpi_set_irq_model_ioapic(void)
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 #include <acpi/processor.h>
 
-static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
+static void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
 	int nid;
@@ -810,7 +810,6 @@ static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 		numa_set_node(cpu, nid);
 	}
 #endif
-	return 0;
 }
 
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
-- 
2.18.2

