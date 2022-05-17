Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A612152A9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351862AbiEQSEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351783AbiEQSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC50250B22
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810637;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dn96w7OIuXgsJAA/EmwLGrYDf2BkWL0mBa1KaqgrM34=;
        b=P+RVEpzgFuh7w+JEd5kbukTW4WadQAon1exQXGe1FUqzKVDOizbZjIa2gvsZ2qvuqbaN1n
        9UtD50jrwJgBcqOGht99udw2hNxsVR541xtPsmQIQJrGiz27h+nZQw4M7Z8/hU8WxT7cZ7
        tLNbdslMcm0u59fYkRIHmEFX4Hpx6FQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-A4BX8nvrPWis-Y88Z-Jaxg-1; Tue, 17 May 2022 14:03:54 -0400
X-MC-Unique: A4BX8nvrPWis-Y88Z-Jaxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79DA8299E76E;
        Tue, 17 May 2022 18:03:53 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 154F1400DFB5;
        Tue, 17 May 2022 18:03:53 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 10/11] smp: replace smp_call_function_single() with  smp_call()
Date:   Tue, 17 May 2022 14:03:25 -0400
Message-Id: <20220517180326.997129-11-dqiao@redhat.com>
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

Replace smp_call_function_single() with smp_call() and
changes all the invocations for it.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to
	  SMP_CALL from the new macros
 arch/alpha/kernel/rtc.c                       |  4 +--
 arch/arm/mach-bcm/bcm_kona_smc.c              |  2 +-
 arch/arm/mach-mvebu/pmsu.c                    |  4 +--
 arch/arm64/kernel/topology.c                  |  2 +-
 arch/csky/kernel/cpu-probe.c                  |  2 +-
 arch/ia64/kernel/palinfo.c                    |  3 +-
 arch/ia64/kernel/smpboot.c                    |  2 +-
 arch/mips/kernel/smp-bmips.c                  |  3 +-
 arch/mips/kernel/smp-cps.c                    |  8 ++---
 arch/powerpc/kernel/sysfs.c                   | 26 +++++++--------
 arch/powerpc/kernel/watchdog.c                |  4 +--
 arch/powerpc/kvm/book3s_hv.c                  |  8 ++---
 arch/powerpc/platforms/85xx/smp.c             |  6 ++--
 arch/sparc/kernel/nmi.c                       |  4 +--
 arch/x86/kernel/apic/vector.c                 |  2 +-
 arch/x86/kernel/cpu/aperfmperf.c              |  5 +--
 arch/x86/kernel/cpu/mce/amd.c                 |  4 +--
 arch/x86/kernel/cpu/mce/inject.c              |  8 ++---
 arch/x86/kernel/cpu/microcode/core.c          |  4 +--
 arch/x86/kernel/cpu/mtrr/mtrr.c               |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  2 +-
 arch/x86/kernel/kvm.c                         |  4 +--
 arch/x86/kvm/vmx/vmx.c                        |  3 +-
 arch/x86/kvm/x86.c                            |  7 ++--
 arch/x86/lib/cache-smp.c                      |  2 +-
 arch/x86/lib/msr-smp.c                        | 16 ++++-----
 arch/x86/xen/mmu_pv.c                         |  2 +-
 arch/xtensa/kernel/smp.c                      |  7 ++--
 drivers/acpi/processor_idle.c                 |  4 +--
 drivers/cpufreq/powernow-k8.c                 |  9 +++--
 drivers/cpufreq/powernv-cpufreq.c             |  2 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c          |  4 +--
 drivers/cpufreq/sparc-us3-cpufreq.c           |  4 +--
 drivers/cpufreq/speedstep-ich.c               |  7 ++--
 drivers/cpufreq/tegra194-cpufreq.c            |  6 ++--
 .../hwtracing/coresight/coresight-cpu-debug.c |  3 +-
 .../coresight/coresight-etm3x-core.c          | 11 +++----
 .../coresight/coresight-etm4x-core.c          | 12 +++----
 .../coresight/coresight-etm4x-sysfs.c         |  2 +-
 drivers/hwtracing/coresight/coresight-trbe.c  |  6 ++--
 drivers/net/ethernet/marvell/mvneta.c         |  4 +--
 .../intel/speed_select_if/isst_if_mbox_msr.c  |  4 +--
 drivers/powercap/intel_rapl_common.c          |  2 +-
 drivers/powercap/intel_rapl_msr.c             |  2 +-
 drivers/regulator/qcom_spmi-regulator.c       |  3 +-
 drivers/soc/fsl/qbman/qman.c                  |  4 +--
 drivers/soc/fsl/qbman/qman_test_stash.c       |  9 ++---
 include/linux/smp.h                           |  1 +
 kernel/cpu.c                                  |  4 +--
 kernel/events/core.c                          | 10 +++---
 kernel/rcu/rcutorture.c                       |  3 +-
 kernel/rcu/tasks.h                            |  4 +--
 kernel/rcu/tree.c                             |  2 +-
 kernel/rcu/tree_exp.h                         |  4 +--
 kernel/relay.c                                |  5 ++-
 kernel/scftorture.c                           |  5 +--
 kernel/sched/membarrier.c                     |  2 +-
 kernel/smp.c                                  | 33 ++-----------------
 kernel/time/clockevents.c                     |  2 +-
 kernel/time/clocksource.c                     |  2 +-
 kernel/time/tick-common.c                     |  2 +-
 net/bpf/test_run.c                            |  4 +--
 net/iucv/iucv.c                               | 11 +++----
 virt/kvm/kvm_main.c                           |  2 +-
 64 files changed, 149 insertions(+), 191 deletions(-)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index fb3025396ac9..2853887cc0d5 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -168,7 +168,7 @@ remote_read_time(struct device *dev, struct rtc_time *tm)
 	union remote_data x;
 	if (smp_processor_id() != boot_cpuid) {
 		x.tm = tm;
-		smp_call_function_single(boot_cpuid, do_remote_read, &x, 1);
+		smp_call(boot_cpuid, do_remote_read, &x, SMP_CALL_TYPE_SYNC);
 		return x.retval;
 	}
 	return alpha_rtc_read_time(NULL, tm);
@@ -187,7 +187,7 @@ remote_set_time(struct device *dev, struct rtc_time *tm)
 	union remote_data x;
 	if (smp_processor_id() != boot_cpuid) {
 		x.tm = tm;
-		smp_call_function_single(boot_cpuid, do_remote_set, &x, 1);
+		smp_call(boot_cpuid, do_remote_set, &x, SMP_CALL_TYPE_SYNC);
 		return x.retval;
 	}
 	return alpha_rtc_set_time(NULL, tm);
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index 43829e49ad93..75453079f79e 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -172,7 +172,7 @@ unsigned bcm_kona_smc(unsigned service_id, unsigned arg0, unsigned arg1,
 	 * Due to a limitation of the secure monitor, we must use the SMP
 	 * infrastructure to forward all secure monitor calls to Core 0.
 	 */
-	smp_call_function_single(0, __bcm_kona_smc, &data, 1);
+	smp_call(0, __bcm_kona_smc, &data, SMP_CALL_TYPE_SYNC);
 
 	return data.result;
 }
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 73d5d72dfc3e..91ef1ba4100e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -585,8 +585,8 @@ int mvebu_pmsu_dfs_request(int cpu)
 	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
 
 	/* Trigger the DFS on the appropriate CPU */
-	smp_call_function_single(cpu, mvebu_pmsu_dfs_request_local,
-				 NULL, false);
+	smp_call(cpu, mvebu_pmsu_dfs_request_local,
+				 NULL, SMP_CALL_TYPE_ASYNC);
 
 	/* Poll until the DFS done event is generated */
 	timeout = jiffies + HZ;
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 9ab78ad826e2..c7a6d037feb4 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -331,7 +331,7 @@ int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
 	if (WARN_ON_ONCE(irqs_disabled()))
 		return -EPERM;
 
