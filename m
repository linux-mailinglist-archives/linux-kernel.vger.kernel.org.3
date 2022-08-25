Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E710A5A087B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiHYFh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiHYFhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E19E8A5;
        Wed, 24 Aug 2022 22:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B91C6188A;
        Thu, 25 Aug 2022 05:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BBAC43143;
        Thu, 25 Aug 2022 05:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661405870;
        bh=qOLfoV0IgOKr5PMe3anUuc+Joh2rLAPVGfEbDbkvfwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcHRjYTovce0Ftq/5wFj1mU72Zww7WCd1SaJq9F1GVfA6KQngN30YDcmmRV9SlxJp
         UT0PCbebb4M5vDcSuPZPFg88ym9jcZjoPhMn50p0pq8MvRXFJKfWm4M8fPnJqRW9M1
         QaG5TMCqGYnmbLj6H0oDft4ueMNg4INOHPLYNy55tdylijAVej4EheOinJW9nCkmo4
         JQItX0ust6LF8ZHWmTFkfAK3oeUWjBxakOuml4gkQ7NL0i/5XujznGtg1tIRQGk0gW
         esn1VmbT5UVbwy5Nf0D1Ps5Vk+qY5zTN4eZ/17fq7A/zSeHbuX4QW7rnnnhQMFNMAV
         LzLRl4MdSer+w==
Date:   Thu, 25 Aug 2022 08:37:43 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sgx: Print EREMOVE return value in
 __sgx_sanitize_pages()
Message-ID: <YwcKpzJMGVet0epv@kernel.org>
References: <20220825051827.246698-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825051827.246698-1-jarkko@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 08:18:27AM +0300, Jarkko Sakkinen wrote:
> In the 2nd run of __sgx_sanitize_pages() print the error
> message. All EREMOVE's should succeed. This will allow to
> provide some additional clues, if not.
> 
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 515e2a5f25bb..33354921c59f 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -50,7 +50,7 @@ static LIST_HEAD(sgx_dirty_page_list);
>   * from the input list, and made available for the page allocator. SECS pages
>   * prepending their children in the input list are left intact.
>   */
> -static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
> +static void __sgx_sanitize_pages(struct list_head *dirty_page_list, bool verbose)
>  {
>  	struct sgx_epc_page *page;
>  	LIST_HEAD(dirty);
> @@ -90,6 +90,9 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
>  			list_del(&page->list);
>  			sgx_free_epc_page(page);
>  		} else {
> +			if (verbose)
> +				pr_err_ratelimited(EREMOVE_ERROR_MESSAGE, ret, ret);
> +
>  			/* The page is not yet clean - move to the dirty list. */
>  			list_move_tail(&page->list, &dirty);
>  		}
> @@ -394,8 +397,8 @@ static int ksgxd(void *p)
>  	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
>  	 * required for SECS pages, whose child pages blocked EREMOVE.
>  	 */
> -	__sgx_sanitize_pages(&sgx_dirty_page_list);
> -	__sgx_sanitize_pages(&sgx_dirty_page_list);
> +	__sgx_sanitize_pages(&sgx_dirty_page_list, false);
> +	__sgx_sanitize_pages(&sgx_dirty_page_list, true);
>  
>  	/* sanity check: */
>  	WARN_ON(!list_empty(&sgx_dirty_page_list));
> -- 
> 2.37.1
> 

Should this also print the number of pages not eremoved?

That would render out the need for WARN_ON() at call site,
and would provide more data.

BR, Jarkko
