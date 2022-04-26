Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D5510B52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355485AbiDZVee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355461AbiDZVe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:34:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602A25587
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:31:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id z21so9441207pgj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNE83scqZXxcJEDYMgDTyuvR1Ggrx94+lQMxMZ/IowU=;
        b=ZKtJ8XGA/SqxhMFiJZUOvHxaI+WraHLnICxfudfiaWADp0gXMDJhi76vjNZeRj9tZn
         HPO35gNJx446gcW6soKp1SYDvLPLJ9HbIPY4+h4LtDlO8B9TI5aL1/cO7fWEK17Ilgcd
         rCf8BKnGHybajm2daHl8zy+7/3CznCm0IdHtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNE83scqZXxcJEDYMgDTyuvR1Ggrx94+lQMxMZ/IowU=;
        b=PH8D8CH7ddnv0Yfc7zEnYpIFnS1ESGvzjfgiSDorlp+Ub4REXyZuWDSN8GVFYatyM3
         yfm2ioDxBPc5Jl7M6G/TnL+AkHOzpd00pvV8xHrADJKp8UYuUyDe3PzRkSgfeTyP33sX
         R1Ej3reTMy0bH1aKSZ7NWqbhowL5FIIWrlw0739ZalOnmSH+mIktxYMiqeIgYJAPI01O
         Yak1tsEm9FbxfAxvikI4JHNfWHA/aw53gWoXFWUOxIs+DRCXJTegXGUciYaQI/tdmSSp
         xTzHK57fwIGrXN22+JT9iwprfj00aeykH1k+OTfSABdmIQhcxLpMwYOIRlnI3JszPzIl
         nJUQ==
X-Gm-Message-State: AOAM530KrMlXZ9h/4O6V0SvoOweL2IiGvX6IkheGOfWfu5Iut+aLoUYG
        mKL/mYQwXhawkZD1Sl7DSYVMhQ==
X-Google-Smtp-Source: ABdhPJyMQWm4GBBd8xOq6MlO1DMwKqAq9qQ61DtlsZ0/uc1Wn8+/SKp/8D2U8jV/KOG4uEk/ZjmK/w==
X-Received: by 2002:a05:6a00:174a:b0:50d:44ca:4b with SMTP id j10-20020a056a00174a00b0050d44ca004bmr10662538pfc.0.1651008679684;
        Tue, 26 Apr 2022 14:31:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb63:4211:eb5d:f6b])
        by smtp.gmail.com with UTF8SMTPSA id pb15-20020a17090b3c0f00b001cd4989ff4esm3587166pjb.21.2022.04.26.14.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 14:31:19 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Song Liu <song@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Tue, 26 Apr 2022 14:31:09 -0700
Message-Id: <20220426143059.v2.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220426213110.3572568-1-mka@chromium.org>
References: <20220426213110.3572568-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend LoadPin to allow loading of kernel files from trusted
dm-verity [1] devices.

This change adds the concept of trusted verity devices to
LoadPin. Userspace can use the new systl file
'loadpin/trusted_verity_root_digests_path' to provide
LoadPin with the path of a file with a list of root digests
from dm-verity devices that LoadPin should consider as
trusted. This file must be located on the pinned root.

When a kernel file is read LoadPin first checks
(as usual) whether the file is located on the pinned root,
if so the file can be loaded. Otherwise, if the verity
extension is enabled, LoadPin determines whether the
file is located on a verity backed device and whether
the root digest of that device is in the list of trusted
digests. The file can be loaded if the verity device has
a trusted root digest.

The path of the file with the trusted root digests can
only be written once, which is typically done at boot time.

Background:

As of now LoadPin restricts loading of kernel files to a single
pinned filesystem, typically the rootfs. This works for many
systems, however it can result in a bloated rootfs (and OTA
updates) on platforms where multiple boards with different
hardware configurations use the same rootfs image. Especially
when 'optional' files are large it may be preferable to
download/install them only when they are actually needed by a
given board. Chrome OS uses Downloadable Content (DLC) [2] to
deploy certain 'packages' at runtime. As an example a DLC
package could contain firmware for a peripheral that is not
present on all boards. DLCs use dm-verity to verify the
integrity of the DLC content.

