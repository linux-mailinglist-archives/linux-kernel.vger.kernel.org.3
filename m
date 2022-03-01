Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA14C953C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiCAT5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiCAT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F586D4D7;
        Tue,  1 Mar 2022 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164556; x=1677700556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lJyla5FagWFCwraH51W1efpjORCyrwBuUXLYfAA9vgM=;
  b=nS6x7XPj2zheOug8jrw2+H9ru/GkF+ogXmZ6L1CpLY3Oc9RaV6s1DwY1
   yyuP+K6Q3k4qiHAWD/6M1CRIPYh9Lo4M47wa7W5OvH5W/dTETygn4T6zi
   1PKKShbNs5lVEDaVvsihnP08bar3E6XJOroKypdNeYCNTFK4c8wmSXR7k
   MCpx+0AMLIKKtR9+07bv/jvJNNYlAzV3Q9iaXjj7jv7iHP+CDyFNL4knj
   kT6JLXQJOMGNH2MLOoQrUmIdW21g9GM/knu/WtDb+t3hnYV7HCkhaiQ2O
   rbzrRuyV8GSdXpRKnhL/tgpugY//JO9h5AGOcloYMkW/NIFwL2jSVzG2F
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194898"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194898"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133173"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: [RFC 07/10] platform/x86/intel/ifs: Create kthreads for online cpus for scan test
Date:   Tue,  1 Mar 2022 11:54:54 -0800
Message-Id: <20220301195457.21152-8-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create scan kthreads for online logical cpus. Once scan test is triggered,
it wakes up the corresponding thread and its sibling threads to execute
the test. Once the scan test is done, the threads go back to thread wait
for next signal to start a new scan.

In a core, the scan engine is shared between siblings. When a scan test
is triggered on a core, all the siblings rendezvous before the test execution.
The scan results are same for all siblings.

Scan may be aborted by some reasons. Scan test will be aborted in certain
circumstances such as when interrupt occurred or cpu does not have enough
power budget for scan. In this case, the kernel restart scan from the chunk
where it stopped. Scan will also be aborted when the test is failed. In
this case, the test is immediately stopped without retry.

Originally-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c | 317 ++++++++++++++++++++++++++
 drivers/platform/x86/intel/ifs/ifs.h  |  91 ++++++++
 2 files changed, 408 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 765d9a2c4683..6747b523587a 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -4,11 +4,38 @@
  * Author: Jithu Joseph <jithu.joseph@intel.com>
  */
 
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
+#include <linux/nmi.h>
 #include <asm/cpu_device_id.h>
 
 #include "ifs.h"
+
+static enum cpuhp_state cpuhp_scan_state;
 struct ifs_params ifs_params;
+int cpu_sibl_ct;
+atomic_t siblings_in;	/* sibling count for joining rendezvous.*/
+atomic_t siblings_out;	/* sibling count for exiting rendezvous.*/
+struct completion test_thread_done; /* set when scan are done for all siblings threads.*/
+
+DEFINE_PER_CPU(struct ifs_state, ifs_state);
+
+static int ifs_retry_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops ifs_retry_ops = {
+	.set = ifs_retry_set,
+	.get = param_get_int,
+};
+
+static int retry = 5;
+module_param_cb(retry, &ifs_retry_ops, &retry, 0644);
+
+MODULE_PARM_DESC(retry, "Maximum retry count when the test is not executed");
+
+static bool noint = 1;
+module_param(noint, bool, 0644);
+MODULE_PARM_DESC(noint, "Option to enable/disable interrupt during test");
 
 #define X86_MATCH(model)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
