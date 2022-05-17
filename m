Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC35352A9DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351767AbiEQSDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351734AbiEQSDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BAF43FD82
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810615;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L00i/xdc0ymjgp8naAR1T/knZwM/7iRn6ugOBew1uSs=;
        b=PwFGkwowRywqRphA83LjowaRDx8OpTrvr2A76mb6FornGDjDD0IHmoNWH7uFyAZWDb1NR9
        Da0xd2Qbnl23UJx9hW24btyz2kz8Jvd3YFhrbDvQx/fd0T/kwb8pxI+42BHs5GrSUoU9SI
        W8VgwCTInc2Lwr8Ru58rNzekAJ5Sk68=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-cFylIeCTPPG2luXxTZwo_w-1; Tue, 17 May 2022 14:03:30 -0400
X-MC-Unique: cFylIeCTPPG2luXxTZwo_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8496185A7B2;
        Tue, 17 May 2022 18:03:29 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAA7A40CF8F0;
        Tue, 17 May 2022 18:03:28 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 00/11] smp: cross CPU call interface
Date:   Tue, 17 May 2022 14:03:15 -0400
Message-Id: <20220517180326.997129-1-dqiao@redhat.com>
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

The motivation of this patch set is intended to make the existing
cross CPU call mechanism become a formal interface, more friendly
to the kernel developers.

For the simplicity self-explanatory less code redundancy and no
ambiguity, the set of functions below can satisfy any existing
demand for cross call, at the meantime they still carry over the
same semantics and the similar parameter lists.

int smp_call(int cpu, smp_call_func_t func, void *info, unsigned int flags)

int smp_call_cond(int cpu, smp_call_func_t func, void *info,
                smp_cond_func_t condf, unsigned int flags)

void smp_call_mask(const struct cpumask *mask, smp_call_func_t func,
                void *info, unsigned int flags)

void smp_call_mask_others(const struct cpumask *mask, smp_call_func_t func,
                void *info, unsigned int flags)

void smp_call_mask_cond(const struct cpumask *mask, smp_call_func_t func,
                void *info, smp_cond_func_t condf, unsigned int flags)

int smp_call_csd(int cpu, call_single_data_t *csd, unsigned int flags)

Patch 1: The smp cross call related structures and definitions are
consolidated from smp.c smp_types.h to smp.h. As a result, smp_types.h
is deleted from the source tree.

Patch 2: The set of smp_call* functions listed above are defined.
But the details will be done with the subsequent patches in this set.

Patch 3: Removed SCF_WAIT and SCF_RUN_LOCAL and changed
smp_call_function_many_cond() accordingly. In order to differentiate
the cross calls that the local CPU needs to be included from those the
local CPU needs to be excluded, the interface provides two different
functions - smp_call_mask() and smp_call_mask_others(). As a result
of these changes, the on_each_cpu* functions and smp_call_function_many
smp_call_function will be eliminated with another patch in this series.

Patch 4: Eliminated the percpu global csd_data. Let
smp_call_function_single() temporarily hook up to smp_call().

Patch 5: Replaced smp_call_function_single_async() with smp_call_csd()
and also extended smp_call_csd() to support one CPU synchronous cross
call with preallocated csd structure

Patch 6: irq_work.c and core.c should use the cross interface rather
than using a unpublished internal function __smp_call_single_queue.

But this change also exposed unpublished types SMP_CALL_TYPE_TTWU and
SMP_CALL_TYPE_IRQ_WORK. However, this is a temporarily change so that
all kernel clients can call the interface as the first step. A
permanent solution should implement new cross call func() for both
and from there the TTWU and IRQ_WORK types of requests can be processed.
That way, the special TTWU and IRQ_WORK types will not be visible from
the cross call interface. Because this needs to change core.s and
irq_work.c, this should be done with a follow up patch set.

Patch 7: When a caller needs to send a cross call to a preferred CPU,
the caller should provide the CPU rather than having the cross call
interface pick up one because interface should do the common job for
the majority rather than cover every single special cases.

In the scenario of smp_call_function_any(), a preferred CPU is either
the local CPU or any CPU in the same node or any online CPU as long
as it is present in cpumask. However, the way of selecting a preferred
CPU should be done by the caller. Thus, the particular code which
deal with CPU selection is moved outside of smp_call_function_any()
and formed a utility function __smp_cpu_nearby() for this purpose.
So, the function smp_call_function_any() can be replaced with the
combination of __smp_cpu_nearby() and smp_call(). As a result, the
function smp_call_function_any() is eliminated.

