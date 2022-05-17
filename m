Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31052A9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351796AbiEQSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351762AbiEQSDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F5C1506E7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810621;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzWCHLVQ2rXuc+IymoEwlmY8nM04V0+aqExE0fh29+M=;
        b=eUkZxnPcPI4StDpAUo4ZK7VezYrAMUzN/MF8Se84ejxXjSROd1JPF4ZanV/He61fZiTlZh
        NeW0CQP1hYj9jteXlqXkcrtoqXPGL+eLtnvJxHywxghi5PnRXPJx8/jkmQ2b5KrslnIKoL
        o1FARH3IMEG05TK6mvFYjHZ8jnbW4zY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-7QlbgCYxM9GR8sqE2FlGjA-1; Tue, 17 May 2022 14:03:38 -0400
X-MC-Unique: 7QlbgCYxM9GR8sqE2FlGjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E970100B8CB;
        Tue, 17 May 2022 18:03:37 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44C5B40CF8F0;
        Tue, 17 May 2022 18:03:37 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 07/11] smp: eliminate smp_call_function_any
Date:   Tue, 17 May 2022 14:03:22 -0400
Message-Id: <20220517180326.997129-8-dqiao@redhat.com>
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

When a caller needs to send a cross call to a preferred CPU,
the caller should provide the CPU rather than having the cross
call interface pick up one because an interface should do the
common job for the majority rather than cover every single
special cases.

In the scenario of smp_call_function_any(), a preferred CPU is
either the local CPU or any CPU in the same node or any online
CPU as long as it is present in cpumask. However, the way of
selecting a preferred CPU should be done by the caller rather
than by the interface. Thus, that particular code is moved
outside of smp_call_function_any() and formed a utility function
__smp_cpu_nearby() for this purpose. So, the function
smp_call_function_any() can be replaced with the combination of
__smp_cpu_nearby() and smp_call(). As a result, the function
smp_call_function_any() is eliminated.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL
	  to SMP_CALL from the new macros
v2 -> v3: Added a new utility function __smp_cpu_nearby() and
	  use the combination of __smp_cpu_nearby() and smp_call()
	  to replace smp_call_function_any() accordingly.
 arch/arm/kernel/perf_event_v7.c           | 18 +++++-
 arch/arm64/kernel/perf_event.c            | 14 ++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 12 +++-
 drivers/cpufreq/acpi-cpufreq.c            |  9 ++-
 drivers/cpufreq/powernv-cpufreq.c         | 37 +++++++++--
 drivers/perf/arm_spe_pmu.c                | 14 ++++-
 include/linux/smp.h                       | 12 +---
 kernel/smp.c                              | 77 ++++++++++-------------
 8 files changed, 123 insertions(+), 70 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index eb2190477da1..64e9d62e9720 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1192,9 +1192,21 @@ static void armv7_read_num_pmnc_events(void *info)
 
 static int armv7_probe_num_events(struct arm_pmu *arm_pmu)
 {
-	return smp_call_function_any(&arm_pmu->supported_cpus,
-				     armv7_read_num_pmnc_events,
-				     &arm_pmu->num_events, 1);
+	int cpu;
+	int ret;
+
+	preempt_disable();
+	cpu = __smp_cpu_nearby(&arm_pmu->supported_cpus);
+	if ((unsigned int)cpu >= nr_cpu_ids) {
+		preempt_enable();
+		return -ENXIO;
+	}
+
+	ret = smp_call(cpu, armv7_read_num_pmnc_events,
+			&arm_pmu->num_events, SMP_CALL_TYPE_SYNC);
+	preempt_enable();
+
+	return ret;
 }
 
 static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1e6138..be4ef28dc1d6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1184,11 +1184,19 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 		.pmu = cpu_pmu,
 		.present = false,
 	};
+	int cpu;
 	int ret;
 
