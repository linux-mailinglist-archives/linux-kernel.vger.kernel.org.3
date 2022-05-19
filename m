Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44252C8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiESAsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiESAsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:48:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB9F175A9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:48:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g184so3648975pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmbZQmJ60J52vGDbdJZDIQrFiSF/ywdIcU18sv4WWI0=;
        b=Gyic0NJswXTCbY/HFFUXOrF2Z9yR6/uyw0s3Qsw7gI1Ml68H/SC/V88u/TVMDluI4F
         1FJ45VghnM0j4Ty2WkfK/3xsB3llMyhbuN6s1owSejXxFSkmTBsRhp6rH9OfFzdeoHO+
         w3YS9Wh2LfrbHG/johWMcclcmyaEnZ8YFxbQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmbZQmJ60J52vGDbdJZDIQrFiSF/ywdIcU18sv4WWI0=;
        b=Bl6cf7+zAkltA2Iq4Q3X8OtBlQjKAMBfNldzA6XY60yEFOgBZ9FtLZz36e2kGPiGzA
         t4X39RiRkZUBtCRO2ugmk3suv3jI0zIkl3hnAZ+ffiA6Y6TPYVHx63gXgmxgcrMxQ5P0
         Tz3Ae66agrQoTyVSOs+cR9qe7JiXaalP/X8MlgUj7MRforGhK5Kax4ZbBoLh+55LA7xF
         4lslHJNljn4etOi4REHVjScfnZlaMZf8xjHvaWTMq38y+Y/kNG/I0L3q4bYYFNfx3zYk
         d+t4lMBQ9JHlDDukYMdLHYlcirL26zbscrS66HtzKrZYul0xMgbcEmPaqynHG/jm0uBk
         Gm2w==
X-Gm-Message-State: AOAM532N1I6l/KoQQ1mFRI44yLzv7VB83a/0Dlf6096b3ClHvub75Zal
        fvdrMK6HE+ggUBhas1E08IMasQ==
X-Google-Smtp-Source: ABdhPJzxV3GGvRm2RPpNFFPrfQU0jq4on2fD0h+tI2IIuH2sHbAH4kWz9FV1y8/hAnYdxWz/PZbCPg==
X-Received: by 2002:a05:6a00:1946:b0:4fe:309f:d612 with SMTP id s6-20020a056a00194600b004fe309fd612mr2086612pfk.10.1652921280281;
        Wed, 18 May 2022 17:48:00 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e229:79ea:227e:d9dd])
        by smtp.gmail.com with UTF8SMTPSA id b3-20020a170902bd4300b0015e8d4eb1f9sm2282488plx.67.2022.05.18.17.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 17:48:00 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Milan Broz <gmazyland@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 2/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Wed, 18 May 2022 17:47:53 -0700
Message-Id: <20220518174739.v5.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519004754.2174254-1-mka@chromium.org>
References: <20220519004754.2174254-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend LoadPin to allow loading of kernel files from trusted dm-verity [1]
devices.

This change adds the concept of trusted verity devices to LoadPin. LoadPin
maintains a list of root digests of verity devices it considers trusted.
Userspace can populate this list through an ioctl on the new LoadPin
securityfs entry 'dm-verity'. The ioctl receives a file descriptor of
a file with verity digests as parameter. Verity reads the digests from
this file after confirming that the file is located on the pinned root.
The digest file must contain one digest per line. The list of trusted
digests can only be set up once, which is typically done at boot time.

When a kernel file is read LoadPin first checks (as usual) whether the file
is located on the pinned root, if so the file can be loaded. Otherwise, if
the verity extension is enabled, LoadPin determines whether the file is
located on a verity backed device and whether the root digest of that
device is in the list of trusted digests. The file can be loaded if the
verity device has a trusted root digest.

Background:

As of now LoadPin restricts loading of kernel files to a single pinned
filesystem, typically the rootfs. This works for many systems, however it
can result in a bloated rootfs (and OTA updates) on platforms where
multiple boards with different hardware configurations use the same rootfs
image. Especially when 'optional' files are large it may be preferable to
download/install them only when they are actually needed by a given board.
Chrome OS uses Downloadable Content (DLC) [2] to deploy certain 'packages'
at runtime. As an example a DLC package could contain firmware for a
peripheral that is not present on all boards. DLCs use dm-verity to verify
the integrity of the DLC content.

[1] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html
[2] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
---

Changes in v5:
- call dm_verity_loadpin_is_sb_trusted() instead of
  dm_verity_loadpin_is_bdev_trusted()
- added 'Acked-by' tag from Kees

