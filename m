Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39A5342F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245507AbiEYS0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiEYS0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:26:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E34F0AE26A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:26:10 -0700 (PDT)
Received: from sequoia.devices.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 948C520B71D5;
        Wed, 25 May 2022 11:26:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 948C520B71D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653503170;
        bh=Fx2o1UKyCtXuLFMagMlAZHz2PLJ3sQHCswAQMFJT72o=;
        h=From:To:Cc:Subject:Date:From;
        b=cFa7NWuKO39idKR0xQYCp3RGC7l9QJYw1uA/8A9dqCFNgOZjcInCLM8M1b1FbAauj
         FHY2DP7GM8rhKpBEG+u7Gz6Jg+36is1vcmc2Sn1Yl/3OSdbLZrSEanFJ6oWcUGEBYD
         9vBx0oGq8xqOjywQfhzEHbleq8pxgL4hrvQswBlc=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: Fix refcounting during full path walks for fid lookups
Date:   Wed, 25 May 2022 13:25:30 -0500
Message-Id: <20220525182530.266068-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decrement the refcount of the parent dentry's fid after walking
each path component during a full path walk for a lookup. Failure to do
so can lead to fids that are not clunked until the filesystem is
unmounted, as indicated by this warning:

 9pnet: found fid 3 not clunked

The improper refcounting after walking resulted in open(2) returning
-EIO on any directories underneath the mount point when using the virtio
transport. When using the fd transport, there's no apparent issue until
the filesytem is unmounted and the warning above is emitted to the logs.

In some cases, the user may not yet be attached to the filesystem and a
new root fid, associated with the user, is created and attached to the
root dentry before the full path walk is performed. Increment the new
root fid's refcount to two in that situation so that it can be safely
decremented to one after it is used for the walk operation. The new fid
will still be attached to the root dentry when
v9fs_fid_lookup_with_uid() returns so a final refcount of one is
correct/expected.

Include a small readability improvement by using a new variable when
dealing with the root fid as it requires special handling not necessary
with non-root fids.

Fixes: 6636b6dcc3db ("9p: add refcount to p9_fid struct")
Cc: stable@vger.kernel.org
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 fs/9p/fid.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 79df61fe0e59..dfe98a308612 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -150,9 +150,9 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 {
 	struct dentry *ds;
 	const unsigned char **wnames, *uname;
-	int i, n, l, clone, access;
+	int i, n, l, access;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid, *old_fid = NULL;
+	struct p9_fid *fid, *root_fid, *old_fid;
 
 	v9ses = v9fs_dentry2v9ses(dentry);
 	access = v9ses->flags & V9FS_ACCESS_MASK;
@@ -178,8 +178,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 	up_read(&v9ses->rename_sem);
 
 	/* start from the root and try to do a lookup */
-	fid = v9fs_fid_find(dentry->d_sb->s_root, uid, any);
-	if (!fid) {
+	root_fid = v9fs_fid_find(dentry->d_sb->s_root, uid, any);
+	if (!root_fid) {
 		/* the user is not attached to the fs yet */
 		if (access == V9FS_ACCESS_SINGLE)
 			return ERR_PTR(-EPERM);
@@ -189,18 +189,18 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		else
 			uname = v9ses->uname;
 
-		fid = p9_client_attach(v9ses->clnt, NULL, uname, uid,
-				       v9ses->aname);
-		if (IS_ERR(fid))
-			return fid;
+		root_fid = p9_client_attach(v9ses->clnt, NULL, uname, uid,
+					    v9ses->aname);
+		if (IS_ERR(root_fid))
+			return root_fid;
 
-		v9fs_fid_add(dentry->d_sb->s_root, fid);
+		refcount_inc(&root_fid->count);
+		v9fs_fid_add(dentry->d_sb->s_root, root_fid);
 	}
 	/* If we are root ourself just return that */
-	if (dentry->d_sb->s_root == dentry) {
-		refcount_inc(&fid->count);
-		return fid;
-	}
+	if (dentry->d_sb->s_root == dentry)
+		return root_fid;
+
 	/*
 	 * Do a multipath walk with attached root.
 	 * When walking parent we need to make sure we
@@ -212,7 +212,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		fid = ERR_PTR(n);
 		goto err_out;
 	}
-	clone = 1;
+	fid = root_fid;
+	old_fid = root_fid;
 	i = 0;
 	while (i < n) {
 		l = min(n - i, P9_MAXWELEM);
@@ -220,22 +221,15 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		 * We need to hold rename lock when doing a multipath
 		 * walk to ensure none of the patch component change
 		 */
-		fid = p9_client_walk(fid, l, &wnames[i], clone);
+		fid = p9_client_walk(old_fid, l, &wnames[i],
+				     old_fid == root_fid);
+		p9_client_clunk(old_fid);
 		if (IS_ERR(fid)) {
-			if (old_fid) {
-				/*
-				 * If we fail, clunk fid which are mapping
-				 * to path component and not the last component
-				 * of the path.
-				 */
-				p9_client_clunk(old_fid);
-			}
 			kfree(wnames);
 			goto err_out;
 		}
 		old_fid = fid;
 		i += l;
-		clone = 0;
 	}
 	kfree(wnames);
 fid_out:
-- 
2.25.1

