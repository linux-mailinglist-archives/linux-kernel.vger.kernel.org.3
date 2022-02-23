Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74F4C203E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiBWXuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiBWXuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:50:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC45C84B;
        Wed, 23 Feb 2022 15:50:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB857B82281;
        Wed, 23 Feb 2022 23:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B5FC340E7;
        Wed, 23 Feb 2022 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645660204;
        bh=+x9HhxRlgmfRobO/LgV0YjczTJW4iqVhbfDJBh1tTy4=;
        h=From:To:Cc:Subject:Date:From;
        b=bFgoGKFaXZC2bLrF4yoiwH16PCVMfQVhZordG7bQRYjkIbG9pcwgEfH25X5miri39
         1JbEDNiRMmN95ZXDUWdUT6jjoZb8TZ9sqMZ4n29CXMlw2xxWVl7BjiVMHkyvUjMrEZ
         af/IbyviH4Kn8DsXxfxxLbcfs7jlhiANyp+xUyWnvx4dqDQLhJ4woXv0O1w6ep6LBn
         KT7rDpKgsxXm6SGxHTOjn3ZVIcO0/04GlelsqqYDVd4hN3ToDPkno4JhBJ9XVJ5ND4
         ocd+FqLm3aHoeH5X8JzWleujUIuSess395gQ3zb8tL3h8LLITAG8eKISy74CdCPETs
         14PH9dAxvbruA==
From:   broonie@kernel.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the maple tree
Date:   Wed, 23 Feb 2022 23:49:58 +0000
Message-Id: <20220223234958.672315-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  mm/internal.h

between commits:

  37f4270132af3 ("mm: Start tracking VMAs with maple tree")
  b3d7ba3cdf23c ("mm: Remove the vma linked list")

from the maple tree and commit:

  522387590ac22 ("mm: Turn page_anon_vma() into folio_anon_vma()")

from the folio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc mm/internal.h
index 2d3ede05cd7bf,0e95bc2130c4d..0000000000000
--- a/mm/internal.h
+++ b/mm/internal.h
@@@ -66,17 -67,12 +67,13 @@@ static inline void wake_throttle_isolat
  vm_fault_t do_swap_page(struct vm_fault *vmf);
  void folio_rotate_reclaimable(struct folio *folio);
  bool __folio_end_writeback(struct folio *folio);
+ void deactivate_file_folio(struct folio *folio);
  
 -void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 -		unsigned long floor, unsigned long ceiling);
 +void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 +		   struct vm_area_struct *start_vma, unsigned long floor,
 +		   unsigned long ceiling);
  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
  
- static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
- {
- 	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
- }
- 
  struct zap_details;
  void unmap_page_range(struct mmu_gather *tlb,
  			     struct vm_area_struct *vma,
@@@ -387,76 -388,12 +389,79 @@@ static inline bool is_data_mapping(vm_f
  	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
  }
  
 +/* Maple tree operations using VMAs */
 +/*
 + * vma_mas_store() - Store a VMA in the maple tree.
 + * @vma: The vm_area_struct
 + * @mas: The maple state
 + *
 + * Efficient way to store a VMA in the maple tree when the @mas has already
 + * walked to the correct location.
 + *
 + * Note: the end address is inclusive in the maple tree.
 + */
 +static inline int vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
 +{
 +#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 +	/* Make sure no VMAs are about to be lost. */
 +	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
 +	struct vm_area_struct *vma_mas;
 +	int count = 0;
 +
 +	mas_for_each(&test, vma_mas, vma->vm_end - 1) {
 +		/* Rule out vma_expand */
 +		if ((vma->vm_start != vma_mas->vm_start) &&
 +		    (vma->vm_end != vma_mas->vm_end))
 +			count++;
 +	}
 +
 +	/* vma adjust may overwrite a partial entry or remove one */
 +	BUG_ON(count > 1);
 +
 +	BUG_ON(mas->min > vma->vm_start);
 +	BUG_ON(mas->index > vma->vm_start);
 +#endif
 +	mas->index = vma->vm_start;
 +	mas->last = vma->vm_end - 1;
 +	return mas_store_gfp(mas, vma, GFP_KERNEL);
 +}
 +
 +/*
 + * vma_mas_remove() - Remove a VMA from the maple tree.
 + * @vma: The vm_area_struct
 + * @mas: The maple state
 + *
 + * Efficient way to remove a VMA from the maple tree when the @mas has already
 + * been established and points to the correct location.
 + * Note: the end address is inclusive in the maple tree.
 + */
 +static inline int vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
 +{
 +	int ret;
 +
 +#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 +	/* Make sure no VMAs are about to be lost. */
 +	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
 +	struct vm_area_struct *vma_mas;
 +	int count = 0;
 +
 +	mas_for_each(&test, vma_mas, vma->vm_end - 1)
 +		count++;
 +
 +	BUG_ON(count != 1);
 +
 +	BUG_ON(mas->min > vma->vm_start);
 +	BUG_ON(mas->min > mas->index);
 +#endif
 +	mas->index = vma->vm_start;
 +	mas->last = vma->vm_end - 1;
 +	ret = mas_store_gfp(mas, NULL, GFP_KERNEL);
 +	return ret;
 +}
 +
+ /* mm/util.c */
 -void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 -		struct vm_area_struct *prev);
 -void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
+ struct anon_vma *folio_anon_vma(struct folio *folio);
+ 
  #ifdef CONFIG_MMU
  void unmap_mapping_folio(struct folio *folio);
  extern long populate_vma_page_range(struct vm_area_struct *vma,