-	smp_call_function_single(cpu, func, val, 1);
+	smp_call(cpu, func, val, SMP_CALL_TYPE_SYNC);
 
 	return 0;
 }
diff --git a/arch/csky/kernel/cpu-probe.c b/arch/csky/kernel/cpu-probe.c
index 5f15ca31d3e8..2af63175fd08 100644
--- a/arch/csky/kernel/cpu-probe.c
+++ b/arch/csky/kernel/cpu-probe.c
@@ -48,7 +48,7 @@ static int c_show(struct seq_file *m, void *v)
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		smp_call_function_single(cpu, percpu_print, m, true);
+		smp_call(cpu, percpu_print, m, SMP_CALL_TYPE_SYNC);
 
 #ifdef CSKY_ARCH_VERSION
 	seq_printf(m, "arch-version : %s\n", CSKY_ARCH_VERSION);
diff --git a/arch/ia64/kernel/palinfo.c b/arch/ia64/kernel/palinfo.c
index 64189f04c1a4..9c1b113e155a 100644
--- a/arch/ia64/kernel/palinfo.c
+++ b/arch/ia64/kernel/palinfo.c
@@ -844,7 +844,8 @@ int palinfo_handle_smp(struct seq_file *m, pal_func_cpu_u_t *f)
 
 
 	/* will send IPI to other CPU and wait for completion of remote call */
