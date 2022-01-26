Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E951F49D1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbiAZSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbiAZSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:36:44 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC05C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:43 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id o25so386223qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UkC+OFwWk3t7ZVs9bgfgTxL7WVNxv4IAEUpD9718gw8=;
        b=NuQmPwn9ODC2HrsAp/Fbc+4/QtEhN2zRjerYLrui6bUFh1RWkI7nzbm+smnYo7LWeB
         2dNlkMC+FM17xTVcaRXVJa3qQN37qUBGEYuuHMCT0jJAdyCS+1xVMS+jDOSJTKesYi20
         um1TQGUvf4zRX0ILDdsgDMoBxG7bPZqsGMcDuka0gdbtzgAr2KlM3lJtNHCgq+1TNNL8
         b5hEJG9BKbjM/6uQVOkHVTjkLg9CVQoV+ytlotm1wrEIB6oFTc1MiZKybpTeMUq6mYIi
         EWhWv1fayjNbSLbJz8ugZgU7nSXLQiLfKkoptdkxlxSmEXack3JpAWmv0ICdY4lS2svL
         i0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkC+OFwWk3t7ZVs9bgfgTxL7WVNxv4IAEUpD9718gw8=;
        b=f3dqpcXeoK/BsIDNIf9ClwcxfQiYk9Y3jPihov44JQkcXE4CQNo1j/iQrRmYMXPrT3
         62C4scq/MJ79XEgckLFzW9lCCCLiT+5gF6UOVFwej8fBlHHzhhLBQBgXDjnuk8ldBw1a
         /G8TS9GwcAOpr8ZiAJ/XDIOuUss3Yh44NfBnzhjTccPNQlU+Rt4f/UZpD/EEdt5Mry58
         NdAFh9hyB0VwsC/jye3Vf75flvcsx4epTt+gVZGOI5RH32cRAxuQn4ZIgW+KuTFIlwW5
         3oF0chNTOGOpMBxmnYTEvP8zTMILy2T9zqjV21haNiw4nbnjZdCPlKOZzkYZ0Uub78jh
         lNTQ==
X-Gm-Message-State: AOAM5334X7URvowu78xoaiYultvK5xxO2Molp3Rr7GiYG8KJepSU/1yE
        iEj3cEhbgMQ1G98Yl9gYC2XdjQ==
X-Google-Smtp-Source: ABdhPJz0DCm314qYSJO3d12j8XktOUREfwthUeQQKZNtRzqebLxqNzzu0tZ+we7pmNupJmyGGAPyiQ==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr21371qkk.441.1643222202808;
        Wed, 26 Jan 2022 10:36:42 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id h9sm26226qkp.75.2022.01.26.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:36:42 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v4 4/4] mm/page_table_check: check entries at pmd levels
Date:   Wed, 26 Jan 2022 18:36:37 +0000
Message-Id: <20220126183637.1840960-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
References: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot detected a case where the page table counters were not properly
updated.

syzkaller login:  ------------[ cut here ]------------
kernel BUG at mm/page_table_check.c:162!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3099 Comm: pasha Not tainted 5.16.0+ #48
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO4
RIP: 0010:__page_table_check_zero+0x159/0x1a0
Code: 7d 3a b2 ff 45 39 f5 74 2a e8 43 38 b2 ff 4d 85 e4 01
RSP: 0018:ffff888010667418 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000
RDX: ffff88800cea8680 RSI: ffffffff81becaf9 RDI: 0000000003
RBP: ffff888010667450 R08: 0000000000000001 R09: 0000000000
R10: ffffffff81becaab R11: 0000000000000001 R12: ffff888008
R13: 0000000000000001 R14: 0000000000000200 R15: dffffc0000
FS:  0000000000000000(0000) GS:ffff888035e00000(0000) knlG0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd875cad00 CR3: 00000000094ce000 CR4: 0000000000
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000
Call Trace:
 <TASK>
 free_pcp_prepare+0x3be/0xaa0
 free_unref_page+0x1c/0x650
 ? trace_hardirqs_on+0x6a/0x1d0
 free_compound_page+0xec/0x130
 free_transhuge_page+0x1be/0x260
 __put_compound_page+0x90/0xd0
 release_pages+0x54c/0x1060
 ? filemap_remove_folio+0x161/0x210
 ? lock_downgrade+0x720/0x720
 ? __put_page+0x150/0x150
 ? filemap_free_folio+0x164/0x350
 __pagevec_release+0x7c/0x110
 shmem_undo_range+0x85e/0x1250
...

The repro involved having a huge page that is split due to uprobe event
temporarily replacing one of the pages in the huge page. Later the huge
page was combined again, but the counters were off, as the PTE level
was not properly updated.

Make sure that when PMD is cleared and prior to freeing the level the
PTEs are updated.

Fixes: df4e817b7108 ("mm: page table check")

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_table_check.h | 18 ++++++++++++++++++
 mm/khugepaged.c                  |  3 +++
 mm/page_table_check.c            | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 38cace1da7b6..e88bbe37727b 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -26,6 +26,8 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd);
 void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud);
+void __page_table_check_pmd_clear_full(struct mm_struct *mm, unsigned long addr,
+				       pmd_t pmd);
 
 static inline void page_table_check_alloc(struct page *page, unsigned int order)
 {
@@ -100,6 +102,16 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
 	__page_table_check_pud_set(mm, addr, pudp, pud);
 }
 
+static inline void page_table_check_pmd_clear_full(struct mm_struct *mm,
+						   unsigned long addr,
+						   pmd_t pmd)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pmd_clear_full(mm, addr, pmd);
+}
+
 #else
 
 static inline void page_table_check_alloc(struct page *page, unsigned int order)
@@ -143,5 +155,11 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
 {
 }
 
+static inline void page_table_check_pmd_clear_full(struct mm_struct *mm,
+						   unsigned long addr,
+						   pmd_t pmd)
+{
+}
+
 #endif /* CONFIG_PAGE_TABLE_CHECK */
 #endif /* __LINUX_PAGE_TABLE_CHECK_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 30e59e4af272..d84977c6dc0d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -16,6 +16,7 @@
 #include <linux/hashtable.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/page_idle.h>
+#include <linux/page_table_check.h>
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 
@@ -1422,10 +1423,12 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 	spinlock_t *ptl;
 	pmd_t pmd;
 
+	mmap_assert_write_locked(mm);
 	ptl = pmd_lock(vma->vm_mm, pmdp);
 	pmd = pmdp_collapse_flush(vma, addr, pmdp);
 	spin_unlock(ptl);
 	mm_dec_nr_ptes(mm);
+	page_table_check_pmd_clear_full(mm, addr, pmd);
 	pte_free(mm, pmd_pgtable(pmd));
 }
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index c61d7ebe13b1..251f95a808b4 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -247,3 +247,24 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pud_set);
+
+void __page_table_check_pmd_clear_full(struct mm_struct *mm, unsigned long addr,
+				       pmd_t pmd)
+{
+	if (&init_mm == mm)
+		return;
+
+	if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
+		pte_t *ptep = pte_offset_map(&pmd, addr);
+		unsigned long i;
+
+		pte_unmap(ptep);
+		for (i = 0; i < PTRS_PER_PTE; i++) {
+			__page_table_check_pte_clear(mm, addr, *ptep);
+			addr += PAGE_SIZE;
+			ptep++;
+		}
+	} else {
+		__page_table_check_pmd_clear(mm, addr, pmd);
+	}
+}
-- 
2.35.0.rc0.227.g00780c9af4-goog

