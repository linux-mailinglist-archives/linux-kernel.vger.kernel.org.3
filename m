Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A12578DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiGRWyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiGRWyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057707673;
        Mon, 18 Jul 2022 15:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D5316155C;
        Mon, 18 Jul 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961D0C341C0;
        Mon, 18 Jul 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658184853;
        bh=Gys8VwNKIenWK94lJnGxUsyVbkTx49TEjms99sZJBGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kjUkzVIGebDzjAUSsNXLbnbcBsfe78jP7ucZq9KYsGCAWn9DjkyLV3l7l52Ldw7yg
         cjQ2XkTgP0zmjVYGk+VN3Rx5pWfG8OkFY+hTCCmcJXXCyNWzUtbUyis63QTgYeSB4e
         KzJqFF766l5jOvlytC16nlcANeVhXeQN1v1b82T4=
Date:   Mon, 18 Jul 2022 15:54:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-Id: <20220718155412.fe6a624ec067ef603bbf0cd8@linux-foundation.org>
In-Reply-To: <20220718202815.11807e92@canb.auug.org.au>
References: <20220718202815.11807e92@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 20:28:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the mm tree, today's linux-next build (powerpc
> ppc44x_defconfig) produced this warning:
> 
> mm/shmem.c:2848:12: warning: 'shmem_fileattr_set' defined but not used [-Wunused-function]
>  2848 | static int shmem_fileattr_set(struct user_namespace *mnt_userns,
>       |            ^~~~~~~~~~~~~~~~~~
> mm/shmem.c:2839:12: warning: 'shmem_fileattr_get' defined but not used [-Wunused-function]
>  2839 | static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>       |            ^~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   8673852551f0 ("mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs")

Thanks, I moved the definitions inside the appropriate ifdef.

--- a/mm/shmem.c~mm-shmem-support-fs_ioc_etflags-in-tmpfs-fix
+++ a/mm/shmem.c
@@ -2837,39 +2837,6 @@ out:
 	return error;
 }
 
-static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
-{
-	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
-
-	fileattr_fill_flags(fa, info->fsflags & SHMEM_FL_USER_VISIBLE);
-
-	return 0;
-}
-
-static int shmem_fileattr_set(struct user_namespace *mnt_userns,
-			      struct dentry *dentry, struct fileattr *fa)
-{
-	struct inode *inode = d_inode(dentry);
-	struct shmem_inode_info *info = SHMEM_I(inode);
-
-	if (fileattr_has_fsx(fa))
-		return -EOPNOTSUPP;
-
-	info->fsflags = (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
-		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
-
-	inode->i_flags &= ~(S_APPEND | S_IMMUTABLE | S_NOATIME);
-	if (info->fsflags & FS_APPEND_FL)
-		inode->i_flags |= S_APPEND;
-	if (info->fsflags & FS_IMMUTABLE_FL)
-		inode->i_flags |= S_IMMUTABLE;
-	if (info->fsflags & FS_NOATIME_FL)
-		inode->i_flags |= S_NOATIME;
-
-	inode->i_ctime = current_time(inode);
-	return 0;
-}
-
 static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
@@ -3195,6 +3162,40 @@ static const char *shmem_get_link(struct
 }
 
 #ifdef CONFIG_TMPFS_XATTR
+
+static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
+
+	fileattr_fill_flags(fa, info->fsflags & SHMEM_FL_USER_VISIBLE);
+
+	return 0;
+}
+
+static int shmem_fileattr_set(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
+
+	info->fsflags = (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
+		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
+
+	inode->i_flags &= ~(S_APPEND | S_IMMUTABLE | S_NOATIME);
+	if (info->fsflags & FS_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (info->fsflags & FS_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+	if (info->fsflags & FS_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+
+	inode->i_ctime = current_time(inode);
+	return 0;
+}
+
 /*
  * Superblocks without xattr inode operations may get some security.* xattr
  * support from the LSM "for free". As soon as we have any other xattrs
_

