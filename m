Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067504CCCE7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiCDFSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiCDFSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5894D35268
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FpwyjJeS3X1Irq3CGuq+3W5FvpvI1rV+CjmQkx/pZ4=;
        b=IkOEIYsOsbamxNpjtfm6RoJl0hO2lHGfW5hdNcU0QOWW8F46zeywR20lkOXbPNR9pAPcPU
        EOei5coiiO3YKBki6VvPo7so1znX4nANLNNJtcHTg29dYJDrPU7nio9xcj3B3ZIvkejzgo
        NfYyn5fVJcYIZhzNkjhPAfofv2kp8Yg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-E4VfJAsPPdaRD1TSB4DAwQ-1; Fri, 04 Mar 2022 00:17:40 -0500
X-MC-Unique: E4VfJAsPPdaRD1TSB4DAwQ-1
Received: by mail-pl1-f198.google.com with SMTP id i7-20020a170902cf0700b0015163eb319eso4083600plg.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1FpwyjJeS3X1Irq3CGuq+3W5FvpvI1rV+CjmQkx/pZ4=;
        b=g29vU+y46chVDhvZqTdDt9uXG/Ojlbn3Utf0zl861Ftv47zlhkbgQHVjIs5AYUrKXr
         jT0ZbJoxs+/TycQhp6OQ9LfKFAfG8z5sLw2nNkF7PEvk5tlrAnwEWSnP2nLvCV72UYnZ
         6YGUXPwVmdYf5WgJaPMykF3higYPyV87uKSeSyPXsUdFotsmodXntHEv7XFA40N+Rdrb
         H/eM2c+W/YMfTAac/wwFdhUl54AyYhSuTnoz4B7ZYiSPcCn+5aTe5PWQBzdOkminb7wD
         Vhp4dS5shG9yErypJl6O1pzdJC46dFT6kUNBY+qEwCrdRpnIfm9Hbv4+hRBLZ5TeuXWB
         g+fQ==
X-Gm-Message-State: AOAM531HBusHbqVDAukKZFb4vlYta6C6lC7obwTH3BOQrEE/w5zLoZPK
        NYyJlNUzCt0vNEiej2ZFjnt6FBusExZXC9QifjZvakqnPmcW+T9OcxIJj3E96hDS4QG8zNrPuNQ
        go3/MNYgMor4OhhhcLuCJ/K5U
X-Received: by 2002:a17:903:2285:b0:151:4b38:298e with SMTP id b5-20020a170903228500b001514b38298emr29448165plh.36.1646371058818;
        Thu, 03 Mar 2022 21:17:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9mrpZaTeSPHfY/AgvFnrkerVofenDGmydQIn76U/VF813c+ZQ9LQV59XdkRzKTOQM8WpPSg==
X-Received: by 2002:a17:903:2285:b0:151:4b38:298e with SMTP id b5-20020a170903228500b001514b38298emr29448139plh.36.1646371058465;
        Thu, 03 Mar 2022 21:17:38 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.17.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:17:38 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 02/23] mm: Teach core mm about pte markers
Date:   Fri,  4 Mar 2022 13:16:47 +0800
Message-Id: <20220304051708.86193-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch still does not use pte marker in any way, however it teaches the
core mm about the pte marker idea.

For example, handle_pte_marker() is introduced that will parse and handle all
the pte marker faults.

Many of the places are more about commenting it up - so that we know there's
the possibility of pte marker showing up, and why we don't need special code
for the cases.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 10 ++++++----
 mm/filemap.c     |  5 +++++
 mm/hmm.c         |  2 +-
 mm/memcontrol.c  |  8 ++++++--
 mm/memory.c      | 23 +++++++++++++++++++++++
 mm/mincore.c     |  3 ++-
 mm/mprotect.c    |  3 +++
 7 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index aa0c47cb0d16..8b4a94f5a238 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -249,9 +249,10 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
-	 * changes under us.
+	 * changes under us.  PTE markers should be handled the same as none
+	 * ptes here.
 	 */