@@ -21,6 +48,273 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 
+static int ifs_retry_set(const char *val, const struct kernel_param *kp)
+{
+	int var = 0;
+
+	if (kstrtoint(val, 0, &var)) {
+		pr_err("unable to parse retry\n");
+		return -EINVAL;
+	}
+
+	/* validate retry value for sanity */
+	if (var < 1 || var > 20) {
+		pr_err("retry parameter should be between 1 and 20\n");
+		return -EINVAL;
+	}
+
+	return param_set_int(val, kp);
+}
+
+static unsigned long msec_to_tsc(unsigned long msec)
+{
+	return tsc_khz * 1000 * msec / MSEC_PER_SEC;
+}
+
+static const char * const scan_test_status[] = {
+	"SCAN no error",
+	"Other thread could not join.",
+	"Interrupt occurred prior to SCAN coordination.",
+	"Core Abort SCAN Response due to power management condition.",
+	"Non valid chunks in the range",
+	"Mismatch in arguments between threads T0/T1.",
+	"Core not capable of performing SCAN currently",
+	"Unassigned error code 0x7",
+	"Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
+	"Interrupt occurred prior to SCAN start",
+};
+
+static void message_not_tested(int cpu, union ifs_status status)
+{
+	if (status.error_code < ARRAY_SIZE(scan_test_status))
+		pr_warn("CPU %d: SCAN operation did not start. %s\n", cpu,
+			scan_test_status[status.error_code]);
+	else if (status.error_code == IFS_SW_TIMEOUT)
+		pr_warn("CPU %d: software timeout during scan\n", cpu);
+	else if (status.error_code == IFS_SW_PARTIAL_COMPLETION)
+		pr_warn("CPU %d: %s\n", cpu,
+			"Not all scan chunks were executed. Maximum forward progress retries exceeded");
+	else
+		pr_warn("CPU %d: SCAN unknown status %llx\n", cpu, status.data);
+}
+
+static void message_fail(int cpu, union ifs_status status)
+{
+	if (status.control_error) {
+		pr_err("CPU %d: scan failed. %s\n", cpu,
+		       "Suggest reload scan file: # echo 1 > /sys/devices/system/cpu/ifs/reload");
+	}
+	if (status.signature_error) {
+		pr_err("CPU %d: test signature incorrect. %s\n", cpu,
+		       "Suggest retry scan to check if problem is transient");
+	}
+}
+
+static bool can_restart(union ifs_status status)
+{
+	/* Signature for chunk is bad, or scan test failed */
+	if (status.signature_error || status.control_error)
+		return false;
+
+	switch (status.error_code) {
+	case IFS_POWER_MGMT_INADEQUATE_FOR_SCAN:
+		mdelay(1);
+		fallthrough;
+	case IFS_NO_ERROR:
+	case IFS_OTHER_THREAD_DID_NOT_JOIN:
+	case IFS_INTERRUPTED_BEFORE_RENDEZVOUS:
+	case IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT:
+	case IFS_INTERRUPTED_DURING_EXECUTION:
+		return true;
+	}
+	return false;
+}
+
+static bool wait_for_siblings(atomic_t *t, long long timeout)
+{
+	atomic_inc(t);
+	while (atomic_read(t) < cpu_sibl_ct) {
+		if (timeout < SPINUNIT) {
+			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+			       cpu_sibl_ct - atomic_read(t));
+			return false;
+		}
+
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
+
+		touch_nmi_watchdog();
+	}
+
+	return true;
+}
+
+/*
+ * Scan test kthreads bound with each logical cpu.
+ * Wait for the sibling thread to join before the execution.
+ * Execute the scan test by running wrmsr(MSR_ACTIVATE_SCAN).
+ */
+static int scan_test_worker(void *info)
+{
+	int cpu = smp_processor_id();
+	union ifs_scan activate;
+	union ifs_status status;
+	unsigned long timeout;
+	int retries;
+	u32 first;
+
+	activate.rsvd = 0;
+	activate.delay = msec_to_tsc(THREAD_WAIT);
+	activate.sigmce = 0;
+
+	while (1) {
+		/* wait event until cpumask set from user */
+		wait_event_interruptible(per_cpu(ifs_state, cpu).scan_wq,
+					 (cpumask_test_cpu(cpu, &per_cpu(ifs_state, cpu).mask) ||
+					 kthread_should_stop()));
+
+		if (kthread_should_stop())
+			break;
+
+		/*
+		 * Need to get (and keep) the threads on this core executing close together
+		 * so that the writes to MSR_ACTIVATE_SCAN below will succeed in entering
+		 * IFS test mode on this core. Interrupts on each thread are expected to be
+		 * brief. But preemption would be a problem.
+		 */
+		preempt_disable();
+
+		/* wait for the sibling threads to join */
+		first = cpumask_first(topology_sibling_cpumask(cpu));
+		if (!wait_for_siblings(&siblings_in, NSEC_PER_SEC)) {
+			preempt_enable();
+			return -1;
+		}
+
+		activate.start = 0;
+		activate.stop = ifs_params.valid_chunks - 1;
+		timeout = jiffies + HZ / 2;
+		retries = retry;
+
+		while (activate.start <= activate.stop) {
+			if (time_after(jiffies, timeout)) {
+				status.error_code = IFS_SW_TIMEOUT;
+				break;
+			}
+
+			if (noint)
+				local_irq_disable();
+			/* scan start */
+			wrmsrl(MSR_ACTIVATE_SCAN, activate.data);
+
+			if (noint)
+				local_irq_enable();
+
+			/*
+			 * All logical CPUs on this core are now running IFS test. When it completes
+			 * execution or is interrupted, the following RDMSR gets the scan status.
+			 */
+
+			rdmsrl(MSR_SCAN_STATUS, status.data);
+
+			/* Some cases can be retried, give up for others */
+			if (!can_restart(status))
+				break;
+
+			if (status.chunk_num == activate.start) {
+				/* Check for forward progress */
+				if (retries-- == 0) {
+					if (status.error_code == IFS_NO_ERROR)
+						status.error_code = IFS_SW_PARTIAL_COMPLETION;
+					break;
+				}
+			} else {
+				retries = retry;
+				activate.start = status.chunk_num;
+			}
+		}
+
+		preempt_enable();
+
+		/* Update status for this core */
+		per_cpu(ifs_state, cpu).scan_details = status.data;
+
+		if (status.control_error || status.signature_error) {
+			per_cpu(ifs_state, cpu).status = SCAN_TEST_FAIL;
+			cpumask_set_cpu(cpu, &ifs_params.fail_mask);
+			cpumask_clear_cpu(cpu, &ifs_params.not_tested_mask);
+			cpumask_clear_cpu(cpu, &ifs_params.pass_mask);
+			message_fail(cpu, status);
+		} else if (status.error_code) {
+			per_cpu(ifs_state, cpu).status = SCAN_NOT_TESTED;
+			cpumask_set_cpu(cpu, &ifs_params.not_tested_mask);
+			cpumask_clear_cpu(cpu, &ifs_params.fail_mask);
+			cpumask_clear_cpu(cpu, &ifs_params.pass_mask);
+			message_not_tested(cpu, status);
+		} else {
+			per_cpu(ifs_state, cpu).status = SCAN_TEST_PASS;
+			cpumask_set_cpu(cpu, &ifs_params.pass_mask);
+			cpumask_clear_cpu(cpu, &ifs_params.not_tested_mask);
+			cpumask_clear_cpu(cpu, &ifs_params.fail_mask);
+		}
+
+		cpumask_clear_cpu(cpu, &per_cpu(ifs_state, cpu).mask);
+
+		if (!wait_for_siblings(&siblings_out, NSEC_PER_SEC))
+			return -1;
+
+		if (cpu == first)
+			complete(&test_thread_done);
+	}
+
+	return 0;
+}
+
+static void ifs_first_time(unsigned int cpu)
+{
+	init_waitqueue_head(&(per_cpu(ifs_state, cpu).scan_wq));
+
+	per_cpu(ifs_state, cpu).first_time = 1;
+	per_cpu(ifs_state, cpu).status = SCAN_NOT_TESTED;
+	cpumask_set_cpu(cpu, &ifs_params.not_tested_mask);
+	cpumask_clear_cpu(cpu, &ifs_params.fail_mask);
+	cpumask_clear_cpu(cpu, &ifs_params.pass_mask);
+}
+
+static int ifs_online_cpu(unsigned int cpu)
+{
+	/* If the CPU is coming online for the first time*/
+	if (per_cpu(ifs_state, cpu).first_time == 0)
+		ifs_first_time(cpu);
+
+	cpumask_clear_cpu(cpu, &(per_cpu(ifs_state, cpu).mask));
+
+	per_cpu(ifs_state, cpu).scan_task = kthread_create_on_node(scan_test_worker, (void *)&cpu,
+								   cpu_to_node(cpu), "ifsCpu/%u",
+								   cpu);
+	if (IS_ERR(per_cpu(ifs_state, cpu).scan_task)) {
+		pr_err("scan_test_worker task create failed\n");
+		return PTR_ERR(per_cpu(ifs_state, cpu).scan_task);
+	}
+	kthread_bind(per_cpu(ifs_state, cpu).scan_task, cpu);
+	wake_up_process(per_cpu(ifs_state, cpu).scan_task);
+
+	return 0;
+}
+
+static int ifs_offline_cpu(unsigned int cpu)
+{
+	struct task_struct *thread;
+
+	thread = per_cpu(ifs_state, cpu).scan_task;
+	per_cpu(ifs_state, cpu).scan_task = NULL;
+
+	if (thread)
+		kthread_stop(thread);
+
+	return 0;
+}
+
 static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
