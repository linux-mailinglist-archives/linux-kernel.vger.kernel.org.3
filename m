Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323C35020B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbiDOCu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348866AbiDOCt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08BFBA7758
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649990845;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FboFSDSjU3HAjYGZ7ahI8FjVlb6LL52BxbnXxke5c/U=;
        b=ZhHn+wvasAjh4dT1N32+6B0opwHCb/qJJmfv+wNJI+6sYulAOjfReZomURyY1/gvRPMjUl
        xG0AQLYcNWs4Maf/oKqvlwP2qiQCLFPt/M5//+VBMxWb0dglVYYBh3JMebBHezTqgA60rD
        b0ssCrHICpnUILnpMj+j/qSs0t7dPUE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-UWLE0CV2PwS-4bPaoUUi6g-1; Thu, 14 Apr 2022 22:47:19 -0400
X-MC-Unique: UWLE0CV2PwS-4bPaoUUi6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 146A73803508;
        Fri, 15 Apr 2022 02:47:18 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.8.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8219B440ADE;
        Fri, 15 Apr 2022 02:47:17 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH 08/11] smp: replace smp_call_function_many_cond() with __smp_call_mask_cond()
Date:   Thu, 14 Apr 2022 22:46:58 -0400
Message-Id: <20220415024701.876364-9-dqiao@redhat.com>
In-Reply-To: <20220415024701.876364-1-dqiao@redhat.com>
References: <20220415024701.876364-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced smp_call_function_many_cond() with __smp_call_mask_cond()
and make the changes as necessary.

Consolidated and clean up the redundant code alongside the paths of the
invocation to the function smp_call_function_many_cond().

on_each_cpu_cond_mask(cond_func, func, info, wait, mask) is replaced by
smp_xcall_mask_cond(umask, func, cond_func, info, (wait?XCALL_TYPE_SYNC:
XCALL_TYPE_ASYNC))

smp_call_function_many(mask, func, info, wait) is replaced by
smp_xcall_mask(mask, func, info, (wait?XCALL_TYPE_SYNC:XCALL_TYPE_ASYNC))

smp_call_function(func, info, wait) is replace by
smp_xcall(XCALL_ALL, func, info, (wait?XCALL_TYPE_SYNC:XCALL_TYPE_ASYNC))

on_each_cpu(func info, wait) is replaced by
smp_xcall(XCALL_ALL, func, info, (wait?XCALL_TYPE_SYNC:XCALL_TYPE_ASYNC))

on_each_cpu_mask(mask, func, info, wait) is replaced by
smp_xcall_mask(mask, func, info, (wait?XCALL_TYPE_SYNC:XCALL_TYPE_ASYNC))

on_each_cpu_cond(cond_func, func, info, wait) is replaced by
smp_xcall_cond(XCALL_ALL, func, info, cond_func, (wait ? XCALL_TYPE_SYNC:
XCALL_TYPE_ASYNC))

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
 arch/alpha/kernel/process.c                   |   2 +-
 arch/alpha/kernel/smp.c                       |  10 +-
 arch/arc/kernel/perf_event.c                  |   2 +-
 arch/arc/mm/cache.c                           |   2 +-
 arch/arc/mm/tlb.c                             |  14 +-
 arch/arm/common/bL_switcher.c                 |   2 +-
 arch/arm/kernel/machine_kexec.c               |   2 +-
 arch/arm/kernel/smp_tlb.c                     |  22 +--
 arch/arm/kernel/smp_twd.c                     |   4 +-
 arch/arm/mm/flush.c                           |   4 +-
 arch/arm/vfp/vfpmodule.c                      |   2 +-
 arch/arm64/kernel/armv8_deprecated.c          |   4 +-
 arch/arm64/kernel/perf_event.c                |   2 +-
 arch/arm64/kvm/arm.c                          |   6 +-
 arch/csky/abiv2/cacheflush.c                  |   2 +-
 arch/csky/kernel/perf_event.c                 |   2 +-
 arch/csky/kernel/smp.c                        |   2 +-
 arch/csky/mm/cachev2.c                        |   2 +-
 arch/ia64/kernel/mca.c                        |   4 +-
 arch/ia64/kernel/smp.c                        |  10 +-
 arch/ia64/kernel/uncached.c                   |   4 +-
 arch/mips/cavium-octeon/octeon-irq.c          |   4 +-
 arch/mips/cavium-octeon/setup.c               |   4 +-
 arch/mips/kernel/crash.c                      |   2 +-
 arch/mips/kernel/machine_kexec.c              |   2 +-
 arch/mips/kernel/perf_event_mipsxx.c          |   7 +-
 arch/mips/kernel/smp.c                        |   8 +-
 arch/mips/kernel/sysrq.c                      |   2 +-
 arch/mips/mm/c-r4k.c                          |   4 +-
 arch/mips/sibyte/common/cfe.c                 |   2 +-
 arch/openrisc/kernel/smp.c                    |  12 +-
 arch/parisc/kernel/cache.c                    |   4 +-
 arch/parisc/mm/init.c                         |   2 +-
 arch/powerpc/kernel/dawr.c                    |   2 +-
 arch/powerpc/kernel/kvm.c                     |   2 +-
 arch/powerpc/kernel/security.c                |   6 +-
 arch/powerpc/kernel/smp.c                     |   4 +-
 arch/powerpc/kernel/sysfs.c                   |   2 +-
 arch/powerpc/kernel/tau_6xx.c                 |   4 +-
 arch/powerpc/kexec/core_64.c                  |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c           |   2 +-
 arch/powerpc/mm/book3s64/pgtable.c            |   2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  12 +-
 arch/powerpc/mm/nohash/tlb.c                  |  10 +-
 arch/powerpc/mm/slice.c                       |   4 +-
 arch/powerpc/perf/core-book3s.c               |   2 +-
 arch/powerpc/perf/imc-pmu.c                   |   2 +-
 arch/powerpc/platforms/85xx/smp.c             |   2 +-
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
 arch/sh/kernel/smp.c                          |  14 +-
 arch/sh/mm/cache.c                            |   2 +-
 arch/sparc/include/asm/mman.h                 |   4 +-
 arch/sparc/kernel/nmi.c                       |  12 +-
 arch/sparc/kernel/perf_event.c                |   4 +-
 arch/sparc/kernel/smp_64.c                    |   8 +-
 arch/sparc/mm/init_64.c                       |   2 +-
 arch/x86/events/core.c                        |   6 +-
 arch/x86/events/intel/core.c                  |   4 +-
 arch/x86/kernel/alternative.c                 |   2 +-
 arch/x86/kernel/amd_nb.c                      |   2 +-
 arch/x86/kernel/apic/apic.c                   |   2 +-
 arch/x86/kernel/cpu/bugs.c                    |   2 +-
 arch/x86/kernel/cpu/mce/core.c                |  12 +-
 arch/x86/kernel/cpu/mce/inject.c              |   6 +-
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
 arch/x86/xen/smp_pv.c                         |   2 +-
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
 drivers/net/ethernet/marvell/mvneta.c         |  30 ++---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   8 +-
 drivers/platform/x86/intel_ips.c              |   4 +-
 drivers/soc/xilinx/xlnx_event_manager.c       |   2 +-
 drivers/tty/sysrq.c                           |   2 +-
 drivers/watchdog/booke_wdt.c                  |   8 +-
 fs/buffer.c                                   |   2 +-
 include/linux/smp.h                           |  53 +-------
 kernel/profile.c                              |   4 +-
 kernel/rcu/tree.c                             |   4 +-
 kernel/scftorture.c                           |   8 +-
 kernel/sched/membarrier.c                     |  12 +-
 kernel/smp.c                                  | 125 +++---------------
 kernel/time/hrtimer.c                         |   6 +-
 kernel/trace/ftrace.c                         |   6 +-
 kernel/trace/ring_buffer.c                    |   2 +-
 kernel/trace/trace.c                          |  12 +-
 kernel/trace/trace_events.c                   |   2 +-
 mm/kasan/quarantine.c                         |   2 +-
 mm/mmu_gather.c                               |   2 +-
 mm/slab.c                                     |   2 +-
 net/iucv/iucv.c                               |   6 +-
 virt/kvm/kvm_main.c                           |  10 +-
 126 files changed, 309 insertions(+), 459 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5f8527081da9..835127b84b66 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -167,7 +167,7 @@ common_shutdown(int mode, char *restart_cmd)
 	struct halt_info args;
 	args.mode = mode;
 	args.restart_cmd = restart_cmd;
-	on_each_cpu(common_shutdown_1, &args, 0);
+	smp_xcall(XCALL_ALL, common_shutdown_1, &args, XCALL_TYPE_ASYNC);
 }
 
 void
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index cb64e4797d2a..70df387ee9f2 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -611,7 +611,7 @@ void
 smp_imb(void)
 {
 	/* Must wait other processors to flush their icache before continue. */
-	on_each_cpu(ipi_imb, NULL, 1);
+	smp_xcall(XCALL_ALL, ipi_imb, NULL, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(smp_imb);
 
@@ -626,7 +626,7 @@ flush_tlb_all(void)
 {
 	/* Although we don't have any data to pass, we do want to
 	   synchronize with the other processors.  */
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_all, NULL, XCALL_TYPE_SYNC);
 }
 
 #define asn_locked() (cpu_data[smp_processor_id()].asn_lock)
@@ -661,7 +661,7 @@ flush_tlb_mm(struct mm_struct *mm)
 		}
 	}
 
-	smp_call_function(ipi_flush_tlb_mm, mm, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_mm, mm, XCALL_TYPE_SYNC);
 
 	preempt_enable();
 }
@@ -712,7 +712,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	data.mm = mm;
 	data.addr = addr;
 
-	smp_call_function(ipi_flush_tlb_page, &data, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_page, &data, XCALL_TYPE_SYNC);
 
 	preempt_enable();
 }
@@ -762,7 +762,7 @@ flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 		}
 	}
 
-	smp_call_function(ipi_flush_icache_page, mm, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_icache_page, mm, XCALL_TYPE_SYNC);
 
 	preempt_enable();
 }
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index adff957962da..ef70a4becba9 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -811,7 +811,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 						 this_cpu_ptr(&arc_pmu_cpu));
 
 			if (!ret)
-				on_each_cpu(arc_cpu_pmu_irq_init, &irq, 1);
+				smp_xcall(XCALL_ALL, arc_cpu_pmu_irq_init, &irq, XCALL_TYPE_SYNC);
 			else
 				irq = -1;
 		}
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 8aa1231865d1..f46df918b3c7 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -569,7 +569,7 @@ static void __ic_line_inv_vaddr(phys_addr_t paddr, unsigned long vaddr,
 		.sz    = sz
 	};
 
-	on_each_cpu(__ic_line_inv_vaddr_helper, &ic_inv, 1);
+	smp_xcall(XCALL_ALL, __ic_line_inv_vaddr_helper, &ic_inv, XCALL_TYPE_SYNC);
 }
 
 #endif	/* CONFIG_SMP */
diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
index 5f71445f26bd..7d5b55410f4c 100644
--- a/arch/arc/mm/tlb.c
+++ b/arch/arc/mm/tlb.c
@@ -330,13 +330,13 @@ static inline void ipi_flush_tlb_kernel_range(void *arg)
 
 void flush_tlb_all(void)
 {
-	on_each_cpu((smp_call_func_t)local_flush_tlb_all, NULL, 1);
+	smp_xcall(XCALL_ALL, (smp_call_func_t)local_flush_tlb_all, NULL, XCALL_TYPE_SYNC);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	on_each_cpu_mask(mm_cpumask(mm), (smp_call_func_t)local_flush_tlb_mm,
-			 mm, 1);
+	smp_xcall_mask(mm_cpumask(mm), (smp_call_func_t)local_flush_tlb_mm,
+			 mm, XCALL_TYPE_SYNC);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
@@ -346,7 +346,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 		.ta_start = uaddr
 	};
 
-	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page, &ta, 1);
+	smp_xcall_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page, &ta, XCALL_TYPE_SYNC);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -358,7 +358,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		.ta_end = end
 	};
 
-	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range, &ta, 1);
+	smp_xcall_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range, &ta, XCALL_TYPE_SYNC);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -371,7 +371,7 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		.ta_end = end
 	};
 
-	on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_pmd_tlb_range, &ta, 1);
+	smp_xcall_mask(mm_cpumask(vma->vm_mm), ipi_flush_pmd_tlb_range, &ta, XCALL_TYPE_SYNC);
 }
 #endif
 
@@ -382,7 +382,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		.ta_end = end
 	};
 
-	on_each_cpu(ipi_flush_tlb_kernel_range, &ta, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_kernel_range, &ta, XCALL_TYPE_SYNC);
 }
 #endif
 
diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 9a9aa53547a6..7840aea57967 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -541,7 +541,7 @@ int bL_switcher_trace_trigger(void)
 	preempt_disable();
 
 	bL_switcher_trace_trigger_cpu(NULL);
-	smp_call_function(bL_switcher_trace_trigger_cpu, NULL, true);
+	smp_xcall(XCALL_ALL, bL_switcher_trace_trigger_cpu, NULL, XCALL_TYPE_SYNC);
 
 	preempt_enable();
 
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0..c1fed9a94fa0 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -101,7 +101,7 @@ void crash_smp_send_stop(void)
 		return;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	smp_xcall(XCALL_ALL, machine_crash_nonpanic_core, NULL, XCALL_TYPE_ASYNC);
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index d4908b3736d8..2113b5760003 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -158,7 +158,7 @@ static void broadcast_tlb_a15_erratum(void)
 	if (!erratum_a15_798181())
 		return;
 
-	smp_call_function(ipi_flush_tlb_a15_erratum, NULL, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_a15_erratum, NULL, XCALL_TYPE_SYNC);
 }
 
 static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
@@ -171,14 +171,14 @@ static void broadcast_tlb_mm_a15_erratum(struct mm_struct *mm)
 
 	this_cpu = get_cpu();
 	a15_erratum_get_cpumask(this_cpu, mm, &mask);
-	smp_call_function_many(&mask, ipi_flush_tlb_a15_erratum, NULL, 1);
+	smp_xcall_mask(&mask, ipi_flush_tlb_a15_erratum, NULL, XCALL_TYPE_SYNC);
 	put_cpu();
 }
 
 void flush_tlb_all(void)
 {
 	if (tlb_ops_need_broadcast())
-		on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+		smp_xcall(XCALL_ALL, ipi_flush_tlb_all, NULL, XCALL_TYPE_SYNC);
 	else
 		__flush_tlb_all();
 	broadcast_tlb_a15_erratum();
@@ -187,7 +187,7 @@ void flush_tlb_all(void)
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	if (tlb_ops_need_broadcast())
-		on_each_cpu_mask(mm_cpumask(mm), ipi_flush_tlb_mm, mm, 1);
+		smp_xcall_mask(mm_cpumask(mm), ipi_flush_tlb_mm, mm, XCALL_TYPE_SYNC);
 	else
 		__flush_tlb_mm(mm);
 	broadcast_tlb_mm_a15_erratum(mm);
@@ -199,8 +199,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 		struct tlb_args ta;
 		ta.ta_vma = vma;
 		ta.ta_start = uaddr;
-		on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page,
-					&ta, 1);
+		smp_xcall_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page,
+			       &ta, XCALL_TYPE_SYNC);
 	} else
 		__flush_tlb_page(vma, uaddr);
 	broadcast_tlb_mm_a15_erratum(vma->vm_mm);
