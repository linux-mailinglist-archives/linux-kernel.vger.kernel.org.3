Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8DB50741E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354922AbiDSQmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354758AbiDSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E2716592;
        Tue, 19 Apr 2022 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386350; x=1681922350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pdwy5ZSj8acjwCelqnKdX23wcn3c0pNPoZbSRNf3BiY=;
  b=LDhaejnInOgO+msRHW1UuIhrvudbPf1f7P638xNfADWFHUCPj8j3sx+Q
   Vg3pVLmf26Mbcfkhoal8ia/rIy+pcXIwKKdae2txfX9CArF2JDnAYaHJ9
   BeZxptUQGxst4ZHk1sy5be3kZHAIDbOBPkF1fFTjob/lgukpIsnhw8TYg
   m9PQBlWDbjdksRK98HArWe6qQyjlo8jgh95GIhcvpOln6/PoNrAgT+zma
   cpZ+gDKw2pkyP81CRRqkOSbSVAWsF8/WOPaDeiJRzvjW36FKYk2kA8FzI
   2ldD84XQPxxVWPfNJubrg62xe2iNBjC22zojz1uwRaS8FSUe5TXJLNsC2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702547"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702547"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802161"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:08 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v3 08/11] platform/x86/intel/ifs: Add scan test support
Date:   Tue, 19 Apr 2022 09:38:56 -0700
Message-Id: <20220419163859.2228874-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419163859.2228874-1-tony.luck@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

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

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/Makefile  |   2 +-
 drivers/platform/x86/intel/ifs/core.c    |  15 +-
 drivers/platform/x86/intel/ifs/ifs.h     |  48 ++++
 drivers/platform/x86/intel/ifs/runtest.c | 321 +++++++++++++++++++++++
 4 files changed, 384 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/x86/intel/ifs/runtest.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index eab0cc81f38e..7de27361b479 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -2,4 +2,4 @@ obj-$(CONFIG_INTEL_IFS_DEVICE)	+= intel_ifs_device.o
 
 obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
 
