Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D193B538E00
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbiEaJvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiEaJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:51:15 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33D489859C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:51:14 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 7833720012B9;
        Tue, 31 May 2022 18:51:10 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24V9p8MW040003
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 18:51:09 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 24V9p8gu211056
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 18:51:08 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 24V9p7BI211055;
        Tue, 31 May 2022 18:51:07 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Kellner <ckellner@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: Re: [PATCH v3 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
References: <20220526134119.242182-1-javierm@redhat.com>
        <20220526134119.242182-3-javierm@redhat.com>
Date:   Tue, 31 May 2022 18:51:07 +0900
In-Reply-To: <20220526134119.242182-3-javierm@redhat.com> (Javier Martinez
        Canillas's message of "Thu, 26 May 2022 15:41:18 +0200")
Message-ID: <87ilpmows4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> The renameat2 RENAME_EXCHANGE flag allows to atomically exchange two paths
> but is currently not supported by the Linux vfat filesystem driver.
>
> Add a vfat_rename_exchange() helper function that implements this support.
>
> The super block lock is acquired during the operation to ensure atomicity,
> and in the error path actions made are reversed also with the mutex held.
>
> It makes the operation as transactional as possible, within the limitation
> impossed by vfat due not having a journal with logs to replay.

I tweaked your patch (tested only slightly), can you review and merge to
this patch if ok?

Main purpose of me is to consolidate helpers with vfat_rename(), and
tweak coding style to use existent fat codes.

> +	if (old_dir != new_dir) {
> +		err = vfat_get_dotdot_info(old_inode, &old_dotdot_bh, &old_dotdot_de);
> +		if (err)
> +			goto out;
> +
> +		err = vfat_get_dotdot_info(new_inode, &new_dotdot_bh, &new_dotdot_de);
> +		if (err)
> +			goto out;

This should not return -ENOENT here. I tweaked to return -EIO in my patch.

> +	/* update inode version and timestamps */
> +	inode_inc_iversion(old_inode);
> +	inode_inc_iversion(new_inode);

Why do we need to update iversion of those inodes? I couldn't get intent
of this.

> +error_new_dotdot:
> +	/* data cluster is shared, serious corruption */

Sharing data cluster would happen here only if one inode success to sync
and another one failed. Then so I/O error, we would not be able to do
much for it.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/namei_vfat.c |  205 +++++++++++++++++++++------------------------------
 1 file changed, 87 insertions(+), 118 deletions(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 3e3cd4f..84f95eb 100644
--- a/fs/fat/namei_vfat.c	2022-05-31 16:53:56.987009983 +0900
+++ b/fs/fat/namei_vfat.c	2022-05-31 18:37:30.893473188 +0900
@@ -893,16 +893,55 @@ out:
 	return err;
 }
 
+static int vfat_get_dotdot_de(struct inode *inode, struct buffer_head **bh,
+			      struct msdos_dir_entry **de)
+{
+	if (S_ISDIR(inode->i_mode)) {
+		if (fat_get_dotdot_entry(inode, bh, de))
+			return -EIO;
+	}
+	return 0;
+}
+
+static int vfat_sync_ipos(struct inode *dir, struct inode *inode)
+{
+	if (IS_DIRSYNC(dir))
+		return fat_sync_inode(inode);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
+static int vfat_update_dotdot_de(struct inode *dir, struct inode *inode,
+				 struct buffer_head *dotdot_bh,
+				 struct msdos_dir_entry *dotdot_de)
+{
+	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
+	mark_buffer_dirty_inode(dotdot_bh, inode);
+	if (IS_DIRSYNC(dir))
+		return sync_dirty_buffer(dotdot_bh);
+	return 0;
+}
+
+static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
+{
+	inode_inc_iversion(dir);
+	fat_truncate_time(dir, ts, S_CTIME | S_MTIME);
+	if (IS_DIRSYNC(dir))
+		(void)fat_sync_inode(dir);
+	else
+		mark_inode_dirty(dir);
+}
+
 static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		       struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct buffer_head *dotdot_bh;
-	struct msdos_dir_entry *dotdot_de;
+	struct msdos_dir_entry *dotdot_de = NULL;
 	struct inode *old_inode, *new_inode;
 	struct fat_slot_info old_sinfo, sinfo;
 	struct timespec64 ts;
 	loff_t new_i_pos;
-	int err, is_dir, update_dotdot, corrupt = 0;
+	int err, is_dir, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
 
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
@@ -913,15 +952,13 @@ static int vfat_rename(struct inode *old
 	if (err)
 		goto out;
 
-	is_dir = S_ISDIR(old_inode->i_mode);
-	update_dotdot = (is_dir && old_dir != new_dir);
-	if (update_dotdot) {
-		if (fat_get_dotdot_entry(old_inode, &dotdot_bh, &dotdot_de)) {
-			err = -EIO;
+	if (old_dir != new_dir) {
+		err = vfat_get_dotdot_de(old_inode, &dotdot_bh, &dotdot_de);
+		if (err)
 			goto out;
-		}
 	}
 
+	is_dir = S_ISDIR(old_inode->i_mode);
 	ts = current_time(old_dir);
 	if (new_inode) {
 		if (is_dir) {
@@ -942,21 +979,15 @@ static int vfat_rename(struct inode *old
 
 	fat_detach(old_inode);
 	fat_attach(old_inode, new_i_pos);
-	if (IS_DIRSYNC(new_dir)) {
-		err = fat_sync_inode(old_inode);
+	err = vfat_sync_ipos(new_dir, old_inode);
+	if (err)
+		goto error_inode;
+
+	if (dotdot_de) {
+		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
+					    dotdot_de);
 		if (err)
-			goto error_inode;
-	} else
-		mark_inode_dirty(old_inode);
-
-	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(new_dir)->i_logstart);
-		mark_buffer_dirty_inode(dotdot_bh, old_inode);
-		if (IS_DIRSYNC(new_dir)) {
-			err = sync_dirty_buffer(dotdot_bh);
-			if (err)
-				goto error_dotdot;
-		}
+			goto error_dotdot;
 		drop_nlink(old_dir);
 		if (!new_inode)
  			inc_nlink(new_dir);
@@ -966,12 +997,7 @@ static int vfat_rename(struct inode *old
 	old_sinfo.bh = NULL;
 	if (err)
 		goto error_dotdot;
-	inode_inc_iversion(old_dir);
-	fat_truncate_time(old_dir, &ts, S_CTIME|S_MTIME);
-	if (IS_DIRSYNC(old_dir))
-		(void)fat_sync_inode(old_dir);
-	else
-		mark_inode_dirty(old_dir);
+	vfat_update_dir_metadata(old_dir, &ts);
 
 	if (new_inode) {
 		drop_nlink(new_inode);
@@ -991,10 +1017,9 @@ error_dotdot:
 	/* data cluster is shared, serious corruption */
 	corrupt = 1;
 
-	if (update_dotdot) {
-		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
-		mark_buffer_dirty_inode(dotdot_bh, old_inode);
-		corrupt |= sync_dirty_buffer(dotdot_bh);
+	if (dotdot_de) {
+		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
+						 dotdot_de);
 	}
 error_inode:
 	fat_detach(old_inode);
@@ -1021,66 +1046,18 @@ error_inode:
 	goto out;
 }
 
-/* Helpers for vfat_rename_exchange() */
-
-static int vfat_get_dotdot_info(struct inode *inode, struct buffer_head **dotdot_bh,
-				struct msdos_dir_entry **dotdot_de)
-{
-	if (!S_ISDIR(inode->i_mode))
-		return 0;
-
-	return fat_get_dotdot_entry(inode, dotdot_bh, dotdot_de);
-}
-
-static void vfat_exchange_dentries(struct inode *old_inode, struct inode *new_inode,
-				   loff_t old_i_pos, loff_t new_i_pos)
+static void vfat_exchange_ipos(struct inode *old_inode, struct inode *new_inode,
+			       loff_t old_i_pos, loff_t new_i_pos)
 {
 	fat_detach(old_inode);
 	fat_detach(new_inode);
-
 	fat_attach(old_inode, new_i_pos);
 	fat_attach(new_inode, old_i_pos);
 }
 
-static int vfat_sync_after_exchange(struct inode *dir, struct inode *inode)
-{
-	int err = 0;
-
-	if (IS_DIRSYNC(dir))
-		err = fat_sync_inode(inode);
-	else
-		mark_inode_dirty(inode);
-
-	return err;
-}
-
-static int vfat_update_dotdot_info(struct buffer_head *dotdot_bh, struct msdos_dir_entry *dotdot_de,
-				   struct inode *dir, struct inode *inode)
-{
-	int err = 0;
-
-	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
-	mark_buffer_dirty_inode(dotdot_bh, inode);
-
-	if (IS_DIRSYNC(dir))
-		err = sync_dirty_buffer(dotdot_bh);
-
-	return err;
-}
-
-static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
-{
-	inode_inc_iversion(dir);
-	fat_truncate_time(dir, ts, S_CTIME | S_MTIME);
-
-	if (IS_DIRSYNC(dir))
-		(void)fat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
-}
-
-static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
-				struct inode *new_dir, struct dentry *new_dentry)
+static int
+vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
+		     struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct buffer_head *old_dotdot_bh = NULL, *new_dotdot_bh = NULL;
 	struct msdos_dir_entry *old_dotdot_de = NULL, *new_dotdot_de = NULL;
@@ -1098,11 +1075,13 @@ static int vfat_rename_exchange(struct i
 
 	/* if directories are not the same, get ".." info to update */
 	if (old_dir != new_dir) {
-		err = vfat_get_dotdot_info(old_inode, &old_dotdot_bh, &old_dotdot_de);
+		err = vfat_get_dotdot_de(old_inode, &old_dotdot_bh,
+					 &old_dotdot_de);
 		if (err)
 			goto out;
 
-		err = vfat_get_dotdot_info(new_inode, &new_dotdot_bh, &new_dotdot_de);
+		err = vfat_get_dotdot_de(new_inode, &new_dotdot_bh,
+					 &new_dotdot_de);
 		if (err)
 			goto out;
 	}
@@ -1110,45 +1089,41 @@ static int vfat_rename_exchange(struct i
 	old_i_pos = MSDOS_I(old_inode)->i_pos;
 	new_i_pos = MSDOS_I(new_inode)->i_pos;
 
-	/* exchange the two dentries */
-	vfat_exchange_dentries(old_inode, new_inode, old_i_pos, new_i_pos);
+	vfat_exchange_ipos(old_inode, new_inode, old_i_pos, new_i_pos);
 
-	err = vfat_sync_after_exchange(old_dir, new_inode);
+	err = vfat_sync_ipos(old_dir, new_inode);
 	if (err)
 		goto error_exchange;
-
-	err = vfat_sync_after_exchange(new_dir, old_inode);
+	err = vfat_sync_ipos(new_dir, old_inode);
 	if (err)
 		goto error_exchange;
 
 	/* update ".." directory entry info */
 	if (old_dotdot_de) {
-		err = vfat_update_dotdot_info(old_dotdot_bh, old_dotdot_de, new_dir, old_inode);
+		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
+					    old_dotdot_de);
 		if (err)
 			goto error_old_dotdot;
-
 		drop_nlink(old_dir);
 		inc_nlink(new_dir);
 	}
 
 	if (new_dotdot_de) {
-		err = vfat_update_dotdot_info(new_dotdot_bh, new_dotdot_de, old_dir, new_inode);
+		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
+					    new_dotdot_de);
 		if (err)
 			goto error_new_dotdot;
-
 		drop_nlink(new_dir);
 		inc_nlink(old_dir);
 	}
 
-	/* update inode version and timestamps */
 	inode_inc_iversion(old_inode);
 	inode_inc_iversion(new_inode);
-
 	vfat_update_dir_metadata(old_dir, &ts);
-
 	/* if directories are not the same, update new_dir as well */
 	if (old_dir != new_dir)
 		vfat_update_dir_metadata(new_dir, &ts);
+
 out:
 	brelse(old_dotdot_bh);
 	brelse(new_dotdot_bh);
@@ -1157,30 +1132,21 @@ out:
 	return err;
 
 error_new_dotdot:
-	/* data cluster is shared, serious corruption */
-	corrupt = 1;
-
 	if (new_dotdot_de) {
-		corrupt |= vfat_update_dotdot_info(new_dotdot_bh, new_dotdot_de,
-						   new_dir, new_inode);
+		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
+						 new_dotdot_bh, new_dotdot_de);
 	}
 
 error_old_dotdot:
-	/* data cluster is shared, serious corruption */
-	corrupt = 1;
-
 	if (old_dotdot_de) {
-		corrupt |= vfat_update_dotdot_info(old_dotdot_bh, old_dotdot_de,
-						   old_dir, old_inode);
+		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
+						 old_dotdot_bh, old_dotdot_de);
 	}
 
 error_exchange:
-	vfat_exchange_dentries(old_inode, new_inode, new_i_pos, old_i_pos);
-
-	if (corrupt) {
-		corrupt |= fat_sync_inode(old_inode);
-		corrupt |= fat_sync_inode(new_inode);
-	}
+	vfat_exchange_ipos(old_inode, new_inode, new_i_pos, old_i_pos);
+	corrupt |= vfat_sync_ipos(new_dir, new_inode);
+	corrupt |= vfat_sync_ipos(old_dir, old_inode);
 
 	if (corrupt < 0) {
 		fat_fs_error(new_dir->i_sb,
@@ -1190,15 +1156,18 @@ error_exchange:
 	goto out;
 }
 
-static int vfat_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
+static int vfat_rename2(struct user_namespace *mnt_userns,
+			struct inode *old_dir,
 			struct dentry *old_dentry, struct inode *new_dir,
 			struct dentry *new_dentry, unsigned int flags)
 {
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
 		return -EINVAL;
 
-	if (flags & RENAME_EXCHANGE)
-		return vfat_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
+	if (flags & RENAME_EXCHANGE) {
+		return vfat_rename_exchange(old_dir, old_dentry,
+					    new_dir, new_dentry);
+	}
 
 	/* VFS already handled RENAME_NOREPLACE, handle it as a normal rename */
 	return vfat_rename(old_dir, old_dentry, new_dir, new_dentry);
_