@@ -211,7 +211,7 @@ void flush_tlb_kernel_page(unsigned long kaddr)
 	if (tlb_ops_need_broadcast()) {
 		struct tlb_args ta;
 		ta.ta_start = kaddr;
-		on_each_cpu(ipi_flush_tlb_kernel_page, &ta, 1);
+		smp_xcall(XCALL_ALL, ipi_flush_tlb_kernel_page, &ta, XCALL_TYPE_SYNC);
 	} else
 		__flush_tlb_kernel_page(kaddr);
 	broadcast_tlb_a15_erratum();
@@ -225,8 +225,8 @@ void flush_tlb_range(struct vm_area_struct *vma,
 		ta.ta_vma = vma;
 		ta.ta_start = start;
 		ta.ta_end = end;
-		on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range,
-					&ta, 1);
+		smp_xcall_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_range,
+				&ta, XCALL_TYPE_SYNC);
 	} else
 		local_flush_tlb_range(vma, start, end);
 	broadcast_tlb_mm_a15_erratum(vma->vm_mm);
@@ -238,7 +238,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		struct tlb_args ta;
 		ta.ta_start = start;
 		ta.ta_end = end;
-		on_each_cpu(ipi_flush_tlb_kernel_range, &ta, 1);
+		smp_xcall(XCALL_ALL, ipi_flush_tlb_kernel_range, &ta, XCALL_TYPE_SYNC);
 	} else
 		local_flush_tlb_kernel_range(start, end);
 	broadcast_tlb_a15_erratum();
@@ -247,7 +247,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 void flush_bp_all(void)
 {
 	if (tlb_ops_need_broadcast())
-		on_each_cpu(ipi_flush_bp_all, NULL, 1);
+		smp_xcall(XCALL_ALL, ipi_flush_bp_all, NULL, XCALL_TYPE_SYNC);
 	else
 		__flush_bp_all();
 }
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f721a2b0..a279bdfe40dd 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -119,8 +119,8 @@ static int twd_rate_change(struct notifier_block *nb,
 	 * changing cpu.
 	 */
 	if (flags == POST_RATE_CHANGE)
-		on_each_cpu(twd_update_frequency,
-				  (void *)&cnd->new_rate, 1);
+		smp_xcall(XCALL_ALL, twd_update_frequency,
+			  (void *)&cnd->new_rate, XCALL_TYPE_SYNC);
 
 	return NOTIFY_OK;
 }
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7ff9feea13a6..07475c23e97c 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -150,8 +150,8 @@ void __flush_ptrace_access(struct page *page, unsigned long uaddr, void *kaddr,
 		else
 			__cpuc_coherent_kern_range(addr, addr + len);
 		if (cache_ops_need_broadcast())
-			smp_call_function(flush_ptrace_access_other,
-					  NULL, 1);
+			smp_xcall(XCALL_ALL, flush_ptrace_access_other,
+				  NULL, XCALL_TYPE_SYNC);
 	}
 }
 
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..41173f46bc80 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -780,7 +780,7 @@ static int __init vfp_init(void)
 	 * following test on FPSID will succeed.
 	 */
 	if (cpu_arch >= CPU_ARCH_ARMv6)
-		on_each_cpu(vfp_enable, NULL, 1);
+		smp_xcall(XCALL_ALL, vfp_enable, NULL, XCALL_TYPE_SYNC);
 
 	/*
 	 * First check that there is a VFP that we can use.
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 6875a16b09d2..5cb793e1893b 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -104,9 +104,9 @@ static int run_all_cpu_set_hw_mode(struct insn_emulation *insn, bool enable)
 	if (!insn->ops->set_hw_mode)
 		return -EINVAL;
 	if (enable)
-		on_each_cpu(enable_insn_hw_mode, (void *)insn, true);
+		smp_xcall(XCALL_ALL, enable_insn_hw_mode, (void *)insn, XCALL_TYPE_SYNC);
 	else
-		on_each_cpu(disable_insn_hw_mode, (void *)insn, true);
+		smp_xcall(XCALL_ALL, disable_insn_hw_mode, (void *)insn, XCALL_TYPE_SYNC);
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 7e847044492b..fc7e13dbf1f5 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1207,7 +1207,7 @@ static int armv8pmu_proc_user_access_handler(struct ctl_table *table, int write,
 	if (ret || !write || sysctl_perf_user_access)
 		return ret;
 
-	on_each_cpu(armv8pmu_disable_user_access_ipi, NULL, 1);
+	smp_xcall(XCALL_ALL, armv8pmu_disable_user_access_ipi, NULL, XCALL_TYPE_SYNC);
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..68e93b87c4cf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1728,7 +1728,7 @@ static int init_subsystems(void)
 	/*
 	 * Enable hardware so that subsystem initialisation can access EL2.
 	 */
-	on_each_cpu(_kvm_arch_hardware_enable, NULL, 1);
+	smp_xcall(XCALL_ALL, _kvm_arch_hardware_enable, NULL, XCALL_TYPE_SYNC);
 
 	/*
 	 * Register CPU lower-power notifier
@@ -1765,7 +1765,7 @@ static int init_subsystems(void)
 
 out:
 	if (err || !is_protected_kvm_enabled())
-		on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
+		smp_xcall(XCALL_ALL, _kvm_arch_hardware_disable, NULL, XCALL_TYPE_SYNC);
 
 	return err;
 }
@@ -2000,7 +2000,7 @@ static int pkvm_drop_host_privileges(void)
 	 * once the host stage 2 is installed.
 	 */
 	static_branch_enable(&kvm_protected_mode_initialized);
-	on_each_cpu(_kvm_host_prot_finalize, &ret, 1);
+	smp_xcall(XCALL_ALL, _kvm_host_prot_finalize, &ret, XCALL_TYPE_SYNC);
 	return ret;
 }
 
diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index 39c51399dd81..68bfe3b618cc 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -80,7 +80,7 @@ void flush_icache_mm_range(struct mm_struct *mm,
 	cpumask_andnot(&others, mm_cpumask(mm), cpumask_of(cpu));
 
 	if (mm != current->active_mm || !cpumask_empty(&others)) {
-		on_each_cpu_mask(&others, local_icache_inv_all, NULL, 1);
+		smp_xcall_mask(&others, local_icache_inv_all, NULL, XCALL_TYPE_SYNC);
 		cpumask_clear(mask);
 	}
 
diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index e5f18420ce64..35f4c8071c64 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1311,7 +1311,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 	csky_pmu.plat_device = pdev;
 
 	/* Ensure the PMU has sane values out of reset. */
-	on_each_cpu(csky_pmu_reset, &csky_pmu, 1);
+	smp_xcall(XCALL_ALL, csky_pmu_reset, &csky_pmu, XCALL_TYPE_SYNC);
 
 	ret = csky_pmu_request_irq(csky_pmu_handle_irq);
 	if (ret) {
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 6bb38bc2f39b..728b157e8323 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -137,7 +137,7 @@ static void ipi_stop(void *unused)
 
 void smp_send_stop(void)
 {
-	on_each_cpu(ipi_stop, NULL, 1);
+	smp_xcall(XCALL_ALL, ipi_stop, NULL, XCALL_TYPE_SYNC);
 }
 
 void smp_send_reschedule(int cpu)
diff --git a/arch/csky/mm/cachev2.c b/arch/csky/mm/cachev2.c
index 7a9664adce43..289ad7852c70 100644
--- a/arch/csky/mm/cachev2.c
+++ b/arch/csky/mm/cachev2.c
@@ -66,7 +66,7 @@ void icache_inv_range(unsigned long start, unsigned long end)
 	if (irqs_disabled())
 		local_icache_inv_range(&param);
 	else
-		on_each_cpu(local_icache_inv_range, &param, 1);
+		smp_xcall(XCALL_ALL, local_icache_inv_range, &param, XCALL_TYPE_SYNC);
 }
 #endif
 
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index e628a88607bb..eeb2dbdf2886 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -712,7 +712,7 @@ ia64_mca_cmc_vector_enable (void *dummy)
 static void
 ia64_mca_cmc_vector_disable_keventd(struct work_struct *unused)
 {
-	on_each_cpu(ia64_mca_cmc_vector_disable, NULL, 0);
+	smp_xcall(XCALL_ALL, ia64_mca_cmc_vector_disable, NULL, XCALL_TYPE_ASYNC);
 }
 
 /*
@@ -724,7 +724,7 @@ ia64_mca_cmc_vector_disable_keventd(struct work_struct *unused)
 static void
 ia64_mca_cmc_vector_enable_keventd(struct work_struct *unused)
 {
-	on_each_cpu(ia64_mca_cmc_vector_enable, NULL, 0);
+	smp_xcall(XCALL_ALL, ia64_mca_cmc_vector_enable, NULL, XCALL_TYPE_ASYNC);
 }
 
 /*
diff --git a/arch/ia64/kernel/smp.c b/arch/ia64/kernel/smp.c
index 7b7b64eb3129..76a76388f1c6 100644
--- a/arch/ia64/kernel/smp.c
+++ b/arch/ia64/kernel/smp.c
@@ -285,7 +285,7 @@ smp_flush_tlb_cpumask(cpumask_t xcpumask)
 void
 smp_flush_tlb_all (void)
 {
-	on_each_cpu((void (*)(void *))local_flush_tlb_all, NULL, 1);
+	smp_xcall(XCALL_ALL, (void (*)(void *))local_flush_tlb_all, NULL, XCALL_TYPE_SYNC);
 }
 
 void
@@ -301,12 +301,12 @@ smp_flush_tlb_mm (struct mm_struct *mm)
 		return;
 	}
 	if (!alloc_cpumask_var(&cpus, GFP_ATOMIC)) {
-		smp_call_function((void (*)(void *))local_finish_flush_tlb_mm,
-			mm, 1);
+		smp_xcall(XCALL_ALL, (void (*)(void *))local_finish_flush_tlb_mm,
+			  mm, XCALL_TYPE_SYNC);
 	} else {
 		cpumask_copy(cpus, mm_cpumask(mm));
-		smp_call_function_many(cpus,
-			(void (*)(void *))local_finish_flush_tlb_mm, mm, 1);
+		smp_xcall_mask(cpus,
+			(void (*)(void *))local_finish_flush_tlb_mm, mm, XCALL_TYPE_SYNC);
 		free_cpumask_var(cpus);
 	}
 	local_irq_disable();
diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 816803636a75..a6166b4f81dd 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -118,7 +118,7 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
 	status = ia64_pal_prefetch_visibility(PAL_VISIBILITY_PHYSICAL);
 	if (status == PAL_VISIBILITY_OK_REMOTE_NEEDED) {
 		atomic_set(&uc_pool->status, 0);
-		smp_call_function(uncached_ipi_visibility, uc_pool, 1);
+		smp_xcall(XCALL_ALL, uncached_ipi_visibility, uc_pool, XCALL_TYPE_SYNC);
 		if (atomic_read(&uc_pool->status))
 			goto failed;
 	} else if (status != PAL_VISIBILITY_OK)
@@ -137,7 +137,7 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
 	if (status != PAL_STATUS_SUCCESS)
 		goto failed;
 	atomic_set(&uc_pool->status, 0);
-	smp_call_function(uncached_ipi_mc_drain, uc_pool, 1);
+	smp_xcall(XCALL_ALL, uncached_ipi_mc_drain, uc_pool, XCALL_TYPE_SYNC);
 	if (atomic_read(&uc_pool->status))
 		goto failed;
 
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 07d7ff5a981d..a6a0b8e50fab 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -216,7 +216,7 @@ static void octeon_irq_core_bus_sync_unlock(struct irq_data *data)
 	struct octeon_core_chip_data *cd = irq_data_get_irq_chip_data(data);
 
 	if (cd->desired_en != cd->current_en) {
-		on_each_cpu(octeon_irq_core_set_enable_local, data, 1);
+		smp_xcall(XCALL_ALL, octeon_irq_core_set_enable_local, data, XCALL_TYPE_SYNC);
 
 		cd->current_en = cd->desired_en;
 	}
@@ -1364,7 +1364,7 @@ void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t h)
 {
 	octeon_irq_ip4 = h;
 	octeon_irq_use_ip4 = true;
-	on_each_cpu(octeon_irq_local_enable_ip4, NULL, 1);
+	smp_xcall(XCALL_ALL, octeon_irq_local_enable_ip4, NULL, XCALL_TYPE_SYNC);
 }
 
 static void octeon_irq_percpu_enable(void)
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 00bf269763cf..dedfc714f733 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -256,7 +256,7 @@ static void octeon_shutdown(void)
 {
 	octeon_generic_shutdown();
 #ifdef CONFIG_SMP
-	smp_call_function(octeon_kexec_smp_down, NULL, 0);
+	smp_xcall(XCALL_ALL, octeon_kexec_smp_down, NULL, XCALL_TYPE_ASYNC);
 	smp_wmb();
 	while (num_online_cpus() > 1) {
 		cpu_relax();
@@ -469,7 +469,7 @@ static void octeon_kill_core(void *arg)
  */
 static void octeon_halt(void)
 {
-	smp_call_function(octeon_kill_core, NULL, 0);
+	smp_xcall(XCALL_ALL, octeon_kill_core, NULL, XCALL_TYPE_ASYNC);
 
 	switch (octeon_bootinfo->board_type) {
 	case CVMX_BOARD_TYPE_NAO38:
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 81845ba04835..3c28e5627f89 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -63,7 +63,7 @@ static void crash_kexec_prepare_cpus(void)
 
 	ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
 
-	smp_call_function(crash_shutdown_secondary, NULL, 0);
+	smp_xcall(XCALL_ALL, crash_shutdown_secondary, NULL, XCALL_TYPE_ASYNC);
 	smp_wmb();
 
 	/*
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 432bfd3e7f22..f995c82b0375 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -139,7 +139,7 @@ machine_shutdown(void)
 		_machine_kexec_shutdown();
 
 #ifdef CONFIG_SMP
-	smp_call_function(kexec_shutdown_secondary, NULL, 0);
+	smp_xcall(XCALL_ALL, kexec_shutdown_secondary, NULL, XCALL_TYPE_ASYNC);
 
 	while (num_online_cpus() > 1) {
 		cpu_relax();
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 1641d274fe37..88ab3bc40741 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -642,8 +642,9 @@ static void hw_perf_event_destroy(struct perf_event *event)
 		 * We must not call the destroy function with interrupts
 		 * disabled.
 		 */
-		on_each_cpu(reset_counters,
-			(void *)(long)mipspmu.num_counters, 1);
+		smp_xcall(XCALL_ALL, reset_counters,
+			(void *)(long)mipspmu.num_counters, XCALL_TYPE_SYNC);
+
 		mipspmu_free_irq();
 		mutex_unlock(&pmu_reserve_mutex);
 	}
@@ -2043,7 +2044,7 @@ init_hw_perf_events(void)
 		mipspmu.write_counter = mipsxx_pmu_write_counter;
 	}
 
-	on_each_cpu(reset_counters, (void *)(long)counters, 1);
+	smp_xcall(XCALL_ALL, reset_counters, (void *)(long)counters, XCALL_TYPE_SYNC);
 
 	pr_cont("%s PMU enabled, %d %d-bit counters available to each "
 		"CPU, irq %d%s\n", mipspmu.name, counters, counter_bits, irq,
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 1986d1309410..d5bb38bfaef5 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -397,7 +397,7 @@ static void stop_this_cpu(void *dummy)
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 0);
+	smp_xcall(XCALL_ALL, stop_this_cpu, NULL, XCALL_TYPE_ASYNC);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
@@ -472,7 +472,7 @@ void flush_tlb_all(void)
 		return;
 	}
 
-	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
+	smp_xcall(XCALL_ALL, flush_tlb_all_ipi, NULL, XCALL_TYPE_SYNC);
 }
 
 static void flush_tlb_mm_ipi(void *mm)
