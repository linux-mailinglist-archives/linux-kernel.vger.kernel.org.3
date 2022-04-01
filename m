Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA274EE8CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbiDAHHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbiDAHHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:07:41 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FC23FA213;
        Fri,  1 Apr 2022 00:05:51 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id EBFCB1E80CC5;
        Fri,  1 Apr 2022 15:05:21 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hKzsnrIxJeEi; Fri,  1 Apr 2022 15:05:19 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.165])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id ABEB21E80C85;
        Fri,  1 Apr 2022 15:05:18 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] 9p: remove unnecessary type castings
Date:   Fri,  1 Apr 2022 00:05:45 -0700
Message-Id: <20220401070545.50577-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 fs/9p/fid.c            | 2 +-
 fs/9p/v9fs.c           | 2 +-
 fs/9p/vfs_inode.c      | 4 ++--
 fs/9p/vfs_inode_dotl.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 79df61fe0e59..c2b8d7fc9e53 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -53,7 +53,7 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 	p9_debug(P9_DEBUG_VFS, " inode: %p\n", inode);
 
 	spin_lock(&inode->i_lock);
-	h = (struct hlist_head *)&inode->i_private;
+	h = &inode->i_private;
 	hlist_for_each_entry(fid, h, ilist) {
 		if (uid_eq(fid->uid, uid)) {
 			refcount_inc(&fid->count);
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index e28ddf763b3b..51ddc58a7029 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -622,7 +622,7 @@ static void v9fs_sysfs_cleanup(void)
 
 static void v9fs_inode_init_once(void *foo)
 {
-	struct v9fs_inode *v9inode = (struct v9fs_inode *)foo;
+	struct v9fs_inode *v9inode = foo;
 
 	memset(&v9inode->qid, 0, sizeof(v9inode->qid));
 	inode_init_once(&v9inode->vfs_inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 55367ecb9442..f415fd7a1eaf 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -409,7 +409,7 @@ static int v9fs_test_inode(struct inode *inode, void *data)
 	int umode;
 	dev_t rdev;
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
+	struct p9_wstat *st = data;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
 	umode = p9mode2unixmode(v9ses, st, &rdev);
@@ -438,7 +438,7 @@ static int v9fs_test_new_inode(struct inode *inode, void *data)
 static int v9fs_set_inode(struct inode *inode,  void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_wstat *st = (struct p9_wstat *)data;
+	struct p9_wstat *st = data;
 
 	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
 	return 0;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index d17502a738a9..b910fee62e25 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -57,7 +57,7 @@ static kgid_t v9fs_get_fsgid_for_create(struct inode *dir_inode)
 static int v9fs_test_inode_dotl(struct inode *inode, void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
+	struct p9_stat_dotl *st = data;
 
 	/* don't match inode of different type */
 	if (inode_wrong_type(inode, st->st_mode))
@@ -88,7 +88,7 @@ static int v9fs_test_new_inode_dotl(struct inode *inode, void *data)
 static int v9fs_set_inode_dotl(struct inode *inode,  void *data)
 {
 	struct v9fs_inode *v9inode = V9FS_I(inode);
-	struct p9_stat_dotl *st = (struct p9_stat_dotl *)data;
+	struct p9_stat_dotl *st = data;
 
 	memcpy(&v9inode->qid, &st->qid, sizeof(st->qid));
 	inode->i_generation = st->st_gen;
-- 
2.25.1

