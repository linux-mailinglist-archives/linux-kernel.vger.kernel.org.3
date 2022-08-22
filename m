Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9B59B77E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiHVCQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiHVCQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:16:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D522288;
        Sun, 21 Aug 2022 19:15:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r69so8185530pgr.2;
        Sun, 21 Aug 2022 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WLszNFH6rAx833ludRXMY401Pm+H+RTV6I0FYUgHTg0=;
        b=SqqVBMOnC7CzBii1m0ocTxbCUywgAQHCwLfgqx83GK4H1dtDbCF9O6MIHnUWaRicTM
         26QmKxmEBTyB+zRhgsS02GmtOBoSUG3n9vNLTx/oVFe/iLv2YXG5DBfeJVvp3N98Nqw3
         QrOZY8/GZMChwXBy246ZcaxGqyefNTj4lrsFOg7n9KSwMyGWA/PJun+O3rN7k6IKejoS
         W0WGG2sDMSITPd9l5SFj5FDjiB8VxiEy3h01jTkhf4lwHS2n4jaEtlm95zcq47ioODO/
         +xzMNd/XLGxseTgLin18K/K9szEkCq6SJSsPsuypa2ZcYXvVOjiUTEtup+0S+TuAjbog
         PD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WLszNFH6rAx833ludRXMY401Pm+H+RTV6I0FYUgHTg0=;
        b=WCRFC+8jMAoTgo7cxei6/FmCEAm8LbBWhUWgMI2YNrYUkNbmXuanKvivQ0P14TKIpc
         NI5YghcAt6UhgadbR/pXtEb46256fW6BvpX/v60OOB2UUtfmpKgGbcrFer49N3nxpLVN
         zMb6k2gDvcSwFz09REzve0Xj8nTEA/ChGUN2NO/AuMQZSLsaBvyFh3cIfFCb4tgr6qn/
         DdfsvmXI4kAfx0RoWsSo8kfOhZ6LKS8hDxwtp/1XQiC0h7DUXtKJCqE4wPookdxvdd9e
         A1mnJlEm2al8viQey7FF0tI4BC3Z9dJLtlHSS8ldecAhemzb8LKo5daCyDVEHycS6bS4
         uEEQ==
X-Gm-Message-State: ACgBeo3UUHiuelYgqYyr0C0n2cj1LfOYL03cmJI4PANcIYaK6yrUJjlq
        1vvOxfis3IngBgKJSka6VA==
X-Google-Smtp-Source: AA6agR6OqW8j4jhaYEyPSXqhTTqweo/eD8PzrvQ6+13CJ2uOIZ0noYxOQmPKYGKHiep+6to1lt7J9Q==
X-Received: by 2002:a05:6a00:23c1:b0:536:463e:e53b with SMTP id g1-20020a056a0023c100b00536463ee53bmr9714834pfc.43.1661134556164;
        Sun, 21 Aug 2022 19:15:56 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:15:55 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [RFC 03/10] cpu/hotplug: Introduce fast kexec reboot
Date:   Mon, 22 Aug 2022 10:15:13 +0800
Message-Id: <20220822021520.6996-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** Current situation 'slow kexec reboot' ***

At present, some architectures rely on smp_shutdown_nonboot_cpus() to
implement "kexec -e". Since smp_shutdown_nonboot_cpus() tears down the
cpus serially, it is very slow.

Take a close look, a cpu_down() processing on a single cpu can approximately be
divided into two stages:
-1. from CPUHP_ONLINE to CPUHP_TEARDOWN_CPU
-2. from CPUHP_TEARDOWN_CPU to CPUHP_AP_IDLE_DEAD
    which is by stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
    and runs on the teardown cpu.

If these processes can run in parallel, then, the reboot can be speeded
up. That is the aim of this patch.

*** Contrast to other implements ***

X86 and PowerPC have their own machine_shutdown(), which does not reply
on the cpu hot-removing mechanism. They just discriminate some critical
component and tears them down in per cpu NMI handler during the kexec
reboot. But for some architectures, let's say arm64, it is not easy to define
these critical component due to various chipmakers' implements.