@@ -490,7 +490,7 @@ static void flush_tlb_mm_ipi(void *mm)
  */
 static inline void smp_on_other_tlbs(void (*func) (void *info), void *info)
 {
-	smp_call_function(func, info, 1);
+	smp_xcall(XCALL_ALL, func, info, XCALL_TYPE_SYNC);
 }
 
 static inline void smp_on_each_tlb(void (*func) (void *info), void *info)
@@ -617,7 +617,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		.addr2 = end,
 	};
 
-	on_each_cpu(flush_tlb_kernel_range_ipi, &fd, 1);
+	smp_xcall(XCALL_ALL, flush_tlb_kernel_range_ipi, &fd, XCALL_TYPE_SYNC);
 }
 
 static void flush_tlb_page_ipi(void *info)
diff --git a/arch/mips/kernel/sysrq.c b/arch/mips/kernel/sysrq.c
index 9c1a2019113b..352ace351a5c 100644
--- a/arch/mips/kernel/sysrq.c
+++ b/arch/mips/kernel/sysrq.c
@@ -38,7 +38,7 @@ static void sysrq_tlbdump_single(void *dummy)
 #ifdef CONFIG_SMP
 static void sysrq_tlbdump_othercpus(struct work_struct *dummy)
 {
-	smp_call_function(sysrq_tlbdump_single, NULL, 0);
+	smp_xcall(XCALL_ALL, sysrq_tlbdump_single, NULL, XCALL_TYPE_ASYNC);
 }
 
 static DECLARE_WORK(sysrq_tlbdump, sysrq_tlbdump_othercpus);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ccb9e47322b0..451662ee259c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -96,8 +96,8 @@ static inline void r4k_on_each_cpu(unsigned int type,
 {
 	preempt_disable();
 	if (r4k_op_needs_ipi(type))
-		smp_call_function_many(&cpu_foreign_map[smp_processor_id()],
-				       func, info, 1);
+		smp_xcall_mask(&cpu_foreign_map[smp_processor_id()],
+				       func, info, XCALL_TYPE_SYNC);
 	func(info);
 	preempt_enable();
 }
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 1a504294d85f..d3bc788cec0e 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -57,7 +57,7 @@ static void __noreturn cfe_linux_exit(void *arg)
 		if (!reboot_smp) {
 			/* Get CPU 0 to do the cfe_exit */
 			reboot_smp = 1;
-			smp_call_function(cfe_linux_exit, arg, 0);
+			smp_xcall(XCALL_ALL, cfe_linux_exit, arg, XCALL_TYPE_ASYNC);
 		}
 	} else {
 		printk("Passing control back to CFE...\n");
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 27041db2c8b0..45e35fde4030 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -194,7 +194,7 @@ static void stop_this_cpu(void *dummy)
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 0);
+	smp_xcall(XCALL_ALL, stop_this_cpu, NULL, XCALL_TYPE_ASYNC);
 }
 
 /* not supported, yet */
@@ -244,7 +244,7 @@ static void smp_flush_tlb_mm(struct cpumask *cmask, struct mm_struct *mm)
 		/* local cpu is the only cpu present in cpumask */
 		local_flush_tlb_mm(mm);
 	} else {
-		on_each_cpu_mask(cmask, ipi_flush_tlb_mm, mm, 1);
+		smp_xcall_mask(cmask, ipi_flush_tlb_mm, mm, XCALL_TYPE_SYNC);
 	}
 	put_cpu();
 }
@@ -291,16 +291,16 @@ static void smp_flush_tlb_range(const struct cpumask *cmask, unsigned long start
 		fd.addr2 = end;
 
 		if ((end - start) <= PAGE_SIZE)
-			on_each_cpu_mask(cmask, ipi_flush_tlb_page, &fd, 1);
+			smp_xcall_mask(cmask, ipi_flush_tlb_page, &fd, XCALL_TYPE_SYNC);
 		else
-			on_each_cpu_mask(cmask, ipi_flush_tlb_range, &fd, 1);
+			smp_xcall_mask(cmask, ipi_flush_tlb_range, &fd, XCALL_TYPE_SYNC);
 	}
 	put_cpu();
 }
 
 void flush_tlb_all(void)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_all, NULL, XCALL_TYPE_SYNC);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
@@ -331,6 +331,6 @@ static void ipi_icache_page_inv(void *arg)
 
 void smp_icache_page_inv(struct page *page)
 {
-	on_each_cpu(ipi_icache_page_inv, page, 1);
+	smp_xcall(XCALL_ALL, ipi_icache_page_inv, page, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(smp_icache_page_inv);
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 23348199f3f8..8619591439c6 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -81,13 +81,13 @@ void flush_cache_all_local(void)
 void flush_cache_all(void)
 {
 	if (static_branch_likely(&parisc_has_cache))
-		on_each_cpu(cache_flush_local_cpu, NULL, 1);
+		smp_xcall(XCALL_ALL, cache_flush_local_cpu, NULL, XCALL_TYPE_SYNC);
 }
 
 static inline void flush_data_cache(void)
 {
 	if (static_branch_likely(&parisc_has_dcache))
-		on_each_cpu(flush_data_cache_local, NULL, 1);
+		smp_xcall(XCALL_ALL, flush_data_cache_local, NULL, XCALL_TYPE_SYNC);
 }
 
 
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 1dc2e88e7b04..3cf4f06e8386 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -847,7 +847,7 @@ void flush_tlb_all(void)
 	    do_recycle++;
 	}
 	spin_unlock(&sid_lock);
-	on_each_cpu(flush_tlb_all_local, NULL, 1);
+	smp_xcall(XCALL_ALL, lush_tlb_all_local, NULL, XCALL_TYPE_SYNC);
 	if (do_recycle) {
 	    spin_lock(&sid_lock);
 	    recycle_sids(recycle_ndirty,recycle_dirty_array);
diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index 64e423d2fe0f..58031057ec1e 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -77,7 +77,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 
 	/* If we are clearing, make sure all CPUs have the DAWR cleared */
 	if (!dawr_force_enable)
-		smp_call_function(disable_dawrs_cb, NULL, 0);
+		smp_xcall(XCALL_ALL, disable_dawrs_cb, NULL, XCALL_TYPE_ASYNC);
 
 	return rc;
 }
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 6568823cf306..6923156e2379 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -666,7 +666,7 @@ static void __init kvm_use_magic_page(void)
 	u32 features;
 
 	/* Tell the host to map the magic page to -4096 on all CPUs */
-	on_each_cpu(kvm_map_magic_page, &features, 1);
+	smp_xcall(XCALL_ALL, kvm_map_magic_page, &features, XCALL_TYPE_SYNC);
 
 	/* Quick self-test to see if the mapping works */
 	if (fault_in_readable((const char __user *)KVM_MAGIC_PAGE,
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index d96fd14bd7c9..31a4e9856e00 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -607,7 +607,7 @@ void rfi_flush_enable(bool enable)
 {
 	if (enable) {
 		do_rfi_flush_fixups(enabled_flush_types);
-		on_each_cpu(do_nothing, NULL, 1);
+		smp_xcall(XCALL_ALL, do_nothing, NULL, XCALL_TYPE_SYNC);
 	} else
 		do_rfi_flush_fixups(L1D_FLUSH_NONE);
 
@@ -618,7 +618,7 @@ static void entry_flush_enable(bool enable)
 {
 	if (enable) {
 		do_entry_flush_fixups(enabled_flush_types);
-		on_each_cpu(do_nothing, NULL, 1);
+		smp_xcall(XCALL_ALL, do_nothing, NULL, XCALL_TYPE_SYNC);
 	} else {
 		do_entry_flush_fixups(L1D_FLUSH_NONE);
 	}
@@ -631,7 +631,7 @@ static void uaccess_flush_enable(bool enable)
 	if (enable) {
 		do_uaccess_flush_fixups(enabled_flush_types);
 		static_branch_enable(&uaccess_flush_key);
-		on_each_cpu(do_nothing, NULL, 1);
+		smp_xcall(XCALL_ALL, do_nothing, NULL, XCALL_TYPE_SYNC);
 	} else {
 		static_branch_disable(&uaccess_flush_key);
 		do_uaccess_flush_fixups(L1D_FLUSH_NONE);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index de0f6f09a5dd..5650a1510cb7 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -655,7 +655,7 @@ void crash_smp_send_stop(void)
 #ifdef CONFIG_NMI_IPI
 	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_stop_this_cpu, 1000000);
 #else
-	smp_call_function(crash_stop_this_cpu, NULL, 0);
+	smp_xcall(XCALL_ALL, crash_stop_this_cpu, NULL, XCALL_TYPE_ASYNC);
 #endif /* CONFIG_NMI_IPI */
 }
 
@@ -711,7 +711,7 @@ void smp_send_stop(void)
 
 	stopped = true;
 
-	smp_call_function(stop_this_cpu, NULL, 0);
+	smp_xcall(XCALL_ALL, stop_this_cpu, NULL, XCALL_TYPE_ASYNC);
 }
 #endif /* CONFIG_NMI_IPI */
 
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 2069bbb90a9a..0ce6aff8eca0 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -206,7 +206,7 @@ static ssize_t __used store_dscr_default(struct device *dev,
 		return -EINVAL;
 	dscr_default = val;
 
-	on_each_cpu(write_dscr, &val, 1);
+	smp_xcall(XCALL_ALL, write_dscr, &val, XCALL_TYPE_SYNC);
 
 	return count;
 }
diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index 828d0f4106d2..fac64b71fc93 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -158,7 +158,7 @@ static struct workqueue_struct *tau_workq;
 static void tau_work_func(struct work_struct *work)
 {
 	msleep(shrink_timer);
-	on_each_cpu(tau_timeout, NULL, 0);
+	smp_xcall(XCALL_ALL, tau_timeout, NULL, XCALL_TYPE_ASYNC);
 	/* schedule ourselves to be run again */
 	queue_work(tau_workq, work);
 }
@@ -204,7 +204,7 @@ static int __init TAU_init(void)
 	if (!tau_workq)
 		return -ENOMEM;
 
-	on_each_cpu(TAU_init_smp, NULL, 0);
+	smp_xcall(XCALL_ALL, TAU_init_smp, NULL, XCALL_TYPE_ASYNC);
 
 	queue_work(tau_workq, &tau_work);
 
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 6cc7793b8420..7f9f4477749a 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -225,7 +225,7 @@ static void wake_offline_cpus(void)
 static void kexec_prepare_cpus(void)
 {
 	wake_offline_cpus();
-	smp_call_function(kexec_smp_down, NULL, /* wait */0);
+	smp_xcall(XCALL_ALL, kexec_smp_down, NULL, XCALL_TYPE_ASYNC);
 	local_irq_disable();
 	hard_irq_disable();
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 0aeb51738ca9..433a04ac48dc 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1555,7 +1555,7 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
 
 	/* Boot all CPUs out of the guest so they re-read
 	 * mmu_ready */
-	on_each_cpu(resize_hpt_boot_vcpu, NULL, 1);
+	smp_xcall(XCALL_ALL, resize_hpt_boot_vcpu, NULL, XCALL_TYPE_SYNC);
 
 	ret = -ENXIO;
 	if (!resize || (resize->order != shift))
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 052e6590f84f..b7129b2bab5b 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -111,7 +111,7 @@ static void do_serialize(void *arg)
 void serialize_against_pte_lookup(struct mm_struct *mm)
 {
 	smp_mb();
-	smp_call_function_many(mm_cpumask(mm), do_serialize, mm, 1);
+	smp_xcall_mask(mm_cpumask(mm), do_serialize, mm, XCALL_TYPE_SYNC);
 }
 
 /*
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 7724af19ed7e..2e46ef59ce5b 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -464,7 +464,7 @@ static inline void _tlbiel_pid_multicast(struct mm_struct *mm,
 	struct cpumask *cpus = mm_cpumask(mm);
 	struct tlbiel_pid t = { .pid = pid, .ric = ric };
 
-	on_each_cpu_mask(cpus, do_tlbiel_pid, &t, 1);
+	smp_xcall_mask(cpus, do_tlbiel_pid, &t, XCALL_TYPE_SYNC);
 	/*
 	 * Always want the CPU translations to be invalidated with tlbiel in
 	 * these paths, so while coprocessors must use tlbie, we can not
@@ -616,7 +616,7 @@ static inline void _tlbiel_va_multicast(struct mm_struct *mm,
 {
 	struct cpumask *cpus = mm_cpumask(mm);
 	struct tlbiel_va t = { .va = va, .pid = pid, .psize = psize, .ric = ric };
-	on_each_cpu_mask(cpus, do_tlbiel_va, &t, 1);
+	smp_xcall_mask(cpus, do_tlbiel_va, &t, XCALL_TYPE_SYNC);
 	if (atomic_read(&mm->context.copros) > 0)
 		_tlbie_va(va, pid, psize, RIC_FLUSH_TLB);
 }
@@ -682,7 +682,7 @@ static inline void _tlbiel_va_range_multicast(struct mm_struct *mm,
 				.pid = pid, .page_size = page_size,
 				.psize = psize, .also_pwc = also_pwc };
 
-	on_each_cpu_mask(cpus, do_tlbiel_va_range, &t, 1);
+	smp_xcall_mask(cpus, do_tlbiel_va_range, &t, XCALL_TYPE_SYNC);
 	if (atomic_read(&mm->context.copros) > 0)
 		_tlbie_va_range(start, end, pid, page_size, psize, also_pwc);
 }
@@ -827,8 +827,8 @@ static void exit_flush_lazy_tlbs(struct mm_struct *mm)
 	 * make a special powerpc IPI for flushing TLBs.
 	 * For now it's not too performance critical.
 	 */
-	smp_call_function_many(mm_cpumask(mm), do_exit_flush_lazy_tlb,
-				(void *)mm, 1);
+	smp_xcall_mask(mm_cpumask(mm), do_exit_flush_lazy_tlb,
+				(void *)mm, XCALL_TYPE_SYNC);
 }
 
 #else /* CONFIG_SMP */
@@ -1064,7 +1064,7 @@ static void do_tlbiel_kernel(void *info)
 
 static inline void _tlbiel_kernel_broadcast(void)
 {
-	on_each_cpu(do_tlbiel_kernel, NULL, 1);
+	smp_xcall(XCALL_ALL, do_tlbiel_kernel, NULL, XCALL_TYPE_SYNC);
 	if (tlbie_capable) {
 		/*
 		 * Coherent accelerators don't refcount kernel memory mappings,
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index fd2c77af5c55..fca3e4ebbfd1 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -276,8 +276,8 @@ void flush_tlb_mm(struct mm_struct *mm)
 	if (!mm_is_core_local(mm)) {
 		struct tlb_flush_param p = { .pid = pid };
 		/* Ignores smp_processor_id() even if set. */
-		smp_call_function_many(mm_cpumask(mm),
-				       do_flush_tlb_mm_ipi, &p, 1);
+		smp_xcall_mask(mm_cpumask(mm),
+			       do_flush_tlb_mm_ipi, &p, XCALL_TYPE_SYNC);
 	}
 	_tlbil_pid(pid);
  no_context:
@@ -321,8 +321,8 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 				.ind = ind,
 			};
 			/* Ignores smp_processor_id() even if set in cpu_mask */
-			smp_call_function_many(cpu_mask,
-					       do_flush_tlb_page_ipi, &p, 1);
+			smp_xcall_mask(cpu_mask,
+				       do_flush_tlb_page_ipi, &p, XCALL_TYPE_SYNC);
 		}
 	}
 	_tlbil_va(vmaddr, pid, tsize, ind);
@@ -362,7 +362,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 #ifdef CONFIG_SMP
 	preempt_disable();
-	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
+	smp_xcall(XCALL_ALL, do_flush_tlb_mm_ipi, NULL, XCALL_TYPE_SYNC);
 	_tlbil_pid(0);
 	preempt_enable();
 #else
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index f42711f865f3..a3348fc0e1fe 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -464,7 +464,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 */
 		mm_ctx_set_slb_addr_limit(&mm->context, high_limit);
 
-		on_each_cpu(slice_flush_segments, mm, 1);
+		smp_xcall(XCALL_ALL, slice_flush_segments, mm, XCALL_TYPE_SYNC);
 	}
 
 	/* Sanity checks */
