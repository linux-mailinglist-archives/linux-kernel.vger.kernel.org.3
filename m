Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A345356E9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348744AbiE0AAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiE0AAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:00:30 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 046AAFD0F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:00:30 -0700 (PDT)
Received: from sequoia.corp.microsoft.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 41E3B20B87F6;
        Thu, 26 May 2022 17:00:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41E3B20B87F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653609629;
        bh=8pdt9j0YTn4gITTYumjXbqE/LEAOIMIl+jNZOjh5y9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqM8ydfpKp1R2Kwm8m7OBlevH7IJIMHPMoCSE1CaHbLVz/LOzrTju7Ar16s7Emix5
         RmZSiXqKjPUnhD8RzfRF61Lt1SR6UQGJ7+C1F9+hczFIgvYrUEckMTPDL0y2chY7Fg
         AW331OC6buNm2EunSqeYeI0BDWQle8Sp9C9XhHSY=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] 9p: Track the root fid with its own variable during lookups
Date:   Thu, 26 May 2022 19:00:00 -0500
Message-Id: <20220527000003.355812-3-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
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

Improve readability by using a new variable when dealing with the root
fid. The root fid requires special handling in comparison to other fids
used during fid lookup.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 fs/9p/fid.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 5a469b79c1ee..dae276ca7f7a 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -152,7 +152,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 	const unsigned char **wnames, *uname;
 	int i, n, l, clone, access;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid, *old_fid;
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
@@ -189,17 +189,18 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
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
 
-		refcount_inc(&fid->count);
-		v9fs_fid_add(dentry->d_sb->s_root, fid);
+		refcount_inc(&root_fid->count);
+		v9fs_fid_add(dentry->d_sb->s_root, root_fid);
 	}
 	/* If we are root ourself just return that */
 	if (dentry->d_sb->s_root == dentry)
-		return fid;
+		return root_fid;
+
 	/*
 	 * Do a multipath walk with attached root.
 	 * When walking parent we need to make sure we
@@ -211,7 +212,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		fid = ERR_PTR(n);
 		goto err_out;
 	}
-	old_fid = fid;
+	fid = root_fid;
+	old_fid = root_fid;
 	clone = 1;
 	i = 0;
 	while (i < n) {
@@ -220,7 +222,7 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
 		 * We need to hold rename lock when doing a multipath
 		 * walk to ensure none of the patch component change
 		 */
-		fid = p9_client_walk(fid, l, &wnames[i], clone);
+		fid = p9_client_walk(old_fid, l, &wnames[i], clone);
 		p9_client_clunk(old_fid);
 		if (IS_ERR(fid)) {
 			kfree(wnames);
-- 
2.25.1