As a result, sticking to the cpu hot-removing mechanism is the simplest
way to re-implement the parallel. It also renders an opportunity to
implement the cpu_down() in parallel in future (not done by this series).

*** Things worthy of consideration ***

1. The definition of a clean boundary between the first kernel and the new kernel
-1.1 firmware
     The firmware's internal state should enter into a proper state.
And this is achieved by the firmware's cpuhp_step's teardown interface
if any.

-1.2 CPU internal
     Whether the cache or PMU needs a clean shutdown before rebooting.

2. The dependency of each cpuhp_step
   The boundary of a clean cut involves only few cpuhp_step, but they
may propagate to other cpuhp_step by the way of the dependency. This
series does not bother to judge the dependency, instead, just iterate
downside each cpuhp_step. And this stragegy demands that each cpuhp_step's
teardown interface supports parallel.

*** Solution ***

Ideally, if the interface _cpu_down() can be enhanced to enable
parallel, then the fast reboot can be achieved.

But revisiting the two parts of the current cpu_down() process, the
second part 'stop_machine_cpuslocked()' is a blockade. Packed inside the
_cpu_down(), stop_machine_cpuslocked() only allow one cpu to execute the
teardown.

So this patch breaks down the process of _cpu_down(), and divides the
teardown into three steps.  And the exposed stop_machine_cpuslocked()
can be used to support parallel.
1. Bring each AP from CPUHP_ONLINE to CPUHP_TEARDOWN_CPU
   in parallel.
2. Sync on BP to wait all APs to enter CPUHP_TEARDOWN_CPU state
3. Bring each AP from CPUHP_TEARDOWN_CPU to CPUHP_AP_IDLE_DEAD by the
   interface of stop_machine_cpuslocked() in parallel.

Apparently, the step 2 is introduced in order to satisfy the condition
on which stop_machine_cpuslocked() can start on each cpu.

Then the rest issue is about how to support parallel in step 1&3.
Furtunately, each subsystem has its own carefully designed lock
mechanism. In each cpuhp_step teardown interface, adopting to the
subsystem's lock rule will make things work.

*** No rollback if failure ***

During kexec reboot, the devices have already been shutdown, there is no
way for system to roll back to a workable state. So this series also
does not consider the rollback issue.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arm-kernel@lists.infradead.org
To: linux-ia64@vger.kernel.org
To: linux-riscv@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/cpu.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 129 insertions(+), 10 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2be6ba811a01..94ab2727d6bb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1260,10 +1260,125 @@ EXPORT_SYMBOL_GPL(remove_cpu);
 
 #ifdef CONFIG_SHUTDOWN_NONBOOT_CPUS
 