-	if ((ret=smp_call_function_single(f->req_cpu, palinfo_smp_call, &ptr, 1))) {
+	ret = smp_call(f->req_cpu, palinfo_smp_call, &ptr, SMP_CALL_TYPE_SYNC);
+	if (ret) {
 		printk(KERN_ERR "palinfo: remote CPU call from %d to %d on function %d: "
 		       "error %d\n", smp_processor_id(), f->req_cpu, f->func_id, ret);
 		return 0;
diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index d10f780c13b9..e71829688bd2 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -295,7 +295,7 @@ ia64_sync_itc (unsigned int master)
 
 	go[MASTER] = 1;
 
-	if (smp_call_function_single(master, sync_master, NULL, 0) < 0) {
+	if (smp_call(master, sync_master, NULL, SMP_CALL_TYPE_ASYNC) < 0) {
 		printk(KERN_ERR "sync_itc: failed to get attention of CPU %u!\n", master);
 		return;
 	}
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index f5d7bfa3472a..bd2df61e4f7f 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -488,8 +488,7 @@ static void bmips_set_reset_vec_remote(void *vinfo)
 
 	preempt_disable();
 	if (smp_processor_id() > 0) {
-		smp_call_function_single(0, &bmips_set_reset_vec_remote,
-					 info, 1);
+		smp_call(0, &bmips_set_reset_vec_remote, info, SMP_CALL_TYPE_SYNC);
 	} else {
 		if (info->cpu & 0x02) {
 			/* BMIPS5200 "should" use mask/shift, but it's buggy */
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bcd6a944b839..3073b1e05b61 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -341,8 +341,7 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 			goto out;
 		}
 
-		err = smp_call_function_single(remote, remote_vpe_boot,
-					       NULL, 1);
+		err = smp_call(remote, remote_vpe_boot, NULL, SMP_CALL_TYPE_SYNC);
 		if (err)
 			panic("Failed to call remote CPU\n");
 		goto out;
@@ -587,9 +586,8 @@ static void cps_cpu_die(unsigned int cpu)
 		 * Have a CPU with access to the offlined CPUs registers wait
 		 * for its TC to halt.
 		 */
-		err = smp_call_function_single(cpu_death_sibling,
-					       wait_for_sibling_halt,
-					       (void *)(unsigned long)cpu, 1);
+		err = smp_call(cpu_death_sibling, wait_for_sibling_halt,
+			       (void *)(unsigned long)cpu, SMP_CALL_TYPE_SYNC);
 		if (err)
 			panic("Failed to call remote sibling CPU\n");
 	} else if (cpu_has_vp) {
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 898b48ca7b5a..b285ca10152b 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -98,7 +98,7 @@ static ssize_t show_##NAME(struct device *dev, \
 { \
 	struct cpu *cpu = container_of(dev, struct cpu, dev); \
 	unsigned long val; \
-	smp_call_function_single(cpu->dev.id, read_##NAME, &val, 1);	\
+	smp_call(cpu->dev.id, read_##NAME, &val, SMP_CALL_TYPE_SYNC);	\
 	return sprintf(buf, "%lx\n", val); \
 } \
 static ssize_t __used \
@@ -110,7 +110,7 @@ static ssize_t __used \
 	int ret = sscanf(buf, "%lx", &val); \
 	if (ret != 1) \
 		return -EINVAL; \
-	smp_call_function_single(cpu->dev.id, write_##NAME, &val, 1); \
+	smp_call(cpu->dev.id, write_##NAME, &val, SMP_CALL_TYPE_SYNC); \
 	return count; \
 }
 
@@ -262,7 +262,7 @@ static ssize_t show_pw20_state(struct device *dev,
 	u32 value;
 	unsigned int cpu = dev->id;
 
-	smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
+	smp_call(cpu, do_show_pwrmgtcr0, &value, SMP_CALL_TYPE_SYNC);
 
 	value &= PWRMGTCR0_PW20_WAIT;
 
@@ -297,7 +297,7 @@ static ssize_t store_pw20_state(struct device *dev,
 	if (value > 1)
 		return -EINVAL;
 
-	smp_call_function_single(cpu, do_store_pw20_state, &value, 1);
+	smp_call(cpu, do_store_pw20_state, &value, SMP_CALL_TYPE_SYNC);
 
 	return count;
 }
@@ -312,7 +312,7 @@ static ssize_t show_pw20_wait_time(struct device *dev,
 	unsigned int cpu = dev->id;
 
 	if (!pw20_wt) {
-		smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
+		smp_call(cpu, do_show_pwrmgtcr0, &value, SMP_CALL_TYPE_SYNC);
 		value = (value & PWRMGTCR0_PW20_ENT) >>
 					PWRMGTCR0_PW20_ENT_SHIFT;
 
@@ -372,8 +372,7 @@ static ssize_t store_pw20_wait_time(struct device *dev,
 
 	pw20_wt = value;
 
-	smp_call_function_single(cpu, set_pw20_wait_entry_bit,
-				&entry_bit, 1);
+	smp_call(cpu, set_pw20_wait_entry_bit, &entry_bit, SMP_CALL_TYPE_SYNC);
 
 	return count;
 }
@@ -384,7 +383,7 @@ static ssize_t show_altivec_idle(struct device *dev,
 	u32 value;
 	unsigned int cpu = dev->id;
 
-	smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
+	smp_call(cpu, do_show_pwrmgtcr0, &value, SMP_CALL_TYPE_SYNC);
 
 	value &= PWRMGTCR0_AV_IDLE_PD_EN;
 
@@ -419,7 +418,7 @@ static ssize_t store_altivec_idle(struct device *dev,
 	if (value > 1)
 		return -EINVAL;
 
-	smp_call_function_single(cpu, do_store_altivec_idle, &value, 1);
+	smp_call(cpu, do_store_altivec_idle, &value, SMP_CALL_TYPE_SYNC);
 
 	return count;
 }
@@ -434,7 +433,7 @@ static ssize_t show_altivec_idle_wait_time(struct device *dev,
 	unsigned int cpu = dev->id;
 
 	if (!altivec_idle_wt) {
-		smp_call_function_single(cpu, do_show_pwrmgtcr0, &value, 1);
+		smp_call(cpu, do_show_pwrmgtcr0, &value, SMP_CALL_TYPE_SYNC);
 		value = (value & PWRMGTCR0_AV_IDLE_CNT) >>
 					PWRMGTCR0_AV_IDLE_CNT_SHIFT;
 
@@ -494,8 +493,7 @@ static ssize_t store_altivec_idle_wait_time(struct device *dev,
 
 	altivec_idle_wt = value;
 
-	smp_call_function_single(cpu, set_altivec_idle_wait_entry_bit,
-				&entry_bit, 1);
+	smp_call(cpu, set_altivec_idle_wait_entry_bit, &entry_bit, SMP_CALL_TYPE_SYNC);
 
 	return count;
 }
@@ -768,7 +766,7 @@ static ssize_t idle_purr_show(struct device *dev,
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 	u64 val;
 
-	smp_call_function_single(cpu->dev.id, read_idle_purr, &val, 1);
+	smp_call(cpu->dev.id, read_idle_purr, &val, SMP_CALL_TYPE_SYNC);
 	return sprintf(buf, "%llx\n", val);
 }
 static DEVICE_ATTR(idle_purr, 0400, idle_purr_show, NULL);
@@ -798,7 +796,7 @@ static ssize_t idle_spurr_show(struct device *dev,
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 	u64 val;
 
-	smp_call_function_single(cpu->dev.id, read_idle_spurr, &val, 1);
+	smp_call(cpu->dev.id, read_idle_spurr, &val, SMP_CALL_TYPE_SYNC);
 	return sprintf(buf, "%llx\n", val);
 }
 static DEVICE_ATTR(idle_spurr, 0400, idle_spurr_show, NULL);
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index bfc27496fe7e..1212a73a1ee3 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -499,7 +499,7 @@ static void start_watchdog(void *arg)
 
 static int start_watchdog_on_cpu(unsigned int cpu)
 {
-	return smp_call_function_single(cpu, start_watchdog, NULL, true);
+	return smp_call(cpu, start_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void stop_watchdog(void *arg)
@@ -522,7 +522,7 @@ static void stop_watchdog(void *arg)
 
 static int stop_watchdog_on_cpu(unsigned int cpu)
 {
-	return smp_call_function_single(cpu, stop_watchdog, NULL, true);
+	return smp_call(cpu, stop_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 static void watchdog_calc_timeouts(void)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6fa518f6501d..3a9df7302421 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1392,7 +1392,7 @@ static unsigned long kvmppc_read_dpdes(struct kvm_vcpu *vcpu)
 		 */
 		pcpu = READ_ONCE(v->cpu);
 		if (pcpu >= 0)
-			smp_call_function_single(pcpu, do_nothing, NULL, 1);
+			smp_call(pcpu, do_nothing, NULL, SMP_CALL_TYPE_SYNC);
 		if (kvmppc_doorbell_pending(v))
 			dpdes |= 1 << thr;
 	}
@@ -3082,7 +3082,7 @@ static void radix_flush_cpu(struct kvm *kvm, int cpu, struct kvm_vcpu *vcpu)
 		struct kvm *running = *per_cpu_ptr(&cpu_in_guest, i);
 
 		if (running == kvm)
-			smp_call_function_single(i, do_nothing, NULL, 1);
+			smp_call(i, do_nothing, NULL, SMP_CALL_TYPE_SYNC);
 	}
 }
 
@@ -3136,8 +3136,8 @@ static void kvmppc_prepare_radix_vcpu(struct kvm_vcpu *vcpu, int pcpu)
 			    cpu_first_tlb_thread_sibling(pcpu))
 				radix_flush_cpu(kvm, prev_cpu, vcpu);
 
-			smp_call_function_single(prev_cpu,
-					do_migrate_away_vcpu, vcpu, 1);
+			smp_call(prev_cpu, do_migrate_away_vcpu,
+				  vcpu, SMP_CALL_TYPE_SYNC);
 		}
 		if (nested)
 			nested->prev_cpu[vcpu->arch.nested_vcpu_id] = pcpu;
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 4491ae39ca7a..145e319c6800 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -300,12 +300,10 @@ static int smp_85xx_kick_cpu(int nr)
 		 * the other.
 		 */
 		if (cpu_online(primary)) {
-			smp_call_function_single(primary,
-					wake_hw_thread, &nr, 1);
+			smp_call(primary, wake_hw_thread, &nr, SMP_CALL_TYPE_SYNC);
 			goto done;
 		} else if (cpu_online(primary + 1)) {
-			smp_call_function_single(primary + 1,
-					wake_hw_thread, &nr, 1);
+			smp_call(primary + 1, wake_hw_thread, &nr, SMP_CALL_TYPE_SYNC);
 			goto done;
 		}
 
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index cffec7822e7c..c2b0caff0ac0 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -298,7 +298,7 @@ int watchdog_nmi_enable(unsigned int cpu)
 	if (!nmi_init_done)
 		return 0;
 
-	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
+	smp_call(cpu, start_nmi_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 
 	return 0;
 }
@@ -311,5 +311,5 @@ void watchdog_nmi_disable(unsigned int cpu)
 	if (atomic_read(&nmi_active) == -1)
 		pr_warn_once("NMI watchdog cannot be enabled or disabled\n");
 	else
-		smp_call_function_single(cpu, stop_nmi_watchdog, NULL, 1);
+		smp_call(cpu, stop_nmi_watchdog, NULL, SMP_CALL_TYPE_SYNC);
 }
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3e6f6b448f6a..4f9f973b3ef3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1266,7 +1266,7 @@ static void __init print_local_APICs(int maxcpu)
 	for_each_online_cpu(cpu) {
 		if (cpu >= maxcpu)
 			break;
-		smp_call_function_single(cpu, print_local_APIC, NULL, 1);
+		smp_call(cpu, print_local_APIC, NULL, SMP_CALL_TYPE_SYNC);
 	}
 	preempt_enable();
 }
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 9ca008f9e9b1..5688727068a6 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -77,7 +77,8 @@ static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
 		return true;
 
 	if (!atomic_xchg(&s->scfpending, 1) || wait)
-		smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
+		smp_call(cpu, aperfmperf_snapshot_khz, NULL,
+				(wait ? SMP_CALL_TYPE_SYNC : SMP_CALL_TYPE_ASYNC));
 
 	/* Return false if the previous iteration was too long ago. */
 	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
@@ -145,7 +146,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	msleep(APERFMPERF_REFRESH_DELAY_MS);
 	atomic_set(&s->scfpending, 1);
 	smp_mb(); /* ->scfpending before smp_call_function_single(). */
-	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
+	smp_call(cpu, aperfmperf_snapshot_khz, NULL, SMP_CALL_TYPE_SYNC);
 
 	return per_cpu(samples.khz, cpu);
 }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1940d305db1c..101ac8ef99fd 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -929,7 +929,7 @@ store_interrupt_enable(struct threshold_block *b, const char *buf, size_t size)
 	memset(&tr, 0, sizeof(tr));
 	tr.b		= b;
 
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	if (smp_call(b->cpu, threshold_restart_bank, &tr, SMP_CALL_TYPE_SYNC))
 		return -ENODEV;
 
 	return size;
@@ -954,7 +954,7 @@ store_threshold_limit(struct threshold_block *b, const char *buf, size_t size)
 	b->threshold_limit = new;
 	tr.b = b;
 
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	if (smp_call(b->cpu, threshold_restart_bank, &tr, SMP_CALL_TYPE_SYNC))
 		return -ENODEV;
 
 	return size;
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index e7d5ad9d62b6..60da18cb8778 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -552,19 +552,19 @@ static void do_inject(void)
 
 	i_mce.mcgstatus = mcg_status;
 	i_mce.inject_flags = inj_type;
-	smp_call_function_single(cpu, prepare_msrs, &i_mce, 0);
+	smp_call(cpu, prepare_msrs, &i_mce, SMP_CALL_TYPE_ASYNC);
 
 	toggle_hw_mce_inject(cpu, false);
 
 	switch (inj_type) {
 	case DFR_INT_INJ:
-		smp_call_function_single(cpu, trigger_dfr_int, NULL, 0);
+		smp_call(cpu, trigger_dfr_int, NULL, SMP_CALL_TYPE_ASYNC);
 		break;
 	case THR_INT_INJ:
-		smp_call_function_single(cpu, trigger_thr_int, NULL, 0);
+		smp_call(cpu, trigger_thr_int, NULL, SMP_CALL_TYPE_ASYNC);
 		break;
 	default:
-		smp_call_function_single(cpu, trigger_mce, NULL, 0);
+		smp_call(cpu, trigger_mce, NULL, SMP_CALL_TYPE_ASYNC);
 	}
 
 err:
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 239ff5fcec6a..ccae0fb0d2d7 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -332,7 +332,7 @@ static int collect_cpu_info_on_target(int cpu, struct cpu_signature *cpu_sig)
 	struct cpu_info_ctx ctx = { .cpu_sig = cpu_sig, .err = 0 };
 	int ret;
 
-	ret = smp_call_function_single(cpu, collect_cpu_info_local, &ctx, 1);
+	ret = smp_call(cpu, collect_cpu_info_local, &ctx, SMP_CALL_TYPE_SYNC);
 	if (!ret)
 		ret = ctx.err;
 
@@ -365,7 +365,7 @@ static int apply_microcode_on_target(int cpu)
 	enum ucode_state err;
 	int ret;
 
-	ret = smp_call_function_single(cpu, apply_microcode_local, &err, 1);
+	ret = smp_call(cpu, apply_microcode_local, &err, SMP_CALL_TYPE_SYNC);
 	if (!ret) {
 		if (err == UCODE_ERROR)
 			ret = 1;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 2746cac9d8a9..1ef6068a9970 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -820,7 +820,7 @@ void mtrr_save_state(void)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
-	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
+	smp_call(first_cpu, mtrr_save_fixed_ranges, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 void set_mtrr_aps_delayed_init(void)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c6f02d1f0673..22be4468c233 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -541,7 +541,7 @@ static void _update_task_closid_rmid(void *task)
 static void update_task_closid_rmid(struct task_struct *t)
 {
 	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
-		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
+		smp_call(task_cpu(t), _update_task_closid_rmid, t, SMP_CALL_TYPE_SYNC);
 	else
 		_update_task_closid_rmid(t);
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 9f1623917322..a2820709b23c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1131,7 +1131,7 @@ void arch_haltpoll_enable(unsigned int cpu)
 	}
 
 	/* Enable guest halt poll disables host halt poll */
-	smp_call_function_single(cpu, kvm_disable_host_haltpoll, NULL, 1);
+	smp_call(cpu, kvm_disable_host_haltpoll, NULL, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL_GPL(arch_haltpoll_enable);
 
@@ -1141,7 +1141,7 @@ void arch_haltpoll_disable(unsigned int cpu)
 		return;
 
 	/* Disable guest halt poll enables host halt poll */
-	smp_call_function_single(cpu, kvm_enable_host_haltpoll, NULL, 1);
+	smp_call(cpu, kvm_enable_host_haltpoll, NULL, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL_GPL(arch_haltpoll_disable);
 #endif
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 610355b9ccce..6d66a5e524d0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -656,8 +656,7 @@ void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
 	int cpu = loaded_vmcs->cpu;
 
 	if (cpu != -1)
-		smp_call_function_single(cpu,
-			 __loaded_vmcs_clear, loaded_vmcs, 1);
+		smp_call(cpu, __loaded_vmcs_clear, loaded_vmcs, SMP_CALL_TYPE_SYNC);
 }
 
 static bool vmx_segment_cache_test_set(struct vcpu_vmx *vmx, unsigned seg,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 691cbf38304c..8015b688b32a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4551,8 +4551,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		if (static_call(kvm_x86_has_wbinvd_exit)())
 			cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
 		else if (vcpu->cpu != -1 && vcpu->cpu != cpu)
-			smp_call_function_single(vcpu->cpu,
-					wbinvd_ipi, NULL, 1);
+			smp_call(vcpu->cpu, wbinvd_ipi, NULL, SMP_CALL_TYPE_SYNC);
 	}
 
 	static_call(kvm_x86_vcpu_load)(vcpu, cpu);
@@ -8729,7 +8728,7 @@ static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
 	 *
 	 */
 
-	smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
+	smp_call(cpu, tsc_khz_changed, freq, SMP_CALL_TYPE_SYNC);
 
 	mutex_lock(&kvm_lock);
 	list_for_each_entry(kvm, &vm_list, vm_list) {
@@ -8756,7 +8755,7 @@ static void __kvmclock_cpufreq_notifier(struct cpufreq_freqs *freq, int cpu)
 		 * guest context is entered kvmclock will be updated,
 		 * so the guest will not see stale values.
 		 */
-		smp_call_function_single(cpu, tsc_khz_changed, freq, 1);
+		smp_call(cpu, tsc_khz_changed, freq, SMP_CALL_TYPE_SYNC);
 	}
 }
 
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 20d00dc2bb8c..bbfa2ef4c1ea 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -9,7 +9,7 @@ static void __wbinvd(void *dummy)
 
 void wbinvd_on_cpu(int cpu)
 {
-	smp_call_function_single(cpu, __wbinvd, NULL, 1);
+	smp_call(cpu, __wbinvd, NULL, SMP_CALL_TYPE_SYNC);
 }
 EXPORT_SYMBOL(wbinvd_on_cpu);
 
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index cc33097651fc..eb1c197883b8 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -41,7 +41,7 @@ int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 	memset(&rv, 0, sizeof(rv));
 
 	rv.msr_no = msr_no;
-	err = smp_call_function_single(cpu, __rdmsr_on_cpu, &rv, 1);
+	err = smp_call(cpu, __rdmsr_on_cpu, &rv, SMP_CALL_TYPE_SYNC);
 	*l = rv.reg.l;
 	*h = rv.reg.h;
 
@@ -57,7 +57,7 @@ int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 	memset(&rv, 0, sizeof(rv));
 
 	rv.msr_no = msr_no;
-	err = smp_call_function_single(cpu, __rdmsr_on_cpu, &rv, 1);
+	err = smp_call(cpu, __rdmsr_on_cpu, &rv, SMP_CALL_TYPE_SYNC);
 	*q = rv.reg.q;
 
 	return err;
@@ -74,7 +74,7 @@ int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 	rv.msr_no = msr_no;
 	rv.reg.l = l;
 	rv.reg.h = h;
-	err = smp_call_function_single(cpu, __wrmsr_on_cpu, &rv, 1);
+	err = smp_call(cpu, __wrmsr_on_cpu, &rv, SMP_CALL_TYPE_SYNC);
 
 	return err;
 }
@@ -90,7 +90,7 @@ int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 	rv.msr_no = msr_no;
 	rv.reg.q = q;
 
-	err = smp_call_function_single(cpu, __wrmsr_on_cpu, &rv, 1);
+	err = smp_call(cpu, __wrmsr_on_cpu, &rv, SMP_CALL_TYPE_SYNC);
 
 	return err;
 }
@@ -200,7 +200,7 @@ int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 	rv.msr_no = msr_no;
 	rv.reg.l = l;
 	rv.reg.h = h;
-	err = smp_call_function_single(cpu, __wrmsr_safe_on_cpu, &rv, 1);
+	err = smp_call(cpu, __wrmsr_safe_on_cpu, &rv, SMP_CALL_TYPE_SYNC);
 
 	return err ? err : rv.err;
 }
@@ -216,7 +216,7 @@ int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 	rv.msr_no = msr_no;
 	rv.reg.q = q;
 
-	err = smp_call_function_single(cpu, __wrmsr_safe_on_cpu, &rv, 1);
+	err = smp_call(cpu, __wrmsr_safe_on_cpu, &rv, SMP_CALL_TYPE_SYNC);
 
 	return err ? err : rv.err;
 }
@@ -259,7 +259,7 @@ int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 
 	rv.regs   = regs;
 	rv.err    = -EIO;
-	err = smp_call_function_single(cpu, __rdmsr_safe_regs_on_cpu, &rv, 1);
+	err = smp_call(cpu, __rdmsr_safe_regs_on_cpu, &rv, SMP_CALL_TYPE_SYNC);
 
 	return err ? err : rv.err;
 }
@@ -272,7 +272,7 @@ int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 
 	rv.regs = regs;
 	rv.err  = -EIO;
-	err = smp_call_function_single(cpu, __wrmsr_safe_regs_on_cpu, &rv, 1);
+	err = smp_call(cpu, __wrmsr_safe_regs_on_cpu, &rv, SMP_CALL_TYPE_SYNC);
 
 	return err ? err : rv.err;
 }
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index ec37a4d2c0f9..d83c5a3cce33 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -930,7 +930,7 @@ static void xen_drop_mm_ref(struct mm_struct *mm)
 		for_each_online_cpu(cpu) {
 			if (per_cpu(xen_current_cr3, cpu) != __pa(mm->pgd))
 				continue;
-			smp_call_function_single(cpu, drop_mm_ref_this_cpu, mm, 1);
+			smp_call(cpu, drop_mm_ref_this_cpu, mm, SMP_CALL_TYPE_SYNC);
 		}
 		return;
 	}
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 5878ba8f0274..2d30ae400d5b 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -201,7 +201,7 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
 	system_flush_invalidate_dcache_range((unsigned long)&cpu_start_id,
 					     sizeof(cpu_start_id));
 #endif
-	smp_call_function_single(0, mx_cpu_start, (void *)cpu, 1);
+	smp_call(0, mx_cpu_start, (void *)cpu, SMP_CALL_TYPE_SYNC);
 
 	for (i = 0; i < 2; ++i) {
 		do
@@ -220,8 +220,7 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
 		} while (ccount && time_before(jiffies, timeout));
 
 		if (ccount) {
-			smp_call_function_single(0, mx_cpu_stop,
-						 (void *)cpu, 1);
+			smp_call(0, mx_cpu_stop, (void *)cpu, SMP_CALL_TYPE_SYNC);
 			WRITE_ONCE(cpu_start_ccount, 0);
 			return -EIO;
 		}
@@ -292,7 +291,7 @@ int __cpu_disable(void)
 
 static void platform_cpu_kill(unsigned int cpu)
 {
-	smp_call_function_single(0, mx_cpu_stop, (void *)cpu, true);
+	smp_call(0, mx_cpu_stop, (void *)cpu, SMP_CALL_TYPE_SYNC);
 }
 
 /*
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index eb95e188d62b..a0002ff8a0a5 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -155,8 +155,8 @@ static void __lapic_timer_propagate_broadcast(void *arg)
 
 static void lapic_timer_propagate_broadcast(struct acpi_processor *pr)
 {
-	smp_call_function_single(pr->id, __lapic_timer_propagate_broadcast,
-				 (void *)pr, 1);
+	smp_call(pr->id, __lapic_timer_propagate_broadcast,
+			 (void *)pr, SMP_CALL_TYPE_SYNC);
 }
 
 /* Power(C) State timer broadcast control */
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index d289036beff2..f5a83043c321 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1025,7 +1025,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 	struct init_on_cpu init_on_cpu;
 	int rc, cpu;
 
-	smp_call_function_single(pol->cpu, check_supported_cpu, &rc, 1);
+	smp_call(pol->cpu, check_supported_cpu, &rc, SMP_CALL_TYPE_SYNC);
 	if (rc)
 		return -ENODEV;
 
@@ -1062,8 +1062,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 
 	/* only run on specific CPU from here on */
 	init_on_cpu.data = data;
-	smp_call_function_single(data->cpu, powernowk8_cpu_init_on_cpu,
-				 &init_on_cpu, 1);
+	smp_call(data->cpu, powernowk8_cpu_init_on_cpu, &init_on_cpu, SMP_CALL_TYPE_SYNC);
 	rc = init_on_cpu.rc;
 	if (rc != 0)
 		goto err_out_exit_acpi;
@@ -1124,7 +1123,7 @@ static unsigned int powernowk8_get(unsigned int cpu)
 	if (!data)
 		return 0;
 
-	smp_call_function_single(cpu, query_values_on_cpu, &err, true);
+	smp_call(cpu, query_values_on_cpu, &err, SMP_CALL_TYPE_SYNC);
 	if (err)
 		goto out;
 
@@ -1182,7 +1181,7 @@ static int powernowk8_init(void)
 
 	cpus_read_lock();
 	for_each_online_cpu(i) {
-		smp_call_function_single(i, check_supported_cpu, &ret, 1);
+		smp_call(i, check_supported_cpu, &ret, SMP_CALL_TYPE_SYNC);
 		if (!ret)
 			supported_cpus++;
 	}
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 078ab1c46f73..fa2f6f868970 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -898,7 +898,7 @@ static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 	freq_data.pstate_id = idx_to_pstate(powernv_pstate_info.min);
 	freq_data.gpstate_id = idx_to_pstate(powernv_pstate_info.min);
-	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
+	smp_call(policy->cpu, set_pstate, &freq_data, SMP_CALL_TYPE_SYNC);
 	if (gpstates)
 		del_timer_sync(&gpstates->timer);
 
diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
index 92acbb25abb3..8c447bf67dc5 100644
--- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -236,7 +236,7 @@ static unsigned int us2e_freq_get(unsigned int cpu)
 	unsigned long clock_tick, estar;
 
 	clock_tick = sparc64_get_clock_tick(cpu) / 1000;
-	if (smp_call_function_single(cpu, __us2e_freq_get, &estar, 1))
+	if (smp_call(cpu, __us2e_freq_get, &estar, SMP_CALL_TYPE_SYNC))
 		return 0;
 
 	return clock_tick / estar_to_divisor(estar);
@@ -268,7 +268,7 @@ static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned int cpu = policy->cpu;
 
-	return smp_call_function_single(cpu, __us2e_freq_target, &index, 1);
+	return smp_call(cpu, __us2e_freq_target, &index, SMP_CALL_TYPE_SYNC);
 }
 
 static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
index e41b35b16afd..0dd7cd16bf93 100644
--- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -87,7 +87,7 @@ static unsigned int us3_freq_get(unsigned int cpu)
 {
 	unsigned long reg;
 
-	if (smp_call_function_single(cpu, read_safari_cfg, &reg, 1))
+	if (smp_call(cpu, read_safari_cfg, &reg, SMP_CALL_TYPE_SYNC))
 		return 0;
 	return get_current_freq(cpu, reg);
 }
@@ -116,7 +116,7 @@ static int us3_freq_target(struct cpufreq_policy *policy, unsigned int index)
 		BUG();
 	}
 
-	return smp_call_function_single(cpu, update_safari_cfg, &new_bits, 1);
+	return smp_call(cpu, update_safari_cfg, &new_bits, SMP_CALL_TYPE_SYNC);
 }
 
 static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index f2076d72bf39..be062ac5804c 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -243,7 +243,7 @@ static unsigned int speedstep_get(unsigned int cpu)
 	unsigned int speed;
 
 	/* You're supposed to ensure CPU is online. */
-	BUG_ON(smp_call_function_single(cpu, get_freq_data, &speed, 1));
+	BUG_ON(smp_call(cpu, get_freq_data, &speed, SMP_CALL_TYPE_SYNC));
 
 	pr_debug("detected %u kHz as current frequency\n", speed);
 	return speed;
@@ -262,8 +262,7 @@ static int speedstep_target(struct cpufreq_policy *policy, unsigned int index)
 
 	policy_cpu = cpumask_any_and(policy->cpus, cpu_online_mask);
 
-	smp_call_function_single(policy_cpu, _speedstep_set_state, &index,
-				 true);
+	smp_call(policy_cpu, _speedstep_set_state, &index, SMP_CALL_TYPE_SYNC);
 
 	return 0;
 }
