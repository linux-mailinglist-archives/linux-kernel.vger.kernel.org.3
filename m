Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F349F47D241
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbhLVMnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:43:05 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30162 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245133AbhLVMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:42:32 -0500
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JJtFj5mbXz8w3c;
        Wed, 22 Dec 2021 20:40:09 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (7.193.23.29) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 20:42:30 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 20:42:29 +0800
From:   Peng Liang <liangpeng10@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <xiexiangyou@huawei.com>, <zhengchuan@huawei.com>,
        <wanghao232@huawei.com>, <liangpeng10@huawei.com>
Subject: [RFC 1/1] memfd: Support mapping to zero page on reading
Date:   Wed, 22 Dec 2021 20:34:00 +0800
Message-ID: <20211222123400.1659635-2-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222123400.1659635-1-liangpeng10@huawei.com>
References: <20211222123400.1659635-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping to zero page on reading memfd and COWing it when a write occurs.

Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 include/linux/fs.h         |  2 ++
 include/uapi/linux/memfd.h |  1 +
 mm/memfd.c                 |  8 ++++++--
 mm/memory.c                | 37 ++++++++++++++++++++++++++++++++++---
 mm/shmem.c                 | 10 ++++++++--
 5 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..404c0c26ba98 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2249,6 +2249,7 @@ struct super_operations {
 #define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
+#define S_ZEROPAGE	(1 << 17)
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -2291,6 +2292,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
 #define IS_CASEFOLDED(inode)	((inode)->i_flags & S_CASEFOLD)
 #define IS_VERITY(inode)	((inode)->i_flags & S_VERITY)
+#define IS_ZEROPAGE(inode)	((inode)->i_flags & S_ZEROPAGE)
 
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 7a8a26751c23..2bfac06f53fb 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -8,6 +8,7 @@
 #define MFD_CLOEXEC		0x0001U
 #define MFD_ALLOW_SEALING	0x0002U
 #define MFD_HUGETLB		0x0004U
+#define MFD_ZEROPAGE		0x0008U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/memfd.c b/mm/memfd.c
index 9f80f162791a..5c167b2de9ae 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -245,7 +245,7 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_ZEROPAGE)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -301,8 +301,12 @@ SYSCALL_DEFINE2(memfd_create,
 					HUGETLB_ANONHUGE_INODE,
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
-	} else
+	} else {
 		file = shmem_file_setup(name, 0, VM_NORESERVE);
+		if (flags & MFD_ZEROPAGE) {
+			file_inode(file)->i_flags |= S_ZEROPAGE;
+		}
+	}
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_fd;
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..360606964a7d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3208,6 +3208,26 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	return ret;
 }
 
+static vm_fault_t do_shared_fault(struct vm_fault *vmf);
+
+static vm_fault_t wp_zero_shared(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct mmu_notifier_range range;
+	vm_fault_t ret;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
+				vmf->address & PAGE_MASK,
+				(vmf->address & PAGE_MASK) + PAGE_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	ret = do_shared_fault(vmf);
+	mmu_notifier_invalidate_range_only_end(&range);
+	return ret;
+}
+
 /*
  * This routine handles present pages, when users try to write
  * to a shared page. It is done by copying the page to a new address
@@ -3254,8 +3274,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
 		 */
 		if ((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
-				     (VM_WRITE|VM_SHARED))
-			return wp_pfn_shared(vmf);
+				     (VM_WRITE|VM_SHARED)) {
+			if (unlikely(vma->vm_file &&
+			    IS_ZEROPAGE(file_inode(vma->vm_file)) &&
+			    is_zero_pfn(pte_pfn(*vmf->pte)))) {
+				return wp_zero_shared(vmf);
+			} else {
+				return wp_pfn_shared(vmf);
+			}
+		}
 
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return wp_page_copy(vmf);
@@ -3970,12 +3997,16 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	else if (unlikely(vma->vm_file && IS_ZEROPAGE(file_inode(vma->vm_file)) &&
+		 is_zero_pfn(page_to_pfn(page))))
+		entry = pte_mkspecial(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
-	} else {
+	} else if (likely(!vma->vm_file || !IS_ZEROPAGE(file_inode(vma->vm_file)) ||
+		   !is_zero_pfn(page_to_pfn(page)))) {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
 	}
diff --git a/mm/shmem.c b/mm/shmem.c
index 18f93c2d68f1..f4b23124826d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1899,8 +1899,14 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	page = shmem_alloc_and_acct_page(huge_gfp, inode, index, true);
 	if (IS_ERR(page)) {
 alloc_nohuge:
-		page = shmem_alloc_and_acct_page(gfp, inode,
-						 index, false);
+		if (IS_ZEROPAGE(inode) && vmf &&
+		    !(vmf->flags & FAULT_FLAG_WRITE)) {
+			page = ZERO_PAGE(0);
+			goto out;
+		} else {
+			page = shmem_alloc_and_acct_page(gfp, inode,
+							 index, false);
+		}
 	}
 	if (IS_ERR(page)) {
 		int retry = 5;
-- 
2.33.1