Patch 8: Eliminated smp_call_function, smp_call_function_many,
smp_call_function_many_cond, on_each_cpu, on_each_cpu_mask,
on_each_cpu_cond, on_each_cpu_cond_mask.

Patch 9: Eliminated smp_call_function_single_async.

Patch 10: Eliminated smp_call_function_single.

Patch 11: modify up.c to adopt the same format of cross CPU call.

Note: Each patch in this set depends on its precedent patch only.
      The kernel can be built and boot if it is patched with any
      number of patches starting from 1 to 11.

v1 -> v2: Removed 'x' from the function names and change XCALL to
	  SMP_CALL from the new macros.
V2 -> v3: Modified the cover-letter since v2;
	  Addressed the issues that Peter has pointed out previously.

Donghai Qiao (11):
  smp: consolidate the structure definitions to smp.h
  smp: the definitions of cross call interface
  smp: remove SCF_WAIT and SCF_RUN_LOCAL
  smp: replace smp_call_function_single() with  smp_call()
  smp: replace smp_call_function_single_async with smp_call_csd
  smp: use smp_call_csd() from irq_work.c and core.c
  smp: eliminate smp_call_function_any
  smp: replace smp_call_function_many_cond() with __smp_call_mask_cond()
  smp: replace smp_call_function_single_async with smp_call_csd
  smp: replace smp_call_function_single() with  smp_call()
  smp: up.c to adopt the same format of cross CPU call.

 arch/alpha/kernel/process.c                   |   2 +-
 arch/alpha/kernel/rtc.c                       |   4 +-
 arch/alpha/kernel/smp.c                       |  13 +-
 arch/arc/kernel/perf_event.c                  |   2 +-
 arch/arc/mm/cache.c                           |   2 +-
 arch/arc/mm/tlb.c                             |  14 +-
 arch/arm/common/bL_switcher.c                 |   3 +-
 arch/arm/kernel/machine_kexec.c               |   3 +-
 arch/arm/kernel/perf_event_v7.c               |  18 +-
 arch/arm/kernel/smp_tlb.c                     |  23 +-
 arch/arm/kernel/smp_twd.c                     |   4 +-
 arch/arm/mach-bcm/bcm_kona_smc.c              |   2 +-
 arch/arm/mach-mvebu/pmsu.c                    |   4 +-
 arch/arm/mm/flush.c                           |   5 +-
 arch/arm/vfp/vfpmodule.c                      |   2 +-
 arch/arm64/kernel/armv8_deprecated.c          |   4 +-
 arch/arm64/kernel/perf_event.c                |  16 +-
 arch/arm64/kernel/topology.c                  |   2 +-
 arch/arm64/kvm/arm.c                          |   6 +-
 arch/csky/abiv2/cacheflush.c                  |   2 +-
 arch/csky/kernel/cpu-probe.c                  |   2 +-
 arch/csky/kernel/perf_event.c                 |   2 +-
 arch/csky/kernel/smp.c                        |   2 +-
 arch/csky/mm/cachev2.c                        |   2 +-
 arch/ia64/kernel/mca.c                        |   4 +-
 arch/ia64/kernel/palinfo.c                    |   3 +-
 arch/ia64/kernel/smp.c                        |  12 +-
 arch/ia64/kernel/smpboot.c                    |   2 +-
 arch/ia64/kernel/uncached.c                   |   6 +-
 arch/mips/cavium-octeon/octeon-irq.c          |   4 +-
 arch/mips/cavium-octeon/setup.c               |   6 +-
 arch/mips/kernel/crash.c                      |   3 +-
 arch/mips/kernel/machine_kexec.c              |   3 +-
 arch/mips/kernel/perf_event_mipsxx.c          |   7 +-
 arch/mips/kernel/process.c                    |   2 +-
 arch/mips/kernel/smp-bmips.c                  |   3 +-
 arch/mips/kernel/smp-cps.c                    |   8 +-
 arch/mips/kernel/smp.c                        |  11 +-
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
 arch/powerpc/kernel/sysfs.c                   |  28 +-
 arch/powerpc/kernel/tau_6xx.c                 |   4 +-
 arch/powerpc/kernel/watchdog.c                |   4 +-
 arch/powerpc/kexec/core_64.c                  |   3 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c           |   2 +-
 arch/powerpc/kvm/book3s_hv.c                  |   8 +-
 arch/powerpc/mm/book3s64/pgtable.c            |   2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  12 +-
 arch/powerpc/mm/nohash/tlb.c                  |  11 +-
 arch/powerpc/mm/slice.c                       |   4 +-
 arch/powerpc/perf/core-book3s.c               |   2 +-
 arch/powerpc/perf/imc-pmu.c                   |   2 +-
 arch/powerpc/platforms/85xx/smp.c             |   9 +-
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
 arch/sh/kernel/smp.c                          |  19 +-
 arch/sh/mm/cache.c                            |   3 +-
 arch/sparc/include/asm/mman.h                 |   4 +-
 arch/sparc/kernel/nmi.c                       |  17 +-
 arch/sparc/kernel/perf_event.c                |   4 +-
 arch/sparc/kernel/smp_64.c                    |   9 +-
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
 arch/x86/kernel/cpu/mce/inject.c              |  12 +-
 arch/x86/kernel/cpu/mce/intel.c               |   2 +-
 arch/x86/kernel/cpu/microcode/core.c          |   4 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c               |   2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  14 +-
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
 arch/x86/xen/smp_pv.c                         |   3 +-
 arch/x86/xen/suspend.c                        |   4 +-
 arch/xtensa/kernel/smp.c                      |  29 +-
 block/blk-mq.c                                |   2 +-
 drivers/acpi/processor_idle.c                 |   4 +-
 drivers/char/agp/generic.c                    |   2 +-
 drivers/clocksource/ingenic-timer.c           |   2 +-
 drivers/clocksource/mips-gic-timer.c          |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                |  15 +-
 drivers/cpufreq/powernow-k8.c                 |   9 +-
 drivers/cpufreq/powernv-cpufreq.c             |  39 +-
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
 drivers/perf/arm_spe_pmu.c                    |  14 +-
 .../intel/speed_select_if/isst_if_mbox_msr.c  |   4 +-
 drivers/platform/x86/intel_ips.c              |   4 +-
 drivers/powercap/intel_rapl_common.c          |   2 +-
 drivers/powercap/intel_rapl_msr.c             |   2 +-
 drivers/regulator/qcom_spmi-regulator.c       |   3 +-
 drivers/soc/fsl/qbman/qman.c                  |   4 +-
 drivers/soc/fsl/qbman/qman_test_stash.c       |   9 +-
 drivers/soc/xilinx/xlnx_event_manager.c       |   2 +-
 drivers/tty/sysrq.c                           |   3 +-
 drivers/watchdog/booke_wdt.c                  |   8 +-
 fs/buffer.c                                   |   2 +-
 include/linux/irq_work.h                      |   2 +-
 include/linux/smp.h                           | 216 ++++--
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
 kernel/scftorture.c                           |  16 +-
 kernel/sched/core.c                           |   4 +-
 kernel/sched/fair.c                           |   2 +-
 kernel/sched/membarrier.c                     |  10 +-
 kernel/smp.c                                  | 638 ++++++++----------
 kernel/time/clockevents.c                     |   2 +-
 kernel/time/clocksource.c                     |   2 +-
 kernel/time/hrtimer.c                         |   5 +-
 kernel/time/tick-common.c                     |   2 +-
 kernel/trace/ftrace.c                         |   9 +-
 kernel/trace/ring_buffer.c                    |   4 +-
 kernel/trace/trace.c                          |  12 +-
 kernel/trace/trace_events.c                   |   2 +-
 kernel/up.c                                   |  58 +-
 mm/kasan/quarantine.c                         |   2 +-
 mm/mmu_gather.c                               |   3 +-
 mm/slab.c                                     |   2 +-
 net/bpf/test_run.c                            |   4 +-
 net/core/dev.c                                |   2 +-
 net/iucv/iucv.c                               |  19 +-
 virt/kvm/kvm_main.c                           |  12 +-
 186 files changed, 1070 insertions(+), 984 deletions(-)
 delete mode 100644 include/linux/smp_types.h

-- 
2.27.0

