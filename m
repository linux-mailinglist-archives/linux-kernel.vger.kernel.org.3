Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CF507D21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358479AbiDSXUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358441AbiDSXT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:19:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0481439160
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650410227; x=1681946227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RY21wbLaxMQpuNcSRjhYTPl5nghgFBt6ua08w/utDcE=;
  b=ZJXHuQcnc3mT1gShXO087ICtpjEqEWCPaNkfVJ5pELwGi3GMWKQnwbtM
   gHQrPi9mPAclfnmr0S2xG2o4OnMExCiVNqUOqCIRT+jJ22n0G/kdpSJ6I
   WicNDrD/dltH38QmvGNxchsvYKCCZTiAUhVPn6xeIMWY4OcvmSs5J2DNy
   4IWvYxn9JajNZL8YMlVOa/r1tzuMD2/yvKHVNJl+O4N04EAHZbdJ4YNct
   8GRTI0swe6le5tRjJRWLwY28UabXNiPK+cA6KvCVbC9oR00rjpLEhzL4w
   opiZ/fO23SDZAt3c1+rpwyBSoVg45ugcLCS/vqlhHILa/c0aKqlVCo5ZN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263656661"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263656661"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:17:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="862277782"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.68.17])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:17:05 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 6/8] test_firmware: Add test support for firmware upload
Date:   Tue, 19 Apr 2022 16:16:56 -0700
Message-Id: <20220419231658.664388-7-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419231658.664388-1-russell.h.weight@intel.com>
References: <20220419231658.664388-1-russell.h.weight@intel.com>
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

Add support for testing the firmware upload driver. There are four sysfs
nodes added:

upload_register: write-only
  Write the name of the firmware device node to be created

upload_unregister: write-only
  Write the name of the firmware device node to be destroyed

config_upload_name: read/write
  Set the name to be used by upload_read

upload_read: read-only
  Read back the data associated with the firmware device node named
  in config_upload_name

You can create multiple, concurrent firmware device nodes for firmware
upload testing. Read firmware back and validate it using config_upload_name
and upload_red.

Example:
    $ cd /sys/devices/virtual/misc/test_firmware
    $ echo -n fw1 > upload_register
    $ ls fw1
    cancel  data  device  error  loading  power  remaining_size  status
    subsystem  uevent
    $ dd if=/dev/urandom of=/tmp/random-firmware.bin bs=512 count=4
    4+0 records in
    4+0 records out
    2048 bytes (2.0 kB, 2.0 KiB) copied, 0.000131959 s, 15.5 MB/s
    $ echo 1 > fw1/loading
    $ cat /tmp/random-firmware.bin > fw1/data
    $ echo 0 > fw1/loading
    $ cat fw1/status
    idle
    $ cat fw1/error
    $ echo -n fw1 > config_upload_name
    $ cmp /tmp/random-firmware.bin upload_read
    $ echo $?
    0
    $ echo -n fw1 > upload_unregister

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - No changes from v1
v3:
  - Added Reviewed-by tag
v4:
  - Added Reviewed-by tag
---
 lib/test_firmware.c | 261 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 1bccd6cd5f48..2b8c56d7bf37 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -31,9 +31,12 @@ MODULE_IMPORT_NS(TEST_FIRMWARE);
 #define TEST_FIRMWARE_NAME	"test-firmware.bin"
 #define TEST_FIRMWARE_NUM_REQS	4
 #define TEST_FIRMWARE_BUF_SIZE	SZ_1K
+#define TEST_UPLOAD_MAX_SIZE	SZ_2K
+#define TEST_UPLOAD_BLK_SIZE	37	/* Avoid powers of two in testing */
 
 static DEFINE_MUTEX(test_fw_mutex);
 static const struct firmware *test_firmware;
