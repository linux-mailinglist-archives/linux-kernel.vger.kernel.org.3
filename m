Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A967A4C2ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiBXLWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiBXLWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:22:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259B1CE;
        Thu, 24 Feb 2022 03:21:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F23651F37F;
        Thu, 24 Feb 2022 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645701690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oJU8mNCuvdPjtG+kxUCL1MNwiSJQCMqrnSDUyRWAPys=;
        b=fbrLd3uYGGuF/+gtgOTc42jy43SBVwMaRLN9Jyjq5Q7kJTFS2NCF/eGWTFihYz3ZuVAO/W
        2Xu155AIWIa5aQE2Yn3kqLHhqurbQ+J8vibQwWSMCIjzpjO7ODhCKl7S5JRnMnSDIvcz3I
        KEd7y3uTKgMSv9d0SiU2rdws2TYqFRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645701690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oJU8mNCuvdPjtG+kxUCL1MNwiSJQCMqrnSDUyRWAPys=;
        b=pimrS9guo0/mLaKBn4sTcUW5Kr+erSaQ5pN956+PIe12zIFsX+NuJKBHZAHm8mzWD0gQgZ
        YGrZG6YXWfuNI4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82DF6139F3;
        Thu, 24 Feb 2022 11:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IsL4HDlqF2IHWAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 24 Feb 2022 11:21:29 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b5956cca;
        Thu, 24 Feb 2022 11:21:43 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH] ceph: add support for encrypted snapshot names
Date:   Thu, 24 Feb 2022 11:21:42 +0000
Message-Id: <20220224112142.18052-1-lhenriques@suse.de>
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

Since filenames in encrypted directories are already encrypted and shown
as a base64-encoded string when the directory is locked, snapshot names
should show a similar behaviour.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/dir.c   | 15 +++++++++++++++
 fs/ceph/inode.c | 10 +++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

Support on the MDS for names that'll be > MAX_NAME when base64 encoded is
still TBD.  I thought it would be something easy to do, but snapshots
don't seem to make use of the CDir/CDentry (which is where alternate_name
is stored on the MDS).  I'm still looking into this, but I may need some
help there :-(

Cheers,
--
Luís

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a449f4a07c07..20ae600ee7cd 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1065,6 +1065,13 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		op = CEPH_MDS_OP_MKSNAP;
 		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
 		     dentry, dentry);
+		/* XXX missing support for alternate_name in snapshots */
+		if (IS_ENCRYPTED(dir) && (dentry->d_name.len >= 189)) {
+			dout("encrypted snapshot name too long: %pd len: %d\n",
+			     dentry, dentry->d_name.len);
+			err = -ENAMETOOLONG;
+			goto out;
+		}
 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
 		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
@@ -1109,6 +1116,14 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	    !req->r_reply_info.head->is_target &&
 	    !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
+
+	/*
+	 * If we have created a snapshot we need to clear the cache, otherwise
+	 * snapshot will show encrypted filenames in readdir.
+	 */
+	if (ceph_snap(dir) == CEPH_SNAPDIR)
+		d_drop(dentry);
+
 out_req:
 	ceph_mdsc_put_request(req);
 out:
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8b0832271fdf..080824610b73 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -182,6 +182,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	ci->i_rbytes = 0;
 	ci->i_btime = ceph_inode(parent)->i_btime;
 
+	/* if encrypted, just borough fscrypt_auth from parent */
+	if (IS_ENCRYPTED(parent)) {
+		struct ceph_inode_info *pci = ceph_inode(parent);
+		inode->i_flags |= S_ENCRYPTED;
+		ci->fscrypt_auth_len = pci->fscrypt_auth_len;
+		ci->fscrypt_auth = pci->fscrypt_auth;
+	}
 	if (inode->i_state & I_NEW) {
 		inode->i_op = &ceph_snapdir_iops;
 		inode->i_fop = &ceph_snapdir_fops;
@@ -632,7 +639,8 @@ void ceph_free_inode(struct inode *inode)
 
 	kfree(ci->i_symlink);
 #ifdef CONFIG_FS_ENCRYPTION
-	kfree(ci->fscrypt_auth);
+	if (ceph_snap(inode) != CEPH_SNAPDIR)
+		kfree(ci->fscrypt_auth);
 #endif
 	fscrypt_free_inode(inode);
 	kmem_cache_free(ceph_inode_cachep, ci);