-	ret = smp_call_function_any(&cpu_pmu->supported_cpus,
-				    __armv8pmu_probe_pmu,
-				    &probe, 1);
+	preempt_disable();
+	cpu = __smp_cpu_nearby(&cpu_pmu->supported_cpus);
+	if ((unsigned int)cpu >= nr_cpu_ids) {
+		preempt_enable();
+		return -ENXIO;
+	}
+
+	ret = smp_call(cpu, __armv8pmu_probe_pmu, &probe, SMP_CALL_TYPE_SYNC);
+	preempt_enable();
+
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 87666275eed9..f2dd4f29af27 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -502,6 +502,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first)
 {
+	int cpu;
+
 	/*
 	 * setup the parameters to send to the IPI to read the data.
 	 */
@@ -512,7 +514,15 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->val = 0;
 	rr->first = first;
 
-	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+	preempt_disable();
+	cpu = __smp_cpu_nearby(&d->cpu_mask);
+	if ((unsigned int)cpu >= nr_cpu_ids) {
+		preempt_enable();
+		return;
+	}
+
+	smp_call(cpu, mon_event_count, rr, SMP_CALL_TYPE_SYNC);
+	preempt_enable();
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 3d514b82d055..9bbb4b9391f8 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -310,10 +310,15 @@ static u32 drv_read(struct acpi_cpufreq_data *data, const struct cpumask *mask)
 		.reg = &perf->control_register,
 		.func.read = data->cpu_freq_read,
 	};
+	int cpu;
 	int err;
 
-	err = smp_call_function_any(mask, do_drv_read, &cmd, 1);
-	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
+	preempt_disable();
+	cpu = __smp_cpu_nearby(mask);
+	err = smp_call(cpu, do_drv_read, &cmd, SMP_CALL_TYPE_SYNC);
+	preempt_enable();
+
+	WARN_ON_ONCE(err);	/* smp_call was buggy? */
 	return cmd.val;
 }
 
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index fddbd1ea1635..078ab1c46f73 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -507,8 +507,15 @@ static unsigned int powernv_cpufreq_get(unsigned int cpu)
 {
 	struct powernv_smp_call_data freq_data;
 
-	smp_call_function_any(cpu_sibling_mask(cpu), powernv_read_cpu_freq,
-			&freq_data, 1);
+	preempt_disable();
+	cpu = (unsigned int)__smp_cpu_nearby(cpu_sibling_mask(cpu));
+	if (cpu >= nr_cpu_ids) {
+		preempt_enable();
+		return -ENXIO;
+	}
+
+	smp_call((int)cpu, powernv_read_cpu_freq, &freq_data, SMP_CALL_TYPE_SYNC);
+	preempt_enable();
 
 	return freq_data.freq;
 }
@@ -744,6 +751,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	struct powernv_smp_call_data freq_data;
 	unsigned int cur_msec, gpstate_idx;
 	struct global_pstate_info *gpstates = policy->driver_data;
+	int cpu;
 
 	if (unlikely(rebooting) && new_index != get_nominal_index())
 		return 0;
@@ -817,11 +825,20 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 
 no_gpstate:
 	/*
-	 * Use smp_call_function to send IPI and execute the
+	 * Use smp_call to send IPI and execute the
 	 * mtspr on target CPU.  We could do that without IPI
 	 * if current CPU is within policy->cpus (core)
 	 */
-	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
+	preempt_disable();
+	cpu = __smp_cpu_nearby(policy->cpus);
+	if ((unsigned int)cpu >= nr_cpu_ids) {
+		preempt_enable();
+		return -ENXIO;
+	}
+
+	smp_call(cpu, set_pstate, &freq_data, SMP_CALL_TYPE_SYNC);
+	preempt_enable();
+
 	return 0;
 }
 
@@ -921,8 +938,16 @@ static void powernv_cpufreq_work_fn(struct work_struct *work)
 
 	cpus_read_lock();
 	cpumask_and(&mask, &chip->mask, cpu_online_mask);
