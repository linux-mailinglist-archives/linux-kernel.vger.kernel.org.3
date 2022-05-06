Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F160D51CEA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388068AbiEFBpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388007AbiEFBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:44:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19F05DBE3;
        Thu,  5 May 2022 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651801248; x=1683337248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rFZQsaMXCTRSCtL0m0F8A/W8Xb84ILIPHcNuXgu06k=;
  b=lETcQod1y/VVpuZ33SDC1z1Sn4r6dmsz69OsQVajB4Pc4npPFKDCnJHv
   23jgDwKmq7iHyAIeoIzYalIiD1Vn3IYI4yocXXuno+05Yl22IC7yzQqWG
   mBErf/cYx3zMDY4TRq38dPyGl+cV6YtyRCDrURhNaKXytQjQo2IN1f/F0
   pKZNwkkJ/U0FnscdkJxdHF83hV7oymqVn6uoNFxThtSVziBq8APO0Qjlv
   YQ/fYoNY55SnJYV/46JwNovzYZkQYUQTILUZ0UZcn8cQTaOJyqyiAw9ln
   IsLopcdYE8zWesNUMYXaxG8swp1+DBiQQf2iSAOuK7JraFlR+jJHIgsvi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293519437"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293519437"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537645049"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:40:46 -0700
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
Subject: [PATCH v6 08/11] platform/x86/intel/ifs: Add scan test support
Date:   Thu,  5 May 2022 18:40:32 -0700
Message-Id: <20220506014035.1173578-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506014035.1173578-1-tony.luck@intel.com>
References: <20220428153849.295779-1-tony.luck@intel.com>
 <20220506014035.1173578-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

In a core, the scan engine is shared between sibling cpus.

When a Scan test (for a particular core) is triggered by the user,
the scan chunks are executed on all the threads on the core using
stop_core_cpuslocked.

Scan may be aborted by some reasons. Scan test will be aborted in certain
circumstances such as when interrupt occurred or cpu does not have enough
power budget for scan. In this case, the kernel restart scan from the chunk
where it stopped. Scan will also be aborted when the test is failed. In
this case, the test is immediately stopped without retry.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/ifs/Makefile  |   2 +-
 drivers/platform/x86/intel/ifs/ifs.h     |  44 ++++
 drivers/platform/x86/intel/ifs/runtest.c | 250 +++++++++++++++++++++++
 3 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/ifs/runtest.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index 98b6fde15689..cedcb103f860 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
 
-intel_ifs-objs			:= core.o load.o
+intel_ifs-objs			:= core.o load.o runtest.o
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 1a606c999b12..7435a5582df3 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -11,6 +11,11 @@
 #define MSR_SCAN_HASHES_STATUS			0x000002c3
 #define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
 #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
