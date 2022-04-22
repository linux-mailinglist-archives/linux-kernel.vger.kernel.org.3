Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B950B7A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447643AbiDVMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiDVMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:49:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5D56770
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:46:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u15so7228704ple.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TssqWSCUtM99yB2weekRLelNZn0id75Zrkx5XljmNCI=;
        b=eVpFjhxnWCXhGc3aru33nXNQWFa6GTAqYVyc6IL5o/roTdkaNcRWwywMzg0sU+Xqvv
         MtfvBoi02hXEOAxFTLa03aWu2H+EgKWcIi03Ag4IHYkNB5LMJlSVVm7IfezA2ghumVNu
         4jNkfTWQ0gcv/Tuk8/PljVFEuRRanMh66N18ff9HYFxeO3MhuG2oc5vZW2AwsODGW4hc
         0KM+tuF0Qiuuysh8VlwQo/3eYQJUoZYLf5QY/b6TV4wKfuSJJBaE5NAIG+5ZrtHuZaNY
         wj9dLa4+q/PvFSwWvollKWUBn1JFgAkvsrroMdLmoWQrirGlH3tspFUxK0vF1m555U4H
         Uu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TssqWSCUtM99yB2weekRLelNZn0id75Zrkx5XljmNCI=;
        b=XcAs28oHv3yRtA3azasxu4iqtPCQ6ECD9xt6MuO6Vnk5UX2XWCXjUSBGPWoIDu37cq
         ZFY3H9o2GNiTIs10qXkDb3tH8ITFXS6DvF1tX6MYbK2QwDrjTOEsiPvRBMK799L2PgEf
         XxSLtqN71U3UXWJTy4g0JfYqLTtH9yVXUQoi+dL7zu09yeOsyYoT1gOc8vOL6s9r7e8+
         t+q4WOhBGFf1w5WWGntIroxmVpWlmh0di5ZcVb0MDqsAlGVNNpb6XpC54zhYtbnHnIrI
         k+ywKmsOh9Bd9zqP/9r9mPTugyM/jeFFEnC6X11R/OQJ2KB9ZiTag2VG/vacySlsOgzV
         277w==
X-Gm-Message-State: AOAM531oeLLSygE7pQ4Mhm48kvM6a6IkIx4BjkQYk+bCW3Bvi2KP07vu
        5a/p480/JvAS77V79K+70CY=
X-Google-Smtp-Source: ABdhPJwnD1YpVhikvRlyFh1pkAgpkFdAnSUzqAOuVn9vieZ74AFaTxJAMMVlsE5U9ZgsCb+pIdYt4w==
X-Received: by 2002:a17:902:9041:b0:159:e08:5f4b with SMTP id w1-20020a170902904100b001590e085f4bmr4395515plz.33.1650631578618;
        Fri, 22 Apr 2022 05:46:18 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id v16-20020a62a510000000b0050759c9a891sm2538866pfm.6.2022.04.22.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:46:16 -0700 (PDT)
Date:   Fri, 22 Apr 2022 21:46:09 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 08/15] mm/sl[auo]b: cleanup kmalloc()
Message-ID: <YmKjkU2mFrZsle4M@hyeyoo>
References: <20220308114142.1744229-1-42.hyeyoo@gmail.com>
 <20220308114142.1744229-9-42.hyeyoo@gmail.com>
 <d35ce303-c72d-2c7f-8785-4aee7237d05e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d35ce303-c72d-2c7f-8785-4aee7237d05e@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 06:46:34PM +0100, Vlastimil Babka wrote:
> On 3/8/22 12:41, Hyeonggon Yoo wrote:
> > Now that kmalloc() and kmalloc_node() do same job, make kmalloc()
> > wrapper of kmalloc_node().
> > 
> > Remove kmalloc_trace() that is now unused. This patch makes slab
> > allocator use kmalloc_node tracepoints in kmalloc().
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Actually there are more things to fix than the commit log.
> 
> > +#ifndef CONFIG_SLOB
> > +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> > +{
> > +	if (__builtin_constant_p(size)) {
> > +		unsigned int index;
> > +
> > +		if (size > KMALLOC_MAX_CACHE_SIZE)
> > +			return kmalloc_large(size, flags);
> 
> Should use kmalloc_large_node().
> 
> > +
> > +		index = kmalloc_index(size);
> > +
> > +		if (!index)
> > +			return ZERO_SIZE_PTR;
> > +
> > +		return kmem_cache_alloc_node_trace(
> > +				kmalloc_caches[kmalloc_type(flags)][index],
> > +						flags, node, size);
> > +	}
> > +	return __kmalloc_node(size, flags, node);
> > +}
> > +#else
> > +static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> > +{
> > +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> > +		return kmalloc_large(size, flags);
> 
> And here.
> 

Sorry for the mistake. did it in v2. thanks!

> > +
> > +	return __kmalloc_node(size, flags, node);
> > +}
> > +#endif

-- 
Thanks,
Hyeonggon
