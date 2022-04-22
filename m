Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE2050C155
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiDVWAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiDVWAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB5341DB2FC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650660180;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XZJU2fw0e7/ykJ50g6qgLPXXSEOlfoK3tt/aCOr/+c=;
        b=jHH5QUWfZYT75lBrwc74CgETnvMAJtb68x94ECAdFkOHOGUSEU5Sn7J6Mg7+YlCkbivtWj
        velDvQ05vpXg+WP1O99q2xOfbwTx5nAmvIzwrxK1dgnylZ3a4fITgjBh517kSmZhyqUWh7
        NbgaiTWGtpLMKRte5z47Bx7qWSlV45U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-Z9baH4P8PsqrEFSk-wD52A-1; Fri, 22 Apr 2022 16:01:01 -0400
X-MC-Unique: Z9baH4P8PsqrEFSk-wD52A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BDA58339B6;
        Fri, 22 Apr 2022 20:01:00 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.19.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A801DC27EB4;
        Fri, 22 Apr 2022 20:00:59 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v2 07/11] smp: change smp_call_function_any() to smp_call_any()
Date:   Fri, 22 Apr 2022 16:00:36 -0400
Message-Id: <20220422200040.93813-8-dqiao@redhat.com>
In-Reply-To: <20220422200040.93813-1-dqiao@redhat.com>
References: <20220422200040.93813-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename smp_call_function_any() to smp_call_any() and also make
the changes necessary.

Replace all the invocations of smp_call_function_any() with
smp_call_any() for all.

Actually the kernel consumers can use smp_call() when they want
to use smp_call_function_any(). The extra logics handled by
smp_call_function_any() should be moved out of there and have the
consumers choose the preferred CPU. Because there are quite a few
of the cross call consumers need to run their functions on just
one of the CPUs of a given CPU set, so there is some advantage to
add smp_call_any() to the interface.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: removed 'x' from the function names and change XCALL to SMP_CALL from the new macros

 arch/arm/kernel/perf_event_v7.c           |  6 +-
 arch/arm64/kernel/perf_event.c            |  6 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 drivers/cpufreq/acpi-cpufreq.c            |  4 +-
 drivers/cpufreq/powernv-cpufreq.c         | 12 ++--
 drivers/perf/arm_spe_pmu.c                |  2 +-
 include/linux/smp.h                       | 12 +---
 kernel/smp.c                              | 78 ++++++++++-------------
 8 files changed, 53 insertions(+), 69 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index eb2190477da1..ae008cba28c4 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1192,9 +1192,9 @@ static void armv7_read_num_pmnc_events(void *info)
 
 static int armv7_probe_num_events(struct arm_pmu *arm_pmu)
 {
-	return smp_call_function_any(&arm_pmu->supported_cpus,
-				     armv7_read_num_pmnc_events,
-				     &arm_pmu->num_events, 1);
+	return smp_call_any(&arm_pmu->supported_cpus,
+			     armv7_read_num_pmnc_events,
+			     &arm_pmu->num_events, SMP_CALL_TYPE_SYNC);
 }
 
 static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1e6138..7326c7cc67de 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1186,9 +1186,9 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	};
 	int ret;
 
-	ret = smp_call_function_any(&cpu_pmu->supported_cpus,
-				    __armv8pmu_probe_pmu,
-				    &probe, 1);
+	ret = smp_call_any(&cpu_pmu->supported_cpus,
+			    __armv8pmu_probe_pmu,
+			    &probe, SMP_CALL_TYPE_SYNC);
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 87666275eed9..418c83c3c4b5 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -512,7 +512,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->val = 0;
 	rr->first = first;
 
-	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+	(void) smp_call_any(&d->cpu_mask, mon_event_count, rr, SMP_CALL_TYPE_SYNC);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 3d514b82d055..e0c4b3c6575d 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -312,8 +312,8 @@ static u32 drv_read(struct acpi_cpufreq_data *data, const struct cpumask *mask)
 	};
 	int err;
 
-	err = smp_call_function_any(mask, do_drv_read, &cmd, 1);
-	WARN_ON_ONCE(err);	/* smp_call_function_any() was buggy? */
+	err = smp_call_any(mask, do_drv_read, &cmd, SMP_CALL_TYPE_SYNC);
+	WARN_ON_ONCE(err);	/* smp_call_any() was buggy? */
 	return cmd.val;
 }
 
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index fddbd1ea1635..d4f45bb9c419 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -507,8 +507,8 @@ static unsigned int powernv_cpufreq_get(unsigned int cpu)
 {
 	struct powernv_smp_call_data freq_data;
 
-	smp_call_function_any(cpu_sibling_mask(cpu), powernv_read_cpu_freq,
-			&freq_data, 1);
+	(void) smp_call_any(cpu_sibling_mask(cpu), powernv_read_cpu_freq,
+			&freq_data, SMP_CALL_TYPE_SYNC);
 
 	return freq_data.freq;
 }