Changes in v4:
- use newline as separator in digest file instead of comma
- after reading an invalid/corrupt digest file deny further attempts
  of setting up the list of digests
- added comment to read_trusted_verity_root_digests() explaining that
  an invalid digests entry invalidates the entire list of digests
- refactored read_trusted_verity_root_digests() to avoid cast of 'data' at
  assignment
- add the format of the digest file and the path of the securityfs
  attribute to the ioctl comment.
- adapted to struct trusted_root_digest with unsized array 'data'
- call dm_verity_loadpin_is_sb_trusted() instead of
  loadpin_is_fs_trusted()
- deleted loadpin_is_fs_trusted()
- use '%ld' in format string for PTR_ERR()
- added note about digest file format to the commit message

Changes in v3:
- added securityfs for LoadPin (currently only populated when
  CONFIG_SECURITY_LOADPIN_VERITY=y)
- added uapi include for LoadPin
- changed the interface for setting up the list of trusted
  digests from sysctl to ioctl on securityfs entry
- added stub for loadpin_is_fs_trusted() to be used
  CONFIG_SECURITY_LOADPIN_VERITY is not select
- depend on CONFIG_SECURITYFS instead of CONFIG_SYSTCL
- updated Kconfig help
- minor changes in read_trusted_verity_root_digests()
- updated commit message

Changes in v2:
- userspace now passes the path of the file with the verity digests
  via systcl, instead of the digests themselves
- renamed sysctl file to 'trusted_verity_root_digests_path'
- have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
- updated Kconfig doc
- updated commit message

 include/uapi/linux/loadpin.h |  22 +++++
 security/loadpin/Kconfig     |  16 ++++
 security/loadpin/loadpin.c   | 167 ++++++++++++++++++++++++++++++++++-
 3 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/loadpin.h

diff --git a/include/uapi/linux/loadpin.h b/include/uapi/linux/loadpin.h
new file mode 100644
index 000000000000..daa6dbb8bb02
--- /dev/null
+++ b/include/uapi/linux/loadpin.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2022, Google LLC
+ */
+
+#ifndef _UAPI_LINUX_LOOP_LOADPIN_H
+#define _UAPI_LINUX_LOOP_LOADPIN_H
+
+#define LOADPIN_IOC_MAGIC	'L'
+
+/**
+ * LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS - Set up the root digests of verity devices
+ *                                          that loadpin should trust.
+ *
+ * Takes a file descriptor from which to read the root digests of trusted verity devices. The file
+ * is expected to contain a list of digests in ASCII format, with one line per digest. The ioctl
+ * must be issued on the securityfs attribute 'loadpin/dm-verity' (which can be typically found
+ * under /sys/kernel/security/loadpin/dm-verity).
+ */
+#define LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS _IOW(LOADPIN_IOC_MAGIC, 0x00, unsigned int)
+
+#endif /* _UAPI_LINUX_LOOP_LOADPIN_H */
diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 91be65dec2ab..e319ca8e3f3d 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -18,3 +18,19 @@ config SECURITY_LOADPIN_ENFORCE
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter
 	  "loadpin.enforce=1".
+
+config SECURITY_LOADPIN_VERITY
+	bool "Allow reading files from certain other filesystems that use dm-verity"
+	depends on DM_VERITY=y && SECURITYFS
+	help
+	  If selected LoadPin can allow reading files from filesystems
+	  that use dm-verity. LoadPin maintains a list of verity root
+	  digests it considers trusted. A verity backed filesystem is
+	  considered trusted if its root digest is found in the list
+	  of trusted digests.
+
+	  The list of trusted verity can be populated through an ioctl
+	  on the LoadPin securityfs entry 'dm-verity'. The ioctl
+	  expects a file descriptor of a file with verity digests as
+	  parameter. The file must be located on the pinned root and
+	  contain a comma separated list of digests.
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..c530f0dd2297 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -18,6 +18,8 @@
 #include <linux/path.h>
 #include <linux/sched.h>	/* current */
 #include <linux/string_helpers.h>
+#include <linux/dm-verity-loadpin.h>
+#include <uapi/linux/loadpin.h>
 
 static void report_load(const char *origin, struct file *file, char *operation)
 {
@@ -43,6 +45,9 @@ static char *exclude_read_files[READING_MAX_ID];
 static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
 static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+static bool deny_reading_verity_digests;
+#endif
 
 #ifdef CONFIG_SYSCTL
 
@@ -174,7 +179,8 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
 		spin_unlock(&pinned_root_spinlock);
 	}
 
