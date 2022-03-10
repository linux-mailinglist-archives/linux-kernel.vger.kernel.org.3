Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63824D506A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbiCJR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiCJR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:27:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0F121E10;
        Thu, 10 Mar 2022 09:26:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF8A31F442;
        Thu, 10 Mar 2022 17:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646933163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GC62EEvmueZ+I68zX9t3hyffLHLjsr9mi4TMkjTqAEk=;
        b=eOTbcfwM7RaZOz+pzzJklCCFCE3IUJATjeE4cmu/ocETTfRMSGExBTNV3va5U/gYJse1Hk
        ivAHDF4Rx4mEDVmyvANN8+ieqwgFVMecINYXZRUaDGm7vBMVwCW2Spt5kykd6lIobB1416
        L1NvYyhw2yCvfVedpzFkk6RaGJ2EARU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646933163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GC62EEvmueZ+I68zX9t3hyffLHLjsr9mi4TMkjTqAEk=;
        b=IpWD5hyc6PLfNflww3OTRezCajGE/7RPa/SpoIXk3sVVqRHC5OS85tawK1quIhrJg68jG+
        nf+jvK+NpvFx/rAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78A3A13A66;
        Thu, 10 Mar 2022 17:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MPyGGqs0KmI0MQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 10 Mar 2022 17:26:03 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b4b071c7;
        Thu, 10 Mar 2022 17:26:17 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [RFC PATCH 1/2] ceph: add support for encrypted snapshot names
Date:   Thu, 10 Mar 2022 17:26:15 +0000
Message-Id: <20220310172616.16212-2-lhenriques@suse.de>
In-Reply-To: <20220310172616.16212-1-lhenriques@suse.de>
References: <20220310172616.16212-1-lhenriques@suse.de>
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
 fs/ceph/dir.c   |  9 +++++++++
 fs/ceph/inode.c | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 6df2a91af236..123e3b9c8161 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1075,6 +1075,15 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		op = CEPH_MDS_OP_MKSNAP;
 		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
 		     dentry, dentry);
+		/*
+		 * Encrypted snapshots require d_revalidate to force a
+		 * LOOKUPSNAP to cleanup dcache
+		 */
+		if (IS_ENCRYPTED(dir)) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags |= DCACHE_NOKEY_NAME;
+			spin_unlock(&dentry->d_lock);
+		}
 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
 		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b573a0f33450..81d3d554d261 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -182,6 +182,19 @@ struct inode *ceph_get_snapdir(struct inode *parent)
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
+		} else
+			dout("Failed to alloc memory for fscrypt_auth in snapdir\n");
+	}
 	if (inode->i_state & I_NEW) {
 		inode->i_op = &ceph_snapdir_iops;
 		inode->i_fop = &ceph_snapdir_fops;
