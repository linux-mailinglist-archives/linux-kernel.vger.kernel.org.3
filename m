Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262924F87E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiDGTRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347114AbiDGTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F223F3F1;
        Thu,  7 Apr 2022 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358867; x=1680894867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=inyPPtiiV99F/m6AV9LrXbOnS06GFQSO9ickEP8Fo6I=;
  b=mwBzhRln1j5tLXR8eYAXezowzhk/VQwG2lH3bpb2I89XOEFf9/3JvJsp
   DkVfVBLlw1B7kEqY9tMeekCuJbfHvaC+BWmr5fD9RwZ9fJ8wmllD7A1bp
   q8lpmPrXzo6cqd+p0SkVp5Yrc7emzCLnQ8v90BGW0CfVDeDx7QqBczH7o
   x6vsxOGeWoDyFybrg4hpG6CP7OxZJj8/YC5aqLW7kWvLsgsI5ehHTx0m5
   Lur89O57m0FhsWLKWURyFzR5XnYyQS8GWExiQlD92nwOyCwiaC/biIrrf
   fjCv9jpznBd/wHaYbnFf1xeOLai/Wmz6Ard26VkU6mG8y1o7nNq2R6heP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255386"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255386"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193724"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:18 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v2 07/10] platform/x86/intel/ifs: Add scan test support
Date:   Thu,  7 Apr 2022 12:13:44 -0700
Message-Id: <20220407191347.9681-8-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407191347.9681-1-jithu.joseph@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a core, the scan engine is shared between sibling cpus.

When a Scan test (for a particular core) is triggered by the user,
worker threads for each sibling cpus(belonging to that core) are
queued to execute the scan test function in the Workqueue context.

All the siblings rendezvous before the test execution. The scan
results are same for all siblings.

Scan may be aborted by some reasons. Scan test will be aborted in certain
circumstances such as when interrupt occurred or cpu does not have enough
power budget for scan. In this case, the kernel restart scan from the chunk
where it stopped. Scan will also be aborted when the test is failed. In
this case, the test is immediately stopped without retry.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/Makefile  |   2 +-
 drivers/platform/x86/intel/ifs/core.c    |  14 ++
 drivers/platform/x86/intel/ifs/ifs.h     |  76 ++++++
 drivers/platform/x86/intel/ifs/runtest.c | 295 +++++++++++++++++++++++
 4 files changed, 386 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/ifs/runtest.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index b69d026ca9da..d5905e5d2de8 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_INTEL_IFS)			+= intel_ifs.o
 
-intel_ifs-objs				:= core.o load.o
+intel_ifs-objs				:= core.o load.o runtest.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 716f333a064b..95847e00038b 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -9,6 +9,9 @@
 
 struct platform_device *ifs_pdev;
 struct ifs_binary ifs_binary;
+struct ifs_test ifs_test;
+
+struct workqueue_struct *ifs_wq;
 
 #define X86_MATCH(model)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
@@ -86,6 +89,15 @@ static int __init ifs_init(void)
 		goto drv_unreg;
 	}
 
+	/* Flags are to keep all the sibling cpu worker threads (of a core) in close sync */
+	ifs_wq = alloc_workqueue("intel_ifs", (WQ_HIGHPRI | WQ_CPU_INTENSIVE), 1);
+	if (!ifs_wq) {
+		dev_err(&ifs_pdev->dev, "Failed to create work queue\n");
+		platform_device_unregister(ifs_pdev);
+		ret = -ENOMEM;
+		goto drv_unreg;
+	}
+	init_completion(&ifs_test.test_thread_done);
 	return 0;
 
 drv_unreg:
@@ -96,6 +108,8 @@ static int __init ifs_init(void)
 
 static void __exit ifs_exit(void)
 {
+	flush_workqueue(ifs_wq);
+	destroy_workqueue(ifs_wq);
 	platform_device_unregister(ifs_pdev);
 	platform_driver_unregister(&ifs_driver);
 }
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 4d12f8e71c67..93cc1af4aea0 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -14,6 +14,13 @@
 #define MSR_SCAN_HASHES_STATUS			0x000002c3
 #define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
 #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
