Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E959B49087D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiAQMO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbiAQMOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:14:55 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:14:55 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id c190so17670332qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uUCg1YItvyrIw9CiOXyM/OuBol/sDAALpX7c8j0fvaI=;
        b=7SlHDseHUVpPddEzwv+4fXqO4TdfNIF9mfH025WwpQ1ebXVTobjMduO9FCh0VaiDYe
         SMH4EBWzX5vIT5/qoLvLepJC3YMrdqoKUyBsUO+9Q96wNnSN1hoU03OKYVFkaAGHFx1T
         fj/vk3ZG45CrQYaznO+Mlf/4L0Q36j2dqV5S7yILS8ESJFDIRAJ4J8UtLyJ7+LWOZcIg
         TTf7N7ovIdIJ9GyT2uG030JMPCXTdIJRnBXNM59F6+nlYgoa+J7RHYzKGNzsYu8cVLyA
         8qY+rL1MKV8uM7M9Oz57ZHECNOPmZUWF24rDZp/Z7uKH+EJ0VvP2lYufxpyVnyUbcdSl
         +g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uUCg1YItvyrIw9CiOXyM/OuBol/sDAALpX7c8j0fvaI=;
        b=MS2lIG2FNhGZ5h9YwpxfIJRtkRPe9xFAYdkT2P8UVNCHb5nzkw3oRg2es6u5RgnjyR
         Ym6wO4mA74BmoBT78k6Yk6eqJxDFYIDGXGLISgj0iomGdaNI75uCUsAt5ogs91as+RnK
         6OsSZVncSNzUTjwZ4OnKl6a6rC36xbIQi6W/A1SRQAZG0p5KDIh3rfp2Eb5kHylCUEjY
         n3qYDBFJQzqURHk1y270fygi10vCmkTVFircStpCxIkN21TB3DqqLV9Ejp364vGgbWC2
         k+bTlJEWMo+nZWzT6m0851gbrB2lSEG7/+asSfFbQskvhezq0zE92CPRJgFOSl7ms8rh
         H7BQ==
X-Gm-Message-State: AOAM532ZvqGOSHjuhVdjBxoLGb/iCfn2z0kqWQajvvnDZqyByepbld8S
        B7C/W381I7ougImfiqXaig1dhw==
X-Google-Smtp-Source: ABdhPJx537Oz6IfeVhDgAwlyGXWeK9OlLGcahtEwqIPOZeC75pvWMLMNQyiaqPc0LZaMaJ5aDqBRng==
X-Received: by 2002:a05:620a:4086:: with SMTP id f6mr126915qko.146.1642421694623;
        Mon, 17 Jan 2022 04:14:54 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bp42sm8871383qtb.61.2022.01.17.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 04:14:54 -0800 (PST)
Date:   Mon, 17 Jan 2022 07:14:53 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
Message-ID: <YeVdvVVBvrXH5U0L@cmpxchg.org>
References: <20220116152150.859520-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116152150.859520-1-yang.yang29@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yang,

On Sun, Jan 16, 2022 at 03:21:51PM +0000, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> When faults in from swap what used to be a ksm page and that page
> had been swapped in before, system has to make a copy. Obviously
> this kind of copy is related to high memory pressure, so we treat
> it as memstall. Although ksm page merging is not because of high
> memory pressure.
> 
> Information of this new kind of stall will help psi to account
> memory pressure more precise.

Thanks for your patch. I'm curious if you have a concrete use case
where this makes a difference, or if this is something you found while
reading the code?

> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  mm/ksm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 4a7f8614e57d..d4ec6773f9b8 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -39,6 +39,7 @@
>  #include <linux/freezer.h>
>  #include <linux/oom.h>
>  #include <linux/numa.h>
> +#include <linux/psi.h>
>  
>  #include <asm/tlbflush.h>
>  #include "internal.h"
> @@ -2569,6 +2570,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
>  {
>  	struct anon_vma *anon_vma = page_anon_vma(page);
>  	struct page *new_page;
> +	unsigned long pflags;
>  
>  	if (PageKsm(page)) {
>  		if (page_stable_node(page) &&
> @@ -2583,6 +2585,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
>  	if (!PageUptodate(page))
>  		return page;		/* let do_swap_page report the error */
>  
> +	psi_memstall_enter(&pflags);
>  	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
>  	if (new_page &&
>  	    mem_cgroup_charge(page_folio(new_page), vma->vm_mm, GFP_KERNEL)) {
> @@ -2600,6 +2603,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
>  #endif
>  	}
>  
> +	psi_memstall_leave(&pflags);

This does unconditional stall accounting for a swapin operation. But
if you take a look at workingset_refault() -> folio_wait_bit_common(),
we only count memory stalls when the page is thrashing, not when it's
a transitionary refault (which happen even when there is enough memory
to hold the workingset). You need to check PageWorkingset() at least.

But again I'd be curious first if this is a practical concern. Swapins
should be IO dominated - or in the case of zswap dominated by the
decompression. Does a page copy really matter?
