Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1051AE6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357943AbiEDT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377708AbiEDT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:58:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8654EA08
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:54:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fv2so2160035pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CetlpCftC8fa22AwQ7f9noDAbp04u3fxXYOBJDWXdo=;
        b=i7PO7MJFWaOICLk7YlYbL76Mf0xaAQ93IS19rBh5kZDqEelU24XSWeAGy/kM3aRVFv
         4pu6lwIhJ6xGsn9VmwyfLpA97TjUL5z/vu6itVt2PsL5RcBV9E3IssZWPxdHqY7Z0JCM
         iQsJUrBX3PvK+cr11Oe8toqnVFCeeZY6TVGqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CetlpCftC8fa22AwQ7f9noDAbp04u3fxXYOBJDWXdo=;
        b=A8ft8o3jZgCI7orEa4hAmgwnLooJM6Yx9hk/HpKxK2YgXR0yIrcamo1zQm6xRltdQz
         /NK2a8qkcakDMTBw6Y0RVT+nYW+FMi8F10f5t2TFDUsVsdocndGPvEK+QthBFABo2+Al
         BUiz98VnWY3iAHzFHE/mbazsWA4yA6R42nMsUaBwCKh3d5kgEmwqQUsyVjPaMUFUn3qA
         daJa522Ck2nv+tJtimyk+NE4Cr5KGU62pj40PAuaCc714n5sP2blRqgQK70rZs5MJbUx
         Rwd5h/EoWA7yK3rnkN9mTNUs6l8Utc763J7/Z8fGYgBK9bIR03nNn0LbzdyK2RbOOd+H
         /bxg==
X-Gm-Message-State: AOAM531g+okBYHZoOo0+HvWNcmPKpeq4pvAuCeJ8HcaxlFbtL+wv85fC
        guTt+DuDwT2nf1dotRquQ7bI0w==
X-Google-Smtp-Source: ABdhPJzmCKD4KIjLDv8vNDJK4ppeaWC2YAVRNAFyqVpurA+XTRKpw2HAvCD1vyC3w23XbEThwD8IPQ==
X-Received: by 2002:a17:902:ecc8:b0:15e:9e46:cb7e with SMTP id a8-20020a170902ecc800b0015e9e46cb7emr18203039plh.111.1651694065547;
        Wed, 04 May 2022 12:54:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id n5-20020aa79045000000b0050dc7628143sm8586582pfo.29.2022.05.04.12.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 12:54:25 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/3] dm: Add verity helpers for LoadPin
Date:   Wed,  4 May 2022 12:54:17 -0700
Message-Id: <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220504195419.1143099-1-mka@chromium.org>
References: <20220504195419.1143099-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes in v3:
- none

Changes in v2:
- none

 drivers/md/Makefile               |  6 +++
 drivers/md/dm-verity-loadpin.c    | 80 +++++++++++++++++++++++++++++++
 drivers/md/dm-verity-target.c     | 33 +++++++++++++
 drivers/md/dm-verity.h            |  4 ++
 include/linux/dm-verity-loadpin.h | 27 +++++++++++
 5 files changed, 150 insertions(+)
 create mode 100644 drivers/md/dm-verity-loadpin.c
 create mode 100644 include/linux/dm-verity-loadpin.h

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 0454b0885b01..e12cd004d375 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -100,6 +100,12 @@ ifeq ($(CONFIG_IMA),y)
 dm-mod-objs			+= dm-ima.o
 endif
 
+ifeq ($(CONFIG_DM_VERITY),y)
+ifeq ($(CONFIG_SECURITY_LOADPIN),y)
+dm-mod-objs			+= dm-verity-loadpin.o
+endif
+endif
+
 ifeq ($(CONFIG_DM_VERITY_FEC),y)
 dm-verity-objs			+= dm-verity-fec.o
 endif
diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
new file mode 100644
index 000000000000..972ca93a2231
--- /dev/null
+++ b/drivers/md/dm-verity-loadpin.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/dm-verity-loadpin.h>
+
+#include "dm.h"
+#include "dm-verity.h"
+
+static struct list_head *trusted_root_digests;
+
+/*
+ * Sets the root digests of verity devices which LoadPin considers as trusted.
+ *
+ * This function must only be called once.
+ */
+void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests)
+{
+	if (!trusted_root_digests)
+		trusted_root_digests = digests;
+	else
+		pr_warn("verity root digests trusted by LoadPin are already set!!!\n");
+}
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
+	list_for_each_entry(trd, trusted_root_digests, node) {
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
+ * Determines whether a mapped device is a verity device that is trusted
+ * by LoadPin.
+ */
+bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
+{
+	int srcu_idx;
+	struct dm_table *table;
+	unsigned int num_targets;
+	bool trusted = false;
+	int i;
+
+	if (!trusted_root_digests || list_empty(trusted_root_digests))
+		return false;
+
+	table = dm_get_live_table(md, &srcu_idx);
+	num_targets = dm_table_get_num_targets(table);
+	for (i = 0; i < num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(table, i);
+
+		if (is_trusted_verity_target(ti)) {
+			trusted = true;
+			break;
+		}
+	}
+
+	dm_put_live_table(md, srcu_idx);
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
index 000000000000..12a86911d05a
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
+struct mapped_device;
+
+struct trusted_root_digest {
+	u8 *data;
+	unsigned int len;
+	struct list_head node;
+};
+
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
+void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests);
+bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md);
+#else
+static inline void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests) {}
+static inline bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
+{
+	return false;
+}
+#endif
+
+#endif /* __LINUX_DM_LOADPIN_H */
-- 
2.36.0.464.gb9c8b46e94-goog

