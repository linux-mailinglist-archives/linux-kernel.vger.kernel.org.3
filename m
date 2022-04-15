Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD85020AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348788AbiDOCtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbiDOCtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A796A76DD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649990833;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6XePGo9GSp98WbtrFfhaLI/5kW3gVCnsjn80HjTl+uA=;
        b=EOy5UYIjrtTQ8zfpYkt6734BciJk0aWsokxGxVd3iBW0pmdu4VCRrH0j0Yg1LAIu5s5h+/
        u0soZUlgX1FKd4eItBmgrdKkbjQGa0rEfGjoAK2Upq53hw5nzUwqazh/MIaDDLW0ImyOMP
        hWyQMx77DlgH7rp5nbVLuYgdWHDgjvE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-3ZnaTbQxNEC1r9jDbWDSGA-1; Thu, 14 Apr 2022 22:47:08 -0400
X-MC-Unique: 3ZnaTbQxNEC1r9jDbWDSGA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 877233C01C05;
        Fri, 15 Apr 2022 02:47:07 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.8.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61FAF440ADC;
        Fri, 15 Apr 2022 02:47:06 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH 00/11] smp: cross CPU call interface
Date:   Thu, 14 Apr 2022 22:46:50 -0400
Message-Id: <20220415024701.876364-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation of submitting this patch set is intended to make the
existing cross CPU call mechanism become a bit more formal interface
and more friendly to the kernel developers.

Basically the minimum set of functions below can satisfy any demand
for cross CPU call from kernel consumers. For the sack of simplicity
self-explanatory and less code redundancy no ambiguity, the functions
in this interface are renamed, simplified, or eliminated. But they
are still inheriting the same semantics and parameter lists from their
previous version.

int smp_xcall(int cpu, smp_call_func_t func, void *info, unsigned int flags)

int smp_xcall_cond(int cpu, smp_call_func_t func, void *info,
                   smp_cond_func_t condf, unsigned int flags)

void smp_xcall_mask(const struct cpumask *mask, smp_call_func_t func,
                    void *info, unsigned int flags)

void smp_xcall_mask_cond(const struct cpumask *mask, smp_call_func_t func,
                         void *info, smp_cond_func_t condf, unsigned int flags)

int smp_xcall_private(int cpu, call_single_data_t *csd, unsigned int flags)

int smp_xcall_any(const struct cpumask *mask, smp_call_func_t func,
                  void *info, unsigned int flags)


Here is the explanation about the patch set:

Patch 1: The smp cross call related structures and definitions are
consolidated from smp.c smp_types.h to smp.h. As a result, smp_types.h
is deleted from the source tree.

Patch 2: The set of smp_xcall* functions listed above are defined.
But the details will be done with the subsequent patches in this set.