@@ -820,8 +820,10 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	 * Use smp_call_function to send IPI and execute the
 	 * mtspr on target CPU.  We could do that without IPI
 	 * if current CPU is within policy->cpus (core)
+	 *
+	 * Shouldn't return the value of smp_call_any() ?
 	 */
-	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
+	(void) smp_call_any(policy->cpus, set_pstate, &freq_data, SMP_CALL_TYPE_SYNC);
 	return 0;
 }
 
@@ -921,8 +923,8 @@ static void powernv_cpufreq_work_fn(struct work_struct *work)
 
 	cpus_read_lock();
 	cpumask_and(&mask, &chip->mask, cpu_online_mask);
-	smp_call_function_any(&mask,
-			      powernv_cpufreq_throttle_check, NULL, 0);
+	(void) smp_call_any(&mask, powernv_cpufreq_throttle_check,
+			     NULL, SMP_CALL_TYPE_ASYNC);
 
 	if (!chip->restore)
 		goto out;
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d44bcc29d99c..e1059c60feab 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1108,7 +1108,7 @@ static int arm_spe_pmu_dev_init(struct arm_spe_pmu *spe_pmu)
 	cpumask_t *mask = &spe_pmu->supported_cpus;
 
 	/* Make sure we probe the hardware on a relevant CPU */
-	ret = smp_call_function_any(mask,  __arm_spe_pmu_dev_probe, spe_pmu, 1);
+	ret = smp_call_any(mask,  __arm_spe_pmu_dev_probe, spe_pmu, SMP_CALL_TYPE_SYNC);
 	if (ret || !(spe_pmu->features & SPE_PMU_FEAT_DEV_PROBED))
 		return -ENXIO;
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 0301faf270bf..3a6663bce18f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -161,6 +161,8 @@ do {						\
 	*(_csd) = CSD_INIT((_func), (_info));	\
 } while (0)
 
+extern int smp_call_any(const struct cpumask *mask, smp_call_func_t func,
+			 void *info, unsigned int flags);
 
 /*
  * smp_call Interface.
@@ -304,9 +306,6 @@ void smp_call_function(smp_call_func_t func, void *info, int wait);
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait);
 
-int smp_call_function_any(const struct cpumask *mask,
-			  smp_call_func_t func, void *info, int wait);
-
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
 
@@ -355,13 +354,6 @@ static inline void smp_send_reschedule(int cpu) { }
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
index 51715633b4f7..6a43ab165aee 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -626,49 +626,6 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
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
 					bool wait,
@@ -1276,6 +1233,39 @@ EXPORT_SYMBOL(smp_call_private);
 int smp_call_any(const struct cpumask *mask, smp_call_func_t func,
 		void *info, unsigned int flags)
 {
-	return 0;
+	int cpu;
+        const struct cpumask *nodemask;
+
+	if (mask == NULL || func == NULL ||
+	    (flags != SMP_CALL_TYPE_SYNC && flags != SMP_CALL_TYPE_ASYNC))
+		return -EINVAL;
+
+        /* Try for same CPU (cheapest) */
+	preempt_disable();
+	cpu = smp_processor_id();
+
+        if (cpumask_test_cpu(cpu, mask))
+                goto call;
+
+        /* Try for same node. */
+        nodemask = cpumask_of_node(cpu_to_node(cpu));
+        for (cpu = cpumask_first_and(nodemask, mask); (unsigned int)cpu < nr_cpu_ids;
+             cpu = cpumask_next_and(cpu, nodemask, mask)) {
+                if (cpu_online(cpu))
+                        goto call;
+        }
+
+        /* Any online will do: smp_call_function_single handles nr_cpu_ids. */
+        cpu = cpumask_any_and(mask, cpu_online_mask);
+	if ((unsigned int)cpu >= nr_cpu_ids) {
+        	preempt_enable();
+		return -ENXIO;
+	}
+
+call:
+	(void) smp_call(cpu, func, info, flags);
+
+        preempt_enable();
+        return 0;
 }
 EXPORT_SYMBOL(smp_call_any);
-- 
2.27.0

