Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A704BF266
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiBVHHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:07:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiBVHHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:07:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA88AB479
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67F12B81716
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF87C340E8;
        Tue, 22 Feb 2022 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645513640;
        bh=bjQux4KfMguEvbyYEyLigPrNa+Mj1tsqrfaVMXRsHu0=;
        h=From:To:Cc:Subject:Date:From;
        b=19ApQUIZl9ruzcQI9gOb3QumHiahYkOI5Gr19WJHpi7iK86XxJhS2TGs6odPIkNF7
         iUwE9NToTLDkV0L+ARfz42y6xIiWPaAx9jlCfe6neR+BCWVuFbJCDv5YZzgJZ5udjK
         FPBGJovToFYRy7z37WvPn3TtBYo5DpVg9ooV3p88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Imran Khan <imran.f.khan@oracle.com>
Subject: [PATCH] kernfs: move struct kernfs_root out of the public view.
Date:   Tue, 22 Feb 2022 08:07:13 +0100
Message-Id: <20220222070713.3517679-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4823; h=from:subject; bh=bjQux4KfMguEvbyYEyLigPrNa+Mj1tsqrfaVMXRsHu0=; b=owGbwMvMwCRo6H6F97bub03G02pJDEki3fPL3v1Zdr/OqU515a6lbBv/N92KmyQTzTb5I/OEt61a /mqBHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRxdMZ5op8fTV/mXLUwfakCqVrGV Vf+Rl2GDPMD5kzvW75K8EN8xNU3socPOx+4dYBFwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have struct kernfs_root be part of kernfs.h for
the whole kernel to see and poke around it.  Move it internal to kernfs
code and provide a helper function, kernfs_root_to_node(), to handle the
one field that kernfs users were directly accessing from the structure.

Cc: Tejun Heo <tj@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
 fs/kernfs/dir.c                        |  9 +++++++++
 fs/kernfs/kernfs-internal.h            | 18 ++++++++++++++++++
 fs/sysfs/mount.c                       |  2 +-
 include/linux/kernfs.h                 |  4 ++++
 kernel/cgroup/cgroup.c                 |  4 ++--
 6 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b57b3db9a6a7..83f901e2c2df 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3221,13 +3221,13 @@ static int __init rdtgroup_setup_root(void)
 
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
 
-	ret = rdtgroup_add_files(rdt_root->kn, RF_CTRL_BASE);
+	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RF_CTRL_BASE);
 	if (ret) {
 		kernfs_destroy_root(rdt_root);
 		goto out;
 	}
 
-	rdtgroup_default.kn = rdt_root->kn;
+	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
 	kernfs_activate(rdtgroup_default.kn);
 
 out:
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index e6d9772ddb4c..61a8edc4ba8b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -970,6 +970,15 @@ void kernfs_destroy_root(struct kernfs_root *root)
 	kernfs_put(root->kn); /* will also free @root */
 }
 
+/**
+ * kernfs_root_to_node - return the kernfs_node associated with a kernfs_root
+ * @root: root to use to lookup
+ */
+struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root)
+{
+	return root->kn;
+}
+
 /**
  * kernfs_create_dir_ns - create a directory
  * @parent: parent in which to create a new directory
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1..123a7edd25f5 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -31,6 +31,24 @@ struct kernfs_iattrs {
 	atomic_t		user_xattr_size;
 };
 
+struct kernfs_root {
+	/* published fields */
+	struct kernfs_node	*kn;
+	unsigned int		flags;	/* KERNFS_ROOT_* flags */
+
+	/* private fields, do not use outside kernfs proper */
+	struct idr		ino_idr;
+	u32			last_id_lowbits;
+	u32			id_highbits;
+	struct kernfs_syscall_ops *syscall_ops;
+
+	/* list of kernfs_super_info of this root, protected by kernfs_rwsem */
+	struct list_head	supers;
+
+	wait_queue_head_t	deactivate_waitq;
+	struct rw_semaphore	kernfs_rwsem;
+};
+
 /* +1 to avoid triggering overflow warning when negating it */
 #define KN_DEACTIVATED_BIAS		(INT_MIN + 1)
 
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index e747c135c1d1..98467bb76737 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -103,7 +103,7 @@ int __init sysfs_init(void)
 	if (IS_ERR(sysfs_root))
 		return PTR_ERR(sysfs_root);
 
-	sysfs_root_kn = sysfs_root->kn;
+	sysfs_root_kn = kernfs_root_to_node(sysfs_root);
 
 	err = register_filesystem(&sysfs_fs_type);
 	if (err) {
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 861c4f0f8a29..62aff082dc3f 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -185,6 +185,7 @@ struct kernfs_syscall_ops {
 			 struct kernfs_root *root);
 };
 
+#if 0
 struct kernfs_root {
 	/* published fields */
 	struct kernfs_node	*kn;
@@ -202,6 +203,9 @@ struct kernfs_root {
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
 };
+#endif
+
+struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root);
 
 struct kernfs_open_file {
 	/* published fields */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b31e1465868a..a800c3b1b795 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1302,7 +1302,7 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 
 struct cgroup_root *cgroup_root_from_kf(struct kernfs_root *kf_root)
 {
-	struct cgroup *root_cgrp = kf_root->kn->priv;
+	struct cgroup *root_cgrp = kernfs_root_to_node(kf_root)->priv;
 
 	return root_cgrp->root;
 }
@@ -2025,7 +2025,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 		ret = PTR_ERR(root->kf_root);
 		goto exit_root_id;
 	}
-	root_cgrp->kn = root->kf_root->kn;
+	root_cgrp->kn = kernfs_root_to_node(root->kf_root);
 	WARN_ON_ONCE(cgroup_ino(root_cgrp) != 1);
 	root_cgrp->ancestor_ids[0] = cgroup_id(root_cgrp);
 
-- 
2.35.1

