Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8418F52AEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiEQXfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiEQXfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:35:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7358D527DF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:35:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m1so215447plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70QJz56WdWWmTL0B6emMjXbopnc6hlLXxIz6KUt2rIk=;
        b=W05BK4Nx6n8Tgd6iJwnFLSqsNhYNl0hrR2DvD/EXRwgmuGTyvkhPX+60jLTK/mCl44
         H0LVqwEC8m3N5O/F4REujx1uriLyXsiDabcQO4cS/s/dHnfuSJ7Abjo4LfHYPnbwqscs
         qoSrLbLWd8fZRINkTF2v+XV7Cjnbmda/ztzU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70QJz56WdWWmTL0B6emMjXbopnc6hlLXxIz6KUt2rIk=;
        b=GAuPp0L1sfnW75I1HuEddciFYWfRtJ7fs9v93iSNmTgModihLptFXTjZpR5BaH988X
         mVIoq6nVzH2e0hc317yZ+AiEjS8E90fsYWpdUVFl1q8wSWicvzZRCVhv7X56WZcRQjI7
         Mek2sFVkUGzr/SFOECNbTgmH/L3ih99yXfCcsUJ8AIzlHluIDUeADdmCXVtORPliMyTG
         p7w395uub5WUqQQ5xX+Q+kg2w1HHVsVA6Jz1+m/nGoAOpB82lRIzO2Y+PpkHbuCSBPV6
         vHtu//qs50/7IGdthd86C4iLA6Mxts/Nqxx4rMBCW3OOxGKpaOB/U3+daPGU/O+mr6lJ
         eQ8A==
X-Gm-Message-State: AOAM530Q7/0EJH+Ql54bY0fCscXWaupn74GyRqz9oxDU8V1J/RuCbZzk
        LZiMaN9DQx/J+Z8PybJhPGLQew==
X-Google-Smtp-Source: ABdhPJz220+nzi3d4a1gLQVv2K14GMGqs/RIb4+jwX6pC6/HC0zH/+CzmRerWtH5qYEVhjVdlmJsEA==
X-Received: by 2002:a17:90b:4c10:b0:1dc:8289:7266 with SMTP id na16-20020a17090b4c1000b001dc82897266mr39216091pjb.190.1652830501982;
        Tue, 17 May 2022 16:35:01 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:a14:3166:4b67:b688])
        by smtp.gmail.com with UTF8SMTPSA id o3-20020a62cd03000000b0050e006279bfsm277942pfg.137.2022.05.17.16.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 16:35:01 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 1/3] dm: Add verity helpers for LoadPin
Date:   Tue, 17 May 2022 16:34:55 -0700
Message-Id: <20220517163437.v4.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220517233457.1123309-1-mka@chromium.org>
References: <20220517233457.1123309-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoadPin limits loading of kernel modules, firmware and certain
other files to a 'pinned' file system (typically a read-only
rootfs). To provide more flexibility LoadPin is being extended
to also allow loading these files from trusted dm-verity
devices. For that purpose LoadPin can be provided with a list
of verity root digests that it should consider as trusted.

Add a bunch of helpers to allow LoadPin to check whether a DM
device is a trusted verity device. The new functions broadly
fall in two categories: those that need access to verity
internals (like the root digest), and the 'glue' between
LoadPin and verity. The new file dm-verity-loadpin.c contains
the glue functions.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v4:
- a trusted verity device must have a single target of
  type 'verity'
- share list of verity digests with loadpin, deleted
  dm_verity_loadpin_set_trusted_root_digests()
- dm_verity_loadpin_is_md_trusted() is now dm_verity_loadpin_is_sb_trusted(),
  it receives a super_block instead of mapped_device. Updated kernel doc.
- changed struct trusted_root_digest to have an unsized
  u8 array instead of a pointer
- extend 'dm-verity-objs' instead of 'dm-mod-objs'

Changes in v3:
- none

Changes in v2:
- none

 drivers/md/Makefile               |  6 +++
 drivers/md/dm-verity-loadpin.c    | 74 +++++++++++++++++++++++++++++++
 drivers/md/dm-verity-target.c     | 33 ++++++++++++++
 drivers/md/dm-verity.h            |  4 ++
 include/linux/dm-verity-loadpin.h | 27 +++++++++++
 5 files changed, 144 insertions(+)
 create mode 100644 drivers/md/dm-verity-loadpin.c
 create mode 100644 include/linux/dm-verity-loadpin.h

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 0454b0885b01..71771901c823 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -108,6 +108,12 @@ ifeq ($(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG),y)
 dm-verity-objs			+= dm-verity-verify-sig.o
 endif
 