-intel_ifs-objs			:= core.o load.o
+intel_ifs-objs			:= core.o load.o runtest.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 139449f11a64..0dc4cdda35ff 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -35,11 +35,24 @@ static struct platform_driver intel_ifs_driver = {
 
 static int __init ifs_init(void)
 {
-	return platform_driver_register(&intel_ifs_driver);
+	int ret;
+
+	ret = platform_driver_register(&intel_ifs_driver);
+	if (ret)
+		return ret;
+
+	ret = ifs_setup_wq();
+	if (ret) {
+		platform_driver_unregister(&intel_ifs_driver);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void __exit ifs_exit(void)
 {
+	ifs_destroy_wq();
 	platform_driver_unregister(&intel_ifs_driver);
 }
 
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index c51e285fc7ba..f5e3636d709f 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -8,6 +8,13 @@
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
@@ -35,18 +42,59 @@ union ifs_chunks_auth_status {
 	};
 };
 
+/* MSR_ACTIVATE_SCAN bit fields */
+union ifs_scan {
+	u64	data;
+	struct {
+		u32	start	:8;
+		u32	stop	:8;
+		u32	rsvd	:16;
+		u32	delay	:31;
+		u32	sigmce	:1;
+	};
+};
+
+/* MSR_SCAN_STATUS bit fields */
+union ifs_status {
+	u64	data;
+	struct {
+		u32	chunk_num		:8;
+		u32	chunk_stop_index	:8;
+		u32	rsvd1			:16;
+		u32	error_code		:8;
+		u32	rsvd2			:22;
+		u32	control_error		:1;
+		u32	signature_error		:1;
+	};
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
  * struct ifs_data - attributes related to intel IFS driver
  * @loaded_version: stores the currently loaded ifs image version.
  * @loaded: If a valid test binary has been loaded into the memory
  * @valid_chunks: number of chunks which could be validated.
+ * @status: it holds simple status pass/fail/untested
+ * @scan_details: opaque scan status code from h/w
  */
 struct ifs_data {
 	int loaded_version;
 	bool loaded;
 	int valid_chunks;
+	int status;
+	u64 scan_details;
 };
 
 int load_ifs_binary(struct device *dev);
+int ifs_setup_wq(void);
+void ifs_destroy_wq(void);
+int do_core_test(int cpu, struct device *dev);
 
 #endif
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
new file mode 100644
index 000000000000..7793a01f7b94
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -0,0 +1,321 @@
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
+static struct workqueue_struct *ifs_wq;
+static struct completion test_thread_done;
+static atomic_t siblings_in;
+static atomic_t siblings_out;
+static int cpu_sibl_ct;
+static bool scan_enabled = true;
+
+struct ifs_work {
+	struct work_struct w;
+	struct device *dev;
+};
+
+/* Max retries on the same chunk */
+#define MAX_IFS_RETRIES  5
+
+static unsigned long msec_to_tsc(unsigned long msec)
+{
+	return tsc_khz * 1000 * msec / MSEC_PER_SEC;
+}
+
+enum ifs_status_err_code {
+	IFS_NO_ERROR				= 0,
+	IFS_OTHER_THREAD_COULD_NOT_JOIN		= 1,
+	IFS_INTERRUPTED_BEFORE_RENDEZVOUS	= 2,
+	IFS_POWER_MGMT_INADEQUATE_FOR_SCAN	= 3,
+	IFS_INVALID_CHUNK_RANGE			= 4,
+	IFS_MISMATCH_ARGUMENTS_BETWEEN_THREADS	= 5,
+	IFS_CORE_NOT_CAPABLE_CURRENTLY		= 6,
+	IFS_UNASSIGNED_ERROR_CODE		= 7,
+	IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT	= 8,
+	IFS_INTERRUPTED_DURING_EXECUTION	= 9,
+};
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
+static void message_not_tested(struct device *dev, int cpu, union ifs_status status)
+{
+	if (status.error_code < ARRAY_SIZE(scan_test_status))
+		dev_info(dev, "CPU(s) %*pbl: SCAN operation did not start. %s\n",
+			 cpumask_pr_args(topology_sibling_cpumask(cpu)),
+			 scan_test_status[status.error_code]);
+	else if (status.error_code == IFS_SW_TIMEOUT)
+		dev_info(dev, "CPU(s) %*pbl: software timeout during scan\n",
+			 cpumask_pr_args(topology_sibling_cpumask(cpu)));
+	else if (status.error_code == IFS_SW_PARTIAL_COMPLETION)
+		dev_info(dev, "CPU(s) %*pbl: %s\n",
+			 cpumask_pr_args(topology_sibling_cpumask(cpu)),
+			 "Not all scan chunks were executed. Maximum forward progress retries exceeded");
+	else
+		dev_info(dev, "CPU(s) %*pbl: SCAN unknown status %llx\n",
+			 cpumask_pr_args(topology_sibling_cpumask(cpu)), status.data);
+}
+
+static void message_fail(struct device *dev, int cpu, union ifs_status status)
+{
+	/*
+	 * control_error is set when the microcode runs into a problem
+	 * loading the image from the reserved BIOS memory, or it has
+	 * been corrupted. Reloading the image may fix this issue.
+	 */
+	if (status.control_error) {
+		dev_err(dev, "CPU(s) %*pbl: could not execute from loaded scan image\n",
+			cpumask_pr_args(topology_sibling_cpumask(cpu)));
+	}
+
+	/*
+	 * signature_error is set when the output from the scan chains does not
+	 * match the expected signature. This might be a transient problem (e.g.
+	 * due to a bit flip from an alpha particle or neutron). If the problem
+	 * repeats on a subsequent test, then it indicates an actual problem in
+	 * the core being tested.
+	 */
+	if (status.signature_error) {
+		dev_err(dev, "CPU(s) %*pbl: test signature incorrect.\n",
+			cpumask_pr_args(topology_sibling_cpumask(cpu)));
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
+static bool wait_for_siblings(struct device *dev, struct ifs_data *ifsd, atomic_t *t, long long timeout)
+{
+	atomic_inc(t);
+	while (atomic_read(t) < cpu_sibl_ct) {
+		if (timeout < SPINUNIT) {
+			dev_err(dev,
+				"Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				cpu_sibl_ct - atomic_read(t));
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
+	struct ifs_work *local_work = container_of(work, struct ifs_work, w);
+	int cpu = smp_processor_id();
+	union ifs_scan activate;
+	union ifs_status status;
+	unsigned long timeout;
+	struct ifs_data *ifsd;
+	struct device *dev;
+	int retries;
+	u32 first;
+
+	dev = local_work->dev;
+	ifsd = dev_get_drvdata(dev);
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
+	if (!wait_for_siblings(dev, ifsd, &siblings_in, NSEC_PER_SEC)) {
+		preempt_enable();
+		dev_err(dev, "cpu %d sibling did not join rendezvous\n", cpu);
+		goto out;
+	}
+
+	activate.start = 0;
+	activate.stop = ifsd->valid_chunks - 1;
+	timeout = jiffies + HZ / 2;
+	retries = MAX_IFS_RETRIES;
+
+	while (activate.start <= activate.stop) {
+		if (time_after(jiffies, timeout)) {
+			status.error_code = IFS_SW_TIMEOUT;
+			break;
+		}
+
+		local_irq_disable();
+		wrmsrl(MSR_ACTIVATE_SCAN, activate.data);
+		local_irq_enable();
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
+			retries = MAX_IFS_RETRIES;
+			activate.start = status.chunk_num;
+		}
+	}
+
+	preempt_enable();
+
+	if (cpu == first) {
+		/* Update status for this core */
+		ifsd->scan_details = status.data;
+
+		if (status.control_error || status.signature_error) {
+			ifsd->status = SCAN_TEST_FAIL;
+			message_fail(dev, cpu, status);
+		} else if (status.error_code) {
+			ifsd->status = SCAN_NOT_TESTED;
+			message_not_tested(dev, cpu, status);
+		} else {
+			ifsd->status = SCAN_TEST_PASS;
+		}
+	}
+
+	if (!wait_for_siblings(dev, ifsd, &siblings_out, NSEC_PER_SEC))
+		dev_err(dev, "cpu %d sibling did not exit rendezvous\n", cpu);
+
+out:
+	if (cpu == first)
+		complete(&test_thread_done);
+}
+
+/*
+ * Initiate per core test. It wakes up work queue threads on the target cpu and
+ * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
+ * wait for all sibling threads to finish the scan test.
+ */
+int do_core_test(int cpu, struct device *dev)
+{
+	struct ifs_work *local_work;
+	int sibling;
+	int ret = 0;
+	int i = 0;
+
+	if (!scan_enabled)
+		return -ENXIO;
+
+	cpu_hotplug_disable();
+	if (!cpu_online(cpu)) {
+		dev_info(dev, "cannot test on the offline cpu %d\n", cpu);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	reinit_completion(&test_thread_done);
+	atomic_set(&siblings_in, 0);
+	atomic_set(&siblings_out, 0);
+
+	cpu_sibl_ct = cpumask_weight(topology_sibling_cpumask(cpu));
+	local_work = kcalloc(cpu_sibl_ct, sizeof(*local_work), GFP_NOWAIT);
+	if (!local_work) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
+		local_work[i].dev = dev;
+		INIT_WORK(&local_work[i].w, ifs_work_func);
+		queue_work_on(sibling, ifs_wq, &local_work[i].w);
+		i++;
+	}
+
+	if (wait_for_completion_timeout(&test_thread_done, HZ) == 0) {
+		dev_err(dev, "cpu %d Core locked up during IFS test? IFS disabled\n", cpu);
+		scan_enabled = false;
+	}
+
+	kfree(local_work);
+out:
+	cpu_hotplug_enable();
+	return ret;
+}
+
+int ifs_setup_wq(void)
+{
+	/* Flags are to keep all the sibling cpu worker threads (of a core) in close sync */
+	ifs_wq = alloc_workqueue("intel_ifs", (WQ_HIGHPRI | WQ_CPU_INTENSIVE), 1);
+	if (!ifs_wq)
+		return -ENOMEM;
+
+	init_completion(&test_thread_done);
+
+	return 0;
+}
+
+void ifs_destroy_wq(void)
+{
+	destroy_workqueue(ifs_wq);
+}
-- 
2.35.1