@@ -299,7 +298,7 @@ static int speedstep_cpu_init(struct cpufreq_policy *policy)
 
 	/* detect low and high frequency and transition latency */
 	gf.policy = policy;
-	smp_call_function_single(policy_cpu, get_freqs_on_cpu, &gf, 1);
+	smp_call(policy_cpu, get_freqs_on_cpu, &gf, SMP_CALL_TYPE_SYNC);
 	if (gf.ret)
 		return gf.ret;
 
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 99fc456f16b6..09a76382f383 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -203,13 +203,13 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	int ret;
 	u32 cl;
 
-	smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
+	smp_call(cpu, get_cpu_cluster, &cl, SMP_CALL_TYPE_SYNC);
 
 	/* reconstruct actual cpu freq using counters */
 	rate = tegra194_calculate_speed(cpu);
 
 	/* get last written ndiv value */
-	ret = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
+	ret = smp_call(cpu, get_cpu_ndiv, &ndiv, SMP_CALL_TYPE_SYNC);
 	if (WARN_ON_ONCE(ret))
 		return rate;
 
@@ -240,7 +240,7 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 	u32 cpu;
 	u32 cl;
 
-	smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);
+	smp_call(policy->cpu, get_cpu_cluster, &cl, SMP_CALL_TYPE_SYNC);
 
 	if (cl >= data->num_clusters || !data->tables[cl])
 		return -EINVAL;
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 8845ec4b4402..f051a658f1cf 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -590,8 +590,7 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
 
 	cpus_read_lock();
 	per_cpu(debug_drvdata, drvdata->cpu) = drvdata;
