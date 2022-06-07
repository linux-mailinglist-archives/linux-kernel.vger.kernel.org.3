Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2838854009F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbiFGOBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiFGOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:01:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29032C1EC0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FMkgIVtfc6b3ABx6BakkG50qZIp134U+1xyaQI6WTD8=; b=k8JbLNQUimojEC6ifvDTH5sfBP
        fpvni16t938kNcvgN3NGuZMkLpTFRwZPmW+HZ/szX/M1gGJT13+XYYDZNUOwIf+qlQUkEk+K4u8Pk
        8dxFvwbIbB7bjovt9aU+7G9tZVK4BB4Cl1kMQw5IdwzDWJqPG3XNsEXvqWW06fxwhPqcugWKR5B4T
        TQxRRM9rGeaaKHQlYG5seTLr3t7WtmgAhc0olggJu5sWL3LNwot8Mc1jH0IPRY/idksvHnw7yTP9o
        W7g1ZyAaLTf8Nafz1asHScega2Y5dCD87Sm2x7vmWBBVnjiLLH8HfL4/qx5iWzbEsrBxZJBaAhjvE
        ByDDgtUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyZm6-00Bgqd-J3; Tue, 07 Jun 2022 14:01:38 +0000
Date:   Tue, 7 Jun 2022 15:01:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: Always read one page in
 do_sync_mmap_readahead()
Message-ID: <Yp9aQk66fkP8MdOS@casper.infradead.org>
References: <20220607083714.183788-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607083714.183788-1-apopple@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 06:37:14PM +1000, Alistair Popple wrote:
> ---
>  include/linux/pagemap.h |  7 +++---
>  mm/filemap.c            | 47 +++++++++++++----------------------------
>  2 files changed, 18 insertions(+), 36 deletions(-)

Love the diffstat ;-)

> @@ -3011,14 +3001,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	}
>  #endif
>  
> -	/* If we don't want any read-ahead, don't bother */
> -	if (vmf->vma->vm_flags & VM_RAND_READ)
> -		return fpin;
> -	if (!ra->ra_pages)
> -		return fpin;
> -
> +	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  	if (vmf->vma->vm_flags & VM_SEQ_READ) {
> -		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		page_cache_sync_ra(&ractl, ra->ra_pages);
>  		return fpin;
>  	}

Good.  Could even pull the maybe_unlock_mmap_for_io() all the way to the
top of the file and remove it from the VM_HUGEPAGE case?

> @@ -3029,19 +3013,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
>  
>  	/*
> -	 * Do we miss much more than hit in this file? If so,
> -	 * stop bothering with read-ahead. It will only hurt.
> +	 * mmap read-around. If we don't want any read-ahead or if we miss more
> +	 * than we hit don't bother with read-ahead and just read a single page.
>  	 */
> -	if (mmap_miss > MMAP_LOTSAMISS)
> -		return fpin;
> +	if ((vmf->vma->vm_flags & VM_RAND_READ) ||
> +	    !ra->ra_pages || mmap_miss > MMAP_LOTSAMISS) {
> +		ra->start = vmf->pgoff;
> +		ra->size = 1;
> +		ra->async_size = 0;
> +	} else {

I'd put the:
		/* mmap read-around */
here

> +		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> +		ra->size = ra->ra_pages;
> +		ra->async_size = ra->ra_pages / 4;
> +	}
>  
> -	/*
> -	 * mmap read-around
> -	 */
> -	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> -	ra->size = ra->ra_pages;
> -	ra->async_size = ra->ra_pages / 4;
>  	ractl._index = ra->start;
>  	page_cache_ra_order(&ractl, ra, 0);
>  	return fpin;
> @@ -3145,9 +3130,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  			filemap_invalidate_lock_shared(mapping);
>  			mapping_locked = true;
>  		}
> -		folio = __filemap_get_folio(mapping, index,
> -					  FGP_CREAT|FGP_FOR_MMAP,
> -					  vmf->gfp_mask);
> +		folio = filemap_get_folio(mapping, index);
>  		if (!folio) {
>  			if (fpin)
>  				goto out_retry;

I think we also should remove the filemap_invalidate_lock_shared()
here, no?

We also need to handle the !folio case differently.  Before, if it was
gone, that was definitely an OOM.  Now if it's gone it might have been
truncated, or removed due to memory pressure, or it might be an OOM
situation where readahead didn't manage to create the folio.

