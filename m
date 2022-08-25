Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDE05A0D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiHYKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbiHYKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:12:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA7BAC259
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:12:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r22so17459474pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4+N7HYlfplazgpIqzrok71tJ5+HL03OgoPpZtaJJ/JA=;
        b=Bu7SsRr4s/1augCft2+vJK75ZrctEK6Iyfqu3Pqt47wpkqwjMjUrUC1JkgguNrwL13
         2hwv5VLcCfH+1TdJctlmV4tEW0D5p2uuFLXfW83lWXUXrRqn7wVkKO6VfJ+TG0znQv03
         iVFjsT+BlKjd/AFLzEoJHLCxK2LgbnhjLHjQ2I0kzLOzbt/5nN04MawaWeD4I0Qm64w2
         E9MSbNuPJ3pLKOYKGmuvPUahHRz+8UnEMIUSOM24Pd3OQIg9OBXQ7WM9H2O2mD3CUq/L
         a6iPYt/Xvmok3ln2e30SBo3/3tTpT4vmSws68CmrOOrJk1agvp1haB8koBrCgA4j8OJl
         16qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4+N7HYlfplazgpIqzrok71tJ5+HL03OgoPpZtaJJ/JA=;
        b=CObyG5vZjYIbGsWq5dQjmkYIvk9eGN307sThcjOObpIwkGNAmJPbCIs7EuYAaVRzme
         zbwip5WXmPCbMJtk9qZVJRr4NKOg6ISFt9VbnfyjI9R+kJ8Yh6m9l89HE0SeIPFuhCDs
         gBAK4j2C3uN6wzH+RuxRVEXgAXQihczS0uTJp0aP3J1bpljkrsUcf648ERmz653NoHiU
         GYEydptuMOyr9m6FozsCJYFOf83Ak8D3v6cOFWqQUkRViRbbJpWMRJ9j4ngtXb5pnf73
         x3UwAOZSD86fEtsZW9jisqgbWqaafmbCNSt3xwwU2ovhHqa/8bioxEYFHvqUCyoHjX9O
         fUSA==
X-Gm-Message-State: ACgBeo3JiPpNJPpDuQqC7yFtRK238dIL16KX29VUNRUt4aT53GrDN4/0
        4j5wvWC9vcMiPrnfmLUbKprCkg==
X-Google-Smtp-Source: AA6agR4E8A9z3wJppoQNhY57GIv03JlBORZW3VAf7AyAGpWyEGHzTY8vAaMpe8BdYq7iY2OzpCD70Q==
X-Received: by 2002:a63:e851:0:b0:42a:3bc0:9ad1 with SMTP id a17-20020a63e851000000b0042a3bc09ad1mr2612576pgk.543.1661422332147;
        Thu, 25 Aug 2022 03:12:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001714c36a6e7sm8477581plh.284.2022.08.25.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:12:11 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 7/7] mm: add proc interface to free user PTE page table pages
Date:   Thu, 25 Aug 2022 18:10:37 +0800
Message-Id: <20220825101037.96517-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
References: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /proc/sys/vm/free_ptes file to procfs, when pid is written
to the file, we will traverse its process address space, find
and free empty PTE pages or zero PTE pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pte_ref.h |   5 ++
 kernel/sysctl.c         |  12 ++++
 mm/pte_ref.c            | 126 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/include/linux/pte_ref.h b/include/linux/pte_ref.h
index ab49c7fac120..f7e244129291 100644
--- a/include/linux/pte_ref.h
+++ b/include/linux/pte_ref.h
@@ -16,6 +16,11 @@ void track_pte_set(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		   pte_t pte);
 void track_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		     pte_t pte);
+
+int free_ptes_sysctl_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *length, loff_t *ppos);
+extern int sysctl_free_ptes_pid;
+
 #else /* !CONFIG_FREE_USER_PTE */
 
 static inline void pte_ref_init(pgtable_t pte)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 35d034219513..14e1a9841cb8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -64,6 +64,7 @@
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/pid.h>
+#include <linux/pte_ref.h>
 
 #include "../lib/kstrtox.h"
 
@@ -2153,6 +2154,17 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_FOUR,
 	},
