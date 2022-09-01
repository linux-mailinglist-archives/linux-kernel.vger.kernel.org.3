Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40475A9215
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiIAI3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIAI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:29:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71061243EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:29:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j5so12542568plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Z8mNRx0q7JkHyItbYSH6ZMDmLisieuEpSm8lhGlJd7Y=;
        b=M/zIvRwXEziAmG7s8UKFmRMZRr3Tec5uiWycNvfqiGrKkEL1QoRfWCquYsc1vYdEnC
         SqcLAjZVEFmbPzNmWFNvdGa7WmyxIZ5yEBhh9CjlQ+d+YoTzJe7ZatTvuMt8uSTuu9Dz
         vbkmiwFzS3dHfas7sXUSKgA+vTItoznGH9P5QkLMJvdLsDTM1WubQvIYIIm0ZZCxYnkD
         +lKT87/GSuiEOc/fRnGuzX4lg5290fuuQ0W+f3vuvXkxy3iq4n7FmbHFYpabEtv4Byww
         ytoNMSY/BaQ1jdybXJEya7H0qEGEJw7hmjRDLUzUgk/Piv0dz6UicBmjTG9TkjcjQVny
         Nx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Z8mNRx0q7JkHyItbYSH6ZMDmLisieuEpSm8lhGlJd7Y=;
        b=IaUn5GNVrI3SYHGXupgwcOzfxumXx2eF2uFn1wvMxHro15hiKaGBqCkWvB8k9rBlY7
         sMhKicRS3AQY3kA2TC5os1V5VfgnkoubHcAhxN5CoSjfQIuB2AcxqMR2hf7ZbZ0dqth+
         5PRI2Z0L1zJuLGKuebaVtkA+XFG7JsUH6Hzs98aozIZkMYU9koKlQQaP3xKva3zzJEKI
         CRJguXw2dHPo5Qew40+Zr8qYhni0I0Qr4UCQN6LdZ+vXIMgYV3NeU0yqXrwp3FCZZCnH
         kkfwu3e6O9y0qsCOKggfD+G/XCMu/Uao4cBIubUYSAay8b8lUL9nm9J5PRlC1hIOVT0O
         r1Sw==
X-Gm-Message-State: ACgBeo1wFkEHcP7kxHb+yfx3gXirfATaF/wGaZObEHTkUDhh2XHiN+W7
        FFAYCmdMNxX8UQLN/jh80CAR7Q==
X-Google-Smtp-Source: AA6agR4ZveHbdLnn20Sv5BWxz37Fsce4HodHVlJOfFj2kXaZohJIOmCDdV2znOy5vkho9v4dOoxUbw==
X-Received: by 2002:a17:90a:e293:b0:1fd:7a55:9e1d with SMTP id d19-20020a17090ae29300b001fd7a559e1dmr7573587pjz.113.1662020977270;
        Thu, 01 Sep 2022 01:29:37 -0700 (PDT)
Received: from J23WFD767R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b00172e19c5f8bsm5354889plb.168.2022.09.01.01.29.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 01:29:36 -0700 (PDT)
From:   Zhang Tianci <zhangtianci.1997@bytedance.com>
To:     miklos@szeredi.hu
Cc:     Zhang Tianci <zhangtianci.1997@bytedance.com>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, brauner@kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH v3] ovl: Use ovl mounter's fsuid and fsgid in ovl_link()
Date:   Thu,  1 Sep 2022 16:29:29 +0800
Message-Id: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
mounter! So this is incorrect.

Fix this bug by using ovl mounter's fsuid/fsgid to do underlying
fs's link().

v1: https://lore.kernel.org/all/20220817102952.xnvesg3a7rbv576x@wittgenstein/T
v2: https://lore.kernel.org/lkml/20220825130552.29587-1-zhangtianci.1997@bytedance.com/t

Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/overlayfs/dir.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b03457f72bb..c3032cef391e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -592,28 +592,42 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			goto out_revert_creds;
 	}
 
-	err = -ENOMEM;
-	override_cred = prepare_creds();
-	if (override_cred) {
+	if (!attr->hardlink) {
+		err = -ENOMEM;
+		override_cred = prepare_creds();
+		if (!override_cred)
+			goto out_revert_creds;
+		/*
+		 * In the creation cases(create, mkdir, mknod, symlink),
+		 * ovl should transfer current's fs{u,g}id to underlying
+		 * fs. Because underlying fs want to initialize its new
+		 * inode owner using current's fs{u,g}id. And in this
+		 * case, the @inode is a new inode that is initialized
+		 * in inode_init_owner() to current's fs{u,g}id. So use
+		 * the inode's i_{u,g}id to override the cred's fs{u,g}id.
+		 *
+		 * But in the other hardlink case, ovl_link() does not
+		 * create a new inode, so just use the ovl mounter's
+		 * fs{u,g}id.
+		 */
 		override_cred->fsuid = inode->i_uid;
 		override_cred->fsgid = inode->i_gid;
-		if (!attr->hardlink) {
-			err = security_dentry_create_files_as(dentry,
-					attr->mode, &dentry->d_name, old_cred,
-					override_cred);
-			if (err) {
-				put_cred(override_cred);
-				goto out_revert_creds;
-			}
+		err = security_dentry_create_files_as(dentry,
+				attr->mode, &dentry->d_name, old_cred,
+				override_cred);
+		if (err) {
+			put_cred(override_cred);
+			goto out_revert_creds;
 		}
 		put_cred(override_creds(override_cred));
 		put_cred(override_cred);
-
-		if (!ovl_dentry_is_whiteout(dentry))
-			err = ovl_create_upper(dentry, inode, attr);
-		else
-			err = ovl_create_over_whiteout(dentry, inode, attr);
 	}
+
+	if (!ovl_dentry_is_whiteout(dentry))
+		err = ovl_create_upper(dentry, inode, attr);
+	else
+		err = ovl_create_over_whiteout(dentry, inode, attr);
+
 out_revert_creds:
 	revert_creds(old_cred);
 	return err;
-- 
2.32.1 (Apple Git-133)

