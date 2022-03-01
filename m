Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C9E4C953A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiCAT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbiCAT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078C5D188;
        Tue,  1 Mar 2022 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164556; x=1677700556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=l9+0JdtN9wgdVgpsIysnTaRpfpOxummB1ggACJktejk=;
  b=Zj/t1xPCbTrti82C4gbk7omPYyddapjbIIVRgBpFBaWqJiEJQgivrfCH
   2bWQecL55uYwA1BcVCqD4bacA9eEqbNpe1w5wsZBRLTD5bQKiG2KMOBO7
   TYEHf25SdWw5gn4Q0fiZzzNi9mdjs88lVlCZj8Terkg+QeHpEV9Dhz4Wx
   Y7BD1EP3sS5yziFZRToKDZ18OPkiTMA6D3gw4EFuJR8zix6v1pHEgeWhz
   PatpaNssxH/iePTXRzklvwoFs0b7N8+XYOmSL2eqVFc0XBcu7lx/CNeho
   vLZRklKOII3ViSQWjgzZaRtJekt4Lm5VmWIlqM3lnlBhXf2XQfYoXL3kz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194900"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194900"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133176"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:54 -0800
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
Subject: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
Date:   Tue,  1 Mar 2022 11:54:55 -0800
Message-Id: <20220301195457.21152-9-jithu.joseph@intel.com>
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

Implement sysfs interface to trigger ifs test for a targeted core or
all cores. For all core testing, the kernel will start testing from core 0
and proceed to the next core one after another. After the ifs test on the
last core, the test stops until the administrator starts another round of
tests. A "targeted core" test runs a single ifs on a single core. The
kernel will only test the target core.

The basic usage is as below.

1. For all cores testing:
   echo 1 > /sys/devices/system/cpu/ifs/run_test
   cat /sys/devices/system/cpu/ifs/status

2. For "targeted core" testing:
   To start test, for example, cpu0:
   echo 1 > /sys/devices/system/cpu/cpu#/ifs/run_test
   cat /sys/devices/system/cpu/cpu#/ifs/status

3. For reloading IFS image: (e.g, when new IFS image is released)
   - copy the new image to /lib/firmware/intel/ifs/
   - rename it as {family/model/stepping}.{testname}
   - echo 1 > /sys/devices/system/cpu/ifs/reload

This module accepts two tunable parameters. Defaults could be overridden
by passing appropriate values during load time. The parameters are as
described below.

1. noint: When set, system interrupts are not allowed to interrupt a scan.
2. retry: Maximum retry counter when the test is not executed due to an
          event such as interrupt.

Originally-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/Makefile |   2 +-
 drivers/platform/x86/intel/ifs/core.c   |   8 +
 drivers/platform/x86/intel/ifs/ifs.h    |   4 +
 drivers/platform/x86/intel/ifs/sysfs.c  | 394 ++++++++++++++++++++++++
 4 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index 105b377de410..a2e05bf78c3e 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_INTEL_IFS)			+= intel_ifs.o
 
-intel_ifs-objs				:= core.o load.o
+intel_ifs-objs				:= core.o load.o sysfs.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 6747b523587a..c9ca385082e9 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -283,11 +283,16 @@ static void ifs_first_time(unsigned int cpu)
 
 static int ifs_online_cpu(unsigned int cpu)
 {
+	int ret;
+
 	/* If the CPU is coming online for the first time*/
 	if (per_cpu(ifs_state, cpu).first_time == 0)
 		ifs_first_time(cpu);
 
 	cpumask_clear_cpu(cpu, &(per_cpu(ifs_state, cpu).mask));
+	ret = ifs_sysfs_create(cpu);
+	if (ret)
+		return ret;
 
 	per_cpu(ifs_state, cpu).scan_task = kthread_create_on_node(scan_test_worker, (void *)&cpu,
 								   cpu_to_node(cpu), "ifsCpu/%u",
@@ -311,6 +316,7 @@ static int ifs_offline_cpu(unsigned int cpu)
 
 	if (thread)
 		kthread_stop(thread);
+	ifs_sysfs_remove(cpu);
 
 	return 0;
 }
@@ -336,6 +342,7 @@ static int __init ifs_init(void)
 		return ret;
 	}
 
+	cpu_ifs_init();
 	init_completion(&test_thread_done);
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/ifs:online",
 				ifs_online_cpu, ifs_offline_cpu);
@@ -361,6 +368,7 @@ static void __exit ifs_exit(void)
 		if (thread)
 			kthread_stop(thread);
 	}
