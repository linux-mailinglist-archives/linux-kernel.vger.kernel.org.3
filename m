Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AAD4C5EE3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiB0U52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiB0U5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD8656D192
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D9241063;
        Sun, 27 Feb 2022 12:56:33 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E27883F66F;
        Sun, 27 Feb 2022 12:56:31 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 07/16] debugfs: Add signed versions of debugfs_create_u32/64 helpers
Date:   Sun, 27 Feb 2022 20:55:59 +0000
Message-Id: <20220227205608.30812-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few helpers to deal with signed values integers; built on existing
debugfs internal helpers as the existing unsigned functions already do.

Make the simple_attr_write() internal helper detect the sign of the
requested set operation from the related format string: this is needed
to be able to properly parse negatively signed input strings.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Note that in the rest of the series I do NOT need the s64 WRITE/SET
operations, that required the more invasive simple_attr_write() change,
but it seemed odd to implement a get only debug_create_s32/64 API.
---
 fs/debugfs/file.c       | 74 +++++++++++++++++++++++++++++++++++++++++
 fs/libfs.c              | 12 +++++--
 include/linux/debugfs.h |  4 +++
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 950c63fa4d0b..5363b12c3dcb 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -556,6 +556,80 @@ void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u64);
 
+static int debugfs_s32_set(void *data, u64 val)
+{
+	*(s32 *)data = val;
+	return 0;
+}
+
+static int debugfs_s32_get(void *data, u64 *val)
+{
+	*val = *(s32 *)data;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_s32, debugfs_s32_get, debugfs_s32_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_s32_ro, debugfs_s32_get, NULL, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_s32_wo, NULL, debugfs_s32_set, "%lld\n");
+
+/**
+ * debugfs_create_s32 - create a debugfs file that is used to read and write an signed 32-bit value
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ */
+void debugfs_create_s32(const char *name, umode_t mode, struct dentry *parent,
+			s32 *value)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_s32,
+				   &fops_s32_ro, &fops_s32_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_s32);
+
+static int debugfs_s64_set(void *data, u64 val)
+{
+	*(s64 *)data = val;
+	return 0;
+}
+
+static int debugfs_s64_get(void *data, u64 *val)
+{
+	*val = *(s64 *)data;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(fops_s64, debugfs_s64_get, debugfs_s64_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_s64_ro, debugfs_s64_get, NULL, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_s64_wo, NULL, debugfs_s64_set, "%lld\n");
+
+/**
+ * debugfs_create_s64 - create a debugfs file that is used to read and write a signed 64-bit value
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ */
+void debugfs_create_s64(const char *name, umode_t mode, struct dentry *parent,
+			s64 *value)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_s64,
+				   &fops_s64_ro, &fops_s64_wo);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_s64);
+
 static int debugfs_ulong_set(void *data, u64 val)
 {
 	*(unsigned long *)data = val;
diff --git a/fs/libfs.c b/fs/libfs.c
index ba7438ab9371..f5a554ed363b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -917,8 +917,8 @@ EXPORT_SYMBOL(simple_transaction_release);
 struct simple_attr {
 	int (*get)(void *, u64 *);
 	int (*set)(void *, u64);
-	char get_buf[24];	/* enough to store a u64 and "\n\0" */
-	char set_buf[24];
+	char get_buf[25];	/* enough to store a u64, a sign and "\n\0" */
+	char set_buf[25];
 	void *data;
 	const char *fmt;	/* format for read operation */
 	struct mutex mutex;	/* protects access to these buffers */
@@ -1001,6 +1001,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 	unsigned long long val;
 	size_t size;
 	ssize_t ret;
+	char *_fmt;
 
 	attr = file->private_data;
 	if (!attr->set)
@@ -1016,7 +1017,12 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 		goto out;
 
 	attr->set_buf[size] = '\0';
-	ret = kstrtoull(attr->set_buf, 0, &val);
+	_fmt = strchr(attr->fmt, '%');
+	/* Deduce signedness from read format string specifier */
+	if (_fmt &&  (strchr(_fmt, 'd') || strchr(_fmt, 'i')))
+		ret = kstrtoll(attr->set_buf, 0, (long long *)&val);
+	else
+		ret = kstrtoull(attr->set_buf, 0, &val);
 	if (ret)
 		goto out;
 	ret = attr->set(attr->data, val);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c869f1e73d75..1b8ea858f261 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -114,6 +114,10 @@ void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
 			u64 *value);
 void debugfs_create_ulong(const char *name, umode_t mode, struct dentry *parent,
 			  unsigned long *value);
+void debugfs_create_s32(const char *name, umode_t mode, struct dentry *parent,
+			s32 *value);
+void debugfs_create_s64(const char *name, umode_t mode, struct dentry *parent,
+			s64 *value);
 void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
 		       u8 *value);
 void debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent,
-- 
2.17.1