+#define MSR_ACTIVATE_SCAN			0x000002c6
+#define MSR_SCAN_STATUS				0x000002c7
+#define SCAN_NOT_TESTED				0
+#define SCAN_TEST_PASS				1
+#define SCAN_TEST_FAIL				2
 
 /* MSR_SCAN_HASHES_STATUS bit fields */
 union ifs_scan_hashes_status {
@@ -38,6 +43,40 @@ union ifs_chunks_auth_status {
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
  * @integrity_cap_bit - MSR_INTEGRITY_CAPS bit enumerating this test
@@ -45,6 +84,8 @@ union ifs_chunks_auth_status {
  * @loaded: If a valid test binary has been loaded into the memory
  * @loading_error: Error occurred on another CPU while loading image
  * @valid_chunks: number of chunks which could be validated.
+ * @status: it holds simple status pass/fail/untested
+ * @scan_details: opaque scan status code from h/w
  */
 struct ifs_data {
 	int	integrity_cap_bit;
@@ -52,6 +93,8 @@ struct ifs_data {
 	bool	loaded;
 	bool	loading_error;
 	int	valid_chunks;
+	int	status;
+	u64	scan_details;
 };
 
 struct ifs_work {
@@ -73,5 +116,6 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 }
 
 void ifs_load_firmware(struct device *dev);
+int do_core_test(int cpu, struct device *dev);
 
 #endif
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
new file mode 100644
index 000000000000..fd3f5f3f31e5
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/nmi.h>
+#include <linux/slab.h>
+#include <linux/stop_machine.h>
+
+#include "ifs.h"
+
+/*
+ * Note all code and data in this file is protected by
+ * ifs_sem. On HT systems all threads on a core will
+ * execute together, but only the first thread on the
+ * core will update results of the test.
+ */
+struct workqueue_struct *ifs_wq;
+static bool scan_enabled = true;
+
+/* Max retries on the same chunk */
+#define MAX_IFS_RETRIES  5
+
+/*
+ * Number of TSC cycles that a logical CPU will wait for the other
+ * logical CPU on the core in the WRMSR(ACTIVATE_SCAN).
+ */
+#define IFS_THREAD_WAIT 100000
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
+/*
+ * Execute the scan. Called "simultaneously" on all threads of a core
+ * at high priority using the stop_cpus mechanism.
+ */
+static int doscan(void *data)
+{
+	int cpu = smp_processor_id();
+	u64 *msrs = data;
+	int first;
+
+	/* Only the first logical CPU on a core reports result */
+	first = cpumask_first(topology_sibling_cpumask(cpu));
+
+	/*
+	 * This WRMSR will wait for other HT threads to also write
+	 * to this MSR (at most for activate.delay cycles). Then it
+	 * starts scan of each requested chunk. The core scan happens
+	 * during the "execution" of the WRMSR. This instruction can
+	 * take up to 200 milliseconds before it retires.
+	 */
+	wrmsrl(MSR_ACTIVATE_SCAN, msrs[0]);
+
+	if (cpu == first) {
+		/* Pass back the result of the scan */
+		rdmsrl(MSR_SCAN_STATUS, msrs[1]);
+	}
+
+	return 0;
+}
+
+/*
+ * Use stop_core_cpuslocked() to synchronize writing to MSR_ACTIVATE_SCAN
+ * on all threads of the core to be tested. Loop if necessary to complete
+ * run of all chunks. Include some defensive tests to make sure forward
+ * progress is made, and that the whole test completes in a reasonable time.
+ */
+static void ifs_test_core(int cpu, struct device *dev)
+{
+	union ifs_scan activate;
+	union ifs_status status;
+	unsigned long timeout;
+	struct ifs_data *ifsd;
+	u64 msrvals[2];
+	int retries;
+
+	ifsd = ifs_get_data(dev);
+
+	activate.rsvd = 0;
+	activate.delay = IFS_THREAD_WAIT;
+	activate.sigmce = 0;
+	activate.start = 0;
+	activate.stop = ifsd->valid_chunks - 1;
+
+	timeout = jiffies + HZ / 2;
+	retries = MAX_IFS_RETRIES;
+
+	while (activate.start <= activate.stop) {
+		if (time_after(jiffies, timeout)) {
+			status.error_code = IFS_SW_TIMEOUT;
+			break;
+		}
+
+		msrvals[0] = activate.data;
+		stop_core_cpuslocked(cpu, doscan, msrvals);
+
+		status.data = msrvals[1];
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
+	/* Update status for this core */
+	ifsd->scan_details = status.data;
+
+	if (status.control_error || status.signature_error) {
+		ifsd->status = SCAN_TEST_FAIL;
+		message_fail(dev, cpu, status);
+	} else if (status.error_code) {
+		ifsd->status = SCAN_NOT_TESTED;
+		message_not_tested(dev, cpu, status);
+	} else {
+		ifsd->status = SCAN_TEST_PASS;
+	}
+}
+
+/*
+ * Initiate per core test. It wakes up work queue threads on the target cpu and
+ * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
+ * wait for all sibling threads to finish the scan test.
+ */
+int do_core_test(int cpu, struct device *dev)
+{
+	int ret = 0;
+
+	if (!scan_enabled)
+		return -ENXIO;
+
+	/* Prevent CPUs from being taken offline during the scan test */
+	cpus_read_lock();
+
+	if (!cpu_online(cpu)) {
+		dev_info(dev, "cannot test on the offline cpu %d\n", cpu);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ifs_test_core(cpu, dev);
+out:
+	cpus_read_unlock();
+	return ret;
+}
-- 
2.35.1

