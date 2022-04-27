Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19D511F65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbiD0QKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242591AbiD0QJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:09:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA26487030;
        Wed, 27 Apr 2022 09:05:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE17A210F4;
        Wed, 27 Apr 2022 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651074995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VbuwhezlBXBYLp3X69XKiAVLFYF1/JeJ3YUoPXX4k7U=;
        b=t11KpoQtzlWU0GhMvKkj6v4n6B4QJUrB0NAWBnFfEzAnMlI+sNNVrpr403O42ZYTF8bpxc
        egXySPu87etU1K/z35uv/u85wClABemH3IZRVHtdsFSx0tD1XfCKi4xehVa8jAjx2eHniL
        iaAX2YIj+5ysZkWTPL11mk0SuFnMdVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651074995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VbuwhezlBXBYLp3X69XKiAVLFYF1/JeJ3YUoPXX4k7U=;
        b=6fuRGT+SZGpND11MoC/2Yrj1m79gSgAsXDHTfkbTajZF8U4QkB3Zcu4fts7haa680rgbEs
        mH7ZyBxoOdv3gdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A97A1323E;
        Wed, 27 Apr 2022 15:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8+1WE7NnaWLTIAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 27 Apr 2022 15:56:35 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a6c62b0f;
        Wed, 27 Apr 2022 15:57:05 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Ryan Taylor <rptaylor@uvic.ca>
Subject: [PATCH v3] ceph: fix statfs for subdir mounts
Date:   Wed, 27 Apr 2022 16:57:04 +0100
Message-Id: <20220427155704.4758-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing a mount using as base a directory that has 'max_bytes' quotas
statfs uses that value as the total; if a subdirectory is used instead,
the same 'max_bytes' too in statfs, unless there is another quota set.

Unfortunately, if this subdirectory only has the 'max_files' quota set,
then statfs uses the filesystem total.  Fix this by making sure we only
lookup realms that contain the 'max_bytes' quota.

Link: https://tracker.ceph.com/issues/55090
Cc: Ryan Taylor <rptaylor@uvic.ca>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Changes since v2:
Renamed function __ceph_has_any_quota() to __ceph_has_quota()

Changes since v1:
Moved some more logic into __ceph_has_any_quota() function.

 fs/ceph/inode.c |  2 +-
 fs/ceph/quota.c | 19 +++++++++++--------
 fs/ceph/super.h | 28 ++++++++++++++++++++++++----
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5de7bb9048b7..1067209cf6f6 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -691,7 +691,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	__ceph_remove_caps(ci);
 
-	if (__ceph_has_any_quota(ci))
+	if (__ceph_has_quota(ci, QUOTA_GET_ANY))
 		ceph_adjust_quota_realms_count(inode, false);
 
 	/*
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index a338a3ec0dc4..64592adfe48f 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -195,9 +195,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
 
 /*
  * This function walks through the snaprealm for an inode and returns the
- * ceph_snap_realm for the first snaprealm that has quotas set (either max_files
- * or max_bytes).  If the root is reached, return the root ceph_snap_realm
- * instead.
+ * ceph_snap_realm for the first snaprealm that has quotas set (max_files,
+ * max_bytes, or any, depending on the 'which_quota' argument).  If the root is
+ * reached, return the root ceph_snap_realm instead.
  *
  * Note that the caller is responsible for calling ceph_put_snap_realm() on the
  * returned realm.
@@ -209,7 +209,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
  * will be restarted.
  */
 static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
-					       struct inode *inode, bool retry)
+					       struct inode *inode,
+					       enum quota_get_realm which_quota,
+					       bool retry)
 {
 	struct ceph_inode_info *ci = NULL;
 	struct ceph_snap_realm *realm, *next;
@@ -248,7 +250,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 		}
 
 		ci = ceph_inode(in);
-		has_quota = __ceph_has_any_quota(ci);
+		has_quota = __ceph_has_quota(ci, which_quota);
 		iput(in);
 
 		next = realm->parent;
@@ -279,8 +281,8 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
 	 * dropped and we can then restart the whole operation.
 	 */
 	down_read(&mdsc->snap_rwsem);
-	old_realm = get_quota_realm(mdsc, old, true);
-	new_realm = get_quota_realm(mdsc, new, false);
+	old_realm = get_quota_realm(mdsc, old, QUOTA_GET_ANY, true);
+	new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
 	if (PTR_ERR(new_realm) == -EAGAIN) {
 		up_read(&mdsc->snap_rwsem);
 		if (old_realm)
@@ -483,7 +485,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
 	bool is_updated = false;
 
 	down_read(&mdsc->snap_rwsem);
-	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
+	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
+				QUOTA_GET_MAX_BYTES, true);
 	up_read(&mdsc->snap_rwsem);
 	if (!realm)
 		return false;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a2e1c83ab29a..0ecde1c12fee 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1317,9 +1317,29 @@ extern void ceph_fs_debugfs_init(struct ceph_fs_client *client);
 extern void ceph_fs_debugfs_cleanup(struct ceph_fs_client *client);
 
 /* quota.c */
-static inline bool __ceph_has_any_quota(struct ceph_inode_info *ci)
+
+enum quota_get_realm {
+	QUOTA_GET_MAX_FILES,
+	QUOTA_GET_MAX_BYTES,
+	QUOTA_GET_ANY
+};
+
+static inline bool __ceph_has_quota(struct ceph_inode_info *ci,
+				    enum quota_get_realm which)
 {
-	return ci->i_max_files || ci->i_max_bytes;
+	bool has_quota = false;
+
+	switch (which) {
+	case QUOTA_GET_MAX_BYTES:
+		has_quota = !!ci->i_max_bytes;
+		break;
+	case QUOTA_GET_MAX_FILES:
+		has_quota = !!ci->i_max_files;
+		break;
+	default:
+		has_quota = !!(ci->i_max_files || ci->i_max_bytes);
+	}
+	return has_quota;
 }
 
 extern void ceph_adjust_quota_realms_count(struct inode *inode, bool inc);
@@ -1328,10 +1348,10 @@ static inline void __ceph_update_quota(struct ceph_inode_info *ci,
 				       u64 max_bytes, u64 max_files)
 {
 	bool had_quota, has_quota;
-	had_quota = __ceph_has_any_quota(ci);
+	had_quota = __ceph_has_quota(ci, QUOTA_GET_ANY);
 	ci->i_max_bytes = max_bytes;
 	ci->i_max_files = max_files;
-	has_quota = __ceph_has_any_quota(ci);
+	has_quota = __ceph_has_quota(ci, QUOTA_GET_ANY);
 
 	if (had_quota != has_quota)
 		ceph_adjust_quota_realms_count(&ci->vfs_inode, has_quota);
