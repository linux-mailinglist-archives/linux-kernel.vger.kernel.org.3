Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A6501FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348050AbiDOAj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbiDOAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:39:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C93BBF8;
        Thu, 14 Apr 2022 17:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649983050; x=1681519050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NqIg0JIeL+aLq0L6edg0YyzM2lgFxJdLKtyUthSAtWE=;
  b=BaRgvRQxv0PisaUB6y8yT0YtMva/5s3fPNOsAoJgXtYi0UzYRGd1HsJD
   8nzevtt/ySmfkkqKlrrVhIIHKfqrWi8Q6WDXr0VV1X6A1M7Rcu/nux5n8
   ci5jvTn2Wtv8Iu8MIye+5HaN9+CPOvb3J/Da4KADv0+dMAvo/CmINUMnA
   DGyZSSK4ebP5QpgVhbbQlOBScwWUge3WA1jAlmXfLkdz3gZJA8XlcGcGu
   gMpKNcPHuPquQl0x9JFBmn/VzIEHhoPntJyS/sencQHDqOec0cWq36AdZ
   02jq9v7O6fMeMb8PJ+OvniSyVMqP7Bd9BlbTTRE7cfk2ROTOPWKxRaubx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349500063"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="349500063"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 17:37:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="508609395"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 17:37:28 -0700
Date:   Thu, 14 Apr 2022 17:37:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in
 hmm_store()
Message-ID: <Yli+R7iLZKqO8kVP@iweiny-desk3>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413225531.9425-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:55:31AM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. The same is true for kmap_atomic().
> 
> In file pci/hmm/hmm.c, function hmm_store() test if we are in atomic
> context and, if so, it calls kmap_atomic(), if not, it calls kmap().
> 
> First of all, in_atomic() shouldn't be used in drivers. This macro
> cannot always detect atomic context; in particular, it cannot know
> about held spinlocks in non-preemptible kernels.
> 
> Notwithstanding what it is said above, this code doesn't need to care
> whether or not it is executing in atomic context. It can simply use
> kmap_local_page() / kunmap_local() that can instead do the mapping /
> unmapping regardless of the context.
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Therefore, hmm_store()() is a function where the use
> of kmap_local_page() in place of both kmap() and kmap_atomic() is
> correctly suited.
> 
> Convert the calls of kmap() / kunmap() and kmap_atomic() /
> kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
> unnecessary tests which test if the code is in atomic context.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

I've had to research this a bit myself because I've not seen this pattern
before.

kmap_atomic() had 2 uses:

	1) a situation where the operation on the page requires pagefaults
	   and/or preemption to be disabled
	2) in a situation where one knows the code can't sleep

kmap_local_page() removes the second use case because kmap() is no longer the
only alternative; from the kdoc for kmap_atomic():

...
 * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
...
 * Effectively a wrapper around kmap_local_page() which disables pagefaults
 * and preemption.
...

The deprecation is because any pagefault/preemption disabling should probably
be done explicitly from now on but allows for existing kmap_atomic() callers to
live on.

In this case, I suspect the original driver writer wanted to use kmap() but
hmm_store() was called from various contexts.  So they incorrectly tried to
protect against the (potentially) sleeping kmap() call.  In reality, I think
they could have simply called kmap_atomic() and skipped 'in_atomic()' check
altogether.

Regardless now that kmap_local_page() exists, this is correct.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/staging/media/atomisp/pci/hmm/hmm.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> index 46ac082cd3f1..54188197c3dc 100644
> --- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
> +++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
> @@ -482,10 +482,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
>  		idx = (virt - bo->start) >> PAGE_SHIFT;
>  		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
>  
> -		if (in_atomic())
> -			des = (char *)kmap_atomic(bo->page_obj[idx].page);
> -		else
> -			des = (char *)kmap(bo->page_obj[idx].page);
> +		des = (char *)kmap_local_page(bo->page_obj[idx].page);
>  
>  		if (!des) {
>  			dev_err(atomisp_dev,
> @@ -512,14 +509,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
>  
>  		clflush_cache_range(des, len);
>  
> -		if (in_atomic())
> -			/*
> -			 * Note: kunmap_atomic requires return addr from
> -			 * kmap_atomic, not the page. See linux/highmem.h
> -			 */
> -			kunmap_atomic(des - offset);
> -		else
> -			kunmap(bo->page_obj[idx].page);
> +		kunmap_local(des);
>  	}
>  
>  	return 0;
> -- 
> 2.34.1
> 
