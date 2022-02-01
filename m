Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C564A5BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiBAMMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:12:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59258 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbiBAMMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:12:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 73FAE2177B;
        Tue,  1 Feb 2022 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643717563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCyHQiKbzyMEje3YXH4+RB6o4TjGzAk2IiiVc0ZLa6w=;
        b=rAmc4E6ec+0h0h6u4NfHnAj5D8vpFV3M4H77Jrn0zJtcCTOJipA2JCGvzzzaQ/+ihSLtlX
        iJD6oaA9BFK6P3ITWiD5cbxXmCeUYLqtb3g7JvptuvRDjihTAAeeZt3EkSSqgEydXvnsI8
        g+KmEk+8dmkx5fH4rdATG6kxHiXVhZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643717563;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCyHQiKbzyMEje3YXH4+RB6o4TjGzAk2IiiVc0ZLa6w=;
        b=hQO6PgcwBK4YuFXwg1DcfCoRjwZf6JljaT2rbVYSu8JgHejMgHZOLMN9j3LxKJyyN1wH+P
        0QTCSpcUTQ4BdjBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 590E3A3B84;
        Tue,  1 Feb 2022 12:12:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1A047A05B1; Tue,  1 Feb 2022 13:12:43 +0100 (CET)
Date:   Tue, 1 Feb 2022 13:12:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/4] mm/gup: remove get_user_pages_locked()
Message-ID: <20220201121243.zlj66znl64nrnclo@quack3.lan>
References: <20220201101108.306062-1-jhubbard@nvidia.com>
 <20220201101108.306062-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201101108.306062-5-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-02-22 02:11:08, John Hubbard wrote:
> There is only one caller of get_user_pages_locked(). The purpose of
> get_user_pages_locked() is to allow for unlocking the mmap_lock when
> reading a page from the disk during a page fault (hidden behind
> VM_FAULT_RETRY). The idea is to reduce contention on the heavily-used
> mmap_lock. (Thanks to Jan Kara for clearly pointing that out, and in
> fact I've used some of his wording here.)
> 
> However, it is unlikely for lookup_node() to take a page fault. With
> that in mind, change over to calling get_user_pages_fast(). This
> simplifies the code, runs a little faster in the expected case, and
> allows removing get_user_pages_locked() entirely.
> 
> Cc: Jan Kara <jack@suse.cz>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/mm.h |  2 --
>  mm/gup.c           | 59 ----------------------------------------------
>  mm/mempolicy.c     | 21 +++++++----------
>  3 files changed, 9 insertions(+), 73 deletions(-)
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
> index 028e8dd82b44..3f8dc58da3e8 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -907,17 +907,14 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
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
> +	ret = get_user_pages_fast(addr & PAGE_MASK, 1, 0, &p);
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
> @@ -968,14 +965,14 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
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
> +			mmap_read_unlock(mm);
>  			err = lookup_node(mm, addr);
>  			if (err < 0)
>  				goto out;
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
