Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554324A9371
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiBDFZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiBDFZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:25:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55702C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:25:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23460B81E57
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC89C004E1;
        Fri,  4 Feb 2022 05:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643952304;
        bh=aQ5bbnmYYvcskYkqujvFmjwHmT9XNwy0IN/9pGWKqpg=;
        h=From:To:Cc:Subject:Date:From;
        b=dxDOh9RAsYqT+PVcaUnxNI5/Kd7qKlTq4F/1DETN4N6fEmIv1XU1uzwBRoi9kJSWZ
         bO5Qs1ObbkJY60wEO1Brh6Q8g8p1obcknWT7UBl8GwCMzc1TqxsGrXfqcusHDayKys
         4MbWrhV9aD0yW/lx8lOjbl5FcGStdqe+XRbNyV1sviJ5ym8VtntOmZ4Vv0Rqyoe7x+
         N57qgd/mP+beu/hgTFnDjJPmqZ38xUYQiK8r0BMrmRQfA8zLiG+rcofHD7ye49yU65
         Rv9IoZ++ch7J/kX+JnI7o59Mi7DFDfavZwxQWlQmQLb9iqvbeJ0Okf43Si2H4kRrfG
         6krLuX5lSCyug==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: support idmapped mounts
Date:   Fri,  4 Feb 2022 13:24:56 +0800
Message-Id: <20220204052456.44573-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables idmapped mounts for f2fs, since all dedicated helpers
for this functionality existsm, so, in this patch we just pass down the
user_namespace argument from the VFS methods to the relevant helpers.

Simple idmap example on f2fs image:

1. truncate -s 128M f2fs.img
2. mkfs.f2fs f2fs.img
3. mount f2fs.img /mnt/f2fs/
4. touch /mnt/f2fs/file

5. ls -ln /mnt/f2fs/
total 0
-rw-r--r-- 1 0 0 0 2月   4 13:17 file

6. ./mount-idmapped --map-mount b:0:1001:1 /mnt/f2fs/ /mnt/scratch_f2fs/

7. ls -ln /mnt/scratch_f2fs/
total 0
-rw-r--r-- 1 1001 1001 0 2月   4 13:17 file

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/acl.c   | 21 ++++++++++++---------
 fs/f2fs/file.c  | 23 ++++++++++++++---------
 fs/f2fs/namei.c | 41 +++++++++++++++++++++++------------------
 fs/f2fs/super.c |  2 +-
 4 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 16e826e01f09..eaa240b21f07 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -204,8 +204,9 @@ struct posix_acl *f2fs_get_acl(struct inode *inode, int type, bool rcu)
 	return __f2fs_get_acl(inode, type, NULL);
 }
 
