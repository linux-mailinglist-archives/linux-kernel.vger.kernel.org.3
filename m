Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5ED4CE28F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 05:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiCEEEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 23:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCEEEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 23:04:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4BB84C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:03:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so6776509pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 20:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DNjNmMTRFvb6vnONGhIWC+OgnqkQwzJ4U2IjjfTyD90=;
        b=MWnFBNqUbnqmMxySEyPpYYnG3q+KcX1+dVgjHzaU5bfUpCng3VkKxrl/jXTMT/AYFG
         wB840KdN4gx8Wg5CgJIfQSSPdzIsRvMkY9wJ2km+kPpRt46fGlY7c1RcbEhiwygxuMoH
         LrdU+9+7KDzRiVUGTh6QyQyWgJRZ3CDHrpt+J3U6l2TtFzy+bW+Kl1oA28hRalvKAzsR
         HHzD9ULUTZJtzX7TxAZt6Dgi/o45EcOtqt2Y7GrPrCp4u7dPp7wdgQRm7J/J8e9IniEW
         KPaqla2Vh3rAIH4dykXe6cN3FGRCUdXEl4fhTUVTNvlxTNma14OM/Pkhpjf38jLAtjtw
         RLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DNjNmMTRFvb6vnONGhIWC+OgnqkQwzJ4U2IjjfTyD90=;
        b=Oe+Kc9g0kBj8BQiYjBGwdn/N+yOZ/YE8b+aDDFu9qFXoBNsFry6jWd3QbdnZtuUwp8
         mu6OfOKm3HR93jfNjd5Ghu5JTslYa2Yqsm7EgckexdYO/DR3Bxf0ZbNQei+dHXg9M1RY
         vEbdViEfCYwrQ7uXXx9Lw6XwzU5LnH+SGg2CzozE/OMRjgeFihgwWSOC07HygjolNkVA
         M5bC7LuFV2C60KpKS2LfQCR51GVkL3yP30oy1SBDoZlC8vJbp9ePsiON6SEll8M/hqpI
         BhTqowWWPnutl62ApteGlu5T3S7w8y5V1caJo7ghG3rfZDe81t4BaZX1LxElBwrugy8d
         i+Nw==
X-Gm-Message-State: AOAM531HW/BMZh6jpB5+XU7/1SJm360bgO5HB24iVsHCG4yorby4gR0a
        5mpXrFKUHfY82sNwZIQUVXk=
X-Google-Smtp-Source: ABdhPJyWbF8QQR9hXYPHj02x5hZat2KesBN01K5DTAtPPg71Q20nhFYTjyR1Oa2SSlfbMTLaLlXitA==
X-Received: by 2002:a17:90a:7e8b:b0:1be:ef6c:9797 with SMTP id j11-20020a17090a7e8b00b001beef6c9797mr14102508pjl.183.1646452996098;
        Fri, 04 Mar 2022 20:03:16 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id n34-20020a056a000d6200b004e1ba1016absm7384637pfv.31.2022.03.04.20.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 20:03:15 -0800 (PST)
Date:   Sat, 5 Mar 2022 04:03:11 +0000
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
Subject: Re: [PATCH v2 3/5] mm/sl[auo]b: move definition of __ksize() to
 mm/slab.h
Message-ID: <YiLg/0be3jp9mg2V@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <20220304063427.372145-4-42.hyeyoo@gmail.com>
 <a7a7fb5a-6c3b-d85f-e4aa-6027a941760d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a7fb5a-6c3b-d85f-e4aa-6027a941760d@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 07:29:21PM +0100, Vlastimil Babka wrote:
> On 3/4/22 07:34, Hyeonggon Yoo wrote:
> > __ksize() is only called by KASAN. Remove export symbol and move
> > definition to mm/slab.h as we don't want to grow its callers.
> > 
> > [ willy@infradead.org: Move definition to mm/slab.h and reduce comments ]
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!

> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -685,6 +685,8 @@ static inline void free_large_kmalloc(struct folio *folio, void *object)
> >  }
> >  #endif /* CONFIG_SLOB */
> >  
> > +size_t __ksize(const void *objp);
> > +
> >  static inline size_t slab_ksize(const struct kmem_cache *s)
> >  {
> >  #ifndef CONFIG_SLUB
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 1d2f92e871d2..b126fc7247b9 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1247,13 +1247,7 @@ EXPORT_SYMBOL(kfree_sensitive);
> >  
> >  #ifndef CONFIG_SLOB
> >  /**
> 
> Maybe just /* so it's not even parsed as a kernel-doc anymore?
>

Oh yes, that would be better.

> > - * __ksize -- Uninstrumented ksize.
> > - * @objp: pointer to the object
> > - *
> > - * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> > - * safety checks as ksize() with KASAN instrumentation enabled.
> > - *
> > - * Return: size of the actual memory used by @objp in bytes
> > + * __ksize -- Uninstrumented ksize. Only called by KASAN.
> >   */
> >  size_t __ksize(const void *object)
> >  {
> > @@ -1269,7 +1263,6 @@ size_t __ksize(const void *object)
> >  
> >  	return slab_ksize(folio_slab(folio)->slab_cache);
> >  }
> > -EXPORT_SYMBOL(__ksize);
> >  #endif
> >  

-- 
Thank you, You are awesome!
Hyeonggon :-)
