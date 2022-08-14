Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E0C591F09
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiHNIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 04:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiHNIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 04:05:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E2C1D320
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 01:05:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f65so4219158pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7G1ch4jQhofsf5blw9v08dA+V4yyEX/5SvBJlQvxtxI=;
        b=FCxkVSpdGnP2vhf/FTZow29Svf69NBFLCTu+K94SX4my/XxYZiJKr+55gFJ0gSjNV5
         Tpfe6ghc/f4NXPgfYWPOO6hcx1VlItiPqsBn1cRHHruifH0yYuw9B4dUKlyay1TLfwV3
         NM2Uc8ZHZA60+rp77A0XFrMM+ktTYmY73P7CiymTo2svfvgyLyF1/YHmQCTHtlFi/Dp8
         i/gt9fez4ucODmSCg8ZTKqrsLL0wsrNqgCMIAkZhBayupSmRfkTte03Uw6WLqLQ0YSsC
         Cq/iCTf4jkamq++AfWF9776NdO9YwzbdDXavlBf8GEfT8+WMlcc96CLKiVuydF81at4l
         AUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7G1ch4jQhofsf5blw9v08dA+V4yyEX/5SvBJlQvxtxI=;
        b=CD6IRMqH7ZVKFchOqT7DhspCNSxdqC9ORuhtbwTt4i4p2NFP+BoJinWlpExoA2QaiB
         Lmwe+dRUuEr4i6T/g9S6BMQWVka4bp7ALsnEwM4KoC5glEHUhedUgk8XBfZuWoKG4983
         CuUr/FzDL+aVGz9vJO19nDpiLSewKkE4YRlSt4wogg+gbuK7ZK+wKjvaGPCb0MFX2Oeh
         sjW+/wj3/VLhMYQ7vUWOygGppRwUetocdrEQXlO910A1yIBwOsFI8NUBSTfOmMQTHfHv
         cQtFMD01/lFR5NNh+VL4W8WtdoGtvsp9AYytMOOfSDltPF2PTbrvg+jzwuWgXwYOWvHP
         0Lgg==
X-Gm-Message-State: ACgBeo2RY5n3w/LwXSoBgP+9kMbxJOGGaAWnRD3xi9u43XhXIhZ0zcqd
        5jgFpV0sScroKr66OWNWMXs=
X-Google-Smtp-Source: AA6agR57w+ju1BUaVHtUyBnWh4c1zgnWTnNyxSldfMe5xn2wB2lCKGMHsYDcZfrEFGUrbAbaIhIosA==
X-Received: by 2002:a65:46c4:0:b0:41d:e36b:1e59 with SMTP id n4-20020a6546c4000000b0041de36b1e59mr9291859pgr.494.1660464349196;
        Sun, 14 Aug 2022 01:05:49 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b0052dc3796cbfsm4689485pfb.75.2022.08.14.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 01:05:47 -0700 (PDT)
Date:   Sun, 14 Aug 2022 17:05:42 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] mm/slub: release kobject if kobject_init_and_add
 failed in sysfs_slab_add
Message-ID: <Yvis1knnMomoeuAx@hyeyoo>
References: <20220811071844.74020-1-xhao@linux.alibaba.com>
 <20220811071844.74020-2-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811071844.74020-2-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 03:18:44PM +0800, Xin Hao wrote:
> In kobject_init_and_add() function, the refcount is setted by calling
> kobject_init() function, regardless of whether the return value is zero
> or not, therefore, we must call kobject_del(&s->kobj) to prevent memory
> of s->kobj is leaked.

TL;DR: IIUC current code works just fine

After thinking more, I don't think the memory leak you said exist.
The space for s->kobj is freed in create_cache() when __kmem_cache_create() failed.

The situation here is:

create_cache() {
	s = kmem_cache_alloc(kmem_cache, GFP_KERNEL)
	err = __kmem_cache_create()
	if (err)
		goto out_free_cache;
	
out_free_cache:
	kmem_cache_free(s) // s is freed here (including its kobject)
	[...]
}

__kmem_cache_create() {
	[...]

	err = sysfs_slab_add();
	if (err) {
		__kmem_cache_release(s);
		return err;
	}
}

The primary goal of kobject_put() is to call release() function 
of kobj_type (when reference becomes zero), which is kmem_cache_release().

kmem_cache_release() {
	__kmem_cache_release(s)
	kfree_const(s->name)
	kmem_cache_free(s)
}

But when slab_sysfs_add() failed, __kmem_cache_release() and
create_cache() releases resources related to the cache.
(Also its name is freed in kmem_cache_create_usercopy().)

So IIUC current code works just fine!

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/slub.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b1281b8654bd..940a3f52e07c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5981,19 +5981,18 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  
>  	err = sysfs_create_group(&s->kobj, &slab_attr_group);
>  	if (err)
> -		goto out_del_kobj;
> +		goto out;
>  
>  	if (!unmergeable) {
>  		/* Setup first alias */
>  		sysfs_slab_alias(s, s->name);
>  	}
> +	return err;
>  out:
>  	if (!unmergeable)
>  		kfree(name);
> +	kobject_put(&s->kobj);
>  	return err;
> -out_del_kobj:
> -	kobject_del(&s->kobj);

So related resources are released in create_cache(), instead of by
calling kobject_put().

But kobject_del() is still needed because it should unlink kobject
hierarchy when kobject_add() succeeded but sysfs_create_group() failed!

> -	goto out;
>  }
>  
>  void sysfs_slab_unlink(struct kmem_cache *s)
> -- 
> 2.31.0
> 

-- 
Thanks,
Hyeonggon
