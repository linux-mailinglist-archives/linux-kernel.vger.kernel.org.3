Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED868465D24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhLBDw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355294AbhLBDtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:49:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E07C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 19:46:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1368873pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 19:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U18hQOa1FAfUqBSBf0IHqKmw+XLYtAfpFzE91QsNYTg=;
        b=VvjoFCNgO7dQ9CmQz7jR1i383nSaFiLDDqkA4qXWNkaRz+ZKFTc5s2NrDuI/mZjgXl
         bAeS23+4XrAMvC6nEfq3CY+2iyeHbNCwpdpTesLleGSRqvwfSafC8Idh7EJfa8cS5T7b
         gJtxe3CKz0R44ZuyiBvczOezUDv5aFYt04Puk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U18hQOa1FAfUqBSBf0IHqKmw+XLYtAfpFzE91QsNYTg=;
        b=chfbm/qtwD/JPYMBBxi1JJvmY41lN3JnfUX57Q+RudMIvFdsisvyoEJ3oYPZq408/k
         7hu+QYUlB0NQbPvXtGK0vmKzBE6qOBBVuTHKmwB8mcU2NHRYiUoScRja2OpnZy1ZJo8H
         zAMUeRaPjPgn2L6/K6F/bRwU+zNumD+8iiL+LQEpd9/JZN4ixJgGpyA22/yND+9OJwLX
         DRVHWS+c54egRwFEeAB5qTkni54LP3zrZCdGj2O8MVsTktpyCV0ZEdE90vO7jUWS1Z0e
         T2a7jWs6uWyQYS8WLa1OtOjF0W+3tJgwAYBCDFhmJVQ1BpWMN8RctHiRFxD8wMfwZXU5
         Ro8A==
X-Gm-Message-State: AOAM532hh2GeHpiI5F2WAQEVB8b6aPQqikjWj+WT9QLvNV4oVwsV1C/8
        61UAtIGuYdGyO8wdZ6APkUrouQ==
X-Google-Smtp-Source: ABdhPJzcpXGaQ+4r1kHUtZXRZ3AUdxl+eWulvIrGiLca5ySRdpf1O1iM5DM7H84EO2vs9Jxci2X3cA==
X-Received: by 2002:a17:90a:c297:: with SMTP id f23mr3058243pjt.138.1638416762323;
        Wed, 01 Dec 2021 19:46:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm1286104pfv.48.2021.12.01.19.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 19:46:01 -0800 (PST)
Date:   Wed, 1 Dec 2021 19:46:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, leon@kernel.org,
        akpm@linux-foundation.org, w@1wt.eu
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <202112011944.28EF2FC44@keescook>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:06:24AM +0800, Bixuan Cui wrote:
> Delete the WARN_ON() and return NULL directly for oversized parameter
> in kvmalloc() calls.
> Also add unlikely().
> 
> Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
> Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
> ---
> There are a lot of oversize warnings and patches about kvmalloc() calls
> recently. Maybe these warnings are not very necessary.

It seems these warnings are working, yes? i.e. we're finding the places
where giant values are coming in?

> 
> https://lore.kernel.org/all/YadOjJXMTjP85MQx@unreal
> 
> The example of size check in __do_kmalloc_node():
> __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> {
>         struct kmem_cache *cachep;
>         void *ret;
> 
>         if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
>                 return NULL;
>         cachep = kmalloc_slab(size, flags);
> 
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 7e433690..d26f19c 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -587,7 +587,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  		return ret;
>  
>  	/* Don't even allow crazy sizes */
> -	if (WARN_ON_ONCE(size > INT_MAX))
> +	if (unlikely(size > INT_MAX))
>  		return NULL;

If we're rejecting the value, then it's still a pathological size, so
shouldn't the check be happening in the caller? I think the WARN is
doing exactly what it was supposed to do: find the places where bad
sizes can reach vmalloc.

-Kees

>  
>  	return __vmalloc_node(size, 1, flags, node,
> -- 
> 1.8.3.1
> 

-- 
Kees Cook
