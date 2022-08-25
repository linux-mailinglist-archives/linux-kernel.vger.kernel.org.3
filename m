Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C635A1184
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbiHYNIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbiHYNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:08:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDEA80036
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:08:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so4880958pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=OBYmnQGANZOHibGw312dbngnREH68qBEMiZ9YOR4h7Y=;
        b=bkqPN0PJIWCCnt7/zGtjcRLXEQvmV3RhkEOkGqLYVNailErPnaJ0gpTVpa7oASHKEI
         JksrKiJ8chvwlXoDgqk1sGqHmoCWsBcB+KxB+dFvm805Je2N4Y6u8w0YGIKLUm+KNZF4
         ICqIgtU7+2aEDmfWA0DNCA0qIXebqdPJUP/LgtxnqF61q0yUSFk9YQBQOg8bdWA2fL90
         MvwLAtXIETHkiX/E7w40u/mKAR/pd6J6jlvDVWLsjufu0+dmSVlulhKKkzsTZgJ74OR0
         eglrJaCrk/dxmBJ5krfEIlX/e9J1UEa5faf0Op1YeNmoJnIAZUkMRDow/Sn9kvqwkjIJ
         CY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=OBYmnQGANZOHibGw312dbngnREH68qBEMiZ9YOR4h7Y=;
        b=eQB/7gefKfsYdd9/BGEv6M78sdogabretK+HUmqPPQIFtOlnTSKmGUUpjWiGomQefr
         VOx7zXYpQm98dGU3+MjHY3tFEZJ3hgtczxMnpg4pUGrqWeBPYnyICyCeTMX+4P4bRpOm
         Kyl8fQflv8bOpqX1I2/2HFpgN/6bwdLHC/erkfhyLNxZvEn1ooguSD76Z6cg60qRbCub
         leOubK8tIOQyCV2S6QBxTq28lqtwWYI67mThUy4lTz+6ewHz1FQHE01jeKsP/LnRvakJ
         X/vP/eqz5k5ekLP44xBey0lDjuPT23rSNP3l4oRx+41hB1mNGWvPJakEw8fCjZhRve7/
         1lIw==
X-Gm-Message-State: ACgBeo0VLle5VxoEQF7Evd/z1hDAt6mczcXSWZZW04UtCc1ZOlQlOgjB
        2f67xq52dKTxpD3OnyOEPlQcIA==
X-Google-Smtp-Source: AA6agR7rdfkSleUlsrhp+Y31d4Aag6ekmGqI8PVk/MkynKCYvUMhkjmZ0p29gttG0ClqWUeE9xvFyg==
X-Received: by 2002:a17:902:904b:b0:172:cd04:a3d3 with SMTP id w11-20020a170902904b00b00172cd04a3d3mr3834358plz.173.1661432908935;
        Thu, 25 Aug 2022 06:08:28 -0700 (PDT)
Received: from J23WFD767R.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902e89000b0016f196209c9sm11019202plg.123.2022.08.25.06.08.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 06:08:28 -0700 (PDT)
From:   Zhang Tianci <zhangtianci.1997@bytedance.com>
To:     miklos@szeredi.hu
Cc:     Zhang Tianci <zhangtianci.1997@bytedance.com>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2] ovl: Use current fsuid and fsgid in ovl_link()
Date:   Thu, 25 Aug 2022 21:05:52 +0800
Message-Id: <20220825130552.29587-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a wrong case of link() on overlay:
  $ mkdir /lower /fuse /merge
  $ mount -t fuse /fuse
  $ mkdir /fuse/upper /fuse/work
  $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,\
    workdir=work
  $ touch /merge/file
  $ chown bin.bin /merge/file // the file's caller becomes "bin"
  $ ln /merge/file /merge/lnkfile

Then we will get an error(EACCES) because fuse daemon checks the link()'s
caller is "bin", it denied this request.

In the changing history of ovl_link(), there are two key commits:

The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
overrides the cred's fsuid/fsgid using the new inode. The new inode's
owner is initialized by inode_init_owner(), and inode->fsuid is
assigned to the current user. So the override fsuid becomes the
current user. We know link() is actually modifying the directory, so
the caller must have the MAY_WRITE permission on the directory. The
current caller may should have this permission. This is acceptable
to use the caller's fsuid.

The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
which removed the inode creation in ovl_link(). This commit move
inode_init_owner() into ovl_create_object(), so the ovl_link() just
give the old inode to ovl_create_or_link(). Then the override fsuid
becomes the old inode's fsuid, neither the caller nor the overlay's
creator! So this is incorrect.

Fix this bug by using current fsuid/fsgid to do underlying fs's link().

Link: https://lore.kernel.org/all/20220817102951.xnvesg3a7rbv576x@wittgenstein/T

Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/overlayfs/dir.c       | 16 +++++++++++-----
 fs/overlayfs/overlayfs.h |  2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b03457f72bb..dd84e6fc5f6e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -595,8 +595,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	err = -ENOMEM;
 	override_cred = prepare_creds();
 	if (override_cred) {
-		override_cred->fsuid = inode->i_uid;
-		override_cred->fsgid = inode->i_gid;
+		override_cred->fsuid = attr->fsuid;
+		override_cred->fsgid = attr->fsgid;
 		if (!attr->hardlink) {
 			err = security_dentry_create_files_as(dentry,
 					attr->mode, &dentry->d_name, old_cred,
@@ -646,6 +646,8 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
 	attr.mode = inode->i_mode;
 
+	attr.fsuid = inode->i_uid;
+	attr.fsgid = inode->i_gid;
 	err = ovl_create_or_link(dentry, inode, &attr, false);
 	/* Did we end up using the preallocated inode? */
 	if (inode != d_inode(dentry))
@@ -702,6 +704,7 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
 {
 	int err;
 	struct inode *inode;
+	struct ovl_cattr attr;
 
 	err = ovl_want_write(old);
 	if (err)
@@ -728,9 +731,12 @@ static int ovl_link(struct dentry *old, struct inode *newdir,
 	inode = d_inode(old);
 	ihold(inode);
 
-	err = ovl_create_or_link(new, inode,
-			&(struct ovl_cattr) {.hardlink = ovl_dentry_upper(old)},
-			ovl_type_origin(old));
+	attr = (struct ovl_cattr) {
+		.hardlink = ovl_dentry_upper(old),
+		.fsuid = current_fsuid(),
+		.fsgid = current_fsgid(),
+	};
+	err = ovl_create_or_link(new, inode, &attr, ovl_type_origin(old));
 	if (err)
 		iput(inode);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87759165d32b..85043123a103 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -655,6 +655,8 @@ struct ovl_cattr {
 	umode_t mode;
 	const char *link;
 	struct dentry *hardlink;
+	kuid_t fsuid;
+	kgid_t fsgid;
 };
 
 #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
-- 
2.32.1 (Apple Git-133)

