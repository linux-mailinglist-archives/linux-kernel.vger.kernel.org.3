Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7651B52A9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351833AbiEQSEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351845AbiEQSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0F9E50B10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810635;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vm6RIiiRbWZOFdqvQrYcMqhI0p251x5p2f0jdauODUk=;
        b=O7PDN+tlwA4plkeEEtGNF0IHmE/MLn0Mgymu3t9Op5WzrcWeYVnrIKemV4u1EE9d+6Cm4S
        VVGGEPmdXXSaNyeN5KxbdnhVEuyFWI5w4VyYkYc5stTsDU0gXkQwO2gwHc9MRp3zOqMTBv
        5N/qkwibiEpIgkedRsk7X1ITAHk5l4Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-QkwokpmNPIis-AIgDmW3yQ-1; Tue, 17 May 2022 14:03:51 -0400
X-MC-Unique: QkwokpmNPIis-AIgDmW3yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 863EA801210;
        Tue, 17 May 2022 18:03:50 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B536A40CF8F6;
        Tue, 17 May 2022 18:03:49 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 08/11] smp: replace smp_call_function_many_cond() with __smp_call_mask_cond()
Date:   Tue, 17 May 2022 14:03:23 -0400
Message-Id: <20220517180326.997129-9-dqiao@redhat.com>
In-Reply-To: <20220517180326.997129-1-dqiao@redhat.com>
References: <20220517180326.997129-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced smp_call_function_many_cond() with __smp_call_mask_cond()
and made the changes accordingly.

Consolidated and clean up the redundant code alongside the paths of the
invocation to the function smp_call_function_many_cond().

on_each_cpu_cond_mask(cond_func, func, info, wait, mask) is replaced by
smp_call_mask_cond(umask, func, cond_func, info, (wait?SMP_CALL_TYPE_SYNC:
SMP_CALL_TYPE_ASYNC))

smp_call_function_many(mask, func, info, wait) is replaced by
smp_call_mask_others(mask, func, info, (wait?SMP_CALL_TYPE_SYNC:SMP_CALL_TYPE_ASYNC))

smp_call_function(func, info, wait) is replace by
smp_call_mask_others(SMP_CALL_MASK_ALL, func, info, (wait?SMP_CALL_TYPE_SYNC:SMP_CALL_TYPE_ASYNC))

on_each_cpu(func info, wait) is replaced by
smp_call(SMP_CALL_ALL, func, info, (wait?SMP_CALL_TYPE_SYNC:SMP_CALL_TYPE_ASYNC))

on_each_cpu_mask(mask, func, info, wait) is replaced by
smp_call_mask(mask, func, info, (wait?SMP_CALL_TYPE_SYNC:SMP_CALL_TYPE_ASYNC))

on_each_cpu_cond(cond_func, func, info, wait) is replaced by
smp_call_cond(SMP_CALL_ALL, func, info, cond_func, (wait ? SMP_CALL_TYPE_SYNC:
SMP_CALL_TYPE_ASYNC))

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to SMP_CALL
	  from the new macros
v2 -> v3: Modified the commit comments;
	  Replaced smp_call_function_many(mask,...) with smp_call_mask_others(mask,...)
	  for all the invocations;
	  Replaced smp_call_function() with smp_call_mask_others(SMP_CALL_MASK_ALL,...)
	  for all the invocations.
 arch/alpha/kernel/process.c                   |   2 +-
 arch/alpha/kernel/smp.c                       |  13 +-
 arch/arc/kernel/perf_event.c                  |   2 +-
 arch/arc/mm/cache.c                           |   2 +-
 arch/arc/mm/tlb.c                             |  14 +-
 arch/arm/common/bL_switcher.c                 |   3 +-
 arch/arm/kernel/machine_kexec.c               |   3 +-
 arch/arm/kernel/smp_tlb.c                     |  23 ++--
 arch/arm/kernel/smp_twd.c                     |   4 +-
 arch/arm/mm/flush.c                           |   5 +-
 arch/arm/vfp/vfpmodule.c                      |   2 +-
 arch/arm64/kernel/armv8_deprecated.c          |   4 +-
 arch/arm64/kernel/perf_event.c                |   2 +-
 arch/arm64/kvm/arm.c                          |   6 +-
 arch/csky/abiv2/cacheflush.c                  |   2 +-
 arch/csky/kernel/perf_event.c                 |   2 +-
 arch/csky/kernel/smp.c                        |   2 +-
 arch/csky/mm/cachev2.c                        |   2 +-
 arch/ia64/kernel/mca.c                        |   4 +-
 arch/ia64/kernel/smp.c                        |  12 +-
 arch/ia64/kernel/uncached.c                   |   6 +-
 arch/mips/cavium-octeon/octeon-irq.c          |   4 +-
 arch/mips/cavium-octeon/setup.c               |   6 +-
 arch/mips/kernel/crash.c                      |   3 +-
 arch/mips/kernel/machine_kexec.c              |   3 +-
 arch/mips/kernel/perf_event_mipsxx.c          |   7 +-
 arch/mips/kernel/smp.c                        |   9 +-
 arch/mips/kernel/sysrq.c                      |   3 +-
 arch/mips/mm/c-r4k.c                          |   4 +-
 arch/mips/sibyte/common/cfe.c                 |   3 +-
 arch/openrisc/kernel/smp.c                    |  13 +-
 arch/parisc/kernel/cache.c                    |   4 +-
 arch/parisc/mm/init.c                         |   2 +-
 arch/powerpc/kernel/dawr.c                    |   3 +-
 arch/powerpc/kernel/kvm.c                     |   2 +-
 arch/powerpc/kernel/security.c                |   6 +-
 arch/powerpc/kernel/smp.c                     |   6 +-
 arch/powerpc/kernel/sysfs.c                   |   2 +-
 arch/powerpc/kernel/tau_6xx.c                 |   4 +-
 arch/powerpc/kexec/core_64.c                  |   3 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c           |   2 +-
 arch/powerpc/mm/book3s64/pgtable.c            |   2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  12 +-
 arch/powerpc/mm/nohash/tlb.c                  |  11 +-
 arch/powerpc/mm/slice.c                       |   4 +-
 arch/powerpc/perf/core-book3s.c               |   2 +-
 arch/powerpc/perf/imc-pmu.c                   |   2 +-
 arch/powerpc/platforms/85xx/smp.c             |   3 +-
 arch/powerpc/platforms/powernv/idle.c         |   2 +-
 arch/powerpc/platforms/pseries/lparcfg.c      |   2 +-
 arch/riscv/mm/cacheflush.c                    |   4 +-
 arch/s390/hypfs/hypfs_diag0c.c                |   2 +-
 arch/s390/kernel/alternative.c                |   2 +-
 arch/s390/kernel/perf_cpum_cf.c               |  10 +-
 arch/s390/kernel/perf_cpum_cf_common.c        |   4 +-
 arch/s390/kernel/perf_cpum_sf.c               |   4 +-
 arch/s390/kernel/processor.c                  |   2 +-
 arch/s390/kernel/smp.c                        |   2 +-
 arch/s390/kernel/topology.c                   |   2 +-
 arch/s390/mm/pgalloc.c                        |   2 +-
 arch/s390/pci/pci_irq.c                       |   2 +-
 arch/sh/kernel/smp.c                          |  19 ++-
 arch/sh/mm/cache.c                            |   3 +-
 arch/sparc/include/asm/mman.h                 |   4 +-
 arch/sparc/kernel/nmi.c                       |  13 +-
 arch/sparc/kernel/perf_event.c                |   4 +-
 arch/sparc/kernel/smp_64.c                    |   9 +-
 arch/sparc/mm/init_64.c                       |   2 +-
 arch/x86/events/core.c                        |   6 +-
 arch/x86/events/intel/core.c                  |   4 +-
 arch/x86/kernel/alternative.c                 |   2 +-
 arch/x86/kernel/amd_nb.c                      |   2 +-
 arch/x86/kernel/apic/apic.c                   |   2 +-
 arch/x86/kernel/cpu/bugs.c                    |   2 +-
 arch/x86/kernel/cpu/mce/core.c                |  12 +-
 arch/x86/kernel/cpu/mce/inject.c              |   4 +-
 arch/x86/kernel/cpu/mce/intel.c               |   2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |   6 +-
 arch/x86/kernel/cpu/sgx/main.c                |   5 +-
 arch/x86/kernel/cpu/umwait.c                  |   2 +-
 arch/x86/kernel/cpu/vmware.c                  |   2 +-
 arch/x86/kernel/kvm.c                         |   2 +-
 arch/x86/kernel/ldt.c                         |   2 +-
 arch/x86/kvm/x86.c                            |   4 +-
 arch/x86/lib/cache-smp.c                      |   2 +-
 arch/x86/lib/msr-smp.c                        |   2 +-
 arch/x86/mm/pat/set_memory.c                  |   4 +-
 arch/x86/mm/tlb.c                             |  12 +-
 arch/x86/xen/mmu_pv.c                         |   2 +-
 arch/x86/xen/smp_pv.c                         |   3 +-
 arch/x86/xen/suspend.c                        |   4 +-
 arch/xtensa/kernel/smp.c                      |  22 +--
 drivers/char/agp/generic.c                    |   2 +-
 drivers/clocksource/mips-gic-timer.c          |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                |   6 +-
 drivers/cpufreq/tegra194-cpufreq.c            |   2 +-
 drivers/cpuidle/driver.c                      |   8 +-
 drivers/edac/amd64_edac.c                     |   4 +-
 drivers/firmware/arm_sdei.c                   |  10 +-
 drivers/gpu/drm/i915/vlv_sideband.c           |   2 +-
 drivers/hwmon/fam15h_power.c                  |   2 +-
 drivers/irqchip/irq-mvebu-pic.c               |   4 +-
 drivers/net/ethernet/marvell/mvneta.c         |  30 ++--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   8 +-
 drivers/platform/x86/intel_ips.c              |   4 +-
 drivers/soc/xilinx/xlnx_event_manager.c       |   2 +-
 drivers/tty/sysrq.c                           |   3 +-
 drivers/watchdog/booke_wdt.c                  |   8 +-
 fs/buffer.c                                   |   2 +-
 include/linux/smp.h                           |  55 +-------
 kernel/profile.c                              |   4 +-
 kernel/rcu/tree.c                             |   4 +-
 kernel/scftorture.c                           |  11 +-
 kernel/sched/membarrier.c                     |   8 +-
 kernel/smp.c                                  | 130 +++---------------
 kernel/time/hrtimer.c                         |   5 +-
 kernel/trace/ftrace.c                         |   9 +-
 kernel/trace/ring_buffer.c                    |   4 +-
 kernel/trace/trace.c                          |  12 +-
 kernel/trace/trace_events.c                   |   2 +-
 mm/kasan/quarantine.c                         |   2 +-
 mm/mmu_gather.c                               |   3 +-
 mm/slab.c                                     |   2 +-
 net/iucv/iucv.c                               |   8 +-
 virt/kvm/kvm_main.c                           |  10 +-
 126 files changed, 363 insertions(+), 451 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5f8527081da9..90eeb04b435f 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -167,7 +167,7 @@ common_shutdown(int mode, char *restart_cmd)
 	struct halt_info args;
 	args.mode = mode;
 	args.restart_cmd = restart_cmd;
-	on_each_cpu(common_shutdown_1, &args, 0);
+	smp_call(SMP_CALL_ALL, common_shutdown_1, &args, SMP_CALL_TYPE_ASYNC);
 }
 
 void
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index cb64e4797d2a..298463cb8c77 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -611,7 +611,7 @@ void
 smp_imb(void)
 {
 	/* Must wait other processors to flush their icache before continue. */
-	on_each_cpu(ipi_imb, NULL, 1);
+	smp_call(SMP_CALL_ALL, ipi_imb, NULL, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(smp_imb);
 
@@ -626,7 +626,7 @@ flush_tlb_all(void)
 {
 	/* Although we don't have any data to pass, we do want to
 	   synchronize with the other processors.  */
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_tlb_all, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 #define asn_locked() (cpu_data[smp_processor_id()].asn_lock)
@@ -661,7 +661,8 @@ flush_tlb_mm(struct mm_struct *mm)
 		}
 	}
 
-	smp_call_function(ipi_flush_tlb_mm, mm, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, ipi_flush_tlb_mm,
+				mm, SMP_CALL_TYPE_SYNC);
 
 	preempt_enable();
 }
@@ -712,7 +713,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	data.mm = mm;
 	data.addr = addr;
 
-	smp_call_function(ipi_flush_tlb_page, &data, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, ipi_flush_tlb_page,
+			&data, SMP_CALL_TYPE_SYNC);
 
 	preempt_enable();
 }
@@ -762,7 +764,8 @@ flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 		}
 	}
 
-	smp_call_function(ipi_flush_icache_page, mm, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, ipi_flush_icache_page,
+			mm, SMP_CALL_TYPE_SYNC);
 
 	preempt_enable();
 }
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index adff957962da..682db1682287 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -811,7 +811,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 						 this_cpu_ptr(&arc_pmu_cpu));
 
 			if (!ret)
-				on_each_cpu(arc_cpu_pmu_irq_init, &irq, 1);
+				smp_call(SMP_CALL_ALL, arc_cpu_pmu_irq_init, &irq, SMP_CALL_TYPE_SYNC);
 			else
 				irq = -1;
 		}
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 5446967ea98d..4ad4e8f843e3 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -569,7 +569,7 @@ static void __ic_line_inv_vaddr(phys_addr_t paddr, unsigned long vaddr,
 		.sz    = sz
 	};
 
-	on_each_cpu(__ic_line_inv_vaddr_helper, &ic_inv, 1);
+	smp_call(SMP_CALL_ALL, __ic_line_inv_vaddr_helper, &ic_inv, SMP_CALL_TYPE_SYNC);
 }
 
 #endif	/* CONFIG_SMP */
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 5f71445f26bd..83aaa61c6698 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -330,13 +330,13 @@ static inline void ipi_flush_tlb_kernel_range(void *arg)
 
 void flush_tlb_all(void)
 {
-	on_each_cpu((smp_call_func_t)local_flush_tlb_all, NULL, 1);
+	smp_call(SMP_CALL_ALL, (smp_call_func_t)local_flush_tlb_all, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	on_each_cpu_mask(mm_cpumask(mm), (smp_call_func_t)local_flush_tlb_mm,
-			 mm, 1);
+	smp_call_mask(mm_cpumask(mm), (smp_call_func_t)local_flush_tlb_mm,
+			 mm, SMP_CALL_TYPE_SYNC);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
@@ -346,7 +346,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 		.ta_start = uaddr
 	};
 
-	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page, &ta, 1);
+	smp_call_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page, &ta, SMP_CALL_TYPE_SYNC);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -358,7 +358,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		.ta_end = end
 	};
 
-	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range, &ta, 1);
+	smp_call_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range, &ta, SMP_CALL_TYPE_SYNC);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -371,7 +371,7 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		.ta_end = end
 	};
 
-	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_pmd_tlb_range, &ta, 1);
+	smp_call_mask(mm_cpumask(vma->vm_mm), ipi_flush_pmd_tlb_range, &ta, SMP_CALL_TYPE_SYNC);
 }
 #endif
 
@@ -382,7 +382,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		.ta_end = end
 	};
 
-	on_each_cpu(ipi_flush_tlb_kernel_range, &ta, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_tlb_kernel_range, &ta, SMP_CALL_TYPE_SYNC);
 }
 #endif
 
diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 9a9aa53547a6..a98a37e16595 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -541,7 +541,8 @@ int bL_switcher_trace_trigger(void)
 	preempt_disable();
 
 	bL_switcher_trace_trigger_cpu(NULL);
-	smp_call_function(bL_switcher_trace_trigger_cpu, NULL, true);
+	mp_call_mask_others(SMP_CALL_MASK_ALL, bL_switcher_trace_trigger_cpu,
+			NULL, SMP_CALL_TYPE_SYNC);
 
 	preempt_enable();
 
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0..15a657130a9e 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -101,7 +101,8 @@ void crash_smp_send_stop(void)
 		return;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, machine_crash_nonpanic_core,
+			NULL, SMP_CALL_TYPE_ASYNC);
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index d4908b3736d8..528500d479e0 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -158,7 +158,8 @@ static void broadcast_tlb_a15_erratum(void)
 	if (!erratum_a15_798181())
 		return;
 
