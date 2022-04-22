Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC89250C2B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiDVWLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiDVWIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:08:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C532F5749;
        Fri, 22 Apr 2022 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650660986; x=1682196986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDP1KA+gF3VUWjOrR0cxv6/OeKG5WTWBFwvyZldlYfM=;
  b=O4ltg5tsIahwh6SUbxF4biKzDNvjwf50nZlGTWZbilwlQ4mIbxfowTFH
   El03S2eAPY2Q/poxHyXD+Wk/lvCuB358uruLs7hCJMc6w+SP0TcuL9eIo
   Y+iBHHedMAoCIve7XkoFEWjTy6CrRwiO4kAGhpifJDVJiGMd3wVqlm1gX
   W0frdhdny3kBGuieFQcZsxXZ27Gi2cGe8swN20MJjcyEHjbIeMooIEsg2
   Hz8vkwEGgUZpojPg4hQ/qfg0HLpbsnJAm7BRCXKgMQRB8wtur02xYEMY6
   7MNj1IJIR55cBwdK6qVKJ6Tzk4WoIE+QueAQlyn8287ViPzywlI89k846
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289897463"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="289897463"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:02:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="511719345"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:02:27 -0700
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
Subject: [PATCH v4 06/10] platform/x86/intel/ifs: Authenticate and copy to secured memory
Date:   Fri, 22 Apr 2022 13:02:15 -0700
Message-Id: <20220422200219.2843823-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422200219.2843823-1-tony.luck@intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
 <20220422200219.2843823-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

The IFS image contains hashes that will be used to authenticate the ifs
test chunks. First, use WRMSR to copy the hashes and enumerate the number
of test chunks, chunk size and the maximum number of cores that can run
scan test simultaneously.

Next, use WRMSR to authenticate each and every scan test chunk which is
also stored in the IFS image. The CPU will check if the test chunks match
the hashes, otherwise failure is indicated to system software. If the test
chunk is authenticated, it is automatically copied to secured memory.

The ifs hash copy and authentication only needs to be done on the first
logical cpu of each socket.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  47 +++++++
 drivers/platform/x86/intel/ifs/load.c | 170 +++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 9a0f8e2077e2..a9e73346cd28 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -7,12 +7,51 @@
 #include <linux/device.h>
 #include <linux/miscdevice.h>
 