[1] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html
[2] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
I'm still doubting what would be the best way to configure
the list of trusted digests. The approach in v2 of writing
a path through sysctl is flexible, but it also feels a bit
odd. I did some experiments with passing a file descriptor
through sysctl, but it's also odd and has its own issues.
Passing the list through a kernel parameter seems hacky.
A Kconfig string would work, but can be have issues when
the same config is used for different platforms, where
some may have trusted digests and others not.

Changes in v2:
- userspace now passes the path of the file with the verity digests
  via systcl, instead of the digests themselves
- renamed sysctl file to 'trusted_verity_root_digests_path'
- have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
- updated Kconfig doc
- updated commit message

 security/loadpin/Kconfig   |  16 +++
 security/loadpin/loadpin.c | 200 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 1 deletion(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 91be65dec2ab..20681dc4b8a5 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -18,3 +18,19 @@ config SECURITY_LOADPIN_ENFORCE
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter
 	  "loadpin.enforce=1".
+
+config SECURITY_LOADPIN_VERITY
+	bool "Allow reading files from certain other filesystems that use dm-verity"
+	depends on DM_VERITY=y && SYSCTL
+	help
+	  If selected LoadPin can allow reading files from filesystems
+	  that use dm-verity. LoadPin maintains a list of verity root
+	  digests it considers trusted. A verity backed filesystem is
+	  considered trusted if its root digest is found in the list
+	  of trusted digests.
+
+	  Userspace can populate the list of trusted digests by writing
+	  the path of a file with the digests to the syctl file
+	  'trusted_verity_root_digests_path'. The file must be located
+	  on the pinned root and contain a comma separated list of
+	  digests.
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..db10b7ff6efd 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -18,6 +18,8 @@
 #include <linux/path.h>
 #include <linux/sched.h>	/* current */
 #include <linux/string_helpers.h>
+#include <linux/device-mapper.h>
+#include <linux/dm-verity-loadpin.h>
 
 static void report_load(const char *origin, struct file *file, char *operation)
 {
@@ -43,6 +45,10 @@ static char *exclude_read_files[READING_MAX_ID];
 static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
 static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+static LIST_HEAD(trusted_verity_root_digests);
+static const char *verity_digests_path;
+#endif
 
 #ifdef CONFIG_SYSCTL
 
@@ -65,6 +71,176 @@ static struct ctl_table loadpin_sysctl_table[] = {
 	{ }
 };
 
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+
+static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
+			     bool contents);
+
+static int read_trusted_verity_root_digests(struct file *file)
+{
+	void *data;
+	char *p, *d;
+	int err, rc;
+
+	data = kzalloc(SZ_4K, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	rc = kernel_read_file(file, 0, &data, SZ_4K - 1, NULL, READING_POLICY);
+	if (rc < 0)
+		return rc;
+
+	((char *)data)[rc] = '\0';
+
+	p = strim(data);
+	while ((d = strsep(&p, ",")) != NULL) {
+		int len = strlen(d);
+		struct trusted_root_digest *trd;
+
+		if (len % 2) {
+			err = -EPROTO;
+			goto free_mem;
+		}
+
+		len /= 2;
+
+		trd = kzalloc(sizeof(*trd), GFP_KERNEL);
+		if (!trd) {
+			err = -ENOMEM;
+			goto free_mem;
+		}
+
+		trd->data = kzalloc(len, GFP_KERNEL);
+		if (!trd->data) {
+			kfree(trd);
+			err = -ENOMEM;
+			goto free_mem;
+		}
+
+		if (hex2bin(trd->data, d, len)) {
+			kfree(trd);
+			err = -EPROTO;
+			goto free_mem;
+		}
+
+		list_add_tail(&trd->node, &trusted_verity_root_digests);
+
+		trd->len = len;
+	}
+
+	kfree(data);
+
+	return 0;
+
+free_mem:
+	kfree(data);
+
+	{
+		struct trusted_root_digest *trd, *tmp;
+
+		list_for_each_entry_safe(trd, tmp, &trusted_verity_root_digests, node) {
+			kfree(trd->data);
+			list_del(&trd->node);
+			kfree(trd);
+		}
+	}
+
+	return err;
+}
+
+static int proc_verity_digests(struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tbl = *table;
+
+	if (write) {
+		int rc;
+		char *digests_path;
+		struct file *file;
+
+		if (*ppos)
+			return -EINVAL;
+
+		if (verity_digests_path != NULL)
+			return -EPERM;
+
+		digests_path = kzalloc(tbl.maxlen, GFP_KERNEL);
+		if (!digests_path)
+			return -ENOMEM;
+
+		tbl.data = digests_path;
+
+		rc = proc_dostring(&tbl, write, buffer, lenp, ppos);
+		if (rc) {
+			kfree(digests_path);
+			return rc;
+		}
+
+		/* only absolute paths are allowed */
+		if (digests_path[0] != '/') {
+			kfree(digests_path);
+			return -EINVAL;
+		}
+
+		file = filp_open(digests_path, O_RDONLY, 0);
+		if (IS_ERR(file)) {
+			int err = PTR_ERR(file);
+
+			if (err == -ENOENT) {
+				kfree(digests_path);
+				return -EINVAL;
+			}
+
+			return err;
+		}
+
+		/* verify the root digests stem from a trusted file system */
+		if (loadpin_read_file(file, READING_POLICY, true)) {
+			fput(file);
+			kfree(digests_path);
+			return -EPERM;
+		}
+
+		rc = read_trusted_verity_root_digests(file);
+		fput(file);
+		if (rc) {
+			kfree(digests_path);
+			return rc;
+		}
+
+		verity_digests_path = digests_path;
+	} else {
+		if (verity_digests_path) {
+			tbl.data = kzalloc(strlen(verity_digests_path) + 1, GFP_KERNEL);
+			strcpy(tbl.data, verity_digests_path);
+		} else {
+			tbl.data = kzalloc(1, GFP_KERNEL);
+		}
+
+		proc_dostring(&tbl, write, buffer, lenp, ppos);
+		kfree(tbl.data);
+	}
+
+	return 0;
+}
+
+static struct ctl_table loadpin_sysctl_table_verity_digests[] = {
+	{
+		.procname       = "trusted_verity_root_digests_path",
+		.maxlen         = SZ_256,
+		.mode           = 0644,
+		.proc_handler   = proc_verity_digests,
+	},
+
+	{ }
+};
+
+#else
+
+static struct ctl_table loadpin_sysctl_table_verity_digests[] = {};
+
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+
 /*
  * This must be called after early kernel init, since then the rootdev
  * is available.
@@ -118,6 +294,20 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
 	}
 }
 
+static bool loadpin_is_fs_trusted(struct super_block *sb)
+{
+	struct mapped_device *md = dm_get_md(sb->s_bdev->bd_dev);
+	bool trusted;
+
+	if (!md)
+		return false;
+
+	trusted = dm_verity_loadpin_is_md_trusted(md);
+	dm_put(md);
+
+	return trusted;
+}
+
 static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
 			     bool contents)
 {
@@ -174,7 +364,8 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
 		spin_unlock(&pinned_root_spinlock);
 	}
 
-	if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
+	if (IS_ERR_OR_NULL(pinned_root) ||
+	    ((load_root != pinned_root) && !loadpin_is_fs_trusted(load_root))) {
 		if (unlikely(!enforce)) {
 			report_load(origin, file, "pinning-ignored");
 			return 0;
@@ -240,6 +431,13 @@ static int __init loadpin_init(void)
 		enforce ? "" : "not ");
 	parse_exclude();
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+
+	if (IS_ENABLED(CONFIG_SECURITY_LOADPIN_VERITY)) {
+		if (!register_sysctl_paths(loadpin_sysctl_path,
+					   loadpin_sysctl_table_verity_digests))
+			pr_notice("sysctl registration failed!\n");
+	}
+
 	return 0;
 }
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

