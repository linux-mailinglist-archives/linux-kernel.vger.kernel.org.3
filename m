Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D11553F94C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbiFGJQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiFGJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:16:35 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C8168215D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:16:33 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 9B31C1E80D55;
        Tue,  7 Jun 2022 17:16:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OCc8k__xCFKU; Tue,  7 Jun 2022 17:16:11 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id AA1791E80CB8;
        Tue,  7 Jun 2022 17:16:11 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     ionela.voinescu@arm.com, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] x86: topology_update_die_map function removes unused return values
Date:   Tue,  7 Jun 2022 17:16:10 +0800
Message-Id: <20220607091610.495912-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return value of the topology_update_die_map function to
void to remove the BUG_ON check and reduce eAX register calls.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/x86/include/asm/topology.h | 6 +++---
 arch/x86/kernel/cpu/common.c    | 2 +-
 arch/x86/kernel/smpboot.c       | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index eabfb44b63ed..b641f81cb61f 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -137,7 +137,7 @@ static inline int topology_max_smt_threads(void)
 }
 
 void topology_update_package_map(unsigned int apicid, unsigned int cpu);
-int topology_update_die_map(unsigned int dieid, unsigned int cpu);
+void topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
 bool topology_is_primary_thread(unsigned int cpu);
@@ -146,8 +146,8 @@ bool topology_smt_supported(void);
 #define topology_max_packages()			(1)
 static inline void
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { }
-static inline int
-topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
+static inline void
+topology_update_die_map(unsigned int dieid, unsigned int cpu) { }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_phys_to_logical_die(unsigned int die,
 		unsigned int cpu) { return 0; }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 22d19a1feafd..6850df297dfd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1674,7 +1674,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 		       cpu, apicid, c->initial_apicid);
 	}
 	topology_update_package_map(c->phys_proc_id, cpu);
-	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
+	topology_update_die_map(c->cpu_die_id, cpu);
 #else
 	c->logical_proc_id = 0;
 #endif
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 20c67cca245b..febec77252e8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -349,7 +349,7 @@ void topology_update_package_map(unsigned int pkg, unsigned int cpu)
  * @die:	The die id as retrieved via CPUID
  * @cpu:	The cpu for which this is updated
  */
-int topology_update_die_map(unsigned int die, unsigned int cpu)
+void topology_update_die_map(unsigned int die, unsigned int cpu)
 {
 	int new;
 
@@ -365,7 +365,6 @@ int topology_update_die_map(unsigned int die, unsigned int cpu)
 	}
 found:
 	cpu_data(cpu).logical_die_id = new;
-	return 0;
 }
 
 void __init smp_store_boot_cpu_info(void)
-- 
2.18.2

