Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39584FACA3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 10:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiDJIO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiDJIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 04:14:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E8321268
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:12:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n8so11457184plh.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lTMJby6vZp5+oevf70LG/5KPI9wfU2uYdg1+BVg4hQ=;
        b=AxDvhhasXMb+E7oXpNukrTdMVh2w0bnmAiVXGITf9LtuX+jcozjvECLSWFX61CHd/i
         BgzFyLA1gSM74dYkLE32I6xipNyl6uXtho+NLy92S3R4EQ7Azs7/HmEkt23DVB8yTC2C
         UM4jajNFBehCh35vUyy12RGoQZW7rsZFbMghElxSvy6JxHuatB4u4qzPlrOknHpwzz2g
         TOymXUW/GryXyjagkzmsixmYMC2etVTh4y+O2dEFpCEv47NHV2nX8k7ZgDbjBsxii8iV
         CyWpkup2xUdDW0I3eSVXGDGPjkNxJWz8mkjYd0bduQl7Ju94CO79jACL1DDuoudTd/D0
         nRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lTMJby6vZp5+oevf70LG/5KPI9wfU2uYdg1+BVg4hQ=;
        b=sWDOCjjgeKaj/mNkZnyCUs4IOef7AylUKK7hM939WawjPd+anzSWiya/1DIS6rC2es
         zT9JedkF/qpfzUMcfNi2Bn4qrmP28tJBlxAE/r+pmreuMYKg2KuYXsK6EMx1tjMMTUod
         TrKI19IUpy6JLV7tL/K2f9l9oJH3V4fjJzG0y7LxG6OBJbi2JdPj1aalsIaUQ5ZRZGEe
         TGa5Z0n/qq8RF2xr/IxLbP7i/I0IPyoc8WvFfgL0yyjRif4TN1lM6sAbY6HACZskdZ+r
         rgEooME2GHImZl16ADcbdp+jDdKA3Vg+XEXbXQFjYyPf72rS2qnvgOiaIcOUKuumbvgR
         0iCA==
X-Gm-Message-State: AOAM530FrDlHLhUzOC8f2nx8vztUwlQc/gPfcYOpocoIu84YMN//SuMT
        osR3uItw+kJxc1cwEEwAYHA=
X-Google-Smtp-Source: ABdhPJzKF27YLsKUZLTUaesw+RUsU+PEO3XccP/UBxusv98NKH8OFcb7FhRgbZ0Kus3qAceqm4qFhQ==
X-Received: by 2002:a17:90a:5409:b0:1ca:8a21:323b with SMTP id z9-20020a17090a540900b001ca8a21323bmr31000899pjh.135.1649578333453;
        Sun, 10 Apr 2022 01:12:13 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090a6c9000b001c993d935e7sm17016731pjj.56.2022.04.10.01.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 01:12:11 -0700 (PDT)
Date:   Sun, 10 Apr 2022 17:12:04 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Ohhoon Kwon <ohkwon1043@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: check pfmemalloc_match in slab_alloc_node
 fastpath
Message-ID: <YlKRVOgAFqdgtxDu@hyeyoo>
References: <20220409160224.611353-1-ohkwon1043@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409160224.611353-1-ohkwon1043@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 01:02:23AM +0900, Ohhoon Kwon wrote:
> If current alloc context does not have __GFP_MEMALLOC in its gfpflags,
> then slab objects that were previously created with __GFP_MEMALLOC
> should not be given.
> 
> This criteria is well kept in slab alloc slowpath:
> When gfpflags does not contain __GFP_MEMALLOC but if per-cpu slab page
> was allocated with __GFP_MEMALLOC, then allocator first deactivates
> per-cpu slab page and then again allocates new slab page with the
> current context's gfpflags.
> 
> However, this criteria is not checked in fastpath.
> It should also be checked in the fastpath, too.
> 
> Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 74d92aa4a3a2..c77cd548e106 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3179,7 +3179,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>  	 * there is a suitable cpu freelist.
>  	 */
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
> -	    unlikely(!object || !slab || !node_match(slab, node))) {
> +	    unlikely(!object || !slab || !node_match(slab, node) ||
> +			!pfmemalloc_match(slab, gfpflags))) {
>  		object = __slab_alloc(s, gfpflags, node, addr, c);
>  	} else {
>  		void *next_object = get_freepointer_safe(s, object);

The missing pfmemalloc check in fastpath was intended.

pfmemalloc check in fast did exist in Mel's commit 072bb0aa5e0629 ("mm:
sl[au]b: add knowledge of PFMEMALLOC reserve pages").

But later removed by Christoph's commit 5091b74a95d4 ("mm: slub: optimise
the SLUB fast path to avoid pfmemalloc checks").

Any thoughts?

Thanks!

-- 
Thanks,
Hyeonggon
