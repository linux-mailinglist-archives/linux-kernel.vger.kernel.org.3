Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163B056CFE7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGJQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:01:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF9A12A88;
        Sun, 10 Jul 2022 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657468905; x=1689004905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z/zdwQGtGZpw5TUuqOObVGsMWxYIOgqz24mXmC4bem8=;
  b=eIFqQ3fyE7gWZ9YGW1WHiz0Z6YhJlvV5xCia7yqgeOZ8wFe1HY18sdCh
   K49ezB4L0f/NJFvVigmRC99h1ysSzsOtGWZclh+lES1toyb6dK2i0QXJY
   MhWxdgOfueWXm0gikMfh6bL/GjtzKXwFL1WTliZYXAHV7MUMD7ugcJIca
   3V39WaNLJ0MjK9ib8HwxmvYALgyvGq1f3Fky6dC/EJ9y182jeydY6zV7E
   30KBU3z7sdoCd9zg3RPpTLHs3AkuB4sL48AayaYIcKiwBJIQjRWnDXHp+
   oRbWR2F0FtmzywugmgoOffJO/6hkenpXfnWnT4cnF9Q6vVf6GZmkt9iMr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370832390"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="370832390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 09:01:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="621798255"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 09:01:39 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     ashok.raj@intel.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, ravi.v.shankar@intel.com,
        jithu.joseph@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for IFS image
Date:   Sun, 10 Jul 2022 09:00:11 -0700
Message-Id: <20220710160011.995800-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing implementation limits IFS images to be loaded only from
a default file-name /lib/firmware/intel/ifs/ff-mm-ss.scan.

But there are situations where there may be multiple scan files
that can be run on a particular system stored in /lib/firmware/intel/ifs

E.g.
1. Because test contents are larger than the memory reserved for IFS by BIOS
2. To provide increased test coverage
3. Custom test files to debug certain specific issues in the field

Renaming each of these to ff-mm-ss.scan and then loading might be
possible in some environments. But on systems where /lib is read-only
this is not a practical solution.

Modify the semantics of the driver file
/sys/devices/virtual/misc/intel_ifs_0/reload such that,
it interprets the input as the filename to be loaded.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
Changes in v2
- drop treating "1" specially, i.e treat everything as a file-name

 drivers/platform/x86/intel/ifs/ifs.h          | 11 ++++----
 drivers/platform/x86/intel/ifs/core.c         |  2 +-
 drivers/platform/x86/intel/ifs/load.c         | 25 +++++++++++++------
 drivers/platform/x86/intel/ifs/sysfs.c        | 13 +++-------
 .../ABI/testing/sysfs-platform-intel-ifs      |  3 +--
 5 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 73c8e91cf144..577cee7db86a 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -34,12 +34,13 @@
  * socket in a two step process using writes to MSRs to first load the
  * SHA hashes for the test. Then the tests themselves. Status MSRs provide
  * feedback on the success/failure of these steps. When a new test file
- * is installed it can be loaded by writing to the driver reload file::
+ * is installed it can be loaded by writing the filename to the driver reload file::
  *
- *   # echo 1 > /sys/devices/virtual/misc/intel_ifs_0/reload
+ *   # echo mytest > /sys/devices/virtual/misc/intel_ifs_0/reload
  *
- * Similar to microcode, the current version of the scan tests is stored
- * in a fixed location: /lib/firmware/intel/ifs.0/family-model-stepping.scan
+ * The file will be loaded from /lib/firmware/intel/ifs/mytest
+ * The default file /lib/firmware/intel/ifs/family-model-stepping.scan
+ * will be loaded during module insertion.
  *
  * Running tests
  * -------------
@@ -225,7 +226,7 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 	return &d->data;
 }
 
-void ifs_load_firmware(struct device *dev);
+int ifs_load_firmware(struct device *dev, const char *file_name);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
 
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 27204e3d674d..9c319ada62d8 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -53,7 +53,7 @@ static int __init ifs_init(void)
 	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
 	    !misc_register(&ifs_device.misc)) {
 		down(&ifs_sem);
-		ifs_load_firmware(ifs_device.misc.this_device);
+		ifs_load_firmware(ifs_device.misc.this_device, NULL);
 		up(&ifs_sem);
 		return 0;
 	}
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index d056617ddc85..89d76bd8b40a 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -232,17 +232,27 @@ static bool ifs_image_sanity_check(struct device *dev, const struct microcode_he
 
 /*
  * Load ifs image. Before loading ifs module, the ifs image must be located
- * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
+ * in the folder /lib/firmware/intel/ifs/
  */
-void ifs_load_firmware(struct device *dev)
+int ifs_load_firmware(struct device *dev, const char *file_name)
 {
 	struct ifs_data *ifsd = ifs_get_data(dev);
 	const struct firmware *fw;
-	char scan_path[32];
-	int ret;
-
-	snprintf(scan_path, sizeof(scan_path), "intel/ifs/%02x-%02x-%02x.scan",
-		 boot_cpu_data.x86, boot_cpu_data.x86_model, boot_cpu_data.x86_stepping);
+	char scan_path[64];
+	int ret = -EINVAL;
+	int file_name_len;
+
+	if (!file_name) {
+		snprintf(scan_path, sizeof(scan_path), "intel/ifs/%02x-%02x-%02x.scan",
+			 boot_cpu_data.x86, boot_cpu_data.x86_model, boot_cpu_data.x86_stepping);
+	} else {
+		if (strchr(file_name, '/'))
+			goto done;
+		file_name_len = strchrnul(file_name, '\n') - file_name;
+		if (snprintf(scan_path, sizeof(scan_path), "intel/ifs/%.*s",
+			     file_name_len, file_name) >= sizeof(scan_path))
+			goto done;
+	}
 
 	ret = request_firmware_direct(&fw, scan_path, dev);
 	if (ret) {
@@ -263,4 +273,5 @@ void ifs_load_firmware(struct device *dev)
 	release_firmware(fw);
 done:
 	ifsd->loaded = (ret == 0);
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 37d8380d6fa8..b4716b7d36aa 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -94,23 +94,16 @@ static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct ifs_data *ifsd = ifs_get_data(dev);
-	bool res;
-
-
-	if (kstrtobool(buf, &res))
-		return -EINVAL;
-	if (!res)
-		return count;
+	int ret;
 
 	if (down_interruptible(&ifs_sem))
 		return -EINTR;
 
-	ifs_load_firmware(dev);
+	ret = ifs_load_firmware(dev, buf);
 
 	up(&ifs_sem);
 
-	return ifsd->loaded ? count : -ENODEV;
+	return ret  ? ret : count;
 }
 
 static DEVICE_ATTR_WO(reload);
diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 486d6d2ff8a0..0b373f73a2b6 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -35,5 +35,4 @@ What:		/sys/devices/virtual/misc/intel_ifs_<N>/reload
 Date:		April 21 2022
 KernelVersion:	5.19
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
-Description:	Write "1" (or "y" or "Y") to reload the IFS image from
-		/lib/firmware/intel/ifs/ff-mm-ss.scan.
+Description:	Write <file_name> to reload the IFS image from /lib/firmware/intel/<file_name>.

base-commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
-- 
2.25.1

