Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30E24A468F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348414AbiAaMGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:06:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34978 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350341AbiAaMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:06:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B926D1F381;
        Mon, 31 Jan 2022 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643630763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lqNijKTz7QzsNvM1Y20CF0Dy7Qx16blcjfJ9npCqma8=;
        b=1j6CxPTaG+3Dksr/6bSTSPPYPYTu+u5QyuH9T7RsgsiyVbAg6CluqEaFSzxs11yw5xUpnD
        1Z/kcRtnBADXbnneQSEHm2XanbjIpX0eBOXrrjGq/BGfesGLbzhYAgAwne4I8jqLSk5H4n
        hOh/5cX1sTF3l3l9X90WQ06tTAE4bfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643630763;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lqNijKTz7QzsNvM1Y20CF0Dy7Qx16blcjfJ9npCqma8=;
        b=LrDoJYTG+hLQzqNBvwnM0Qze9PZu3NMvwPtGX1OberJlXW2OYVLs9eSmcSlmFZ0iBA6YYG
        BLozY6UX/c0oUvAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8CF93A3B87;
        Mon, 31 Jan 2022 12:06:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D101AA05B9; Mon, 31 Jan 2022 13:05:57 +0100 (CET)
Date:   Mon, 31 Jan 2022 13:05:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm/gup: remove get_user_pages_locked()
Message-ID: <20220131120557.rwde6sphc245pzu7@quack3.lan>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131051752.447699-5-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 30-01-22 21:17:52, John Hubbard wrote:
> Unraveling the rat's nest set of APIs in mm/gup.c a bit more.
> get_user_pages_locked() was not helping at all, so remove it.
> 
> Also, lookup_node() has only a single caller, but it is still worth
> having a clearer locking policy there. Changing it so that the caller
> both takes and releases the mmap_lock, thus leaving lookup_node() with
> the sole job of translating a virtual address into a numa node ID.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Well, the point of _locked() GUP variants is that we can unlock mmap_sem
when reading a page from the disk during a page fault (hidden behind
VM_FAULT_RETRY). So as such _locked() variants are about reducing mmap_sem
latency rather than code readability.  In this particular case, I don't
think using _locked() variant in lookup_node() is very beneficial
(generally I would not expect to take a fault there) but at least a
justification in the commit message should be different :).

								Honza

> ---
>  include/linux/mm.h |  2 --
>  mm/gup.c           | 59 ----------------------------------------------
>  mm/mempolicy.c     | 22 ++++++++---------
>  3 files changed, 10 insertions(+), 73 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 80c540c17d83..528ef1cb4f3a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1916,8 +1916,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>  long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages,
>  		    struct vm_area_struct **vmas);
> -long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -		    unsigned int gup_flags, struct page **pages, int *locked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  		    struct page **pages, unsigned int gup_flags);
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> diff --git a/mm/gup.c b/mm/gup.c
> index 58d01a96ab30..4a43c79f0972 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2119,65 +2119,6 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>  }
>  EXPORT_SYMBOL(get_user_pages);
>  
> -/**
> - * get_user_pages_locked() - variant of get_user_pages()
> - *
> - * @start:      starting user address
> - * @nr_pages:   number of pages from start to pin
> - * @gup_flags:  flags modifying lookup behaviour
> - * @pages:      array that receives pointers to the pages pinned.
> - *              Should be at least nr_pages long. Or NULL, if caller
> - *              only intends to ensure the pages are faulted in.
> - * @locked:     pointer to lock flag indicating whether lock is held and
> - *              subsequently whether VM_FAULT_RETRY functionality can be
> - *              utilised. Lock must initially be held.
> - *
> - * It is suitable to replace the form:
> - *
> - *      mmap_read_lock(mm);
> - *      do_something()
> - *      get_user_pages(mm, ..., pages, NULL);
> - *      mmap_read_unlock(mm);
> - *
> - *  to:
> - *
> - *      int locked = 1;
> - *      mmap_read_lock(mm);
> - *      do_something()
> - *      get_user_pages_locked(mm, ..., pages, &locked);
> - *      if (locked)
> - *          mmap_read_unlock(mm);
> - *
> - * We can leverage the VM_FAULT_RETRY functionality in the page fault
> - * paths better by using either get_user_pages_locked() or
> - * get_user_pages_unlocked().
> - *
> - */
> -long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -			   unsigned int gup_flags, struct page **pages,
> -			   int *locked)
> -{
> -	/*
> -	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
> -	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> -	 * vmas.  As there are no users of this flag in this call we simply
> -	 * disallow this option for now.
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> -		return -EINVAL;
> -	/*
> -	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> -	 * never directly by the caller, so enforce that:
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> -		return -EINVAL;
> -
> -	return __get_user_pages_locked(current->mm, start, nr_pages,
> -				       pages, NULL, locked,
> -				       gup_flags | FOLL_TOUCH);
> -}
> -EXPORT_SYMBOL(get_user_pages_locked);
> -
>  /*
>   * get_user_pages_unlocked() is suitable to replace the form:
>   *
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 028e8dd82b44..040d88354cfa 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -907,17 +907,15 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
>  static int lookup_node(struct mm_struct *mm, unsigned long addr)
>  {
>  	struct page *p = NULL;
> -	int err;
> +	int ret;
>  
> -	int locked = 1;
> -	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
> -	if (err > 0) {
> -		err = page_to_nid(p);
> +	mmap_assert_locked(mm);
> +	ret = get_user_pages(addr & PAGE_MASK, 1, 0, &p, NULL);
> +	if (ret > 0) {
> +		ret = page_to_nid(p);
>  		put_page(p);
>  	}
> -	if (locked)
> -		mmap_read_unlock(mm);
> -	return err;
> +	return ret;
>  }
>  
>  /* Retrieve NUMA policy */
> @@ -968,15 +966,15 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>  	if (flags & MPOL_F_NODE) {
>  		if (flags & MPOL_F_ADDR) {
>  			/*
> -			 * Take a refcount on the mpol, lookup_node()
> -			 * will drop the mmap_lock, so after calling
> -			 * lookup_node() only "pol" remains valid, "vma"
> -			 * is stale.
> +			 * Take a refcount on the mpol, because we are about to
> +			 * drop the mmap_lock, after which only "pol" remains
> +			 * valid, "vma" is stale.
>  			 */
>  			pol_refcount = pol;
>  			vma = NULL;
>  			mpol_get(pol);
>  			err = lookup_node(mm, addr);
> +			mmap_read_unlock(mm);
>  			if (err < 0)
>  				goto out;
>  			*policy = err;
> -- 
> 2.35.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
