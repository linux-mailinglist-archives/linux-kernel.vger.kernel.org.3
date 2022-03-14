Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B24D8E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 22:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiCNVNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 17:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiCNVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 17:13:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A694FD28
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:11:53 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x15so25950646wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=w+42UXCNtAJ9TGLf2A5cmkfyu32cpXBmuZcjtlmKWJM=;
        b=h/numXueNH979gadCe+KzmYSaDCK5rcefpMQgJuahYkpNRnOX09QntgacPyzicZF3E
         KRl9VkiNCCUeKCtQXSFQhyYJzOhewjj/SEajVtr688ttT0ECTEvjzvJcL3GjekMf3tk9
         lAmpPtfNc7SXLLa+njjpI2uT3Ht5AcFIKHrGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=w+42UXCNtAJ9TGLf2A5cmkfyu32cpXBmuZcjtlmKWJM=;
        b=QFUxWM9O5Ur7idPeBqwkKvxsmL8kBsoZ7JxD0urOHWBV7zLGjX6sc7CRWbdskri193
         psUDn/FcYiiOIY9XPbsTbmk+WV9Rmw//OQFxBKZS2yk0+PIzPaONpXf9HRWNWbCzYcJp
         OVPz7Y3iUMgV7q33K3HvFG3S0urLuss3A/gC4EiMj4I7LgVlnoLE71A43A5wh0B0VFbN
         TvvK7Zpo5BDkuHK/lEqre3hottDcyieUtannNngQ0TfN3ppMP+45wyt96UWlCvwUjgLn
         lP8Vam6axryUa2apKxQODmSXcHm2hoLxHiFGk8BJz1CZ0GrwQ0kRfeeNRMLbTdOJubdB
         JMwA==
X-Gm-Message-State: AOAM530yMzpp1MB/r60G0CbzTru4MIZ4sFVpbxotqScq0Ry5u2mi3B7H
        az4n25TyCJHzRB9F0EvnTot1W5z9vNpMyw==
X-Google-Smtp-Source: ABdhPJzuQfk/7tfTzPzLwD+eWx12+yu5LILm2C/cqXTReUV/J/EMlCxItFP0C0L0S0jL2o4sxbhGBw==
X-Received: by 2002:adf:ed0c:0:b0:1f0:63a5:36aa with SMTP id a12-20020adfed0c000000b001f063a536aamr17823912wro.588.1647292311832;
        Mon, 14 Mar 2022 14:11:51 -0700 (PDT)
Received: from xavier-xps ([2a01:e0a:830:d971:cc11:3255:8bf2:4a49])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm14346782wra.97.2022.03.14.14.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 14:11:51 -0700 (PDT)
Date:   Mon, 14 Mar 2022 22:11:50 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.de>,
        Xavier Roche <xavier.roche@algolia.com>, linux-mm@kvack.org
Subject: [PATCH v4] tmpfs: support for file creation time
Message-ID: <20220314211150.GA123458@xavier-xps>
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

Note that using shmem_getattr() on other file types than regular requires
that shmem_is_huge() check type, to stop incorrect HPAGE_PMD_SIZE blksize.

Signed-off-by: Xavier Roche <xavier.roche@algolia.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Xavier Roche <xavier.roche@algolia.com>
Tested-by: Sylvain Bellone <sylvain.bellone@algolia.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reported-by: Xavier Grand <xavier.grand@algolia.com>
Cc: Xavier Roche <xavier.roche@algolia.com>
Cc: Jean Delvare <jdelvare@suse.de>
Link: https://lore.kernel.org/lkml/b954973a-b8d1-cab8-63bd-6ea8063de3@google.com/
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e65b80ed09e7..ab51d3cd39bd 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -24,6 +24,7 @@ struct shmem_inode_info {
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
+	struct timespec64	i_crtime;	/* file creation time */
 	struct inode		vfs_inode;
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index a09b29ec2b45..f8205b2b0322 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -476,6 +476,8 @@ bool shmem_is_huge(struct vm_area_struct *vma,
 {
 	loff_t i_size;
 
+	if (!S_ISREG(inode->i_mode))
+		return false;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
 	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
@@ -1061,6 +1063,12 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	if (shmem_is_huge(NULL, inode, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
+	if (request_mask & STATX_BTIME) {
+		stat->result_mask |= STATX_BTIME;
+		stat->btime.tv_sec = info->i_crtime.tv_sec;
+		stat->btime.tv_nsec = info->i_crtime.tv_nsec;
+	}
+
 	return 0;
 }
 
@@ -1854,9 +1862,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	/* Never use a huge page for shmem_symlink() */
-	if (S_ISLNK(inode->i_mode))
-		goto alloc_nohuge;
 	if (!shmem_is_huge(vma, inode, index))
 		goto alloc_nohuge;
 
@@ -2265,6 +2270,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		atomic_set(&info->stop_eviction, 0);
 		info->seals = F_SEAL_SEAL;
 		info->flags = flags & VM_NORESERVE;
+		info->i_crtime = inode->i_mtime;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
 		simple_xattrs_init(&info->xattrs);
@@ -3196,6 +3202,7 @@ static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 #endif /* CONFIG_TMPFS_XATTR */
 
 static const struct inode_operations shmem_short_symlink_operations = {
+	.getattr	= shmem_getattr,
 	.get_link	= simple_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3203,6 +3210,7 @@ static const struct inode_operations shmem_short_symlink_operations = {
 };
 
 static const struct inode_operations shmem_symlink_inode_operations = {
+	.getattr	= shmem_getattr,
 	.get_link	= shmem_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3790,6 +3798,7 @@ static const struct inode_operations shmem_inode_operations = {
 
 static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
+	.getattr	= shmem_getattr,
 	.create		= shmem_create,
 	.lookup		= simple_lookup,
 	.link		= shmem_link,
@@ -3811,6 +3820,7 @@ static const struct inode_operations shmem_dir_inode_operations = {
 };
 
 static const struct inode_operations shmem_special_inode_operations = {
+	.getattr	= shmem_getattr,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
 #endif
-- 
2.25.1