+ifeq ($(CONFIG_DM_VERITY),y)
+ifeq ($(CONFIG_SECURITY_LOADPIN),y)
+dm-verity-objs			+= dm-verity-loadpin.o
+endif
+endif
+
 ifeq ($(CONFIG_DM_AUDIT),y)
 dm-mod-objs			+= dm-audit.o
 endif
diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
new file mode 100644
index 000000000000..3226fbe4a1fe
--- /dev/null
+++ b/drivers/md/dm-verity-loadpin.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/dm-verity-loadpin.h>
+
+#include "dm.h"
+#include "dm-verity.h"
+
+#define DM_MSG_PREFIX	"verity-loadpin"
+
+LIST_HEAD(loadpin_trusted_verity_root_digests);
+
+static bool is_trusted_verity_target(struct dm_target *ti)
+{
+	u8 *root_digest;
+	unsigned int digest_size;
+	struct trusted_root_digest *trd;
+	bool trusted = false;
+
+	if (!dm_is_verity_target(ti))
+		return false;
+
+	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
+		return false;
+
+	list_for_each_entry(trd, &loadpin_trusted_verity_root_digests, node) {
+		if ((trd->len == digest_size) &&
+		    !memcmp(trd->data, root_digest, digest_size)) {
+			trusted = true;
+			break;
+		}
+	}
+
+	kfree(root_digest);
+
+	return trusted;
+}
+
+/*
+ * Determines whether the file system of a superblock is located on
+ * a verity device that is trusted by LoadPin.
+ */
+bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb)
+{
+	struct mapped_device *md;
+	struct dm_table *table;
+	struct dm_target *ti;
+	int srcu_idx;
+	bool trusted = false;
+
+	if (list_empty(&loadpin_trusted_verity_root_digests))
+		return false;
+
+	md = dm_get_md(sb->s_bdev->bd_dev);
+	if (!md)
+		return false;
+
+	table = dm_get_live_table(md, &srcu_idx);
+
+	if (dm_table_get_num_targets(table) != 1)
+		goto out;
+
+	ti = dm_table_get_target(table, 0);
+
+	if (is_trusted_verity_target(ti))
+		trusted = true;
+
+out:
+	dm_put_live_table(md, srcu_idx);
+	dm_put(md);
+
+	return trusted;
+}
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 80133aae0db3..6f07b849fcb2 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/scatterlist.h>
+#include <linux/string.h>
 
 #define DM_MSG_PREFIX			"verity"
 
@@ -1310,6 +1311,38 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	return r;
 }
 
+/*
+ * Check whether a DM target is a verity target.
+ */
+bool dm_is_verity_target(struct dm_target *ti)
+{
+	return ti->type->module == THIS_MODULE;
+}
+EXPORT_SYMBOL_GPL(dm_is_verity_target);
+
+/*
+ * Get the root digest of a verity target.
+ *
+ * Returns a copy of the root digest, the caller is responsible for
+ * freeing the memory of the digest.
+ */
+int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned int *digest_size)
+{
+	struct dm_verity *v = ti->private;
+
+	if (!dm_is_verity_target(ti))
+		return -EINVAL;
+
+	*root_digest = kmemdup(v->root_digest, v->digest_size, GFP_KERNEL);
+	if (*root_digest == NULL)
+		return -ENOMEM;
+
+	*digest_size = v->digest_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dm_verity_get_root_digest);
+
 static struct target_type verity_target = {
 	.name		= "verity",
 	.version	= {1, 8, 0},
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 4e769d13473a..c832cc3e3d24 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -129,4 +129,8 @@ extern int verity_hash(struct dm_verity *v, struct ahash_request *req,
 extern int verity_hash_for_block(struct dm_verity *v, struct dm_verity_io *io,
 				 sector_t block, u8 *digest, bool *is_zero);
 
+extern bool dm_is_verity_target(struct dm_target *ti);
+extern int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest,
+				     unsigned int *digest_size);
+
 #endif /* DM_VERITY_H */
diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
new file mode 100644
index 000000000000..c2bfd2b9c651
--- /dev/null
+++ b/include/linux/dm-verity-loadpin.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_DM_VERITY_LOADPIN_H
+#define __LINUX_DM_VERITY_LOADPIN_H
+
+#include <linux/list.h>
+
+struct super_block;
+
+extern struct list_head loadpin_trusted_verity_root_digests;
+
+struct trusted_root_digest {
+	struct list_head node;
+	unsigned int len;
+	u8 data[];
+};
+
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
+#else
+static inline bool dm_verity_loadpin_is_sb_trusted(struct super_block *sb);
+{
+	return false;
+}
+#endif
+
+#endif /* __LINUX_DM_LOADPIN_H */
-- 
2.36.0.550.gb090851708-goog