-	smp_call_function_any(&mask,
-			      powernv_cpufreq_throttle_check, NULL, 0);
+
+	preempt_disable();
+	cpu = (unsigned int)__smp_cpu_nearby(&mask);
+	if (cpu >= nr_cpu_ids) {
+		preempt_enable();
+		return;
+	}
+
+	smp_call((int)cpu, powernv_cpufreq_throttle_check, NULL, SMP_CALL_TYPE_ASYNC);
+	preempt_enable();
 
 	if (!chip->restore)
 		goto out;
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d44bcc29d99c..92fa8e00086f 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1104,11 +1104,21 @@ static int arm_spe_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 
 static int arm_spe_pmu_dev_init(struct arm_spe_pmu *spe_pmu)
 {
-	int ret;
 	cpumask_t *mask = &spe_pmu->supported_cpus;
+	int cpu;
+	int ret;
 
 	/* Make sure we probe the hardware on a relevant CPU */
-	ret = smp_call_function_any(mask,  __arm_spe_pmu_dev_probe, spe_pmu, 1);
+	preempt_disable();
+	cpu = __smp_cpu_nearby(mask);
+	if ((unsigned int)cpu >= nr_cpu_ids) {
+		preempt_enable();
+		return -ENXIO;
+	}
+
+	ret = smp_call(cpu, __arm_spe_pmu_dev_probe, spe_pmu, SMP_CALL_TYPE_SYNC);
+	preempt_enable();
+
 	if (ret || !(spe_pmu->features & SPE_PMU_FEAT_DEV_PROBED))
 		return -ENXIO;
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index b4885e45690b..1fb0951ca16b 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -178,6 +178,8 @@ extern void smp_call_mask_cond(const struct cpumask *mask, smp_call_func_t func,
 
 extern int smp_call_csd(int cpu, call_single_data_t *csd, unsigned int flags);
 
+extern int __smp_cpu_nearby(const struct cpumask *mask);
+
 /*
  * Enqueue a llist_node on the call_single_queue; be very careful, read
  * flush_smp_call_function_queue() in detail.
@@ -291,9 +293,6 @@ void smp_call_function(smp_call_func_t func, void *info, int wait);
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait);
 
-int smp_call_function_any(const struct cpumask *mask,
-			  smp_call_func_t func, void *info, int wait);
-
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
 
@@ -342,13 +341,6 @@ static inline void smp_send_reschedule(int cpu) { }
 			(up_smp_call_function(func, info))
 static inline void call_function_init(void) { }
 
-static inline int
-smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
-		      void *info, int wait)
-{
-	return smp_call_function_single(0, func, info, wait);
-}
-
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
 
diff --git a/kernel/smp.c b/kernel/smp.c
index f08135ad70e3..df343b1368eb 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -641,49 +641,6 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-/*
- * smp_call_function_any - Run a function on any of the given cpus
- * @mask: The mask of cpus it can run on.
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait until function has completed.
- *
- * Returns 0 on success, else a negative status code (if no cpus were online).
- *
- * Selection preference:
- *	1) current cpu if in @mask
- *	2) any cpu of current node if in @mask
- *	3) any other online cpu in @mask
- */
-int smp_call_function_any(const struct cpumask *mask,
-			  smp_call_func_t func, void *info, int wait)
-{
-	unsigned int cpu;
-	const struct cpumask *nodemask;
-	int ret;
-
-	/* Try for same CPU (cheapest) */
-	cpu = get_cpu();
-	if (cpumask_test_cpu(cpu, mask))
-		goto call;
-
-	/* Try for same node. */
-	nodemask = cpumask_of_node(cpu_to_node(cpu));
-	for (cpu = cpumask_first_and(nodemask, mask); cpu < nr_cpu_ids;
-	     cpu = cpumask_next_and(cpu, nodemask, mask)) {
-		if (cpu_online(cpu))
-			goto call;
-	}
-
-	/* Any online will do: smp_call_function_single handles nr_cpu_ids. */
-	cpu = cpumask_any_and(mask, cpu_online_mask);
-call:
-	ret = smp_call_function_single(cpu, func, info, wait);
-	put_cpu();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(smp_call_function_any);
-
 static void smp_call_function_many_cond(const struct cpumask *mask,
 					smp_call_func_t func, void *info,
 					bool local_cpu,
@@ -1072,6 +1029,40 @@ void __smp_call_mask_cond(const struct cpumask *mask,
 	preempt_enable();
 }
 
+/**
+ * Given cpumask, find an online CPU as close to the local CPU as
+ * possible in the order below:
+ *
+ *   - The first pick is the local CPU if it is present in cpumask.
+ *   - The second pick is a CPU located in the same node of the
+ *     local CPU and it is also present in cpumask.
+ *   - The Third pick is any online CPU which is also in cpumask.
+ *
+ * The callers should disable preemption when using this function.
+ */
+int __smp_cpu_nearby(const struct cpumask *mask)
+{
+        int cpu;
+        const struct cpumask *nodemask;
+
+        cpu = smp_processor_id();
+        if (cpumask_test_cpu(cpu, mask))
+                return cpu;
+
+        /* Any CPU in the same node */
+        nodemask = cpumask_of_node(cpu_to_node(cpu));
+        for (cpu = cpumask_first_and(nodemask, mask); cpu < nr_cpu_ids;
+             cpu = cpumask_next_and(cpu, nodemask, mask)) {
+                if (cpu_online(cpu))
+                        return cpu;
+        }
+
+        /* Any online CPU will do */
+        cpu = cpumask_any_and(mask, cpu_online_mask);
+        return cpu;
+}
+EXPORT_SYMBOL(__smp_cpu_nearby);
+
 /*
  * smp_call Interface
  *
-- 
2.27.0