+#define MSR_COPY_SCAN_HASHES			0x000002c2
+#define MSR_SCAN_HASHES_STATUS			0x000002c3
+#define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
+#define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
+
+/* MSR_SCAN_HASHES_STATUS bit fields */
+union ifs_scan_hashes_status {
+	u64	data;
+	struct {
+		u32	chunk_size	:16;
+		u32	num_chunks	:8;
+		u32	rsvd1		:8;
+		u32	error_code	:8;
+		u32	rsvd2		:11;
+		u32	max_core_limit	:12;
+		u32	valid		:1;
+	};
+};
+
+/* MSR_CHUNKS_AUTH_STATUS bit fields */
+union ifs_chunks_auth_status {
+	u64	data;
+	struct {
+		u32	valid_chunks	:8;
+		u32	total_chunks	:8;
+		u32	rsvd1		:16;
+		u32	error_code	:8;
+		u32	rsvd2		:24;
+	};
+};
+
 /**
  * struct ifs_data - attributes related to intel IFS driver
  * @integrity_cap_bit - MSR_INTEGRITY_CAPS bit enumerating this test
+ * @loaded_version: stores the currently loaded ifs image version.
+ * @loaded: If a valid test binary has been loaded into the memory
+ * @loading_error: Error occurred on another CPU while loading image
+ * @valid_chunks: number of chunks which could be validated.
  */
 struct ifs_data {
 	int integrity_cap_bit;
+	int loaded_version;
+	bool loaded;
+	bool loading_error;
+	int valid_chunks;
 };
 
 struct ifs_device {
@@ -20,6 +59,14 @@ struct ifs_device {
 	struct miscdevice misc;
 };
 
+static inline struct ifs_data *ifs_get_data(struct device *dev)
+{
+	struct miscdevice *m = dev_get_drvdata(dev);
+	struct ifs_device *d = container_of(m, struct ifs_device, misc);
+
+	return &d->data;
+}
+
 void ifs_load_firmware(struct device *dev);
 
 #endif
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index aece78d1c757..46a9b78aa195 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -3,10 +3,166 @@
 
 #include <linux/firmware.h>
 #include <asm/cpu.h>
+#include <linux/slab.h>
 #include <asm/microcode_intel.h>
 
 #include "ifs.h"
 
+struct ifs_header {
+	u32 header_ver;
+	u32 blob_revision;
+	u32 date;
+	u32 processor_sig;
+	u32 check_sum;
+	u32 loader_rev;
+	u32 processor_flags;
+	u32 metadata_size;
+	u32 total_size;
+	u32 fusa_info;
+	u64 reserved;
+};
+
+#define IFS_HEADER_SIZE	(sizeof(struct ifs_header))
+static struct ifs_header *ifs_header_ptr;	/* pointer to the ifs image header */
+static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
+static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
+
+static const char * const scan_hash_status[] = {
+	[0] = "No error reported",
+	[1] = "Attempt to copy scan hashes when copy already in progress",
+	[2] = "Secure Memory not set up correctly",
+	[3] = "FuSaInfo.ProgramID does not match or ff-mm-ss does not match",
+	[4] = "Reserved",
+	[5] = "Integrity check failed",
+	[6] = "Scan reload or test is in progress"
+};
+
+static const char * const scan_authentication_status[] = {
+	[0] = "No error reported",
+	[1] = "Attempt to authenticate a chunk which is already marked as authentic",
+	[2] = "Chunk authentication error. The hash of chunk did not match expected value"
+};
+
+/*
+ * To copy scan hashes and authenticate test chunks, the initiating cpu must point
+ * to the EDX:EAX to the test image in linear address.
+ * Run wrmsr(MSR_COPY_SCAN_HASHES) for scan hash copy and run wrmsr(MSR_AUTHENTICATE_AND_COPY_CHUNK)
+ * for scan hash copy and test chunk authentication.
+ */
+static void copy_hashes_authenticate_chunks(void *arg)
+{
+	union ifs_scan_hashes_status hashes_status;
+	union ifs_chunks_auth_status chunk_status;
+	int i, num_chunks, chunk_size;
+	struct device *dev = arg;
+	struct ifs_data *ifsd;
+	u64 linear_addr, base;
+	u32 err_code;
+
+	ifsd = ifs_get_data(dev);
+	/* run scan hash copy */
+	wrmsrl(MSR_COPY_SCAN_HASHES, ifs_hash_ptr);
+	rdmsrl(MSR_SCAN_HASHES_STATUS, hashes_status.data);
+
+	/* enumerate the scan image information */
+	num_chunks = hashes_status.num_chunks;
+	chunk_size = hashes_status.chunk_size * 1024;
+	err_code = hashes_status.error_code;
+
+	if (!hashes_status.valid) {
+		ifsd->loading_error = true;
+		if (err_code >= ARRAY_SIZE(scan_hash_status)) {
+			dev_err(dev, "invalid error code 0x%x for hash copy\n", err_code);
+			return;
+		}
+		dev_err(dev, "Hash copy error : %s", scan_hash_status[err_code]);
+		return;
+	}
+
+	/* base linear address to the scan data */
+	base = ifs_test_image_ptr;
+
+	/* scan data authentication and copy chunks to secured memory */
+	for (i = 0; i < num_chunks; i++) {
+		linear_addr = base + i * chunk_size;
+		linear_addr |= i;
+
+		wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, linear_addr);
+		rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
+
+		ifsd->valid_chunks = chunk_status.valid_chunks;
+		err_code = chunk_status.error_code;
+
+		if (err_code) {
+			ifsd->loading_error = true;
+			if (err_code >= ARRAY_SIZE(scan_authentication_status)) {
+				dev_err(dev,
+					"invalid error code 0x%x for authentication\n", err_code);
+				return;
+			}
+			dev_err(dev, "Chunk authentication error %s\n",
+				scan_authentication_status[err_code]);
+			return;
+		}
+	}
+}
+
+/*
+ * IFS requires scan chunks authenticated per each socket in the platform.
+ * Once the test chunk is authenticated, it is automatically copied to secured memory
+ * and proceed the authentication for the next chunk.
+ */
+static int scan_chunks_sanity_check(struct device *dev)
+{
+	int metadata_size, curr_pkg, cpu, ret = -ENOMEM;
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	bool *package_authenticated;
+	char *test_ptr;
+
+	package_authenticated = kcalloc(topology_max_packages(), sizeof(bool), GFP_KERNEL);
+	if (!package_authenticated)
+		return ret;
+
+	metadata_size = ifs_header_ptr->metadata_size;
+
+	/* Spec says that if the Meta Data Size = 0 then it should be treated as 2000 */
+	if (metadata_size == 0)
+		metadata_size = 2000;
+
+	/* Scan chunk start must be 256 byte aligned */
+	if ((metadata_size + IFS_HEADER_SIZE) % 256) {
+		dev_err(dev, "Scan pattern offset within the binary is not 256 byte aligned\n");
+		return -EINVAL;
+	}
+
+	test_ptr = (char *)ifs_header_ptr + IFS_HEADER_SIZE + metadata_size;
+	ifsd->loading_error = false;
+
+	ifs_test_image_ptr = (u64)test_ptr;
+	ifsd->loaded_version = ifs_header_ptr->blob_revision;
+
+	/* copy the scan hash and authenticate per package */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		curr_pkg = topology_physical_package_id(cpu);
+		if (package_authenticated[curr_pkg])
+			continue;
+		package_authenticated[curr_pkg] = 1;
+		ret = smp_call_function_single(cpu, copy_hashes_authenticate_chunks,
+					       dev, 1);
+		if (ret || ifsd->loading_error) {
+			ret = ifsd->loading_error ? -ENOMEM : ret;
+			goto out;
+		}
+	}
+
+out:
+	cpus_read_unlock();
+	kfree(package_authenticated);
+
+	return ret;
+}
+
 static int ifs_sanity_check(struct device *dev,
 			    const struct microcode_header_intel *mc_header)
 {
@@ -76,6 +232,7 @@ static bool ifs_image_sanity_check(struct device *dev, const struct microcode_he
  */
 void ifs_load_firmware(struct device *dev)
 {
+	struct ifs_data *ifsd = ifs_get_data(dev);
 	const struct firmware *fw;
 	char scan_path[32];
 	int ret;
@@ -86,11 +243,20 @@ void ifs_load_firmware(struct device *dev)
 	ret = request_firmware_direct(&fw, scan_path, dev);
 	if (ret) {
 		dev_err(dev, "ifs file %s load failed\n", scan_path);
-		return;
+		goto done;
 	}
 
-	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data))
+	if (!ifs_image_sanity_check(dev, (struct microcode_header_intel *)fw->data)) {
 		dev_err(dev, "ifs header sanity check failed\n");
+		goto release;
+	}
+
+	ifs_header_ptr = (struct ifs_header *)fw->data;
+	ifs_hash_ptr = (u64)(ifs_header_ptr + 1);
 
+	ret = scan_chunks_sanity_check(dev);
+release:
 	release_firmware(fw);
+done:
+	ifsd->loaded = (ret == 0);
 }
-- 
2.35.1

