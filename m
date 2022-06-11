Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3145471AF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347546AbiFKDuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiFKDuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:50:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441439A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:50:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so1088724pjo.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FBKlFdK4PX2cFyTdjAl6VU9HARFofyR9t9zwGts6b7U=;
        b=pEkMsE98bnoHn3Kb7FwscLB2ArAgu1loIHLwd+dvPKR62K/thYl91V0nTPMor4JF2D
         Rw2pGHKz4EoUyQlCR/VObEfdxX55yHnj2/EiWuUgEapX5S8Envl3tSNiH70S5FHfIagM
         k9GJBXEKlMLW75F+HD7N/kTfjiTx6cUSe3CN8WOWAVja5SQcI8CAE+YQLhgwEc2mmxHm
         +ZpwiTNSXtJde9FXkMco8DoZ3U9KEZ5UA2bafkwxV43pvHc1SnazGbujsLqiiHRePfe7
         pdWjAqskPHSwcG3mmaljvdxSRzyAIh/Iec6mi2WhEeA+C1zjkoMH/0FFaSR0cjLdiTvr
         vj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FBKlFdK4PX2cFyTdjAl6VU9HARFofyR9t9zwGts6b7U=;
        b=SDfomiYHYsLdLgUAF4i3c/T0CMYvunkvuAnXKCdrWVp2GdgDyWuoa2hcQ0tN6j/QF7
         SqZ2amRSuQ+GHBZLBkBuJ5x7scmX7jfEIT59QLtKh3XX3TxUTbLXlVRbo42aJYz+lt6Q
         ggqmwp2UDKtZvPAXpPAYYmFRL6ZcPCvsk9nuVNTHBXgVXrLW2bAz4e41xl0RmFeq1fC+
         IjKa05MkM1/jOx9ocyLX3CRZT/PrPaG25caddOJ7oiHMCIboFV393Mv6iNlQoNrf7IE+
         jjdosUTmEi4b70AENW7H40NH8iTOl4zHctN1TN4AmQqV1vczi3w1eRe+rcxqmO5gv1Kc
         2LbQ==
X-Gm-Message-State: AOAM530QcwiLFWqWmOPYyhmvhY1OVa9SSmvECZskJLt4607fIjzQ5atf
        vvZXQHRduR9JhojeAVv7zu4=
X-Google-Smtp-Source: ABdhPJxtlzxs3+O913NXNcri66h1VaR4TYdkSkiD6iwm5eGBZc68W/DT9TWoN0emd1hIUj6j+jP3Pw==
X-Received: by 2002:a17:903:2cf:b0:151:a932:f1f0 with SMTP id s15-20020a17090302cf00b00151a932f1f0mr48762665plk.130.1654919419758;
        Fri, 10 Jun 2022 20:50:19 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id x195-20020a627ccc000000b005185407eda5sm368133pfc.44.2022.06.10.20.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 20:50:18 -0700 (PDT)
Date:   Sat, 11 Jun 2022 12:50:08 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mm, slab: fix bad alignments
Message-ID: <YqQQ8HallkC5pTBV@hyeyoo>
References: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:01:32PM +0800, Jiapeng Chong wrote:
> As reported by coccicheck:
> 
> ./mm/slab.c:3253:2-59: code aligned with following code on line 3255.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  mm/slab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 47151fb2b2d2..c359c0f2c897 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3223,7 +3223,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
>  	}
>  	/* ___cache_alloc_node can fall back to other nodes */
>  	ptr = ____cache_alloc_node(cachep, flags, nodeid);
> -  out:
> +out:
>  	local_irq_restore(save_flags);
>  	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
>  	init = slab_want_init_on_alloc(flags, cachep);
> @@ -3252,7 +3252,7 @@ __do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
>  	if (!objp)
>  		objp = ____cache_alloc_node(cache, flags, numa_mem_id());
>  
> -  out:
> +out:
>  	return objp;
>  }
>  #else
> -- 
> 2.20.1.7.g153144c

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
