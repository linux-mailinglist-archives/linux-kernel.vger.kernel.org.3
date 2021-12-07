Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14846C241
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbhLGSEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:04:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57076 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhLGSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:04:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8C471FE00;
        Tue,  7 Dec 2021 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638900074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sW0G13L8LD3vgOCzYybnjl1DLQ/o79kuO3HbE02t/2c=;
        b=b86kL9GxGDQxZmbhmUH5Mv7g3oBf0JP1OB4hNDMdn2qk7vG9hR8Bl326gcVcytktcT4Thp
        JO1qG5p8w2TX8z08p1jFZWSUWN0Ks09fi1GwGetLA5XWvGQBm+ZNuregUZpaLEsKjNsy83
        sSyYibOUajplc3fn+/hHWPTL+ucE8d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638900074;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sW0G13L8LD3vgOCzYybnjl1DLQ/o79kuO3HbE02t/2c=;
        b=H9NPRWL20q5s5cTMbqqGZkOgzpCBMYl/q46/W1On+xqxDGNe1PVc4hUQv2BnUmiG/FeaNe
        Qle3FiwqgpFVTtAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 673B513AAD;
        Tue,  7 Dec 2021 18:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I+NyGGqhr2EjTwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Dec 2021 18:01:14 +0000
Message-ID: <d585f9e5-538e-bdab-c89b-b4e1cc03c7b2@suse.cz>
Date:   Tue, 7 Dec 2021 19:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-7-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 06/66] mm: Start tracking VMAs with maple tree
In-Reply-To: <20211201142918.921493-7-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 15:29, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Start tracking the VMAs with the new maple tree structure in parallel
> with the rb_tree.  Add debug and trace events for maple tree operations
> and duplicate the rb_tree that is created on forks into the maple tree.
> 
> The maple tree is added to the mm_struct including the mm_init struct,
> added support in required mm/mmap functions, added tracking in
> kernel/fork for process forking, and used to find the unmapped_area and
> checked against what the rbtree finds.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/x86/kernel/tboot.c     |   1 +
>  drivers/firmware/efi/efi.c  |   1 +
>  include/linux/mm.h          |   2 +
>  include/linux/mm_types.h    |   3 +
>  include/trace/events/mmap.h |  71 ++++++++++++
>  init/main.c                 |   2 +
>  kernel/fork.c               |   5 +
>  mm/init-mm.c                |   2 +
>  mm/internal.h               |  73 ++++++++++++
>  mm/mmap.c                   | 220 +++++++++++++++++++++++++++++++++++-
>  10 files changed, 378 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index f9af561c3cd4..859e8d2ea070 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -98,6 +98,7 @@ void __init tboot_probe(void)
>  static pgd_t *tboot_pg_dir;
>  static struct mm_struct tboot_mm = {
>  	.mm_rb          = RB_ROOT,
> +	.mm_mt          = MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock),
>  	.pgd            = swapper_pg_dir,
>  	.mm_users       = ATOMIC_INIT(2),
>  	.mm_count       = ATOMIC_INIT(1),
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index ae79c3300129..0b40291416ca 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop = EFI_INVALID_TABLE_ADDR;
>  
>  struct mm_struct efi_mm = {
>  	.mm_rb			= RB_ROOT,
> +	.mm_mt			= MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
>  	.mm_users		= ATOMIC_INIT(2),
>  	.mm_count		= ATOMIC_INIT(1),
>  	.write_protect_seq      = SEQCNT_ZERO(efi_mm.write_protect_seq),
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a7e4a9e7d807..9eae78a155be 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2610,6 +2610,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
>  /* nommu.c */
>  extern atomic_long_t mmap_pages_allocated;
>  extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
> +/* maple_tree */

Hm should it say mmap.c as that's where vma_store() is defined.

...

> diff --git a/mm/mmap.c b/mm/mmap.c
> index bfb0ea164a90..c2f1431886d4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c

...

> @@ -1901,12 +2018,21 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long length, low_limit, high_limit, gap_start, gap_end;
> +	unsigned long gap;
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  
>  	/* Adjust search length to account for worst case alignment overhead */
>  	length = info->length + info->align_mask;
>  	if (length < info->length)
>  		return -ENOMEM;
>  
> +	rcu_read_lock();
> +	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
> +			   length);

unmapped_area_topdown also uses mas_empty_area_rev(), shouldn't this one be
non-rev()?

> +	rcu_read_unlock();
> +	gap = mas.index;
> +	gap += (info->align_offset - gap) & info->align_mask;
> +
>  	/* Adjust search limits by the desired length */
>  	if (info->high_limit < length)
>  		return -ENOMEM;
> @@ -1988,20 +2114,39 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  
>  	VM_BUG_ON(gap_start + info->length > info->high_limit);
>  	VM_BUG_ON(gap_start + info->length > gap_end);
> +
> +	VM_BUG_ON(gap != gap_start);
>  	return gap_start;
>  }
>  
> +static inline unsigned long top_area_aligned(struct vm_unmapped_area_info *info,
> +					     unsigned long end)
> +{
> +	return (end - info->length - info->align_offset) & (~info->align_mask);
> +}

Looks like this is never used anywhere and just deleted later in the series.

> +
>  static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma;
> +	struct vm_area_struct *vma = NULL;
>  	unsigned long length, low_limit, high_limit, gap_start, gap_end;
> +	unsigned long gap;
> +
> +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> +	validate_mm_mt(mm);
>  
>  	/* Adjust search length to account for worst case alignment overhead */
>  	length = info->length + info->align_mask;
>  	if (length < info->length)
>  		return -ENOMEM;
>  
> +	rcu_read_lock();
> +	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
> +		   length);
> +	rcu_read_unlock();
> +	gap = (mas.index + info->align_mask) & ~info->align_mask;
> +	gap -= info->align_offset & info->align_mask;
> +
>  	/*
>  	 * Adjust search limits by the desired length.
>  	 * See implementation comment at top of unmapped_area().
