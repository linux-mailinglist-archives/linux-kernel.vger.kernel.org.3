Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799FD5102EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352808AbiDZQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbiDZQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:14:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CDD9A9A7;
        Tue, 26 Apr 2022 09:11:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E3051F380;
        Tue, 26 Apr 2022 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650989496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g6ykGUukp+fKk1ilY1BWV9rT8pwISCf1/1RZl1i49JA=;
        b=Z5wMDSSH0NV5rrH+auRARz46CA/8MFeIT0UvniY0GVWXTqMvxNB801SQsuV3sBROWLRGXH
        CNDi0jtEJ0sNp+KCzFEjL/CQVFT+rAdPiW59KeT9TSNOUGFTNMTQWXGiH97lT26XcbPQKw
        4SCaa+VP+1/X/NivBkm0dGhK+0YUIX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650989496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g6ykGUukp+fKk1ilY1BWV9rT8pwISCf1/1RZl1i49JA=;
        b=DVhesvHl3LDTQowiqc8Y5a0pc9N3V/wJCLuJj5cEpx4AkQfSe+9+p9SQ76jG67d8lZXCbW
        qIQ69bHlu9MwjTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8000E13223;
        Tue, 26 Apr 2022 16:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o5WRHLcZaGLJeQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 26 Apr 2022 16:11:35 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 8bd29aa5;
        Tue, 26 Apr 2022 16:12:06 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Ryan Taylor <rptaylor@uvic.ca>
Subject: [PATCH] ceph: fix statfs for subdir mounts
Date:   Tue, 26 Apr 2022 17:12:04 +0100
Message-Id: <20220426161204.17896-1-lhenriques@suse.de>
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
Hi!

Unfortunately, I don't think this is the real fix for the bug reported in
the tracker (or by Ryan on the mailing-list).  I haven't seen any
reference to 'max_files' so I suspect Ryan and Dan are hitting another
bug.  This can be easily checked by 'getfattr -n ceph.quota <subdir>'.

Also, Dan (in the tracker) states the bug is on the kernel client only but
I can also see if in the fuse client.

Anyway, this patch fixes a real bug.

 fs/ceph/quota.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index a338a3ec0dc4..235a8d06a8ee 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -193,11 +193,17 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
 	mutex_unlock(&mdsc->quotarealms_inodes_mutex);
 }
 
+enum quota_get_realm {
+	QUOTA_GET_MAX_FILES,
+	QUOTA_GET_MAX_BYTES,
+	QUOTA_GET_ANY
+};
+
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
@@ -209,7 +215,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
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
@@ -248,7 +256,17 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 		}
 
 		ci = ceph_inode(in);
-		has_quota = __ceph_has_any_quota(ci);
+		switch (which_quota) {
+		case QUOTA_GET_MAX_BYTES:
+			has_quota = ci->i_max_bytes;
+			break;
+		case QUOTA_GET_MAX_FILES:
+			has_quota = ci->i_max_files;
+			break;
+		default: /* QUOTA_GET_ANY */
+			has_quota = __ceph_has_any_quota(ci);
+			break;
+		}
 		iput(in);
 
 		next = realm->parent;
@@ -279,8 +297,8 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
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
@@ -483,7 +501,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
 	bool is_updated = false;
 
 	down_read(&mdsc->snap_rwsem);
-	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
+	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
+				QUOTA_GET_MAX_BYTES, true);
 	up_read(&mdsc->snap_rwsem);
 	if (!realm)
 		return false;