@@ -42,11 +336,34 @@ static int __init ifs_init(void)
 		return ret;
 	}
 
+	init_completion(&test_thread_done);
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/ifs:online",
+				ifs_online_cpu, ifs_offline_cpu);
+
+	if (ret < 0) {
+		pr_err("cpuhp_setup_failed\n");
+		return ret;
+	}
+	cpuhp_scan_state = ret;
+
 	return 0;
 }
 
 static void __exit ifs_exit(void)
 {
+	struct task_struct *thread;
+	int cpu;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		thread = per_cpu(ifs_state, cpu).scan_task;
+		per_cpu(ifs_state, cpu).scan_task = NULL;
+		if (thread)
+			kthread_stop(thread);
+	}
+	cpus_read_unlock();
+	cpuhp_remove_state(cpuhp_scan_state);
+
 	pr_info("unloaded 'In-Field Scan' module\n");
 }
 
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 8f9abdb304b0..fcbbb49faa19 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -18,6 +18,13 @@
 #define MSR_SCAN_HASHES_STATUS			0x000002c3
 #define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
 #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
+#define MSR_ACTIVATE_SCAN			0x000002c6
+#define MSR_SCAN_STATUS				0x000002c7
+#define SCAN_TEST_PASS				0
+#define SCAN_TEST_FAIL				1
+#define SCAN_NOT_TESTED				2
+#define SPINUNIT				100
+#define THREAD_WAIT				5
 
 /* MSR_SCAN_HASHES_STATUS bit fields */
 union ifs_scan_hashes_status {
@@ -45,16 +52,100 @@ union ifs_chunks_auth_status {
 	};
 };
 
