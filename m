Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657004D2C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiCIJ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiCIJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:56:27 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC2914FBF8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:55:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso4765161pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGPvmym07bxizPlaV93boc4dRxyZrMMzOC0ov2cO4E8=;
        b=PpMnduGy3C4sqc7UhVaFiGOKydHZz/v0e1jqKRqRBW58P70y3O4m039ZVfIRyTNvZX
         +TB+2MS6e4FoAswNPEK1xFzStl95L8PaE1Lx+75nPlz86R9arQAhhykMFfMos59OXNFM
         acRfxqv4NxxULe4Sq7MDEUEXjCEu/Dg+lBicV+8lqhSskautuCfEFGD4aaYWLXfxo7Qt
         0Tr2QR0/hz79N70Jetk/YqY6Tmg50c0Dasuc2os4en+nzNKQ4KDsWBzG+ZBONh4C+52s
         mfPPxgSh3oY53a8XDmGkXZUS9dSi2Tjc33UOVZxh5byp8lrXbXF4aHRWLWx9oW2NNdZC
         j3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGPvmym07bxizPlaV93boc4dRxyZrMMzOC0ov2cO4E8=;
        b=2U9VeSt8Mk5G+niLxnps+pGX2I8CiPLfCm5X0MONYV+0stiuy9SHdbW0vYBtgqIDsD
         NA/5Fb3v4YyR7P+crAp05WF2CfiQm7TuZK19GmyPTDJFKmyhHRfNWV2gcvijamIKHUGM
         9ZQhD+UM523oCMhg9siKvX/A/EAmtv9WXX/9kcxWoGbs2xZuMlWq7y+Jr94PpIaAMxGU
         rT+AzJjE4LF/lokuEvDew0+zKoBRaVhtAuSOwN9dIwDjXbKwJh5eMY3aNqeMUvgQQQ45
         AOb8hmydpn5n5UTOMiyau4wBOXDtxdb4s3DHDLQs03Ip/XyqBQqaD1MrJBXi98YxV5Al
         6JYg==
X-Gm-Message-State: AOAM533HwscV3Avau/UoYq5jtogI5If4e1bRpUiN82rX6dL3qFGZJ51O
        LsOulCZikycZ3POzLJ15UGo=
X-Google-Smtp-Source: ABdhPJyyqpvPYZqnrlWYWmMNqi8qbWejB4dUpdV8zy/7cd0orIl1ARVmxXBEx8nmmCL7oNCN/KoVTg==
X-Received: by 2002:a17:902:c745:b0:153:b0e:8586 with SMTP id q5-20020a170902c74500b001530b0e8586mr617759plq.9.1646819728752;
        Wed, 09 Mar 2022 01:55:28 -0800 (PST)
Received: from odroid ([114.29.23.97])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm2391939pfl.141.2022.03.09.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:55:28 -0800 (PST)
Date:   Wed, 9 Mar 2022 09:55:22 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove forced_order parameter in calculate_sizes
Message-ID: <20220309095522.GA1091946@odroid>
References: <20220309092036.50844-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309092036.50844-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:20:36PM +0800, Miaohe Lin wrote:
> Since commit 32a6f409b693 ("mm, slub: remove runtime allocation order
> changes"), forced_order is always -1. Remove this unneeded parameter
> to simplify the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/slub.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 180354d7e741..7f09901ae6b2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4038,7 +4038,7 @@ static void set_cpu_partial(struct kmem_cache *s)
>   * calculate_sizes() determines the order and the distribution of data within
>   * a slab object.
>   */
> -static int calculate_sizes(struct kmem_cache *s, int forced_order)
> +static int calculate_sizes(struct kmem_cache *s)
>  {
>  	slab_flags_t flags = s->flags;
>  	unsigned int size = s->object_size;
> @@ -4142,10 +4142,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  	size = ALIGN(size, s->align);
>  	s->size = size;
>  	s->reciprocal_size = reciprocal_value(size);
> -	if (forced_order >= 0)
> -		order = forced_order;
> -	else
> -		order = calculate_order(size);
> +	order = calculate_order(size);
>  
>  	if ((int)order < 0)
>  		return 0;
> @@ -4181,7 +4178,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	s->random = get_random_long();
>  #endif
>  
> -	if (!calculate_sizes(s, -1))
> +	if (!calculate_sizes(s))
>  		goto error;
>  	if (disable_higher_order_debug) {
>  		/*
> @@ -4191,7 +4188,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  		if (get_order(s->size) > get_order(s->object_size)) {
>  			s->flags &= ~DEBUG_METADATA_FLAGS;
>  			s->offset = 0;
> -			if (!calculate_sizes(s, -1))
> +			if (!calculate_sizes(s))
>  				goto error;
>  		}
>  	}

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> -- 
> 2.23.0

--
Thank you, You are awesome!
Hyeonggon :-)
