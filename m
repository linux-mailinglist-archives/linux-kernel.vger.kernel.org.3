Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85C94C9539
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbiCAT5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiCAT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E66CA59;
        Tue,  1 Mar 2022 11:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164555; x=1677700555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LXBIKDOPHycxgjU3B8bcgxSuOd2mkT56pNavGwV7x9k=;
  b=KDuugjEVAkwSBbJPWUZerFw1NtziKBMVM+h4fllw8X63/JLkAEpQ3yoL
   1XB/xG+8WI/5+vEVB/yxEUsVElhdRa/7DTapzDJN4Fg2dwm6u7ZPBBMR3
   uBbJqMgR+rB3Suf01Q78z1bxUzL1Bn14clgP/qmOMAv3oOIbhK50PcrSU
   36wlnur6V699t/5XkRfJ5wvUX5OW6MnSXlLKx9qpP8cHO1ms+DF0NGlZQ
   EJjqmRQOssdAsTBtaaM/Rlt0tnR9EGGHaPqWO0fBTpoQLRR19+5GE3yGU
   SuMv6mvmOzS6iU2E3Bvek2ipQp17PEIZOk4r/FXtD+zRPr2mTvhmNhS0X
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194896"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194896"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133170"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:53 -0800
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
Subject: [RFC 06/10] platform/x86/intel/ifs: Authenticate and copy to secured memory
Date:   Tue,  1 Mar 2022 11:54:53 -0800
Message-Id: <20220301195457.21152-7-jithu.joseph@intel.com>
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

Originally-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  33 ++++++
 drivers/platform/x86/intel/ifs/load.c | 139 +++++++++++++++++++++++++-
 2 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index f2daf2cfd3e6..8f9abdb304b0 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -14,12 +14,45 @@
 #define MSR_IA32_CORE_CAPS_INTEGRITY_BIT	2
 #define MSR_IA32_CORE_CAPS_INTEGRITY		BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)
 
+#define MSR_COPY_SCAN_HASHES			0x000002c2
+#define MSR_SCAN_HASHES_STATUS			0x000002c3
+#define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
+#define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
+
+/* MSR_SCAN_HASHES_STATUS bit fields */
+union ifs_scan_hashes_status {
+	u64	data;
+	struct {
+		u64	chunk_size	:16;
+		u64	num_chunks	:8;
+		u64	rsvd1		:8;
+		u64	error_code	:8;
+		u64	rsvd2		:11;
+		u64	max_core_limit	:12;
+		u64	valid		:1;
+	};
+};
+
+/* MSR_CHUNKS_AUTH_STATUS bit fields */
+union ifs_chunks_auth_status {
+	u64	data;
+	struct {
+		u64	valid_chunks	:8;
+		u64	total_chunks	:8;
+		u64	rsvd1		:16;
+		u64	error_code	:8;
+		u64	rsvd2		:24;
+	};
+};
+
 /**
  * struct ifs_params - global ifs parameter for all cpus.
  * @loaded_version: stores the currently loaded ifs image version.
+ * @valid_chunks: number of chunks which could be validated.
  */
 struct ifs_params {
 	int loaded_version;
+	int valid_chunks;
 };
 
 int load_ifs_binary(void);
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index b40f70258f8e..a0cb0e1718bc 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -6,10 +6,13 @@
 
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <asm/microcode_intel.h>
 
 #include "ifs.h"
+
 static const char *ifs_path = "intel/ifs/";
+static bool ifs_loading_error;	/* error occurred during ifs hashes/chunk authentication.*/
 
 struct ifs_header {
 	u32 header_ver;
@@ -28,6 +31,140 @@ struct ifs_header {
 #define IFS_HEADER_SIZE	(sizeof(struct ifs_header))
 static struct ifs_header *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
+static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
+
+static const char * const scan_hash_status[] = {
+	"Reserved",
+	"Attempt to copy scan hashes when copy already in progress",
+	"Secure Memory not set up correctly",
+	"FuSaInfo.ProgramID does not match or ff-mm-ss does not match",
+	"Reserved",
+	"Integrity check failed",
+	"Scan test is in progress"
+};
+
+static const char * const scan_authentication_status[] = {
+	"No error reported",
+	"Attempt to authenticate a chunk which is already marked as authentic",
+	"Chunk authentication error. The hash of chunk did not match expected value"
+};
+
+/*
+ * To copy scan hashes and authenticate test chunks, the initiating cpu must point
+ * to the EDX:EAX to the test image in linear address.
+ * Run wrmsr(MSR_COPY_SCAN_HASHES) for scan hash copy and run wrmsr(MSR_AUTHENTICATE_AND_COPY_CHUNK)
+ * for scan hash copy and test chunk authentication.
+ */
+static int copy_hashes_authenticate_chunks(void *arg)
+{
+	union ifs_scan_hashes_status hashes_status;
+	union ifs_chunks_auth_status chunk_status;
+	int i, num_chunks, chunk_size;
+	u64 linear_addr, base;
+	u32 err_code;
+
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
+			pr_err("invalid error code 0x%x for hash copy\n", err_code);
+			return -EINVAL;
+		}
+		pr_err("ifs: %s", scan_hash_status[err_code]);
+		return -ENODEV;
+	}
+	pr_info("the total chunk number: %d\n", num_chunks);
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
+		ifs_params.valid_chunks = chunk_status.valid_chunks;
+		err_code = chunk_status.error_code;
+
+		if (err_code) {
+			ifs_loading_error = true;
+			if (err_code >= ARRAY_SIZE(scan_authentication_status)) {
+				pr_err("invalid error code 0x%x for authentication\n", err_code);
+				return -EINVAL;
+			}
+			pr_err("%s\n", scan_authentication_status[err_code]);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * IFS requires scan chunks authenticated per each socket in the platform.
+ * Once the test chunk is authenticated, it is automatically copied to secured memory
+ * and proceed the authentication for the next chunk.
+ */
+static int scan_chunks_sanity_check(void)
+{
+	int metadata_size, curr_pkg, cpu, ret = -ENOMEM;
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
+		pr_err("Scan pattern offset within the binary is not 256 byte aligned\n");
+		return -EINVAL;
+	}
+
+	test_ptr = (char *)ifs_header_ptr + IFS_HEADER_SIZE + metadata_size;
+
+	ifs_test_image_ptr = (u64)test_ptr;
+	ifs_params.loaded_version = ifs_header_ptr->blob_revision;
+
+	/* copy the scan hash and authenticate per package */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		curr_pkg = topology_physical_package_id(cpu);
+		if (package_authenticated[curr_pkg])
+			continue;
+		package_authenticated[curr_pkg] = 1;
+		ret = smp_call_function_single(cpu, (void *)copy_hashes_authenticate_chunks,
+					       NULL, 1);
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
+
 static int ifs_sanity_check(void *mc)
 {
 	struct microcode_header_intel *mc_header = mc;
@@ -154,7 +291,7 @@ int load_ifs_binary(void)
 	ifs_header_ptr = (struct ifs_header *)scan_fw->data;
 	ifs_hash_ptr = (u64)(ifs_header_ptr + 1);
 
-	ret = 0;
+	ret = scan_chunks_sanity_check();
 out:
 	release_firmware(scan_fw);
 
-- 
2.17.1