-static int f2fs_acl_update_mode(struct inode *inode, umode_t *mode_p,
-			  struct posix_acl **acl)
+static int f2fs_acl_update_mode(struct user_namespace *mnt_userns,
+				struct inode *inode, umode_t *mode_p,
+				struct posix_acl **acl)
 {
 	umode_t mode = inode->i_mode;
 	int error;
@@ -218,14 +219,15 @@ static int f2fs_acl_update_mode(struct inode *inode, umode_t *mode_p,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!in_group_p(i_gid_into_mnt(&init_user_ns, inode)) &&
-	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
+	if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
+	    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
 }
 
-static int __f2fs_set_acl(struct inode *inode, int type,
+static int __f2fs_set_acl(struct user_namespace *mnt_userns,
+			struct inode *inode, int type,
 			struct posix_acl *acl, struct page *ipage)
 {
 	int name_index;
@@ -238,7 +240,8 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
 		if (acl && !ipage) {
-			error = f2fs_acl_update_mode(inode, &mode, &acl);
+			error = f2fs_acl_update_mode(mnt_userns, inode,
+								&mode, &acl);
 			if (error)
 				return error;
 			set_acl_inode(inode, mode);
@@ -279,7 +282,7 @@ int f2fs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
 
-	return __f2fs_set_acl(inode, type, acl, NULL);
+	return __f2fs_set_acl(mnt_userns, inode, type, acl, NULL);
 }
 
 /*
@@ -419,7 +422,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (default_acl) {
-		error = __f2fs_set_acl(inode, ACL_TYPE_DEFAULT, default_acl,
+		error = __f2fs_set_acl(NULL, inode, ACL_TYPE_DEFAULT, default_acl,
 				       ipage);
 		posix_acl_release(default_acl);
 	} else {
@@ -427,7 +430,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 	}
 	if (acl) {
 		if (!error)
-			error = __f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl,
+			error = __f2fs_set_acl(NULL, inode, ACL_TYPE_ACCESS, acl,
 					       ipage);
 		posix_acl_release(acl);
 	} else {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3a573125002b..135e6ac0792c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -844,7 +844,7 @@ int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(mnt_userns, inode, stat);
 
 	/* we need to show initial sectors used for inline_data/dentries */
 	if ((S_ISREG(inode->i_mode) && f2fs_has_inline_data(inode)) ||
@@ -904,7 +904,7 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(mnt_userns, dentry, attr);
 	if (err)
 		return err;
 
@@ -980,10 +980,10 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
 
-	__setattr_copy(&init_user_ns, inode, attr);
+	__setattr_copy(mnt_userns, inode, attr);
 
 	if (attr->ia_valid & ATTR_MODE) {
-		err = posix_acl_chmod(&init_user_ns, inode, f2fs_get_inode_mode(inode));
+		err = posix_acl_chmod(mnt_userns, inode, f2fs_get_inode_mode(inode));
 
 		if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 			if (!err)
@@ -1989,11 +1989,12 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 static int f2fs_ioc_start_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
@@ -2058,9 +2059,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 static int f2fs_ioc_commit_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
@@ -2100,9 +2102,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 static int f2fs_ioc_start_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
@@ -2135,9 +2138,10 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 static int f2fs_ioc_release_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
@@ -2164,9 +2168,10 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 static int f2fs_ioc_abort_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 0347c5780910..2b23a76bdae9 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -22,7 +22,8 @@
 #include "acl.h"
 #include <trace/events/f2fs.h>
 
-static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
+static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
+						struct inode *dir, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	nid_t ino;
@@ -46,7 +47,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	nid_free = true;
 
-	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_init_owner(mnt_userns, inode, dir, mode);
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
@@ -67,7 +68,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		(F2FS_I(dir)->i_flags & F2FS_PROJINHERIT_FL))
 		F2FS_I(inode)->i_projid = F2FS_I(dir)->i_projid;
 	else
-		F2FS_I(inode)->i_projid = make_kprojid(&init_user_ns,
+		F2FS_I(inode)->i_projid = make_kprojid(mnt_userns,
 							F2FS_DEF_PROJID);
 
 	err = fscrypt_prepare_new_inode(dir, inode, &encrypt);
@@ -349,7 +350,7 @@ static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(dir, mode);
+	inode = f2fs_new_inode(mnt_userns, dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -679,7 +680,7 @@ static int f2fs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(dir, S_IFLNK | S_IRWXUGO);
+	inode = f2fs_new_inode(mnt_userns, dir, S_IFLNK | S_IRWXUGO);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -750,7 +751,7 @@ static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(dir, S_IFDIR | mode);
+	inode = f2fs_new_inode(mnt_userns, dir, S_IFDIR | mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -807,7 +808,7 @@ static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(dir, mode);
+	inode = f2fs_new_inode(mnt_userns, dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -834,8 +835,9 @@ static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	return err;
 }
 
-static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
-					umode_t mode, struct inode **whiteout)
+static int __f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+					struct dentry *dentry, umode_t mode,
+					struct inode **whiteout)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
@@ -845,7 +847,7 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	if (err)
 		return err;
 
-	inode = f2fs_new_inode(dir, mode);
+	inode = f2fs_new_inode(mnt_userns, dir, mode);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -909,20 +911,22 @@ static int f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (!f2fs_is_checkpoint_ready(sbi))
 		return -ENOSPC;
 
-	return __f2fs_tmpfile(dir, dentry, mode, NULL);
+	return __f2fs_tmpfile(mnt_userns, dir, dentry, mode, NULL);
 }
 
-static int f2fs_create_whiteout(struct inode *dir, struct inode **whiteout)
+static int f2fs_create_whiteout(struct user_namespace *mnt_userns,
+				struct inode *dir, struct inode **whiteout)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(dir))))
 		return -EIO;
 
-	return __f2fs_tmpfile(dir, NULL, S_IFCHR | WHITEOUT_MODE, whiteout);
+	return __f2fs_tmpfile(mnt_userns, dir, NULL,
+				S_IFCHR | WHITEOUT_MODE, whiteout);
 }
 
-static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
-			struct inode *new_dir, struct dentry *new_dentry,
-			unsigned int flags)
+static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+			struct dentry *old_dentry, struct inode *new_dir,
+			struct dentry *new_dentry, unsigned int flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(old_dir);
 	struct inode *old_inode = d_inode(old_dentry);
@@ -960,7 +964,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 
 	if (flags & RENAME_WHITEOUT) {
-		err = f2fs_create_whiteout(old_dir, &whiteout);
+		err = f2fs_create_whiteout(mnt_userns, old_dir, &whiteout);
 		if (err)
 			return err;
 	}
@@ -1300,7 +1304,8 @@ static int f2fs_rename2(struct user_namespace *mnt_userns,
 	 * VFS has already handled the new dentry existence case,
 	 * here, we just deal with "RENAME_NOREPLACE" as regular rename.
 	 */
-	return f2fs_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
+	return f2fs_rename(mnt_userns, old_dir, old_dentry,
+					new_dir, new_dentry, flags);
 }
 
 static const char *f2fs_encrypted_get_link(struct dentry *dentry,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cc0429279b4c..41ef1273f2f2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4528,7 +4528,7 @@ static struct file_system_type f2fs_fs_type = {
 	.name		= "f2fs",
 	.mount		= f2fs_mount,
 	.kill_sb	= kill_f2fs_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("f2fs");
 
-- 
2.32.0

