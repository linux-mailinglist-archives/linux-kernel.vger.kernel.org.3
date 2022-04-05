Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309EE4F2116
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiDECnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiDECnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0D9B1404EE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzKAaIaqf6EF4behF3lujXRCF51brNcWMl75G/VXVIo=;
        b=YWTUUfvACPodtRvkVwOHtDQSYu4hTjadU1VRltTcpohNTxHfdjAl8jlZOe2zx0MxWYhw6a
        IJaAL7YcSvPguY0ujsxjmHvbcKT6nH5IrBS4rgfS7Y3KIgD8+/ZkHgNqe2ATGTksKTqfLO
        6bnC+arj6XWi8R6HfqAknIhqDsqMEiQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-diFJKrpBMKG_5MLIi6qMMw-1; Mon, 04 Apr 2022 21:48:37 -0400
X-MC-Unique: diFJKrpBMKG_5MLIi6qMMw-1
Received: by mail-il1-f199.google.com with SMTP id r16-20020a056e02109000b002ca35f87493so3272705ilj.22
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzKAaIaqf6EF4behF3lujXRCF51brNcWMl75G/VXVIo=;
        b=EEW7C3dP51N6Og1tbfNoQTsKlHVNg8939yTyI/8R+aWkXrG5XK8Q0tgn1AJAyGkELh
         XCGZpKw6cWGCDE5DPhQC+fX5Ne05WMKbXTW2xW02uka3Qf/c76ws/TP6pAfNYRNKGMZz
         EoqerlOQQvCquwX3dd/U36kbt8/HwmRkTVjhj8KV/huo6ciomq3ENXy0MGWHJsM2JgJP
         aSW6ToYJ9iyjagzos3UN0SxI+rhKDlgBLaGGT1bn9FjYvFqEw2wWbfpIfUdVeX4yuoSV
         ifMac8czgwjU/cC6yEbVMTpOjp3u09SJ0A+vmpuccCvvwoawBdTZHvgy9K6p19ezRf82
         lV/g==
X-Gm-Message-State: AOAM533NLtYj9r6i0a9QrIf2MXESc+h+rCDMp/4ahf7ftgKnWrKCSFc/
        +3eYuThbTXeql0j7lU+P3iwoEkg+Rz6bhMTQ5M7xg+JaPG8Qp7d42ObZOUVWQtzI1zLWiR6ctp9
        ztTys4I6ackp/Pl5M0v0i8sfpVzCKNxVrP8E74RusWyqBjpw5dqVubqUr1qiK8sgnoicdIWe1FA
        ==
X-Received: by 2002:a05:6e02:1c0a:b0:2c7:75de:d84 with SMTP id l10-20020a056e021c0a00b002c775de0d84mr565302ilh.186.1649123316147;
        Mon, 04 Apr 2022 18:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Bx++Tjrd/IXRjPJSzct03qjBhI2A5uyYDMnoG1Ghox9iQaiS+UpZyVnd00v9azlJVSYwiQ==
X-Received: by 2002:a05:6e02:1c0a:b0:2c7:75de:d84 with SMTP id l10-20020a056e021c0a00b002c775de0d84mr565275ilh.186.1649123315794;
        Mon, 04 Apr 2022 18:48:35 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d8b4f000000b00648f75d0289sm7369921iot.6.2022.04.04.18.48.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:48:35 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: [PATCH v8 02/23] mm: Teach core mm about pte markers
Date:   Mon,  4 Apr 2022 21:48:33 -0400
Message-Id: <20220405014833.14015-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 3a5ffb5587cd..ef77dae8c28d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3382,6 +3382,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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
index 7a08737bac4b..08af97c73f0f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5644,10 +5644,14 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 
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
index 2c5d1bb4694f..3f396241a7db 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -100,6 +100,8 @@ struct page *mem_map;
 EXPORT_SYMBOL(mem_map);
 #endif
 
+static vm_fault_t do_fault(struct vm_fault *vmf);
+
 /*
  * A number of key systems in x86 including ioremap() rely on the assumption
  * that high_memory defines the upper bound on direct map memory, then end
@@ -1415,6 +1417,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (!should_zap_page(details, page))
 				continue;
 			rss[mm_counter(page)]--;
+		} else if (is_pte_marker_entry(entry)) {
+			/* By default, simply drop all pte markers when zap */
 		} else if (is_hwpoison_entry(entry)) {
 			if (!should_zap_cows(details))
 				continue;
@@ -3555,6 +3559,23 @@ static inline bool should_try_to_free_swap(struct page *page,
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
@@ -3592,6 +3613,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
+		} else if (is_pte_marker_entry(entry)) {
+			ret = handle_pte_marker(vmf);
 		} else {
 			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
 			ret = VM_FAULT_SIGBUS;
diff --git a/mm/mincore.c b/mm/mincore.c
index f4f627325e12..fa200c14185f 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -122,7 +122,8 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		pte_t pte = *ptep;
 
-		if (pte_none(pte))
+		/* We need to do cache lookup too for pte markers */
+		if (pte_none_mostly(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte))
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 56060acdabd3..709a6f73b764 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -188,6 +188,9 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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