-void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
+/*
+ * Push all of cpus to the state CPUHP_AP_ONLINE_IDLE.
+ * Since kexec-reboot has already shut down all devices, there is no way to
+ * roll back, the cpus' teardown also requires no rollback, instead, just throw
+ * warning.
+ */
+static void cpus_down_no_rollback(struct cpumask *cpus)
 {
+	struct cpuhp_cpu_state *st;
 	unsigned int cpu;
+
+	/* launch ap work one by one, but not wait for completion */
+	for_each_cpu(cpu, cpus) {
+		st = per_cpu_ptr(&cpuhp_state, cpu);
+		/*
+		 * If the current CPU state is in the range of the AP hotplug thread,
+		 * then we need to kick the thread.
+		 */
+		if (st->state > CPUHP_TEARDOWN_CPU) {
+			cpuhp_set_state(cpu, st, CPUHP_TEARDOWN_CPU);
+			/* In order to parallel, async. And there is no way to rollback */
+			cpuhp_kick_ap_work_async(cpu);
+		}
+	}
+
+	/* wait for all ap work completion */
+	for_each_cpu(cpu, cpus) {
+		st = per_cpu_ptr(&cpuhp_state, cpu);
+		wait_for_ap_thread(st, st->bringup);
+		if (st->result)
+			pr_warn("cpu %u refuses to offline due to %d\n", cpu, st->result);
+		else if (st->state > CPUHP_TEARDOWN_CPU)
+			pr_warn("cpu %u refuses to offline, state: %d\n", cpu, st->state);
+	}
+}
+
+static int __takedown_cpu_cleanup(unsigned int cpu)
+{
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+
+	/*
+	 * The teardown callback for CPUHP_AP_SCHED_STARTING will have removed
+	 * all runnable tasks from the CPU, there's only the idle task left now
+	 * that the migration thread is done doing the stop_machine thing.
+	 *
+	 * Wait for the stop thread to go away.
+	 */
+	wait_for_ap_thread(st, false);
+	BUG_ON(st->state != CPUHP_AP_IDLE_DEAD);
+
+	hotplug_cpu__broadcast_tick_pull(cpu);
+	/* This actually kills the CPU. */
+	__cpu_die(cpu);
+
+	tick_cleanup_dead_cpu(cpu);
+	rcutree_migrate_callbacks(cpu);
+	return 0;
+}
+
+/*
+ * There is a sync that all ap threads are done before calling this func.
+ */
+static void takedown_cpus_no_rollback(struct cpumask *cpus)
+{
+	struct cpuhp_cpu_state *st;
+	unsigned int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		st = per_cpu_ptr(&cpuhp_state, cpu);
+		WARN_ON(st->state != CPUHP_TEARDOWN_CPU);
+		/* No invoke to takedown_cpu(), so set the state by manual */
+		st->state = CPUHP_AP_ONLINE;
+		cpuhp_set_state(cpu, st, CPUHP_AP_OFFLINE);
+	}
+
+	irq_lock_sparse();
+	/* ask stopper kthreads to execute take_cpu_down() in parallel */
+	stop_machine_cpuslocked(take_cpu_down, NULL, cpus);
+
+	/* Finally wait for completion and clean up */
+	for_each_cpu(cpu, cpus)
+		__takedown_cpu_cleanup(cpu);
+	irq_unlock_sparse();
+}
+
+static bool check_quick_reboot(void)
+{
+	return false;
+}
+
+static struct cpumask kexec_ap_map;
+
+void smp_shutdown_nonboot_cpus_quick_path(unsigned int primary_cpu)
+{
+	struct cpumask *cpus = &kexec_ap_map;
+	/*
+	 * To prevent other subsystem from access to __cpu_online_mask, but internally,
+	 * __cpu_disable() accesses the bitmap in parral and needs its own local lock.
+	 */
+	cpus_write_lock();
+
+	cpumask_copy(cpus, cpu_online_mask);
+	cpumask_clear_cpu(primary_cpu, cpus);
+	cpus_down_no_rollback(cpus);
+	takedown_cpus_no_rollback(cpus);
+	/*
+	 * For some subsystems, there are still remains for offline cpus from
+	 * CPUHP_BRINGUP_CPU to CPUHP_OFFLINE. But since none of them interact
+	 * with hardwares or firmware, they have no effect on the new kernel.
+	 * So skipping the cpuhp callbacks in that range
+	 */
+
+	cpus_write_unlock();
+}
+
+void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
+{
 	int error;
+	unsigned int cpu;
 
 	cpu_maps_update_begin();
 
@@ -1275,15 +1390,19 @@ void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 	if (!cpu_online(primary_cpu))
 		primary_cpu = cpumask_first(cpu_online_mask);
 
-	for_each_online_cpu(cpu) {
-		if (cpu == primary_cpu)
-			continue;
-
-		error = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
-		if (error) {
-			pr_err("Failed to offline CPU%d - error=%d",
-				cpu, error);
-			break;
+	if (check_quick_reboot()) {
+		smp_shutdown_nonboot_cpus_quick_path(primary_cpu);
+	} else {
+		for_each_online_cpu(cpu) {
+			if (cpu == primary_cpu)
+				continue;
+
+			error = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
+			if (error) {
+				pr_err("Failed to offline CPU%d - error=%d",
+					cpu, error);
+				break;
+			}
 		}
 	}
 
-- 
2.31.1

