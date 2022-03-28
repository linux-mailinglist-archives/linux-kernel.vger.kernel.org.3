Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C574E957F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbiC1Lpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242661AbiC1Lf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:35:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F59F76
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:26:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KRr1w24myzCrNB;
        Mon, 28 Mar 2022 19:24:20 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Mar
 2022 19:26:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: shmem: make shmem_init return void
Date:   Mon, 28 Mar 2022 19:27:07 +0800
Message-ID: <20220328112707.22217-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of shmem_init is never used. So we can make it
return void now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/shmem_fs.h | 2 +-
 mm/shmem.c               | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index ab51d3cd39bd..3e915cc550bc 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -56,7 +56,7 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
  * Functions in mm/shmem.c called directly from elsewhere:
  */
 extern const struct fs_parameter_spec shmem_fs_parameters[];
-extern int shmem_init(void);
+extern void shmem_init(void);
 extern int shmem_init_fs_context(struct fs_context *fc);
 extern struct file *shmem_file_setup(const char *name,
 					loff_t size, unsigned long flags);
diff --git a/mm/shmem.c b/mm/shmem.c
index 529c9ad3e926..26e09a022087 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3879,7 +3879,7 @@ static struct file_system_type shmem_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
-int __init shmem_init(void)
+void __init shmem_init(void)
 {
 	int error;
 
@@ -3904,14 +3904,13 @@ int __init shmem_init(void)
 	else
 		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
 #endif
-	return 0;
+	return;
 
 out1:
 	unregister_filesystem(&shmem_fs_type);
 out2:
 	shmem_destroy_inodecache();
 	shm_mnt = ERR_PTR(error);
-	return error;
 }
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
@@ -3989,14 +3988,14 @@ static struct file_system_type shmem_fs_type = {
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
-int __init shmem_init(void)
+void __init shmem_init(void)
 {
 	BUG_ON(register_filesystem(&shmem_fs_type) != 0);
 
 	shm_mnt = kern_mount(&shmem_fs_type);
 	BUG_ON(IS_ERR(shm_mnt));
 
-	return 0;
+	return;
 }
 
 int shmem_unuse(unsigned int type)
-- 
2.23.0