@@ -626,7 +626,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 !bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH))) {
 		slice_convert(mm, &potential_mask, psize);
 		if (psize > MMU_PAGE_BASE)
-			on_each_cpu(slice_flush_segments, mm, 1);
+			smp_xcall(XCALL_ALL, slice_flush_segments, mm, XCALL_TYPE_SYNC);
 	}
 	return newaddr;
 
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b5b42cf0a703..d87477afe337 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2529,7 +2529,7 @@ static int __init init_ppc64_pmu(void)
 {
 	if (cpu_has_feature(CPU_FTR_HVMODE) && pmu_override) {
 		pr_warn("disabling perf due to pmu_override= command line option.\n");
-		on_each_cpu(do_pmu_override, NULL, 1);
+		smp_xcall(XCALL_ALL, do_pmu_override, NULL, XCALL_TYPE_SYNC);
 		return 0;
 	}
 
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 526d4b767534..0e367f651df7 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1583,7 +1583,7 @@ static void thread_imc_ldbar_disable(void *dummy)
 
 void thread_imc_disable(void)
 {
-	on_each_cpu(thread_imc_ldbar_disable, NULL, 1);
+	smp_xcall(XCALL_ALL, thread_imc_ldbar_disable, NULL, XCALL_TYPE_SYNC);
 }
 
 static void cleanup_all_thread_imc_memory(void)
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a1c6a7827c8f..ca4995a39884 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -445,7 +445,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 	int i, num_cpus = num_present_cpus();
 
 	if (image->type == KEXEC_TYPE_DEFAULT)
-		smp_call_function(mpc85xx_smp_kexec_down, NULL, 0);
+		smp_xcall(XCALL_ALL, mpc85xx_smp_kexec_down, NULL, XCALL_TYPE_ASYNC);
 
 	while ( (atomic_read(&kexec_down_cpus) != (num_cpus - 1)) &&
 		( timeout > 0 ) )
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index a6677a111aca..9b6136338df3 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -202,7 +202,7 @@ static ssize_t store_fastsleep_workaround_applyonce(struct device *dev,
 	power7_fastsleep_workaround_exit = false;
 
 	cpus_read_lock();
-	on_each_cpu(pnv_fastsleep_workaround_apply, &err, 1);
+	smp_xcall(XCALL_ALL, pnv_fastsleep_workaround_apply, &err, XCALL_TYPE_SYNC);
 	cpus_read_unlock();
 	if (err) {
 		pr_err("fastsleep_workaround_applyonce change failed while running pnv_fastsleep_workaround_apply");
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 2119c003fcf9..8f5fdf69155a 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -61,7 +61,7 @@ static unsigned long get_purr(void)
 {
 	atomic64_t purr = ATOMIC64_INIT(0);
 
-	on_each_cpu(cpu_get_purr, &purr, 1);
+	smp_xcall(XCALL_ALL, cpu_get_purr, &purr, XCALL_TYPE_SYNC);
 
 	return atomic64_read(&purr);
 }
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..dbfa13c52742 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -21,7 +21,7 @@ void flush_icache_all(void)
 	if (IS_ENABLED(CONFIG_RISCV_SBI))
 		sbi_remote_fence_i(NULL);
 	else
-		on_each_cpu(ipi_remote_fence_i, NULL, 1);
+		smp_xcall(XCALL_ALL, ipi_remote_fence_i, NULL, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(flush_icache_all);
 
@@ -69,7 +69,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
 		sbi_remote_fence_i(&others);
 	} else {
-		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
+		smp_xcall_mask(&others, ipi_remote_fence_i, NULL, XCALL_TYPE_SYNC);
 	}
 
 	preempt_enable();
diff --git a/arch/s390/hypfs/hypfs_diag0c.c b/arch/s390/hypfs/hypfs_diag0c.c
index 9a2786079e3a..41c0a95d20d3 100644
--- a/arch/s390/hypfs/hypfs_diag0c.c
+++ b/arch/s390/hypfs/hypfs_diag0c.c
@@ -51,7 +51,7 @@ static void *diag0c_store(unsigned int *count)
 		cpu_vec[cpu] = &diag0c_data->entry[i++];
 	}
 	/* Collect data all CPUs */
-	on_each_cpu(diag0c_fn, cpu_vec, 1);
+	smp_xcall(XCALL_ALL, diag0c_fn, cpu_vec, XCALL_TYPE_SYNC);
 	*count = cpu_count;
 	kfree(cpu_vec);
 	cpus_read_unlock();
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index cce0ddee2d02..cf6808d25d8f 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -121,7 +121,7 @@ static void do_sync_core(void *info)
 
 void text_poke_sync(void)
 {
-	on_each_cpu(do_sync_core, NULL, 1);
+	smp_xcall(XCALL_ALL, do_sync_core, NULL, XCALL_TYPE_SYNC);
 }
 
 void text_poke_sync_lock(void)
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 483ab5e10164..0787ea07c003 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -923,7 +923,7 @@ static void cfset_all_stop(struct cfset_request *req)
 	};
 
 	cpumask_and(&req->mask, &req->mask, cpu_online_mask);
-	on_each_cpu_mask(&req->mask, cfset_ioctl_off, &p, 1);
+	smp_xcall_mask(&req->mask, cfset_ioctl_off, &p, XCALL_TYPE_SYNC);
 }
 
 /* Release function is also called when application gets terminated without
@@ -940,7 +940,7 @@ static int cfset_release(struct inode *inode, struct file *file)
 		file->private_data = NULL;
 	}
 	if (!atomic_dec_return(&cfset_opencnt))
-		on_each_cpu(cfset_release_cpu, NULL, 1);
+		smp_xcall(XCALL_ALL, cfset_release_cpu, NULL, XCALL_TYPE_SYNC);
 	mutex_unlock(&cfset_ctrset_mutex);
 
 	hw_perf_event_destroy(NULL);
@@ -974,9 +974,9 @@ static int cfset_all_start(struct cfset_request *req)
 	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
 		return -ENOMEM;
 	cpumask_and(mask, &req->mask, cpu_online_mask);
-	on_each_cpu_mask(mask, cfset_ioctl_on, &p, 1);
+	smp_xcall_mask(mask, cfset_ioctl_on, &p, XCALL_TYPE_SYNC);
 	if (atomic_read(&p.cpus_ack) != cpumask_weight(mask)) {
-		on_each_cpu_mask(mask, cfset_ioctl_off, &p, 1);
+		smp_xcall_mask(mask, cfset_ioctl_off, &p, XCALL_TYPE_SYNC);
 		rc = -EIO;
 		debug_sprintf_event(cf_dbg, 4, "%s CPUs missing", __func__);
 	}
@@ -1100,7 +1100,7 @@ static int cfset_all_read(unsigned long arg, struct cfset_request *req)
 
 	p.sets = req->ctrset;
 	cpumask_and(mask, &req->mask, cpu_online_mask);
-	on_each_cpu_mask(mask, cfset_cpu_read, &p, 1);
+	smp_xcall_mask(mask, cfset_cpu_read, &p, XCALL_TYPE_SYNC);
 	rc = cfset_all_copy(arg, mask);
 	free_cpumask_var(mask);
 	return rc;
diff --git a/arch/s390/kernel/perf_cpum_cf_common.c b/arch/s390/kernel/perf_cpum_cf_common.c
index 8ee48672233f..e67211b4f518 100644
--- a/arch/s390/kernel/perf_cpum_cf_common.c
+++ b/arch/s390/kernel/perf_cpum_cf_common.c
@@ -105,7 +105,7 @@ int __kernel_cpumcf_begin(void)
 {
 	int flags = PMC_INIT;
 
-	on_each_cpu(cpum_cf_setup_cpu, &flags, 1);
+	smp_xcall(XCALL_ALL, cpum_cf_setup_cpu, &flags, XCALL_TYPE_SYNC);
 	irq_subclass_register(IRQ_SUBCLASS_MEASUREMENT_ALERT);
 
 	return 0;
@@ -131,7 +131,7 @@ void __kernel_cpumcf_end(void)
 {
 	int flags = PMC_RELEASE;
 
-	on_each_cpu(cpum_cf_setup_cpu, &flags, 1);
+	smp_xcall(XCALL_ALL, cpum_cf_setup_cpu, &flags, XCALL_TYPE_SYNC);
 	irq_subclass_unregister(IRQ_SUBCLASS_MEASUREMENT_ALERT);
 }
 EXPORT_SYMBOL(__kernel_cpumcf_end);
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..b0a7e8574b4b 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -582,14 +582,14 @@ static void release_pmc_hardware(void)
 	int flags = PMC_RELEASE;
 
 	irq_subclass_unregister(IRQ_SUBCLASS_MEASUREMENT_ALERT);
-	on_each_cpu(setup_pmc_cpu, &flags, 1);
+	smp_xcall(XCALL_ALL, setup_pmc_cpu, &flags, XCALL_TYPE_SYNC);
 }
 
 static int reserve_pmc_hardware(void)
 {
 	int flags = PMC_INIT;
 
-	on_each_cpu(setup_pmc_cpu, &flags, 1);
+	smp_xcall(XCALL_ALL, setup_pmc_cpu, &flags, XCALL_TYPE_SYNC);
 	if (flags & PMC_FAILURE) {
 		release_pmc_hardware();
 		return -ENODEV;
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 7a74ea5f7531..ebb32b5cde40 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -62,7 +62,7 @@ void s390_update_cpu_mhz(void)
 {
 	s390_adjust_jiffies();
 	if (machine_has_cpu_mhz)
-		on_each_cpu(update_cpu_mhz, NULL, 0);
+		smp_xcall(XCALL_ALL, update_cpu_mhz, NULL, XCALL_TYPE_ASYNC);
 }
 
 void notrace stop_machine_yield(const struct cpumask *cpumask)
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 30c91d565933..c42190d4bd4f 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -595,7 +595,7 @@ void smp_ctl_set_clear_bit(int cr, int bit, bool set)
 	ctlreg = (ctlreg & parms.andval) | parms.orval;
 	put_abs_lowcore(cregs_save_area[cr], ctlreg);
 	spin_unlock(&ctl_lock);
-	on_each_cpu(smp_ctl_bit_callback, &parms, 1);
+	smp_xcall(XCALL_ALL, smp_ctl_bit_callback, &parms, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(smp_ctl_set_clear_bit);
 
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index c6eecd4a5302..3a4a52b9bc9e 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -322,7 +322,7 @@ int arch_update_cpu_topology(void)
 	int cpu, rc;
 
 	rc = __arch_update_cpu_topology();
-	on_each_cpu(__arch_update_dedicated_flag, NULL, 0);
+	smp_xcall(XCALL_ALL, __arch_update_dedicated_flag, NULL, XCALL_TYPE_ASYNC);
 	for_each_online_cpu(cpu) {
 		dev = get_cpu_device(cpu);
 		if (dev)
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 2de48b2c1b04..fa3afbe85f2d 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -131,7 +131,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 
 	spin_unlock_bh(&mm->page_table_lock);
 
-	on_each_cpu(__crst_table_upgrade, mm, 0);
+	smp_xcall(XCALL_ALL, __crst_table_upgrade, mm, XCALL_TYPE_ASYNC);
 
 	return 0;
 
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 500cd2dbdf53..325c42c6ddb4 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -440,7 +440,7 @@ static int __init zpci_directed_irq_init(void)
 		if (!zpci_ibv[cpu])
 			return -ENOMEM;
 	}
-	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
+	smp_xcall(XCALL_ALL, cpu_enable_directed_irq, NULL, XCALL_TYPE_SYNC);
 
 	zpci_irq_chip.irq_set_affinity = zpci_set_irq_affinity;
 
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 65924d9ec245..3f1afc1b18fa 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -263,7 +263,7 @@ void smp_send_reschedule(int cpu)
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, 0, 0);
+	smp_xcall(XCALL_ALL, stop_this_cpu, NULL, XCALL_TYPE_ASYNC);
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
@@ -335,7 +335,7 @@ static void flush_tlb_all_ipi(void *info)
 
 void flush_tlb_all(void)
 {
-	on_each_cpu(flush_tlb_all_ipi, 0, 1);
+	smp_xcall(XCALL_ALL, flush_tlb_all_ipi, NULL, XCALL_TYPE_SYNC);
 }
 
 static void flush_tlb_mm_ipi(void *mm)
@@ -360,7 +360,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 	preempt_disable();
 
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
-		smp_call_function(flush_tlb_mm_ipi, (void *)mm, 1);
+		smp_xcall(XCALL_ALL, flush_tlb_mm_ipi, (void *)mm, XCALL_TYPE_SYNC);
 	} else {
 		int i;
 		for_each_online_cpu(i)
@@ -397,7 +397,7 @@ void flush_tlb_range(struct vm_area_struct *vma,
 		fd.vma = vma;
 		fd.addr1 = start;
 		fd.addr2 = end;
-		smp_call_function(flush_tlb_range_ipi, (void *)&fd, 1);
+		smp_xcall(XCALL_ALL, flush_tlb_range_ipi, (void *)&fd, XCALL_TYPE_SYNC);
 	} else {
 		int i;
 		for_each_online_cpu(i)
@@ -421,7 +421,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 
 	fd.addr1 = start;
 	fd.addr2 = end;
-	on_each_cpu(flush_tlb_kernel_range_ipi, (void *)&fd, 1);
+	smp_xcall(XCALL_ALL, flush_tlb_kernel_range_ipi, (void *)&fd, XCALL_TYPE_SYNC);
 }
 
 static void flush_tlb_page_ipi(void *info)
@@ -440,7 +440,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 
 		fd.vma = vma;
 		fd.addr1 = page;
-		smp_call_function(flush_tlb_page_ipi, (void *)&fd, 1);
+		smp_xcall(XCALL_ALL, flush_tlb_page_ipi, (void *)&fd, XCALL_TYPE_SYNC);
 	} else {
 		int i;
 		for_each_online_cpu(i)
@@ -464,7 +464,7 @@ void flush_tlb_one(unsigned long asid, unsigned long vaddr)
 	fd.addr1 = asid;
 	fd.addr2 = vaddr;
 
-	smp_call_function(flush_tlb_one_ipi, (void *)&fd, 1);
+	smp_xcall(XCALL_ALL, flush_tlb_one_ipi, (void *)&fd, XCALL_TYPE_SYNC);
 	local_flush_tlb_one(asid, vaddr);
 }
 
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 3aef78ceb820..67eef4bf42e3 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -49,7 +49,7 @@ static inline void cacheop_on_each_cpu(void (*func) (void *info), void *info,
 	 * even attempt IPIs unless there are other CPUs online.
 	 */
 	if (num_online_cpus() > 1)
-		smp_call_function(func, info, wait);
+		smp_xcall(XCALL_ALL, func, info, (wait ? XCALL_TYPE_SYNC : XCALL_TYPE_ASYNC));
 #endif
 
 	func(info);
diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index 274217e7ed70..ce7a2be6df0b 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -37,8 +37,8 @@ static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
 			regs = task_pt_regs(current);
 			regs->tstate |= TSTATE_MCDE;
 			current->mm->context.adi = true;
