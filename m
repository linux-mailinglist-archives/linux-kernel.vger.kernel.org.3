Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D792D534224
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245661AbiEYRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiEYRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:23:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A395A34;
        Wed, 25 May 2022 10:23:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01CC41F897;
        Wed, 25 May 2022 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653499433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6qP67cQkbfdwGwYUYrK9vkjemtwnVTSyEF2Iosy1P/8=;
        b=oTCyXpCmzqlmjVnYszS+cBLQNp+21ld+4SES/K+A6d6mrMqg2wasaXwPp0AnrIG2Eoi1Cc
        1tPk0R+dQhOQKcbTSVe+KsrTdBF2RLFFOOjQm4iEED7qQWY6PgUrT7oAzZdTlomkXRzYUQ
        ugvwjvIiJdn3oQRg6slrXdDFwr2SKfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653499433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6qP67cQkbfdwGwYUYrK9vkjemtwnVTSyEF2Iosy1P/8=;
        b=W/W0n83VL9Wg1HoiRSNld28OQaHegHgpWReZkEEd8uz/ao0AfOPmnI7yBj3LuZ4ru8UTPu
        xDh+tYBHZsOPw9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 824F513ADF;
        Wed, 25 May 2022 17:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +R0kHChmjmJ4PQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 25 May 2022 17:23:52 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 37a1b265;
        Wed, 25 May 2022 17:24:28 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH v2] ceph: prevent a client from exceeding the MDS maximum xattr size
Date:   Wed, 25 May 2022 18:24:27 +0100
Message-Id: <20220525172427.3692-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MDS tries to enforce a limit on the total key/values in extended
attributes.  However, this limit is enforced only if doing a synchronous
operation (MDS_OP_SETXATTR) -- if we're buffering the xattrs, the MDS
doesn't have a chance to enforce these limits.

This patch adds support for an extra feature bit that will allow the
client to get the MDS max_xattr_pairs_size setting in the session message.
Then, when setting an xattr, the kernel will revert to do a synchronous
operation if that maximum size is exceeded.

While there, fix a dout() that would trigger a printk warning:

[   98.718078] ------------[ cut here ]------------
[   98.719012] precision 65536 too large
[   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf+0x5e3/0x600
...

URL: https://tracker.ceph.com/issues/55725
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/mds_client.c | 12 ++++++++++++
 fs/ceph/mds_client.h | 15 ++++++++++++++-
 fs/ceph/xattr.c      | 12 ++++++++----
 3 files changed, 34 insertions(+), 5 deletions(-)

* Changes since v1

Added support for new feature bit to get the MDS max_xattr_pairs_size
setting.

Also note that this patch relies on a patch that hasn't been merged yet
("ceph: use correct index when encoding client supported features"),
otherwise the new feature bit won't be correctly encoded.

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 35597fafb48c..87a25b7cf496 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3500,6 +3500,7 @@ static void handle_session(struct ceph_mds_session *session,
 	struct ceph_mds_session_head *h;
 	u32 op;
 	u64 seq, features = 0;
+	u64 max_xattr_pairs_size = 0;
 	int wake = 0;
 	bool blocklisted = false;
 
@@ -3545,6 +3546,9 @@ static void handle_session(struct ceph_mds_session *session,
 		}
 	}
 
+	if (msg_version >= 6)
+		ceph_decode_64_safe(&p, end, max_xattr_pairs_size, bad);
+
 	mutex_lock(&mdsc->mutex);
 	if (op == CEPH_SESSION_CLOSE) {
 		ceph_get_mds_session(session);
@@ -3552,6 +3556,12 @@ static void handle_session(struct ceph_mds_session *session,
 	}
 	/* FIXME: this ttl calculation is generous */
 	session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
+
+	if (max_xattr_pairs_size && (op == CEPH_SESSION_OPEN)) {
+		dout("Changing MDS max xattrs pairs size: %llu => %llu\n",
+		     mdsc->max_xattr_pairs_size, max_xattr_pairs_size);
+		mdsc->max_xattr_pairs_size = max_xattr_pairs_size;
+	}
 	mutex_unlock(&mdsc->mutex);
 
 	mutex_lock(&session->s_mutex);
@@ -4761,6 +4771,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	strscpy(mdsc->nodename, utsname()->nodename,
 		sizeof(mdsc->nodename));
 
+	mdsc->max_xattr_pairs_size = MDS_MAX_XATTR_PAIRS_SIZE;
+
 	fsc->mdsc = mdsc;
 	return 0;
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index ca32f26f5eed..3db777df6d88 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -29,8 +29,11 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_MULTI_RECONNECT,
 	CEPHFS_FEATURE_DELEG_INO,
 	CEPHFS_FEATURE_METRIC_COLLECT,
+	CEPHFS_FEATURE_ALTERNATE_NAME,
+	CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
+	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
 
-	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
+	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,
 };
 
 /*
@@ -45,9 +48,16 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_MULTI_RECONNECT,		\
 	CEPHFS_FEATURE_DELEG_INO,		\
 	CEPHFS_FEATURE_METRIC_COLLECT,		\
+	CEPHFS_FEATURE_MAX_XATTR_PAIRS_SIZE,	\
 }
 #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
 
+/*
+ * Maximum size of xattrs the MDS can handle per inode by default.  This
+ * includes the attribute name and 4+4 bytes for the key/value sizes.
+ */
+#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
+
 /*
  * Some lock dependencies:
  *
@@ -404,6 +414,9 @@ struct ceph_mds_client {
 	struct rb_root		quotarealms_inodes;
 	struct mutex		quotarealms_inodes_mutex;
 
+	/* maximum aggregate size of extended attributes on a file */
+	u64			max_xattr_pairs_size;
+
 	/*
 	 * snap_rwsem will cover cap linkage into snaprealms, and
 	 * realm snap contexts.  (later, we can do per-realm snap
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 8c2dc2c762a4..175a8c1449aa 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1086,7 +1086,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			flags |= CEPH_XATTR_REMOVE;
 	}
 
-	dout("setxattr value=%.*s\n", (int)size, value);
+	dout("setxattr value size: %ld\n", size);
 
 	/* do request */
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
@@ -1184,8 +1184,14 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	spin_lock(&ci->i_ceph_lock);
 retry:
 	issued = __ceph_caps_issued(ci, NULL);
-	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
+	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
+	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
+	    (required_blob_size >= mdsc->max_xattr_pairs_size)) {
+		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
+		     __func__, ci->i_xattrs.version, required_blob_size,
+		     mdsc->max_xattr_pairs_size);
 		goto do_sync;
+	}
 
 	if (!lock_snap_rwsem && !ci->i_head_snapc) {
 		lock_snap_rwsem = true;
@@ -1201,8 +1207,6 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	     ceph_cap_string(issued));
 	__build_xattrs(inode);
 
-	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
-
 	if (!ci->i_xattrs.prealloc_blob ||
 	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
 		struct ceph_buffer *blob;
