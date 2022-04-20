Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AB8508756
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378227AbiDTLuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359409AbiDTLuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:50:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE61D419B7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:48:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q3so1555970plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/ioqyMtGhgT8ISEDn/usHLH5R3KJLV/B97GOzazafc=;
        b=U+gJXLEVbej5eDWOrkmQPZgsCrTk1tamX1cWQ23CG/ttIdcnYb+7A+1Fk7B75njiNH
         1o6ZrnHjQy8bAyRNl80sGvpGpIalt8lMq+THKk6pBQDoJpvzh7nGEv4Bg5XOQKCPFL4v
         phdWyntUB5dkckSslPzNqIYZtRFXhwtVCm/lw1wdtKUHy87OIv4cF+KvtugIKWQ56yoZ
         EFmoalGWQAJM5cGy1trIWgvZ7zF5o2EvfGjYxZv4owCGHGRc6ovmVi0kNidcfHCGz5TW
         lwcijgS+UnPZ3wchwNg4+8hT/NmplLT7l6NCgb6rz/kYZnfCWOHMSasevAb3e7veOigT
         tfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/ioqyMtGhgT8ISEDn/usHLH5R3KJLV/B97GOzazafc=;
        b=FZNsrnHYJ5sHITFUpcCxZMq+LxCMEvva02eHkbfv7426tykViAHxySziin7PJKY9tu
         j+w704O2uQEet1icJWXu9f8y7SpfKUbu58a8kXdmcX2MCeUgnp4F1CzGZZX3goXmp0q2
         AFXsH/1xBwkwre3euON3NliRhyVxT49lmoV/AfbVUMeIYb9C/YUlcERTITaFQHkf69Pn
         C/uwZXqiNvpkuQI5HuldCrRdfItXy/UtdXeLAZxLm1y2nWWakF3/rcrGaWDmCg7Tj/91
         JtP7Kc3SZ17+gywnMgZERJCzCCCFNtB/wvWTC/Ee5I+6c16lVSr5Ja0pu3K9rbZrUznW
         00GA==
X-Gm-Message-State: AOAM532gvwuQs8H4hKxGLNoAZs3pz5EPFkd9MRc4G0jaWOieHsEI3ZN0
        mYfMiAFlR13ATtIhTpi3h1xkJ+Gf3mY=
X-Google-Smtp-Source: ABdhPJyVYe1VeH+uzXmiBpeuXKNxGvL1Jy3NFBKwFB13ZUZc3QOmA/ZWHJ+01MyNJW9hI5nxDfASxQ==
X-Received: by 2002:a17:903:1d0:b0:158:d4c7:99c2 with SMTP id e16-20020a17090301d000b00158d4c799c2mr20287232plh.63.1650455285344;
        Wed, 20 Apr 2022 04:48:05 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p1-20020a62ab01000000b0050acad694a3sm2345756pff.206.2022.04.20.04.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:48:03 -0700 (PDT)
Date:   Wed, 20 Apr 2022 20:47:56 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove unneeded return value of slab_pad_check
Message-ID: <Yl/y7GWdKCbVPeYS@hyeyoo>
References: <20220419120352.37825-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419120352.37825-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 08:03:52PM +0800, Miaohe Lin wrote:
> The return value of slab_pad_check is never used. So we can make it return
> void now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/slub.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6dc703488d30..1f699ddfff7f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1017,7 +1017,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>  }
>  
>  /* Check the pad bytes at the end of a slab page */
> -static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
> +static void slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  {
>  	u8 *start;
>  	u8 *fault;
> @@ -1027,21 +1027,21 @@ static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  	int remainder;
>  
>  	if (!(s->flags & SLAB_POISON))
> -		return 1;
> +		return;
>  
>  	start = slab_address(slab);
>  	length = slab_size(slab);
>  	end = start + length;
>  	remainder = length % s->size;
>  	if (!remainder)
> -		return 1;
> +		return;
>  
>  	pad = end - remainder;
>  	metadata_access_enable();
>  	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
>  	metadata_access_disable();
>  	if (!fault)
> -		return 1;
> +		return;
>  	while (end > fault && end[-1] == POISON_INUSE)
>  		end--;
>  
> @@ -1050,7 +1050,6 @@ static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  	print_section(KERN_ERR, "Padding ", pad, remainder);
>  
>  	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
> -	return 0;
>  }
>  
>  static int check_object(struct kmem_cache *s, struct slab *slab,
> @@ -1642,8 +1641,7 @@ static inline int free_debug_processing(
>  	void *head, void *tail, int bulk_cnt,
>  	unsigned long addr) { return 0; }
>  
> -static inline int slab_pad_check(struct kmem_cache *s, struct slab *slab)
> -			{ return 1; }
> +static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
>  static inline int check_object(struct kmem_cache *s, struct slab *slab,
>  			void *object, u8 val) { return 1; }
>  static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,

Seems the return value was not used even at birth of SLUB.

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> -- 
> 2.23.0
> 
> 

-- 
Thanks,
Hyeonggon