-	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, ipi_flush_tlb_a15_erratum,
+			NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
@@ -171,14 +172,14 @@ static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 
 	this_cpu = get_cpu();
 	a15_erratum_get_cpumask(this_cpu, mm, &mask);
-	smp_call_function_many(&mask, ipi_flush_tlb_a15_erratum, NULL, 1);
+	smp_call_mask_others(&mask, ipi_flush_tlb_a15_erratum, NULL, SMP_CALL_TYPE_SYNC);
 	put_cpu();
 }
 
 void flush_tlb_all(void)
 {
 	if (tlb_ops_need_broadcast())
-		on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+		smp_call(SMP_CALL_ALL, ipi_flush_tlb_all, NULL, SMP_CALL_TYPE_SYNC);
 	else
 		__flush_tlb_all();
 	broadcast_tlb_a15_erratum();
@@ -187,7 +188,7 @@ void flush_tlb_all(void)
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	if (tlb_ops_need_broadcast())
-		on_each_cpu_mask(mm_cpumask(mm), ipi_flush_tlb_mm, mm, 1);
+		smp_call_mask(mm_cpumask(mm), ipi_flush_tlb_mm, mm, SMP_CALL_TYPE_SYNC);
 	else
 		__flush_tlb_mm(mm);
 	broadcast_tlb_mm_a15_erratum(mm);
@@ -199,8 +200,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 		struct tlb_args ta;
 		ta.ta_vma = vma;
 		ta.ta_start = uaddr;
-		on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page,
-					&ta, 1);
+		smp_call_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page,
+			       &ta, SMP_CALL_TYPE_SYNC);
 	} else
 		__flush_tlb_page(vma, uaddr);
 	broadcast_tlb_mm_a15_erratum(vma->vm_mm);
@@ -211,7 +212,7 @@ void flush_tlb_kernel_page(unsigned long kaddr)
 	if (tlb_ops_need_broadcast()) {
 		struct tlb_args ta;
 		ta.ta_start = kaddr;
-		on_each_cpu(ipi_flush_tlb_kernel_page, &ta, 1);
+		smp_call(SMP_CALL_ALL, ipi_flush_tlb_kernel_page, &ta, SMP_CALL_TYPE_SYNC);
 	} else
 		__flush_tlb_kernel_page(kaddr);
 	broadcast_tlb_a15_erratum();
@@ -225,8 +226,8 @@ void flush_tlb_range(struct vm_area_struct *vma,
 		ta.ta_vma = vma;
 		ta.ta_start = start;
 		ta.ta_end = end;
-		on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range,
-					&ta, 1);
+		smp_call_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range,
+				&ta, SMP_CALL_TYPE_SYNC);
 	} else
 		local_flush_tlb_range(vma, start, end);
 	broadcast_tlb_mm_a15_erratum(vma->vm_mm);
@@ -238,7 +239,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		struct tlb_args ta;
 		ta.ta_start = start;
 		ta.ta_end = end;
-		on_each_cpu(ipi_flush_tlb_kernel_range, &ta, 1);
+		smp_call(SMP_CALL_ALL, ipi_flush_tlb_kernel_range, &ta, SMP_CALL_TYPE_SYNC);
 	} else
 		local_flush_tlb_kernel_range(start, end);
 	broadcast_tlb_a15_erratum();
@@ -247,7 +248,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 void flush_bp_all(void)
 {
 	if (tlb_ops_need_broadcast())
-		on_each_cpu(ipi_flush_bp_all, NULL, 1);
+		smp_call(SMP_CALL_ALL, ipi_flush_bp_all, NULL, SMP_CALL_TYPE_SYNC);
 	else
 		__flush_bp_all();
 }
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f721a2b0..fa1b054e1398 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -119,8 +119,8 @@ static int twd_rate_change(struct notifier_block *nb,
 	 * changing cpu.
 	 */
 	if (flags == POST_RATE_CHANGE)
-		on_each_cpu(twd_update_frequency,
-				  (void *)&cnd->new_rate, 1);
+		smp_call(SMP_CALL_ALL, twd_update_frequency,
+			  (void *)&cnd->new_rate, SMP_CALL_TYPE_SYNC);
 
 	return NOTIFY_OK;
 }
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7ff9feea13a6..6bff1e59cc14 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -150,8 +150,9 @@ void __flush_ptrace_access(struct page *page, unsigned long uaddr, void *kaddr,
 		else
 			__cpuc_coherent_kern_range(addr, addr + len);
 		if (cache_ops_need_broadcast())
-			smp_call_function(flush_ptrace_access_other,
-					  NULL, 1);
+			smp_call_mask_others(SMP_CALL_MASK_ALL,
+					flush_ptrace_access_other,
+					NULL, SMP_CALL_TYPE_SYNC);
 	}
 }
 
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..dc21f87062c2 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -780,7 +780,7 @@ static int __init vfp_init(void)
 	 * following test on FPSID will succeed.
 	 */
 	if (cpu_arch >= CPU_ARCH_ARMv6)
-		on_each_cpu(vfp_enable, NULL, 1);
+		smp_call(SMP_CALL_ALL, vfp_enable, NULL, SMP_CALL_TYPE_SYNC);
 
 	/*
 	 * First check that there is a VFP that we can use.
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 6875a16b09d2..03f469dffdb6 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -104,9 +104,9 @@ static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
 	if (!insn->ops->set_hw_mode)
 		return -EINVAL;
 	if (enable)
-		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
+		smp_call(SMP_CALL_ALL, enable_insn_hw_mode, (void *)insn, SMP_CALL_TYPE_SYNC);
 	else
-		on_each_cpu(disable_insn_hw_mode, (void *)insn, true);
+		smp_call(SMP_CALL_ALL, disable_insn_hw_mode, (void *)insn, SMP_CALL_TYPE_SYNC);
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index be4ef28dc1d6..c1efb0b0d8d6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1215,7 +1215,7 @@ static int armv8pmu_proc_user_access_handler(struct ctl_table *table, int write,
 	if (ret || !write || sysctl_perf_user_access)
 		return ret;
 
-	on_each_cpu(armv8pmu_disable_user_access_ipi, NULL, 1);
+	smp_call(SMP_CALL_ALL, armv8pmu_disable_user_access_ipi, NULL, SMP_CALL_TYPE_SYNC);
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..bb82cbc48626 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1728,7 +1728,7 @@ static int init_subsystems(void)
 	/*
 	 * Enable hardware so that subsystem initialisation can access EL2.
 	 */
-	on_each_cpu(_kvm_arch_hardware_enable, NULL, 1);
+	smp_call(SMP_CALL_ALL, _kvm_arch_hardware_enable, NULL, SMP_CALL_TYPE_SYNC);
 
 	/*
 	 * Register CPU lower-power notifier
@@ -1765,7 +1765,7 @@ static int init_subsystems(void)
 
 out:
 	if (err || !is_protected_kvm_enabled())
-		on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
+		smp_call(SMP_CALL_ALL, _kvm_arch_hardware_disable, NULL, SMP_CALL_TYPE_SYNC);
 
 	return err;
 }
@@ -2000,7 +2000,7 @@ static int pkvm_drop_host_privileges(void)
 	 * once the host stage 2 is installed.
 	 */
 	static_branch_enable(&kvm_protected_mode_initialized);
-	on_each_cpu(_kvm_host_prot_finalize, &ret, 1);
+	smp_call(SMP_CALL_ALL, _kvm_host_prot_finalize, &ret, SMP_CALL_TYPE_SYNC);
 	return ret;
 }
 
diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index 39c51399dd81..b662f8a10db8 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -80,7 +80,7 @@ void flush_icache_mm_range(struct mm_struct *mm,
 	cpumask_andnot(&others, mm_cpumask(mm), cpumask_of(cpu));
 
 	if (mm != current->active_mm || !cpumask_empty(&others)) {
-		on_each_cpu_mask(&others, local_icache_inv_all, NULL, 1);
+		smp_call_mask(&others, local_icache_inv_all, NULL, SMP_CALL_TYPE_SYNC);
 		cpumask_clear(mask);
 	}
 
diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index e5f18420ce64..bc8fb8a8fd28 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1311,7 +1311,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 	csky_pmu.plat_device = pdev;
 
 	/* Ensure the PMU has sane values out of reset. */
-	on_each_cpu(csky_pmu_reset, &csky_pmu, 1);
+	smp_call(SMP_CALL_ALL, csky_pmu_reset, &csky_pmu, SMP_CALL_TYPE_SYNC);
 
 	ret = csky_pmu_request_irq(csky_pmu_handle_irq);
 	if (ret) {
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 6bb38bc2f39b..2b62171d8d82 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -137,7 +137,7 @@ static void ipi_stop(void *unused)
 
 void smp_send_stop(void)
 {
-	on_each_cpu(ipi_stop, NULL, 1);
+	smp_call(SMP_CALL_ALL, ipi_stop, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 void smp_send_reschedule(int cpu)
diff --git a/arch/csky/mm/cachev2.c b/arch/csky/mm/cachev2.c
index 7a9664adce43..19dab0d4c089 100644
--- a/arch/csky/mm/cachev2.c
+++ b/arch/csky/mm/cachev2.c
@@ -66,7 +66,7 @@ void icache_inv_range(unsigned long start, unsigned long end)
 	if (irqs_disabled())
 		local_icache_inv_range(&param);
 	else
-		on_each_cpu(local_icache_inv_range, &param, 1);
+		smp_call(SMP_CALL_ALL, local_icache_inv_range, &param, SMP_CALL_TYPE_SYNC);
 }
 #endif
 
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index e628a88607bb..c3723f7b0068 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -712,7 +712,7 @@ ia64_mca_cmc_vector_enable (void *dummy)
 static void
 ia64_mca_cmc_vector_disable_keventd(struct work_struct *unused)
 {
-	on_each_cpu(ia64_mca_cmc_vector_disable, NULL, 0);
+	smp_call(SMP_CALL_ALL, ia64_mca_cmc_vector_disable, NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 /*
@@ -724,7 +724,7 @@ ia64_mca_cmc_vector_disable_keventd(struct work_struct *unused)
 static void
 ia64_mca_cmc_vector_enable_keventd(struct work_struct *unused)
 {
-	on_each_cpu(ia64_mca_cmc_vector_enable, NULL, 0);
+	smp_call(SMP_CALL_ALL, ia64_mca_cmc_vector_enable, NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 /*
diff --git a/arch/ia64/kernel/smp.c b/arch/ia64/kernel/smp.c
index 7b7b64eb3129..e7865d3d006d 100644
--- a/arch/ia64/kernel/smp.c
+++ b/arch/ia64/kernel/smp.c
@@ -285,7 +285,7 @@ smp_flush_tlb_cpumask(cpumask_t xcpumask)
 void
 smp_flush_tlb_all (void)
 {
-	on_each_cpu((void (*)(void *))local_flush_tlb_all, NULL, 1);
+	smp_call(SMP_CALL_ALL, (void (*)(void *))local_flush_tlb_all, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 void
@@ -301,12 +301,14 @@ smp_flush_tlb_mm (struct mm_struct *mm)
 		return;
 	}
 	if (!alloc_cpumask_var(&cpus, GFP_ATOMIC)) {
-		smp_call_function((void (*)(void *))local_finish_flush_tlb_mm,
-			mm, 1);
+		smp_call_mask_others(SMP_CALL_MASK_ALL,
+				(void (*)(void *))local_finish_flush_tlb_mm,
+				mm, SMP_CALL_TYPE_SYNC);
 	} else {
 		cpumask_copy(cpus, mm_cpumask(mm));
-		smp_call_function_many(cpus,
-			(void (*)(void *))local_finish_flush_tlb_mm, mm, 1);
+		smp_call_mask_others(cpus,
+			(void (*)(void *))local_finish_flush_tlb_mm,
+			mm, SMP_CALL_TYPE_SYNC);
 		free_cpumask_var(cpus);
 	}
 	local_irq_disable();
diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 816803636a75..966b7dd679f7 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -118,7 +118,8 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
 	status = ia64_pal_prefetch_visibility(PAL_VISIBILITY_PHYSICAL);
 	if (status == PAL_VISIBILITY_OK_REMOTE_NEEDED) {
 		atomic_set(&uc_pool->status, 0);
-		smp_call_function(uncached_ipi_visibility, uc_pool, 1);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, uncached_ipi_visibility,
+				uc_pool, SMP_CALL_TYPE_SYNC);
 		if (atomic_read(&uc_pool->status))
 			goto failed;
 	} else if (status != PAL_VISIBILITY_OK)
@@ -137,7 +138,8 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
 	if (status != PAL_STATUS_SUCCESS)
 		goto failed;
 	atomic_set(&uc_pool->status, 0);
-	smp_call_function(uncached_ipi_mc_drain, uc_pool, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, uncached_ipi_mc_drain,
+			uc_pool, SMP_CALL_TYPE_SYNC);
 	if (atomic_read(&uc_pool->status))
 		goto failed;
 
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 07d7ff5a981d..558a16d3a705 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -216,7 +216,7 @@ static void octeon_irq_core_bus_sync_unlock(struct irq_data *data)
 	struct octeon_core_chip_data *cd = irq_data_get_irq_chip_data(data);
 
 	if (cd->desired_en != cd->current_en) {
-		on_each_cpu(octeon_irq_core_set_enable_local, data, 1);
+		smp_call(SMP_CALL_ALL, octeon_irq_core_set_enable_local, data, SMP_CALL_TYPE_SYNC);
 
 		cd->current_en = cd->desired_en;
 	}
@@ -1364,7 +1364,7 @@ void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t h)
 {
 	octeon_irq_ip4 = h;
 	octeon_irq_use_ip4 = true;
-	on_each_cpu(octeon_irq_local_enable_ip4, NULL, 1);
+	smp_call(SMP_CALL_ALL, octeon_irq_local_enable_ip4, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void octeon_irq_percpu_enable(void)
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 00bf269763cf..e808957e123c 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -256,7 +256,8 @@ static void octeon_shutdown(void)
 {
 	octeon_generic_shutdown();
 #ifdef CONFIG_SMP
-	smp_call_function(octeon_kexec_smp_down, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, octeon_kexec_smp_down,
+			NULL, SMP_CALL_TYPE_ASYNC);
 	smp_wmb();
 	while (num_online_cpus() > 1) {
 		cpu_relax();
@@ -469,7 +470,8 @@ static void octeon_kill_core(void *arg)
  */
 static void octeon_halt(void)
 {
-	smp_call_function(octeon_kill_core, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, octeon_kill_core,
+			NULL, SMP_CALL_TYPE_ASYNC);
 
 	switch (octeon_bootinfo->board_type) {
 	case CVMX_BOARD_TYPE_NAO38:
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 81845ba04835..036e778a40d0 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -63,7 +63,8 @@ static void crash_kexec_prepare_cpus(void)
 
 	ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
 
-	smp_call_function(crash_shutdown_secondary, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, crash_shutdown_secondary,
+			NULL, SMP_CALL_TYPE_ASYNC);
 	smp_wmb();
 
 	/*
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 432bfd3e7f22..9f99998ddb32 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -139,7 +139,8 @@ machine_shutdown(void)
 		_machine_kexec_shutdown();
 
 #ifdef CONFIG_SMP
-	smp_call_function(kexec_shutdown_secondary, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, kexec_shutdown_secondary,
+			NULL, SMP_CALL_TYPE_ASYNC);
 
 	while (num_online_cpus() > 1) {
 		cpu_relax();
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 1641d274fe37..8d8a4ae1ca26 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -642,8 +642,9 @@ static void hw_perf_event_destroy(struct perf_event *event)
 		 * We must not call the destroy function with interrupts
 		 * disabled.
 		 */
-		on_each_cpu(reset_counters,
-			(void *)(long)mipspmu.num_counters, 1);
+		smp_call(SMP_CALL_ALL, reset_counters,
+			(void *)(long)mipspmu.num_counters, SMP_CALL_TYPE_SYNC);
+
 		mipspmu_free_irq();
 		mutex_unlock(&pmu_reserve_mutex);
 	}
@@ -2043,7 +2044,7 @@ init_hw_perf_events(void)
 		mipspmu.write_counter = mipsxx_pmu_write_counter;
 	}
 
-	on_each_cpu(reset_counters, (void *)(long)counters, 1);
+	smp_call(SMP_CALL_ALL, reset_counters, (void *)(long)counters, SMP_CALL_TYPE_SYNC);
 
 	pr_cont("%s PMU enabled, %d %d-bit counters available to each "
 		"CPU, irq %d%s\n", mipspmu.name, counters, counter_bits, irq,
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 1986d1309410..ca4727862b95 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -397,7 +397,8 @@ static void stop_this_cpu(void *dummy)
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, stop_this_cpu,
+			NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
@@ -472,7 +473,7 @@ void flush_tlb_all(void)
 		return;
 	}
 
-	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
+	smp_call(SMP_CALL_ALL, flush_tlb_all_ipi, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void flush_tlb_mm_ipi(void *mm)
@@ -490,7 +491,7 @@ static void flush_tlb_mm_ipi(void *mm)
  */
 static inline void smp_on_other_tlbs(void (*func) (void *info), void *info)
 {
-	smp_call_function(func, info, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, func, info, SMP_CALL_TYPE_SYNC);
 }
 
 static inline void smp_on_each_tlb(void (*func) (void *info), void *info)
@@ -617,7 +618,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		.addr2 = end,
 	};
 
-	on_each_cpu(flush_tlb_kernel_range_ipi, &fd, 1);
+	smp_call(SMP_CALL_ALL, flush_tlb_kernel_range_ipi, &fd, SMP_CALL_TYPE_SYNC);
 }
 
 static void flush_tlb_page_ipi(void *info)
diff --git a/arch/mips/kernel/sysrq.c b/arch/mips/kernel/sysrq.c
index 9c1a2019113b..281e4a0f2832 100644
--- a/arch/mips/kernel/sysrq.c
+++ b/arch/mips/kernel/sysrq.c
@@ -38,7 +38,8 @@ static void sysrq_tlbdump_single(void *dummy)
 #ifdef CONFIG_SMP
 static void sysrq_tlbdump_othercpus(struct work_struct *dummy)
 {
-	smp_call_function(sysrq_tlbdump_single, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, sysrq_tlbdump_single,
+			NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 static DECLARE_WORK(sysrq_tlbdump, sysrq_tlbdump_othercpus);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ccb9e47322b0..558ce8f115a3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -96,8 +96,8 @@ static inline void r4k_on_each_cpu(unsigned int type,
 {
 	preempt_disable();
 	if (r4k_op_needs_ipi(type))
-		smp_call_function_many(&cpu_foreign_map[smp_processor_id()],
-				       func, info, 1);
+		smp_call_mask_others(&cpu_foreign_map[smp_processor_id()],
+					func, info, SMP_CALL_TYPE_SYNC);
 	func(info);
 	preempt_enable();
 }
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 1a504294d85f..51e7c1b2c8f3 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -57,7 +57,8 @@ static void __noreturn cfe_linux_exit(void *arg)
 		if (!reboot_smp) {
 			/* Get CPU 0 to do the cfe_exit */
 			reboot_smp = 1;
-			smp_call_function(cfe_linux_exit, arg, 0);
+			smp_call_mask_others(SMP_CALL_MASK_ALL, cfe_linux_exit,
+					arg, SMP_CALL_TYPE_ASYNC);
 		}
 	} else {
 		printk("Passing control back to CFE...\n");
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 27041db2c8b0..bd8748acde10 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -194,7 +194,8 @@ static void stop_this_cpu(void *dummy)
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, stop_this_cpu,
+			NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 /* not supported, yet */
@@ -244,7 +245,7 @@ static void smp_flush_tlb_mm(struct cpumask *cmask, struct mm_struct *mm)
 		/* local cpu is the only cpu present in cpumask */
 		local_flush_tlb_mm(mm);
 	} else {
-		on_each_cpu_mask(cmask, ipi_flush_tlb_mm, mm, 1);
+		smp_call_mask(cmask, ipi_flush_tlb_mm, mm, SMP_CALL_TYPE_SYNC);
 	}
 	put_cpu();
 }
@@ -291,16 +292,16 @@ static void smp_flush_tlb_range(const struct cpumask *cmask, unsigned long start
 		fd.addr2 = end;
 
 		if ((end - start) <= PAGE_SIZE)
-			on_each_cpu_mask(cmask, ipi_flush_tlb_page, &fd, 1);
+			smp_call_mask(cmask, ipi_flush_tlb_page, &fd, SMP_CALL_TYPE_SYNC);
 		else
-			on_each_cpu_mask(cmask, ipi_flush_tlb_range, &fd, 1);
+			smp_call_mask(cmask, ipi_flush_tlb_range, &fd, SMP_CALL_TYPE_SYNC);
 	}
 	put_cpu();
 }
 
 void flush_tlb_all(void)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_tlb_all, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
@@ -331,6 +332,6 @@ static void ipi_icache_page_inv(void *arg)
 
 void smp_icache_page_inv(struct page *page)
 {
-	on_each_cpu(ipi_icache_page_inv, page, 1);
+	smp_call(SMP_CALL_ALL, ipi_icache_page_inv, page, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(smp_icache_page_inv);
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index e7911225a4f8..2d51c1fef256 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -81,13 +81,13 @@ void flush_cache_all_local(void)
 void flush_cache_all(void)
 {
 	if (static_branch_likely(&parisc_has_cache))
-		on_each_cpu(cache_flush_local_cpu, NULL, 1);
+		smp_call(SMP_CALL_ALL, cache_flush_local_cpu, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static inline void flush_data_cache(void)
 {
 	if (static_branch_likely(&parisc_has_dcache))
-		on_each_cpu(flush_data_cache_local, NULL, 1);
+		smp_call(SMP_CALL_ALL, flush_data_cache_local, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 1dc2e88e7b04..3b89ab4af568 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -847,7 +847,7 @@ void flush_tlb_all(void)
 	    do_recycle++;
 	}
 	spin_unlock(&sid_lock);
-	on_each_cpu(flush_tlb_all_local, NULL, 1);
+	smp_call(SMP_CALL_ALL, lush_tlb_all_local, NULL, SMP_CALL_TYPE_SYNC);
 	if (do_recycle) {
 	    spin_lock(&sid_lock);
 	    recycle_sids(recycle_ndirty,recycle_dirty_array);
diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index 64e423d2fe0f..9b17c7f32cdf 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -77,7 +77,8 @@ static ssize_t dawr_write_file_bool(struct file *file,
 
 	/* If we are clearing, make sure all CPUs have the DAWR cleared */
 	if (!dawr_force_enable)
-		smp_call_function(disable_dawrs_cb, NULL, 0);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, disable_dawrs_cb,
+				NULL, SMP_CALL_TYPE_ASYNC);
 
 	return rc;
 }
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 6568823cf306..559023ef1952 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -666,7 +666,7 @@ static void __init kvm_use_magic_page(void)
 	u32 features;
 
 	/* Tell the host to map the magic page to -4096 on all CPUs */
-	on_each_cpu(kvm_map_magic_page, &features, 1);
+	smp_call(SMP_CALL_ALL, kvm_map_magic_page, &features, SMP_CALL_TYPE_SYNC);
 
 	/* Quick self-test to see if the mapping works */
 	if (fault_in_readable((const char __user *)KVM_MAGIC_PAGE,
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index d96fd14bd7c9..65b53535f2b9 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -607,7 +607,7 @@ void rfi_flush_enable(bool enable)
 {
 	if (enable) {
 		do_rfi_flush_fixups(enabled_flush_types);
-		on_each_cpu(do_nothing, NULL, 1);
+		smp_call(SMP_CALL_ALL, do_nothing, NULL, SMP_CALL_TYPE_SYNC);
 	} else
 		do_rfi_flush_fixups(L1D_FLUSH_NONE);
 
@@ -618,7 +618,7 @@ static void entry_flush_enable(bool enable)
 {
 	if (enable) {
 		do_entry_flush_fixups(enabled_flush_types);
-		on_each_cpu(do_nothing, NULL, 1);
+		smp_call(SMP_CALL_ALL, do_nothing, NULL, SMP_CALL_TYPE_SYNC);
 	} else {
 		do_entry_flush_fixups(L1D_FLUSH_NONE);
 	}
@@ -631,7 +631,7 @@ static void uaccess_flush_enable(bool enable)
 	if (enable) {
 		do_uaccess_flush_fixups(enabled_flush_types);
 		static_branch_enable(&uaccess_flush_key);
-		on_each_cpu(do_nothing, NULL, 1);
+		smp_call(SMP_CALL_ALL, do_nothing, NULL, SMP_CALL_TYPE_SYNC);
 	} else {
 		static_branch_disable(&uaccess_flush_key);
 		do_uaccess_flush_fixups(L1D_FLUSH_NONE);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index de0f6f09a5dd..ad7816cc94d6 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -655,7 +655,8 @@ void crash_smp_send_stop(void)
 #ifdef CONFIG_NMI_IPI
 	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_stop_this_cpu, 1000000);
 #else
-	smp_call_function(crash_stop_this_cpu, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, crash_stop_this_cpu,
+			NULL, SMP_CALL_TYPE_ASYNC);
 #endif /* CONFIG_NMI_IPI */
 }
 
@@ -711,7 +712,8 @@ void smp_send_stop(void)
 
 	stopped = true;
 
-	smp_call_function(stop_this_cpu, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, stop_this_cpu,
+			NULL, SMP_CALL_TYPE_ASYNC);
 }
 #endif /* CONFIG_NMI_IPI */
 
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 2069bbb90a9a..898b48ca7b5a 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -206,7 +206,7 @@ static ssize_t __used store_dscr_default(struct device *dev,
 		return -EINVAL;
 	dscr_default = val;
 
-	on_each_cpu(write_dscr, &val, 1);
+	smp_call(SMP_CALL_ALL, write_dscr, &val, SMP_CALL_TYPE_SYNC);
 
 	return count;
 }
diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index 828d0f4106d2..235905acf234 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -158,7 +158,7 @@ static struct workqueue_struct *tau_workq;
 static void tau_work_func(struct work_struct *work)
 {
 	msleep(shrink_timer);
-	on_each_cpu(tau_timeout, NULL, 0);
+	smp_call(SMP_CALL_ALL, tau_timeout, NULL, SMP_CALL_TYPE_ASYNC);
 	/* schedule ourselves to be run again */
 	queue_work(tau_workq, work);
 }
@@ -204,7 +204,7 @@ static int __init TAU_init(void)
 	if (!tau_workq)
 		return -ENOMEM;
 
-	on_each_cpu(TAU_init_smp, NULL, 0);
+	smp_call(SMP_CALL_ALL, TAU_init_smp, NULL, SMP_CALL_TYPE_ASYNC);
 
 	queue_work(tau_workq, &tau_work);
 
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 6cc7793b8420..4cb3806b12c4 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -225,7 +225,8 @@ static void wake_offline_cpus(void)
 static void kexec_prepare_cpus(void)
 {
 	wake_offline_cpus();
-	smp_call_function(kexec_smp_down, NULL, /* wait */0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, kexec_smp_down,
+			NULL, SMP_CALL_TYPE_ASYNC);
 	local_irq_disable();
 	hard_irq_disable();
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 0aeb51738ca9..776f9d1dfe99 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1555,7 +1555,7 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
 
 	/* Boot all CPUs out of the guest so they re-read
 	 * mmu_ready */
-	on_each_cpu(resize_hpt_boot_vcpu, NULL, 1);
+	smp_call(SMP_CALL_ALL, resize_hpt_boot_vcpu, NULL, SMP_CALL_TYPE_SYNC);
 
 	ret = -ENXIO;
 	if (!resize || (resize->order != shift))
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 052e6590f84f..ed809b93c635 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -111,7 +111,7 @@ static void do_serialize(void *arg)
 void serialize_against_pte_lookup(struct mm_struct *mm)
 {
 	smp_mb();
-	smp_call_function_many(mm_cpumask(mm), do_serialize, mm, 1);
+	smp_call_mask_others(mm_cpumask(mm), do_serialize, mm, SMP_CALL_TYPE_SYNC);
 }
 
 /*
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 7724af19ed7e..189b1b483ca5 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -464,7 +464,7 @@ static inline void _tlbiel_pid_multicast(struct mm_struct *mm,
 	struct cpumask *cpus = mm_cpumask(mm);
 	struct tlbiel_pid t = { .pid = pid, .ric = ric };
 
-	on_each_cpu_mask(cpus, do_tlbiel_pid, &t, 1);
+	smp_call_mask(cpus, do_tlbiel_pid, &t, SMP_CALL_TYPE_SYNC);
 	/*
 	 * Always want the CPU translations to be invalidated with tlbiel in
 	 * these paths, so while coprocessors must use tlbie, we can not
@@ -616,7 +616,7 @@ static inline void _tlbiel_va_multicast(struct mm_struct *mm,
 {
 	struct cpumask *cpus = mm_cpumask(mm);
 	struct tlbiel_va t = { .va = va, .pid = pid, .psize = psize, .ric = ric };
-	on_each_cpu_mask(cpus, do_tlbiel_va, &t, 1);
+	smp_call_mask(cpus, do_tlbiel_va, &t, SMP_CALL_TYPE_SYNC);
 	if (atomic_read(&mm->context.copros) > 0)
 		_tlbie_va(va, pid, psize, RIC_FLUSH_TLB);
 }
@@ -682,7 +682,7 @@ static inline void _tlbiel_va_range_multicast(struct mm_struct *mm,
 				.pid = pid, .page_size = page_size,
 				.psize = psize, .also_pwc = also_pwc };
 
-	on_each_cpu_mask(cpus, do_tlbiel_va_range, &t, 1);
+	smp_call_mask(cpus, do_tlbiel_va_range, &t, SMP_CALL_TYPE_SYNC);
 	if (atomic_read(&mm->context.copros) > 0)
 		_tlbie_va_range(start, end, pid, page_size, psize, also_pwc);
 }
@@ -827,8 +827,8 @@ static void exit_flush_lazy_tlbs(struct mm_struct *mm)
 	 * make a special powerpc IPI for flushing TLBs.
 	 * For now it's not too performance critical.
 	 */
-	smp_call_function_many(mm_cpumask(mm), do_exit_flush_lazy_tlb,
-				(void *)mm, 1);
+	smp_call_mask_others(mm_cpumask(mm), do_exit_flush_lazy_tlb,
+				(void *)mm, SMP_CALL_TYPE_SYNC);
 }
 
 #else /* CONFIG_SMP */
@@ -1064,7 +1064,7 @@ static void do_tlbiel_kernel(void *info)
 
 static inline void _tlbiel_kernel_broadcast(void)
 {
-	on_each_cpu(do_tlbiel_kernel, NULL, 1);
+	smp_call(SMP_CALL_ALL, do_tlbiel_kernel, NULL, SMP_CALL_TYPE_SYNC);
 	if (tlbie_capable) {
 		/*
 		 * Coherent accelerators don't refcount kernel memory mappings,
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index fd2c77af5c55..5af924d35c3d 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -276,8 +276,8 @@ void flush_tlb_mm(struct mm_struct *mm)
 	if (!mm_is_core_local(mm)) {
 		struct tlb_flush_param p = { .pid = pid };
 		/* Ignores smp_processor_id() even if set. */
-		smp_call_function_many(mm_cpumask(mm),
-				       do_flush_tlb_mm_ipi, &p, 1);
+		smp_call_mask_others(mm_cpumask(mm),
+			       do_flush_tlb_mm_ipi, &p, SMP_CALL_TYPE_SYNC);
 	}
 	_tlbil_pid(pid);
  no_context:
@@ -321,8 +321,8 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 				.ind = ind,
 			};
 			/* Ignores smp_processor_id() even if set in cpu_mask */
-			smp_call_function_many(cpu_mask,
-					       do_flush_tlb_page_ipi, &p, 1);
+			smp_call_mask_others(cpu_mask,
+				       do_flush_tlb_page_ipi, &p, SMP_CALL_TYPE_SYNC);
 		}
 	}
 	_tlbil_va(vmaddr, pid, tsize, ind);
@@ -362,7 +362,8 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 #ifdef CONFIG_SMP
 	preempt_disable();
-	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, do_flush_tlb_mm_ipi,
+			NULL, SMP_CALL_TYPE_SYNC);
 	_tlbil_pid(0);
 	preempt_enable();
 #else
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index f42711f865f3..a597007d8cf4 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -464,7 +464,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 */
 		mm_ctx_set_slb_addr_limit(&mm->context, high_limit);
 
-		on_each_cpu(slice_flush_segments, mm, 1);
+		smp_call(SMP_CALL_ALL, slice_flush_segments, mm, SMP_CALL_TYPE_SYNC);
 	}
 
 	/* Sanity checks */
@@ -626,7 +626,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 !bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH))) {
 		slice_convert(mm, &potential_mask, psize);
 		if (psize > MMU_PAGE_BASE)
-			on_each_cpu(slice_flush_segments, mm, 1);
+			smp_call(SMP_CALL_ALL, slice_flush_segments, mm, SMP_CALL_TYPE_SYNC);
 	}
 	return newaddr;
 
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b5b42cf0a703..548dccc3efe1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2529,7 +2529,7 @@ static int __init init_ppc64_pmu(void)
 {
 	if (cpu_has_feature(CPU_FTR_HVMODE) && pmu_override) {
 		pr_warn("disabling perf due to pmu_override= command line option.\n");
-		on_each_cpu(do_pmu_override, NULL, 1);
+		smp_call(SMP_CALL_ALL, do_pmu_override, NULL, SMP_CALL_TYPE_SYNC);
 		return 0;
 	}
 
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 526d4b767534..6ecf8315e928 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1583,7 +1583,7 @@ static void thread_imc_ldbar_disable(void *dummy)
 
 void thread_imc_disable(void)
 {
-	on_each_cpu(thread_imc_ldbar_disable, NULL, 1);
+	smp_call(SMP_CALL_ALL, thread_imc_ldbar_disable, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void cleanup_all_thread_imc_memory(void)
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a1c6a7827c8f..4491ae39ca7a 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -445,7 +445,8 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 	int i, num_cpus = num_present_cpus();
 
 	if (image->type == KEXEC_TYPE_DEFAULT)
-		smp_call_function(mpc85xx_smp_kexec_down, NULL, 0);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, mpc85xx_smp_kexec_down,
+				NULL, SMP_CALL_TYPE_ASYNC);
 
 	while ( (atomic_read(&kexec_down_cpus) != (num_cpus - 1)) &&
 		( timeout > 0 ) )
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index a6677a111aca..5bc261517d08 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -202,7 +202,7 @@ static ssize_t store_fastsleep_workaround_applyonce(struct device *dev,
 	power7_fastsleep_workaround_exit = false;
 
 	cpus_read_lock();
-	on_each_cpu(pnv_fastsleep_workaround_apply, &err, 1);
+	smp_call(SMP_CALL_ALL, pnv_fastsleep_workaround_apply, &err, SMP_CALL_TYPE_SYNC);
 	cpus_read_unlock();
 	if (err) {
 		pr_err("fastsleep_workaround_applyonce change failed while running pnv_fastsleep_workaround_apply");
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 2119c003fcf9..3a5d31321366 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -61,7 +61,7 @@ static unsigned long get_purr(void)
 {
 	atomic64_t purr = ATOMIC64_INIT(0);
 
-	on_each_cpu(cpu_get_purr, &purr, 1);
+	smp_call(SMP_CALL_ALL, cpu_get_purr, &purr, SMP_CALL_TYPE_SYNC);
 
 	return atomic64_read(&purr);
 }
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..8d64bb39aff2 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -21,7 +21,7 @@ void flush_icache_all(void)
 	if (IS_ENABLED(CONFIG_RISCV_SBI))
 		sbi_remote_fence_i(NULL);
 	else
-		on_each_cpu(ipi_remote_fence_i, NULL, 1);
+		smp_call(SMP_CALL_ALL, ipi_remote_fence_i, NULL, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(flush_icache_all);
 
@@ -69,7 +69,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
 		sbi_remote_fence_i(&others);
 	} else {
-		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
+		smp_call_mask(&others, ipi_remote_fence_i, NULL, SMP_CALL_TYPE_SYNC);
 	}
 
 	preempt_enable();
diff --git a/arch/s390/hypfs/hypfs_diag0c.c b/arch/s390/hypfs/hypfs_diag0c.c
index 9a2786079e3a..f513e1529b6a 100644
--- a/arch/s390/hypfs/hypfs_diag0c.c
+++ b/arch/s390/hypfs/hypfs_diag0c.c
@@ -51,7 +51,7 @@ static void *diag0c_store(unsigned int *count)
 		cpu_vec[cpu] = &diag0c_data->entry[i++];
 	}
 	/* Collect data all CPUs */
-	on_each_cpu(diag0c_fn, cpu_vec, 1);
+	smp_call(SMP_CALL_ALL, diag0c_fn, cpu_vec, SMP_CALL_TYPE_SYNC);
 	*count = cpu_count;
 	kfree(cpu_vec);
 	cpus_read_unlock();
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index cce0ddee2d02..2c112748a785 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -121,7 +121,7 @@ static void do_sync_core(void *info)
 
 void text_poke_sync(void)
 {
-	on_each_cpu(do_sync_core, NULL, 1);
+	smp_call(SMP_CALL_ALL, do_sync_core, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 void text_poke_sync_lock(void)
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 483ab5e10164..5629b32a7f5a 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -923,7 +923,7 @@ static void cfset_all_stop(struct cfset_request *req)
 	};
 
 	cpumask_and(&req->mask, &req->mask, cpu_online_mask);
-	on_each_cpu_mask(&req->mask, cfset_ioctl_off, &p, 1);
+	smp_call_mask(&req->mask, cfset_ioctl_off, &p, SMP_CALL_TYPE_SYNC);
 }
 
 /* Release function is also called when application gets terminated without
@@ -940,7 +940,7 @@ static int cfset_release(struct inode *inode, struct file *file)
 		file->private_data = NULL;
 	}
 	if (!atomic_dec_return(&cfset_opencnt))
-		on_each_cpu(cfset_release_cpu, NULL, 1);
+		smp_call(SMP_CALL_ALL, cfset_release_cpu, NULL, SMP_CALL_TYPE_SYNC);
 	mutex_unlock(&cfset_ctrset_mutex);
 
 	hw_perf_event_destroy(NULL);
@@ -974,9 +974,9 @@ static int cfset_all_start(struct cfset_request *req)
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
 		return -ENOMEM;
 	cpumask_and(mask, &req->mask, cpu_online_mask);
-	on_each_cpu_mask(mask, cfset_ioctl_on, &p, 1);
+	smp_call_mask(mask, cfset_ioctl_on, &p, SMP_CALL_TYPE_SYNC);
 	if (atomic_read(&p.cpus_ack) != cpumask_weight(mask)) {
-		on_each_cpu_mask(mask, cfset_ioctl_off, &p, 1);
+		smp_call_mask(mask, cfset_ioctl_off, &p, SMP_CALL_TYPE_SYNC);
 		rc = -EIO;
 		debug_sprintf_event(cf_dbg, 4, "%s CPUs missing", __func__);
 	}
@@ -1100,7 +1100,7 @@ static int cfset_all_read(unsigned long arg, struct cfset_request *req)
 
 	p.sets = req->ctrset;
 	cpumask_and(mask, &req->mask, cpu_online_mask);
-	on_each_cpu_mask(mask, cfset_cpu_read, &p, 1);
+	smp_call_mask(mask, cfset_cpu_read, &p, SMP_CALL_TYPE_SYNC);
 	rc = cfset_all_copy(arg, mask);
 	free_cpumask_var(mask);
 	return rc;
diff --git a/arch/s390/kernel/perf_cpum_cf_common.c b/arch/s390/kernel/perf_cpum_cf_common.c
index 8ee48672233f..d46b6ee17485 100644
--- a/arch/s390/kernel/perf_cpum_cf_common.c
+++ b/arch/s390/kernel/perf_cpum_cf_common.c
@@ -105,7 +105,7 @@ int __kernel_cpumcf_begin(void)
 {
 	int flags = PMC_INIT;
 
-	on_each_cpu(cpum_cf_setup_cpu, &flags, 1);
+	smp_call(SMP_CALL_ALL, cpum_cf_setup_cpu, &flags, SMP_CALL_TYPE_SYNC);
 	irq_subclass_register(IRQ_SUBCLASS_MEASUREMENT_ALERT);
 
 	return 0;
@@ -131,7 +131,7 @@ void __kernel_cpumcf_end(void)
 {
 	int flags = PMC_RELEASE;
 
-	on_each_cpu(cpum_cf_setup_cpu, &flags, 1);
+	smp_call(SMP_CALL_ALL, cpum_cf_setup_cpu, &flags, SMP_CALL_TYPE_SYNC);
 	irq_subclass_unregister(IRQ_SUBCLASS_MEASUREMENT_ALERT);
 }
 EXPORT_SYMBOL(__kernel_cpumcf_end);
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..d0e1c7acb249 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -582,14 +582,14 @@ static void release_pmc_hardware(void)
 	int flags = PMC_RELEASE;
 
 	irq_subclass_unregister(IRQ_SUBCLASS_MEASUREMENT_ALERT);
-	on_each_cpu(setup_pmc_cpu, &flags, 1);
+	smp_call(SMP_CALL_ALL, setup_pmc_cpu, &flags, SMP_CALL_TYPE_SYNC);
 }
 
 static int reserve_pmc_hardware(void)
 {
 	int flags = PMC_INIT;
 
-	on_each_cpu(setup_pmc_cpu, &flags, 1);
+	smp_call(SMP_CALL_ALL, setup_pmc_cpu, &flags, SMP_CALL_TYPE_SYNC);
 	if (flags & PMC_FAILURE) {
 		release_pmc_hardware();
 		return -ENODEV;
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index aa0e0e7fc773..04c6f2a70483 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -62,7 +62,7 @@ void s390_update_cpu_mhz(void)
 {
 	s390_adjust_jiffies();
 	if (machine_has_cpu_mhz)
-		on_each_cpu(update_cpu_mhz, NULL, 0);
+		smp_call(SMP_CALL_ALL, update_cpu_mhz, NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 void notrace stop_machine_yield(const struct cpumask *cpumask)
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 30c91d565933..837e5f8a619c 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -595,7 +595,7 @@ void smp_ctl_set_clear_bit(int cr, int bit, bool set)
 	ctlreg = (ctlreg & parms.andval) | parms.orval;
 	put_abs_lowcore(cregs_save_area[cr], ctlreg);
 	spin_unlock(&ctl_lock);
-	on_each_cpu(smp_ctl_bit_callback, &parms, 1);
+	smp_call(SMP_CALL_ALL, smp_ctl_bit_callback, &parms, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(smp_ctl_set_clear_bit);
 
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index c6eecd4a5302..3df2a1f0c5fe 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -322,7 +322,7 @@ int arch_update_cpu_topology(void)
 	int cpu, rc;
 
 	rc = __arch_update_cpu_topology();
-	on_each_cpu(__arch_update_dedicated_flag, NULL, 0);
+	smp_call(SMP_CALL_ALL, __arch_update_dedicated_flag, NULL, SMP_CALL_TYPE_ASYNC);
 	for_each_online_cpu(cpu) {
 		dev = get_cpu_device(cpu);
 		if (dev)
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 2de48b2c1b04..f700843a703c 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -131,7 +131,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 
 	spin_unlock_bh(&mm->page_table_lock);
 
-	on_each_cpu(__crst_table_upgrade, mm, 0);
+	smp_call(SMP_CALL_ALL, __crst_table_upgrade, mm, SMP_CALL_TYPE_ASYNC);
 
 	return 0;
 
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 500cd2dbdf53..136af9f32f23 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -440,7 +440,7 @@ static int __init zpci_directed_irq_init(void)
 		if (!zpci_ibv[cpu])
 			return -ENOMEM;
 	}
-	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
+	smp_call(SMP_CALL_ALL, cpu_enable_directed_irq, NULL, SMP_CALL_TYPE_SYNC);
 
 	zpci_irq_chip.irq_set_affinity = zpci_set_irq_affinity;
 
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 65924d9ec245..9d7997499d51 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -263,7 +263,8 @@ void smp_send_reschedule(int cpu)
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, 0, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, stop_this_cpu,
+			NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
@@ -335,7 +336,7 @@ static void flush_tlb_all_ipi(void *info)
 
 void flush_tlb_all(void)
 {
-	on_each_cpu(flush_tlb_all_ipi, 0, 1);
+	smp_call(SMP_CALL_ALL, flush_tlb_all_ipi, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void flush_tlb_mm_ipi(void *mm)
@@ -360,7 +361,8 @@ void flush_tlb_mm(struct mm_struct *mm)
 	preempt_disable();
 
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
-		smp_call_function(flush_tlb_mm_ipi, (void *)mm, 1);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, flush_tlb_mm_ipi,
+				(void *)mm, SMP_CALL_TYPE_SYNC);
 	} else {
 		int i;
 		for_each_online_cpu(i)
@@ -397,7 +399,8 @@ void flush_tlb_range(struct vm_area_struct *vma,
 		fd.vma = vma;
 		fd.addr1 = start;
 		fd.addr2 = end;
-		smp_call_function(flush_tlb_range_ipi, (void *)&fd, 1);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, flush_tlb_range_ipi,
+				(void *)&fd, SMP_CALL_TYPE_SYNC);
 	} else {
 		int i;
 		for_each_online_cpu(i)
@@ -421,7 +424,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 
 	fd.addr1 = start;
 	fd.addr2 = end;
-	on_each_cpu(flush_tlb_kernel_range_ipi, (void *)&fd, 1);
+	smp_call(SMP_CALL_ALL, flush_tlb_kernel_range_ipi, (void *)&fd, SMP_CALL_TYPE_SYNC);
 }
 
 static void flush_tlb_page_ipi(void *info)
@@ -440,7 +443,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 
 		fd.vma = vma;
 		fd.addr1 = page;
-		smp_call_function(flush_tlb_page_ipi, (void *)&fd, 1);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, flush_tlb_page_ipi,
+				(void *)&fd, SMP_CALL_TYPE_SYNC);
 	} else {
 		int i;
 		for_each_online_cpu(i)
@@ -464,7 +468,8 @@ void flush_tlb_one(unsigned long asid, unsigned long vaddr)
 	fd.addr1 = asid;
 	fd.addr2 = vaddr;
 
-	smp_call_function(flush_tlb_one_ipi, (void *)&fd, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, flush_tlb_one_ipi,
+			(void *)&fd, SMP_CALL_TYPE_SYNC);
 	local_flush_tlb_one(asid, vaddr);
 }
 
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 3aef78ceb820..58215011a441 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -49,7 +49,8 @@ static inline void cacheop_on_each_cpu(void (*func) (void *info), void *info,
 	 * even attempt IPIs unless there are other CPUs online.
 	 */
 	if (num_online_cpus() > 1)
-		smp_call_function(func, info, wait);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, func, info,
+			(wait ? SMP_CALL_TYPE_SYNC : SMP_CALL_TYPE_ASYNC));
 #endif
 
 	func(info);
diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index 274217e7ed70..038099bcabea 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -37,8 +37,8 @@ static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
 			regs = task_pt_regs(current);
 			regs->tstate |= TSTATE_MCDE;
 			current->mm->context.adi = true;
-			on_each_cpu_mask(mm_cpumask(current->mm),
-					 ipi_set_tstate_mcde, current->mm, 0);
+			smp_call_mask(mm_cpumask(current->mm),
+				ipi_set_tstate_mcde, current->mm, SMP_CALL_TYPE_ASYNC);
 		}
 		return VM_SPARC_ADI;
 	} else {
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 060fff95a305..cffec7822e7c 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -176,7 +176,8 @@ static int __init check_nmi_watchdog(void)
 
 	printk(KERN_INFO "Testing NMI watchdog ... ");
 
-	smp_call_function(nmi_cpu_busy, (void *)&endflag, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, nmi_cpu_busy,
+			(void *)&endflag, SMP_CALL_TYPE_ASYNC);
 
 	for_each_possible_cpu(cpu)
 		prev_nmi_count[cpu] = get_nmi_count(cpu);
@@ -203,7 +204,7 @@ static int __init check_nmi_watchdog(void)
 	kfree(prev_nmi_count);
 	return 0;
 error:
-	on_each_cpu(stop_nmi_watchdog, NULL, 1);
+	smp_call(SMP_CALL_ALL, stop_nmi_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 	return err;
 }
 
@@ -235,13 +236,13 @@ static void nmi_adjust_hz_one(void *unused)
 void nmi_adjust_hz(unsigned int new_hz)
 {
 	nmi_hz = new_hz;
-	on_each_cpu(nmi_adjust_hz_one, NULL, 1);
+	smp_call(SMP_CALL_ALL, nmi_adjust_hz_one, NULL, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL_GPL(nmi_adjust_hz);
 
 static int nmi_shutdown(struct notifier_block *nb, unsigned long cmd, void *p)
 {
-	on_each_cpu(stop_nmi_watchdog, NULL, 1);
+	smp_call(SMP_CALL_ALL, stop_nmi_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 	return 0;
 }
 
@@ -253,13 +254,13 @@ int __init nmi_init(void)
 {
 	int err;
 
-	on_each_cpu(start_nmi_watchdog, NULL, 1);
+	smp_call(SMP_CALL_ALL, start_nmi_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 
 	err = check_nmi_watchdog();
 	if (!err) {
 		err = register_reboot_notifier(&nmi_reboot_notifier);
 		if (err) {
-			on_each_cpu(stop_nmi_watchdog, NULL, 1);
+			smp_call(SMP_CALL_ALL, stop_nmi_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 			atomic_set(&nmi_active, -1);
 		}
 	}
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index a58ae9c42803..a843eb4a0f2c 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1176,7 +1176,7 @@ static void perf_event_grab_pmc(void)
 	mutex_lock(&pmc_grab_mutex);
 	if (atomic_read(&active_events) == 0) {
 		if (atomic_read(&nmi_active) > 0) {
-			on_each_cpu(perf_stop_nmi_watchdog, NULL, 1);
+			smp_call(SMP_CALL_ALL, perf_stop_nmi_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 			BUG_ON(atomic_read(&nmi_active) != 0);
 		}
 		atomic_inc(&active_events);
@@ -1188,7 +1188,7 @@ static void perf_event_release_pmc(void)
 {
 	if (atomic_dec_and_mutex_lock(&active_events, &pmc_grab_mutex)) {
 		if (atomic_read(&nmi_active) == 0)
-			on_each_cpu(start_nmi_watchdog, NULL, 1);
+			smp_call(SMP_CALL_ALL, start_nmi_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 		mutex_unlock(&pmc_grab_mutex);
 	}
 }
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index a1f78e9ddaf3..4c945f49fee5 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -901,7 +901,7 @@ static void tsb_sync(void *info)
 
 void smp_tsb_sync(struct mm_struct *mm)
 {
-	smp_call_function_many(mm_cpumask(mm), tsb_sync, mm, 1);
+	smp_call_mask_others(mm_cpumask(mm), tsb_sync, mm, SMP_CALL_TYPE_SYNC);
 }
 
 extern unsigned long xcall_flush_tlb_mm;
@@ -1084,8 +1084,8 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 	info.nr = nr;
 	info.vaddrs = vaddrs;
 
-	smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
-			       &info, 1);
+	smp_call_mask_others(mm_cpumask(mm), tlb_pending_func,
+		       &info, SMP_CALL_TYPE_SYNC);
 
 	__flush_tlb_pending(ctx, nr, vaddrs);
 
@@ -1523,7 +1523,8 @@ void smp_send_stop(void)
 				prom_stopcpu_cpuid(cpu);
 		}
 	} else
-		smp_call_function(stop_this_cpu, NULL, 0);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, stop_this_cpu,
+				NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 8b1911591581..dca8c077c8ad 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -3024,7 +3024,7 @@ void hugetlb_setup(struct pt_regs *regs)
 		spin_unlock_irq(&ctx_alloc_lock);
 
 		if (need_context_reload)
-			on_each_cpu(context_reload, mm, 0);
+			smp_call(SMP_CALL_ALL, context_reload, mm, SMP_CALL_TYPE_ASYNC);
 	}
 }
 #endif
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index eef816fc216d..03515ba1f36a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2526,7 +2526,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	mmap_assert_write_locked(mm);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
-		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
+		smp_call_mask(mm_cpumask(mm), cr4_update_pce, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
@@ -2535,7 +2535,7 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 		return;
 
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
-		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
+		smp_call_mask(mm_cpumask(mm), cr4_update_pce, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static int x86_pmu_event_idx(struct perf_event *event)
@@ -2591,7 +2591,7 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 		else if (x86_pmu.attr_rdpmc == 2)
 			static_branch_dec(&rdpmc_always_available_key);
 
-		on_each_cpu(cr4_update_pce, NULL, 1);
+		smp_call(SMP_CALL_ALL, cr4_update_pce, NULL, SMP_CALL_TYPE_SYNC);
 		x86_pmu.attr_rdpmc = val;
 	}
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fc7f458eb3de..2e94f33d1aab 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5123,7 +5123,7 @@ static ssize_t freeze_on_smi_store(struct device *cdev,
 	x86_pmu.attr_freeze_on_smi = val;
 
 	cpus_read_lock();
-	on_each_cpu(flip_smm_bit, &val, 1);
+	smp_call(SMP_CALL_ALL, flip_smm_bit, &val, SMP_CALL_TYPE_SYNC);
 	cpus_read_unlock();
 done:
 	mutex_unlock(&freeze_on_smi_mutex);
@@ -5168,7 +5168,7 @@ static ssize_t set_sysctl_tfa(struct device *cdev,
 	allow_tsx_force_abort = val;
 
 	cpus_read_lock();
-	on_each_cpu(update_tfa_sched, NULL, 1);
+	smp_call(SMP_CALL_ALL, update_tfa_sched, NULL, SMP_CALL_TYPE_SYNC);
 	cpus_read_unlock();
 
 	return count;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d374cb3cf024..b8d93fb7c33b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1181,7 +1181,7 @@ static void do_sync_core(void *info)
 
 void text_poke_sync(void)
 {
-	on_each_cpu(do_sync_core, NULL, 1);
+	smp_call(SMP_CALL_ALL, do_sync_core, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 struct text_poke_loc {
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 020c906f7934..4edc11afcd78 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -488,7 +488,7 @@ static __init void fix_erratum_688(void)
 	if (val & BIT(2))
 		return;
 
-	on_each_cpu(__fix_erratum_688, NULL, 0);
+	smp_call(SMP_CALL_ALL, __fix_erratum_688, NULL, SMP_CALL_TYPE_ASYNC);
 
 	pr_info("x86/cpu/AMD: CPU erratum 688 worked around\n");
 }
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344bf6600..87a68837db30 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -656,7 +656,7 @@ void lapic_update_tsc_freq(void)
 	 * changed. In order to avoid races, schedule the frequency
 	 * update code on each CPU.
 	 */
-	on_each_cpu(__lapic_update_tsc_freq, NULL, 0);
+	smp_call(SMP_CALL_ALL, __lapic_update_tsc_freq, NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1ebed1d..a6806b73f7e3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1091,7 +1091,7 @@ static void update_stibp_strict(void)
 	pr_info("Update user space SMT mitigation: STIBP %s\n",
 		mask & SPEC_CTRL_STIBP ? "always-on" : "off");
 	x86_spec_ctrl_base = mask;
-	on_each_cpu(update_stibp_msr, NULL, 1);
+	smp_call(SMP_CALL_ALL, update_stibp_msr, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 /* Update the static key controlling the evaluation of TIF_SPEC_IB */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 981496e6bc0e..e8ddca5aacf1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2207,7 +2207,7 @@ void mce_disable_bank(int bank)
 		return;
 	}
 	set_bit(bank, mce_banks_ce_disabled);
-	on_each_cpu(__mce_disable_bank, &bank, 1);
+	smp_call(SMP_CALL_ALL, __mce_disable_bank, &bank, SMP_CALL_TYPE_SYNC);
 }
 
 /*
@@ -2362,7 +2362,7 @@ static void mce_cpu_restart(void *data)
 static void mce_restart(void)
 {
 	mce_timer_delete_all();
-	on_each_cpu(mce_cpu_restart, NULL, 1);
+	smp_call(SMP_CALL_ALL, mce_cpu_restart, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 /* Toggle features for corrected errors */
@@ -2450,12 +2450,12 @@ static ssize_t set_ignore_ce(struct device *s,
 		if (new) {
 			/* disable ce features */
 			mce_timer_delete_all();
-			on_each_cpu(mce_disable_cmci, NULL, 1);
+			smp_call(SMP_CALL_ALL, mce_disable_cmci, NULL, SMP_CALL_TYPE_SYNC);
 			mca_cfg.ignore_ce = true;
 		} else {
 			/* enable ce features */
 			mca_cfg.ignore_ce = false;
-			on_each_cpu(mce_enable_ce, (void *)1, 1);
+			smp_call(SMP_CALL_ALL, mce_enable_ce, (void *)1, SMP_CALL_TYPE_SYNC);
 		}
 	}
 	mutex_unlock(&mce_sysfs_mutex);
@@ -2476,12 +2476,12 @@ static ssize_t set_cmci_disabled(struct device *s,
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
-			on_each_cpu(mce_disable_cmci, NULL, 1);
+			smp_call(SMP_CALL_ALL, mce_disable_cmci, NULL, SMP_CALL_TYPE_SYNC);
 			mca_cfg.cmci_disabled = true;
 		} else {
 			/* enable cmci */
 			mca_cfg.cmci_disabled = false;
-			on_each_cpu(mce_enable_ce, NULL, 1);
+			smp_call(SMP_CALL_ALL, mce_enable_ce, NULL, SMP_CALL_TYPE_SYNC);
 		}
 	}
 	mutex_unlock(&mce_sysfs_mutex);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5fbd7ffb3233..e7d5ad9d62b6 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -264,8 +264,8 @@ static void __maybe_unused raise_mce(struct mce *m)
 				 * to be sync with following raise_local
 				 */
 				preempt_disable();
-				smp_call_function_many(mce_inject_cpumask,
-					mce_irq_ipi, NULL, 0);
+				smp_call_mask_others(mce_inject_cpumask,
+					mce_irq_ipi, NULL, SMP_CALL_TYPE_ASYNC);
 				preempt_enable();
 			} else if (m->inject_flags & MCJ_NMI_BROADCAST)
 				apic->send_IPI_mask(mce_inject_cpumask,
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..787dfc787336 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -400,7 +400,7 @@ void cmci_rediscover(void)
 	if (!cmci_supported(&banks))
 		return;
 
-	on_each_cpu(cmci_rediscover_work_func, NULL, 1);
+	smp_call(SMP_CALL_ALL, cmci_rediscover_work_func, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index f2dd4f29af27..a8a5df0828b1 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -326,7 +326,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		rdt_ctrl_update(&msr_param);
 	/* Update resource control msr on other CPUs. */
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
+	smp_call_mask_others(cpu_mask, rdt_ctrl_update, &msr_param, SMP_CALL_TYPE_SYNC);
 	put_cpu();
 
 done:
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 83f901e2c2df..c6f02d1f0673 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -329,7 +329,7 @@ update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
 
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		update_cpu_closid_rmid(r);
-	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);
+	smp_call_mask_others(cpu_mask, update_cpu_closid_rmid, r, SMP_CALL_TYPE_SYNC);
 	put_cpu();
 }
 
@@ -1866,7 +1866,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		update(&enable);
 	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */
-	smp_call_function_many(cpu_mask, update, &enable, 1);
+	smp_call_mask_others(cpu_mask, update, &enable, SMP_CALL_TYPE_SYNC);
 	put_cpu();
 
 	free_cpumask_var(cpu_mask);
@@ -2335,7 +2335,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		rdt_ctrl_update(&msr_param);
 	/* Update CBM on all other cpus in cpu_mask. */
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
+	smp_call_mask_others(cpu_mask, rdt_ctrl_update, &msr_param, SMP_CALL_TYPE_SYNC);
 	put_cpu();
 
 	free_cpumask_var(cpu_mask);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 8e4bc6453d26..67bdfe2c3069 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -278,8 +278,9 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 			 * miss cpus that entered the enclave between
 			 * generating the mask and incrementing epoch.
 			 */
-			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
-					 sgx_ipi_cb, NULL, 1);
+			smp_call_mask(sgx_encl_ewb_cpumask(encl),
+				 sgx_ipi_cb, NULL, SMP_CALL_TYPE_SYNC);
+
 			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
 		}
 	}
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index ec8064c0ae03..86a9dd98d596 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -120,7 +120,7 @@ static inline void umwait_update_control(u32 maxtime, bool c02_enable)
 
 	WRITE_ONCE(umwait_control_cached, ctrl);
 	/* Propagate to all CPUs */
-	on_each_cpu(umwait_update_control_msr, NULL, 1);
+	smp_call(SMP_CALL_ALL, umwait_update_control_msr, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static ssize_t
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c04b933f48d3..741e49bfaa1f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -282,7 +282,7 @@ static int vmware_pv_reboot_notify(struct notifier_block *nb,
 				unsigned long code, void *unused)
 {
 	if (code == SYS_RESTART)
-		on_each_cpu(vmware_pv_guest_cpu_reboot, NULL, 1);
+		smp_call(SMP_CALL_ALL, vmware_pv_guest_cpu_reboot, NULL, SMP_CALL_TYPE_SYNC);
 	return NOTIFY_DONE;
 }
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 8b1c45c9cda8..9f1623917322 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -743,7 +743,7 @@ static int kvm_pv_reboot_notify(struct notifier_block *nb,
 				unsigned long code, void *unused)
 {
 	if (code == SYS_RESTART)
-		on_each_cpu(kvm_pv_guest_cpu_reboot, NULL, 1);
+		smp_call(SMP_CALL_ALL, kvm_pv_guest_cpu_reboot, NULL, SMP_CALL_TYPE_SYNC);
 	return NOTIFY_DONE;
 }
 
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 525876e7b9f4..3243e2507d73 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -424,7 +424,7 @@ static void install_ldt(struct mm_struct *mm, struct ldt_struct *ldt)
 	smp_store_release(&mm->context.ldt, ldt);
 
 	/* Activate the LDT for all CPUs using currents mm. */
-	on_each_cpu_mask(mm_cpumask(mm), flush_ldt, mm, true);
+	smp_call_mask(mm_cpumask(mm), flush_ldt, mm, SMP_CALL_TYPE_SYNC);
 
 	mutex_unlock(&mm->context.lock);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4790f0d7d40b..691cbf38304c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7442,8 +7442,8 @@ static int kvm_emulate_wbinvd_noskip(struct kvm_vcpu *vcpu)
 		int cpu = get_cpu();
 
 		cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
-		on_each_cpu_mask(vcpu->arch.wbinvd_dirty_mask,
-				wbinvd_ipi, NULL, 1);
+		smp_call_mask(vcpu->arch.wbinvd_dirty_mask,
+				wbinvd_ipi, NULL, SMP_CALL_TYPE_SYNC);
 		put_cpu();
 		cpumask_clear(vcpu->arch.wbinvd_dirty_mask);
 	} else
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 7c48ff4ae8d1..20d00dc2bb8c 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -15,7 +15,7 @@ EXPORT_SYMBOL(wbinvd_on_cpu);
 
 int wbinvd_on_all_cpus(void)
 {
-	on_each_cpu(__wbinvd, NULL, 1);
+	smp_call(SMP_CALL_ALL, __wbinvd, NULL, SMP_CALL_TYPE_SYNC);
 	return 0;
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 40bbe56bde32..cbe2874835f3 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -113,7 +113,7 @@ static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
 	if (cpumask_test_cpu(this_cpu, mask))
 		msr_func(&rv);
 
-	smp_call_function_many(mask, msr_func, &rv, 1);
+	smp_call_mask_others(mask, msr_func, &rv, SMP_CALL_TYPE_SYNC);
 	put_cpu();
 }
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 0656db33574d..5f65746b6fc0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -348,7 +348,7 @@ static void cpa_flush_all(unsigned long cache)
 {
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
+	smp_call(SMP_CALL_ALL, __cpa_flush_all, (void *) cache, SMP_CALL_TYPE_SYNC);
 }
 
 static void __cpa_flush_tlb(void *data)
@@ -375,7 +375,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
 		flush_tlb_all();
 	else
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
+		smp_call(SMP_CALL_ALL, __cpa_flush_tlb, cpa, SMP_CALL_TYPE_SYNC);
 
 	if (!cache)
 		return;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d400b6d9d246..8771ca98af7b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -889,10 +889,10 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * doing a speculative memory access.
 	 */
 	if (info->freed_tables)
-		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
+		smp_call_mask(cpumask, flush_tlb_func, (void *)info, SMP_CALL_TYPE_SYNC);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
-				(void *)info, 1, cpumask);
+		smp_call_mask_cond(cpumask, flush_tlb_func, (void *)info,
+				tlb_is_not_lazy, SMP_CALL_TYPE_SYNC);
 }
 
 void flush_tlb_multi(const struct cpumask *cpumask,
@@ -1006,7 +1006,7 @@ static void do_flush_tlb_all(void *info)
 void flush_tlb_all(void)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
-	on_each_cpu(do_flush_tlb_all, NULL, 1);
+	smp_call(SMP_CALL_ALL, do_flush_tlb_all, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void do_kernel_range_flush(void *info)
@@ -1024,14 +1024,14 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	/* Balance as user space task's flush, a bit conservative */
 	if (end == TLB_FLUSH_ALL ||
 	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
+		smp_call(SMP_CALL_ALL, do_flush_tlb_all, NULL, SMP_CALL_TYPE_SYNC);
 	} else {
 		struct flush_tlb_info *info;
 
 		preempt_disable();
 		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
 
-		on_each_cpu(do_kernel_range_flush, info, 1);
+		smp_call(SMP_CALL_ALL, do_kernel_range_flush, info, SMP_CALL_TYPE_SYNC);
 
 		put_flush_tlb_info();
 		preempt_enable();
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 00354866921b..ec37a4d2c0f9 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -948,7 +948,7 @@ static void xen_drop_mm_ref(struct mm_struct *mm)
 			cpumask_set_cpu(cpu, mask);
 	}
 
-	smp_call_function_many(mask, drop_mm_ref_this_cpu, mm, 1);
+	smp_call_mask_others(mask, drop_mm_ref_this_cpu, mm, SMP_CALL_TYPE_SYNC);
 	free_cpumask_var(mask);
 }
 #else
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 688aa8b6ae29..ab58eee9a5d3 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -428,7 +428,8 @@ static void stop_self(void *v)
 
 static void xen_pv_stop_other_cpus(int wait)
 {
-	smp_call_function(stop_self, NULL, wait);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, stop_self, NULL,
+			(wait ? SMP_CALL_TYPE_SYNC : SMP_CALL_TYPE_ASYNC));
 }
 
 static irqreturn_t xen_irq_work_interrupt(int irq, void *dev_id)
diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 1d83152c761b..94abd0bb7a26 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -67,7 +67,7 @@ void xen_arch_resume(void)
 {
 	int cpu;
 
-	on_each_cpu(xen_vcpu_notify_restore, NULL, 1);
+	smp_call(SMP_CALL_ALL, xen_vcpu_notify_restore, NULL, SMP_CALL_TYPE_SYNC);
 
 	for_each_online_cpu(cpu)
 		xen_pmu_init(cpu);
@@ -80,5 +80,5 @@ void xen_arch_suspend(void)
 	for_each_online_cpu(cpu)
 		xen_pmu_finish(cpu);
 
-	on_each_cpu(xen_vcpu_notify_suspend, NULL, 1);
+	smp_call(SMP_CALL_ALL, xen_vcpu_notify_suspend, NULL, SMP_CALL_TYPE_SYNC);
 }
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 1254da07ead1..5878ba8f0274 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -470,7 +470,7 @@ static void ipi_flush_tlb_all(void *arg)
 
 void flush_tlb_all(void)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_tlb_all, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void ipi_flush_tlb_mm(void *arg)
@@ -480,7 +480,7 @@ static void ipi_flush_tlb_mm(void *arg)
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	on_each_cpu(ipi_flush_tlb_mm, mm, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_tlb_mm, mm, SMP_CALL_TYPE_SYNC);
 }
 
 static void ipi_flush_tlb_page(void *arg)
@@ -495,7 +495,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 		.vma = vma,
 		.addr1 = addr,
 	};
-	on_each_cpu(ipi_flush_tlb_page, &fd, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_tlb_page, &fd, SMP_CALL_TYPE_SYNC);
 }
 
 static void ipi_flush_tlb_range(void *arg)
@@ -512,7 +512,7 @@ void flush_tlb_range(struct vm_area_struct *vma,
 		.addr1 = start,
 		.addr2 = end,
 	};
-	on_each_cpu(ipi_flush_tlb_range, &fd, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_tlb_range, &fd, SMP_CALL_TYPE_SYNC);
 }
 
 static void ipi_flush_tlb_kernel_range(void *arg)
@@ -527,7 +527,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		.addr1 = start,
 		.addr2 = end,
 	};
-	on_each_cpu(ipi_flush_tlb_kernel_range, &fd, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_tlb_kernel_range, &fd, SMP_CALL_TYPE_SYNC);
 }
 
 /* Cache flush functions */
@@ -539,7 +539,7 @@ static void ipi_flush_cache_all(void *arg)
 
 void flush_cache_all(void)
 {
-	on_each_cpu(ipi_flush_cache_all, NULL, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_cache_all, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void ipi_flush_cache_page(void *arg)
@@ -556,7 +556,7 @@ void flush_cache_page(struct vm_area_struct *vma,
 		.addr1 = address,
 		.addr2 = pfn,
 	};
-	on_each_cpu(ipi_flush_cache_page, &fd, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_cache_page, &fd, SMP_CALL_TYPE_SYNC);
 }
 
 static void ipi_flush_cache_range(void *arg)
@@ -573,7 +573,7 @@ void flush_cache_range(struct vm_area_struct *vma,
 		.addr1 = start,
 		.addr2 = end,
 	};
-	on_each_cpu(ipi_flush_cache_range, &fd, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_cache_range, &fd, SMP_CALL_TYPE_SYNC);
 }
 
 static void ipi_flush_icache_range(void *arg)
@@ -588,7 +588,7 @@ void flush_icache_range(unsigned long start, unsigned long end)
 		.addr1 = start,
 		.addr2 = end,
 	};