-			on_each_cpu_mask(mm_cpumask(current->mm),
-					 ipi_set_tstate_mcde, current->mm, 0);
+			smp_xcall_mask(mm_cpumask(current->mm),
+				ipi_set_tstate_mcde, current->mm, XCALL_TYPE_ASYNC);
 		}
 		return VM_SPARC_ADI;
 	} else {
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 060fff95a305..ff789082d5ab 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -176,7 +176,7 @@ static int __init check_nmi_watchdog(void)
 
 	printk(KERN_INFO "Testing NMI watchdog ... ");
 
-	smp_call_function(nmi_cpu_busy, (void *)&endflag, 0);
+	smp_xcall(XCALL_ALL, nmi_cpu_busy, (void *)&endflag, XCALL_TYPE_ASYNC);
 
 	for_each_possible_cpu(cpu)
 		prev_nmi_count[cpu] = get_nmi_count(cpu);
@@ -203,7 +203,7 @@ static int __init check_nmi_watchdog(void)
 	kfree(prev_nmi_count);
 	return 0;
 error:
-	on_each_cpu(stop_nmi_watchdog, NULL, 1);
+	smp_xcall(XCALL_ALL, stop_nmi_watchdog, NULL, XCALL_TYPE_SYNC);
 	return err;
 }
 
@@ -235,13 +235,13 @@ static void nmi_adjust_hz_one(void *unused)
 void nmi_adjust_hz(unsigned int new_hz)
 {
 	nmi_hz = new_hz;
-	on_each_cpu(nmi_adjust_hz_one, NULL, 1);
+	smp_xcall(XCALL_ALL, nmi_adjust_hz_one, NULL, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL_GPL(nmi_adjust_hz);
 
 static int nmi_shutdown(struct notifier_block *nb, unsigned long cmd, void *p)
 {
-	on_each_cpu(stop_nmi_watchdog, NULL, 1);
+	smp_xcall(XCALL_ALL, stop_nmi_watchdog, NULL, XCALL_TYPE_SYNC);
 	return 0;
 }
 
@@ -253,13 +253,13 @@ int __init nmi_init(void)
 {
 	int err;
 
-	on_each_cpu(start_nmi_watchdog, NULL, 1);
+	smp_xcall(XCALL_ALL, start_nmi_watchdog, NULL, XCALL_TYPE_SYNC);
 
 	err = check_nmi_watchdog();
 	if (!err) {
 		err = register_reboot_notifier(&nmi_reboot_notifier);
 		if (err) {
-			on_each_cpu(stop_nmi_watchdog, NULL, 1);
+			smp_xcall(XCALL_ALL, stop_nmi_watchdog, NULL, XCALL_TYPE_SYNC);
 			atomic_set(&nmi_active, -1);
 		}
 	}
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index a58ae9c42803..e6038831a4f0 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1176,7 +1176,7 @@ static void perf_event_grab_pmc(void)
 	mutex_lock(&pmc_grab_mutex);
 	if (atomic_read(&active_events) == 0) {
 		if (atomic_read(&nmi_active) > 0) {
-			on_each_cpu(perf_stop_nmi_watchdog, NULL, 1);
+			smp_xcall(XCALL_ALL, perf_stop_nmi_watchdog, NULL, XCALL_TYPE_SYNC);
 			BUG_ON(atomic_read(&nmi_active) != 0);
 		}
 		atomic_inc(&active_events);
@@ -1188,7 +1188,7 @@ static void perf_event_release_pmc(void)
 {
 	if (atomic_dec_and_mutex_lock(&active_events, &pmc_grab_mutex)) {
 		if (atomic_read(&nmi_active) == 0)
-			on_each_cpu(start_nmi_watchdog, NULL, 1);
+			smp_xcall(XCALL_ALL, start_nmi_watchdog, NULL, XCALL_TYPE_SYNC);
 		mutex_unlock(&pmc_grab_mutex);
 	}
 }
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index a1f78e9ddaf3..2785d660eb2a 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -901,7 +901,7 @@ static void tsb_sync(void *info)
 
 void smp_tsb_sync(struct mm_struct *mm)
 {
-	smp_call_function_many(mm_cpumask(mm), tsb_sync, mm, 1);
+	smp_xcall_mask(mm_cpumask(mm), tsb_sync, mm, XCALL_TYPE_SYNC);
 }
 
 extern unsigned long xcall_flush_tlb_mm;
@@ -1084,8 +1084,8 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 	info.nr = nr;
 	info.vaddrs = vaddrs;
 
-	smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
-			       &info, 1);
+	smp_xcall_mask(mm_cpumask(mm), tlb_pending_func,
+		       &info, XCALL_TYPE_SYNC);
 
 	__flush_tlb_pending(ctx, nr, vaddrs);
 
@@ -1523,7 +1523,7 @@ void smp_send_stop(void)
 				prom_stopcpu_cpuid(cpu);
 		}
 	} else
-		smp_call_function(stop_this_cpu, NULL, 0);
+		smp_xcall(XCALL_ALL, stop_this_cpu, NULL, XCALL_TYPE_ASYNC);
 }
 
 static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 8b1911591581..68c48edd012f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -3024,7 +3024,7 @@ void hugetlb_setup(struct pt_regs *regs)
 		spin_unlock_irq(&ctx_alloc_lock);
 
 		if (need_context_reload)
-			on_each_cpu(context_reload, mm, 0);
+			smp_xcall(XCALL_ALL, context_reload, mm, XCALL_TYPE_ASYNC);
 	}
 }
 #endif
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index eef816fc216d..bb0f3f6d8019 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2526,7 +2526,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	mmap_assert_write_locked(mm);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
-		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
+		smp_xcall_mask(mm_cpumask(mm), cr4_update_pce, NULL, XCALL_TYPE_SYNC);
 }
 
 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
@@ -2535,7 +2535,7 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 		return;
 
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
-		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
+		smp_xcall_mask(mm_cpumask(mm), cr4_update_pce, NULL, XCALL_TYPE_SYNC);
 }
 
 static int x86_pmu_event_idx(struct perf_event *event)
@@ -2591,7 +2591,7 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 		else if (x86_pmu.attr_rdpmc == 2)
 			static_branch_dec(&rdpmc_always_available_key);
 
-		on_each_cpu(cr4_update_pce, NULL, 1);
+		smp_xcall(XCALL_ALL, cr4_update_pce, NULL, XCALL_TYPE_SYNC);
 		x86_pmu.attr_rdpmc = val;
 	}
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fc7f458eb3de..f2b577e6b66d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5123,7 +5123,7 @@ static ssize_t freeze_on_smi_store(struct device *cdev,
 	x86_pmu.attr_freeze_on_smi = val;
 
 	cpus_read_lock();
-	on_each_cpu(flip_smm_bit, &val, 1);
+	smp_xcall(XCALL_ALL, flip_smm_bit, &val, XCALL_TYPE_SYNC);
 	cpus_read_unlock();
 done:
 	mutex_unlock(&freeze_on_smi_mutex);
@@ -5168,7 +5168,7 @@ static ssize_t set_sysctl_tfa(struct device *cdev,
 	allow_tsx_force_abort = val;
 
 	cpus_read_lock();
-	on_each_cpu(update_tfa_sched, NULL, 1);
+	smp_xcall(XCALL_ALL, update_tfa_sched, NULL, XCALL_TYPE_SYNC);
 	cpus_read_unlock();
 
 	return count;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d374cb3cf024..7721b55e58e5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1181,7 +1181,7 @@ static void do_sync_core(void *info)
 
 void text_poke_sync(void)
 {
-	on_each_cpu(do_sync_core, NULL, 1);
+	smp_xcall(XCALL_ALL, do_sync_core, NULL, XCALL_TYPE_SYNC);
 }
 
 struct text_poke_loc {
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 020c906f7934..b6276a0a21eb 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -488,7 +488,7 @@ static __init void fix_erratum_688(void)
 	if (val & BIT(2))
 		return;
 
-	on_each_cpu(__fix_erratum_688, NULL, 0);
+	smp_xcall(XCALL_ALL, __fix_erratum_688, NULL, XCALL_TYPE_ASYNC);
 
 	pr_info("x86/cpu/AMD: CPU erratum 688 worked around\n");
 }
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344bf6600..56f281fed53a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -656,7 +656,7 @@ void lapic_update_tsc_freq(void)
 	 * changed. In order to avoid races, schedule the frequency
 	 * update code on each CPU.
 	 */
-	on_each_cpu(__lapic_update_tsc_freq, NULL, 0);
+	smp_xcall(XCALL_ALL, __lapic_update_tsc_freq, NULL, XCALL_TYPE_ASYNC);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1ebed1d..d9d242993982 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1091,7 +1091,7 @@ static void update_stibp_strict(void)
 	pr_info("Update user space SMT mitigation: STIBP %s\n",
 		mask & SPEC_CTRL_STIBP ? "always-on" : "off");
 	x86_spec_ctrl_base = mask;
-	on_each_cpu(update_stibp_msr, NULL, 1);
+	smp_xcall(XCALL_ALL, update_stibp_msr, NULL, XCALL_TYPE_SYNC);
 }
 
 /* Update the static key controlling the evaluation of TIF_SPEC_IB */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 981496e6bc0e..7e021f6fa20b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2207,7 +2207,7 @@ void mce_disable_bank(int bank)
 		return;
 	}
 	set_bit(bank, mce_banks_ce_disabled);
-	on_each_cpu(__mce_disable_bank, &bank, 1);
+	smp_xcall(XCALL_ALL, __mce_disable_bank, &bank, XCALL_TYPE_SYNC);
 }
 
 /*
@@ -2362,7 +2362,7 @@ static void mce_cpu_restart(void *data)
 static void mce_restart(void)
 {
 	mce_timer_delete_all();
-	on_each_cpu(mce_cpu_restart, NULL, 1);
+	smp_xcall(XCALL_ALL, mce_cpu_restart, NULL, XCALL_TYPE_SYNC);
 }
 
 /* Toggle features for corrected errors */
@@ -2450,12 +2450,12 @@ static ssize_t set_ignore_ce(struct device *s,
 		if (new) {
 			/* disable ce features */
 			mce_timer_delete_all();
-			on_each_cpu(mce_disable_cmci, NULL, 1);
+			smp_xcall(XCALL_ALL, mce_disable_cmci, NULL, XCALL_TYPE_SYNC);
 			mca_cfg.ignore_ce = true;
 		} else {
 			/* enable ce features */
 			mca_cfg.ignore_ce = false;
-			on_each_cpu(mce_enable_ce, (void *)1, 1);
+			smp_xcall(XCALL_ALL, mce_enable_ce, (void *)1, XCALL_TYPE_SYNC);
 		}
 	}
 	mutex_unlock(&mce_sysfs_mutex);
@@ -2476,12 +2476,12 @@ static ssize_t set_cmci_disabled(struct device *s,
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
-			on_each_cpu(mce_disable_cmci, NULL, 1);
+			smp_xcall(XCALL_ALL, mce_disable_cmci, NULL, XCALL_TYPE_SYNC);
 			mca_cfg.cmci_disabled = true;
 		} else {
 			/* enable cmci */
 			mca_cfg.cmci_disabled = false;
-			on_each_cpu(mce_enable_ce, NULL, 1);
+			smp_xcall(XCALL_ALL, mce_enable_ce, NULL, XCALL_TYPE_SYNC);
 		}
 	}
 	mutex_unlock(&mce_sysfs_mutex);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5fbd7ffb3233..f23445733020 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -263,10 +263,8 @@ static void __maybe_unused raise_mce(struct mce *m)
 				 * don't wait because mce_irq_ipi is necessary
 				 * to be sync with following raise_local
 				 */
-				preempt_disable();
-				smp_call_function_many(mce_inject_cpumask,
-					mce_irq_ipi, NULL, 0);
-				preempt_enable();
+				smp_xcall_mask(mce_inject_cpumask,
+					mce_irq_ipi, NULL, XCALL_TYPE_ASYNC);
 			} else if (m->inject_flags & MCJ_NMI_BROADCAST)
 				apic->send_IPI_mask(mce_inject_cpumask,
 						NMI_VECTOR);
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..6385fff2051b 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -400,7 +400,7 @@ void cmci_rediscover(void)
 	if (!cmci_supported(&banks))
 		return;
 
-	on_each_cpu(cmci_rediscover_work_func, NULL, 1);
+	smp_xcall(XCALL_ALL, cmci_rediscover_work_func, NULL, XCALL_TYPE_SYNC);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 7e45da5f3c8b..5daf63859c95 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -326,7 +326,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		rdt_ctrl_update(&msr_param);
 	/* Update resource control msr on other CPUs. */
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
+	smp_xcall_mask(cpu_mask, rdt_ctrl_update, &msr_param, XCALL_TYPE_SYNC);
 	put_cpu();
 
 done:
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 83f901e2c2df..2fee32deb701 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -329,7 +329,7 @@ update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
 
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		update_cpu_closid_rmid(r);
-	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);
+	smp_xcall_mask(cpu_mask, update_cpu_closid_rmid, r, XCALL_TYPE_SYNC);
 	put_cpu();
 }
 
@@ -1866,7 +1866,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		update(&enable);
 	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */
-	smp_call_function_many(cpu_mask, update, &enable, 1);
+	smp_xcall_mask(cpu_mask, update, &enable, XCALL_TYPE_SYNC);
 	put_cpu();
 
 	free_cpumask_var(cpu_mask);
@@ -2335,7 +2335,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	if (cpumask_test_cpu(cpu, cpu_mask))
 		rdt_ctrl_update(&msr_param);
 	/* Update CBM on all other cpus in cpu_mask. */
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
+	smp_xcall_mask(cpu_mask, rdt_ctrl_update, &msr_param, XCALL_TYPE_SYNC);
 	put_cpu();
 
 	free_cpumask_var(cpu_mask);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 8e4bc6453d26..ed9a7cf4f996 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -278,8 +278,9 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 			 * miss cpus that entered the enclave between
 			 * generating the mask and incrementing epoch.
 			 */
-			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
-					 sgx_ipi_cb, NULL, 1);
+			smp_xcall_mask(sgx_encl_ewb_cpumask(encl),
+				 sgx_ipi_cb, NULL, XCALL_TYPE_SYNC);
+
 			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
 		}
 	}
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index ec8064c0ae03..5da5c757ce42 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -120,7 +120,7 @@ static inline void umwait_update_control(u32 maxtime, bool c02_enable)
 
 	WRITE_ONCE(umwait_control_cached, ctrl);
 	/* Propagate to all CPUs */
-	on_each_cpu(umwait_update_control_msr, NULL, 1);
+	smp_xcall(XCALL_ALL, umwait_update_control_msr, NULL, XCALL_TYPE_SYNC);
 }
 
 static ssize_t
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c04b933f48d3..94cc41cf656e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -282,7 +282,7 @@ static int vmware_pv_reboot_notify(struct notifier_block *nb,
 				unsigned long code, void *unused)
 {
 	if (code == SYS_RESTART)
-		on_each_cpu(vmware_pv_guest_cpu_reboot, NULL, 1);
+		smp_xcall(XCALL_ALL, vmware_pv_guest_cpu_reboot, NULL, XCALL_TYPE_SYNC);
 	return NOTIFY_DONE;
 }
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a22deb58f86d..9ba37c13df7b 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -730,7 +730,7 @@ static int kvm_pv_reboot_notify(struct notifier_block *nb,
 				unsigned long code, void *unused)
 {
 	if (code == SYS_RESTART)
-		on_each_cpu(kvm_pv_guest_cpu_reboot, NULL, 1);
+		smp_xcall(XCALL_ALL, kvm_pv_guest_cpu_reboot, NULL, XCALL_TYPE_SYNC);
 	return NOTIFY_DONE;
 }
 
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 525876e7b9f4..d92b0a04b859 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -424,7 +424,7 @@ static void install_ldt(struct mm_struct *mm, struct ldt_struct *ldt)
 	smp_store_release(&mm->context.ldt, ldt);
 
 	/* Activate the LDT for all CPUs using currents mm. */
