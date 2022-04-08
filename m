Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA14F9162
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiDHJJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiDHJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:09:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B13102430
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:07:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso11352929pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hp7oYdsS7Bs34J2va/oMNBikxIZxJ90vFNDe63jTHPc=;
        b=TgIcmPCUaDGf5BULFOSeUI5lFTbyU4OYkADhgfOVmNlBAMQ8R+47hSDSezENWBsISy
         98s+Uomdrhqqgkai8K8sh/RTwR+cSuQMYT69WSrf8N7uEzsF9gYqFu5ryH1GCBgZzLIj
         1VJHhEOLlZUl/nWwDnt9CSyFpm275Q+MOtezxZhJWvCkpOnaBh2y+HbFWI5iGzDOjQFx
         NidhzW+cL5E9bBDt61BTI2NcpYw74P1/QLO6qZt4fQGNn+oBfn3dmiEfl7mVKNIfSo7s
         qVXPYfMHxZ8G8IinzssHL9KQwxqhvoC5LabWF7OxHzJygVGRTR1F4c9d1Y34I6JT9eyE
         u+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hp7oYdsS7Bs34J2va/oMNBikxIZxJ90vFNDe63jTHPc=;
        b=1ntkJzmlPB7gdCD93YIrYSvdXmmTZYiOJDOZETEJ82zDH3+KUUajtUweXr4/rUi95E
         ZGv9RRx1jgsUOT5vH3p2ANtaFklh8AiO/O58Z9RGCoUcHeToaG+ir0SwRe8IJrRavADR
         /oq1AekzTtiQEha4byQfRbDnLjcheY/RL5DVkzFMBTCvBrAf4e7YsArz5rr+L1EO8W0U
         XVyJQZNW04siaROgxdhqcBsreE6p7JAfhiCaolLdoFJPeZLsqmEiFGSWvHQEqZ18Yo6q
         GJ97Nlvqj2X1Dksd6VABxSX/ZuUPvT/fzFDaO0uI0szoNNFX7RDWEF+qvzP9y8+P9k/q
         hZDA==
X-Gm-Message-State: AOAM530qB0yLaIMnY4/QhKisSvW5Rr9RVXzqUzLNNZSVUR+mAL6rBOHs
        Ua7LKwVUSuLAtBSEIF2XGWw=
X-Google-Smtp-Source: ABdhPJy91dsjCOSU1aXFqQra3/IuGWyEESqAOb9Od7Z2fXTT7pJzE9WcTnmSxGLrPprsHZJgcnh2mQ==
X-Received: by 2002:a17:90b:4b43:b0:1c9:85b0:2db8 with SMTP id mi3-20020a17090b4b4300b001c985b02db8mr20542501pjb.23.1649408826983;
        Fri, 08 Apr 2022 02:07:06 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm24075496pfw.144.2022.04.08.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 02:07:05 -0700 (PDT)
Date:   Fri, 8 Apr 2022 18:06:58 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <Yk/7MrhcdR5PaKHd@hyeyoo>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-2-catalin.marinas@arm.com>
 <Yk/ZRTggY3wZ00o4@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk/ZRTggY3wZ00o4@hyeyoo>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:42:13PM +0900, Hyeonggon Yoo wrote:
> On Tue, Apr 05, 2022 at 02:57:49PM +0100, Catalin Marinas wrote:
> > In preparation for supporting a dynamic kmalloc() minimum alignment,
> > allow architectures to define ARCH_KMALLOC_MINALIGN independently of
> > ARCH_DMA_MINALIGN. In addition, always define ARCH_DMA_MINALIGN even if
> > an architecture does not override it.
> > 
> > After this patch, ARCH_DMA_MINALIGN is expected to be used in static
> > alignment annotations and defined by an architecture to be the maximum
> > alignment for all supported configurations/SoCs in a single Image.
> > ARCH_KMALLOC_MINALIGN, if different, is the minimum alignment guaranteed
> > by kmalloc().
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  include/linux/slab.h | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 373b3ef99f4e..d58211bdeceb 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -187,17 +187,30 @@ bool kmem_valid_obj(void *object);
> >  void kmem_dump_obj(void *object);
> >  #endif
> >  
> > +/*
> > + * slob does not support independent control of ARCH_KMALLOC_MINALIGN and
> > + * ARCH_DMA_MINALIGN.
> > + */
> > +#ifdef CONFIG_SLOB
> > +#undef ARCH_KMALLOC_MINALIGN
> > +#endif
> 

Sorry for the noise. Yeah, the code above is making
ARCH_KMALLOC_MINALIGN = ARCH_DMA_MINALIGN.

I was confused :(

> I think you should replace ARCH_KMALLOC_MINALIGN with ARCH_DMA_MINALIGN
> in mm/slob.c too? Or detect minimum kmalloc alignment in runtime like SLAB/SLUB?
> 
> current code seem to break with SLOB on machines that has 128 byte cache lines
> because ARCH_KMALLOC_MINALIGN is 64?
> 

> > +
> >  /*
> >   * Some archs want to perform DMA into kmalloc caches and need a guaranteed
> >   * alignment larger than the alignment of a 64-bit integer.
> > - * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.
> > + * Setting ARCH_DMA_MINALIGN in arch headers allows that.
> >   */
> > -#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
> > +#ifndef ARCH_DMA_MINALIGN
> > +#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
> > +#elif ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
> >  #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
> > -#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
> > -#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
> > -#else
> > +#endif
> > +
> > +#ifndef ARCH_KMALLOC_MINALIGN
> >  #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
> > +#else
> > +#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
> > +#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
> >  #endif
> >  
> >  /*
> > 
> 
> -- 
> Thanks,
> Hyeonggon

-- 
Thanks,
Hyeonggon