-	on_each_cpu(ipi_flush_icache_range, &fd, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_icache_range, &fd, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(flush_icache_range);
 
@@ -607,7 +607,7 @@ static void system_invalidate_dcache_range(unsigned long start,
 		.addr1 = start,
 		.addr2 = size,
 	};
-	on_each_cpu(ipi_invalidate_dcache_range, &fd, 1);
+	smp_call(SMP_CALL_ALL, ipi_invalidate_dcache_range, &fd, SMP_CALL_TYPE_SYNC);
 }
 
 static void ipi_flush_invalidate_dcache_range(void *arg)
@@ -623,5 +623,5 @@ static void system_flush_invalidate_dcache_range(unsigned long start,
 		.addr1 = start,
 		.addr2 = size,
 	};
-	on_each_cpu(ipi_flush_invalidate_dcache_range, &fd, 1);
+	smp_call(SMP_CALL_ALL, ipi_flush_invalidate_dcache_range, &fd, SMP_CALL_TYPE_SYNC);
 }
diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 3ffbb1c80c5c..dddb96754e0b 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -1308,7 +1308,7 @@ static void ipi_handler(void *null)
 
 void global_cache_flush(void)
 {
-	on_each_cpu(ipi_handler, NULL, 1);
+	smp_call(SMP_CALL_ALL, ipi_handler, NULL, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(global_cache_flush);
 
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index be4175f415ba..3f0566027bf6 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -130,7 +130,7 @@ static int gic_clk_notifier(struct notifier_block *nb, unsigned long action,
 
 	if (action == POST_RATE_CHANGE) {
 		gic_clocksource_unstable("ref clock rate change");
-		on_each_cpu(gic_update_frequency, (void *)cnd->new_rate, 1);
+		smp_call(SMP_CALL_ALL, gic_update_frequency, (void *)cnd->new_rate, SMP_CALL_TYPE_SYNC);
 	}
 
 	return NOTIFY_OK;
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 9bbb4b9391f8..b6ade5348c7f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -129,8 +129,8 @@ static void boost_set_msr_each(void *p_en)
 
 static int set_boost(struct cpufreq_policy *policy, int val)
 {
-	on_each_cpu_mask(policy->cpus, boost_set_msr_each,
-			 (void *)(long)val, 1);
+	smp_call_mask(policy->cpus, boost_set_msr_each,
+			(void *)(long)val, SMP_CALL_TYPE_SYNC);
 	pr_debug("CPU %*pbl: Core Boosting %sabled.\n",
 		 cpumask_pr_args(policy->cpus), val ? "en" : "dis");
 
@@ -345,7 +345,7 @@ static void drv_write(struct acpi_cpufreq_data *data,
 	if (cpumask_test_cpu(this_cpu, mask))
 		do_drv_write(&cmd);
 
-	smp_call_function_many(mask, do_drv_write, &cmd, 1);
+	smp_call_mask_others(mask, do_drv_write, &cmd, SMP_CALL_TYPE_SYNC);
 	put_cpu();
 }
 
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index ac381db25dbe..99fc456f16b6 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -265,7 +265,7 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 	 * in a cluster run at same frequency which is the maximum frequency
 	 * request out of the values requested by both cores in that cluster.
 	 */
-	on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);
+	smp_call_mask(policy->cpus, set_cpu_ndiv, tbl, SMP_CALL_TYPE_SYNC);
 
 	return 0;
 }
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index f70aa17e2a8e..a7e6f95e6a9c 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -225,8 +225,8 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 		return ret;
 
 	if (drv->bctimer)
-		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
-				 (void *)1, 1);
+		smp_call_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
+				 (void *)1, SMP_CALL_TYPE_SYNC);
 
 	return 0;
 }
