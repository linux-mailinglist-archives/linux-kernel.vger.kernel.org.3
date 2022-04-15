Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB85A502F82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351344AbiDOULc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351201AbiDOULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:11:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413CEDB4B2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650053319; x=1681589319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q2HZAqyWTr9UkKMgXRNvffhCaeOGw+m6qpTfjr33qko=;
  b=kYATqVuKDtGx019ID2uquj8sPoeB/7No7EU38NarZu1RKqKWKn6aos+C
   G/OhpibBZkXTJx5dci4DN2n03KzgYPo13ipqvhXKTNn2GlgKiKHqmU+2H
   oPgdZ9apqY6eNLcGL1I0KnB8wAbomA/VaCEIJ+X6L6Uy5D9KjQoQRXGP8
   5ND5NkIUgI9rqlFfHRZIL8oPr+/NPCN5+fOx3cCsXp+tCS3D5wq5nygOV
   10HPjiUxGDOmKMOVdEwLVvHqvMuah2/XlRge7LZrgluVyWH+FSx60vJxe
   pLCFGYb1buMofxbd4/pzlkEySbhT6Q9TswVqXM9W+ZJAlIVFLEs21Xd8h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262078957"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="262078957"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:08:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="574510718"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.98.156])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:08:11 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 7/8] test_firmware: Error injection for firmware upload
Date:   Fri, 15 Apr 2022 13:08:04 -0700
Message-Id: <20220415200805.610339-8-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415200805.610339-1-russell.h.weight@intel.com>
References: <20220415200805.610339-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error injection capability to the test_firmware module specifically
for firmware upload testing. Error injection instructions are transferred
as the first part of the firmware payload. The format of an error
injection string is similar to the error strings that may be read from
the error sysfs node.

To inject the error "programming:hw-error", one would use the error
injection string "inject:programming:hw-error" as the firmware payload:

$ echo 1 > loading
$ echo inject:programming:hw-error > data
$ echo 0 > loading
$ cat status
idle
$ cat error
programming:hw-error

The first part of the error string is the progress state of the upload at
the time of the error. The progress state would be one of the following:
"preparing", "transferring", or "programming". The second part of the
error string is one of the following: "hw-error", "timeout", "device-busy",
"invalid-file-size", "read-write-error", "flash-wearout", and "user-abort".

Note that all of the error strings except "user-abort" will fail without
delay. The "user-abort" error will cause the firmware upload to stall at
the requested progress state for up to 5 minutes to allow you to echo 1
to the cancel sysfs node. It is this cancellation that causes the
'user-abort" error. If the upload is not cancelled within the 5 minute
time period, then the upload will complete without an error.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - No changes from v1
---
 lib/test_firmware.c | 127 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 5 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 2b8c56d7bf37..76115c1a2629 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -117,12 +117,18 @@ struct test_config {
 			    struct device *device);
 };
 
+struct upload_inject_err {
+	const char *prog;
+	enum fw_upload_err err_code;
+};
+
 struct test_firmware_upload {
 	char *name;
 	struct list_head node;
 	char *buf;
 	size_t size;
 	bool cancel_request;
+	struct upload_inject_err inject;
 	struct fw_upload *fwl;
 };
 
@@ -1067,20 +1073,105 @@ static void upload_release_all(void)
 	test_fw_config->upload_name = NULL;
 }
 
