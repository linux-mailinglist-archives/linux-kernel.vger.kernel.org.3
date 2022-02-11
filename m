Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFB44B2F73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353773AbiBKVgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:36:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348044AbiBKVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:36:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B454C62
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:36:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o24so14645749wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QoHkcZvCmcHF62oRV/Hm9AoyHlp+75nzlQs0pgmwqUI=;
        b=s8v8rMvQoML6oAH/jNhMegfoUndT2JSIU3CERlBOF4Oi6fm+u54Ix6EuMuVg+cksOH
         tKXO81zID1PUPvvqlxPXARkYJON2MJJRdri9oSaKO1Fw3+iVHcmmPwOyFrt8m9iALg7c
         GiqaZrocgto3SuwzrfUiTNa0NWRi/hcxIAxPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QoHkcZvCmcHF62oRV/Hm9AoyHlp+75nzlQs0pgmwqUI=;
        b=WrGLJoRHh84yW2NIr6+JvJkfodE81aAk0M3zThq8aDZZgaH1Zi5NYRJi5ysOo1fYCW
         NSlKovxHGZtOsBwX1dFslfRnZmOQgvOcO8dJjYrIeTY5r70gNRc3x+2SfeloeOvjzlkF
         hh6I5GYXZwehmnqW9UZsQ+52NaSlxsJafBQWmC1tsf+mCYwSc4JHk6Dw7BYmim0V2bhC
         bRIGzBVdGRv/jp7xf9PPCVQBmpLBmYvlOPoB9bsC7jmGcf1KqELdPMexlKBr6CH2Lu32
         WdC2pSJJ0olBKM9TWatsRfk2VkHzbMWoXPZ6x1WbaC5OJrttS7QovnmdUKK5YZIIG8zG
         TScA==
X-Gm-Message-State: AOAM531XLcZJHeOq00Tw4yxVhoeHZf3lxgXspk5OduxVnmo7euwACQ8z
        Vj2sZo983TwOY5PmgabjKMcuIaUEYvifeA==
X-Google-Smtp-Source: ABdhPJwKq1doCFiVgUnyUmItCSHDL6e7xpBEp05K5zavzokjOh6gztQvmlDI3nsM1kotmCw6/9CABQ==
X-Received: by 2002:a5d:64ad:: with SMTP id m13mr2785015wrp.671.1644615391604;
        Fri, 11 Feb 2022 13:36:31 -0800 (PST)
Received: from xavier-xps ([2a01:e0a:830:d971:752e:e19b:a691:2171])
        by smtp.gmail.com with ESMTPSA id r2sm13133308wrt.65.2022.02.11.13.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:36:30 -0800 (PST)
Date:   Fri, 11 Feb 2022 22:36:28 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.de>,
        Xavier Roche <xavier.roche@algolia.com>, linux-mm@kvack.org
Subject: [PATCH v2] tmpfs: support for file creation time
Message-ID: <20220211213628.GA1919658@xavier-xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various filesystems (including ext4) now support file creation time.
This patch adds such support for tmpfs-based filesystems.

Signed-off-by: Xavier Roche <xavier.roche@algolia.com>
Tested-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e65b80ed09e7..29787767c3b9 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -25,6 +25,7 @@ struct shmem_inode_info {
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct inode		vfs_inode;
+	struct timespec64	i_crtime;	/* file creation time */
 };
 
 struct shmem_sb_info {
diff --git a/mm/shmem.c b/mm/shmem.c
index a09b29ec2b45..5a3907712c4f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1061,6 +1061,12 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	if (shmem_is_huge(NULL, inode, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
+	if ((request_mask & STATX_BTIME)) {
+		stat->result_mask |= STATX_BTIME;
+		stat->btime.tv_sec = info->i_crtime.tv_sec;
+		stat->btime.tv_nsec = info->i_crtime.tv_nsec;
+	}
+
 	return 0;
 }
 
@@ -2265,6 +2271,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		atomic_set(&info->stop_eviction, 0);
 		info->seals = F_SEAL_SEAL;
 		info->flags = flags & VM_NORESERVE;
+		info->i_crtime = inode->i_mtime;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
 		simple_xattrs_init(&info->xattrs);
@@ -3196,6 +3203,7 @@ static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 #endif /* CONFIG_TMPFS_XATTR */
 
 static const struct inode_operations shmem_short_symlink_operations = {
+	.getattr	= shmem_getattr,
 	.get_link	= simple_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3203,6 +3211,7 @@ static const struct inode_operations shmem_short_symlink_operations = {
 };
 
 static const struct inode_operations shmem_symlink_inode_operations = {
+	.getattr	= shmem_getattr,
 	.get_link	= shmem_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3790,6 +3799,7 @@ static const struct inode_operations shmem_inode_operations = {
 
 static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
+	.getattr	= shmem_getattr,
 	.create		= shmem_create,
 	.lookup		= simple_lookup,
 	.link		= shmem_link,
@@ -3811,6 +3821,7 @@ static const struct inode_operations shmem_dir_inode_operations = {
 };
 
 static const struct inode_operations shmem_special_inode_operations = {
+	.getattr	= shmem_getattr,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
 #endif
-- 
2.25.1