-	ret = smp_call_function_single(drvdata->cpu, debug_init_arch_data,
-				       drvdata, 1);
+	ret = smp_call(drvdata->cpu, debug_init_arch_data, drvdata, SMP_CALL_TYPE_SYNC);
 	cpus_read_unlock();
 
 	if (ret) {
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 7d413ba8b823..7f11115163e2 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -518,8 +518,8 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	 */
 	if (cpu_online(drvdata->cpu)) {
 		arg.drvdata = drvdata;
-		ret = smp_call_function_single(drvdata->cpu,
-					       etm_enable_hw_smp_call, &arg, 1);
+		ret = smp_call(drvdata->cpu, etm_enable_hw_smp_call,
+				&arg, SMP_CALL_TYPE_SYNC);
 		if (!ret)
 			ret = arg.rc;
 		if (!ret)
@@ -630,7 +630,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
-	smp_call_function_single(drvdata->cpu, etm_disable_hw, drvdata, 1);
+	smp_call(drvdata->cpu, etm_disable_hw, drvdata, SMP_CALL_TYPE_SYNC);
 
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
@@ -864,8 +864,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!desc.name)
 		return -ENOMEM;
 
-	if (smp_call_function_single(drvdata->cpu,
-				     etm_init_arch_data,  drvdata, 1))
+	if (smp_call(drvdata->cpu, etm_init_arch_data,  drvdata, SMP_CALL_TYPE_SYNC))
 		dev_err(dev, "ETM arch init failed\n");
 
 	if (etm_arch_supported(drvdata->arch) == false)
@@ -933,7 +932,7 @@ static void etm_remove(struct amba_device *adev)
 	 * CPU i ensures these call backs has consistent view
 	 * inside one call back function.
 	 */
-	if (smp_call_function_single(drvdata->cpu, clear_etmdrvdata, &drvdata->cpu, 1))
+	if (smp_call(drvdata->cpu, clear_etmdrvdata, &drvdata->cpu, SMP_CALL_TYPE_SYNC))
 		etmdrvdata[drvdata->cpu] = NULL;
 
 	cpus_read_unlock();
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7f416a12000e..4f136e477808 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -746,8 +746,8 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	 * ensures that register writes occur when cpu is powered.
 	 */
 	arg.drvdata = drvdata;
-	ret = smp_call_function_single(drvdata->cpu,
-				       etm4_enable_hw_smp_call, &arg, 1);
+	ret = smp_call(drvdata->cpu, etm4_enable_hw_smp_call,
+			&arg, SMP_CALL_TYPE_SYNC);
 	if (!ret)
 		ret = arg.rc;
 	if (!ret)
@@ -903,7 +903,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
-	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
+	smp_call(drvdata->cpu, etm4_disable_hw, drvdata, SMP_CALL_TYPE_SYNC);
 
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
@@ -1977,8 +1977,8 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	init_arg.csa = &desc.access;
 	init_arg.pid = etm_pid;
 
-	if (smp_call_function_single(drvdata->cpu,
-				etm4_init_arch_data,  &init_arg, 1))
+	if (smp_call(drvdata->cpu, etm4_init_arch_data,
+				&init_arg, SMP_CALL_TYPE_SYNC))
 		dev_err(dev, "ETM arch init failed\n");
 
 	if (!drvdata->arch)
@@ -2118,7 +2118,7 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
 	 * CPU i ensures these call backs has consistent view
 	 * inside one call back function.
 	 */
-	if (smp_call_function_single(drvdata->cpu, clear_etmdrvdata, &drvdata->cpu, 1))
+	if (smp_call(drvdata->cpu, clear_etmdrvdata, &drvdata->cpu, SMP_CALL_TYPE_SYNC))
 		etmdrvdata[drvdata->cpu] = NULL;
 
 	cpus_read_unlock();
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 21687cc1e4e2..377f7e40b081 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2379,7 +2379,7 @@ static u32 etmv4_cross_read(const struct etmv4_drvdata *drvdata, u32 offset)
 	 * smp cross call ensures the CPU will be powered up before
 	 * accessing the ETMv4 trace core registers
 	 */
-	smp_call_function_single(drvdata->cpu, do_smp_cross_read, &reg, 1);
+	smp_call(drvdata->cpu, do_smp_cross_read, &reg, SMP_CALL_TYPE_SYNC);
 	return reg.data;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 2b386bb848f8..c0e3cff19cdb 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1350,12 +1350,12 @@ static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
 
 	for_each_cpu(cpu, &drvdata->supported_cpus) {
 		/* If we fail to probe the CPU, let us defer it to hotplug callbacks */
-		if (smp_call_function_single(cpu, arm_trbe_probe_cpu, drvdata, 1))
+		if (smp_call(cpu, arm_trbe_probe_cpu, drvdata, SMP_CALL_TYPE_SYNC))
 			continue;
 		if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
 			arm_trbe_register_coresight_cpu(drvdata, cpu);
 		if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
-			smp_call_function_single(cpu, arm_trbe_enable_cpu, drvdata, 1);
+			smp_call(cpu, arm_trbe_enable_cpu, drvdata, SMP_CALL_TYPE_SYNC);
 	}
 	return 0;
 }
