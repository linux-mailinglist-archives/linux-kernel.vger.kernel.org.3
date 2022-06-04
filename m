Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2453D647
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiFDJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiFDJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:43:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8D19F9D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 02:42:57 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f4so7858692iov.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=unzjzvfi9PrBQZfrjQ2iDmRQxsZtvSAfZhjP5fuk9Mc=;
        b=PPQ2PINKv89eSRuXsNMTWrGuBW1KBti3kaS9DjJDXmELyPqkm6tD+GfOKje7/L9uO4
         vlARQyB44pTmG8AA2dKoceJLx3GM62KEjS/tKBc0lw8lOtSxIAUoZOLHQv9FpGs3Uz01
         GQ6K5LJyhxTHEJYlXVGCQx9q+wmp2p2AIYYVL2JX90ln57WV/1m43dTXMZ0If9z8NEyp
         vq41oPTzt8Y2q8PXwHtM2yaz+gQ7eKDXoR2pkyk2IwQrLO5KgnO0yH7rb1VZE84y3Lnn
         6dtW5YvDt/BE1s+HRVyRE7cADebazJAJt1t8VmaonH0cIDXN0PKIkOAMOnt+gth0tMCz
         Nwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=unzjzvfi9PrBQZfrjQ2iDmRQxsZtvSAfZhjP5fuk9Mc=;
        b=J6Cf/EhKvvTsL/y/xUtIT9OeFNEJO0VEQ8pQhNuydKOrhc4EaC3C0CYBeL/sUgWxPh
         +WaGLLZj7XKua9yO0h0ynEHwoJ+xRs5Ghy3AcxPW79FIqHpoLRZJTWeJaTjyvtaOL4Vc
         uxvgxwIYTHuE1moOFZOOiOsfX9FMZN8tScioNFgV5Q8HKNiB0KwzroSwyzceReDu1PBh
         MiAxWcU/FaBtp6IxJwUYHgONCWQQJ23I/2naase36NqFx2DbWDErbPJn0/MUmC7ymysk
         TysotPUEyLpZR5EQ8HqFmCAHOmKDapzh560EtlEK7Pa60hQ1kP39jZcOILRAQZ5fHbD2
         cmsw==
X-Gm-Message-State: AOAM531r09u4yZAcDetch0bSa2BUl5tEbP9+aTlKTHHsVCgS8OiQag3W
        mLUZYVLLASOCEXkFtlD+sXA=
X-Google-Smtp-Source: ABdhPJzUE4jXudX1ZhVhdU5GnFLPG9UR6NhWdSPqYNJ8qtwUtJKYyfN8HzWXRflxi//NrvJTryIALA==
X-Received: by 2002:a05:6602:1585:b0:665:5f6a:9d7a with SMTP id e5-20020a056602158500b006655f6a9d7amr6639010iow.154.1654335776607;
        Sat, 04 Jun 2022 02:42:56 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id r8-20020a02aa08000000b003314d1acddesm3498760jam.152.2022.06.04.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 02:42:55 -0700 (PDT)
Date:   Sat, 4 Jun 2022 09:42:54 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH v2] mm/slub: Simplify __kmem_cache_alias()
Message-ID: <YpspHqZM27DeEhNR@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <20220603143555.41914-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603143555.41914-1-sxwjean@me.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 10:35:55PM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> There is no need to do anything if sysfs_slab_alias() return nonzero
> value after getting a mergeable cache.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2: Collect Reviewed-by tag from Muchun.
> ---
>  mm/slub.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d8d5abf49f5f..9444277d669a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4861,6 +4861,9 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  
>  	s = find_mergeable(size, align, flags, name, ctor);
>  	if (s) {
> +		if (sysfs_slab_alias(s, name))
> +			return NULL;
> +
>  		s->refcount++;
>

I think we should not expose sysfs attributes before initializing
what can be read via sysfs attribute (object_size).

>  		/*
> @@ -4869,11 +4872,6 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  		 */
>  		s->object_size = max(s->object_size, size);

this calculation should be done before sysfs_slab_alias().

Thanks,
Hyeonggon

>  		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
> -
> -		if (sysfs_slab_alias(s, name)) {
> -			s->refcount--;
> -			s = NULL;
> -		}
>  	}
>  
>  	return s;
> -- 
> 2.30.2
> 
