Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE764C59D3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 07:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiB0Gay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 01:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiB0Gax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 01:30:53 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B22EBC85
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 22:30:15 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 11so6337054qtt.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 22:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=u2DzgVMV1bW5JCC4SUZOIoJd+XZwoGYmc/Bv0aGkfSw=;
        b=q7fFprcg73fGah6aXTI4Zc02BldDyWEnvwvELxcwU+ts4pqoLwuR1wLeE6rXgGxRkK
         f9uSELTsD0C3Sz59NK+9ZwUM/WkJm4c4oOqWBA3Heu5XFTcRz7Vw7eaRrlKb5nO1gvEJ
         FCEA+Kk8QLDVLpeKlbHfEvUN1UyzQCKt4FaT801HLeN9J6CipN+aqZjEfVL0EtqKc1OU
         ipK71V2sWxF0vTy3xD/t4RD3lSJI/ST9j/0KZFuotG78k3vv9z4N4TZ5ncZbOuTYiky5
         SWmgK79yMVFNQ/GdQuSMXWmAieHLU1hdO622f4i1LZsJk9u+KOcXj5Hsbz4CMZoNMgpG
         dQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=u2DzgVMV1bW5JCC4SUZOIoJd+XZwoGYmc/Bv0aGkfSw=;
        b=GME8UbJ5/rIxWfjDCP0xW6wnKpJGPQCtZDPkOpGTEJzKgEze/qgOFk8SLj4x/FeGjU
         XRLzY03VDNsmoR8jukCOkVjTFx/ib4HDUiO5CVGWFn9UcUOx+7cjCAQ3hz5p6U0rjjon
         3wj8G6xP0M3GLwlzc3OXe/mSq2wu07l+f2UedrpK65cUH0G3wm9/SaKgVQf0MzId3bv5
         jyFTvxeyrtKTuvFXeBJbPeuUX3BHRvJoymAMelbvjcliDfMV+jtXGxahkWmMXQnIzyU5
         SzCy8ZkosJGrWwXWBKjTKwAiLWCrdm8PLa4OGX8ha0pViX6lPL1svKrExAxFt2jgwgFH
         YhDA==
X-Gm-Message-State: AOAM531EHNmC2tpESoDww/BTAAakrgALiqilcq/m+XQMFAieJYraxPe2
        oK8Axk+Fy+a05T+NL1jT8EiLGw==
X-Google-Smtp-Source: ABdhPJzKL487DZDKKdZUU1mzNVs8ZSqXW7BZIAVvlyjxrkZk0Cxm6btMJm0P4SIefrANKn/B+WjqmA==
X-Received: by 2002:ac8:4e82:0:b0:2dd:e5a1:3b2a with SMTP id 2-20020ac84e82000000b002dde5a13b2amr12637058qtp.196.1645943414134;
        Sat, 26 Feb 2022 22:30:14 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b006494fb49246sm3443689qkb.86.2022.02.26.22.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 22:30:13 -0800 (PST)
Date:   Sat, 26 Feb 2022 22:30:01 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Xavier Roche <xavier.roche@algolia.com>,
        Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] tmpfs: three tweaks to creation time patch
In-Reply-To: <20220211213628.GA1919658@xavier-xps>
Message-ID: <b954973a-b8d1-cab8-63bd-6ea8063de3@google.com>
References: <20220211213628.GA1919658@xavier-xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you to Xavier Roche for his tmpfs file creation time patch.
Please apply these 3 tweaks on top (and fold in when sending to Linus):

1. Move vfs_inode back to being last element of shmem_inode_info.
2. Remove unnecessary parentheses from condition in shmem_getattr().
3. Using shmem_getattr() on other file types than regular requires that
   shmem_is_huge() check type, to stop incorrect HPAGE_PMD_SIZE blksize.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Cleanups and fix to tmpfs-support-for-file-creation-time.patch

 include/linux/shmem_fs.h |    2 +-
 mm/shmem.c               |    7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

--- mmotm/include/linux/shmem_fs.h
+++ linux/include/linux/shmem_fs.h
@@ -24,8 +24,8 @@ struct shmem_inode_info {
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
-	struct inode		vfs_inode;
 	struct timespec64	i_crtime;	/* file creation time */
+	struct inode		vfs_inode;
 };
 
 struct shmem_sb_info {
--- mmotm/mm/shmem.c
+++ linux/mm/shmem.c
@@ -476,6 +476,8 @@ bool shmem_is_huge(struct vm_area_struct
 {
 	loff_t i_size;
 
+	if (!S_ISREG(inode->i_mode))
+		return false;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
 	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
@@ -1061,7 +1063,7 @@ static int shmem_getattr(struct user_nam
 	if (shmem_is_huge(NULL, inode, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
-	if ((request_mask & STATX_BTIME)) {
+	if (request_mask & STATX_BTIME) {
 		stat->result_mask |= STATX_BTIME;
 		stat->btime.tv_sec = info->i_crtime.tv_sec;
 		stat->btime.tv_nsec = info->i_crtime.tv_nsec;
@@ -1860,9 +1862,6 @@ repeat:
 		return 0;
 	}
 
-	/* Never use a huge page for shmem_symlink() */
-	if (S_ISLNK(inode->i_mode))
-		goto alloc_nohuge;
 	if (!shmem_is_huge(vma, inode, index))
 		goto alloc_nohuge;
 