@@ -1365,7 +1365,7 @@ static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
 	int cpu;
 
 	for_each_cpu(cpu, &drvdata->supported_cpus)
-		smp_call_function_single(cpu, arm_trbe_remove_coresight_cpu, drvdata, 1);
+		smp_call(cpu, arm_trbe_remove_coresight_cpu, drvdata, SMP_CALL_TYPE_SYNC);
 	free_percpu(drvdata->cpudata);
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 77042499baa4..165c59778a33 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4304,8 +4304,8 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
 		/* Update the interrupt mask on each CPU according the
 		 * new mapping
 		 */
-		smp_call_function_single(cpu, mvneta_percpu_unmask_interrupt,
-					 pp, true);
+		smp_call(cpu, mvneta_percpu_unmask_interrupt,
+			  pp, SMP_CALL_TYPE_SYNC);
 		i++;
 
 	}
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
index 1b6eab071068..2ae76aa42d50 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
@@ -124,8 +124,8 @@ static long isst_if_mbox_proc_cmd(u8 *cmd_ptr, int *write_only, int resume)
 	 * and also with wait flag, wait for completion.
 	 * smp_call_function_single is using get_cpu() and put_cpu().
 	 */
-	ret = smp_call_function_single(action.mbox_cmd->logical_cpu,
-				       msrl_update_func, &action, 1);
+	ret = smp_call(action.mbox_cmd->logical_cpu,
+			msrl_update_func, &action, SMP_CALL_TYPE_SYNC);
 	if (ret)
 		return ret;
 
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 07611a00b78f..518ef59e7467 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -913,7 +913,7 @@ static void package_power_limit_irq_save(struct rapl_package *rp)
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
-	smp_call_function_single(rp->lead_cpu, power_limit_irq_save_cpu, rp, 1);
+	smp_call(rp->lead_cpu, power_limit_irq_save_cpu, rp, SMP_CALL_TYPE_SYNC);
 }
 
 /*
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 1be45f36ab6c..0430bafbffed 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -128,7 +128,7 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 {
 	int ret;
 
-	ret = smp_call_function_single(cpu, rapl_msr_update_func, ra, 1);
+	ret = smp_call(cpu, rapl_msr_update_func, ra, SMP_CALL_TYPE_SYNC);
 	if (WARN_ON_ONCE(ret))
 		return ret;
 
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 02bfce981150..222fc60bb1f3 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1292,8 +1292,7 @@ spmi_regulator_saw_set_voltage(struct regulator_dev *rdev, unsigned selector)
 	}
 
 	/* Always do the SAW register writes on the first CPU */
