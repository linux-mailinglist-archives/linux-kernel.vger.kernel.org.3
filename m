Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A464147384B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbhLMXOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhLMXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:14:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E306C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 15:14:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso15818931pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 15:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FwNmwVpIgAbDB44rnby2J0WVT+bFYdkspTHcRPJBdaM=;
        b=gtktlhzdt8fxMF16T+F7VMnDiItDek8wMuKKMo6q+2Hw7DG3t1SitU6BsUd5x5YMsB
         Pojd7pkm6yui1UDMoweINKELjl/DrLgp56uSvsjFqxvoPL3Zp5BQcFiTEQtN8HhGAg3P
         mR6jc3G5WEKXCyuDazWnKHbhmku8ZxX6tp/3AwiGvRCc9nrQAYdRC8y39MG6papq2Vj2
         22Kvtnk5yrEA5vdQmiZ1KZj6oMOFN1+efiOikcJD+8yESPzPKUjvLLQpe4v4Eln0TWyp
         7Ri0nu6Z/dBwtrkJJVpviXF8Z0+6rKuECf+B5uQqyxTj4BUCAxWfztLpRaYzjTvpN9uF
         wy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FwNmwVpIgAbDB44rnby2J0WVT+bFYdkspTHcRPJBdaM=;
        b=L/apQ9d9VjRuoKH3iWvqqKMQkU4BliKRZy2JDFPBee9FPK8aVzE1ulr+hD8lduQVIB
         Pj2yVJD4BD0V3pkfEPi71MVZz7rblLnp3VzEpyiguexDe1FD7HxBV9AN2VX+DvaUxDAQ
         cxUsDAPuwe7LPzbxbeFPF3QR5iC0K2rd5tZhe8+AqZGi4Ylci+9hNyub+6D88LdghhKa
         Q2OFDX6qNOTDuO7t3htPiAAbiaYa3UFIA9uKk0s5YFO7Llc2aECoHOk7/AiarhS4rMAX
         st4kZ9VnPYZh1XcLEkl8n8MU0pjgpBuAJSKnqgTLnCeNnpN7rY/A4stsmHKFnbFQdLsY
         GOIA==
X-Gm-Message-State: AOAM532sIUY6xK+R/MOOSI4bekdUne/UlBg7a3RHCzJywQRKitAIDG/Q
        hSGOccJw99ymA1CZjpYGwZQ=
X-Google-Smtp-Source: ABdhPJxSqz/vAuZ6AEGLqN4ye0OElCVvnV8tjWOCYIGPuu8WzxRtm1HV0XA+sgQs862cwzJ5LGM3Aw==
X-Received: by 2002:a17:902:e804:b0:142:1c0b:c2a6 with SMTP id u4-20020a170902e80400b001421c0bc2a6mr1247730plg.23.1639437252780;
        Mon, 13 Dec 2021 15:14:12 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7fed:4a3e:d021:bbd0])
        by smtp.gmail.com with ESMTPSA id y37sm11087536pga.78.2021.12.13.15.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:14:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 13 Dec 2021 15:14:10 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YbfTwvQ9KuPPHfP2@google.com>
References: <20211206221006.946661-1-minchan@kernel.org>
 <20211206150421.fc06972fac949a5f6bc8b725@linux-foundation.org>
 <Ya6d+zC/CsYAp0Gf@google.com>
 <Ya6g0uXYlR/MRLDD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya6g0uXYlR/MRLDD@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:46:26PM -0800, Minchan Kim wrote:

< snip >

Hi,

Any chance to get review/merge for the testing in next tree?

