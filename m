Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A100E531D83
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiEWVOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiEWVOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:14:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6431E7DE08
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:14:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so14717008pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFCWx+ylAY8dgCt25JkKf17aOAoMoBf41nquHMuShDE=;
        b=DrxRx3lcJlrmz3dLTTbA/BGYwGlTnpRvbUn3+FYGbiyqc4fVVCmnHeaYh9oRRylTqf
         mwVuGqA66Wk5YOx4+E+11K5zMPz+fQWvA+SOglWu8QqlKYDd1D9QrrfWjtQVi8VEtz4D
         RCMsaWnJLfHfLrQLi2TMwruH5HBHe/jWUmoiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFCWx+ylAY8dgCt25JkKf17aOAoMoBf41nquHMuShDE=;
        b=56qQB/2obBxzZTiiCzk7YRY1/1XDxbCvg+8j9Rl0vlyIRR2HFhXEqexvNo3IVQF3Z7
         yiydzFP0kFd1Q7mAMz3Td1zvMfq/zxwiTfZMj6iwTjEOrxxcQsVK4DF7HzZIJLYfk2iz
         9OJA27fYq3Skfp2gKUj8wQxp/B1au58Y2vhT0e+jgw/W5wvqx861tCOBmVQu27Fcvl6M
         G24PQZ4KeZmjcWGG6R58PiQaHuCB1kK0WNBmYEqMTL8J4jK+i6thEERGUGL3j3pEzrH0
         2EARXXnrlwA862AuO1hVgHSUeizLaJPOLERSUHDvecSOhy19EMXZkAhKJgBsiJmz2HWd
         9ukA==
X-Gm-Message-State: AOAM532qwfgaSZTw/Z0w6Tg+gXA4dBN7l0CN61NwZgddo41h9cWli6+v
        8mg++0KjRrFAZCNuO79f1PZRKA==
X-Google-Smtp-Source: ABdhPJzFBI8sZMoLwz+YBgyqx5St60xio7LcpPb0/AquoAtcXVQBdrULJtODVLNJRd6PnonV4Oef3Q==
X-Received: by 2002:a63:8bc9:0:b0:3f8:4817:880b with SMTP id j192-20020a638bc9000000b003f84817880bmr15353756pge.87.1653340444919;
        Mon, 23 May 2022 14:14:04 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d9e2:8472:9ac:8532])
        by smtp.gmail.com with UTF8SMTPSA id v17-20020a17090ad59100b001deb92de665sm118439pju.46.2022.05.23.14.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 14:14:04 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 1/3] dm: Add verity helpers for LoadPin
Date:   Mon, 23 May 2022 14:13:58 -0700
Message-Id: <20220523141325.v6.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523211400.290537-1-mka@chromium.org>
References: <20220523211400.290537-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-by: Kees Cook <keescook@chromium.org>
---

Changes in v6:
- s/loadpin_trusted_verity_root_digests/dm_verity_loadpin_trusted_root_digests/
- s/trusted_root_digest/dm_verity_loadpin_trusted_root_digest/
- removed unnecessary symbol exports

Changes in v5:
- changed dm_verity_loadpin_is_sb_trusted() to
  dm_verity_loadpin_is_bdev_trusted()
- bumped version number to 1.8.1
- deleted bad semicolon in declaration of stub for
  dm_verity_loadpin_is_bdev_trusted()
- added 'Acked-by' tag from Kees

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
 drivers/md/dm-verity-target.c     | 33 +++++++++++++-
 drivers/md/dm-verity.h            |  4 ++
 include/linux/dm-verity-loadpin.h | 27 +++++++++++
 5 files changed, 143 insertions(+), 1 deletion(-)
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
index 000000000000..10c18bc1652c
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
+LIST_HEAD(dm_verity_loadpin_trusted_root_digests);
+
+static bool is_trusted_verity_target(struct dm_target *ti)
+{
+	u8 *root_digest;
+	unsigned int digest_size;
+	struct dm_verity_loadpin_trusted_root_digest *trd;
+	bool trusted = false;
+
+	if (!dm_is_verity_target(ti))
+		return false;
+
+	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
+		return false;
+
+	list_for_each_entry(trd, &dm_verity_loadpin_trusted_root_digests, node) {
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
+bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
+{
+	struct mapped_device *md;
+	struct dm_table *table;
+	struct dm_target *ti;
+	int srcu_idx;
+	bool trusted = false;
+
+	if (list_empty(&dm_verity_loadpin_trusted_root_digests))
+		return false;
+
+	md = dm_get_md(bdev->bd_dev);
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
index 80133aae0db3..c5395e93525a 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/scatterlist.h>
+#include <linux/string.h>
 
 #define DM_MSG_PREFIX			"verity"
 
@@ -1310,9 +1311,39 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	return r;
 }
 
+/*
+ * Check whether a DM target is a verity target.
+ */
+bool dm_is_verity_target(struct dm_target *ti)
+{
+	return ti->type->module == THIS_MODULE;
+}
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
+
 static struct target_type verity_target = {
 	.name		= "verity",
-	.version	= {1, 8, 0},
+	.version	= {1, 8, 1},
 	.module		= THIS_MODULE,
 	.ctr		= verity_ctr,
 	.dtr		= verity_dtr,
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
index 000000000000..fb695ecaa5d5
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
+struct block_device;
+
+extern struct list_head dm_verity_loadpin_trusted_root_digests;
+
+struct dm_verity_loadpin_trusted_root_digest {
+	struct list_head node;
+	unsigned int len;
+	u8 data[];
+};
+
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev);
+#else
+static inline bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
+{
+	return false;
+}
+#endif
+
+#endif /* __LINUX_DM_VERITY_LOADPIN_H */
-- 
2.36.1.124.g0e6072fb45-goog