-	return smp_call_function_single(0, spmi_saw_set_vdd, \
-					&voltage_sel, true);
+	return smp_call(0, spmi_saw_set_vdd, &voltage_sel, SMP_CALL_TYPE_SYNC);
 }
 
 static struct regulator_ops spmi_saw_ops = {};
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index fde4edd83c14..4fb3cab1bf5d 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2548,8 +2548,8 @@ void qman_delete_cgr_safe(struct qman_cgr *cgr)
 {
 	preempt_disable();
 	if (qman_cgr_cpus[cgr->cgrid] != smp_processor_id()) {
-		smp_call_function_single(qman_cgr_cpus[cgr->cgrid],
-					 qman_delete_cgr_smp_call, cgr, true);
+		smp_call(qman_cgr_cpus[cgr->cgrid],
+			  qman_delete_cgr_smp_call, cgr, SMP_CALL_TYPE_SYNC);
 		preempt_enable();
 		return;
 	}
diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
index b7e8e5ec884c..e4110c3177e5 100644
--- a/drivers/soc/fsl/qbman/qman_test_stash.c
+++ b/drivers/soc/fsl/qbman/qman_test_stash.c
@@ -507,8 +507,9 @@ static int init_phase3(void)
 				if (err)
 					return err;
 			} else {
-				smp_call_function_single(hp_cpu->processor_id,
-					init_handler_cb, hp_cpu->iterator, 1);
+				smp_call(hp_cpu->processor_id,
+					init_handler_cb, hp_cpu->iterator,
+					SMP_CALL_TYPE_SYNC);
 			}
 			preempt_enable();
 		}
@@ -607,8 +608,8 @@ int qman_test_stash(void)
 		if (err)
 			goto failed;
 	} else {
-		smp_call_function_single(special_handler->processor_id,
-					 send_first_frame_cb, NULL, 1);
+		smp_call(special_handler->processor_id,
+				 send_first_frame_cb, NULL, SMP_CALL_TYPE_SYNC);
 	}
 	preempt_enable();
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 1086f8d5e18c..96066dcf6eef 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -160,6 +160,7 @@ do {						\
 #define	SMP_CALL_TYPE_TTWU		CSD_TYPE_TTWU
 #define	SMP_CALL_TYPE_MASK		CSD_FLAG_TYPE_MASK
 
+/* Cross call on all online CPUs */
 #define	SMP_CALL_ALL		-1
 #define	SMP_CALL_MASK_ALL	((struct cpumask *)-1)
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0b42e8..8217b989c3cf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1091,8 +1091,8 @@ void cpuhp_report_idle_dead(void)
 	 * We cannot call complete after rcu_report_dead() so we delegate it
 	 * to an online cpu.
 	 */
-	smp_call_function_single(cpumask_first(cpu_online_mask),
-				 cpuhp_complete_idle_dead, st, 0);
+	smp_call(cpumask_first(cpu_online_mask),
+			 cpuhp_complete_idle_dead, st, SMP_CALL_TYPE_ASYNC);
 }
 
 static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7858bafffa9d..180eeb04e5a5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -116,8 +116,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	int ret;
 
 	for (;;) {
-		ret = smp_call_function_single(task_cpu(p), remote_function,
-					       &data, 1);
+		ret = smp_call(task_cpu(p), remote_function,
+				&data, SMP_CALL_TYPE_SYNC);
 		if (!ret)
 			ret = data.ret;
 
@@ -149,7 +149,7 @@ static int cpu_function_call(int cpu, remote_function_f func, void *info)
 		.ret	= -ENXIO, /* No such CPU */
 	};
 
-	smp_call_function_single(cpu, remote_function, &data, 1);
+	smp_call(cpu, remote_function, &data, SMP_CALL_TYPE_SYNC);
 
 	return data.ret;
 }
@@ -4513,7 +4513,7 @@ static int perf_event_read(struct perf_event *event, bool group)
 		 * Therefore, either way, we'll have an up-to-date event count
 		 * after this.
 		 */
-		(void)smp_call_function_single(event_cpu, __perf_event_read, &data, 1);
+		(void)smp_call(event_cpu, __perf_event_read, &data, SMP_CALL_TYPE_SYNC);
 		preempt_enable();
 		ret = data.ret;
 
@@ -13292,7 +13292,7 @@ static void perf_event_exit_cpu_context(int cpu)
 		ctx = &cpuctx->ctx;
 
 		mutex_lock(&ctx->mutex);
-		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
+		smp_call(cpu, __perf_event_exit_context, ctx, SMP_CALL_TYPE_SYNC);
 		cpuctx->online = 0;
 		mutex_unlock(&ctx->mutex);
 	}
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 55d049c39608..ad9c33487526 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2662,8 +2662,7 @@ static int rcu_torture_barrier_cbs(void *arg)
 		 * The above smp_load_acquire() ensures barrier_phase load
 		 * is ordered before the following ->call().
 		 */
-		if (smp_call_function_single(myid, rcu_torture_barrier1cb,
-					     &rcu, 1)) {
+		if (smp_call(myid, rcu_torture_barrier1cb, &rcu, SMP_CALL_TYPE_SYNC)) {
 			// IPI failed, so use direct call from current CPU.
 			cur_ops->call(&rcu, rcu_torture_barrier_cbf);
 		}
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 99cf3a13954c..428fe1451aeb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1299,7 +1299,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 		per_cpu(trc_ipi_to_cpu, cpu) = true;
 		t->trc_ipi_to_cpu = cpu;
 		rcu_tasks_trace.n_ipis++;
-		if (smp_call_function_single(cpu, trc_read_check_handler, t, 0)) {
+		if (smp_call(cpu, trc_read_check_handler, t, SMP_CALL_TYPE_ASYNC)) {
 			// Just in case there is some other reason for
 			// failure than the target CPU being offline.
 			WARN_ONCE(1, "%s():  smp_call_function_single() failed for CPU: %d\n",
@@ -1473,7 +1473,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 	// changes, there will need to be a recheck and/or timed wait.
 	for_each_online_cpu(cpu)
 		if (WARN_ON_ONCE(smp_load_acquire(per_cpu_ptr(&trc_ipi_to_cpu, cpu))))
-			smp_call_function_single(cpu, rcu_tasks_trace_empty_fn, NULL, 1);
+			smp_call(cpu, rcu_tasks_trace_empty_fn, NULL, SMP_CALL_TYPE_SYNC);
 
 	// Remove the safety count.
 	smp_mb__before_atomic();  // Order vs. earlier atomics
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7bf1db5ebade..aac99328d193 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4100,7 +4100,7 @@ void rcu_barrier(void)
 			continue;
 		}
 		raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
-		if (smp_call_function_single(cpu, rcu_barrier_handler, (void *)cpu, 1)) {
+		if (smp_call(cpu, rcu_barrier_handler, (void *)cpu, SMP_CALL_TYPE_SYNC)) {
 			schedule_timeout_uninterruptible(1);
 			goto retry;
 		}
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 60197ea24ceb..ef4cec63a544 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -391,7 +391,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 			put_cpu();
 			continue;
 		}
-		ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
+		ret = smp_call(cpu, rcu_exp_handler, NULL, SMP_CALL_TYPE_ASYNC);
 		put_cpu();
 		/* The CPU will report the QS in response to the IPI. */
 		if (!ret)
@@ -777,7 +777,7 @@ static void sync_sched_exp_online_cleanup(int cpu)
 		return;
 	}
 	/* Quiescent state needed on some other CPU, send IPI. */
-	ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
+	ret = smp_call(cpu, rcu_exp_handler, NULL, SMP_CALL_TYPE_ASYNC);
 	put_cpu();
 	WARN_ON_ONCE(ret);
 }
diff --git a/kernel/relay.c b/kernel/relay.c
index d1a67fbb819d..0e615f5367a7 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -635,9 +635,8 @@ int relay_late_setup_files(struct rchan *chan,
 			disp.dentry = dentry;
 			smp_mb();
 			/* relay_channels_mutex must be held, so wait. */
-			err = smp_call_function_single(i,
-						       __relay_set_buf_dentry,
-						       &disp, 1);
+			err = smp_call(i, __relay_set_buf_dentry,
+					&disp, SMP_CALL_TYPE_SYNC);
 		}
 		if (unlikely(err))
 			break;
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 1ab37f610441..7326a089f066 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -351,7 +351,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			barrier(); // Prevent race-reduction compiler optimizations.
 			scfcp->scfc_in = true;
 		}
