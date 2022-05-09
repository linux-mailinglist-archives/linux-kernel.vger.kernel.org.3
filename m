Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A522C51FB2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiEILZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiEILZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:25:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427F275D2;
        Mon,  9 May 2022 04:21:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so2011745pjq.2;
        Mon, 09 May 2022 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MPgbgqFyUzi/pFIIl7e5TfJ4g1kI/3PaA6Fy/1JOhfo=;
        b=LXyc68wE9Tqryc7MXDlYdhdIOKehEozgCEtEPNYYV8YYudUQtKzmgy5hfOIVQTJ9sC
         KrVakukKljSFGzfObUSuFnO9vFYU3rhBEVlBBzbfH2RSA7bV5GZYYuuoF00hIQjMrdHk
         8v6Vw2rB4VyXQHMdcfBibLStLlTFqHQOy2xLDWTHyEQZ7iiyoLHWKcA7PKqed5DALb0h
         QQcms6zuYXy9k9CQ9hCvLfjRc0r1hHy6NPBgnzGNfzV01x2j/kIDBkGKhX2TMEKsddOv
         kjkRI3D0K1cInlxHRfZVFCs0CA2nifvB5lacSVDUgBCSF6YndZh3xspcW7JNa8hcx3Uj
         YLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPgbgqFyUzi/pFIIl7e5TfJ4g1kI/3PaA6Fy/1JOhfo=;
        b=ZVIZF0M+kzp+JuuzK5TwL7/SmysClj5kugysySzM/GLI7dTu5kaa5PhyvEGJA37aR0
         MGPjO1PtmHJ89PG2yKZ73xJKLwN8cbbv/rLWuSSCaLpPPdZSNm+oJJRNvav7hHNuUWk4
         +LNupWOSnTKZx15C6orxzJH8rDcT4Hi/7M5melQDAE27nsOTsJxXU2dZevbNmnetycXk
         SKS0/aBPJBg+xCDPK+XcCALLb9gjqjkpObAw2vU8aXFAGAaJlAk/wEBZ8DI3tYRXC/9W
         PZwY3WOEOIsB98TR4+KtKzcHFmcpseNm4Qr/BF6WO534lXCwelaykfFGNttoDKB/nX8v
         1tLw==
X-Gm-Message-State: AOAM530h8K8DXdUojUL0YPV5JTbpr0sW/+C2nZXjJoJulOYAflKfXaeO
        6PwsguoSjnaLbJhVhfypN/s=
X-Google-Smtp-Source: ABdhPJxUIbeOoe8L+kkYmJD77E+tXkGv6tUMh90aoncV+NJEaGYXxZ51nNQmZJBWVoSvZWIkMAHBPw==
X-Received: by 2002:a17:90a:884:b0:1d9:531c:9cd6 with SMTP id v4-20020a17090a088400b001d9531c9cd6mr17211836pjc.211.1652095265364;
        Mon, 09 May 2022 04:21:05 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00000d00b0050dc7628173sm8461311pfk.77.2022.05.09.04.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:21:04 -0700 (PDT)
Date:   Mon, 9 May 2022 20:20:57 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Paran Lee <p4ranlee@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Austin Kim <austindh.kim@gmail.com>
Subject: Re: [PATCH] slub: kunit catch kmem_cache_alloc failed
Message-ID: <Ynj5GZuXG6CgCUJp@hyeyoo>
References: <20220506045319.GA28237@DESKTOP-NK4TH6S.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506045319.GA28237@DESKTOP-NK4TH6S.localdomain>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 01:53:19PM +0900, Paran Lee wrote:
> Catch kmem_cache_alloc failed on slub kunit test.
> 
> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> ---
>  lib/slub_kunit.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 8662dc6cb509..7b80241dd498 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -32,6 +32,11 @@ static void test_next_pointer(struct kunit *test)
>  	struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
>  				SLAB_POISON, NULL);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +	if (!p) {
> +		kunit_err(test, "Allocation failed: %s\n", __func__);
> +		kmem_cache_destroy(s);
> +		return;
> +	}
>  	unsigned long tmp;
>  	unsigned long *ptr_addr;
>  
> @@ -77,6 +82,11 @@ static void test_first_word(struct kunit *test)
>  	struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
>  				SLAB_POISON, NULL);

Recently SLAB_NO_USER_FLAGS is added for test caches.
Looks like it's not based on Vlastimil's slab tree:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git

>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +	if (!p) {
> +		kunit_err(test, "Allocation failed: %s\n", __func__);
> +		kmem_cache_destroy(s);
> +		return;
> +	}
>  
>  	kmem_cache_free(s, p);
>  	*p = 0x78;
> @@ -92,6 +102,11 @@ static void test_clobber_50th_byte(struct kunit *test)
>  	struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
>  				SLAB_POISON, NULL);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +	if (!p) {
> +		kunit_err(test, "Allocation failed: %s\n", __func__);
> +		kmem_cache_destroy(s);
> +		return;
> +	}
>  
>  	kmem_cache_free(s, p);
>  	p[50] = 0x9a;
> @@ -108,6 +123,11 @@ static void test_clobber_redzone_free(struct kunit *test)
>  	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
>  				SLAB_RED_ZONE, NULL);
>  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
> +	if (!p) {
> +		kunit_err(test, "Allocation failed: %s\n", __func__);
> +		kmem_cache_destroy(s);
> +		return;
> +	}
>  
>  	kasan_disable_current();
>  	kmem_cache_free(s, p);
> -- 
> 2.25.1
> 

To be more paranoid kmem_cache_create() can also fail - but I'm not sure
these checks are useful for tests.

-- 
Thanks,
Hyeonggon