@@ -244,8 +244,8 @@ static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
 	if (drv->bctimer) {
 		drv->bctimer = 0;
-		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
-				 NULL, 1);
+		smp_call_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
+				 NULL, SMP_CALL_TYPE_SYNC);
 	}
 
 	__cpuidle_unset_driver(drv);
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 812baa48b290..69038cd22924 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -793,7 +793,7 @@ static ssize_t inject_write_store(struct device *dev,
 			"/sys/bus/machinecheck/devices/machinecheck<CPUNUM>/check_interval\n"
 			"so that you can get the error report faster.\n");
 
-	on_each_cpu(disable_caches, NULL, 1);
+	smp_call(SMP_CALL_ALL, disable_caches, NULL, SMP_CALL_TYPE_SYNC);
 
 	/* Issue 'word' and 'bit' along with the READ request */
 	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_DATA, word_bits);
@@ -806,7 +806,7 @@ static ssize_t inject_write_store(struct device *dev,
 		goto retry;
 	}
 
-	on_each_cpu(enable_caches, NULL, 1);
+	smp_call(SMP_CALL_ALL, enable_caches, NULL, SMP_CALL_TYPE_SYNC);
 
 	edac_dbg(0, "section=0x%x word_bits=0x%x\n", section, word_bits);
 
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1e1a51510e83..691408efb912 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -101,7 +101,7 @@ static inline int sdei_do_cross_call(smp_call_func_t fn,
 	struct sdei_crosscall_args arg;
 
 	CROSSCALL_INIT(arg, event);
-	on_each_cpu(fn, &arg, true);
+	smp_call(SMP_CALL_ALL, fn, &arg, SMP_CALL_TYPE_SYNC);
 
 	return arg.first_error;
 }
