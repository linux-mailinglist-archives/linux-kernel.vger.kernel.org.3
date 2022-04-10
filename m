Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284FC4FAC83
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiDJHRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 03:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiDJHQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 03:16:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA135D186
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 00:14:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so136950pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 00:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PMY5eIllAtYW0O4Krr8r6TdMFoC/4GNbntYNUsV7TDM=;
        b=pmJnpsJ5BKsfrji2xj06XksVesUPMK0FhCQ9OlttXfXl9J/RuqkX01pkBZcbhsB5IQ
         ICh+EVF8SoUt1+0bKuDFGxo5IrH6BTyRJ0Rmguz/fW5gjmsIaFvPV/TGuEK3k8Uv1Civ
         xO1W4AnOeFWBR/JOoL+RWSY7DJMRniBOAl+qD8zEEUfegepBvP0oDAc1uXJ2WabrAOg7
         MropX/Jm3slB7HpWLL+TELBcfqYkzOJ7cTjIXwtcfxi1SWDufax+fPwfgTH/cAUJjrer
         JTC3NZ5/G0m2cZx3X2JdT7HV9mQpLnFUhIcN0mv7r5VcQIfGrH4RVHFTfiyH5Q1OPpY0
         RAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PMY5eIllAtYW0O4Krr8r6TdMFoC/4GNbntYNUsV7TDM=;
        b=LFHcl1SrPt52keSutz4JgpaN+Zy3dGvBpgIMWMEU9Kc3ZZCDeGOGqpOsSvcXs9mioi
         XHxDUfoHokQ7w4JX/J3omCaT+vjyO0OcfB68Px9+xU11vHeGwGo6cgIWVtatwKP4QKCv
         WvFiUCNdXDGotglS+CGusD6+xOJirT5yji9PMRMTz7uZ9tF8MaVmqY+uw31cjPXzGf2R
         w7Vp9r8HP1gPjNREF5m/e9ATCM6Fm55G7Yge97ITPqy3DU6Idm2vROBe9CudoUlXKtZy
         IJYdP4MpqYtF0guDD51QlyAyDIiuUJFKJol6myU5ze5nEAR+2ZVABDOTUMfW4p9V2H8s
         t9ig==
X-Gm-Message-State: AOAM533aDgrGbGa1wnE2HegFw3ZonOQAwd4LvZYPdYL0ofrvXm12EO7z
        rj9DFzZgJnoOoRrzB4jHuMY=
X-Google-Smtp-Source: ABdhPJzT2Js1kF46f/1gtMncEUNMETja4yVeubZOnQDIW0iO59NQE/+UrLiSGfVndfjTXq8eGEn4aA==
X-Received: by 2002:a17:902:7447:b0:158:2662:b8e2 with SMTP id e7-20020a170902744700b001582662b8e2mr9795761plt.54.1649574888369;
        Sun, 10 Apr 2022 00:14:48 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm10359056pfw.77.2022.04.10.00.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 00:14:47 -0700 (PDT)
Date:   Sun, 10 Apr 2022 16:14:38 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     JaeSang Yoo <js.yoo.5b@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove meaningless node check in ___slab_alloc()
Message-ID: <YlKD3oz3HqQnucyc@hyeyoo>
References: <20220409144239.2649257-1-jsyoo5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409144239.2649257-1-jsyoo5b@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 11:42:39PM +0900, JaeSang Yoo wrote:
> node_match() with node=NUMA_NO_NODE always returns 1.
> Duplicate check by goto statement is meaningless. Remove it.

Yeah, I think node = NUMA_NO_NODE here is to remove constraints
when later calling get_partial_node() or new_slab().

So no further check is required.

> 
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
> ---
>  mm/slub.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 9fe000fd19ca..a65e282b8238 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2913,7 +2913,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		 */
>  		if (!node_isset(node, slab_nodes)) {
>  			node = NUMA_NO_NODE;
> -			goto redo;
>  		} else {
>  			stat(s, ALLOC_NODE_MISMATCH);
>  			goto deactivate_slab;
> -- 
> 2.25.1

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> 
> 

-- 
Thanks,
Hyeonggon
