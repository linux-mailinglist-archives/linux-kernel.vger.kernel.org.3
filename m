Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DDF52EB3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbiETLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346944AbiETLxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:53:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62B55A156;
        Fri, 20 May 2022 04:53:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74B0121B21;
        Fri, 20 May 2022 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653047630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=odZCkoyt1raniMI756SQp0+X5fym2vW4nS/PB0RUy+o=;
        b=H3TTGCzguH+hUwZQMY03Hmo66+CToYMwEvjEp8WPenkvKXYhjYlXAb0W4+4EVkUQTuzbLU
        2bouSzGIrifL0BhloT1sru2QWyjpCXkHlwsgtt4MPIXmZCz7S1mGSmrQt/I7DEok82maz6
        YGEgUga6qO8wV5MWUjNm+L64DzgqVOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653047630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=odZCkoyt1raniMI756SQp0+X5fym2vW4nS/PB0RUy+o=;
        b=idKjf09Uliga1F+wR/EV9gSsWXnfW3xdRgE4hKC/Hj3ucqSso4MxIVze6W/9vIO0fcWKBp
        CcRJ3T7eRIjP2yBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 016AF13AF4;
        Fri, 20 May 2022 11:53:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1OBzOE2Bh2JBNgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 20 May 2022 11:53:49 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id cf0f8a7d;
        Fri, 20 May 2022 11:54:27 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH] ceph: try to prevent exceeding the MDS maximum xattr size
Date:   Fri, 20 May 2022 12:54:26 +0100
Message-Id: <20220520115426.438-1-lhenriques@suse.de>
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

This patch forces the usage of the synchronous operation if xattrs size hits
the maximum size that is set on the MDS by default (64k).

While there, fix a dout() that would trigger a printk warning:

[   98.718078] ------------[ cut here ]------------
[   98.719012] precision 65536 too large
[   98.719039] WARNING: CPU: 1 PID: 3755 at lib/vsprintf.c:2703 vsnprintf+0x5e3/0x600
...

URL: https://tracker.ceph.com/issues/55725
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/xattr.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index afec84088471..09751a5f028c 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -15,6 +15,12 @@
 #define XATTR_CEPH_PREFIX "ceph."
 #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
 
+/*
+ * Maximum size of xattrs the MDS can handle per inode by default.  This
+ * includes the attribute name and 4+4 bytes for the key/value sizes.
+ */
+#define MDS_MAX_XATTR_PAIRS_SIZE (1<<16) /* 64K */
+
 static int __remove_xattr(struct ceph_inode_info *ci,
 			  struct ceph_inode_xattr *xattr);
 
@@ -1078,7 +1084,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			flags |= CEPH_XATTR_REMOVE;
 	}
 
-	dout("setxattr value=%.*s\n", (int)size, value);
+	dout("setxattr value size: ld\n", size);
 
 	/* do request */
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
@@ -1176,8 +1182,13 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	spin_lock(&ci->i_ceph_lock);
 retry:
 	issued = __ceph_caps_issued(ci, NULL);
-	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
+	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
+	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
+	    (required_blob_size >= MDS_MAX_XATTR_PAIRS_SIZE)) {
+		dout("%s do sync setxattr: version: %llu blob size: %d\n",
+		     __func__, ci->i_xattrs.version, required_blob_size);
 		goto do_sync;
+	}
 
 	if (!lock_snap_rwsem && !ci->i_head_snapc) {
 		lock_snap_rwsem = true;
@@ -1193,8 +1204,6 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	     ceph_cap_string(issued));
 	__build_xattrs(inode);
 
-	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
-
 	if (!ci->i_xattrs.prealloc_blob ||
 	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
 		struct ceph_buffer *blob;
