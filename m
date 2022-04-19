Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA236507495
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355020AbiDSQnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354759AbiDSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB43165AD;
        Tue, 19 Apr 2022 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386350; x=1681922350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rl3uEdpxOQU5349vFOTUv4jtIFXCWqbErRbGVN1n8Rw=;
  b=AOcbia7Z0B919bEMlqFSv7LQJ5O/TrHNiQH1YJjBi+vnKNKBiyJBhPyO
   VK+manMVpb3twBkeYs2gmnqAKGVm4Z/5k6Wpn7BfwM2K2miHXNe1W4JHJ
   JS3gsOFerfBY+PTUk8P9dEoPvAwCb/4zTSrnakQuLAOqFMbqwOw64v5Ju
   a+EKB/xvRdyyRHAOUVAfMa81jfKm2C8kxYNixmx7d4VR44vljO73Fkh0f
   q6uefM5yoffgIaYtrpchscJbP7OMkBAuyUMc/XFhFi8rGxDSBn108tI6x
   Oo40K4zqjJaaCjfSh1bWlPrl79UBSZEoKuGoHiAqQKLvmLVCzgFt5u+yQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702552"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702552"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802167"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:09 -0700
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
Subject: [PATCH v3 09/11] platform/x86/intel/ifs: Add IFS sysfs interface
Date:   Tue, 19 Apr 2022 09:38:57 -0700
Message-Id: <20220419163859.2228874-10-tony.luck@intel.com>
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

Implement sysfs interface to trigger ifs test for a specific cpu.
Additional interfaces related to checking the status of the
scan test and seeing the version of the loaded IFS binary
are also added.

The basic usage is as below.
   - To start test, for example on cpu5:
       echo 5 > /sys/devices/platform/intel_ifs/run_test
   - To see the status of the last test
       cat /sys/devices/platform/intel_ifs/status
   - To see the version of the loaded scan binary
       cat /sys/devices/platform/intel_ifs/image_version

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/Makefile  |   2 +-
 drivers/platform/x86/intel/ifs/core.c    |   9 ++
 drivers/platform/x86/intel/ifs/ifs.h     |   3 +
 drivers/platform/x86/intel/ifs/runtest.c |   7 ++
 drivers/platform/x86/intel/ifs/sysfs.c   | 151 +++++++++++++++++++++++
 5 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index 7de27361b479..dbbe0bf66987 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -2,4 +2,4 @@ obj-$(CONFIG_INTEL_IFS_DEVICE)	+= intel_ifs_device.o
 
 obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
 
-intel_ifs-objs			:= core.o load.o runtest.o
+intel_ifs-objs			:= core.o load.o runtest.o sysfs.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 0dc4cdda35ff..f56cde0cdfd6 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/semaphore.h>
 
 #include "ifs.h"
 
@@ -26,10 +27,18 @@ static int ifs_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * Note there is no need for a ->remove() call back. There isn't an
+ * "unload" operation to remove the scan binary from the BIOS reserved
+ * area. Also ".dev_groups" removal order will guarantee that any in
+ * flight tests have completed.
+ */
+
 static struct platform_driver intel_ifs_driver = {
 	.probe = ifs_probe,
 	.driver = {
 		.name = "intel_ifs",
+		.dev_groups = plat_ifs_groups,
 	},
 };
 
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index f5e3636d709f..4e6662f2d2f8 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -97,4 +97,7 @@ int ifs_setup_wq(void);
 void ifs_destroy_wq(void);
 int do_core_test(int cpu, struct device *dev);
 
+extern const struct attribute_group *plat_ifs_groups[];
+extern struct semaphore ifs_sem;
+
 #endif
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 7793a01f7b94..246eff250563 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -10,6 +10,13 @@
 
 #include "ifs.h"
 
+/*
+ * Note all code and data in this file is protected by
+ * ifs_sem. On HT systems all threads on a core will
+ * execute together, but only the first thread on the
+ * core will update results of the test and indicate
+ * completion.
+ */
 static struct workqueue_struct *ifs_wq;
 static struct completion test_thread_done;
 static atomic_t siblings_in;
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
new file mode 100644
index 000000000000..41db2a12fbc8
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. */
+
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/platform_device.h>
+#include <linux/semaphore.h>
+#include <linux/slab.h>
+
+#include "ifs.h"
+
+/*
+ * Protects against simultaneous tests on multiple cores, or
+ * reloading can file while a test is in progress
+ */
+DEFINE_SEMAPHORE(ifs_sem);
+
+/*
+ * The sysfs interface to check additional details of last test
+ * cat /sys/devices/system/platform/ifs/details
+ */
+static ssize_t details_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct ifs_data *ifsd = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%#llx\n", ifsd->scan_details);
+}
+
+static DEVICE_ATTR_RO(details);
+
+static const char * const status_msg[] = {
+	[SCAN_NOT_TESTED] = "untested",
+	[SCAN_TEST_PASS] = "pass",
+	[SCAN_TEST_FAIL] = "fail"
+};
+
+/*
+ * The sysfs interface to check the test status:
+ * To check the status of last test
+ * cat /sys/devices/platform/ifs/status
+ */
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ifs_data *ifsd = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", status_msg[ifsd->status]);
+}
+
+static DEVICE_ATTR_RO(status);
+
+/*
+ * The sysfs interface for single core testing
+ * To start test, for example, cpu5
+ * echo 5 > /sys/devices/platform/ifs/run_test
+ * To check the result:
+ * cat /sys/devices/platform/ifs/result
+ * The sibling core gets tested at the same time.
+ */
+static ssize_t run_test_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct ifs_data *ifsd = dev_get_drvdata(dev);
+	unsigned int cpu;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &cpu);
+	if (rc < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (down_interruptible(&ifs_sem))
+		return -EINTR;
+
+	if (!ifsd->loaded)
+		rc = -EPERM;
+	else
+		rc = do_core_test(cpu, dev);
+
+	up(&ifs_sem);
+
+	return rc ? rc : count;
+}
+
+static DEVICE_ATTR_WO(run_test);
+
+/*
+ * Reload the IFS image. When user wants to install new IFS image
+ */
+static ssize_t reload_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct ifs_data *ifsd = dev_get_drvdata(dev);
+	int rc;
+
+	if (!sysfs_streq(buf, "1"))
+		return -EINVAL;
+
+	if (down_interruptible(&ifs_sem))
+		return -EINTR;
+
+	rc = load_ifs_binary(dev);
+
+	ifsd->loaded = (rc == 0);
+
+	up(&ifs_sem);
+
+	return rc ? rc : count;
+}
+
+static DEVICE_ATTR_WO(reload);
+
+/*
+ * Display currently loaded IFS image version.
+ */
+static ssize_t image_version_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct ifs_data *ifsd = dev_get_drvdata(dev);
+
+	if (!ifsd->loaded)
+		return sysfs_emit(buf, "%s\n", "none");
+	else
+		return sysfs_emit(buf, "%#x\n", ifsd->loaded_version);
+}
+
+static DEVICE_ATTR_RO(image_version);
+
+/* global scan sysfs attributes */
+static struct attribute *plat_ifs_attrs[] = {
+	&dev_attr_details.attr,
+	&dev_attr_status.attr,
+	&dev_attr_run_test.attr,
+	&dev_attr_reload.attr,
+	&dev_attr_image_version.attr,
+	NULL
+};
+
+static const struct attribute_group plat_ifs_attr_group = {
+	.attrs = plat_ifs_attrs,
+};
+
+const struct attribute_group *plat_ifs_groups[] = {
+	&plat_ifs_attr_group,
+	NULL
+};
-- 
2.35.1