+static LIST_HEAD(test_upload_list);
 
 struct test_batched_req {
 	u8 idx;
@@ -63,6 +66,7 @@ struct test_batched_req {
  * @reqs: stores all requests information
  * @read_fw_idx: index of thread from which we want to read firmware results
  *	from through the read_fw trigger.
+ * @upload_name: firmware name to be used with upload_read sysfs node
  * @test_result: a test may use this to collect the result from the call
  *	of the request_firmware*() calls used in their tests. In order of
  *	priority we always keep first any setup error. If no setup errors were
@@ -101,6 +105,7 @@ struct test_config {
 	bool send_uevent;
 	u8 num_requests;
 	u8 read_fw_idx;
+	char *upload_name;
 
 	/*
 	 * These below don't belong her but we'll move them once we create
@@ -112,8 +117,28 @@ struct test_config {
 			    struct device *device);
 };
 
+struct test_firmware_upload {
+	char *name;
+	struct list_head node;
+	char *buf;
+	size_t size;
+	bool cancel_request;
+	struct fw_upload *fwl;
+};
+
 static struct test_config *test_fw_config;
 
+static struct test_firmware_upload *upload_lookup_name(const char *name)
+{
+	struct test_firmware_upload *tst;
+
+	list_for_each_entry(tst, &test_upload_list, node)
+		if (strncmp(name, tst->name, strlen(tst->name)) == 0)
+			return tst;
+
+	return NULL;
+}
+
 static ssize_t test_fw_misc_read(struct file *f, char __user *buf,
 				 size_t size, loff_t *offset)
 {
@@ -198,6 +223,7 @@ static int __test_firmware_config_init(void)
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
 	test_fw_config->reqs = NULL;
+	test_fw_config->upload_name = NULL;
 
 	return 0;
 
@@ -277,6 +303,13 @@ static ssize_t config_show(struct device *dev,
 			test_fw_config->sync_direct ? "true" : "false");
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"read_fw_idx:\t%u\n", test_fw_config->read_fw_idx);
+	if (test_fw_config->upload_name)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				"upload_name:\t%s\n",
+				test_fw_config->upload_name);
+	else
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				"upload_name:\tEMTPY\n");
 
 	mutex_unlock(&test_fw_mutex);
 
@@ -392,6 +425,32 @@ static ssize_t config_name_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(config_name);
 
+static ssize_t config_upload_name_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct test_firmware_upload *tst;
+	int ret = count;
+
+	mutex_lock(&test_fw_mutex);
+	tst = upload_lookup_name(buf);
+	if (tst)
+		test_fw_config->upload_name = tst->name;
+	else
+		ret = -EINVAL;
+	mutex_unlock(&test_fw_mutex);
+
+	return ret;
+}
+
+static ssize_t config_upload_name_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return config_test_show_str(buf, test_fw_config->upload_name);
+}
+static DEVICE_ATTR_RW(config_upload_name);
+
 static ssize_t config_num_requests_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
@@ -989,6 +1048,167 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_batched_requests_async);
 
+static void upload_release(struct test_firmware_upload *tst)
+{
+	firmware_upload_unregister(tst->fwl);
+	kfree(tst->buf);
+	kfree(tst->name);
+	kfree(tst);
+}
+
+static void upload_release_all(void)
+{
+	struct test_firmware_upload *tst, *tmp;
+
+	list_for_each_entry_safe(tst, tmp, &test_upload_list, node) {
+		list_del(&tst->node);
+		upload_release(tst);
+	}
+	test_fw_config->upload_name = NULL;
+}
+
+static enum fw_upload_err test_fw_upload_prepare(struct fw_upload *fwl,
+						 const u8 *data, u32 size)
+{
+	struct test_firmware_upload *tst = fwl->dd_handle;
+
+	tst->cancel_request = false;
+
+	if (!size || size > TEST_UPLOAD_MAX_SIZE)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	memset(tst->buf, 0, TEST_UPLOAD_MAX_SIZE);
+	tst->size = size;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err test_fw_upload_write(struct fw_upload *fwl,
+					       const u8 *data, u32 offset,
+					       u32 size, u32 *written)
+{
+	struct test_firmware_upload *tst = fwl->dd_handle;
+	u32 blk_size;
+
+	if (tst->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	blk_size = min_t(u32, TEST_UPLOAD_BLK_SIZE, size);
+	memcpy(tst->buf + offset, data + offset, blk_size);
+
+	*written = blk_size;
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err test_fw_upload_complete(struct fw_upload *fwl)
+{
+	struct test_firmware_upload *tst = fwl->dd_handle;
+
+	if (tst->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void test_fw_upload_cancel(struct fw_upload *fwl)
+{
+	struct test_firmware_upload *tst = fwl->dd_handle;
+
+	tst->cancel_request = true;
+}
+
+static const struct fw_upload_ops upload_test_ops = {
+	.prepare = test_fw_upload_prepare,
+	.write = test_fw_upload_write,
+	.poll_complete = test_fw_upload_complete,
+	.cancel = test_fw_upload_cancel,
+};
+
+static ssize_t upload_register_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct test_firmware_upload *tst;
+	struct fw_upload *fwl;
+	char *name;
+	int ret;
+
+	name = kstrndup(buf, count, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	mutex_lock(&test_fw_mutex);
+	tst = upload_lookup_name(name);
+	if (tst) {
+		ret = -EEXIST;
+		goto free_name;
+	}
+
+	tst = kzalloc(sizeof(*tst), GFP_KERNEL);
+	if (!tst) {
+		ret = -ENOMEM;
+		goto free_name;
+	}
+
+	tst->name = name;
+	tst->buf = kzalloc(TEST_UPLOAD_MAX_SIZE, GFP_KERNEL);
+	if (!tst->buf) {
+		ret = -ENOMEM;
+		goto free_tst;
+	}
+
+	fwl = firmware_upload_register(THIS_MODULE, dev, tst->name,
+				       &upload_test_ops, tst);
+	if (IS_ERR(fwl)) {
+		ret = PTR_ERR(fwl);
+		goto free_buf;
+	}
+
+	tst->fwl = fwl;
+	list_add_tail(&tst->node, &test_upload_list);
+	mutex_unlock(&test_fw_mutex);
+	return count;
+
+free_buf:
+	kfree(tst->buf);
+
+free_tst:
+	kfree(tst);
+
+free_name:
+	mutex_unlock(&test_fw_mutex);
+	kfree(name);
+
+	return ret;
+}
+static DEVICE_ATTR_WO(upload_register);
+
+static ssize_t upload_unregister_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct test_firmware_upload *tst;
+	int ret = count;
+
+	mutex_lock(&test_fw_mutex);
+	tst = upload_lookup_name(buf);
+	if (!tst) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (test_fw_config->upload_name == tst->name)
+		test_fw_config->upload_name = NULL;
+
+	list_del(&tst->node);
+	upload_release(tst);
+
+out:
+	mutex_unlock(&test_fw_mutex);
+	return ret;
+}
+static DEVICE_ATTR_WO(upload_unregister);
+
 static ssize_t test_result_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -1051,6 +1271,42 @@ static ssize_t read_firmware_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(read_firmware);
 
+static ssize_t upload_read_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct test_firmware_upload *tst;
+	int ret = -EINVAL;
+
+	if (!test_fw_config->upload_name) {
+		pr_err("Set config_upload_name before using upload_read\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&test_fw_mutex);
+	list_for_each_entry(tst, &test_upload_list, node)
+		if (tst->name == test_fw_config->upload_name)
+			break;
+
+	if (tst->name != test_fw_config->upload_name) {
+		pr_err("Firmware name not found: %s\n",
+		       test_fw_config->upload_name);
+		goto out;
+	}
+
+	if (tst->size > PAGE_SIZE) {
+		pr_err("Testing interface must use PAGE_SIZE firmware for now\n");
+		goto out;
+	}
+
+	memcpy(buf, tst->buf, tst->size);
+	ret = tst->size;
+out:
+	mutex_unlock(&test_fw_mutex);
+	return ret;
+}
+static DEVICE_ATTR_RO(upload_read);
+
 #define TEST_FW_DEV_ATTR(name)          &dev_attr_##name.attr
 
 static struct attribute *test_dev_attrs[] = {
@@ -1066,6 +1322,7 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(config_sync_direct),
 	TEST_FW_DEV_ATTR(config_send_uevent),
 	TEST_FW_DEV_ATTR(config_read_fw_idx),
+	TEST_FW_DEV_ATTR(config_upload_name),
 
 	/* These don't use the config at all - they could be ported! */
 	TEST_FW_DEV_ATTR(trigger_request),
@@ -1082,6 +1339,9 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(release_all_firmware),
 	TEST_FW_DEV_ATTR(test_result),
 	TEST_FW_DEV_ATTR(read_firmware),
+	TEST_FW_DEV_ATTR(upload_read),
+	TEST_FW_DEV_ATTR(upload_register),
+	TEST_FW_DEV_ATTR(upload_unregister),
 	NULL,
 };
 
@@ -1128,6 +1388,7 @@ static void __exit test_firmware_exit(void)
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
 	misc_deregister(&test_fw_misc_device);
+	upload_release_all();
 	__test_firmware_config_free();
 	kfree(test_fw_config);
 	mutex_unlock(&test_fw_mutex);
-- 
2.25.1