-	on_each_cpu_mask(mm_cpumask(mm), flush_ldt, mm, true);
+	smp_xcall_mask(mm_cpumask(mm), flush_ldt, mm, XCALL_TYPE_SYNC);
 
 	mutex_unlock(&mm->context.lock);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0c0ca599a353..02b84f0bdff2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7443,8 +7443,8 @@ static int kvm_emulate_wbinvd_noskip(struct kvm_vcpu *vcpu)
 		int cpu = get_cpu();
 
 		cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
-		on_each_cpu_mask(vcpu->arch.wbinvd_dirty_mask,
-				wbinvd_ipi, NULL, 1);
+		smp_xcall_mask(vcpu->arch.wbinvd_dirty_mask,
+				wbinvd_ipi, NULL, XCALL_TYPE_SYNC);
 		put_cpu();
 		cpumask_clear(vcpu->arch.wbinvd_dirty_mask);
 	} else
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 7c48ff4ae8d1..d81977b85228 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -15,7 +15,7 @@ EXPORT_SYMBOL(wbinvd_on_cpu);
 
 int wbinvd_on_all_cpus(void)
 {
-	on_each_cpu(__wbinvd, NULL, 1);
+	smp_xcall(XCALL_ALL, __wbinvd, NULL, XCALL_TYPE_SYNC);
 	return 0;
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 40bbe56bde32..68170a28270f 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -113,7 +113,7 @@ static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
 	if (cpumask_test_cpu(this_cpu, mask))
 		msr_func(&rv);
 
-	smp_call_function_many(mask, msr_func, &rv, 1);
+	smp_xcall_mask(mask, msr_func, &rv, XCALL_TYPE_SYNC);
 	put_cpu();
 }
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index abf5ed76e4b7..835ab4e0a8fd 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -348,7 +348,7 @@ static void cpa_flush_all(unsigned long cache)
 {
 	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
-	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
+	smp_xcall(XCALL_ALL, __cpa_flush_all, (void *) cache, XCALL_TYPE_SYNC);
 }
 
 static void __cpa_flush_tlb(void *data)
@@ -375,7 +375,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 	if (cpa->force_flush_all || cpa->numpages > tlb_single_page_flush_ceiling)
 		flush_tlb_all();
 	else
-		on_each_cpu(__cpa_flush_tlb, cpa, 1);
+		smp_xcall(XCALL_ALL, __cpa_flush_tlb, cpa, XCALL_TYPE_SYNC);
 
 	if (!cache)
 		return;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d400b6d9d246..78f685c9ebb0 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -889,10 +889,10 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * doing a speculative memory access.
 	 */
 	if (info->freed_tables)
-		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
+		smp_xcall_mask(cpumask, flush_tlb_func, (void *)info, XCALL_TYPE_SYNC);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
-				(void *)info, 1, cpumask);
+		smp_xcall_mask_cond(cpumask, flush_tlb_func, (void *)info,
+				tlb_is_not_lazy, XCALL_TYPE_SYNC);
 }
 
 void flush_tlb_multi(const struct cpumask *cpumask,
@@ -1006,7 +1006,7 @@ static void do_flush_tlb_all(void *info)
 void flush_tlb_all(void)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
-	on_each_cpu(do_flush_tlb_all, NULL, 1);
+	smp_xcall(XCALL_ALL, do_flush_tlb_all, NULL, XCALL_TYPE_SYNC);
 }
 
 static void do_kernel_range_flush(void *info)
@@ -1024,14 +1024,14 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	/* Balance as user space task's flush, a bit conservative */
 	if (end == TLB_FLUSH_ALL ||
 	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
+		smp_xcall(XCALL_ALL, do_flush_tlb_all, NULL, XCALL_TYPE_SYNC);
 	} else {
 		struct flush_tlb_info *info;
 
 		preempt_disable();
 		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
 
-		on_each_cpu(do_kernel_range_flush, info, 1);
+		smp_xcall(XCALL_ALL, do_kernel_range_flush, info, XCALL_TYPE_SYNC);
 
 		put_flush_tlb_info();
 		preempt_enable();
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 00354866921b..1938d08b20e7 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -948,7 +948,7 @@ static void xen_drop_mm_ref(struct mm_struct *mm)
 			cpumask_set_cpu(cpu, mask);
 	}
 
-	smp_call_function_many(mask, drop_mm_ref_this_cpu, mm, 1);
+	smp_xcall_mask(mask, drop_mm_ref_this_cpu, mm, XCALL_TYPE_SYNC);
 	free_cpumask_var(mask);
 }
 #else
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 688aa8b6ae29..6030daaa8f04 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -428,7 +428,7 @@ static void stop_self(void *v)
 
 static void xen_pv_stop_other_cpus(int wait)
 {
-	smp_call_function(stop_self, NULL, wait);
+	smp_xcall(XCALL_ALL, stop_self, NULL, (wait ? XCALL_TYPE_SYNC : XCALL_TYPE_ASYNC));
 }
 
 static irqreturn_t xen_irq_work_interrupt(int irq, void *dev_id)
diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 1d83152c761b..e54ae4cb388d 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -67,7 +67,7 @@ void xen_arch_resume(void)
 {
 	int cpu;
 
-	on_each_cpu(xen_vcpu_notify_restore, NULL, 1);
+	smp_xcall(XCALL_ALL, xen_vcpu_notify_restore, NULL, XCALL_TYPE_SYNC);
 
 	for_each_online_cpu(cpu)
 		xen_pmu_init(cpu);
@@ -80,5 +80,5 @@ void xen_arch_suspend(void)
 	for_each_online_cpu(cpu)
 		xen_pmu_finish(cpu);
 
-	on_each_cpu(xen_vcpu_notify_suspend, NULL, 1);
+	smp_xcall(XCALL_ALL, xen_vcpu_notify_suspend, NULL, XCALL_TYPE_SYNC);
 }
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 1254da07ead1..b2d126510c9f 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -470,7 +470,7 @@ static void ipi_flush_tlb_all(void *arg)
 
 void flush_tlb_all(void)
 {
-	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_all, NULL, XCALL_TYPE_SYNC);
 }
 
 static void ipi_flush_tlb_mm(void *arg)
@@ -480,7 +480,7 @@ static void ipi_flush_tlb_mm(void *arg)
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	on_each_cpu(ipi_flush_tlb_mm, mm, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_mm, mm, XCALL_TYPE_SYNC);
 }
 
 static void ipi_flush_tlb_page(void *arg)
@@ -495,7 +495,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 		.vma = vma,
 		.addr1 = addr,
 	};
-	on_each_cpu(ipi_flush_tlb_page, &fd, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_page, &fd, XCALL_TYPE_SYNC);
 }
 
 static void ipi_flush_tlb_range(void *arg)
@@ -512,7 +512,7 @@ void flush_tlb_range(struct vm_area_struct *vma,
 		.addr1 = start,
 		.addr2 = end,
 	};
-	on_each_cpu(ipi_flush_tlb_range, &fd, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_range, &fd, XCALL_TYPE_SYNC);
 }
 
 static void ipi_flush_tlb_kernel_range(void *arg)
@@ -527,7 +527,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		.addr1 = start,
 		.addr2 = end,
 	};
-	on_each_cpu(ipi_flush_tlb_kernel_range, &fd, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_tlb_kernel_range, &fd, XCALL_TYPE_SYNC);
 }
 
 /* Cache flush functions */
@@ -539,7 +539,7 @@ static void ipi_flush_cache_all(void *arg)
 
 void flush_cache_all(void)
 {
-	on_each_cpu(ipi_flush_cache_all, NULL, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_cache_all, NULL, XCALL_TYPE_SYNC);
 }
 
 static void ipi_flush_cache_page(void *arg)
@@ -556,7 +556,7 @@ void flush_cache_page(struct vm_area_struct *vma,
 		.addr1 = address,
 		.addr2 = pfn,
 	};
-	on_each_cpu(ipi_flush_cache_page, &fd, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_cache_page, &fd, XCALL_TYPE_SYNC);
 }
 
 static void ipi_flush_cache_range(void *arg)
@@ -573,7 +573,7 @@ void flush_cache_range(struct vm_area_struct *vma,
 		.addr1 = start,
 		.addr2 = end,
 	};
-	on_each_cpu(ipi_flush_cache_range, &fd, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_cache_range, &fd, XCALL_TYPE_SYNC);
 }
 
 static void ipi_flush_icache_range(void *arg)
@@ -588,7 +588,7 @@ void flush_icache_range(unsigned long start, unsigned long end)
 		.addr1 = start,
 		.addr2 = end,
 	};
-	on_each_cpu(ipi_flush_icache_range, &fd, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_icache_range, &fd, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(flush_icache_range);
 
@@ -607,7 +607,7 @@ static void system_invalidate_dcache_range(unsigned long start,
 		.addr1 = start,
 		.addr2 = size,
 	};
-	on_each_cpu(ipi_invalidate_dcache_range, &fd, 1);
+	smp_xcall(XCALL_ALL, ipi_invalidate_dcache_range, &fd, XCALL_TYPE_SYNC);
 }
 
 static void ipi_flush_invalidate_dcache_range(void *arg)
@@ -623,5 +623,5 @@ static void system_flush_invalidate_dcache_range(unsigned long start,
 		.addr1 = start,
 		.addr2 = size,
 	};
-	on_each_cpu(ipi_flush_invalidate_dcache_range, &fd, 1);
+	smp_xcall(XCALL_ALL, ipi_flush_invalidate_dcache_range, &fd, XCALL_TYPE_SYNC);
 }
diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 3ffbb1c80c5c..dc9754f3162e 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -1308,7 +1308,7 @@ static void ipi_handler(void *null)
 
 void global_cache_flush(void)
 {
-	on_each_cpu(ipi_handler, NULL, 1);
+	smp_xcall(XCALL_ALL, ipi_handler, NULL, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(global_cache_flush);
 
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index be4175f415ba..51754c81213f 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -130,7 +130,7 @@ static int gic_clk_notifier(struct notifier_block *nb, unsigned long action,
 
 	if (action == POST_RATE_CHANGE) {
 		gic_clocksource_unstable("ref clock rate change");
-		on_each_cpu(gic_update_frequency, (void *)cnd->new_rate, 1);
+		smp_xcall(XCALL_ALL, gic_update_frequency, (void *)cnd->new_rate, XCALL_TYPE_SYNC);
 	}
 
 	return NOTIFY_OK;
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index fd595c1cdd2f..140b6f1d6078 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -129,8 +129,8 @@ static void boost_set_msr_each(void *p_en)
 
 static int set_boost(struct cpufreq_policy *policy, int val)
 {
-	on_each_cpu_mask(policy->cpus, boost_set_msr_each,
-			 (void *)(long)val, 1);
+	smp_xcall_mask(policy->cpus, boost_set_msr_each,
+			(void *)(long)val, XCALL_TYPE_SYNC);
 	pr_debug("CPU %*pbl: Core Boosting %sabled.\n",
 		 cpumask_pr_args(policy->cpus), val ? "en" : "dis");
 
@@ -340,7 +340,7 @@ static void drv_write(struct acpi_cpufreq_data *data,
 	if (cpumask_test_cpu(this_cpu, mask))
 		do_drv_write(&cmd);
 
-	smp_call_function_many(mask, do_drv_write, &cmd, 1);
+	smp_xcall_mask(mask, do_drv_write, &cmd, XCALL_TYPE_SYNC);
 	put_cpu();
 }
 
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index ac381db25dbe..4b0b7e3cb19f 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -265,7 +265,7 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 	 * in a cluster run at same frequency which is the maximum frequency
 	 * request out of the values requested by both cores in that cluster.
 	 */
-	on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);
+	smp_xcall_mask(policy->cpus, set_cpu_ndiv, tbl, XCALL_TYPE_SYNC);
 
 	return 0;
 }
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index f70aa17e2a8e..88c104ee76b4 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -225,8 +225,8 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 		return ret;
 
 	if (drv->bctimer)
-		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
-				 (void *)1, 1);
+		smp_xcall_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
+				 (void *)1, XCALL_TYPE_SYNC);
 
 	return 0;
 }
@@ -244,8 +244,8 @@ static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
 {
 	if (drv->bctimer) {
 		drv->bctimer = 0;
-		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
-				 NULL, 1);
+		smp_xcall_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
+				 NULL, XCALL_TYPE_SYNC);
 	}
 
 	__cpuidle_unset_driver(drv);
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 812baa48b290..4d44c541fea7 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -793,7 +793,7 @@ static ssize_t inject_write_store(struct device *dev,
 			"/sys/bus/machinecheck/devices/machinecheck<CPUNUM>/check_interval\n"
 			"so that you can get the error report faster.\n");
 
-	on_each_cpu(disable_caches, NULL, 1);
+	smp_xcall(XCALL_ALL, disable_caches, NULL, XCALL_TYPE_SYNC);
 
 	/* Issue 'word' and 'bit' along with the READ request */
 	amd64_write_pci_cfg(pvt->F3, F10_NB_ARRAY_DATA, word_bits);
@@ -806,7 +806,7 @@ static ssize_t inject_write_store(struct device *dev,
 		goto retry;
 	}
 
-	on_each_cpu(enable_caches, NULL, 1);
+	smp_xcall(XCALL_ALL, enable_caches, NULL, XCALL_TYPE_SYNC);
 
 	edac_dbg(0, "section=0x%x word_bits=0x%x\n", section, word_bits);
 
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1e1a51510e83..e5d79fe7fe6b 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -101,7 +101,7 @@ static inline int sdei_do_cross_call(smp_call_func_t fn,
 	struct sdei_crosscall_args arg;
 
 	CROSSCALL_INIT(arg, event);
-	on_each_cpu(fn, &arg, true);
+	smp_xcall(XCALL_ALL, fn, &arg, XCALL_TYPE_SYNC);
 
 	return arg.first_error;
 }
@@ -359,7 +359,7 @@ static int sdei_api_shared_reset(void)
 static void sdei_mark_interface_broken(void)
 {
 	pr_err("disabling SDEI firmware interface\n");
-	on_each_cpu(&_ipi_mask_cpu, NULL, true);
+	smp_xcall(XCALL_ALL, &_ipi_mask_cpu, NULL, XCALL_TYPE_SYNC);
 	sdei_firmware_call = NULL;
 }
 
