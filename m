Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47E753E8C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiFFMXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiFFMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:23:34 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC9BE4ECCB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:23:31 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 71D481E80D76;
        Mon,  6 Jun 2022 20:23:19 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oJle7d--Zptp; Mon,  6 Jun 2022 20:23:16 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 735241E80D27;
        Mon,  6 Jun 2022 20:23:16 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        rafael.j.wysocki@intel.com, tony.luck@intel.com,
        tim.c.chen@linux.intel.com, tim.gardner@canonical.com,
        boris.ostrovsky@oracle.com
Cc:     peterz@infradead.org, ray.huang@amd.com, paulmck@kernel.org,
        ionela.voinescu@arm.com, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] x86: topology_update_package_map function doesn't use the return value
Date:   Mon,  6 Jun 2022 20:23:16 +0800
Message-Id: <20220606122316.291022-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

topology_update_package_map function could remove the return value, and
it could remove the BUG_ON check.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/x86/include/asm/topology.h | 6 +++---
 arch/x86/kernel/cpu/common.c    | 2 +-
 arch/x86/kernel/smpboot.c       | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 458c891a8273..eabfb44b63ed 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -136,7 +136,7 @@ static inline int topology_max_smt_threads(void)
 	return __max_smt_threads;
 }
 
-int topology_update_package_map(unsigned int apicid, unsigned int cpu);
+void topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
@@ -144,8 +144,8 @@ bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
 #else
 #define topology_max_packages()			(1)
-static inline int
-topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
+static inline void
+topology_update_package_map(unsigned int apicid, unsigned int cpu) { }
 static inline int
 topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c296cb1c0113..22d19a1feafd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1673,7 +1673,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
 		       cpu, apicid, c->initial_apicid);
 	}
-	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
+	topology_update_package_map(c->phys_proc_id, cpu);
 	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
 #else
 	c->logical_proc_id = 0;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5e7f9532a10d..20c67cca245b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -327,7 +327,7 @@ EXPORT_SYMBOL(topology_phys_to_logical_die);
  * @pkg:	The physical package id as retrieved via CPUID
  * @cpu:	The cpu for which this is updated
  */
-int topology_update_package_map(unsigned int pkg, unsigned int cpu)
+void topology_update_package_map(unsigned int pkg, unsigned int cpu)
 {
 	int new;
 
@@ -343,7 +343,6 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
 	}
 found:
 	cpu_data(cpu).logical_proc_id = new;
-	return 0;
 }
 /**
  * topology_update_die_map - Update the physical to logical die map
-- 
2.18.2

