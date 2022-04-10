Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C04FAC96
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiDJHoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiDJHo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 03:44:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A762F0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 00:42:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y6so11436106plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cSXw+XVYOoX2G7IopQ/sIWz/YQYFoZXQ3ZmEBf6FWSM=;
        b=HpxHKRU2aoHfoFqFL83nSo0hUqwoFOEviIl5QHGVndY2acZcZC1lvJiuQkznBuSY6y
         R2c1aZV7JW3jZB4kmcRDqXiJGkYhHb2wTFvltgURNixUpkLQ6wF701ibEmM118PD+w6i
         EEcMjqFqkGLTRDqEL3X7eATLmFbiy9rZE0UK2IslN50mYTzAcz2eyjcVn6L6GQqub96N
         VIg4wL+2KLzlMFJNLhTl6tVsoICvejpW8/QeA88BpqNLPbq5x6epmOITXgwUS4r2DlNx
         3c2byneqiiiDt+MYO7p6twH9+3Ghz2TN4EvwTDWh3JQX4QFhfYtqVvOWJGLgcbLcJ+Qi
         wzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cSXw+XVYOoX2G7IopQ/sIWz/YQYFoZXQ3ZmEBf6FWSM=;
        b=BtzhrTB1QBKsP0G4BX0PZlBy8EXtH82Kp+ngOTlBnof4l3hxxmuS6sGjl5te2/WV9W
         0q953QA2CGCjEZLN/9S2AC8vzLqfA4vQxbQe3gRvx+txyFyoSlE0z56UyKRX9hzfH74A
         03FGmGQfYlEa5V0LRw5Oz6k8wLHnD9aWDxssZAWYRj/Izk793yBL69uAec8GBrJLhX0h
         jCjskfyqxfZAu8vzCKv+RyFO5JD+44DtGbPzw/pClH1e2hh8Sur/3jn+uHE5rGjEFd5C
         McvmC05UAJlZsonb57KvNVMPSU3+nHyceJEx5vK4wLlzvvlnC8xoHUoc4MSBmCtSSZvU
         n6GQ==
X-Gm-Message-State: AOAM533Taevp9KqWNdb8Bw4JyuIVn9YBBPQYsCsRhFHQzhWoB/xI4CxO
        ElZmInRF15FzWsWVfFEIeroRW3B1tOE=
X-Google-Smtp-Source: ABdhPJz1R7lcKspCAXdSnT/AtJp8Obuzx7gzxJj0iY67kpevyLxwvwEzljeNPVcvLWpn2/znIyjXlg==
X-Received: by 2002:a17:902:a710:b0:156:5650:f94a with SMTP id w16-20020a170902a71000b001565650f94amr26471202plq.86.1649576538467;
        Sun, 10 Apr 2022 00:42:18 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a8b8a00b001ca7bafba51sm15750166pjn.0.2022.04.10.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 00:42:17 -0700 (PDT)
Date:   Sun, 10 Apr 2022 16:42:08 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jiyoup Kim <lakroforce@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove duplicate flag in allocate_slab()
Message-ID: <YlKKUGWta0XayfMb@hyeyoo>
References: <20220409150538.1264-1-lakroforce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409150538.1264-1-lakroforce@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 12:05:37AM +0900, Jiyoup Kim wrote:
> In allocate_slab(), __GFP_NOFAIL flag is removed twice when trying
> higher-order allocation. Remove it.
> 
> Signed-off-by: Jiyoup Kim <lakroforce@gmail.com>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 74d92aa4a3a2..a0e605ab3036 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1939,7 +1939,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  	 */
>  	alloc_gfp = (flags | __GFP_NOWARN | __GFP_NORETRY) & ~__GFP_NOFAIL;
>  	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
> -		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~(__GFP_RECLAIM|__GFP_NOFAIL);
> +		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
>  
>  	slab = alloc_slab_page(alloc_gfp, node, oo);
>  	if (unlikely(!slab)) {

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> -- 
> 2.25.1
> 
> 

-- 
Thanks,
Hyeonggon