@@ -367,7 +367,7 @@ static int sdei_platform_reset(void)
 {
 	int err;
 
-	on_each_cpu(&_ipi_private_reset, NULL, true);
+	smp_xcall(XCALL_ALL, &_ipi_private_reset, NULL, XCALL_TYPE_SYNC);
 	err = sdei_api_shared_reset();
 	if (err) {
 		pr_err("Failed to reset platform: %d\n", err);
@@ -741,14 +741,14 @@ static struct notifier_block sdei_pm_nb = {
 
 static int sdei_device_suspend(struct device *dev)
 {
-	on_each_cpu(_ipi_mask_cpu, NULL, true);
+	smp_xcall(XCALL_ALL, _ipi_mask_cpu, NULL, XCALL_TYPE_SYNC);
 
 	return 0;
 }
 
 static int sdei_device_resume(struct device *dev)
 {
-	on_each_cpu(_ipi_unmask_cpu, NULL, true);
+	smp_xcall(XCALL_ALL, _ipi_unmask_cpu, NULL, XCALL_TYPE_SYNC);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/vlv_sideband.c b/drivers/gpu/drm/i915/vlv_sideband.c
index c26001300ebd..3c67ba455bb7 100644
--- a/drivers/gpu/drm/i915/vlv_sideband.c
+++ b/drivers/gpu/drm/i915/vlv_sideband.c
@@ -42,7 +42,7 @@ static void __vlv_punit_get(struct drm_i915_private *i915)
 	 */
 	if (IS_VALLEYVIEW(i915)) {
 		cpu_latency_qos_update_request(&i915->sb_qos, 0);
-		on_each_cpu(ping, NULL, 1);
+		smp_xcall(XCALL_ALL, ping, NULL, XCALL_TYPE_SYNC);
 	}
 }
 
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 521534d5c1e5..ce69d7cdd91d 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -188,7 +188,7 @@ static int read_registers(struct fam15h_power_data *data)
 		cpumask_set_cpu(cpumask_any(topology_sibling_cpumask(cpu)), mask);
 	}
 
-	on_each_cpu_mask(mask, do_read_registers_on_cu, data, true);
+	smp_xcall_mask(mask, do_read_registers_on_cu, data, XCALL_TYPE_SYNC);
 
 	cpus_read_unlock();
 	free_cpumask_var(mask);
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index ef3d3646ccc2..80cee49a9a8e 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -160,7 +160,7 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	irq_set_chained_handler(pic->parent_irq, mvebu_pic_handle_cascade_irq);
 	irq_set_handler_data(pic->parent_irq, pic);
 
-	on_each_cpu(mvebu_pic_enable_percpu_irq, pic, 1);
+	smp_xcall(XCALL_ALL, mvebu_pic_enable_percpu_irq, pic, XCALL_TYPE_SYNC);
 
 	platform_set_drvdata(pdev, pic);
 
@@ -171,7 +171,7 @@ static int mvebu_pic_remove(struct platform_device *pdev)
 {
 	struct mvebu_pic *pic = platform_get_drvdata(pdev);
 
-	on_each_cpu(mvebu_pic_disable_percpu_irq, pic, 1);
+	smp_xcall(XCALL_ALL, mvebu_pic_disable_percpu_irq, pic, XCALL_TYPE_SYNC);
 	irq_domain_remove(pic->domain);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 934f6dd90992..305c18bf33c1 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1473,10 +1473,10 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 	int max_cpu = num_present_cpus();
 
 	/* Clear all Cause registers */
-	on_each_cpu(mvneta_percpu_clear_intr_cause, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_clear_intr_cause, pp, XCALL_TYPE_SYNC);
 
 	/* Mask all interrupts */
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_mask_interrupt, pp, XCALL_TYPE_SYNC);
 	mvreg_write(pp, MVNETA_INTR_ENABLE, 0);
 
 	/* Enable MBUS Retry bit16 */
@@ -3704,7 +3704,7 @@ static void mvneta_start_dev(struct mvneta_port *pp)
 	}
 
 	/* Unmask interrupts. It has to be done from each CPU */
-	on_each_cpu(mvneta_percpu_unmask_interrupt, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_unmask_interrupt, pp, XCALL_TYPE_SYNC);
 
 	mvreg_write(pp, MVNETA_INTR_MISC_MASK,
 		    MVNETA_CAUSE_PHY_STATUS_CHANGE |
@@ -3751,10 +3751,10 @@ static void mvneta_stop_dev(struct mvneta_port *pp)
 	mvneta_port_disable(pp);
 
 	/* Clear all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_clear_intr_cause, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_clear_intr_cause, pp, XCALL_TYPE_SYNC);
 
 	/* Mask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_mask_interrupt, pp, XCALL_TYPE_SYNC);
 
 	mvneta_tx_reset(pp);
 	mvneta_rx_reset(pp);
@@ -3811,7 +3811,7 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 	 * reallocation of the queues
 	 */
 	mvneta_stop_dev(pp);
-	on_each_cpu(mvneta_percpu_disable, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_disable, pp, XCALL_TYPE_SYNC);
 
 	mvneta_cleanup_txqs(pp);
 	mvneta_cleanup_rxqs(pp);
@@ -3833,7 +3833,7 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 		return ret;
 	}
 
-	on_each_cpu(mvneta_percpu_enable, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_enable, pp, XCALL_TYPE_SYNC);
 	mvneta_start_dev(pp);
 
 	netdev_update_features(dev);
@@ -4349,7 +4349,7 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
 	}
 
 	/* Mask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_mask_interrupt, pp, XCALL_TYPE_SYNC);
 	napi_enable(&port->napi);
 
 	/*
@@ -4365,7 +4365,7 @@ static int mvneta_cpu_online(unsigned int cpu, struct hlist_node *node)
 	mvneta_percpu_elect(pp);
 
 	/* Unmask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_unmask_interrupt, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_unmask_interrupt, pp, XCALL_TYPE_SYNC);
 	mvreg_write(pp, MVNETA_INTR_MISC_MASK,
 		    MVNETA_CAUSE_PHY_STATUS_CHANGE |
 		    MVNETA_CAUSE_LINK_CHANGE);
@@ -4386,7 +4386,7 @@ static int mvneta_cpu_down_prepare(unsigned int cpu, struct hlist_node *node)
 	 */
 	spin_lock(&pp->lock);
 	/* Mask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_mask_interrupt, pp, XCALL_TYPE_SYNC);
 	spin_unlock(&pp->lock);
 
 	napi_synchronize(&port->napi);
@@ -4406,7 +4406,7 @@ static int mvneta_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	mvneta_percpu_elect(pp);
 	spin_unlock(&pp->lock);
 	/* Unmask all ethernet port interrupts */
-	on_each_cpu(mvneta_percpu_unmask_interrupt, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_unmask_interrupt, pp, XCALL_TYPE_SYNC);
 	mvreg_write(pp, MVNETA_INTR_MISC_MASK,
 		    MVNETA_CAUSE_PHY_STATUS_CHANGE |
 		    MVNETA_CAUSE_LINK_CHANGE);
@@ -4445,7 +4445,7 @@ static int mvneta_open(struct net_device *dev)
 		/* Enable per-CPU interrupt on all the CPU to handle our RX
 		 * queue interrupts
 		 */
-		on_each_cpu(mvneta_percpu_enable, pp, true);
+		smp_xcall(XCALL_ALL, mvneta_percpu_enable, pp, XCALL_TYPE_SYNC);
 
 		pp->is_stopped = false;
 		/* Register a CPU notifier to handle the case where our CPU
@@ -4484,7 +4484,7 @@ static int mvneta_open(struct net_device *dev)
 	if (pp->neta_armada3700) {
 		free_irq(pp->dev->irq, pp);
 	} else {
-		on_each_cpu(mvneta_percpu_disable, pp, true);
+		smp_xcall(XCALL_ALL, mvneta_percpu_disable, pp, XCALL_TYPE_SYNC);
 		free_percpu_irq(pp->dev->irq, pp->ports);
 	}
 err_cleanup_txqs:
@@ -4516,7 +4516,7 @@ static int mvneta_stop(struct net_device *dev)
 						    &pp->node_online);
 		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
 						    &pp->node_dead);
-		on_each_cpu(mvneta_percpu_disable, pp, true);
+		smp_xcall(XCALL_ALL, mvneta_percpu_disable, pp, XCALL_TYPE_SYNC);
 		free_percpu_irq(dev->irq, pp->ports);
 	} else {
 		mvneta_stop_dev(pp);
@@ -4893,7 +4893,7 @@ static int  mvneta_config_rss(struct mvneta_port *pp)
 
 	netif_tx_stop_all_queues(pp->dev);
 
-	on_each_cpu(mvneta_percpu_mask_interrupt, pp, true);
+	smp_xcall(XCALL_ALL, mvneta_percpu_mask_interrupt, pp, XCALL_TYPE_SYNC);
 
 	if (!pp->neta_armada3700) {
 		/* We have to synchronise on the napi of each CPU */
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 1a835b48791b..e94b51be503f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3263,7 +3263,7 @@ static void mvpp2_cleanup_txqs(struct mvpp2_port *port)
 		mvpp2_txq_deinit(port, txq);
 	}
 
-	on_each_cpu(mvpp2_txq_sent_counter_clear, port, 1);
+	smp_xcall(XCALL_ALL, mvpp2_txq_sent_counter_clear, port, XCALL_TYPE_SYNC);
 
 	val &= ~MVPP2_TX_PORT_FLUSH_MASK(port->id);
 	mvpp2_write(port->priv, MVPP2_TX_PORT_FLUSH_REG, val);
@@ -3327,7 +3327,7 @@ static int mvpp2_setup_txqs(struct mvpp2_port *port)
 		}
 	}
 
-	on_each_cpu(mvpp2_txq_sent_counter_clear, port, 1);
+	smp_xcall(XCALL_ALL, mvpp2_txq_sent_counter_clear, port, XCALL_TYPE_SYNC);
 	return 0;
 
 err_cleanup:
@@ -4829,7 +4829,7 @@ static int mvpp2_open(struct net_device *dev)
 	}
 
 	/* Unmask interrupts on all CPUs */
-	on_each_cpu(mvpp2_interrupts_unmask, port, 1);
+	smp_xcall(XCALL_ALL, mvpp2_interrupts_unmask, port, XCALL_TYPE_SYNC);
 	mvpp2_shared_interrupt_mask_unmask(port, false);
 
 	mvpp2_start_dev(port);
@@ -4858,7 +4858,7 @@ static int mvpp2_stop(struct net_device *dev)
 	mvpp2_stop_dev(port);
 
 	/* Mask interrupts on all threads */
-	on_each_cpu(mvpp2_interrupts_mask, port, 1);
+	smp_xcall(XCALL_ALL, mvpp2_interrupts_mask, port, XCALL_TYPE_SYNC);
 	mvpp2_shared_interrupt_mask_unmask(port, true);
 
 	if (port->phylink)
diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 4dfdbfca6841..8a0fb76b297e 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -457,7 +457,7 @@ static void ips_enable_cpu_turbo(struct ips_driver *ips)
 		return;
 
 	if (ips->turbo_toggle_allowed)
-		on_each_cpu(do_enable_cpu_turbo, ips, 1);
+		smp_xcall(XCALL_ALL, do_enable_cpu_turbo, ips, XCALL_TYPE_SYNC);
 
 	ips->__cpu_turbo_on = true;
 }
@@ -495,7 +495,7 @@ static void ips_disable_cpu_turbo(struct ips_driver *ips)
 		return;
 
 	if (ips->turbo_toggle_allowed)
-		on_each_cpu(do_disable_cpu_turbo, ips, 1);
+		smp_xcall(XCALL_ALL, do_disable_cpu_turbo, ips, XCALL_TYPE_SYNC);
 
 	ips->__cpu_turbo_on = false;
 }
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index b27f8853508e..efb11c62f2a0 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -514,7 +514,7 @@ static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
 
 	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
 
-	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
+	smp_xcall(XCALL_ALL, xlnx_disable_percpu_irq, NULL, XCALL_TYPE_SYNC);
 
 	irq_clear_status_flags(virq_sgi, IRQ_PER_CPU);
 	free_percpu_irq(virq_sgi, &cpu_number1);
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5..e8542970d93e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -243,7 +243,7 @@ static void showacpu(void *dummy)
 
 static void sysrq_showregs_othercpus(struct work_struct *dummy)
 {
-	smp_call_function(showacpu, NULL, 0);
+	smp_xcall(XCALL_ALL, showacpu, NULL, XCALL_TYPE_ASYNC);
 }
 
 static DECLARE_WORK(sysrq_showallcpus, sysrq_showregs_othercpus);
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 5e4dc1a0f2c6..45ec7bb02f2a 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -118,7 +118,7 @@ static void __booke_wdt_set(void *data)
 
 static void booke_wdt_set(void *data)
 {
-	on_each_cpu(__booke_wdt_set, data, 0);
+	smp_xcall(XCALL_ALL, __booke_wdt_set, data, XCALL_TYPE_ASYNC);
 }
 
 static void __booke_wdt_ping(void *data)
@@ -128,7 +128,7 @@ static void __booke_wdt_ping(void *data)
 
 static int booke_wdt_ping(struct watchdog_device *wdog)
 {
-	on_each_cpu(__booke_wdt_ping, NULL, 0);
+	smp_xcall(XCALL_ALL, __booke_wdt_ping, NULL, XCALL_TYPE_ASYNC);
 
 	return 0;
 }
