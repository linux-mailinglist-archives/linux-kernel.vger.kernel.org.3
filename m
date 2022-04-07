Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C404F87EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiDGTRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiDGTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:16:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24FD23F3F3;
        Thu,  7 Apr 2022 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649358867; x=1680894867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5ehqf316RdAka79UWwQtesTUIsJFIeDPGATINN3N0JQ=;
  b=kYJW8a2g/R+Y00FzCTsHmqz8ThJ5Wgf35Wl6wke7/RLT6AMImftadKWT
   VafcjlYcctR1gs26g208jj2iB+CIc0+E8L2pj4V1ScF5mXo+XT0fLVQhq
   m3Zg+ncrr4iP6oyo2G7WajN1Mc/GnNkN4aULwXPqAQJ2jrjTpoTDalFiN
   2Bw1uAiGIe2yJK4p3cznuG1bh0jhME2qgdlezidl6VSBAi/2vizybzXmX
   1ZESXE/1JBjZzfJ/lVJ3kIMVfuZxhp5FMj7lVf0GKd33OOerGWsf1K2Jx
   DpeXojJH3c6gsXYM+pvw7DiT/4vafaza+MANokYgyG/MxKlbiDaD9Xip4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260255387"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="260255387"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 12:14:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571193728"
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
Subject: [PATCH v2 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
Date:   Thu,  7 Apr 2022 12:13:45 -0700
Message-Id: <20220407191347.9681-9-jithu.joseph@intel.com>
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

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/Makefile |   2 +-
 drivers/platform/x86/intel/ifs/core.c   |   1 +
 drivers/platform/x86/intel/ifs/ifs.h    |   2 +
 drivers/platform/x86/intel/ifs/sysfs.c  | 139 ++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index d5905e5d2de8..93745fcdf652 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_INTEL_IFS)			+= intel_ifs.o
 
-intel_ifs-objs				:= core.o load.o runtest.o
+intel_ifs-objs				:= core.o load.o runtest.o sysfs.o
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 95847e00038b..85442953d0f5 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -82,6 +82,7 @@ static int __init ifs_init(void)
 		goto drv_unreg;
 	}
 
+	ifs_sysfs_add();
 	ret = platform_device_add(ifs_pdev);
 	if (ret) {
 		pr_err("intel_ifs: platform device add failed\n");
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 93cc1af4aea0..3200d9de4436 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -127,6 +127,8 @@ struct ifs_test {
 
 int load_ifs_binary(void);
 int do_core_test(int cpu);
+void ifs_sysfs_add(void);
+
 extern struct platform_device *ifs_pdev;
 extern struct ifs_binary ifs_binary;
 extern struct ifs_test ifs_test;
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
new file mode 100644
index 000000000000..f6decebbeae9
--- /dev/null
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -0,0 +1,139 @@
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
+static DEFINE_SEMAPHORE(ifs_sem);
+
+/*
+ * The sysfs interface to check additional details of last test
+ * cat /sys/devices/system/platform/ifs/details
+ */
+static ssize_t details_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	int ret;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	ret = sysfs_emit(buf, "%#llx\n", ifs_test.scan_details);
+	up(&ifs_sem);
+
+	return ret;
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
+	int ret;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	ret = sysfs_emit(buf, "%s\n", status_msg[ifs_test.status]);
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
+	unsigned int cpu;
+	int ret = count;
+	int rc;
+
+	if (!ifs_binary.loaded) {
+		dev_info(&ifs_pdev->dev, "Load scan binary using driver bind interface\n");
+		return -EPERM;
+	}
+
+	if (ifs_disabled)
+		return -ENXIO;
+
+	rc = kstrtouint(buf, 0, &cpu);
+	if (rc < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (down_trylock(&ifs_sem))
+		return -EBUSY;
+
+	rc = do_core_test(cpu);
+	if (rc)
+		ret = rc;
+
+	up(&ifs_sem);
+
+	return ret;
+}
+
+static DEVICE_ATTR_WO(run_test);
+
+/*
+ * Currently loaded IFS image version.
+ */
+static ssize_t image_version_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%#x\n", ifs_binary.loaded_version);
+}
+
+static DEVICE_ATTR_RO(image_version);
+
+/* global scan sysfs attributes */
+static struct attribute *plat_ifs_attrs[] = {
+	&dev_attr_image_version.attr,
+	&dev_attr_run_test.attr,
+	&dev_attr_status.attr,
+	&dev_attr_details.attr,
+	NULL
+};
+
+static const struct attribute_group plat_ifs_attr_group = {
+	.attrs = plat_ifs_attrs,
+};
+
+static const struct attribute_group *plat_ifs_groups[] = {
+	&plat_ifs_attr_group,
+	NULL
+};
+
+void ifs_sysfs_add(void)
+{
+	ifs_pdev->dev.groups = plat_ifs_groups;
+}
-- 
2.17.1

