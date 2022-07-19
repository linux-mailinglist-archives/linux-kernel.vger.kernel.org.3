Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B39579485
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiGSHs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiGSHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:48:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6442240AD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:48:19 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ln9p55XX6zVgZD;
        Tue, 19 Jul 2022 15:44:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 15:48:02 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:48:01 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <chengzhihao1@huawei.com>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
Subject: [PATCH] ubifs: Fix AA deadlock when setting xattr for encrypted file
Date:   Tue, 19 Jul 2022 16:00:17 +0800
Message-ID: <20220719080017.1595777-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following process:
vfs_setxattr(host)
  ubifs_xattr_set
    down_write(host_ui->xattr_sem)   <- lock first time
      create_xattr
        ubifs_new_inode(host)
          fscrypt_prepare_new_inode(host)
            fscrypt_policy_to_inherit(host)
              if (IS_ENCRYPTED(inode))
                fscrypt_require_key(host)
                  fscrypt_get_encryption_info(host)
                    ubifs_xattr_get(host)
                      down_read(host_ui->xattr_sem) <- AA deadlock

, which may trigger an AA deadlock problem:

[  102.620871] INFO: task setfattr:1599 blocked for more than 10 seconds.
[  102.625298]       Not tainted 5.19.0-rc7-00001-gb666b6823ce0-dirty #711
[  102.628732] task:setfattr        state:D stack:    0 pid: 1599
[  102.628749] Call Trace:
[  102.628753]  <TASK>
[  102.628776]  __schedule+0x482/0x1060
[  102.629964]  schedule+0x92/0x1a0
[  102.629976]  rwsem_down_read_slowpath+0x287/0x8c0
[  102.629996]  down_read+0x84/0x170
[  102.630585]  ubifs_xattr_get+0xd1/0x370 [ubifs]
[  102.630730]  ubifs_crypt_get_context+0x1f/0x30 [ubifs]
[  102.630791]  fscrypt_get_encryption_info+0x7d/0x1c0
[  102.630810]  fscrypt_policy_to_inherit+0x56/0xc0
[  102.630817]  fscrypt_prepare_new_inode+0x35/0x160
[  102.630830]  ubifs_new_inode+0xcc/0x4b0 [ubifs]
[  102.630873]  ubifs_xattr_set+0x591/0x9f0 [ubifs]
[  102.630961]  xattr_set+0x8c/0x3e0 [ubifs]
[  102.631003]  __vfs_setxattr+0x71/0xc0
[  102.631026]  vfs_setxattr+0x105/0x270
[  102.631034]  do_setxattr+0x6d/0x110
[  102.631041]  setxattr+0xa0/0xd0
[  102.631087]  __x64_sys_setxattr+0x2f/0x40

Fetch a reproducer in [Link].

Just like ext4 does, which skips encrypting for inode with
EXT4_EA_INODE_FL flag. Stop encypting xattr inode for ubifs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216260
Fixes: f4e3634a3b64222 ("ubifs: Fix races between xattr_{set|get} ...")
Fixes: d475a507457b5ca ("ubifs: Add skeleton for fscrypto")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/dir.c   | 25 ++++++++++++++-----------
 fs/ubifs/ubifs.h |  2 +-
 fs/ubifs/xattr.c |  2 +-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 86151889548e..bc11276301fd 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -68,13 +68,14 @@ static int inherit_flags(const struct inode *dir, umode_t mode)
  * @c: UBIFS file-system description object
  * @dir: parent directory inode
  * @mode: inode mode flags
+ * @is_xattr: whether the inode is xattr inode
  *
  * This function finds an unused inode number, allocates new inode and
  * initializes it. Returns new inode in case of success and an error code in
  * case of failure.
  */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
-			      umode_t mode)
+			      umode_t mode, bool is_xattr)
 {
 	int err;
 	struct inode *inode;
@@ -99,10 +100,12 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 			 current_time(inode);
 	inode->i_mapping->nrpages = 0;
 
-	err = fscrypt_prepare_new_inode(dir, inode, &encrypted);
-	if (err) {
-		ubifs_err(c, "fscrypt_prepare_new_inode failed: %i", err);
-		goto out_iput;
+	if (!is_xattr) {
+		err = fscrypt_prepare_new_inode(dir, inode, &encrypted);
+		if (err) {
+			ubifs_err(c, "fscrypt_prepare_new_inode failed: %i", err);
+			goto out_iput;
+		}
 	}
 
 	switch (mode & S_IFMT) {
@@ -309,7 +312,7 @@ static int ubifs_create(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
@@ -370,7 +373,7 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	if (err)
 		return ERR_PTR(err);
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_free;
@@ -462,7 +465,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 		return err;
 	}
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_budg;
@@ -1004,7 +1007,7 @@ static int ubifs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, S_IFDIR | mode);
+	inode = ubifs_new_inode(c, dir, S_IFDIR | mode, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
@@ -1091,7 +1094,7 @@ static int ubifs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, mode);
+	inode = ubifs_new_inode(c, dir, mode, false);
 	if (IS_ERR(inode)) {
 		kfree(dev);
 		err = PTR_ERR(inode);
@@ -1173,7 +1176,7 @@ static int ubifs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 
 	sz_change = CALC_DENT_SIZE(fname_len(&nm));
 
-	inode = ubifs_new_inode(c, dir, S_IFLNK | S_IRWXUGO);
+	inode = ubifs_new_inode(c, dir, S_IFLNK | S_IRWXUGO, false);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_fname;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 7d6d2f152e03..478bbbb5382f 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2026,7 +2026,7 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time, int flags);
 
 /* dir.c */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
-			      umode_t mode);
+			      umode_t mode, bool is_xattr);
 int ubifs_getattr(struct user_namespace *mnt_userns, const struct path *path, struct kstat *stat,
 		  u32 request_mask, unsigned int flags);
 int ubifs_check_dir_empty(struct inode *dir);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index e4c4761aff7f..3db8486e3725 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -110,7 +110,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 	if (err)
 		return err;
 
-	inode = ubifs_new_inode(c, host, S_IFREG | S_IRWXUGO);
+	inode = ubifs_new_inode(c, host, S_IFREG | S_IRWXUGO, true);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out_budg;
-- 
2.31.1

