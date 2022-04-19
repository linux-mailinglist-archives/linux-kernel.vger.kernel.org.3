Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7E8507438
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354905AbiDSQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354749AbiDSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF7215FDD;
        Tue, 19 Apr 2022 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386349; x=1681922349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lAHmRWehfWDOAFlxWZxUdjWAKAkKi+7uhbPifbaQN5s=;
  b=ZpURAYuUHE5v9+0o8peVzfuq8g4b0WxWzQprV5xTv6+vezfYLrPN5yxO
   GOWU/61MsbLXxAKBBGVSakc+YbPtErXTao4KJfUtOpNxTZMhBwQqNYgtY
   awFKK19tpG+FfUKVK8B4sUNDV5T71JH6qsLH2a9muHWOI5w7IfqVG2czU
   3Bio17nFrxg5wCJVjFhK4LJlifYEODKRL2/esmPYUSu2LebG9VXtfit6G
   94i7WzRwbyEgcjk12cSBcKTv6MtWZOtucrDbgNi1n1lLkLUJykJncuvZj
   hbuaLTmr78PkDPcSowKVMlmlCvdvvHB1qNr+CIbXu6Gtb9ghbqISkKiO+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702540"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702540"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802154"
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
Subject: [PATCH v3 07/11] platform/x86/intel/ifs: Authenticate and copy to secured memory
Date:   Tue, 19 Apr 2022 09:38:55 -0700
Message-Id: <20220419163859.2228874-8-tony.luck@intel.com>
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
 drivers/platform/x86/intel/ifs/ifs.h  |  33 ++++++
 drivers/platform/x86/intel/ifs/load.c | 165 ++++++++++++++++++++++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index dacc8b6ce159..c51e285fc7ba 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -4,14 +4,47 @@
 #ifndef _IFS_H_
 #define _IFS_H_
 
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
  * @loaded_version: stores the currently loaded ifs image version.
  * @loaded: If a valid test binary has been loaded into the memory
+ * @valid_chunks: number of chunks which could be validated.
  */
 struct ifs_data {
 	int loaded_version;
 	bool loaded;
+	int valid_chunks;
 };
 
 int load_ifs_binary(struct device *dev);
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index b05d9055c391..04072ed84071 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -3,10 +3,169 @@
 
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <asm/cpu.h>
 #include <asm/microcode_intel.h>
 
+#include "ifs.h"
+
 static const char *ifs_path = "intel/ifs/";
+static bool ifs_loading_error;	/* error occurred during ifs hashes/chunk authentication.*/
+
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
+	ifsd = dev_get_drvdata(dev);
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
+		ifs_loading_error = true;
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
+			ifs_loading_error = true;
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
+	struct ifs_data *ifsd = dev_get_drvdata(dev);
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
+	ifs_loading_error = false;
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
+		if (ret || ifs_loading_error) {
+			ret = ifs_loading_error ? -ENOMEM : ret;
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
 
 static int ifs_sanity_check(struct device *dev, void *mc)
 {
@@ -92,8 +251,14 @@ int load_ifs_binary(struct device *dev)
 	if (!ifs_image_sanity_check(dev, (void *)fw->data)) {
 		dev_err(dev, "ifs header sanity check failed\n");
 		ret = -ENOENT;
+		goto release;
 	}
 
+	ifs_header_ptr = (struct ifs_header *)fw->data;
+	ifs_hash_ptr = (u64)(ifs_header_ptr + 1);
+
+	ret = scan_chunks_sanity_check(dev);
+release:
 	release_firmware(fw);
 
 	return ret;
-- 
2.35.1

