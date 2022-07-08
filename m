Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20FA56BD91
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiGHPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbiGHPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:21:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3052D1C108;
        Fri,  8 Jul 2022 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657293690; x=1688829690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TbxLQsX7X7jtiu3wxncWkDvV7SYx2qXGo050KRVi1pk=;
  b=gxIADb5wYC5/FlCo3M+b6/OHtxYfk4gq/sFRQTb1UseffDCkocuVP7EL
   bfAvdpTsGSVNKYUtUzhi0VWDoq6Nlg4fPnNjOHCSWZ4pCnLhtwJIxBlm3
   IUyMlJZBj6+Ep+jFvwoLUBGCNbmdF5udNSHUhfMo2cAOA0b4wI/+suKek
   EWNUhLMFxmuCSBCON8keX8SqH7Ag1moHTDKmbqykqfTdznZg+N6g6T1Ny
   SuGoy3KoNZJJSWIz81gR+H7XPTK0lidlHSAbDeyeymOjXQLWLhjAzEhxk
   pusHHVsAoBeSvdYwo81hDkLfwmP6a2MpHQzcID0as62OLKz33zMvHuiSS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="285430866"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285430866"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 08:21:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="621251955"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 08:21:29 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     ashok.raj@intel.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, ravi.v.shankar@intel.com,
        jithu.joseph@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH] platform/x86/intel/ifs: Allow non-default names for IFS image
Date:   Fri,  8 Jul 2022 08:19:38 -0700
Message-Id: <20220708151938.986530-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing implementation limits IFS image to be loaded only from
a default file-name (ff-mm-ss.scan).

Change the semantics of the "reload" file. Writing "1" keeps the legacy
behavior to reload from the default "ff-mm-ss.scan" file, but now interpret
other strings as a filename to be loaded from the /lib/firmware/intel/ifs
directory.

Situations where multiple image files are helpful:
1. Test contents are larger than the memory reserved for IFS by BIOS
2. Increased test coverage
3. Custom test files to debug certain specific issues in field

Fix the below items in adjacent code
- Return error when ifs_image_sanity_check() fails in ifs_load_firmware()
- Correct documentation "ifs.0"->"ifs"

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h          | 11 +++++--
 drivers/platform/x86/intel/ifs/core.c         |  2 +-
 drivers/platform/x86/intel/ifs/load.c         | 30 +++++++++++++++----
 drivers/platform/x86/intel/ifs/sysfs.c        | 13 ++------
 .../ABI/testing/sysfs-platform-intel-ifs      |  5 +++-
 5 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 73c8e91cf144..ee258e896dd0 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -39,7 +39,14 @@
  *   # echo 1 > /sys/devices/virtual/misc/intel_ifs_0/reload
  *
  * Similar to microcode, the current version of the scan tests is stored
- * in a fixed location: /lib/firmware/intel/ifs.0/family-model-stepping.scan
+ * in a fixed location: /lib/firmware/intel/ifs/family-model-stepping.scan
+ *
+ * An alternate scan file can be loaded by writing its filename to the
+ * reload file::
+ *
+ *   # echo mytest > /sys/devices/virtual/misc/intel_ifs_0/reload
+ *
+ * The file will be loaded from the same directory, i.e. /lib/firmware/intel/ifs/mytest
  *
  * Running tests
  * -------------
@@ -225,7 +232,7 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 	return &d->data;
 }
 
-void ifs_load_firmware(struct device *dev);
+int ifs_load_firmware(struct device *dev, const char *file_name);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
 
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 27204e3d674d..306f599a8f5a 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -53,7 +53,7 @@ static int __init ifs_init(void)
 	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
 	    !misc_register(&ifs_device.misc)) {
 		down(&ifs_sem);
-		ifs_load_firmware(ifs_device.misc.this_device);
+		ifs_load_firmware(ifs_device.misc.this_device, "1");
 		up(&ifs_sem);
 		return 0;
 	}
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index d056617ddc85..6f49a2c593f4 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -232,17 +232,33 @@ static bool ifs_image_sanity_check(struct device *dev, const struct microcode_he
 
 /*
  * Load ifs image. Before loading ifs module, the ifs image must be located
- * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
+ * in the folder /lib/firmware/intel/ifs/
  */
-void ifs_load_firmware(struct device *dev)
+int ifs_load_firmware(struct device *dev, const char *file_name)
 {
 	struct ifs_data *ifsd = ifs_get_data(dev);
+	bool default_name = false;
 	const struct firmware *fw;
-	char scan_path[32];
-	int ret;
+	char scan_path[64];
+	int ret = -EINVAL;
+	int file_name_len;
+
+	if ((kstrtobool(file_name, &default_name) == 0)) {
+		if (default_name)
+			snprintf(scan_path, sizeof(scan_path), "intel/ifs/%02x-%02x-%02x.scan",
+				 boot_cpu_data.x86,
+				 boot_cpu_data.x86_model,
+				 boot_cpu_data.x86_stepping);
+	}
 
-	snprintf(scan_path, sizeof(scan_path), "intel/ifs/%02x-%02x-%02x.scan",
-		 boot_cpu_data.x86, boot_cpu_data.x86_model, boot_cpu_data.x86_stepping);
+	if (!default_name) {
+		if (strchr(file_name, '/'))
+			goto done;
+		file_name_len = strchrnul(file_name, '\n') - file_name;
+		if (snprintf(scan_path, sizeof(scan_path), "intel/ifs/%.*s",
+			     file_name_len, file_name) >= sizeof(scan_path))
+			goto done;
+	}
 
 	ret = request_firmware_direct(&fw, scan_path, dev);
 	if (ret) {
@@ -252,6 +268,7 @@ void ifs_load_firmware(struct device *dev)
 
 	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data)) {
 		dev_err(dev, "ifs header sanity check failed\n");
+		ret = -EINVAL;
 		goto release;
 	}
 
@@ -263,4 +280,5 @@ void ifs_load_firmware(struct device *dev)
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
index 486d6d2ff8a0..560b85561eac 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -36,4 +36,7 @@ Date:		April 21 2022
 KernelVersion:	5.19
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Write "1" (or "y" or "Y") to reload the IFS image from
-		/lib/firmware/intel/ifs/ff-mm-ss.scan.
+                the default location /lib/firmware/intel/ifs/ff-mm-ss.scan.
+                Alternatively write <file_name> to use a specific IFS image file.
+                In this case image from /lib/firmware/intel/ifs/<file_name> will
+                be loaded.

base-commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
-- 
2.25.1

