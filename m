Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E086349466C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358459AbiATEZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358467AbiATEZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:25:19 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EDBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:18 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id f5so4258779qtp.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nKZbvnKqUABkXpOqTg5mpojiJ4GqEoBKOOiPWM73Qxw=;
        b=bu7EWjQ32HnOd5DIeVyrxkiwHfYyZeU1n3WqXyfs6V8TzykoyKOhzXQUF5Xj35f3td
         vJ91pwx58PU7M7jxX2L7kJlm3pjn9WI6OhAlG5I+jBj/mKTjIs4F8byCHLNodvmqPI23
         KDga4e2ajDKFSN+ZzIs6fs6gtUJ527vE3zNBvOC/Jm6AAYkgtH8HNrd88igosq9JGtHK
         8MTKLhi13hLvpsrhKUwTl8Q/JpgX1qSYMFIZo8XR0kL8fjGiFiGf0p/vK8obLPk+CPm3
         cE0aQEFlpuCQ6RDom4qL0xWd1opvo7KHBpFQOeDaD2j0ddMVRnkE1Pdo15RLGxD+k7ap
         +4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nKZbvnKqUABkXpOqTg5mpojiJ4GqEoBKOOiPWM73Qxw=;
        b=XmvIlSIMgr4c3I1TUZsFVLoqrCdIJK0b/Bd3fzJRtycHMRrThwVRZX/42fp0nXNgIR
         AuhZeulMSG++nVyrfG1BvLEmIIZuTvb7wcLc6xi0BLAFw7FnZCKK7acgUPqq8mipzPwj
         DlR6xJn0FQLxj0w/23fZ/8lhNPErVY/Zg10ciaD5ON2KJCC6v0cdzjfpLkpIK4DNqvJ0
         PPle5RK+BBb/OrJ4KJRGa3yA7AhX2Ln5OFxlT9wPrb6p3rqD7nRyMOFRgUYV4FWfEBxu
         Vg1GdMpexB7Bp95PdHhi1CGbOuZFbkN5v2Y1iYXPAPkTkUC7kp5KcHumrUeAHBIAqnLa
         rrpg==
X-Gm-Message-State: AOAM531Cxmx9QpS7P1qd8/JEiEvaEeHKW1E/I4AMMvPVVn459KkjkyqH
        M90CPfqNWK8V/af1bDSnQpIVyA==
X-Google-Smtp-Source: ABdhPJwDDA5NIRNSeOLvTEcxsAy5nszcqa0qbDh0l+wfx933/17zCvV7fpoerVnAqcsbC4bItVnryw==
X-Received: by 2002:ac8:574e:: with SMTP id 14mr12632481qtx.626.1642652718132;
        Wed, 19 Jan 2022 20:25:18 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id n22sm927228qka.46.2022.01.19.20.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 20:25:17 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH 2/3] mm/page_table_check: check entries at pud and pmd levels
Date:   Thu, 20 Jan 2022 04:25:12 +0000
Message-Id: <20220120042513.1648831-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
References: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
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

Make sure that not only huge page but also small pages are updated when
a new entry is set or cleared.

Fixes: df4e817b7108 ("mm: page table check")

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_table_check.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 7504e7caa2a1..2341ac382cd5 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -145,6 +145,40 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+static void pte_clear_level(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep)
+{
+	unsigned long i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		__page_table_check_pte_clear(mm, addr, *ptep);
+		addr += PAGE_SIZE;
+		ptep++;
+	}
+}
+
+static void pmd_clear_level(struct mm_struct *mm, unsigned long addr,
+			    pmd_t *pmdp)
+{
+	unsigned long i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd_t old_pmd = *pmdp;
+
+		if (pmd_user_accessible_page(old_pmd)) {
+			page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
+					       PMD_PAGE_SIZE >> PAGE_SHIFT);
+		} else if (!pmd_bad(old_pmd) && !pmd_leaf(old_pmd)) {
+			pte_t *ptep = pte_offset_map(&old_pmd, addr);
+
+			pte_clear_level(mm, addr, ptep);
+			pte_unmap(ptep);
+		}
+		addr += PMD_PAGE_SIZE;
+		pmdp++;
+	}
+}
+
 /*
  * page is on free list, or is being allocated, verify that counters are zeroes
  * crash if they are not.
@@ -186,6 +220,11 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
 	if (pmd_user_accessible_page(pmd)) {
 		page_table_check_clear(mm, addr, pmd_pfn(pmd),
 				       PMD_PAGE_SIZE >> PAGE_SHIFT);
+	} else if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
+		pte_t *ptep = pte_offset_map(&pmd, addr);
+
+		pte_clear_level(mm, addr, ptep);
+		pte_unmap(ptep);
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pmd_clear);
@@ -199,6 +238,10 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
 	if (pud_user_accessible_page(pud)) {
 		page_table_check_clear(mm, addr, pud_pfn(pud),
 				       PUD_PAGE_SIZE >> PAGE_SHIFT);
+	} else if (!pud_bad(pud) && !pud_leaf(pud)) {
+		pmd_t *pmdp = pmd_offset(&pud, addr);
+
+		pmd_clear_level(mm, addr, pmdp);
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
@@ -237,6 +280,11 @@ void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 	if (pmd_user_accessible_page(old_pmd)) {
 		page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
 				       PMD_PAGE_SIZE >> PAGE_SHIFT);
+	} else if (!pmd_bad(old_pmd) && !pmd_leaf(old_pmd)) {
+		pte_t *ptep = pte_offset_map(&old_pmd, addr);
+
+		pte_clear_level(mm, addr, ptep);
+		pte_unmap(ptep);
 	}
 
 	if (pmd_user_accessible_page(pmd)) {
@@ -259,6 +307,10 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 	if (pud_user_accessible_page(old_pud)) {
 		page_table_check_clear(mm, addr, pud_pfn(old_pud),
 				       PUD_PAGE_SIZE >> PAGE_SHIFT);
+	} else if (!pud_bad(old_pud) && !pud_leaf(old_pud)) {
+		pmd_t *pmdp = pmd_offset(&old_pud, addr);
+
+		pmd_clear_level(mm, addr, pmdp);
 	}
 
 	if (pud_user_accessible_page(pud)) {
-- 
2.34.1.703.g22d0c6ccf7-goog