+/*
+ * This table is replicated from .../firmware_loader/sysfs_upload.c
+ * and needs to be kept in sync.
+ */
+static const char * const fw_upload_err_str[] = {
+	[FW_UPLOAD_ERR_NONE]	     = "none",
+	[FW_UPLOAD_ERR_HW_ERROR]     = "hw-error",
+	[FW_UPLOAD_ERR_TIMEOUT]	     = "timeout",
+	[FW_UPLOAD_ERR_CANCELED]     = "user-abort",
+	[FW_UPLOAD_ERR_BUSY]	     = "device-busy",
+	[FW_UPLOAD_ERR_INVALID_SIZE] = "invalid-file-size",
+	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
+	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
+};
+
+static void upload_err_inject_error(struct test_firmware_upload *tst,
+				    const u8 *p, const char *prog)
+{
+	enum fw_upload_err err;
+
+	for (err = FW_UPLOAD_ERR_NONE + 1; err < FW_UPLOAD_ERR_MAX; err++) {
+		if (strncmp(p, fw_upload_err_str[err],
+			    strlen(fw_upload_err_str[err])) == 0) {
+			tst->inject.prog = prog;
+			tst->inject.err_code = err;
+			return;
+		}
+	}
+}
+
+static void upload_err_inject_prog(struct test_firmware_upload *tst,
+				   const u8 *p)
+{
+	static const char * const progs[] = {
+		"preparing:", "transferring:", "programming:"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(progs); i++) {
+		if (strncmp(p, progs[i], strlen(progs[i])) == 0) {
+			upload_err_inject_error(tst, p + strlen(progs[i]),
+						progs[i]);
+			return;
+		}
+	}
+}
+
+#define FIVE_MINUTES_MS	(5 * 60 * 1000)
+static enum fw_upload_err
+fw_upload_wait_on_cancel(struct test_firmware_upload *tst)
+{
+	int ms_delay;
+
+	for (ms_delay = 0; ms_delay < FIVE_MINUTES_MS; ms_delay += 100) {
+		msleep(100);
+		if (tst->cancel_request)
+			return FW_UPLOAD_ERR_CANCELED;
+	}
+	return FW_UPLOAD_ERR_NONE;
+}
+
 static enum fw_upload_err test_fw_upload_prepare(struct fw_upload *fwl,
 						 const u8 *data, u32 size)
 {
 	struct test_firmware_upload *tst = fwl->dd_handle;
+	enum fw_upload_err ret = FW_UPLOAD_ERR_NONE;
+	const char *progress = "preparing:";
 
 	tst->cancel_request = false;
 
-	if (!size || size > TEST_UPLOAD_MAX_SIZE)
-		return FW_UPLOAD_ERR_INVALID_SIZE;
+	if (!size || size > TEST_UPLOAD_MAX_SIZE) {
+		ret = FW_UPLOAD_ERR_INVALID_SIZE;
+		goto err_out;
+	}
+
+	if (strncmp(data, "inject:", strlen("inject:")) == 0)
+		upload_err_inject_prog(tst, data + strlen("inject:"));
 
 	memset(tst->buf, 0, TEST_UPLOAD_MAX_SIZE);
 	tst->size = size;
 
-	return FW_UPLOAD_ERR_NONE;
+	if (tst->inject.err_code == FW_UPLOAD_ERR_NONE ||
+	    strncmp(tst->inject.prog, progress, strlen(progress)) != 0)
+		return FW_UPLOAD_ERR_NONE;
+
+	if (tst->inject.err_code == FW_UPLOAD_ERR_CANCELED)
+		ret = fw_upload_wait_on_cancel(tst);
+	else
+		ret = tst->inject.err_code;
+
+err_out:
+	/*
+	 * The cleanup op only executes if the prepare op succeeds.
+	 * If the prepare op fails, it must do it's own clean-up.
+	 */
+	tst->inject.err_code = FW_UPLOAD_ERR_NONE;
+	tst->inject.prog = NULL;
+
+	return ret;
 }
 
 static enum fw_upload_err test_fw_upload_write(struct fw_upload *fwl,
@@ -1088,6 +1179,7 @@ static enum fw_upload_err test_fw_upload_write(struct fw_upload *fwl,
 					       u32 size, u32 *written)
 {
 	struct test_firmware_upload *tst = fwl->dd_handle;
+	const char *progress = "transferring:";
 	u32 blk_size;
 
 	if (tst->cancel_request)
@@ -1097,17 +1189,33 @@ static enum fw_upload_err test_fw_upload_write(struct fw_upload *fwl,
 	memcpy(tst->buf + offset, data + offset, blk_size);
 
 	*written = blk_size;
-	return FW_UPLOAD_ERR_NONE;
+
+	if (tst->inject.err_code == FW_UPLOAD_ERR_NONE ||
+	    strncmp(tst->inject.prog, progress, strlen(progress)) != 0)
+		return FW_UPLOAD_ERR_NONE;
+
+	if (tst->inject.err_code == FW_UPLOAD_ERR_CANCELED)
+		return fw_upload_wait_on_cancel(tst);
+
+	return tst->inject.err_code;
 }
 
 static enum fw_upload_err test_fw_upload_complete(struct fw_upload *fwl)
 {
 	struct test_firmware_upload *tst = fwl->dd_handle;
+	const char *progress = "programming:";
 
 	if (tst->cancel_request)
 		return FW_UPLOAD_ERR_CANCELED;
 
-	return FW_UPLOAD_ERR_NONE;
+	if (tst->inject.err_code == FW_UPLOAD_ERR_NONE ||
+	    strncmp(tst->inject.prog, progress, strlen(progress)) != 0)
+		return FW_UPLOAD_ERR_NONE;
+
+	if (tst->inject.err_code == FW_UPLOAD_ERR_CANCELED)
+		return fw_upload_wait_on_cancel(tst);
+
+	return tst->inject.err_code;
 }
 
 static void test_fw_upload_cancel(struct fw_upload *fwl)
@@ -1117,11 +1225,20 @@ static void test_fw_upload_cancel(struct fw_upload *fwl)
 	tst->cancel_request = true;
 }
 
+static void test_fw_cleanup(struct fw_upload *fwl)
+{
+	struct test_firmware_upload *tst = fwl->dd_handle;
+
+	tst->inject.err_code = FW_UPLOAD_ERR_NONE;
+	tst->inject.prog = NULL;
+}
+
 static const struct fw_upload_ops upload_test_ops = {
 	.prepare = test_fw_upload_prepare,
 	.write = test_fw_upload_write,
 	.poll_complete = test_fw_upload_complete,
 	.cancel = test_fw_upload_cancel,
+	.cleanup = test_fw_cleanup
 };
 
 static ssize_t upload_register_store(struct device *dev,
-- 
2.25.1