@@ -359,7 +359,7 @@ static int sdei_api_shared_reset(void)
 static void sdei_mark_interface_broken(void)
 {
 	pr_err("disabling SDEI firmware interface\n");
-	on_each_cpu(&_ipi_mask_cpu, NULL, true);
+	smp_call(SMP_CALL_ALL, &_ipi_mask_cpu, NULL, SMP_CALL_TYPE_SYNC);
 	sdei_firmware_call = NULL;
 }
 
@@ -367,7 +367,7 @@ static int sdei_platform_reset(void)
 {
 	int err;
 
-	on_each_cpu(&_ipi_private_reset, NULL, true);
+	smp_call(SMP_CALL_ALL, &_ipi_private_reset, NULL, SMP_CALL_TYPE_SYNC);
 	err = sdei_api_shared_reset();
 	if (err) {
 		pr_err("Failed to reset platform: %d\n", err);
@@ -741,14 +741,14 @@ static struct notifier_block sdei_pm_nb = {
 
 static int sdei_device_suspend(struct device *dev)
 {
-	on_each_cpu(_ipi_mask_cpu, NULL, true);
+	smp_call(SMP_CALL_ALL, _ipi_mask_cpu, NULL, SMP_CALL_TYPE_SYNC);
 
 	return 0;
 }
 
 static int sdei_device_resume(struct device *dev)
 {
-	on_each_cpu(_ipi_unmask_cpu, NULL, true);
+	smp_call(SMP_CALL_ALL, _ipi_unmask_cpu, NULL, SMP_CALL_TYPE_SYNC);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/vlv_sideband.c b/drivers/gpu/drm/i915/vlv_sideband.c
index c26001300ebd..09a261d8af80 100644
--- a/drivers/gpu/drm/i915/vlv_sideband.c
+++ b/drivers/gpu/drm/i915/vlv_sideband.c
@@ -42,7 +42,7 @@ static void __vlv_punit_get(struct drm_i915_private *i915)
 	 */
 	if (IS_VALLEYVIEW(i915)) {
 		cpu_latency_qos_update_request(&i915->sb_qos, 0);
-		on_each_cpu(ping, NULL, 1);
+		smp_call(SMP_CALL_ALL, ping, NULL, SMP_CALL_TYPE_SYNC);
 	}
 }
 
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 521534d5c1e5..25bf112c9aa0 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -188,7 +188,7 @@ static int read_registers(struct fam15h_power_data *data)
 		cpumask_set_cpu(cpumask_any(topology_sibling_cpumask(cpu)), mask);
 	}
 
-	on_each_cpu_mask(mask, do_read_registers_on_cu, data, true);
+	smp_call_mask(mask, do_read_registers_on_cu, data, SMP_CALL_TYPE_SYNC);
 
 	cpus_read_unlock();
 	free_cpumask_var(mask);
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index ef3d3646ccc2..c000fd1be945 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -160,7 +160,7 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	irq_set_chained_handler(pic->parent_irq, mvebu_pic_handle_cascade_irq);
 	irq_set_handler_data(pic->parent_irq, pic);
 
-	on_each_cpu(mvebu_pic_enable_percpu_irq, pic, 1);
+	smp_call(SMP_CALL_ALL, mvebu_pic_enable_percpu_irq, pic, SMP_CALL_TYPE_SYNC);
 
 	platform_set_drvdata(pdev, pic);
 
@@ -171,7 +171,7 @@ static int mvebu_pic_remove(struct platform_device *pdev)
 {
 	struct mvebu_pic *pic = platform_get_drvdata(pdev);
 
-	on_each_cpu(mvebu_pic_disable_percpu_irq, pic, 1);
+	smp_call(SMP_CALL_ALL, mvebu_pic_disable_percpu_irq, pic, SMP_CALL_TYPE_SYNC);
 	irq_domain_remove(pic->domain);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 934f6dd90992..77042499baa4 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1473,10 +1473,10 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 	int max_cpu = num_present_cpus();
 
 	/* Clear all Cause registers */
-	on_each_cpu(mvneta_percpu_clear_intr_cause, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_clear_intr_cause, pp, SMP_CALL_TYPE_SYNC);
 
 	/* Mask all interrupts */
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_mask_interrupt, pp, SMP_CALL_TYPE_SYNC);
 	mvreg_write(pp, MVNETA_INTR_ENABLE, 0);
 
 	/* Enable MBUS Retry bit16 */
@@ -3704,7 +3704,7 @@ static void mvneta_start_dev(struct mvneta_port *pp)
 	}
 
 	/* Unmask interrupts. It has to be done from each CPU */
-	on_each_cpu(mvneta_percpu_unmask_interrupt, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_unmask_interrupt, pp, SMP_CALL_TYPE_SYNC);
 
 	mvreg_write(pp, MVNETA_INTR_MISC_MASK,
 		    MVNETA_CAUSE_PHY_STATUS_CHANGE |
@@ -3751,10 +3751,10 @@ static void mvneta_stop_dev(struct mvneta_port *pp)
 	mvneta_port_disable(pp);
 
 	/* Clear all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_clear_intr_cause, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_clear_intr_cause, pp, SMP_CALL_TYPE_SYNC);
 
 	/* Mask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_mask_interrupt, pp, SMP_CALL_TYPE_SYNC);
 
 	mvneta_tx_reset(pp);
 	mvneta_rx_reset(pp);
@@ -3811,7 +3811,7 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 	 * reallocation of the queues
 	 */
 	mvneta_stop_dev(pp);
-	on_each_cpu(mvneta_percpu_disable, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_disable, pp, SMP_CALL_TYPE_SYNC);
 
 	mvneta_cleanup_txqs(pp);
 	mvneta_cleanup_rxqs(pp);
@@ -3833,7 +3833,7 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 		return ret;
 	}
 
-	on_each_cpu(mvneta_percpu_enable, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_enable, pp, SMP_CALL_TYPE_SYNC);
 	mvneta_start_dev(pp);
 
 	netdev_update_features(dev);
@@ -4349,7 +4349,7 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
 	}
 
 	/* Mask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_mask_interrupt, pp, SMP_CALL_TYPE_SYNC);
 	napi_enable(&port->napi);
 
 	/*
@@ -4365,7 +4365,7 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
 	mvneta_percpu_elect(pp);
 
 	/* Unmask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_unmask_interrupt, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_unmask_interrupt, pp, SMP_CALL_TYPE_SYNC);
 	mvreg_write(pp, MVNETA_INTR_MISC_MASK,
 		    MVNETA_CAUSE_PHY_STATUS_CHANGE |
 		    MVNETA_CAUSE_LINK_CHANGE);
@@ -4386,7 +4386,7 @@ static int mvneta_cpu_down_prepare(unsigned int cpu, struct hlist_node *node)
 	 */
 	spin_lock(&pp->lock);
 	/* Mask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_mask_interrupt, pp, SMP_CALL_TYPE_SYNC);
 	spin_unlock(&pp->lock);
 
 	napi_synchronize(&port->napi);
@@ -4406,7 +4406,7 @@ static int mvneta_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	mvneta_percpu_elect(pp);
 	spin_unlock(&pp->lock);
 	/* Unmask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_unmask_interrupt, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_unmask_interrupt, pp, SMP_CALL_TYPE_SYNC);
 	mvreg_write(pp, MVNETA_INTR_MISC_MASK,
 		    MVNETA_CAUSE_PHY_STATUS_CHANGE |
 		    MVNETA_CAUSE_LINK_CHANGE);
@@ -4445,7 +4445,7 @@ static int mvneta_open(struct net_device *dev)
 		/* Enable per-CPU interrupt on all the CPU to handle our RX
 		 * queue interrupts
 		 */