-		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, scfsp->scfs_wait);
+		ret = smp_call(cpu, scf_handler_1, (void *)scfcp,
+				(scfsp->scfs_wait ? SMP_CALL_TYPE_SYNC : SMP_CALL_TYPE_ASYNC));
 		if (ret) {
 			if (scfsp->scfs_wait)
 				scfp->n_single_wait_ofl++;
@@ -372,7 +373,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		scfcp->scfc_rpc = true;
 		barrier(); // Prevent race-reduction compiler optimizations.
 		scfcp->scfc_in = true;
-		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, 0);
+		ret = smp_call(cpu, scf_handler_1, (void *)scfcp, SMP_CALL_TYPE_ASYNC);
 		if (!ret) {
 			if (use_cpus_read_lock)
 				cpus_read_unlock();
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 427abc8aee02..e5786b977bd9 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -379,7 +379,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		 * smp_call_function_single() will call ipi_func() if cpu_id
 		 * is the calling CPU.
 		 */
-		smp_call_function_single(cpu_id, ipi_func, NULL, 1);
+		smp_call(cpu_id, ipi_func, NULL, SMP_CALL_TYPE_SYNC);
 	} else {
 		/*
 		 * For regular membarrier, we can save a few cycles by
diff --git a/kernel/smp.c b/kernel/smp.c
index 901399697e67..d68d87471ab9 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -611,36 +611,6 @@ void flush_smp_call_function_from_idle(void)
 	local_irq_restore(flags);
 }
 
-/*
- * This is a temporarily hook up. This function will be eliminated
- * with a later patch in this series.
- *
- * smp_call_function_single - Run a function on a specific CPU
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait until function has completed on other CPUs.
- *
- * Returns 0 on success, else a negative status code.
- */
-int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
-			int wait)
-{
-	unsigned int flags = 0;
-
-	if ((unsigned int)cpu >= nr_cpu_ids || !cpu_online(cpu))
-		return -ENXIO;
-
-	if (wait)
-		flags = SMP_CALL_TYPE_SYNC;
-	else
-		flags = SMP_CALL_TYPE_ASYNC;
-
-	smp_call(cpu, func, info, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL(smp_call_function_single);
-
 static void __smp_call_mask_cond(const struct cpumask *mask,
 		smp_call_func_t func, void *info,
 		smp_cond_func_t cond_func, bool local_cpu,
@@ -1187,7 +1157,8 @@ int smp_call_csd(int cpu, call_single_data_t *csd, unsigned int flags)
 		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
-		func(info);
+		if (likely(func != NULL))
+			func(info);
 		csd_lock_record(NULL);
 		local_irq_restore(flags);
 		goto out;
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 003ccf338d20..862d56cd554a 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -418,7 +418,7 @@ static int clockevents_unbind(struct clock_event_device *ced, int cpu)
 {
 	struct ce_unbind cu = { .ce = ced, .res = -ENODEV };
 
-	smp_call_function_single(cpu, __clockevents_unbind, &cu, 1);
+	smp_call(cpu, __clockevents_unbind, &cu, SMP_CALL_TYPE_SYNC);
 	return cu.res;
 }
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 95d7ca35bdf2..7830fa290474 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -355,7 +355,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		if (cpu == testcpu)
 			continue;
 		csnow_begin = cs->read(cs);
-		smp_call_function_single(cpu, clocksource_verify_one_cpu, cs, 1);
+		smp_call(cpu, clocksource_verify_one_cpu, cs, SMP_CALL_TYPE_SYNC);
 		csnow_end = cs->read(cs);
 		delta = (s64)((csnow_mid - csnow_begin) & cs->mask);
 		if (delta < 0)
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 46789356f856..608a176552d6 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -195,7 +195,7 @@ static void tick_take_do_timer_from_boot(void)
 	int from = tick_do_timer_boot_cpu;
 
 	if (from >= 0 && from != cpu)
-		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
+		smp_call(from, giveup_do_timer, &cpu, SMP_CALL_TYPE_SYNC);
 }
 #endif
 
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index af709c182674..0240c89337b9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -823,8 +823,8 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
 		 */
 		err = -ENXIO;
 	} else {
-		err = smp_call_function_single(cpu, __bpf_prog_test_run_raw_tp,
-					       &info, 1);
+		err = smp_call(cpu, __bpf_prog_test_run_raw_tp,
+				&info, SMP_CALL_TYPE_SYNC);
 	}
 	put_cpu();
 
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 015373965343..98d3d777ebac 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -507,8 +507,7 @@ static void iucv_setmask_mp(void)
 		/* Enable all cpus with a declared buffer. */
 		if (cpumask_test_cpu(cpu, &iucv_buffer_cpumask) &&
 		    !cpumask_test_cpu(cpu, &iucv_irq_cpumask))
-			smp_call_function_single(cpu, iucv_allow_cpu,
-						 NULL, 1);
+			smp_call(cpu, iucv_allow_cpu, NULL, SMP_CALL_TYPE_SYNC);
 	cpus_read_unlock();
 }
 
@@ -526,7 +525,7 @@ static void iucv_setmask_up(void)
 	cpumask_copy(&cpumask, &iucv_irq_cpumask);
 	cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
 	for_each_cpu(cpu, &cpumask)
-		smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
+		smp_call(cpu, iucv_block_cpu, NULL, SMP_CALL_TYPE_SYNC);
 }
 
 /*
@@ -551,7 +550,7 @@ static int iucv_enable(void)
 	/* Declare per cpu buffers. */
 	rc = -EIO;
 	for_each_online_cpu(cpu)
-		smp_call_function_single(cpu, iucv_declare_cpu, NULL, 1);
+		smp_call(cpu, iucv_declare_cpu, NULL, SMP_CALL_TYPE_SYNC);
 	if (cpumask_empty(&iucv_buffer_cpumask))
 		/* No cpu could declare an iucv buffer. */
 		goto out;
@@ -641,8 +640,8 @@ static int iucv_cpu_down_prep(unsigned int cpu)
 	iucv_retrieve_cpu(NULL);
 	if (!cpumask_empty(&iucv_irq_cpumask))
 		return 0;
-	smp_call_function_single(cpumask_first(&iucv_buffer_cpumask),
-				 iucv_allow_cpu, NULL, 1);
+	smp_call(cpumask_first(&iucv_buffer_cpumask),
+		  iucv_allow_cpu, NULL, SMP_CALL_TYPE_SYNC);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ffa181d2d465..abdb844f671d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5724,7 +5724,7 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	c.ret = &r;
 	c.opaque = opaque;
 	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu, check_processor_compat, &c, 1);
+		smp_call(cpu, check_processor_compat, &c, SMP_CALL_TYPE_SYNC);
 		if (r < 0)
 			goto out_free_2;
 	}
-- 
2.27.0

