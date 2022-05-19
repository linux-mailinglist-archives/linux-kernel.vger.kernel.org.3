Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27B52DCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiESSat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiESSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:30:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D70EBA97
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ds11so6075021pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmD3lcFeTPDWHVGorCCwoEXIVzcsZGCT2BZYAichU1Y=;
        b=oY+dcEgNEIo9g6YqyXfxa63f/ZoyciRGzpdYhqxPmlGdmu4UQhDp5GSrZVEekt9cBe
         aleWBsFQEgfuiiGNK9Qy/YGRavjN8QNttJmZTKDfcyUN77iJOC8n1IEfzfWwmYR4QSkb
         A5dbTP0JAKWckixtpadpAGtfgOrUbdXiEJHAiYu5FtYDQ4zIWzth5qNKm+dTvlId4ow+
         NyVzELN+Ux+WowpkTTgAvo4QYSQ3XbPWUIdix32vBd5x4b6Dzo/bdu4zBw2V6JZvoko5
         b6kZYT5eK2OWI8AshzsQXn3D7kp8hnzwbYXgt7chaULMqKqU5qcjZT4ujoTvz/2JD9/d
         ucnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmD3lcFeTPDWHVGorCCwoEXIVzcsZGCT2BZYAichU1Y=;
        b=4EWVmfv/DCzQ48UzNSNrJAlvcK2KskxtaxD+Ty9Vt2qj92seQk93VxNUB8Ozv84Rux
         430SvswTGFnXISixnD6JwB5Q+R7EaJ1jZ5rLVSZBzd3GXgr0rbhU5LlGC+CNImOGLwJr
         jszz2G7dVyGXJ3hTEK9EkRzoto3mb+N+M/ktioTO6SIbsd05hvNqFZIrb5NJ7kIlg086
         GuVrCgfLLBoeipHarzpidCpIGER8qcShAlJX5WYRd6okZ6wpYUV8khCNCMiZ33aaCutF
         xUhvfiitrqJzxPN1fWF9u39DTGW6IqB6rZCFxzQJyQfQrEEOBHlYveHJ/d3kmzRbZdn2
         Q2Hw==
X-Gm-Message-State: AOAM531dzzRjVdaKFAQqaalviC22bGVLz5g4d4HAzyCKihFIvivNK9Pk
        EAvXHb3cDIRLFl07auSHgqg=
X-Google-Smtp-Source: ABdhPJzcgtA40HpIUmFEvX1Y8bcQpMq8LvSrxZ0XWDgxCPWU8IRvzIFvnpxFPWLY1xszYrbDzx6oEA==
X-Received: by 2002:a17:90a:7441:b0:1df:5f54:502c with SMTP id o1-20020a17090a744100b001df5f54502cmr7132196pjk.129.1652985036178;
        Thu, 19 May 2022 11:30:36 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm3884674pgh.14.2022.05.19.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:30:35 -0700 (PDT)
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
Subject: [RFC PATCH 5/6] mm, pgtable: Add the reference counter for COW PTE
Date:   Fri, 20 May 2022 02:31:26 +0800
Message-Id: <20220519183127.3909598-6-shiyn.lin@gmail.com>
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

Add the reference counter cow_pgtable_refcount to maintain the number
of process references to COW PTE. Before decreasing the reference
count, it will check whether the counter is one or not for reusing
COW PTE when the counter is one.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h |  1 +
 include/linux/pgtable.h  | 27 +++++++++++++++++++++++++++
 mm/memory.c              |  1 +
 4 files changed, 30 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 221926a3d818..e48bb3fbc33c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2329,6 +2329,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
 	page->cow_pte_owner = NULL;
+	atomic_set(&page->cow_pgtable_refcount, 1);
 	return true;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5dcbd7f6c361..984d81e47d53 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -221,6 +221,7 @@ struct page {
 #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
 	int _last_cpupid;
 #endif
+	atomic_t cow_pgtable_refcount; /* COW page table */
 	pmd_t *cow_pte_owner; /* cow pte: pmd */
 } _struct_page_alignment;
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index faca57af332e..33c01fec7b92 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -604,6 +604,33 @@ static inline bool cow_pte_owner_is_same(pmd_t *pmd, pmd_t *owner)
 		true : false;
 }
 
+extern void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
+		unsigned long addr);
+
+static inline int pmd_get_pte(pmd_t *pmd)
+{
+	return atomic_inc_return(&pmd_page(*pmd)->cow_pgtable_refcount);
+}
+
+/* If the COW PTE page->cow_pgtable_refcount is 1, instead of decreasing the
+ * counter, clear write protection of the corresponding PMD entry and reset
+ * the COW PTE owner to reuse the table.
+ */
+static inline int pmd_put_pte(struct vm_area_struct *vma, pmd_t *pmd,
+		unsigned long addr)
+{
+	if (!atomic_add_unless(&pmd_page(*pmd)->cow_pgtable_refcount, -1, 1)) {
+		cow_pte_fallback(vma, pmd, addr);
+		return 1;
+	}
+	return 0;
+}
+
+static inline int cow_pte_refcount_read(pmd_t *pmd)
+{
+	return atomic_read(&pmd_page(*pmd)->cow_pgtable_refcount);
+}
+
 #ifndef pte_access_permitted
 #define pte_access_permitted(pte, write) \
 	(pte_present(pte) && (!(write) || pte_write(pte)))
diff --git a/mm/memory.c b/mm/memory.c
index dcb678cbb051..aa66af76e214 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4597,6 +4597,7 @@ void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
 	pmd_t new;
 
 	BUG_ON(pmd_write(*pmd));
+	BUG_ON(cow_pte_refcount_read(pmd) != 1);
 
 	start = addr & PMD_MASK;
 	end = (addr + PMD_SIZE) & PMD_MASK;
-- 
2.36.1