-		on_each_cpu(mvneta_percpu_enable, pp, true);
+		smp_call(SMP_CALL_ALL, mvneta_percpu_enable, pp, SMP_CALL_TYPE_SYNC);
 
 		pp->is_stopped = false;
 		/* Register a CPU notifier to handle the case where our CPU
@@ -4484,7 +4484,7 @@ static int mvneta_open(struct net_device *dev)
 	if (pp->neta_armada3700) {
 		free_irq(pp->dev->irq, pp);
 	} else {
-		on_each_cpu(mvneta_percpu_disable, pp, true);
+		smp_call(SMP_CALL_ALL, mvneta_percpu_disable, pp, SMP_CALL_TYPE_SYNC);
 		free_percpu_irq(pp->dev->irq, pp->ports);
 	}
 err_cleanup_txqs:
@@ -4516,7 +4516,7 @@ static int mvneta_stop(struct net_device *dev)
 						    &pp->node_online);
 		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
 						    &pp->node_dead);
-		on_each_cpu(mvneta_percpu_disable, pp, true);
+		smp_call(SMP_CALL_ALL, mvneta_percpu_disable, pp, SMP_CALL_TYPE_SYNC);
 		free_percpu_irq(dev->irq, pp->ports);
 	} else {
 		mvneta_stop_dev(pp);
@@ -4893,7 +4893,7 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 
 	netif_tx_stop_all_queues(pp->dev);
 
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_call(SMP_CALL_ALL, mvneta_percpu_mask_interrupt, pp, SMP_CALL_TYPE_SYNC);
 
 	if (!pp->neta_armada3700) {
 		/* We have to synchronise on the napi of each CPU */
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 1a835b48791b..70fe2af6985f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3263,7 +3263,7 @@ static void mvpp2_cleanup_txqs(struct mvpp2_port *port)
 		mvpp2_txq_deinit(port, txq);
 	}
 
-	on_each_cpu(mvpp2_txq_sent_counter_clear, port, 1);
+	smp_call(SMP_CALL_ALL, mvpp2_txq_sent_counter_clear, port, SMP_CALL_TYPE_SYNC);
 
 	val &= ~MVPP2_TX_PORT_FLUSH_MASK(port->id);
 	mvpp2_write(port->priv, MVPP2_TX_PORT_FLUSH_REG, val);
@@ -3327,7 +3327,7 @@ static int mvpp2_setup_txqs(struct mvpp2_port *port)
 		}
 	}
 
-	on_each_cpu(mvpp2_txq_sent_counter_clear, port, 1);
+	smp_call(SMP_CALL_ALL, mvpp2_txq_sent_counter_clear, port, SMP_CALL_TYPE_SYNC);
 	return 0;
 
 err_cleanup:
@@ -4829,7 +4829,7 @@ static int mvpp2_open(struct net_device *dev)
 	}
 
 	/* Unmask interrupts on all CPUs */
-	on_each_cpu(mvpp2_interrupts_unmask, port, 1);
+	smp_call(SMP_CALL_ALL, mvpp2_interrupts_unmask, port, SMP_CALL_TYPE_SYNC);
 	mvpp2_shared_interrupt_mask_unmask(port, false);
 
 	mvpp2_start_dev(port);
@@ -4858,7 +4858,7 @@ static int mvpp2_stop(struct net_device *dev)
 	mvpp2_stop_dev(port);
 
 	/* Mask interrupts on all threads */
-	on_each_cpu(mvpp2_interrupts_mask, port, 1);
+	smp_call(SMP_CALL_ALL, mvpp2_interrupts_mask, port, SMP_CALL_TYPE_SYNC);
 	mvpp2_shared_interrupt_mask_unmask(port, true);
 
 	if (port->phylink)
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 4dfdbfca6841..e8cacf59357a 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -457,7 +457,7 @@ static void ips_enable_cpu_turbo(struct ips_driver *ips)
 		return;
 
 	if (ips->turbo_toggle_allowed)
-		on_each_cpu(do_enable_cpu_turbo, ips, 1);
+		smp_call(SMP_CALL_ALL, do_enable_cpu_turbo, ips, SMP_CALL_TYPE_SYNC);
 
 	ips->__cpu_turbo_on = true;
 }
@@ -495,7 +495,7 @@ static void ips_disable_cpu_turbo(struct ips_driver *ips)
 		return;
 
 	if (ips->turbo_toggle_allowed)
-		on_each_cpu(do_disable_cpu_turbo, ips, 1);
+		smp_call(SMP_CALL_ALL, do_disable_cpu_turbo, ips, SMP_CALL_TYPE_SYNC);
 
 	ips->__cpu_turbo_on = false;
 }
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index b27f8853508e..a9dc450951b8 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -514,7 +514,7 @@ static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
 
 	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
 
-	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
+	smp_call(SMP_CALL_ALL, xlnx_disable_percpu_irq, NULL, SMP_CALL_TYPE_SYNC);
 
 	irq_clear_status_flags(virq_sgi, IRQ_PER_CPU);
 	free_percpu_irq(virq_sgi, &cpu_number1);
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5..444cdd8bc8a0 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -243,7 +243,8 @@ static void showacpu(void *dummy)
 
 static void sysrq_showregs_othercpus(struct work_struct *dummy)
 {
-	smp_call_function(showacpu, NULL, 0);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, showacpu,
+			NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 static DECLARE_WORK(sysrq_showallcpus, sysrq_showregs_othercpus);
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 5e4dc1a0f2c6..b34ba999c8c5 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -118,7 +118,7 @@ static void __booke_wdt_set(void *data)
 
 static void booke_wdt_set(void *data)
 {
-	on_each_cpu(__booke_wdt_set, data, 0);
+	smp_call(SMP_CALL_ALL, __booke_wdt_set, data, SMP_CALL_TYPE_ASYNC);
 }
 
 static void __booke_wdt_ping(void *data)
@@ -128,7 +128,7 @@ static void __booke_wdt_ping(void *data)
 
 static int booke_wdt_ping(struct watchdog_device *wdog)
 {
-	on_each_cpu(__booke_wdt_ping, NULL, 0);
+	smp_call(SMP_CALL_ALL, __booke_wdt_ping, NULL, SMP_CALL_TYPE_ASYNC);
 
 	return 0;
 }
@@ -170,7 +170,7 @@ static void __booke_wdt_disable(void *data)
 
 static int booke_wdt_start(struct watchdog_device *wdog)
 {
-	on_each_cpu(__booke_wdt_enable, wdog, 0);
+	smp_call(SMP_CALL_ALL, __booke_wdt_enable, wdog, SMP_CALL_TYPE_ASYNC);
 	pr_debug("watchdog enabled (timeout = %u sec)\n", wdog->timeout);
 
 	return 0;
@@ -178,7 +178,7 @@ static int booke_wdt_start(struct watchdog_device *wdog)
 
 static int booke_wdt_stop(struct watchdog_device *wdog)
 {
-	on_each_cpu(__booke_wdt_disable, NULL, 0);
+	smp_call(SMP_CALL_ALL, __booke_wdt_disable, NULL, SMP_CALL_TYPE_ASYNC);
 	pr_debug("watchdog disabled\n");
 
 	return 0;
diff --git a/fs/buffer.c b/fs/buffer.c
index 2b5561ae5d0b..e02180ab3816 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1420,7 +1420,7 @@ bool has_bh_in_lru(int cpu, void *dummy)
 
 void invalidate_bh_lrus(void)
 {
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
+	smp_call_cond(SMP_CALL_ALL, invalidate_bh_lru, NULL, has_bh_in_lru, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 1fb0951ca16b..40c46d2bea88 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -160,7 +160,8 @@ do {						\
 #define	SMP_CALL_TYPE_TTWU		CSD_TYPE_TTWU
 #define	SMP_CALL_TYPE_MASK		CSD_FLAG_TYPE_MASK
 
-#define	SMP_CALL_ALL	-1
+#define	SMP_CALL_ALL		-1
+#define	SMP_CALL_MASK_ALL	((struct cpumask *)-1)
 
 extern int smp_call(int cpu, smp_call_func_t func, void *info, unsigned int flags);
 
@@ -192,9 +193,6 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
-void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask);
-
 #define	smp_call_function_single_async(cpu, csd) \
 	smp_call_csd(cpu, csd, SMP_CALL_TYPE_ASYNC)
 
@@ -206,48 +204,6 @@ void panic_smp_self_stop(void);
 void nmi_panic_self_stop(struct pt_regs *regs);
 void crash_smp_send_stop(void);
 
-/*
- * Call a function on all processors
- */
-static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
-{
-	on_each_cpu_cond_mask(NULL, func, info, wait, cpu_online_mask);
-}
-
-/**
- * on_each_cpu_mask(): Run a function on processors specified by
- * cpumask, which may include the local processor.
- * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * If @wait is true, then returns once @func has returned.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.  The
- * exception is that it may be used during early boot while
- * early_boot_irqs_disabled is set.
- */
-static inline void on_each_cpu_mask(const struct cpumask *mask,
-				    smp_call_func_t func, void *info, bool wait)
-{
-	on_each_cpu_cond_mask(NULL, func, info, wait, mask);
-}
-
-/*
- * Call a function on each processor for which the supplied function
- * cond_func returns a positive value. This may include the local
- * processor.  May be used during early boot while early_boot_irqs_disabled is
- * set. Use local_irq_save/restore() instead of local_irq_disable/enable().
- */
-static inline void on_each_cpu_cond(smp_cond_func_t cond_func,
-				    smp_call_func_t func, void *info, bool wait)
-{
-	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
-}
-
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
@@ -286,13 +242,6 @@ extern int __cpu_up(unsigned int cpunum, struct task_struct *tidle);
  */
 extern void smp_cpus_done(unsigned int max_cpus);
 
-/*
- * Call a function on all other processors
- */
-void smp_call_function(smp_call_func_t func, void *info, int wait);
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait);
-
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
 
diff --git a/kernel/profile.c b/kernel/profile.c
index 37640a0bd8a3..7b7a6135f443 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -179,7 +179,7 @@ static void profile_flip_buffers(void)
 	mutex_lock(&profile_flip_mutex);
 	j = per_cpu(cpu_profile_flip, get_cpu());
 	put_cpu();
-	on_each_cpu(__profile_flip_buffers, NULL, 1);
+	smp_call(SMP_CALL_ALL, __profile_flip_buffers, NULL, SMP_CALL_TYPE_SYNC);
 	for_each_online_cpu(cpu) {
 		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[j];
 		for (i = 0; i < NR_PROFILE_HIT; ++i) {
@@ -202,7 +202,7 @@ static void profile_discard_flip_buffers(void)
 	mutex_lock(&profile_flip_mutex);
 	i = per_cpu(cpu_profile_flip, get_cpu());
 	put_cpu();
-	on_each_cpu(__profile_flip_buffers, NULL, 1);
+	smp_call(SMP_CALL_ALL, __profile_flip_buffers, NULL, SMP_CALL_TYPE_SYNC);
 	for_each_online_cpu(cpu) {
 		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[i];
 		memset(hits, 0, NR_PROFILE_HIT*sizeof(struct profile_hit));
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..7bf1db5ebade 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1884,7 +1884,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 
 	// If strict, make all CPUs aware of new grace period.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
-		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
+		smp_call(SMP_CALL_ALL, rcu_strict_gp_boundary, NULL, SMP_CALL_TYPE_ASYNC);
 
 	return true;
 }
@@ -2109,7 +2109,7 @@ static noinline void rcu_gp_cleanup(void)
 
 	// If strict, make all CPUs aware of the end of the old grace period.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
-		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
+		smp_call(SMP_CALL_ALL, rcu_strict_gp_boundary, NULL, SMP_CALL_TYPE_ASYNC);
 }
 
 /*
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index dcb0410950e4..1ab37f610441 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -398,7 +398,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
 		}
-		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
+		smp_call_mask_others(cpu_online_mask, scf_handler, scfcp,
+			       (scfsp->scfs_wait ? SMP_CALL_TYPE_SYNC : SMP_CALL_TYPE_ASYNC));
 		break;
 	case SCF_PRIM_ALL:
 		if (scfsp->scfs_wait)
@@ -409,7 +410,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
 		}
-		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, scf_handler, scfcp,
+			  (scfsp->scfs_wait ? SMP_CALL_TYPE_SYNC : SMP_CALL_TYPE_ASYNC));
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -515,7 +517,10 @@ static void scf_torture_cleanup(void)
 			torture_stop_kthread("scftorture_invoker", scf_stats_p[i].task);
 	else
 		goto end;
-	smp_call_function(scf_cleanup_handler, NULL, 0);
+
+	smp_call_mask_others(SMP_CALL_MASK_ALL, scf_cleanup_handler,
+			NULL, SMP_CALL_TYPE_ASYNC);
+
 	torture_stop_kthread(scf_torture_stats, scf_torture_stats_task);
 	scf_torture_stats_print();  // -After- the stats thread is stopped!
 	kfree(scf_stats_p);  // -After- the last stats print has completed!
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 0c5be7ebb1dc..427abc8aee02 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -291,7 +291,7 @@ static int membarrier_global_expedited(void)
 	rcu_read_unlock();
 
 	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
+	smp_call_mask_others(tmpmask, ipi_mb, NULL, SMP_CALL_TYPE_SYNC);
 	preempt_enable();
 
 	free_cpumask_var(tmpmask);
@@ -400,10 +400,10 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		 */
 		if (flags != MEMBARRIER_FLAG_SYNC_CORE) {
 			preempt_disable();
-			smp_call_function_many(tmpmask, ipi_func, NULL, true);
+			smp_call_mask_others(tmpmask, ipi_func, NULL, SMP_CALL_TYPE_SYNC);
 			preempt_enable();
 		} else {
-			on_each_cpu_mask(tmpmask, ipi_func, NULL, true);
+			smp_call_mask(tmpmask, ipi_func, NULL, SMP_CALL_TYPE_SYNC);
 		}
 	}
 
@@ -471,7 +471,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 	}
 	rcu_read_unlock();
 
-	on_each_cpu_mask(tmpmask, ipi_sync_rq_state, mm, true);
+	smp_call_mask(tmpmask, ipi_sync_rq_state, mm, SMP_CALL_TYPE_SYNC);
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
diff --git a/kernel/smp.c b/kernel/smp.c
index df343b1368eb..901399697e67 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -641,11 +641,10 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-static void smp_call_function_many_cond(const struct cpumask *mask,
-					smp_call_func_t func, void *info,
-					bool local_cpu,
-					bool wait,
-					smp_cond_func_t cond_func)
+static void __smp_call_mask_cond(const struct cpumask *mask,
+		smp_call_func_t func, void *info,
+		smp_cond_func_t cond_func, bool local_cpu,
+		unsigned int type)
 {
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
@@ -666,10 +665,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		lockdep_assert_irqs_enabled();
 
 	/*
-	 * When @wait we can deadlock when we interrupt between llist_add() and
-	 * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
-	 * csd_lock() on because the interrupt context uses the same csd
-	 * storage.
+	 * When CSD_TYPE_SYNC we can deadlock when we interrupt between
+	 * llist_add() and arch_send_call_function_ipi*(); when CSD_TYPE_ASYNC
+	 * we can deadlock due to csd_lock() on because the interrupt context
+	 * uses the same csd storage.
 	 */
 	WARN_ON_ONCE(!in_task());
 
@@ -698,7 +697,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 				continue;
 
 			csd_lock(csd);
-			if (wait)
+			if (type & CSD_TYPE_SYNC)
 				csd->node.u_flags |= CSD_TYPE_SYNC;
 			csd->func = func;
 			csd->info = info;
@@ -737,11 +736,12 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		unsigned long flags;
 
 		local_irq_save(flags);
-		func(info);
+		if (likely(func != NULL))
+			func(info);
 		local_irq_restore(flags);
 	}
 
-	if (run_remote && wait) {
+	if (run_remote && (type & CSD_TYPE_SYNC)) {
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
@@ -751,48 +751,6 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	}
 }
 
-/**
- * smp_call_function_many(): Run a function on a set of CPUs except the local CPU.
- * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If wait is true, the call will not return until func()
- *        has completed on other CPUs.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler. Preemption
- * must be disabled when calling this function.
- */
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait)
-{
-	smp_call_function_many_cond(mask, func, info, false, wait, NULL);
-}
-EXPORT_SYMBOL(smp_call_function_many);
-
-/**
- * smp_call_function(): Run a function on all other CPUs.
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * Returns 0.
- *
- * If @wait is true, then returns once @func has returned; otherwise
- * it returns just before the target cpu calls @func.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.
- */
-void smp_call_function(smp_call_func_t func, void *info, int wait)
-{
-	preempt_disable();
-	smp_call_function_many(cpu_online_mask, func, info, wait);
-	preempt_enable();
-}
-EXPORT_SYMBOL(smp_call_function);
-
 /* Setup configured maximum number of CPUs to activate */
 unsigned int setup_max_cpus = NR_CPUS;
 EXPORT_SYMBOL(setup_max_cpus);
@@ -877,38 +835,6 @@ void __init smp_init(void)
 	smp_cpus_done(setup_max_cpus);
 }
 
-/*
- * on_each_cpu_cond(): Call a function on each processor which
- * the supplied function cond_func returns true, optionally waiting
- * for all the required CPUs to finish. This may include the local
- * processor.
- * @cond_func:	A callback function that is passed a cpu id and
- *		the info parameter. The function is called
- *		with preemption disabled. The function should
- *		return a blooean value indicating whether to IPI
- *		the specified CPU.
- * @func:	The function to run on all applicable CPUs.
- *		This must be fast and non-blocking.
- * @info:	An arbitrary pointer to pass to both functions.
- * @wait:	If true, wait (atomically) until function has
- *		completed on other CPUs.
- *
- * Preemption is disabled to protect against CPUs going offline but not online.
- * CPUs going online during the call will not be seen or sent an IPI.
- *
- * You must not call this function with disabled interrupts or
- * from a hardware interrupt handler or from a bottom half handler.
- */
-void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask)
-{
-
-	preempt_disable();
-	smp_call_function_many_cond(mask, func, info, true, wait, cond_func);
-	preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu_cond_mask);
-
 static void do_nothing(void *unused)
 {
 }