Patch 3: Eliminated the macros SCF_WAIT and SCF_RUN_LOCAL and the
code around them. The reason that we can do that is because the
function smp_call_function_many_cond() was able to handle the local
cpu call after the commit a32a4d8a815c ("smp: Run functions concurrently
in smp_call_function_many_cond()") only if the local cpu showed up
in cpumask. So it was incorrect to force a local cpu call for the
on_each_cpu_cond_mask code path.

This change and the changes in subsequent patches will eventually
help eliminate the set of on_each_cpu* functions.

Patch 4: Eliminated the percpu global csd_data. Let
smp_call_function_single() temporarily hook up to smp_xcall().

Patch 5: Replaced smp_call_function_single_async() with smp_xcall_private()
and also extended smp_xcall_private() to support synchronous call
with a preallocated csd structures.

Patch 6: Previously, there were two special cross call clients
irq_work.c and core.c that they were using __smp_call_single_queue
which was a smp internal function. With some minor changes in this
patch, they are able to use this interface.

Patch 7: Actually kernel consumers can use smp_xcall() when they
want to use smp_call_function_any(). The extra logics handled by
smp_call_function_any() should be moved out of there and have the
kernel consumers pick up the CPU. Because there are quite a few
of the consumers need to run the cross call function on any one
of the CPUs, so there is some advantage to add smp_xcall_any()
to the interface.

Patch 8: Eliminated smp_call_function, smp_call_function_many,
smp_call_function_many_cond, on_each_cpu, on_each_cpu_mask,
on_each_cpu_cond, on_each_cpu_cond_mask.

Patch 9: Eliminated smp_call_function_single_async.

Patch 10: Eliminated smp_call_function_single.

Patch 11: modify up.c to adopt the same format of cross CPU call.

Note: each patch in this set depends on its precedent patch only.
The kernel can be built and boot if it is patched with any number
of patches starting from 1 to 11.

Donghai Qiao (11):
  smp: consolidate the structure definitions to smp.h
  smp: cross call interface
  smp: eliminate SCF_WAIT and SCF_RUN_LOCAL
  smp: replace smp_call_function_single() with smp_xcall()
  smp: replace smp_call_function_single_async() with smp_xcall_private()
  smp: use smp_xcall_private() fron irq_work.c and core.c
  smp: change smp_call_function_any() to smp_xcall_any()
  smp: replace smp_call_function_many_cond() with __smp_call_mask_cond()
  smp: replace smp_call_function_single_async with smp_xcall_private
  smp: replace smp_call_function_single() with smp_xcall()
  smp: modify up.c to adopt the same format of cross CPU call.

 arch/alpha/kernel/process.c                   |   2 +-
 arch/alpha/kernel/rtc.c                       |   4 +-
 arch/alpha/kernel/smp.c                       |  10 +-
 arch/arc/kernel/perf_event.c                  |   2 +-
 arch/arc/mm/cache.c                           |   2 +-
 arch/arc/mm/tlb.c                             |  14 +-
 arch/arm/common/bL_switcher.c                 |   2 +-
 arch/arm/kernel/machine_kexec.c               |   2 +-
 arch/arm/kernel/perf_event_v7.c               |   6 +-
 arch/arm/kernel/smp_tlb.c                     |  22 +-
 arch/arm/kernel/smp_twd.c                     |   4 +-
 arch/arm/mach-bcm/bcm_kona_smc.c              |   2 +-
 arch/arm/mach-mvebu/pmsu.c                    |   4 +-
 arch/arm/mm/flush.c                           |   4 +-
 arch/arm/vfp/vfpmodule.c                      |   2 +-
 arch/arm64/kernel/armv8_deprecated.c          |   4 +-
 arch/arm64/kernel/perf_event.c                |   8 +-
 arch/arm64/kernel/topology.c                  |   2 +-
 arch/arm64/kvm/arm.c                          |   6 +-
 arch/csky/abiv2/cacheflush.c                  |   2 +-
 arch/csky/kernel/cpu-probe.c                  |   2 +-
 arch/csky/kernel/perf_event.c                 |   2 +-
 arch/csky/kernel/smp.c                        |   2 +-
 arch/csky/mm/cachev2.c                        |   2 +-
 arch/ia64/kernel/mca.c                        |   4 +-
 arch/ia64/kernel/palinfo.c                    |   3 +-
 arch/ia64/kernel/smp.c                        |  10 +-
 arch/ia64/kernel/smpboot.c                    |   2 +-
 arch/ia64/kernel/uncached.c                   |   4 +-
 arch/mips/cavium-octeon/octeon-irq.c          |   4 +-
 arch/mips/cavium-octeon/setup.c               |   4 +-
 arch/mips/kernel/crash.c                      |   2 +-
 arch/mips/kernel/machine_kexec.c              |   2 +-
 arch/mips/kernel/perf_event_mipsxx.c          |   7 +-
 arch/mips/kernel/process.c                    |   2 +-
 arch/mips/kernel/smp-bmips.c                  |   3 +-
 arch/mips/kernel/smp-cps.c                    |   8 +-
 arch/mips/kernel/smp.c                        |  10 +-
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
 arch/powerpc/kernel/sysfs.c                   |  28 +-
 arch/powerpc/kernel/tau_6xx.c                 |   4 +-
 arch/powerpc/kernel/watchdog.c                |   4 +-
 arch/powerpc/kexec/core_64.c                  |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c           |   2 +-
 arch/powerpc/kvm/book3s_hv.c                  |   8 +-
 arch/powerpc/mm/book3s64/pgtable.c            |   2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  12 +-
 arch/powerpc/mm/nohash/tlb.c                  |  10 +-
 arch/powerpc/mm/slice.c                       |   4 +-
 arch/powerpc/perf/core-book3s.c               |   2 +-
 arch/powerpc/perf/imc-pmu.c                   |   2 +-
 arch/powerpc/platforms/85xx/smp.c             |   8 +-
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
 arch/s390/pci/pci_irq.c                       |   4 +-
 arch/sh/kernel/smp.c                          |  14 +-
 arch/sh/mm/cache.c                            |   2 +-
 arch/sparc/include/asm/mman.h                 |   4 +-
 arch/sparc/kernel/nmi.c                       |  16 +-
 arch/sparc/kernel/perf_event.c                |   4 +-
 arch/sparc/kernel/smp_64.c                    |   8 +-
 arch/sparc/mm/init_64.c                       |   2 +-
 arch/x86/events/core.c                        |   6 +-
 arch/x86/events/intel/core.c                  |   4 +-
 arch/x86/kernel/alternative.c                 |   2 +-
 arch/x86/kernel/amd_nb.c                      |   2 +-
 arch/x86/kernel/apic/apic.c                   |   2 +-
 arch/x86/kernel/apic/vector.c                 |   2 +-
 arch/x86/kernel/cpu/aperfmperf.c              |   5 +-
 arch/x86/kernel/cpu/bugs.c                    |   2 +-
 arch/x86/kernel/cpu/mce/amd.c                 |   4 +-
 arch/x86/kernel/cpu/mce/core.c                |  12 +-
 arch/x86/kernel/cpu/mce/inject.c              |  14 +-
 arch/x86/kernel/cpu/mce/intel.c               |   2 +-
 arch/x86/kernel/cpu/microcode/core.c          |   4 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c               |   2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |   8 +-
 arch/x86/kernel/cpu/sgx/main.c                |   5 +-
 arch/x86/kernel/cpu/umwait.c                  |   2 +-
 arch/x86/kernel/cpu/vmware.c                  |   2 +-
 arch/x86/kernel/cpuid.c                       |   2 +-
 arch/x86/kernel/kvm.c                         |   6 +-
 arch/x86/kernel/ldt.c                         |   2 +-
 arch/x86/kvm/vmx/vmx.c                        |   3 +-
 arch/x86/kvm/x86.c                            |  11 +-
 arch/x86/lib/cache-smp.c                      |   4 +-
 arch/x86/lib/msr-smp.c                        |  20 +-
 arch/x86/mm/pat/set_memory.c                  |   4 +-
 arch/x86/mm/tlb.c                             |  12 +-
 arch/x86/xen/mmu_pv.c                         |   4 +-
 arch/x86/xen/smp_pv.c                         |   2 +-
 arch/x86/xen/suspend.c                        |   4 +-
 arch/xtensa/kernel/smp.c                      |  29 +-
 block/blk-mq.c                                |   2 +-
 drivers/acpi/processor_idle.c                 |   4 +-
 drivers/char/agp/generic.c                    |   2 +-
 drivers/clocksource/ingenic-timer.c           |   2 +-
 drivers/clocksource/mips-gic-timer.c          |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                |  10 +-
 drivers/cpufreq/powernow-k8.c                 |   9 +-
 drivers/cpufreq/powernv-cpufreq.c             |  14 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c          |   4 +-
 drivers/cpufreq/sparc-us3-cpufreq.c           |   4 +-
 drivers/cpufreq/speedstep-ich.c               |   7 +-
 drivers/cpufreq/tegra194-cpufreq.c            |   8 +-
 drivers/cpuidle/coupled.c                     |   2 +-
 drivers/cpuidle/driver.c                      |   8 +-
 drivers/edac/amd64_edac.c                     |   4 +-
 drivers/firmware/arm_sdei.c                   |  10 +-
 drivers/gpu/drm/i915/vlv_sideband.c           |   2 +-
 drivers/hwmon/fam15h_power.c                  |   2 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |   3 +-
 .../coresight/coresight-etm3x-core.c          |  11 +-
 .../coresight/coresight-etm4x-core.c          |  12 +-
 .../coresight/coresight-etm4x-sysfs.c         |   2 +-
 drivers/hwtracing/coresight/coresight-trbe.c  |   6 +-
 drivers/irqchip/irq-mvebu-pic.c               |   4 +-
 .../net/ethernet/cavium/liquidio/lio_core.c   |   2 +-
 drivers/net/ethernet/marvell/mvneta.c         |  34 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   8 +-
 drivers/perf/arm_spe_pmu.c                    |   2 +-
 .../intel/speed_select_if/isst_if_mbox_msr.c  |   4 +-
 drivers/platform/x86/intel_ips.c              |   4 +-
 drivers/powercap/intel_rapl_common.c          |   2 +-
 drivers/powercap/intel_rapl_msr.c             |   2 +-
 drivers/regulator/qcom_spmi-regulator.c       |   3 +-
 drivers/soc/fsl/qbman/qman.c                  |   4 +-
 drivers/soc/fsl/qbman/qman_test_stash.c       |   9 +-
 drivers/soc/xilinx/xlnx_event_manager.c       |   2 +-
 drivers/tty/sysrq.c                           |   2 +-
 drivers/watchdog/booke_wdt.c                  |   8 +-
 fs/buffer.c                                   |   2 +-
 include/linux/irq_work.h                      |   2 +-
 include/linux/smp.h                           | 234 ++++---
 include/linux/smp_types.h                     |  69 --
 kernel/cpu.c                                  |   4 +-
 kernel/debug/debug_core.c                     |   2 +-
 kernel/events/core.c                          |  10 +-
 kernel/irq_work.c                             |   4 +-
 kernel/profile.c                              |   4 +-
 kernel/rcu/rcutorture.c                       |   3 +-
 kernel/rcu/tasks.h                            |   4 +-
 kernel/rcu/tree.c                             |   6 +-
 kernel/rcu/tree_exp.h                         |   4 +-
 kernel/relay.c                                |   5 +-
 kernel/scftorture.c                           |  13 +-
 kernel/sched/core.c                           |   4 +-
 kernel/sched/fair.c                           |   2 +-
 kernel/sched/membarrier.c                     |  14 +-
 kernel/smp.c                                  | 633 ++++++++----------
 kernel/time/clockevents.c                     |   2 +-
 kernel/time/clocksource.c                     |   2 +-
 kernel/time/hrtimer.c                         |   6 +-
 kernel/time/tick-common.c                     |   2 +-
 kernel/trace/ftrace.c                         |   6 +-
 kernel/trace/ring_buffer.c                    |   2 +-
 kernel/trace/trace.c                          |  12 +-
 kernel/trace/trace_events.c                   |   2 +-
 kernel/up.c                                   |  56 +-
 mm/kasan/quarantine.c                         |   2 +-
 mm/mmu_gather.c                               |   2 +-
 mm/slab.c                                     |   2 +-
 net/bpf/test_run.c                            |   4 +-
 net/core/dev.c                                |   2 +-
 net/iucv/iucv.c                               |  17 +-
 virt/kvm/kvm_main.c                           |  12 +-
 186 files changed, 945 insertions(+), 1009 deletions(-)
 delete mode 100644 include/linux/smp_types.h

-- 
2.27.0

