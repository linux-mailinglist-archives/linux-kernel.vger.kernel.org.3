Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2565B53AB0A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355548AbiFAQ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243359AbiFAQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:29:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C4941B9;
        Wed,  1 Jun 2022 09:29:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DDB4121A30;
        Wed,  1 Jun 2022 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654100941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w3DcqKkJjZxj1reVW9md3wTOs1U0Ns1YkJ/9eIz+FTI=;
        b=eozbooOhLbLSsV1UMiNjKI8EpIKg9SC4AawqwCEDoCzhyU6N79FaTZhZNgTPJzvVHIC+xa
        wXirF7cTj8Xa59y92XFjB/oslobwXVVkdU5sjYgSFiFAG+bqeU7K25wd91Hy4fKh0PMjZn
        /5EYdNls6XwxMtwuhkXrxx2e2ZFgqXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654100941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w3DcqKkJjZxj1reVW9md3wTOs1U0Ns1YkJ/9eIz+FTI=;
        b=KLyJKgMa36LedXK0gB6fZNcfjzp5i8mhuVkg6jmhjj17fAEM2kdMzU/EbB4OS7oSKlUa/L
        fU4V0Oa4KBlKv1CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DD9813A8F;
        Wed,  1 Jun 2022 16:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fD4LGM2Tl2IzUAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 01 Jun 2022 16:29:01 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 5f5451d9;
        Wed, 1 Jun 2022 16:29:40 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Gregory Farnum <gfarnum@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH v3] ceph: prevent a client from exceeding the MDS maximum xattr size
Date:   Wed,  1 Jun 2022 17:29:39 +0100
Message-Id: <20220601162939.12278-1-lhenriques@suse.de>
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

This patch adds support for decoding the xattrs maximum size setting that is
distributed in the mdsmap.  Then, when setting an xattr, the kernel client
will revert to do a synchronous operation if that maximum size is exceeded.

While there, fix a dout() that would trigger a printk warning:

[   98.718078] ------------[ cut here ]------------
[   98.719012] precision 65536 too large
[   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf+0x5e3/0x600
...

URL: https://tracker.ceph.com/issues/55725
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/mdsmap.c            | 27 +++++++++++++++++++++++----
 fs/ceph/xattr.c             | 12 ++++++++----
 include/linux/ceph/mdsmap.h |  1 +
 3 files changed, 32 insertions(+), 8 deletions(-)

* Changes since v2

Well, a lot has changed since v2!  Now the xattr max value setting is
obtained through the mdsmap, which needs to be decoded, and the feature
that was used in the previous revision was dropped.  The drawback is that
the MDS isn't unable to know in advance if a client is aware of this xattr
max value.

* Changes since v1

Added support for new feature bit to get the MDS max_xattr_pairs_size
setting.

Also note that this patch relies on a patch that hasn't been merged yet
("ceph: use correct index when encoding client supported features"),
otherwise the new feature bit won't be correctly encoded.

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 30387733765d..36b2bc18ca2a 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -13,6 +13,12 @@
 
 #include "super.h"
 
+/*
+ * Maximum size of xattrs the MDS can handle per inode by default.  This
+ * includes the attribute name and 4+4 bytes for the key/value sizes.
+ */
+#define MDS_MAX_XATTR_SIZE (1<<16) /* 64K */
+
 #define CEPH_MDS_IS_READY(i, ignore_laggy) \
 	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
 
@@ -352,12 +358,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
 		__decode_and_drop_type(p, end, u8, bad_ext);
 	}
 	if (mdsmap_ev >= 8) {
-		u32 name_len;
 		/* enabled */
 		ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
-		ceph_decode_32_safe(p, end, name_len, bad_ext);
-		ceph_decode_need(p, end, name_len, bad_ext);
-		*p += name_len;
+		/* fs_name */
+		ceph_decode_skip_string(p, end, bad_ext);
 	}
 	/* damaged */
 	if (mdsmap_ev >= 9) {
@@ -370,6 +374,21 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
 	} else {
 		m->m_damaged = false;
 	}
+	if (mdsmap_ev >= 17) {
+		/* balancer */
+		ceph_decode_skip_string(p, end, bad_ext);
+		/* standby_count_wanted */
+		ceph_decode_skip_32(p, end, bad_ext);
+		/* old_max_mds */
+		ceph_decode_skip_32(p, end, bad_ext);
+		/* min_compat_client */
+		ceph_decode_skip_8(p, end, bad_ext);
+		/* required_client_features */
+		ceph_decode_skip_set(p, end, 64, bad_ext);
+		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
+	} else {
+		m->m_max_xattr_size = MDS_MAX_XATTR_SIZE;
+	}
 bad_ext:
 	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
 	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 8c2dc2c762a4..67f046dac35c 100644
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
+	    (required_blob_size >= mdsc->mdsmap->m_max_xattr_size)) {
+		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
+		     __func__, ci->i_xattrs.version, required_blob_size,
+		     mdsc->mdsmap->m_max_xattr_size);
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
diff --git a/include/linux/ceph/mdsmap.h b/include/linux/ceph/mdsmap.h
index 523fd0452856..4c3e0648dc27 100644
--- a/include/linux/ceph/mdsmap.h
+++ b/include/linux/ceph/mdsmap.h
@@ -25,6 +25,7 @@ struct ceph_mdsmap {
 	u32 m_session_timeout;          /* seconds */
 	u32 m_session_autoclose;        /* seconds */
 	u64 m_max_file_size;
+	u64 m_max_xattr_size;		/* maximum size for xattrs blob */
 	u32 m_max_mds;			/* expected up:active mds number */
 	u32 m_num_active_mds;		/* actual up:active mds number */
 	u32 possible_max_rank;		/* possible max rank index */
