Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A74C64FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiB1Inq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiB1Ino (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:43:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B2F17E1C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:43:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r10so14182318wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition;
        bh=gF2h43IPb7uVz7qOwzCRk0sOsMdTB9uSAj1/EGBvwDM=;
        b=CuQYnp8lI6hR/debPsdD0hxe5bX78+NWDYQCs5+KPqYC0en9yIw9DOdeg40u4cDyKX
         1TKa2OscAbwonNI/NDNw7hQoXIhVACqDlxwIFN5Cb+R3QyFQrjzKO2UTBP06goYyG9s9
         FAU40ylTzi6VE3cu+eOH5xRXoLmScTJ1GQl4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition;
        bh=gF2h43IPb7uVz7qOwzCRk0sOsMdTB9uSAj1/EGBvwDM=;
        b=uL3OtCHi4MOCLUeDDfLq//A11YMZ20Eox/0OPKULG6/X0nw8iRf+XySVJT8ARqEjpf
         H0PW0SumF/vGeIhNzj3DwMU8rm3kfMZLIHCCR7tRy+WvsRJg+yMRcUtZu1VANhOyENwg
         6Dt6LovdyLqQ0Bwy1amG7rR5V2nJQVI/XmqYp6YInDYB0Si/P7d+fgWR729Idquo00JR
         76vzFPC89deNHRWLzTRdYa9xcJf3orJPUxOvjH2XLj8U/uC6sJXxZGDhUZ9k5vPWAB8p
         Uw4pVXD0w6SdkSgKRLlkfoovmeT7Zx/klWAdzLdj5JtfcjWk37Hd8gzRbGWYfFZzs9FN
         cqLQ==
X-Gm-Message-State: AOAM530LnfKzQ8+MOqywPaPbFIe55VRDFCW79jO1Uqa3XCPcwpqjOpGF
        ND6gvdXCZqP0bYDzj4Rje5TKaw==
X-Google-Smtp-Source: ABdhPJwtiLVK/US2TGE5RK8XE5mxaMTZakxwCktoyfkqJgl1SV46lQW35ewBRwYBzi6hgr49/vQYEA==
X-Received: by 2002:adf:f711:0:b0:1ed:ab16:12e6 with SMTP id r17-20020adff711000000b001edab1612e6mr14764521wrp.534.1646037783516;
        Mon, 28 Feb 2022 00:43:03 -0800 (PST)
Received: from xavier-xps ([2a01:e0a:830:d971:a8a3:7a18:7fc0:8070])
        by smtp.gmail.com with ESMTPSA id v11-20020adfe4cb000000b001e62a8914c7sm9721083wrm.59.2022.02.28.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 00:43:02 -0800 (PST)
Date:   Mon, 28 Feb 2022 09:43:01 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.de>,
        Xavier Roche <xavier.roche@algolia.com>, linux-mm@kvack.org
Subject: [PATCH v3] tmpfs: support for file creation time
Message-ID: <20220211213628.GA1919658@xavier-xps>
Reply-To: b954973a-b8d1-cab8-63bd-6ea8063de3@google.com
References: <20220211213628.GA1919658@xavier-xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received: from xavier-xps ([2a01:e0a:830:d971:752e:e19b:a691:2171]) by
 smtp.gmail.com with ESMTPSA id r2sm13133308wrt.65.2022.02.11.13.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Fri, 11 Feb
 2022 13:36:30 -0800 (PST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various filesystems (including ext4) now support file creation time.
This patch adds such support for tmpfs-based filesystems.

Signed-off-by: Xavier Roche <xavier.roche@algolia.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Cc: Xavier Roche <xavier.roche@algolia.com>
Cc: Jean Delvare <jdelvare@suse.de>
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 11 +++++++++++
 2 files changed, 12 insertions(+)

Index: linux/include/linux/shmem_fs.h
===================================================================
--- linux.orig/include/linux/shmem_fs.h
+++ linux/include/linux/shmem_fs.h
@@ -24,6 +24,7 @@ struct shmem_inode_info {
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
+	struct timespec64	i_crtime;	/* file creation time */
 	struct inode		vfs_inode;
 };
 
Index: linux/mm/shmem.c
===================================================================
--- linux.orig/mm/shmem.c
+++ linux/mm/shmem.c
@@ -476,6 +476,8 @@ bool shmem_is_huge(struct vm_area_struct
 {
 	loff_t i_size;
 
+	if (!S_ISREG(inode->i_mode))
+		return false;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
 	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
@@ -1061,6 +1063,12 @@ static int shmem_getattr(struct user_nam
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
 
@@ -1854,9 +1862,6 @@ repeat:
 		return 0;
 	}
 
-	/* Never use a huge page for shmem_symlink() */
-	if (S_ISLNK(inode->i_mode))
-		goto alloc_nohuge;
 	if (!shmem_is_huge(vma, inode, index))
 		goto alloc_nohuge;
 
@@ -2265,6 +2270,7 @@ static struct inode *shmem_get_inode(str
 		atomic_set(&info->stop_eviction, 0);
 		info->seals = F_SEAL_SEAL;
 		info->flags = flags & VM_NORESERVE;
+		info->i_crtime = inode->i_mtime;
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
 		simple_xattrs_init(&info->xattrs);
@@ -3196,6 +3202,7 @@ static ssize_t shmem_listxattr(struct de
 #endif /* CONFIG_TMPFS_XATTR */
 
 static const struct inode_operations shmem_short_symlink_operations = {
+	.getattr	= shmem_getattr,
 	.get_link	= simple_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3203,6 +3210,7 @@ static const struct inode_operations shm
 };
 
 static const struct inode_operations shmem_symlink_inode_operations = {
+	.getattr	= shmem_getattr,
 	.get_link	= shmem_get_link,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
@@ -3790,6 +3798,7 @@ static const struct inode_operations shm
 
 static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
+	.getattr	= shmem_getattr,
 	.create		= shmem_create,
 	.lookup		= simple_lookup,
 	.link		= shmem_link,
@@ -3811,6 +3820,7 @@ static const struct inode_operations shm
 };
 
 static const struct inode_operations shmem_special_inode_operations = {
+	.getattr	= shmem_getattr,
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,
 #endif
