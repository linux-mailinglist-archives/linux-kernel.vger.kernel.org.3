Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8DA4AA95B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380098AbiBEOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbiBEOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:12:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A5C061346
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 06:12:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e3so2584125wra.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 06:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OOEtnw8xKF5peU7h9AlWIN/mhVNk/Fs8o4NsdA8KyPE=;
        b=pV7Xh5PnAO84jxxZcVD7WuvvvlbgYHisTwMUv0V5B/KP970NuI64fOESHlXxNqVcvL
         +cEFxbGZnxGBRL+2kvt9KpGLcTOh1uQcCx+lyKSlVOmeOw4Pon3Z2MlTrKgwOc3oqQ9E
         YukEJg7wApWSZr6zOzZMkWkyQ+NZ0CQq1vH0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OOEtnw8xKF5peU7h9AlWIN/mhVNk/Fs8o4NsdA8KyPE=;
        b=kCZgqa6HRAmvuW51smNm4jV04EJ2YMoG6RhVpu7r5PsxSimmUhNFV+EAXcjCEG69pO
         G90ZoFYv1esH+2sNcYdwB3DFKJiOJhBsze3m9Rhw7mVKkAnDJn2gwBuKMBzDMAJJDzLh
         Icr0nzS7W+5IRVsxMhOCedg8ytDhrrknPTL8YPnEHQLJj+PPM90okMPJdGXq5wGmeE0K
         V9ksbm6q7GEdghmusThCpgrFHljrYZQou8VC0lMpWQwxSH8Cv8CwHnm7QPpQeOuUhlfC
         YjnEK7qb7zTwbRriW5HwxOLwifN9/wXzeFr9Ol/UeMpKzBwxZPFvP6nWQPD+K5ypEzML
         6MJw==
X-Gm-Message-State: AOAM533pfoyN8uHP1pnu6v1ZCzddcJ6p5spoJS2pHJSkMpfaoEw16n7I
        zmjU2Ztj6Vn90FuSFGiPrSiRMBSy0qzwVg==
X-Google-Smtp-Source: ABdhPJwLqN0XhniFdPIk8WXQzvVT7Vuni7tXNmCF6Ihnkq6oGE2q5M7SCowUOUlIzmzpco8yS8r+Tg==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr3157663wri.212.1644070355724;
        Sat, 05 Feb 2022 06:12:35 -0800 (PST)
Received: from xavier-xps ([2a01:e0a:830:d971:752e:e19b:a691:2171])
        by smtp.gmail.com with ESMTPSA id g6sm4559293wrq.97.2022.02.05.06.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 06:12:35 -0800 (PST)
Date:   Sat, 5 Feb 2022 15:12:33 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        Hugh Dickins <hughd@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [PATCH RFC v1] tmpfs: support for file creation time
Message-ID: <20220205141233.GA938324@xavier-xps>
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
This patch tentatively adds such support for tmpfs-based filesystems.

The reason is that creation time has been supported on an increasing number
of filesystems (this information can be retrieved through the statx()
userland function), and its support for tmpfs would add consistency.
Example of use includes checking the creation time of an ephemeral status file
being updated (such as a "work in progress" placeholder), to get two time
points (starting point and last update).

Note that I am nothing but a new contributor, and while this patch has
been tested (and userland results checked), the logic might be broken.

Signed-off-by: Xavier Roche <xavier.roche@algolia.com>
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

