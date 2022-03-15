Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423B44D9FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350002AbiCOQVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349987AbiCOQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:20:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA61BEB6;
        Tue, 15 Mar 2022 09:19:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 577372192D;
        Tue, 15 Mar 2022 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647361184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0IpsQeH7sa3P2E/obisysTpWW1R6WUBwo48BxYnHy4=;
        b=DK2rpWjzAj9bBIYUTD2zrcg86/d3oDeK0Paf2TlxrorgZFCgHzFrqPcI1LB/de9QCMbsFT
        Cl4w47AGXGuKEW1ZLmu+oFIVmdszMRqfSsh3XDCd3RkhMr0g/G/eym/Vc5Wrf2tVRB8tdW
        Yt2E/soGd9RwgIhNLGaTuIhci7QorFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647361184;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0IpsQeH7sa3P2E/obisysTpWW1R6WUBwo48BxYnHy4=;
        b=8xgJKmkbmcOtufh6xL/OWc29N0lUjDxcrSjtf4hmRNdD+9QUzE6XKgOjnHj/kXQb5ah5+R
        ivtKly/EYu99gjDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E142913B4E;
        Tue, 15 Mar 2022 16:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gN3mM5+8MGIKPQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 15 Mar 2022 16:19:43 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id e4d492a7;
        Tue, 15 Mar 2022 16:20:01 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH v2 1/3] ceph: add support for encrypted snapshot names
Date:   Tue, 15 Mar 2022 16:19:57 +0000
Message-Id: <20220315161959.19453-2-lhenriques@suse.de>
In-Reply-To: <20220315161959.19453-1-lhenriques@suse.de>
References: <20220315161959.19453-1-lhenriques@suse.de>
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
 fs/ceph/inode.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 7b670e2405c1..359e29896f16 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -91,9 +91,15 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 	if (err < 0)
 		goto out_err;
 
-	err = ceph_fscrypt_prepare_context(dir, inode, as_ctx);
-	if (err)
-		goto out_err;
+	/*
+	 * We'll skip setting fscrypt context for snapshots, leaving that for
+	 * the handle_reply().
+	 */
+	if (ceph_snap(dir) != CEPH_SNAPDIR) {
+		err = ceph_fscrypt_prepare_context(dir, inode, as_ctx);
+		if (err)
+			goto out_err;
+	}
 
 	return inode;
 out_err:
@@ -157,6 +163,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	};
 	struct inode *inode = ceph_get_inode(parent->i_sb, vino, NULL);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	int ret = -ENOTDIR;
 
 	if (IS_ERR(inode))
 		return inode;
@@ -182,6 +189,22 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	ci->i_rbytes = 0;
 	ci->i_btime = ceph_inode(parent)->i_btime;
 
+	/* if encrypted, just borrow fscrypt_auth from parent */
+	if (IS_ENCRYPTED(parent)) {
+		struct ceph_inode_info *pci = ceph_inode(parent);
+
+		ci->fscrypt_auth = kmemdup(pci->fscrypt_auth,
+					   pci->fscrypt_auth_len,
+					   GFP_KERNEL);
+		if (ci->fscrypt_auth) {
+			inode->i_flags |= S_ENCRYPTED;
+			ci->fscrypt_auth_len = pci->fscrypt_auth_len;
+		} else {
+			dout("Failed to alloc snapdir fscrypt_auth\n");
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
 	if (inode->i_state & I_NEW) {
 		inode->i_op = &ceph_snapdir_iops;
 		inode->i_fop = &ceph_snapdir_fops;
@@ -195,7 +218,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		discard_new_inode(inode);
 	else
 		iput(inode);
-	return ERR_PTR(-ENOTDIR);
+	return ERR_PTR(ret);
 }
 
 const struct inode_operations ceph_file_iops = {
