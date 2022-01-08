Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13710488460
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiAHQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiAHQFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:05:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F377C06173F;
        Sat,  8 Jan 2022 08:05:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2532860DD0;
        Sat,  8 Jan 2022 16:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09373C36AE3;
        Sat,  8 Jan 2022 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641657930;
        bh=dk8QUev5sH4DU0fCiL7FLNaJ7jVlAe2KzCfeX3x8qPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sY8RkShcCbllE8PG7jFTEZacrQhVb5I7bGmTgobLF7RyG6DbUxY5hWs8oO8N2nZin
         1HUzb1eMyA7CPHLYPYn3t1zasnskWXqJYUjsszdcTXDJa/2b7zzXH89VzB5MLCVQFo
         Z4hI23L4+hXE+MoO8cMVxejcCdmjFwZTm0xXxbK0NM5YwP/mLbkDWTRPnUBU7AjmWY
         k9NemHkN0R83hUfDs4+LFql9DzehjTLx+sDjmJ0mjQxG01md2YtkyW5YKs+KLKVdxW
         3CMt2O2VzdruparmEP/6u84zwABWIJzVXCJb7RL24NmC0Aneo8jogOiP9kG9+VfPvo
         janq1YcigUVvg==
Date:   Sat, 8 Jan 2022 18:05:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
Message-ID: <Ydm2Qk8JFwgdueZa@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-3-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107181618.6597-3-kristen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:16:17AM -0800, Kristen Carlson Accardi wrote:
> SGX may allow EPC pages to be overcommitted. If the system is
> out of enclave memory, EPC pages are swapped to normal RAM via
> a per enclave shared memory area. This shared memory is not
> charged to the enclave or the task mapping it, making it hard
> to account for using normal methods.
> 
> In order to avoid unlimited usage of normal RAM, enclaves must be
> charged for each new page used for backing storage, and uncharged
> when they are no longer using a backing page.
> 
> Modify the existing flow for requesting backing pages to reduce the
> available backing page counter and confirm that the limit has not
> been exceeded. Backing page usage for loading EPC pages back out of
> the shared memory do not incur a charge.
> 
> When a backing page is released from usage, increment the available
> backing page counter.
> 
> When swapping EPC pages to RAM, in addition to storing the page
> contents, SGX must store some additional metadata to protect
> against a malicious kernel when the page is swapped back in. This
> additional metadata is called Paging Crypto MetaData. PCMD is
> allocated from the same shared memory area as the backing page
> contents and consumes RAM the same way.
> 
> PCMD is 128 bytes in size, and there is one PCMD structure per
> page written to shared RAM. The page index for the PCMD page is
> calculated from the page index of the backing page, so it is possible
> that the PCMD structures are not packed into the minimum number of
> pages possible. If 32 PCMDs can fit onto a single page, then PCMD
> usage is 1/32 of total EPC pages. In the worst case, PCMD can
> consume the same amount of RAM as EPC backing pages (1:1). For
> simplicity, this implementation does not account for PCMD page usage.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 76 ++++++++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/sgx/encl.h |  6 ++-
>  arch/x86/kernel/cpu/sgx/main.c |  6 +--
>  3 files changed, 80 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 001808e3901c..8be6f0592bdc 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -32,7 +32,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	else
>  		page_index = PFN_DOWN(encl->size);
>  
> -	ret = sgx_encl_get_backing(encl, page_index, &b);
> +	ret = sgx_encl_lookup_backing(encl, page_index, &b);
>  	if (ret)
>  		return ret;
>  
> @@ -407,6 +407,12 @@ void sgx_encl_release(struct kref *ref)
>  			sgx_encl_free_epc_page(entry->epc_page);
>  			encl->secs_child_cnt--;
>  			entry->epc_page = NULL;
> +		} else {
> +			/*
> +			 * If there is no epc_page, it means it has been
> +			 * swapped out. Uncharge the backing storage.
> +			 */
> +			sgx_uncharge_mem();
>  		}
>  
>  		kfree(entry);
> @@ -574,8 +580,8 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
>   *   0 on success,
>   *   -errno otherwise.
>   */
> -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
> -			 struct sgx_backing *backing)
> +static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
> +				struct sgx_backing *backing)
>  {
>  	pgoff_t pcmd_index = PFN_DOWN(encl->size) + 1 + (page_index >> 5);
>  	struct page *contents;
> @@ -601,6 +607,62 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
>  	return 0;
>  }
>  
> +/**
> + * sgx_encl_alloc_backing() - allocate a new backing storage page
> + * @encl:	an enclave pointer
> + * @page_index:	enclave page index
> + * @backing:	data for accessing backing storage for the page
> + *
> + * Confirm that the global overcommit limit has not been reached before
> + * requesting a new backing storage page for storing the encrypted contents
> + * and Paging Crypto MetaData (PCMD) of an enclave page. This is called when
> + * there is no existing backing page, just before writing to the backing
> + * storage with EWB.
> + *
> + * Return:
> + *   0 on success,
> + *   -errno otherwise.
> + */
> +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
> +			   struct sgx_backing *backing)
> +{
> +	int ret;
> +
> +	if (sgx_charge_mem())
> +		return -ENOMEM;
> +
> +	ret = sgx_encl_get_backing(encl, page_index, backing);
> +	if (ret)
> +		sgx_uncharge_mem();
> +
> +	return ret;
> +}
> +
> +/**
> + * sgx_encl_lookup_backing() - retrieve an existing backing storage page
> + * @encl:	an enclave pointer
> + * @page_index:	enclave page index
> + * @backing:	data for accessing backing storage for the page
> + *
> + * Retrieve a backing page for loading data back into an EPC page with ELDU.
> + * This call does not cause a charge to the overcommit limit because a page
> + * has already been allocated, but has been swapped out or is in RAM
> + *
> + * It is the caller's responsibility to ensure that it is appropriate to
> + * use sgx_encl_lookup_backing() rather than sgx_encl_alloc_backing(). If
> + * lookup is not used correctly, this will cause an allocation that is
> + * not accounted for.
> + *
> + * Return:
> + *   0 on success,
> + *   -errno otherwise.
> + */
> +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
> +			    struct sgx_backing *backing)
> +{
> +	return sgx_encl_get_backing(encl, page_index, backing);
> +}