> From 0874e108b4708355d703927716a49670b989e960 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Mon, 6 Dec 2021 11:59:36 -0800
> Subject: [PATCH v2] mm: don't call lru draining in the nested lru_cache_disable
> 
> lru_cache_disable involves IPIs to drain pagevec of each core,
> which sometimes takes quite long time to complete depending
> on cpu's business, which makes allocation too slow up to
> sveral hundredth milliseconds. Furthermore, the repeated draining
> in the alloc_contig_range makes thing worse considering caller
> of alloc_contig_range usually tries multiple times in the loop.
> 
> This patch makes the lru_cache_disable aware of the fact the
> pagevec was already disabled. With that, user of alloc_contig_range
> can disable the lru cache in advance in their context during the
> repeated trial so they can avoid the multiple costly draining
> in cma allocation.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  * from v1 - https://lore.kernel.org/lkml/20211206221006.946661-1-minchan@kernel.org/
>    * fix lru_cache_disable race - akpm
> 
>  include/linux/swap.h | 14 ++------------
>  mm/cma.c             |  5 +++++
>  mm/swap.c            | 26 ++++++++++++++++++++++++--
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index ba52f3a3478e..fe18e86a4f13 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -348,19 +348,9 @@ extern void lru_note_cost_page(struct page *);
>  extern void lru_cache_add(struct page *);
>  extern void mark_page_accessed(struct page *);
>  
> -extern atomic_t lru_disable_count;
> -
> -static inline bool lru_cache_disabled(void)
> -{
> -	return atomic_read(&lru_disable_count);
> -}
> -
> -static inline void lru_cache_enable(void)
> -{
> -	atomic_dec(&lru_disable_count);
> -}
> -
> +extern bool lru_cache_disabled(void);
>  extern void lru_cache_disable(void);
> +extern void lru_cache_enable(void);
>  extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
> diff --git a/mm/cma.c b/mm/cma.c
> index 995e15480937..60be555c5b95 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -30,6 +30,7 @@
>  #include <linux/cma.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> +#include <linux/swap.h>
>  #include <linux/kmemleak.h>
>  #include <trace/events/cma.h>
>  
> @@ -453,6 +454,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	if (bitmap_count > bitmap_maxno)
>  		goto out;
>  
> +	lru_cache_disable();
> +
>  	for (;;) {
>  		spin_lock_irq(&cma->lock);
>  		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
> @@ -492,6 +495,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  		start = bitmap_no + mask + 1;
>  	}
>  
> +	lru_cache_enable();
> +
>  	trace_cma_alloc_finish(cma->name, pfn, page, count, align);
>  
>  	/*
> diff --git a/mm/swap.c b/mm/swap.c
> index af3cad4e5378..edcfcd6cf38e 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -847,7 +847,17 @@ void lru_add_drain_all(void)
>  }
>  #endif /* CONFIG_SMP */
>  
> -atomic_t lru_disable_count = ATOMIC_INIT(0);
> +static atomic_t lru_disable_count = ATOMIC_INIT(0);
> +
> +bool lru_cache_disabled(void)
> +{
> +	return atomic_read(&lru_disable_count) != 0;
> +}
> +
> +void lru_cache_enable(void)
> +{
> +	atomic_dec(&lru_disable_count);
> +}
>  
>  /*
>   * lru_cache_disable() needs to be called before we start compiling
> @@ -859,7 +869,17 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
>   */
>  void lru_cache_disable(void)
>  {
> -	atomic_inc(&lru_disable_count);
> +	static DEFINE_MUTEX(lock);
> +
> +	mutex_lock(&lock);
> +	/*
> +	 * If someone is already disabled lru_cache, just return with
> +	 * increasing the lru_disable_count.
> +	 */
> +	if (atomic_inc_not_zero(&lru_disable_count)) {
> +		mutex_unlock(&lock);
> +		return;
> +	}
>  #ifdef CONFIG_SMP
>  	/*
>  	 * lru_add_drain_all in the force mode will schedule draining on
> @@ -873,6 +893,8 @@ void lru_cache_disable(void)
>  #else
>  	lru_add_and_bh_lrus_drain();
>  #endif
> +	atomic_inc(&lru_disable_count);
> +	mutex_unlock(&lock);
>  }
>  
>  /**
> -- 
> 2.34.1.400.ga245620fadb-goog
> 
