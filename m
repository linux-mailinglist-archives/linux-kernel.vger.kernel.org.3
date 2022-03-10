Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7744D4C76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbiCJO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347070AbiCJOu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B9318DAB7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:45:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b8so5421794pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RPULJMtRKjA9XHVfCiU0lkTP5Po3/tVc3d3ybzr9pAI=;
        b=byClIQkE7K9xa0RUPSQIo8oicPjQHvO18luT1iFudeZHAwG/hmzPYRusS3SBg/y8Yz
         4xha71rAYfjUyIW8SiJMR5OVAf4y75iDDx2BAHwi/2H0qMNBNfdYV1e1Sr1YDxwV1gxO
         e8aG5gKO45NmxNHTT9LGtYN22t9cPih2/dZJ66v69DdqrU8nrkmS+QFG8wVcplvrfnCP
         P5y8vEyEpFx1YEt/RT/wRxb1YPV63wRAHyXLmVqOSnZnXAzu+tlT+0SXrUHBfH6wlDhG
         1RCZma7jOYDiqOAQz4L2xGjDP9YEDiIcyEG3YD2Xo0haSnLqkkmY5G7vPVowX4yvrdjS
         /ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RPULJMtRKjA9XHVfCiU0lkTP5Po3/tVc3d3ybzr9pAI=;
        b=n+yY/WoL3CTxjUv/qZ6+HJ4JJBU2KRGC5c/3WPLBel8A/7zTGVAPHZysMgmMf3ElAg
         mS0Wg7tNf4LD8tTYyNcw4aAg4rvBtRDI2cvA9LQKOJC5I03FDkS6Y0IDfPNHG2WchIxz
         LNyS7J5lf7ZwlIdY0GkU+ahHDbFKGSIrlyY4jOTpfMinZS5CseczkxOY8x5kuwGCu2mh
         5bpbTxwak3SgM0NyOhC0lbsn4uWiAChoBs/fBl/usAP/jpqj4xrejiXhNml/UXS6unW/
         XpRvF2b7Tpqn4dzibYWG18hK/GzcbPp3aAGY50+NLN4HBiKxnwyGefzc2rgS0BQ2IeA7
         dpMg==
X-Gm-Message-State: AOAM530lnB90fS5z3b0N1MYXhZ/QOY1xhq0EF9DDOhHWm6YlroCtKDuW
        ukbN6FzaSAT1r/CLYTN1faA=
X-Google-Smtp-Source: ABdhPJwZUmXQFM3Uvcfr5KMlb0Cc/uEttYBjsXg12377+TEKKxHNKSo5/XbJw4PSJO/SdlQluC6YNw==
X-Received: by 2002:a17:902:e5cc:b0:151:f626:9153 with SMTP id u12-20020a170902e5cc00b00151f6269153mr5502607plf.41.1646923531533;
        Thu, 10 Mar 2022 06:45:31 -0800 (PST)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a1a0100b001bf3ba1508fsm6275329pjk.33.2022.03.10.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:45:31 -0800 (PST)
Date:   Thu, 10 Mar 2022 14:45:24 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, willy@infradead.org,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH v2 2/2] mm: slub: Delete useless parameter of
 alloc_slab_page()
Message-ID: <20220310144524.GA1166889@odroid>
References: <20220310140701.87908-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140701.87908-1-sxwjean@me.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Xiongwei Song <sxwjean@gmail.com>
>
> The parameter @s is useless for alloc_slab_page(). It was added in 2014
> by commit 5dfb41750992 ("sl[au]b: charge slabs to kmemcg explicitly"). The
> need for it was removed in 2020 by commit 1f3147b49d75 ("mm: slub: call
> account_slab_page() after slab page initialization"). Let's delete it.
>
> [willy@infradead.org: Added detailed history of @s]
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
> mm/slub.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 261474092e43..5d273ee04c43 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1788,8 +1788,8 @@ static void *setup_object(struct kmem_cache *s, struct slab *slab,
>  /*
>  * Slab allocation and freeing
>  */
> -static inline struct slab *alloc_slab_page(struct kmem_cache *s,
> -		gfp_t flags, int node, struct kmem_cache_order_objects oo)
> +static inline struct slab *alloc_slab_page(gfp_t flags, int node,
> +		struct kmem_cache_order_objects oo)
>  {
>  	struct folio *folio;
> 	struct slab *slab;
> @@ -1941,7 +1941,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
> 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
> 
>-	slab = alloc_slab_page(s, alloc_gfp, node, oo);
>+	slab = alloc_slab_page(alloc_gfp, node, oo);
> 	if (unlikely(!slab)) {
> 		oo = s->min;
> 		alloc_gfp = flags;
>@@ -1949,7 +1949,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> 		 * Allocation may have failed due to fragmentation.
> 		 * Try a lower order alloc if possible
> 		 */
>-		slab = alloc_slab_page(s, alloc_gfp, node, oo);
>+		slab = alloc_slab_page(alloc_gfp, node, oo);
> 		if (unlikely(!slab))
> 			goto out;
> 		stat(s, ORDER_FALLBACK);

Looks good, nice changelog!

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