IMHO, sgx_encl_backing() should be open-coded here.

> +
>  /**
>   * sgx_encl_put_backing() - Unpin the backing storage
>   * @backing:	data for accessing backing storage for the page
> @@ -608,9 +670,17 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
>   */
>  void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write)
>  {
> +	/*
> +	 * If the page is being written to by the reclaimer, it is
> +	 * still in use and the backing page usage should not be
> +	 * uncharged. However, if the page is not being written to,
> +	 * it is no longer in use and may be uncharged.
> +	 */
>  	if (do_write) {
>  		set_page_dirty(backing->pcmd);
>  		set_page_dirty(backing->contents);
> +	} else {
> +		sgx_uncharge_mem();
>  	}
>  
>  	put_page(backing->pcmd);
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index fec43ca65065..8ffb8a83263f 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -105,8 +105,10 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  
>  void sgx_encl_release(struct kref *ref);
>  int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
> -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
> -			 struct sgx_backing *backing);
> +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
> +			   struct sgx_backing *backing);

This might sound overly long but it really would make this a lot clearer
than alloc, which can mean pretty much anything:

sgx_encl_lookup_and_charge_backing()

What do you think? That leaves no guesswork what the function does.

> +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
> +			    struct sgx_backing *backing);
>  void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
>  int sgx_encl_test_and_clear_young(struct mm_struct *mm,
>  				  struct sgx_encl_page *page);
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 8a7bfe0d9023..20ccd9c5b184 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -347,8 +347,8 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
>  	encl->secs_child_cnt--;
>  
>  	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flags)) {
> -		ret = sgx_encl_get_backing(encl, PFN_DOWN(encl->size),
> -					   &secs_backing);
> +		ret = sgx_encl_alloc_backing(encl, PFN_DOWN(encl->size),
> +					     &secs_backing);
>  		if (ret)
>  			goto out;
>  
> @@ -418,7 +418,7 @@ static void sgx_reclaim_pages(void)
>  			goto skip;
>  
>  		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
> -		ret = sgx_encl_get_backing(encl_page->encl, page_index, &backing[i]);
> +		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i]);
>  		if (ret)
>  			goto skip;
>  
> -- 
> 2.20.1
> 

/Jarkko
