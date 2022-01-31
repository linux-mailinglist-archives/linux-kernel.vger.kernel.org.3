Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07484A502E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379042AbiAaUdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378991AbiAaUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:33:01 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76DC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:33:00 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a7so14007245qvl.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AM3L4Ev7NB1R87m9UVMqXlPBBRGhukRV4JpXV46C9WE=;
        b=VgxBIxJ0hiHLQyNThvhA4DR5VIF7DaW5tnlYercL6lG4BdPNRcJ4feaFDr49XnPJgj
         OAuGN9kkbL/k0WS/ESNGQTOxhfQoFghohuY+0yCEAMeQxbUzMydi6tHXfZgMXfbs7Kf4
         N4lYqp3WrX/Jf6/domHnPz0jX13A73MaOvIY9txUUBt1/NS77Jes+qhBP4UYT69Y7R6m
         1Ki68agcRKkXDE4MXkSN63RF1O9OkCSqwxFJTwX4vxULibefaqLTgi4AStPTCktfFvxT
         n/sJ3qOOkYjLtNjHR0GU8V8Fn7ozCOvOBMxfmU7OdEpAreN8LFLqdCGdKAYzrMUWNefn
         9i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AM3L4Ev7NB1R87m9UVMqXlPBBRGhukRV4JpXV46C9WE=;
        b=eGhEuy7gDRxvEEVhfwHZWGALDholdFvNqvcDMp3h36DPHJ0MepouIYyu4CpckWsNUr
         arTtsNK1AnpZvMxuf3Y7+rDjH4+61tYJwEF9kWEP9YBbxLEAlBt+H81Me9xwD7JAd1gn
         dj0ZjjO52SXvKBxWDwzZQ5esiOPXu1g+40oMSXTSXSJV+sLiY4gneguOYGOkclMStVQa
         mOlPhuu11gjo+BMGLukXwoc/ybnpn0wAe2rqdxpNz36jdQiXhmTiPVKkrbygcG/I0vT7
         nirJcdXtBbVuNpGNTkynjs8mLnBvMSc9PWOYbZlcN0AM+AgvOhKMkDeL9cnbLt78IUwQ
         owfQ==
X-Gm-Message-State: AOAM531lK/8HFmzmModCnU0yD2/lr6EV6Vs2olnqom5ytrnuCwbpit2X
        cyufsUsUfnhHoVdIotPkk3aIkw==
X-Google-Smtp-Source: ABdhPJzoXyE3v1wQg9qr6hkLjh4LSwViEgR3/H8/DbVGMEMW+KOaQDeNNotNwxteh9FE9xUG/VOW+Q==
X-Received: by 2002:a05:6214:29ce:: with SMTP id gh14mr18628233qvb.81.1643661180014;
        Mon, 31 Jan 2022 12:33:00 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id j14sm5349661qko.10.2022.01.31.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:32:59 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v5 4/4] mm/page_table_check: check entries at pmd levels
Date:   Mon, 31 Jan 2022 20:32:49 +0000
Message-Id: <20220131203249.2832273-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
References: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
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
Acked-by: David Rientjes <rientjes@google.com>
---
 include/linux/page_table_check.h | 19 +++++++++++++++++++
 mm/khugepaged.c                  |  3 +++
 mm/page_table_check.c            | 20 ++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 38cace1da7b6..01e16c7696ec 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -26,6 +26,9 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd);
 void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud);
+void __page_table_check_pte_clear_range(struct mm_struct *mm,
+					unsigned long addr,
+					pmd_t pmd);
 
 static inline void page_table_check_alloc(struct page *page, unsigned int order)
 {
@@ -100,6 +103,16 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
 	__page_table_check_pud_set(mm, addr, pudp, pud);
 }
 
+static inline void page_table_check_pte_clear_range(struct mm_struct *mm,
+						    unsigned long addr,
+						    pmd_t pmd)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pte_clear_range(mm, addr, pmd);
+}
+
 #else
 
 static inline void page_table_check_alloc(struct page *page, unsigned int order)
@@ -143,5 +156,11 @@ static inline void page_table_check_pud_set(struct mm_struct *mm,
 {
 }
 
+static inline void page_table_check_pte_clear_range(struct mm_struct *mm,
+						    unsigned long addr,
+						    pmd_t pmd)
+{
+}
+
 #endif /* CONFIG_PAGE_TABLE_CHECK */
 #endif /* __LINUX_PAGE_TABLE_CHECK_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 30e59e4af272..131492fd1148 100644
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
+	page_table_check_pte_clear_range(mm, addr, pmd);
 	pte_free(mm, pmd_pgtable(pmd));
 }
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index c61d7ebe13b1..3763bd077861 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -247,3 +247,23 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pud_set);
+
+void __page_table_check_pte_clear_range(struct mm_struct *mm,
+					unsigned long addr,
+					pmd_t pmd)
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
+	}
+}
-- 
2.35.0.rc2.247.g8bbb082509-goog