@@ -170,7 +170,7 @@ static void __booke_wdt_disable(void *data)
 
 static int booke_wdt_start(struct watchdog_device *wdog)
 {
-	on_each_cpu(__booke_wdt_enable, wdog, 0);
+	smp_xcall(XCALL_ALL, __booke_wdt_enable, wdog, XCALL_TYPE_ASYNC);
 	pr_debug("watchdog enabled (timeout = %u sec)\n", wdog->timeout);
 
 	return 0;
@@ -178,7 +178,7 @@ static int booke_wdt_start(struct watchdog_device *wdog)
 
 static int booke_wdt_stop(struct watchdog_device *wdog)
 {
-	on_each_cpu(__booke_wdt_disable, NULL, 0);
+	smp_xcall(XCALL_ALL, __booke_wdt_disable, NULL, XCALL_TYPE_ASYNC);
 	pr_debug("watchdog disabled\n");
 
 	return 0;
diff --git a/fs/buffer.c b/fs/buffer.c
index 2b5561ae5d0b..5c93f3d94c74 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1420,7 +1420,7 @@ bool has_bh_in_lru(int cpu, void *dummy)
 
 void invalidate_bh_lrus(void)
 {
-	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
+	smp_xcall_cond(XCALL_ALL, invalidate_bh_lru, NULL, has_bh_in_lru, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 3ddd4c6107e1..673192e2192e 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -174,6 +174,7 @@ extern int smp_xcall_any(const struct cpumask *mask, smp_call_func_t func,
 #define	XCALL_TYPE_IRQ_WORK	CSD_TYPE_IRQ_WORK
 #define	XCALL_TYPE_TTWU		CSD_TYPE_TTWU
 #define	XCALL_TYPE_MASK		CSD_FLAG_TYPE_MASK
+#define	XCALL_ALL		-1
 
 #define	XCALL_ALL		-1
 
@@ -205,9 +206,6 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
-void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask);
-
 #define	smp_call_function_single_async(cpu, csd) \
 	smp_xcall_private(cpu, csd, XCALL_TYPE_ASYNC)
 
@@ -219,48 +217,6 @@ void panic_smp_self_stop(void);
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
@@ -299,13 +255,6 @@ extern int __cpu_up(unsigned int cpunum, struct task_struct *tidle);
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
index 37640a0bd8a3..61a564372fc0 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -179,7 +179,7 @@ static void profile_flip_buffers(void)
 	mutex_lock(&profile_flip_mutex);
 	j = per_cpu(cpu_profile_flip, get_cpu());
 	put_cpu();
-	on_each_cpu(__profile_flip_buffers, NULL, 1);
+	smp_xcall(XCALL_ALL, __profile_flip_buffers, NULL, XCALL_TYPE_SYNC);
 	for_each_online_cpu(cpu) {
 		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[j];
 		for (i = 0; i < NR_PROFILE_HIT; ++i) {
@@ -202,7 +202,7 @@ static void profile_discard_flip_buffers(void)
 	mutex_lock(&profile_flip_mutex);
 	i = per_cpu(cpu_profile_flip, get_cpu());
 	put_cpu();
-	on_each_cpu(__profile_flip_buffers, NULL, 1);
+	smp_xcall(XCALL_ALL, __profile_flip_buffers, NULL, XCALL_TYPE_SYNC);
 	for_each_online_cpu(cpu) {
 		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[i];
 		memset(hits, 0, NR_PROFILE_HIT*sizeof(struct profile_hit));
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..bf3a3fe88d94 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1884,7 +1884,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 
 	// If strict, make all CPUs aware of new grace period.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
-		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
+		smp_xcall(XCALL_ALL, rcu_strict_gp_boundary, NULL, XCALL_TYPE_ASYNC);
 
 	return true;
 }
@@ -2109,7 +2109,7 @@ static noinline void rcu_gp_cleanup(void)
 
 	// If strict, make all CPUs aware of the end of the old grace period.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
-		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
+		smp_xcall(XCALL_ALL, rcu_strict_gp_boundary, NULL, XCALL_TYPE_ASYNC);
 }
 
 /*
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index dcb0410950e4..a2cb2b223997 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -398,7 +398,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
 		}
-		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
+		smp_xcall_mask(cpu_online_mask, scf_handler, scfcp,
+			       (scfsp->scfs_wait ? XCALL_TYPE_SYNC : XCALL_TYPE_ASYNC));
 		break;
 	case SCF_PRIM_ALL:
 		if (scfsp->scfs_wait)
@@ -409,7 +410,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
 		}
-		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
+		smp_xcall(XCALL_ALL, scf_handler, scfcp,
+			  (scfsp->scfs_wait ? XCALL_TYPE_SYNC : XCALL_TYPE_ASYNC));
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -515,7 +517,7 @@ static void scf_torture_cleanup(void)
 			torture_stop_kthread("scftorture_invoker", scf_stats_p[i].task);
 	else
 		goto end;
-	smp_call_function(scf_cleanup_handler, NULL, 0);
+	smp_xcall(XCALL_ALL, scf_cleanup_handler, NULL, XCALL_TYPE_ASYNC);
 	torture_stop_kthread(scf_torture_stats, scf_torture_stats_task);
 	scf_torture_stats_print();  // -After- the stats thread is stopped!
 	kfree(scf_stats_p);  // -After- the last stats print has completed!
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 0c5be7ebb1dc..9af7795f220e 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -290,9 +290,7 @@ static int membarrier_global_expedited(void)
 	}
 	rcu_read_unlock();
 
-	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
-	preempt_enable();
+	smp_xcall_mask(tmpmask, ipi_mb, NULL, XCALL_TYPE_SYNC);
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
@@ -399,11 +397,9 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		 * rseq critical section.
 		 */
 		if (flags != MEMBARRIER_FLAG_SYNC_CORE) {
-			preempt_disable();
-			smp_call_function_many(tmpmask, ipi_func, NULL, true);
-			preempt_enable();
+			smp_xcall_mask(tmpmask, ipi_func, NULL, XCALL_TYPE_SYNC);
 		} else {
-			on_each_cpu_mask(tmpmask, ipi_func, NULL, true);
+			smp_xcall_mask(tmpmask, ipi_func, NULL, XCALL_TYPE_SYNC);
 		}
 	}
 
@@ -471,7 +467,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 	}
 	rcu_read_unlock();
 
-	on_each_cpu_mask(tmpmask, ipi_sync_rq_state, mm, true);
+	smp_xcall_mask(tmpmask, ipi_sync_rq_state, mm, XCALL_TYPE_SYNC);
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
diff --git a/kernel/smp.c b/kernel/smp.c
index 94df3b3a38cf..fb2333218e31 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -626,10 +626,12 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-static void smp_call_function_many_cond(const struct cpumask *mask,
-					smp_call_func_t func, void *info,
-					bool wait,
-					smp_cond_func_t cond_func)
+/*
+ * This function performs synchronous and asynchronous cross CPU call for
+ * more than one participants.
+ */
+static void __smp_call_mask_cond(const struct cpumask *mask, smp_call_func_t func,
+		void *info, smp_cond_func_t cond_func, unsigned int flags)
 {
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
@@ -650,10 +652,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
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
 
@@ -682,7 +684,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 				continue;
 
 			csd_lock(csd);
-			if (wait)
+			if (flags & CSD_TYPE_SYNC)
 				csd->node.u_flags |= CSD_TYPE_SYNC;
 			csd->func = func;
 			csd->info = info;
@@ -721,11 +723,12 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		unsigned long flags;
 
 		local_irq_save(flags);
-		func(info);
+		if (func != NULL)
+			func(info);
 		local_irq_restore(flags);
 	}
 
-	if (run_remote && wait) {
+	if (run_remote && (flags & CSD_TYPE_SYNC)) {
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
@@ -735,48 +738,6 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	}
 }
 
-/**
- * smp_call_function_many(): Run a function on a set of CPUs.
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
-	smp_call_function_many_cond(mask, func, info, wait, NULL);
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
@@ -861,38 +822,6 @@ void __init smp_init(void)
 	smp_cpus_done(setup_max_cpus);
 }
 
-/*
- * on_each_cpu_cond(): Call a function on each processor for which
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
-	smp_call_function_many_cond(mask, func, info, wait, cond_func);
-	preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu_cond_mask);
-
 static void do_nothing(void *unused)
 {
 }
@@ -912,7 +841,7 @@ void kick_all_cpus_sync(void)
 {
 	/* Make sure the change is visible before we kick the cpus */
 	smp_mb();
-	smp_call_function(do_nothing, NULL, 1);
+	smp_xcall(XCALL_ALL, do_nothing, NULL, XCALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
 
@@ -992,27 +921,6 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 }
 EXPORT_SYMBOL_GPL(smp_call_on_cpu);
 
-
-void __smp_call_mask_cond(const struct cpumask *mask,
-		smp_call_func_t func, void *info,
-		smp_cond_func_t cond_func,
-		unsigned int flags)
-{
-	bool wait = false;
-
-	if (flags == XCALL_TYPE_SYNC)
-		wait = true;
-
-	preempt_disable();
-
-	/*
-	 * This is temporarily hook. The function smp_call_function_many_cond()
-	 * will be inlined here with the last patch in this series.
-	 */
-	smp_call_function_many_cond(mask, func, info, wait, cond_func);
-	preempt_enable();
-}
-
 /*
  * smp_xcall Interface
  *
@@ -1033,7 +941,8 @@ void __smp_call_mask_cond(const struct cpumask *mask,
  * Parameters:
  *
  * cpu: If cpu >=0 && cpu < nr_cpu_ids, the cross call is for that cpu.
- *      If cpu == -1, the cross call is for all the online CPUs
+ *      If cpu == XCALL_ALL which is -1, the cross call is for all the online
+ *      CPUs.
  *
  * func: It is the cross function that the destination CPUs need to execute.
  *       This function must be fast and non-blocking.
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb516..b829694d8d9d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -952,7 +952,7 @@ void clock_was_set(unsigned int bases)
 		goto out_timerfd;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
-		on_each_cpu(retrigger_next_event, NULL, 1);
+		smp_xcall(XCALL_ALL, retrigger_next_event, NULL, XCALL_TYPE_SYNC);
 		goto out_timerfd;
 	}
 
@@ -970,9 +970,7 @@ void clock_was_set(unsigned int bases)
 		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	}
 
-	preempt_disable();
-	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
-	preempt_enable();
+	smp_xcall_mask(mask, retrigger_next_event, NULL, XCALL_TYPE_SYNC);
 	cpus_read_unlock();
 	free_cpumask_var(mask);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f1d2f5e7263..6b5f1bcb0f47 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -243,7 +243,7 @@ static void update_ftrace_function(void)
 	/* Make sure the function_trace_op is visible on all CPUs */
 	smp_wmb();
 	/* Nasty way to force a rmb on all cpus */
-	smp_call_function(ftrace_sync_ipi, NULL, 1);
+	smp_xcall(XCALL_ALL, ftrace_sync_ipi, NULL, XCALL_TYPE_SYNC);
 	/* OK, we are all set to update the ftrace_trace_function now! */
 #endif /* !CONFIG_DYNAMIC_FTRACE */
 
@@ -2756,7 +2756,7 @@ void ftrace_modify_all_code(int command)
 		smp_wmb();
 		/* If irqs are disabled, we are in stop machine */
 		if (!irqs_disabled())
-			smp_call_function(ftrace_sync_ipi, NULL, 1);
+			smp_xcall(XCALL_ALL, ftrace_sync_ipi, NULL, XCALL_TYPE_SYNC);
 		err = ftrace_update_ftrace_func(ftrace_trace_function);
 		if (FTRACE_WARN_ON(err))
 			return;
@@ -7769,7 +7769,7 @@ pid_write(struct file *filp, const char __user *ubuf,
 	 * check for those tasks that are currently running.
 	 * Always do this in case a pid was appended or removed.
 	 */
-	on_each_cpu(ignore_task_cpu, tr, 1);
+	smp_xcall(XCALL_ALL, ignore_task_cpu, tr, XCALL_TYPE_SYNC);
 
 	ftrace_update_pid_func();
 	ftrace_startup_all(0);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05dfc7a12d3d..489a59d0cdac 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5865,7 +5865,7 @@ static __init int rb_hammer_test(void *arg)
 	while (!kthread_should_stop()) {
 
 		/* Send an IPI to all cpus to write data! */
-		smp_call_function(rb_ipi, NULL, 1);
+		smp_xcall(XCALL_ALL, rb_ipi, NULL, XCALL_TYPE_SYNC);
 		/* No sleep, but for non preempt, let others run */
 		schedule();
 	}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa18f..58c8984b37d8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2724,11 +2724,9 @@ void trace_buffered_event_disable(void)
 	if (--trace_buffered_event_ref)
 		return;
 
-	preempt_disable();
 	/* For each CPU, set the buffer as used. */
-	smp_call_function_many(tracing_buffer_mask,
-			       disable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	smp_xcall_mask(tracing_buffer_mask,
+		       disable_trace_buffered_event, NULL, XCALL_TYPE_SYNC);
 
 	/* Wait for all current users to finish */
 	synchronize_rcu();
@@ -2743,11 +2741,9 @@ void trace_buffered_event_disable(void)
 	 */
 	smp_wmb();
 
-	preempt_disable();
 	/* Do the work on each cpu */
-	smp_call_function_many(tracing_buffer_mask,
-			       enable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	smp_xcall_mask(tracing_buffer_mask,
+		       enable_trace_buffered_event, NULL, XCALL_TYPE_SYNC);
 }
 
 static struct trace_buffer *temp_buffer;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..b9d6c0465077 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1995,7 +1995,7 @@ event_pid_write(struct file *filp, const char __user *ubuf,
 	 * check for those tasks that are currently running.
 	 * Always do this in case a pid was appended or removed.
 	 */
-	on_each_cpu(ignore_task_cpu, tr, 1);
+	smp_xcall(XCALL_ALL, ignore_task_cpu, tr, XCALL_TYPE_SYNC);
 
  out:
 	mutex_unlock(&event_mutex);
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 08291ed33e93..9c851fee2f2a 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -332,7 +332,7 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 	 * achieves the first goal, while synchronize_srcu() achieves the
 	 * second.
 	 */
-	on_each_cpu(per_cpu_remove_cache, cache, 1);
+	smp_xcall(XCALL_ALL, per_cpu_remove_cache, cache, XCALL_TYPE_SYNC);
 
 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i = 0; i < QUARANTINE_BATCHES; i++) {
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index afb7185ffdc4..befe6183806f 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -149,7 +149,7 @@ static void tlb_remove_table_sync_one(void)
 	 * It is however sufficient for software page-table walkers that rely on
 	 * IRQ disabling.
 	 */
-	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
+	smp_xcall(XCALL_ALL, tlb_remove_table_smp_sync, NULL, XCALL_TYPE_SYNC);
 }
 
 static void tlb_remove_table_rcu(struct rcu_head *head)
diff --git a/mm/slab.c b/mm/slab.c
index b04e40078bdf..e53acef380f3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2171,7 +2171,7 @@ static void drain_cpu_caches(struct kmem_cache *cachep)
 	int node;
 	LIST_HEAD(list);
 
-	on_each_cpu(do_drain, cachep, 1);
+	smp_xcall(XCALL_ALL, do_drain, cachep, XCALL_TYPE_SYNC);
 	check_irq_on();
 	for_each_kmem_cache_node(cachep, node, n)
 		if (n->alien)
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index eb0295d90039..7fba16e99665 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -574,7 +574,7 @@ static int iucv_enable(void)
 static void iucv_disable(void)
 {
 	cpus_read_lock();
-	on_each_cpu(iucv_retrieve_cpu, NULL, 1);
+	smp_xcall(XCALL_ALL, iucv_retrieve_cpu, NULL, XCALL_TYPE_SYNC);
 	kfree(iucv_path_table);
 	iucv_path_table = NULL;
 	cpus_read_unlock();
@@ -696,7 +696,7 @@ static void iucv_cleanup_queue(void)
 	 * pending interrupts force them to the work queue by calling
 	 * an empty function on all cpus.
 	 */
-	smp_call_function(__iucv_cleanup_queue, NULL, 1);
+	smp_xcall(XCALL_ALL, __iucv_cleanup_queue, NULL, XCALL_TYPE_SYNC);
 	spin_lock_irq(&iucv_queue_lock);
 	list_for_each_entry_safe(p, n, &iucv_task_queue, list) {
 		/* Remove stale work items from the task queue. */
@@ -787,7 +787,7 @@ static int iucv_reboot_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	cpus_read_lock();
-	on_each_cpu_mask(&iucv_irq_cpumask, iucv_block_cpu, NULL, 1);
+	smp_xcall_mask(&iucv_irq_cpumask, iucv_block_cpu, NULL, XCALL_TYPE_SYNC);
 	preempt_disable();
 	for (i = 0; i < iucv_max_pathid; i++) {
 		if (iucv_path_table[i])
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 70e05af5ebea..adb7cbe67ee5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -244,7 +244,7 @@ static inline bool kvm_kick_many_cpus(struct cpumask *cpus, bool wait)
 	if (cpumask_empty(cpus))
 		return false;
 
-	smp_call_function_many(cpus, ack_flush, NULL, wait);
+	smp_xcall_mask(cpus, ack_flush, NULL, (wait ? XCALL_TYPE_SYNC : XCALL_TYPE_ASYNC));
 	return true;
 }
 
@@ -4895,7 +4895,7 @@ static void hardware_disable_all_nolock(void)
 
 	kvm_usage_count--;
 	if (!kvm_usage_count)
-		on_each_cpu(hardware_disable_nolock, NULL, 1);
+		smp_xcall(XCALL_ALL, hardware_disable_nolock, NULL, XCALL_TYPE_SYNC);
 }
 
 static void hardware_disable_all(void)
@@ -4914,7 +4914,7 @@ static int hardware_enable_all(void)
 	kvm_usage_count++;
 	if (kvm_usage_count == 1) {
 		atomic_set(&hardware_enable_failed, 0);
-		on_each_cpu(hardware_enable_nolock, NULL, 1);
+		smp_xcall(XCALL_ALL, hardware_enable_nolock, NULL, XCALL_TYPE_SYNC);
 
 		if (atomic_read(&hardware_enable_failed)) {
 			hardware_disable_all_nolock();
@@ -4938,7 +4938,7 @@ static int kvm_reboot(struct notifier_block *notifier, unsigned long val,
 	 */
 	pr_info("kvm: exiting hardware virtualization\n");
 	kvm_rebooting = true;
-	on_each_cpu(hardware_disable_nolock, NULL, 1);
+	smp_xcall(XCALL_ALL, hardware_disable_nolock, NULL, XCALL_TYPE_SYNC);
 	return NOTIFY_OK;
 }
 
@@ -5790,7 +5790,7 @@ void kvm_exit(void)
 	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_STARTING);
-	on_each_cpu(hardware_disable_nolock, NULL, 1);
+	smp_xcall(XCALL_ALL, hardware_disable_nolock, NULL, XCALL_TYPE_SYNC);
 	kvm_arch_hardware_unsetup();
 	kvm_arch_exit();
 	kvm_irqfd_exit();
-- 
2.27.0