+#define MSR_ACTIVATE_SCAN			0x000002c6
+#define MSR_SCAN_STATUS				0x000002c7
+#define SCAN_NOT_TESTED				0
+#define SCAN_TEST_PASS				1
+#define SCAN_TEST_FAIL				2
+#define SPINUNIT				100
+#define THREAD_WAIT				5
 
 /* MSR_SCAN_HASHES_STATUS bit fields */
 union ifs_scan_hashes_status {
@@ -41,6 +48,53 @@ union ifs_chunks_auth_status {
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
+enum ifs_status_err_code {
+	IFS_NO_ERROR = 0,
+	IFS_OTHER_THREAD_COULD_NOT_JOIN,
+	IFS_INTERRUPTED_BEFORE_RENDEZVOUS,
+	IFS_POWER_MGMT_INADEQUATE_FOR_SCAN,
+	IFS_INVALID_CHUNK_RANGE,
+	IFS_MISMATCH_ARGUMENTS_BETWEEN_THREADS,
+	IFS_CORE_NOT_CAPABLE_CURRENTLY,
+	IFS_UNASSIGNED_ERROR_CODE,
+	IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT,
+	IFS_INTERRUPTED_DURING_EXECUTION,
+};
+
+/*
+ * Driver populated error-codes
+ * 0xFD: Test timed out before completing all the chunks.
+ * 0xFE: not all scan chunks were executed. Maximum forward progress retries exceeded.
+ */
+#define IFS_SW_TIMEOUT				0xFD
+#define IFS_SW_PARTIAL_COMPLETION		0xFE
+
 /**
  * struct ifs_binary - attributes related to test binary
  * @loaded_version: stores the currently loaded ifs image version.
@@ -53,7 +107,29 @@ struct ifs_binary {
 	bool loaded;
 };
 
+/**
+ * struct ifs_test - various parameters pertaining to a test
+ * @status: it holds simple status pass/fail/untested
+ * @cpu_sibl_ct: number of h/w sibling threads for the test cpu
+ * @siblings_in: sibling count for joining rendezvous
+ * @siblings_out: sibling count for exiting rendezvous
+ * @scan_details: opaque scan status code from h/w
+ * @test_thread_done: set when scan are done for all siblings threads
+ */
+struct ifs_test {
+	int status;
+	int cpu_sibl_ct;
+	atomic_t siblings_in;
+	atomic_t siblings_out;
+	u64 scan_details;
+	struct completion test_thread_done;
+};
+
 int load_ifs_binary(void);
+int do_core_test(int cpu);
 extern struct platform_device *ifs_pdev;
 extern struct ifs_binary ifs_binary;
+extern struct ifs_test ifs_test;
+extern struct workqueue_struct *ifs_wq;
+extern bool ifs_disabled;
 #endif
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
new file mode 100644
index 000000000000..f9c98d84183f
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/nmi.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "ifs.h"
+
+bool ifs_disabled;
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
+static bool noirq = 1;
+module_param(noirq, bool, 0644);
+MODULE_PARM_DESC(noirq, "Option to enable/disable interrupt during test");
+
+static int ifs_retry_set(const char *val, const struct kernel_param *kp)
+{
+	int var = 0;
+
+	if (kstrtoint(val, 0, &var)) {
+		dev_warn(&ifs_pdev->dev, "unable to parse retry\n");
+		return -EINVAL;
+	}
+
+	/* validate retry value for sanity */
+	if (var < 1 || var > 20) {
+		dev_warn(&ifs_pdev->dev, "retry parameter should be between 1 and 20\n");
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
+	[IFS_NO_ERROR] = "SCAN no error",
+	[IFS_OTHER_THREAD_COULD_NOT_JOIN] = "Other thread could not join.",
+	[IFS_INTERRUPTED_BEFORE_RENDEZVOUS] = "Interrupt occurred prior to SCAN coordination.",
+	[IFS_POWER_MGMT_INADEQUATE_FOR_SCAN] =
+	"Core Abort SCAN Response due to power management condition.",
+	[IFS_INVALID_CHUNK_RANGE] = "Non valid chunks in the range",
+	[IFS_MISMATCH_ARGUMENTS_BETWEEN_THREADS] = "Mismatch in arguments between threads T0/T1.",
+	[IFS_CORE_NOT_CAPABLE_CURRENTLY] = "Core not capable of performing SCAN currently",
+	[IFS_UNASSIGNED_ERROR_CODE] = "Unassigned error code 0x7",
+	[IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT] =
+	"Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
+	[IFS_INTERRUPTED_DURING_EXECUTION] = "Interrupt occurred prior to SCAN start",
+};
+
+static void message_not_tested(int cpu, union ifs_status status)
+{
+	if (status.error_code < ARRAY_SIZE(scan_test_status))
+		dev_info(&ifs_pdev->dev, "CPU(s) %*pbl: SCAN operation did not start. %s\n",
+			 cpumask_pr_args(topology_sibling_cpumask(cpu)),
+			 scan_test_status[status.error_code]);
+	else if (status.error_code == IFS_SW_TIMEOUT)
+		dev_info(&ifs_pdev->dev, "CPU(s) %*pbl: software timeout during scan\n",
+			 cpumask_pr_args(topology_sibling_cpumask(cpu)));
+	else if (status.error_code == IFS_SW_PARTIAL_COMPLETION)
+		dev_info(&ifs_pdev->dev, "CPU(s) %*pbl: %s\n",
+			 cpumask_pr_args(topology_sibling_cpumask(cpu)),
+			 "Not all scan chunks were executed. Maximum forward progress retries exceeded");
+	else
+		dev_info(&ifs_pdev->dev, "CPU(s) %*pbl: SCAN unknown status %llx\n",
+			 cpumask_pr_args(topology_sibling_cpumask(cpu)), status.data);
+}
+
+static void message_fail(int cpu, union ifs_status status)
+{
+	if (status.control_error) {
+		dev_err(&ifs_pdev->dev, "CPU(s) %*pbl: scan failed. %s\n",
+			cpumask_pr_args(topology_sibling_cpumask(cpu)),
+			"Suggest reload scan file: # echo 1 > /sys/devices/platform/intel_ifs/reload");
+	}
+	if (status.signature_error) {
+		dev_err(&ifs_pdev->dev, "CPU(s) %*pbl: test signature incorrect. %s\n",
+			cpumask_pr_args(topology_sibling_cpumask(cpu)),
+			"Retry once to check if problem is transient");
+	}
+}
+
+static bool can_restart(union ifs_status status)
+{
+	enum ifs_status_err_code err_code = status.error_code;
+
+	/* Signature for chunk is bad, or scan test failed */
+	if (status.signature_error || status.control_error)
+		return false;
+
+	switch (err_code) {
+	case IFS_NO_ERROR:
+	case IFS_OTHER_THREAD_COULD_NOT_JOIN:
+	case IFS_INTERRUPTED_BEFORE_RENDEZVOUS:
+	case IFS_POWER_MGMT_INADEQUATE_FOR_SCAN:
+	case IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT:
+	case IFS_INTERRUPTED_DURING_EXECUTION:
+		return true;
+	case IFS_INVALID_CHUNK_RANGE:
+	case IFS_MISMATCH_ARGUMENTS_BETWEEN_THREADS:
+	case IFS_CORE_NOT_CAPABLE_CURRENTLY:
+	case IFS_UNASSIGNED_ERROR_CODE:
+		break;
+	}
+	return false;
+}
+
+static bool wait_for_siblings(atomic_t *t, long long timeout)
+{
+	atomic_inc(t);
+	while (atomic_read(t) < ifs_test.cpu_sibl_ct) {
+		if (timeout < SPINUNIT) {
+			dev_err(&ifs_pdev->dev,
+				"Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				ifs_test.cpu_sibl_ct - atomic_read(t));
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
+ * When a Scan test (for a particular core) is triggered by the user, worker threads
+ * for each sibling cpus(belonging to that core) are queued to execute this function in
+ * the Workqueue (ifs_wq) context.
+ * Wait for the sibling thread to join before the execution.
+ * Execute the scan test by running wrmsr(MSR_ACTIVATE_SCAN).
+ */
+static void ifs_work_func(struct work_struct *work)
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
+	/*
+	 * Need to get (and keep) the threads on this core executing close together
+	 * so that the writes to MSR_ACTIVATE_SCAN below will succeed in entering
+	 * IFS test mode on this core. Interrupts on each thread are expected to be
+	 * brief. But preemption would be a problem.
+	 */
+	preempt_disable();
+
+	/* wait for the sibling threads to join */
+	first = cpumask_first(topology_sibling_cpumask(cpu));
+	if (!wait_for_siblings(&ifs_test.siblings_in, NSEC_PER_SEC)) {
+		preempt_enable();
+		dev_err(&ifs_pdev->dev, "cpu %d sibling did not join rendezvous\n", cpu);
+		goto out;
+	}
+
+	activate.start = 0;
+	activate.stop = ifs_binary.valid_chunks - 1;
+	timeout = jiffies + HZ / 2;
+	retries = retry;
+
+	while (activate.start <= activate.stop) {
+		if (time_after(jiffies, timeout)) {
+			status.error_code = IFS_SW_TIMEOUT;
+			break;
+		}
+
+		if (noirq)
+			local_irq_disable();
+		/* scan start */
+		wrmsrl(MSR_ACTIVATE_SCAN, activate.data);
+
+		if (noirq)
+			local_irq_enable();
+
+		/*
+		 * All logical CPUs on this core are now running IFS test. When it completes
+		 * execution or is interrupted, the following RDMSR gets the scan status.
+		 */
+
+		rdmsrl(MSR_SCAN_STATUS, status.data);
+
+		/* Some cases can be retried, give up for others */
+		if (!can_restart(status))
+			break;
+
+		if (status.chunk_num == activate.start) {
+			/* Check for forward progress */
+			if (retries-- == 0) {
+				if (status.error_code == IFS_NO_ERROR)
+					status.error_code = IFS_SW_PARTIAL_COMPLETION;
+				break;
+			}
+		} else {
+			retries = retry;
+			activate.start = status.chunk_num;
+		}
+	}
+
+	preempt_enable();
+
+	if (cpu == first) {
+		/* Update status for this core */
+		ifs_test.scan_details = status.data;
+
+		if (status.control_error || status.signature_error) {
+			ifs_test.status = SCAN_TEST_FAIL;
+			message_fail(cpu, status);
+		} else if (status.error_code) {
+			ifs_test.status = SCAN_NOT_TESTED;
+			message_not_tested(cpu, status);
+		} else {
+			ifs_test.status = SCAN_TEST_PASS;
+		}
+	}
+
+	if (!wait_for_siblings(&ifs_test.siblings_out, NSEC_PER_SEC))
+		dev_err(&ifs_pdev->dev, "cpu %d sibling did not exit rendezvous\n", cpu);
+
+out:
+	if (cpu == first)
+		complete(&ifs_test.test_thread_done);
+}
+
+/*
+ * Initiate per core test. It wakes up work queue threads on the target cpu and
+ * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
+ * wait for all sibling threads to finish the scan test.
+ */
+int do_core_test(int cpu)
+{
+	struct work_struct *local_work;
+	int sibling;
+	int ret = 0;
+	int i = 0;
+
+	cpu_hotplug_disable();
+	if (!cpu_online(cpu)) {
+		dev_info(&ifs_pdev->dev, "cannot test on the offline cpu %d\n", cpu);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	reinit_completion(&ifs_test.test_thread_done);
+	atomic_set(&ifs_test.siblings_in, 0);
+	atomic_set(&ifs_test.siblings_out, 0);
+
+	ifs_test.cpu_sibl_ct = cpumask_weight(topology_sibling_cpumask(cpu));
+	local_work = kcalloc(ifs_test.cpu_sibl_ct, sizeof(struct work_struct), GFP_NOWAIT);
+	if (!local_work) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
+		INIT_WORK(&local_work[i], ifs_work_func);
+		queue_work_on(sibling, ifs_wq, &local_work[i]);
+		i++;
+	}
+
+	if (wait_for_completion_timeout(&ifs_test.test_thread_done, HZ) == 0) {
+		dev_err(&ifs_pdev->dev,
+			"cpu %d Core locked up during IFS test? IFS disabled\n", cpu);
+		ifs_disabled = true;
+	}
+
+	kfree(local_work);
+out:
+	cpu_hotplug_enable();
+	return ret;
+}
-- 
2.17.1