-	if (huge_pte_none(pte))
+	if (huge_pte_none_mostly(pte))
 		ret = true;
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
@@ -330,9 +331,10 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte = pte_offset_map(pmd, address);
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
-	 * changes under us.
+	 * changes under us.  PTE markers should be handled the same as none
+	 * ptes here.
 	 */
-	if (pte_none(*pte))
+	if (pte_none_mostly(*pte))
 		ret = true;
 	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
 		ret = true;
diff --git a/mm/filemap.c b/mm/filemap.c
index 8f7e6088ee2a..464b8f0f111a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3379,6 +3379,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
 
+		/*
+		 * NOTE: If there're PTE markers, we'll leave them to be
+		 * handled in the specific fault path, and it'll prohibit the
+		 * fault-around logic.
+		 */
 		if (!pte_none(*vmf->pte))
 			goto unlock;
 
diff --git a/mm/hmm.c b/mm/hmm.c
index af71aac3140e..3fd3242c5e50 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -239,7 +239,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	pte_t pte = *ptep;
 	uint64_t pfn_req_flags = *hmm_pfn;
 
-	if (pte_none(pte)) {
+	if (pte_none_mostly(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f79bb3f25ce4..bba3b7e9f699 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5636,10 +5636,14 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 
 	if (pte_present(ptent))
 		page = mc_handle_present_pte(vma, addr, ptent);
+	else if (pte_none_mostly(ptent))
+		/*
+		 * PTE markers should be treated as a none pte here, separated
+		 * from other swap handling below.
+		 */
+		page = mc_handle_file_pte(vma, addr, ptent);
 	else if (is_swap_pte(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
-	else if (pte_none(ptent))
-		page = mc_handle_file_pte(vma, addr, ptent);
 
 	if (!page && !ent.val)
 		return ret;
diff --git a/mm/memory.c b/mm/memory.c
index a0ca84756159..22d24ea7b87d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -99,6 +99,8 @@ struct page *mem_map;
 EXPORT_SYMBOL(mem_map);
 #endif
 
+static vm_fault_t do_fault(struct vm_fault *vmf);
+
 /*
  * A number of key systems in x86 including ioremap() rely on the assumption
  * that high_memory defines the upper bound on direct map memory, then end
@@ -1419,6 +1421,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (!should_zap_page(details, page))
 				continue;
 			rss[mm_counter(page)]--;
+		} else if (is_pte_marker_entry(entry)) {
+			/* By default, simply drop all pte markers when zap */
 		} else if (is_hwpoison_entry(entry)) {
 			if (!should_zap_cows(details))
 				continue;
@@ -3508,6 +3512,23 @@ static inline bool should_try_to_free_swap(struct page *page,
 		page_count(page) == 2;
 }
 
+static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
+{
+	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
+	unsigned long marker = pte_marker_get(entry);
+
+	/*
+	 * PTE markers should always be with file-backed memories, and the
+	 * marker should never be empty.  If anything weird happened, the best
+	 * thing to do is to kill the process along with its mm.
+	 */
+	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
+		return VM_FAULT_SIGBUS;
+
+	/* TODO: handle pte markers */
+	return 0;
+}
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3544,6 +3565,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
+		} else if (is_pte_marker_entry(entry)) {
+			ret = handle_pte_marker(vmf);
 		} else {
 			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
 			ret = VM_FAULT_SIGBUS;
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..736869f4b409 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -121,7 +121,8 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		pte_t pte = *ptep;
 
-		if (pte_none(pte))
+		/* We need to do cache lookup too for pte markers */
+		if (pte_none_mostly(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte))
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a7b2b7..6d179c720089 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -184,6 +184,9 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 					newpte = pte_swp_mksoft_dirty(newpte);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
+			} else if (is_pte_marker_entry(entry)) {
+				/* Skip it, the same as none pte */
+				continue;
 			} else {
 				newpte = oldpte;
 			}
-- 
2.32.0