+/* MSR_ACTIVATE_SCAN bit fields */
+union ifs_scan {
+	u64	data;
+	struct {
+		u64	start	:8;
+		u64	stop	:8;
+		u64	rsvd	:16;
+		u64	delay	:31;
+		u64	sigmce	:1;
+	};
+};
+
+/* MSR_SCAN_STATUS bit fields */
+union ifs_status {
+	u64	data;
+	struct {
+		u64	chunk_num		:8;
+		u64	chunk_stop_index	:8;
+		u64	rsvd1			:16;
+		u64	error_code		:8;
+		u64	rsvd2			:22;
+		u64	control_error		:1;
+		u64	signature_error		:1;
+	};
+};
+
+/*
+ * ifs_status.error_code values after rdmsr(SCAN_STATUS)
+ * 0x0: no error.
+ * 0x1: scan did not start because all sibling threads did not join.
+ * 0x2: scan did not start because interrupt occurred prior to threads rendezvous
+ * 0x3: scan did not start because power management conditions are inadequate.
+ * 0x4: scan did not start because non-valid chunks in range stop_index:start_index.
+ * 0x5: scan did not start because of mismatches in arguments between sibling threads.
+ * 0x6: scan did not start because core is not capable of performing scan currently.
+ * 0x7: not assigned.
+ * 0x8: scan did not start because of exceed number of concurrent CPUs attempt to run scan.
+ * 0x9: interrupt occurred. Scan operation aborted prematurely. Not all chunks executed.
+ * 0xFE: not all scan chunks were executed. Maximum forward progress retries exceeded.
+ *	 This is a driver populated error-code as hardware returns success in this scenario.
+ */
+#define IFS_NO_ERROR				0x0
+#define IFS_OTHER_THREAD_DID_NOT_JOIN		0x1
+#define IFS_INTERRUPTED_BEFORE_RENDEZVOUS	0x2
+#define IFS_POWER_MGMT_INADEQUATE_FOR_SCAN	0x3
+#define IFS_INVALID_CHUNK_RANGE			0x4
+#define IFS_MISMATCH_ARGUMENTS_BETWEEN_THREADS	0x5
+#define IFS_CORE_NOT_CAPABLE_CURRENTLY		0x6
+/* Code 0x7 not assigned */
+#define IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT	0x8
+#define IFS_INTERRUPTED_DURING_EXECUTION	0x9
+
+#define IFS_SW_TIMEOUT				0xFD
+#define IFS_SW_PARTIAL_COMPLETION		0xFE
+
 /**
  * struct ifs_params - global ifs parameter for all cpus.
  * @loaded_version: stores the currently loaded ifs image version.
  * @valid_chunks: number of chunks which could be validated.
+ * @fail_mask: stores the cpus which failed the scan.
+ * @not_tested_mask: stores the cpus which have not been tested.
  */
 struct ifs_params {
 	int loaded_version;
 	int valid_chunks;
+	struct cpumask fail_mask;
+	struct cpumask pass_mask;
+	struct cpumask not_tested_mask;
 };
 
+/**
+ * struct ifs_state - per-cpu ifs parameter.
+ * @scan_task: scan_task for kthread to run scan test on each cpu.
+ * @first_time: to track if cpu is coming online for the first time.
+ * @status: it holds simple status pass/fail/untested.
+ * @scan_details: opaque scan status code from h/w.
+ * @scan_wq: kthread task wait queue.
+ * @mask: triggering the test by setting the mask.
+ */
+struct ifs_state {
+	struct task_struct *scan_task;
+	int first_time;
+	int status;
+	u64 scan_details;
+	wait_queue_head_t scan_wq;
+	struct cpumask mask;
+};
+
+DECLARE_PER_CPU(struct ifs_state, ifs_state);
+
 int load_ifs_binary(void);
 extern struct ifs_params ifs_params;
+extern atomic_t siblings_in;
+extern atomic_t siblings_out;
+extern struct completion test_thread_done;
+extern int cpu_sibl_ct;
 #endif
-- 
2.17.1

