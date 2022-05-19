Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8716652DCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbiESSal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbiESSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:30:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A92FFD371
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so5851473pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GM+Jpl2PB5bL1v4oYzWVj7sToezUiR+DzB0/ofcA2U=;
        b=edalsKs+cr1bHh8k68c1cKtEAXiGwPDe+9mwnH4RI6wby9g93BgMBhEo2FvH1BiNE/
         Rf+mHA2Avzet8LIPH8/gei2VwN5rRzg5NjmV0iOB/d33JAiwPchFJ9a5YyeQop5KvfBJ
         xFGjMQxMBs6fyOWtImOPcl8yz553+6++yGTZA8+IjrC73jMjrs8/l1KiPB0fSA/9IloT
         AxTnr8x+VXzunejPPM1Z5lNAGMyCaRpIAe5ngyNUIXVqKjwip9YS5xFhkzU/n5rYFmBI
         uf17WAO9nDvdwAl18G8ppoKLB/3TsZv110JHXS4noK0X0hhxJcxYWuQuROcuw2ohusip
         LgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GM+Jpl2PB5bL1v4oYzWVj7sToezUiR+DzB0/ofcA2U=;
        b=ptqMHr5/cECDZXcp9m6ohPWpg9oTmLIW2q3jhmu02xiSYZ2hYP9veZ5jJJchKzxkVp
         ARYJgPpa/aBco5NAB0RtU6JZyHvFCHG+C7di21lesFN//CBX+L7STkvpx/dysqalpRuC
         owDodhVwBRJJjR+BPQ0ZNk0JTKnvRX46q0u//kfceYJecMC0+VnxauFOhGyWvS7+mDW+
         GrmMqNd2Y3dKXsSQF2vEYbqWWBxc9gcL4VdvY5fUC/yMpdw4bbYwoYIN5a6A+jTamMdF
         QUDqG/+96svIfeCC7Ix6IO1hMJxnkRGOOVa+ON54hQchELJO/p3cyADlW+jmZ2v2QXJe
         3mDg==
X-Gm-Message-State: AOAM530RhRtxeyKHN9joUlUy1UC2QGGxUQvPCpuBOtyNjB0FCsZnXdOC
        UJ9drnRHQRyEtALTRsRqQkJbOrsy1aM=
X-Google-Smtp-Source: ABdhPJwd4x1e0UIjlmbwBKk07N79TOTNwuw1JTWaurKAs+KJuC4ETrijeUFGJjgHf84Ek3MdEHyQLQ==
X-Received: by 2002:a65:6d08:0:b0:3c6:8a08:3b9f with SMTP id bf8-20020a656d08000000b003c68a083b9fmr5013534pgb.147.1652985030008;
        Thu, 19 May 2022 11:30:30 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm3884674pgh.14.2022.05.19.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:30:29 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: [RFC PATCH 4/6] mm: Add COW PTE fallback function
Date:   Fri, 20 May 2022 02:31:25 +0800
Message-Id: <20220519183127.3909598-5-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519183127.3909598-1-shiyn.lin@gmail.com>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lifetime of COW PTE will handle by ownership and a reference count.
When the process wants to write the COW PTE, which reference count is 1,
it will reuse the COW PTE instead of copying then free.

Only the owner will update its RSS state and the record of page table
bytes allocation. So we need to handle when the non-owner process gets
the fallback COW PTE.

This commit prepares for the following implementation of the reference
count for COW PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/memory.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 76e3af9639d9..dcb678cbb051 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1000,6 +1000,34 @@ page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
 	return new_page;
 }
 
+static inline void cow_pte_rss(struct mm_struct *mm, struct vm_area_struct *vma,
+	pmd_t *pmdp, unsigned long addr, unsigned long end, bool inc_dec)
+{
+	int rss[NR_MM_COUNTERS];
+	pte_t *orig_ptep, *ptep;
+	struct page *page;
+
+	init_rss_vec(rss);
+
+	ptep = pte_offset_map(pmdp, addr);
+	orig_ptep = ptep;
+	arch_enter_lazy_mmu_mode();
+	do {
+		if (pte_none(*ptep) || pte_special(*ptep))
+			continue;
+
+		page = vm_normal_page(vma, addr, *ptep);
+		if (page) {
+			if (inc_dec)
+				rss[mm_counter(page)]++;
+			else
+				rss[mm_counter(page)]--;
+		}
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
+	arch_leave_lazy_mmu_mode();
+	add_mm_rss_vec(mm, rss);
+}
+
 static int
 copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	       pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
@@ -4554,6 +4582,44 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	return VM_FAULT_FALLBACK;
 }
 
+/* COW PTE fallback to normal PTE:
+ * - two state here
+ *   - After break child :   [parent, rss=1, ref=1, write=NO , owner=parent]
+ *                        to [parent, rss=1, ref=1, write=YES, owner=NULL  ]
+ *   - After break parent:   [child , rss=0, ref=1, write=NO , owner=NULL  ]
+ *                        to [child , rss=1, ref=1, write=YES, owner=NULL  ]
+ */
+void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
+		unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long start, end;
+	pmd_t new;
+
+	BUG_ON(pmd_write(*pmd));
+
+	start = addr & PMD_MASK;
+	end = (addr + PMD_SIZE) & PMD_MASK;
+
+	/* If pmd is not owner, it needs to increase the rss.
+	 * Since only the owner has the RSS state for the COW PTE.
+	 */
+	if (!cow_pte_owner_is_same(pmd, pmd)) {
+		cow_pte_rss(mm, vma, pmd, start, end, true /* inc */);
+		mm_inc_nr_ptes(mm);
+		smp_wmb();
+		pmd_populate(mm, pmd, pmd_page(*pmd));
+	}
+
+	/* Reuse the pte page */
+	set_cow_pte_owner(pmd, NULL);
+	new = pmd_mkwrite(*pmd);
+	set_pmd_at(mm, addr, pmd, new);
+
+	BUG_ON(!pmd_write(*pmd));
+	BUG_ON(pmd_page(*pmd)->cow_pte_owner);
+}
+
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
-- 
2.36.1