+#ifdef CONFIG_FREE_USER_PTE
+	{
+		.procname	= "free_ptes",
+		.data		= &sysctl_free_ptes_pid,
+		.maxlen		= sizeof(int),
+		.mode		= 0200,
+		.proc_handler	= free_ptes_sysctl_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
+	},
+#endif
 #ifdef CONFIG_COMPACTION
 	{
 		.procname	= "compact_memory",
diff --git a/mm/pte_ref.c b/mm/pte_ref.c
index 818821d068af..e7080a3100a6 100644
--- a/mm/pte_ref.c
+++ b/mm/pte_ref.c
@@ -6,6 +6,14 @@
  */
 #include <linux/pgtable.h>
 #include <linux/pte_ref.h>
+#include <linux/mm.h>
+#include <linux/pagewalk.h>
+#include <linux/sched/mm.h>
+#include <linux/jump_label.h>
+#include <linux/hugetlb.h>
+#include <asm/tlbflush.h>
+
+#include "internal.h"
 
 #ifdef CONFIG_FREE_USER_PTE
 
@@ -105,4 +113,122 @@ void track_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 }
 EXPORT_SYMBOL(track_pte_clear);
 
+#ifdef CONFIG_DEBUG_VM
+void pte_free_debug(pmd_t pmd)
+{
+	pte_t *ptep = (pte_t *)pmd_page_vaddr(pmd);
+	int i = 0;
+
+	for (i = 0; i < PTRS_PER_PTE; i++, ptep++) {
+		pte_t pte = *ptep;
+		BUG_ON(!(pte_none(pte) || is_zero_pfn(pte_pfn(pte))));
+	}
+}
+#else
+static inline void pte_free_debug(pmd_t pmd)
+{
+}
+#endif
+
+
+static int kfreeptd_pmd_entry(pmd_t *pmd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pmd_t pmdval;
+	pgtable_t page;
+	struct mm_struct *mm = walk->mm;
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	spinlock_t *ptl;
+	bool free = false;
+	unsigned long haddr = addr & PMD_MASK;
+
+	if (pmd_trans_unstable(pmd))
+		goto out;
+
+	mmap_read_unlock(mm);
+	mmap_write_lock(mm);
+
+	if (mm_find_pmd(mm, addr) != pmd)
+		goto unlock_out;
+
+	ptl = pmd_lock(mm, pmd);
+	pmdval = *pmd;
+	if (pmd_none(pmdval) || pmd_leaf(pmdval)) {
+		spin_unlock(ptl);
+		goto unlock_out;
+	}
+	page = pmd_pgtable(pmdval);
+	if (!pte_mapped_count(page) || pte_zero_count(page) == PTRS_PER_PTE) {
+		pmd_clear(pmd);
+		flush_tlb_range(&vma, haddr, haddr + PMD_SIZE);
+		free = true;
+	}
+	spin_unlock(ptl);
+
+unlock_out:
+	mmap_write_unlock(mm);
+	mmap_read_lock(mm);
+
+	if (free) {
+		pte_free_debug(pmdval);
+		mm_dec_nr_ptes(mm);
+		pgtable_pte_page_dtor(page);
+		__free_page(page);
+	}
+
+out:
+	cond_resched();
+	return 0;
+}
+
+static const struct mm_walk_ops kfreeptd_walk_ops = {
+	.pmd_entry		= kfreeptd_pmd_entry,
+};
+
+int sysctl_free_ptes_pid;
+int free_ptes_sysctl_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *length, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (ret)
+		return ret;
+	if (write) {
+		struct task_struct *task;
+		struct mm_struct *mm;
+
+		rcu_read_lock();
+		task = find_task_by_vpid(sysctl_free_ptes_pid);
+		if (!task) {
+			rcu_read_unlock();
+			return -ESRCH;
+		}
+		mm = get_task_mm(task);
+		rcu_read_unlock();
+
+		if (!mm) {
+			mmput(mm);
+			return -ESRCH;
+		}
+
+		do {
+			ret = -EBUSY;
+
+			if (mmap_read_trylock(mm)) {
+				ret = walk_page_range(mm, FIRST_USER_ADDRESS,
+						      ULONG_MAX,
+						      &kfreeptd_walk_ops, NULL);
+
+				mmap_read_unlock(mm);
+			}
+
+			cond_resched();
+		} while (ret == -EAGAIN);
+
+		mmput(mm);
+	}
+	return ret;
+}
+
 #endif /* CONFIG_FREE_USER_PTE */
-- 
2.20.1