@@ -928,7 +854,8 @@ void kick_all_cpus_sync(void)
 {
 	/* Make sure the change is visible before we kick the cpus */
 	smp_mb();
-	smp_call_function(do_nothing, NULL, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, do_nothing,
+			NULL, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
 
@@ -1008,27 +935,6 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 }
 EXPORT_SYMBOL_GPL(smp_call_on_cpu);
 
-
-void __smp_call_mask_cond(const struct cpumask *mask,
-		smp_call_func_t func, void *info,
-		smp_cond_func_t cond_func, bool local_cpu,
-		unsigned int flags)
-{
-	bool wait = false;
-
-	if (flags == SMP_CALL_TYPE_SYNC)
-		wait = true;
-
-	preempt_disable();
-
-	/*
-	 * This is temporarily hook. The function smp_call_function_many_cond()
-	 * will be inlined here with a later patch in this series.
-	 */
-	smp_call_function_many_cond(mask, func, info, local_cpu, wait, cond_func);
-	preempt_enable();
-}
-
 /**
  * Given cpumask, find an online CPU as close to the local CPU as
  * possible in the order below:
@@ -1165,6 +1071,9 @@ EXPORT_SYMBOL(smp_call_mask);
  * mask: The cross call will be sent to all the CPUs in mask except
  *       the local CPU.
  *
+ *       If mask == SMP_CALL_MASK_ALL, then the cross call is sent
+ *       to all online CPUs except the local CPU.
+ *
  * Others: see smp_call().
  *
  * Besides, its the callers' discrimination as to whether preemption
@@ -1178,7 +1087,10 @@ void smp_call_mask_others(const struct cpumask *mask, smp_call_func_t func,
 		return;
 	}
 
-	__smp_call_mask_cond(mask, func, info, NULL, false, flags);
+	if (mask == SMP_CALL_MASK_ALL)
+		__smp_call_mask_cond(cpu_online_mask, func, info, NULL, false, flags);
+	else
+		__smp_call_mask_cond(mask, func, info, NULL, false, flags);
 }
 EXPORT_SYMBOL(smp_call_mask_others);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb516..6726e92d9a9e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -952,7 +952,7 @@ void clock_was_set(unsigned int bases)
 		goto out_timerfd;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
-		on_each_cpu(retrigger_next_event, NULL, 1);
+		smp_call(SMP_CALL_ALL, retrigger_next_event, NULL, SMP_CALL_TYPE_SYNC);
 		goto out_timerfd;
 	}
 
@@ -971,8 +971,9 @@ void clock_was_set(unsigned int bases)
 	}
 
 	preempt_disable();
-	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
+	smp_call_mask_others(mask, retrigger_next_event, NULL, SMP_CALL_TYPE_SYNC);
 	preempt_enable();
+
 	cpus_read_unlock();
 	free_cpumask_var(mask);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5e7263..8b751715397d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -243,7 +243,8 @@ static void update_ftrace_function(void)
 	/* Make sure the function_trace_op is visible on all CPUs */
 	smp_wmb();
 	/* Nasty way to force a rmb on all cpus */
-	smp_call_function(ftrace_sync_ipi, NULL, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, ftrace_sync_ipi,
+			NULL, SMP_CALL_TYPE_SYNC);
 	/* OK, we are all set to update the ftrace_trace_function now! */
 #endif /* !CONFIG_DYNAMIC_FTRACE */
 
@@ -2756,7 +2757,9 @@ void ftrace_modify_all_code(int command)
 		smp_wmb();
 		/* If irqs are disabled, we are in stop machine */
 		if (!irqs_disabled())
-			smp_call_function(ftrace_sync_ipi, NULL, 1);
+			smp_call_mask_others(SMP_CALL_MASK_ALL,
+				ftrace_sync_ipi, NULL, SMP_CALL_TYPE_SYNC);
+
 		err = ftrace_update_ftrace_func(ftrace_trace_function);
 		if (FTRACE_WARN_ON(err))
 			return;
@@ -7769,7 +7772,7 @@ pid_write(struct file *filp, const char __user *ubuf,
 	 * check for those tasks that are currently running.
 	 * Always do this in case a pid was appended or removed.
 	 */
-	on_each_cpu(ignore_task_cpu, tr, 1);
+	smp_call(SMP_CALL_ALL, ignore_task_cpu, tr, SMP_CALL_TYPE_SYNC);
 
 	ftrace_update_pid_func();
 	ftrace_startup_all(0);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05dfc7a12d3d..416a7cf4249e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5865,7 +5865,9 @@ static __init int rb_hammer_test(void *arg)
 	while (!kthread_should_stop()) {
 
 		/* Send an IPI to all cpus to write data! */
-		smp_call_function(rb_ipi, NULL, 1);
+		smp_call_mask_others(SMP_CALL_MASK_ALL, rb_ipi,
+				NULL, SMP_CALL_TYPE_SYNC);
+
 		/* No sleep, but for non preempt, let others run */
 		schedule();
 	}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa18f..ac55868475d4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2724,10 +2724,10 @@ void trace_buffered_event_disable(void)
 	if (--trace_buffered_event_ref)
 		return;
 
-	preempt_disable();
 	/* For each CPU, set the buffer as used. */
-	smp_call_function_many(tracing_buffer_mask,
-			       disable_trace_buffered_event, NULL, 1);
+	preempt_disable();
+	smp_call_mask_others(tracing_buffer_mask,
+		       disable_trace_buffered_event, NULL, SMP_CALL_TYPE_SYNC);
 	preempt_enable();
 
 	/* Wait for all current users to finish */
@@ -2743,10 +2743,10 @@ void trace_buffered_event_disable(void)
 	 */
 	smp_wmb();
 
-	preempt_disable();
 	/* Do the work on each cpu */
-	smp_call_function_many(tracing_buffer_mask,
-			       enable_trace_buffered_event, NULL, 1);
+	preempt_disable();
+	smp_call_mask_others(tracing_buffer_mask,
+		       enable_trace_buffered_event, NULL, SMP_CALL_TYPE_SYNC);
 	preempt_enable();
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..30441ba91790 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1995,7 +1995,7 @@ event_pid_write(struct file *filp, const char __user *ubuf,
 	 * check for those tasks that are currently running.
 	 * Always do this in case a pid was appended or removed.
 	 */
-	on_each_cpu(ignore_task_cpu, tr, 1);
+	smp_call(SMP_CALL_ALL, ignore_task_cpu, tr, SMP_CALL_TYPE_SYNC);
 
  out:
 	mutex_unlock(&event_mutex);
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 0a9def8ce5e8..54b500a0fc4c 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -339,7 +339,7 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 	 * achieves the first goal, while synchronize_srcu() achieves the
 	 * second.
 	 */
-	on_each_cpu(per_cpu_remove_cache, cache, 1);
+	smp_call(SMP_CALL_ALL, per_cpu_remove_cache, cache, SMP_CALL_TYPE_SYNC);
 
 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i = 0; i < QUARANTINE_BATCHES; i++) {
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index afb7185ffdc4..f1eedba51d4b 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -149,7 +149,8 @@ static void tlb_remove_table_sync_one(void)
 	 * It is however sufficient for software page-table walkers that rely on
 	 * IRQ disabling.
 	 */
-	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, tlb_remove_table_smp_sync,
+			NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void tlb_remove_table_rcu(struct rcu_head *head)
diff --git a/mm/slab.c b/mm/slab.c
index 0edb474edef1..13c96fad5ff4 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2171,7 +2171,7 @@ static void drain_cpu_caches(struct kmem_cache *cachep)
 	int node;
 	LIST_HEAD(list);
 
-	on_each_cpu(do_drain, cachep, 1);
+	smp_call(SMP_CALL_ALL, do_drain, cachep, SMP_CALL_TYPE_SYNC);
 	check_irq_on();
 	for_each_kmem_cache_node(cachep, node, n)
 		if (n->alien)
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index eb0295d90039..015373965343 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -574,7 +574,7 @@ static int iucv_enable(void)
 static void iucv_disable(void)
 {
 	cpus_read_lock();
-	on_each_cpu(iucv_retrieve_cpu, NULL, 1);
+	smp_call(SMP_CALL_ALL, iucv_retrieve_cpu, NULL, SMP_CALL_TYPE_SYNC);
 	kfree(iucv_path_table);
 	iucv_path_table = NULL;
 	cpus_read_unlock();
@@ -696,7 +696,9 @@ static void iucv_cleanup_queue(void)
 	 * pending interrupts force them to the work queue by calling
 	 * an empty function on all cpus.
 	 */
-	smp_call_function(__iucv_cleanup_queue, NULL, 1);
+	smp_call_mask_others(SMP_CALL_MASK_ALL, __iucv_cleanup_queue,
+			NULL, SMP_CALL_TYPE_SYNC);
+
 	spin_lock_irq(&iucv_queue_lock);
 	list_for_each_entry_safe(p, n, &iucv_task_queue, list) {
 		/* Remove stale work items from the task queue. */
@@ -787,7 +789,7 @@ static int iucv_reboot_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	cpus_read_lock();
-	on_each_cpu_mask(&iucv_irq_cpumask, iucv_block_cpu, NULL, 1);
+	smp_call_mask(&iucv_irq_cpumask, iucv_block_cpu, NULL, SMP_CALL_TYPE_SYNC);
 	preempt_disable();
 	for (i = 0; i < iucv_max_pathid; i++) {
 		if (iucv_path_table[i])
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6d971fb1b08d..ffa181d2d465 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -248,7 +248,7 @@ static inline bool kvm_kick_many_cpus(struct cpumask *cpus, bool wait)
 	if (cpumask_empty(cpus))
 		return false;
 
-	smp_call_function_many(cpus, ack_flush, NULL, wait);
+	smp_call_mask_others(cpus, ack_flush, NULL, (wait ? SMP_CALL_TYPE_SYNC : SMP_CALL_TYPE_ASYNC));
 	return true;
 }
 
@@ -4923,7 +4923,7 @@ static void hardware_disable_all_nolock(void)
 
 	kvm_usage_count--;
 	if (!kvm_usage_count)
-		on_each_cpu(hardware_disable_nolock, NULL, 1);
+		smp_call(SMP_CALL_ALL, hardware_disable_nolock, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void hardware_disable_all(void)
@@ -4942,7 +4942,7 @@ static int hardware_enable_all(void)
 	kvm_usage_count++;
 	if (kvm_usage_count == 1) {
 		atomic_set(&hardware_enable_failed, 0);
-		on_each_cpu(hardware_enable_nolock, NULL, 1);
+		smp_call(SMP_CALL_ALL, hardware_enable_nolock, NULL, SMP_CALL_TYPE_SYNC);
 
 		if (atomic_read(&hardware_enable_failed)) {
 			hardware_disable_all_nolock();
@@ -4966,7 +4966,7 @@ static int kvm_reboot(struct notifier_block *notifier, unsigned long val,
 	 */
 	pr_info("kvm: exiting hardware virtualization\n");
 	kvm_rebooting = true;
-	on_each_cpu(hardware_disable_nolock, NULL, 1);
+	smp_call(SMP_CALL_ALL, hardware_disable_nolock, NULL, SMP_CALL_TYPE_SYNC);
 	return NOTIFY_OK;
 }
 
@@ -5818,7 +5818,7 @@ void kvm_exit(void)
 	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_STARTING);
-	on_each_cpu(hardware_disable_nolock, NULL, 1);
+	smp_call(SMP_CALL_ALL, hardware_disable_nolock, NULL, SMP_CALL_TYPE_SYNC);
 	kvm_arch_hardware_unsetup();
 	kvm_arch_exit();
 	kvm_irqfd_exit();
-- 
2.27.0

