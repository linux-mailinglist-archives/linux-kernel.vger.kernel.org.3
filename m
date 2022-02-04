Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC14A9885
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiBDLlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:41:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39328 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbiBDLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:41:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5A4F71F38E;
        Fri,  4 Feb 2022 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643974899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5Sv1e977HYYyKSSzGMU2i+xIwcCslr9H/hMxyl4WxQ=;
        b=PpdxpmrIThC0YfEu7BeHD0Cu8hSVyrPOxdPflGO++jEBvxu06QHsWubQ+y+ycNHx0LT35M
        FfiK6FXHLl+P6QcAjhgIwCXNhTwmS2Kb9BTMkiS34Nd6B2qh5AYZDFZ5jG+ZqDNy8hvAOn
        O8IlJMv+x8AkiP5XLkJ7nMXttj4I2q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643974899;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5Sv1e977HYYyKSSzGMU2i+xIwcCslr9H/hMxyl4WxQ=;
        b=v3qY3kMYEBwGW/22MV7tHvbFGYT693wfQa80TMVboWY2cRH6nqDrFQAzmLTMg6Yp4SemUk
        cTkipSiDr49hi3AA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 40B6EA3B81;
        Fri,  4 Feb 2022 11:41:39 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E7995A05B6; Fri,  4 Feb 2022 12:41:37 +0100 (CET)
Date:   Fri, 4 Feb 2022 12:41:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/5] mm/gup: follow_pfn_pte(): -EEXIST cleanup
Message-ID: <20220204114137.7arnme6gutsjzjse@quack3.lan>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
 <20220204020010.68930-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204020010.68930-3-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-02-22 18:00:07, John Hubbard wrote:
> Remove a quirky special case from follow_pfn_pte(), and adjust its
> callers to match. Caller changes include:
> 
> __get_user_pages(): Regardless of any FOLL_* flags, get_user_pages() and
> its variants should handle PFN-only entries by stopping early, if the
> caller expected **pages to be filled in. This makes for a more reliable
> API, as compared to the previous approach of skipping over such entries
> (and thus leaving them silently unwritten).
> 
> move_pages(): squash the -EEXIST error return from follow_page() into
> -EFAULT, because -EFAULT is listed in the man page, whereas -EEXIST is
> not.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/gup.c     | 13 ++++++++-----
>  mm/migrate.c |  7 +++++++
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 80229ecf0114..2df0d0103c43 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -464,10 +464,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
>  static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>  		pte_t *pte, unsigned int flags)
>  {
> -	/* No page to get reference */
> -	if (flags & (FOLL_GET | FOLL_PIN))
> -		return -EFAULT;
> -
>  	if (flags & FOLL_TOUCH) {
>  		pte_t entry = *pte;
>  
> @@ -1205,8 +1201,15 @@ static long __get_user_pages(struct mm_struct *mm,
>  		} else if (PTR_ERR(page) == -EEXIST) {
>  			/*
>  			 * Proper page table entry exists, but no corresponding
> -			 * struct page.
> +			 * struct page. If the caller expects **pages to be
> +			 * filled in, bail out now, because that can't be done
> +			 * for this page.
>  			 */
> +			if (pages) {
> +				ret = PTR_ERR(page);
> +				goto out;
> +			}
> +
>  			goto next_page;
>  		} else if (IS_ERR(page)) {
>  			ret = PTR_ERR(page);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c7da064b4781..be0d5ae36dc1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1761,6 +1761,13 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			continue;
>  		}
>  
> +		/*
> +		 * The move_pages() man page does not have an -EEXIST choice, so
> +		 * use -EFAULT instead.
> +		 */
> +		if (err == -EEXIST)
> +			err = -EFAULT;
> +
>  		/*
>  		 * If the page is already on the target node (!err), store the
>  		 * node, otherwise, store the err.
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