+	cpu_ifs_exit();
 	cpus_read_unlock();
 	cpuhp_remove_state(cpuhp_scan_state);
 
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index fcbbb49faa19..4442ccd626c6 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -143,6 +143,10 @@ struct ifs_state {
 DECLARE_PER_CPU(struct ifs_state, ifs_state);
 
 int load_ifs_binary(void);
+void cpu_ifs_init(void);
+void cpu_ifs_exit(void);
+int ifs_sysfs_create(unsigned int cpu);
+void ifs_sysfs_remove(unsigned int cpu);
 extern struct ifs_params ifs_params;
 extern atomic_t siblings_in;
 extern atomic_t siblings_out;
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
new file mode 100644
index 000000000000..f441968de642
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation.
+ *
+ * Author: Jithu Joseph <jithu.joseph@intel.com>
+ */
+
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/semaphore.h>
+
+#include "ifs.h"
+
+static DEFINE_SEMAPHORE(ifs_sem);
+static int core_delay = 1;
+static bool ifs_disabled;
+
+/*
+ * Initiate per core test. It wakes up all sibling threads that belongs to the
+ * target cpu. Once all sibling threads wake up, the scan test gets executed and
+ * wait for all sibling threads to finish the scan test.
+ */
+static void do_core_test(int cpu)
+{
+	int sibling;
+
+	reinit_completion(&test_thread_done);
+	atomic_set(&siblings_in, 0);
+	atomic_set(&siblings_out, 0);
+
+	cpu_sibl_ct = cpumask_weight(topology_sibling_cpumask(cpu));
+
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+		cpumask_set_cpu(sibling, &per_cpu(ifs_state, sibling).mask);
+
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+		wake_up_interruptible(&per_cpu(ifs_state, sibling).scan_wq);
+
+	if (wait_for_completion_timeout(&test_thread_done, HZ) == 0) {
+		pr_err("Core locked up during IFS test? IFS disabled\n");
+		ifs_disabled = true;
+	}
+}
+
+/*
+ * The sysfs interface to check the test status:
+ * To check the result, for example, cpu0
+ * cat /sys/devices/system/cpu/cpu0/ifs/details
+ */
+static ssize_t details_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	unsigned int cpu = dev->id;
+	int ret;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	ret = sprintf(buf, "%llx\n", per_cpu(ifs_state, cpu).scan_details);
+	up(&ifs_sem);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(details);
+
+/*
+ * The sysfs interface to check the test status:
+ * To check the status, for example, cpu0
+ * cat /sys/devices/system/cpu/cpu0/ifs/status
+ */
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	unsigned int cpu = dev->id;
+	u32 scan_result;
+	int ret;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	scan_result = per_cpu(ifs_state, cpu).status;
+
+	if (scan_result == SCAN_TEST_FAIL)
+		ret = sprintf(buf, "fail\n");
+	else if (scan_result == SCAN_NOT_TESTED)
+		ret = sprintf(buf, "untested\n");
+	else
+		ret = sprintf(buf, "pass\n");
+
+	up(&ifs_sem);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(status);
+
+/*
+ * The sysfs interface for single core testing
+ * To start test, for example, cpu0
+ * echo 1 > /sys/devices/system/cpu/cpu0/ifs/run_test
+ * To check the result:
+ * cat /sys/devices/system/cpu/cpu0/ifs/result
+ * The sibling core gets tested at the same time.
+ */
+static ssize_t run_test_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	unsigned int cpu = dev->id;
+	bool var;
+	int rc;
+
+	if (ifs_disabled)
+		return -ENXIO;
+
+	rc = kstrtobool(buf, &var);
+	if (rc < 0 || var != 1)
+		return -EINVAL;
+
+	if (down_trylock(&ifs_sem)) {
+		pr_info("another instance in progress.\n");
+		return -EBUSY;
+	}
+	cpu_hotplug_disable();
+	do_core_test(cpu);
+	cpu_hotplug_enable();
+	up(&ifs_sem);
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(run_test);
+
+/* per-cpu scan sysfs attributes */
+static struct attribute *ifs_attrs[] = {
+	&dev_attr_run_test.attr,
+	&dev_attr_status.attr,
+	&dev_attr_details.attr,
+	NULL
+};
+
+const struct attribute_group ifs_attr_group = {
+	.attrs	= ifs_attrs,
+	.name = "ifs",
+};
+
+/* Creates the sysfs files under /sys/devices/system/cpu/cpuX/ifs */
+int ifs_sysfs_create(unsigned int cpu)
+{
+	struct device *dev;
+	int ret;
+
+	dev = get_cpu_device(cpu);
+	ret = sysfs_create_group(&dev->kobj, &ifs_attr_group);
+	if (ret) {
+		pr_err("failed to create sysfs group\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Removes the sysfs files under /sys/devices/system/cpu/cpuX/ifs */
+void ifs_sysfs_remove(unsigned int cpu)
+{
+	struct device *dev;
+
+	dev = get_cpu_device(cpu);
+	sysfs_remove_group(&dev->kobj, &ifs_attr_group);
+}
+
+/*
+ * Reload the IFS image. When user wants to install new IFS image
+ * image, reloading must be done.
+ */
+static ssize_t reload_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	bool var;
+	int rc;
+
+	if (ifs_disabled)
+		return -ENXIO;
+
+	rc = kstrtobool(buf, &var);
+	if (rc < 0 || var != 1)
+		return -EINVAL;
+
+	down(&ifs_sem);
+	rc = load_ifs_binary();
+	up(&ifs_sem);
+	if (rc < 0) {
+		pr_info("failed to reload ifs hash and test\n");
+		return rc;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(reload);
+
+static int run_allcpu_scan_test(void)
+{
+	int cpu;
+
+	if (down_trylock(&ifs_sem)) {
+		pr_info("another instance in progress.\n");
+		return -EBUSY;
+	}
+
+	cpu_hotplug_disable();
+	for_each_cpu(cpu, cpu_online_mask) {
+		/* Only execute test on the first thread on each core */
+		if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
+			continue;
+		do_core_test(cpu);
+		mdelay(core_delay);
+	}
+	cpu_hotplug_enable();
+
+	up(&ifs_sem);
+	return 0;
+}
+
+/*
+ * The sysfs interface to execute scan test for all online cpus.
+ * The test can be triggered as below:
+ * echo 1 > /sys/devices/system/cpu/ifs/run_test
+ */
+static ssize_t allcpu_run_test_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	bool var;
+	int rc;
+
+	if (ifs_disabled)
+		return -ENXIO;
+
+	rc = kstrtobool(buf, &var);
+	if (rc < 0 || var != 1)
+		return -EINVAL;
+
+	rc = run_allcpu_scan_test();
+	if (rc < 0)
+		return rc;
+
+	return count;
+}
+
+/*
+ * Percpu and allcpu ifs have attributes named "run_test".
+ * Since the former is defined in this same file using DEVICE_ATTR_WO()
+ * the latter is defined directly.
+ */
+static struct device_attribute dev_attr_allcpu_run_test = {
+	.attr	= { .name = "run_test", .mode = 0200 },
+	.store	= allcpu_run_test_store,
+};
+
+/*
+ * Currently loaded IFS image version.
+ */
+static ssize_t image_version_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%x\n", ifs_params.loaded_version);
+}
+
+static DEVICE_ATTR_RO(image_version);
+
+/*
+ * Currently loaded IFS image version.
+ */
+static ssize_t cpu_fail_list_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	int ret;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	ret = sprintf(buf, "%*pbl\n", cpumask_pr_args(&ifs_params.fail_mask));
+	up(&ifs_sem);
+	return ret;
+}
+
+static DEVICE_ATTR_RO(cpu_fail_list);
+
+static ssize_t cpu_untested_list_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	int ret;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	ret = sprintf(buf, "%*pbl\n", cpumask_pr_args(&ifs_params.not_tested_mask));
+	up(&ifs_sem);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(cpu_untested_list);
+
+static ssize_t cpu_pass_list_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	int ret;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	ret = sprintf(buf, "%*pbl\n", cpumask_pr_args(&ifs_params.pass_mask));
+	up(&ifs_sem);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(cpu_pass_list);
+
+/*
+ * Status for global ifs test
+ */
+static ssize_t allcpu_status_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	int ret;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	if (!cpumask_empty(&ifs_params.fail_mask))
+		ret = sprintf(buf, "fail\n");
+	else if (!cpumask_empty(&ifs_params.not_tested_mask))
+		ret = sprintf(buf, "untested\n");
+	else
+		ret = sprintf(buf, "pass\n");
+
+	up(&ifs_sem);
+
+	return ret;
+}
+
+/*
+ * Percpu and allcpu ifs have attributes named "status".
+ * Since the former is defined in this same file using DEVICE_ATTR_RO()
+ * the latter is defined directly.
+ */
+static struct device_attribute dev_attr_allcpu_status = {
+	.attr	= { .name = "status", .mode = 0444 },
+	.show	= allcpu_status_show,
+};
+
+/* global scan sysfs attributes */
+static struct attribute *cpu_ifs_attrs[] = {
+	&dev_attr_reload.attr,
+	&dev_attr_allcpu_run_test.attr,
+	&dev_attr_image_version.attr,
+	&dev_attr_cpu_fail_list.attr,
+	&dev_attr_cpu_untested_list.attr,
+	&dev_attr_cpu_pass_list.attr,
+	&dev_attr_allcpu_status.attr,
+	NULL
+};
+
+const struct attribute_group cpu_ifs_attr_group = {
+	.attrs = cpu_ifs_attrs,
+};
+
+const struct attribute_group *cpu_ifs_attr_groups[] = {
+	&cpu_ifs_attr_group,
+	NULL,
+};
+
+static struct device *cpu_scan_device;
+
+/* Creates the sysfs files under /sys/devices/system/cpu/ifs */
+void cpu_ifs_init(void)
+{
+	struct device *root;
+
+	root = cpu_subsys.dev_root;
+	cpu_scan_device = cpu_device_create(root, NULL, cpu_ifs_attr_groups, "ifs");
+}
+
+void cpu_ifs_exit(void)
+{
+	device_unregister(cpu_scan_device);
+}
-- 
2.17.1