-	if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
+	if (IS_ERR_OR_NULL(pinned_root) ||
+	    ((load_root != pinned_root) && !dm_verity_loadpin_is_bdev_trusted(load_root->s_bdev))) {
 		if (unlikely(!enforce)) {
 			report_load(origin, file, "pinning-ignored");
 			return 0;
@@ -240,6 +246,7 @@ static int __init loadpin_init(void)
 		enforce ? "" : "not ");
 	parse_exclude();
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+
 	return 0;
 }
 
@@ -248,6 +255,164 @@ DEFINE_LSM(loadpin) = {
 	.init = loadpin_init,
 };
 
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+
+enum loadpin_securityfs_interface_index {
+	LOADPIN_DM_VERITY,
+};
+
+static int read_trusted_verity_root_digests(unsigned int fd)
+{
+	struct fd f;
+	void *data;
+	int rc;
+	char *p, *d;
+
+	if (deny_reading_verity_digests)
+		return -EPERM;
+
+	/* The list of trusted root digests can only be set up once */
+	if (!list_empty(&loadpin_trusted_verity_root_digests))
+		return -EPERM;
+
+	f = fdget(fd);
+	if (!f.file)
+		return -EINVAL;
+
+	data = kzalloc(SZ_4K, GFP_KERNEL);
+	if (!data) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	rc = kernel_read_file(f.file, 0, (void **)&data, SZ_4K - 1, NULL, READING_POLICY);
+	if (rc < 0)
+		goto err;
+
+	p = data;
+	p[rc] = '\0';
+	p = strim(p);
+
+	p = strim(data);
+	while ((d = strsep(&p, "\n")) != NULL) {
+		int len = strlen(d);
+		struct trusted_root_digest *trd;
+
+		if (len % 2) {
+			rc = -EPROTO;
+			goto err;
+		}
+
+		len /= 2;
+
+		trd = kzalloc(struct_size(trd, data, len), GFP_KERNEL);
+		if (!trd) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		if (hex2bin(trd->data, d, len)) {
+			kfree(trd);
+			rc = -EPROTO;
+			goto err;
+		}
+
+		trd->len = len;
+
+		list_add_tail(&trd->node, &loadpin_trusted_verity_root_digests);
+	}
+
+	if (list_empty(&loadpin_trusted_verity_root_digests)) {
+		rc = -EPROTO;
+		goto err;
+	}
+
+	kfree(data);
+	fdput(f);
+
+	return 0;
+
+err:
+	kfree(data);
+
+	/* any failure in loading/parsing invalidates the entire list */
+	{
+		struct trusted_root_digest *trd, *tmp;
+
+		list_for_each_entry_safe(trd, tmp, &loadpin_trusted_verity_root_digests, node) {
+			list_del(&trd->node);
+			kfree(trd);
+		}
+	}
+
+	/* disallow further attempts after reading a corrupt/invalid file */
+	deny_reading_verity_digests = true;
+
+	fdput(f);
+
+	return rc;
+}
+
+/******************************** securityfs ********************************/
+
+static long dm_verity_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	void __user *uarg = (void __user *)arg;
+	unsigned int fd;
+	int rc;
+
+	switch (cmd) {
+	case LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS:
+		rc = copy_from_user(&fd, uarg, sizeof(fd));
+		if (rc)
+			return rc;
+
+		return read_trusted_verity_root_digests(fd);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations loadpin_dm_verity_ops = {
+	.unlocked_ioctl = dm_verity_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+/**
+ * init_loadpin_securityfs - create the securityfs directory for LoadPin
+ *
+ * We can not put this method normally under the loadpin_init() code path since
+ * the security subsystem gets initialized before the vfs caches.
+ *
+ * Returns 0 if the securityfs directory creation was successful.
+ */
+static int __init init_loadpin_securityfs(void)
+{
+	struct dentry *loadpin_dir, *dentry;
+
+	loadpin_dir = securityfs_create_dir("loadpin", NULL);
+	if (IS_ERR(loadpin_dir)) {
+		pr_err("LoadPin: could not create securityfs dir: %ld\n",
+		       PTR_ERR(loadpin_dir));
+		return PTR_ERR(loadpin_dir);
+	}
+
+	dentry = securityfs_create_file("dm-verity", 0600, loadpin_dir,
+					(void *)LOADPIN_DM_VERITY, &loadpin_dm_verity_ops);
+	if (IS_ERR(dentry)) {
+		pr_err("LoadPin: could not create securityfs entry 'dm-verity': %ld\n",
+		       PTR_ERR(dentry));
+		return PTR_ERR(dentry);
+	}
+
+	return 0;
+}
+
+fs_initcall(init_loadpin_securityfs);
+
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.36.1.124.g0e6072fb45-goog

