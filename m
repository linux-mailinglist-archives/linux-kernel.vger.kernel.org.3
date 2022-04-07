Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F304F7B6A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbiDGJU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiDGJUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:20:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809661BD9A2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:18:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z16so4923483pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5gURCAriqkaAtBbfKf62b2z4rl8Y51p+M4glQXpt9x8=;
        b=iGLO9qe/PLwc1g6gOO9kH9kQ/Zco0tV2QRxPA5NnhsCk8qICB1T+hQV3mEZfZ5Oh6C
         iyj+HWjI9UtZ7/mcTu4BNNcZxvlrpzPqYw0rdtj8y8W2AwTj/kQlncQWMVnfaXoMF/3o
         FAj3X8m0QYcAYrA/Jx6w4I1Pe/mRUW7vPpYmrRoSuEDxahR3qjQCAUs/JaCyMB2UtnTJ
         +tNjfj83dJc+388hr0Xgvs7T6qgxO6dk6ty9hqyTO2N6rvbaPw5yDZl3sP8b0qWg3hpp
         1QVn8ZR6pWKB+0Rh7Xeu+yOvK/o/ljXRRFsh1kDbVHArhHeRLecj/BofTQYCtNIHEHwT
         Z6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5gURCAriqkaAtBbfKf62b2z4rl8Y51p+M4glQXpt9x8=;
        b=NzPsAf7ann2fJIMS5SjBecZCiPk7sOYBg+oYSxCt62C6Q6/lDFgBqRD+rVjJ1nz5CD
         OSVTZZA4ZKd70GMNc1dPjb0DruWwIIHwHPaRte4QjMgeGsSmjcfyanYbeIEgn/cg5P/Q
         EmR2aolghfPKmHtIfSUOMZ288PjiqeTBY2Iy1KKkZKDsuuMefjC47b7rzTTF44xYVXkK
         U0rZ85YVNvfP9x5ibPWWDv/TSTE7z6ZGxvV4Wq5SQ7BZ3y8GZ0/zRMvOiomyoHcIE7rw
         R6pvI12yYqhH7v8aUNPAtPZNPd2XPIuYHLpa7iMBfa8wBaCpPH82sW+PITcehknmnDOy
         COSQ==
X-Gm-Message-State: AOAM533hXX4ApB+D3AiKF1iQeEiTbm9ww32OtKauY0sU/q8CmGcHfvS2
        ev9L30VprxI7BgRhmrvDhMw=
X-Google-Smtp-Source: ABdhPJxlX1yOTDW7FCqeMUgd+SHwts+POqKUD0XmCnmbloTbgSQo0fWVa+V2PUrlzMGI9pF6xNdFQw==
X-Received: by 2002:aa7:8049:0:b0:4fd:bfde:45eb with SMTP id y9-20020aa78049000000b004fdbfde45ebmr13388148pfm.76.1649323104933;
        Thu, 07 Apr 2022 02:18:24 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000b4a00b004fd9a6a2a39sm22754230pfo.184.2022.04.07.02.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:18:23 -0700 (PDT)
Date:   Thu, 7 Apr 2022 18:18:16 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] mm/slab: Allow dynamic kmalloc() minimum alignment
Message-ID: <Yk6sWNBSwNRbLdfZ@hyeyoo>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-9-catalin.marinas@arm.com>
 <Yk5endPQFHc/pB1W@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <Yk6lz0UYyKIv5ibI@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk6lz0UYyKIv5ibI@arm.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 09:50:23AM +0100, Catalin Marinas wrote:
> On Thu, Apr 07, 2022 at 03:46:37AM +0000, Hyeonggon Yoo wrote:
> > On Tue, Apr 05, 2022 at 02:57:56PM +0100, Catalin Marinas wrote:
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -838,9 +838,18 @@ void __init setup_kmalloc_cache_index_table(void)
> > >  	}
> > >  }
> > >  
> > > -static void __init
> > > +unsigned int __weak arch_kmalloc_minalign(void)
> > > +{
> > > +	return ARCH_KMALLOC_MINALIGN;
> > > +}
> > > +
> > 
> > As ARCH_KMALLOC_ALIGN and arch_kmalloc_minalign() may not be same after
> > patch 10, I think s/ARCH_KMALLOC_ALIGN/arch_kmalloc_minalign/g
> > for every user of it would be more correct?
> 
> Not if the code currently using ARCH_KMALLOC_MINALIGN needs a constant.
> Yes, there probably are a few places where the code can cope with a
> dynamic arch_kmalloc_minalign() but there are two other cases where a
> constant is needed:
> 
> 1. As a BUILD_BUG check because the code is storing some flags in the
>    bottom bits of a pointer. A smaller ARCH_KMALLOC_MINALIGN works just
>    fine here.
> 
> 2. As a static alignment for DMA requirements. That's where the newly
>    exposed ARCH_DMA_MINALIGN should be used.
> 
> Note that this series doesn't make the situation any worse than before
> since ARCH_DMA_MINALIGN stays at 128 bytes for arm64. Current users can
> evolve to use a dynamic alignment in future patches. My main aim with
> this series is to be able to create kmalloc-64 caches on arm64.

AFAIK there are bunch of drivers that directly calls kmalloc().
It becomes tricky when e.g.) a driver allocates just 32 bytes,
but architecture requires it to be 128-byte aligned.

That's why everything allocated from kmalloc() need to be aligned in
ARCH_DMA_MINALIGN. And It's too hard to update all of drivers
that depends on this fact.

So I'm yet skeptical on decoupling ARCH_DMA/KMALLOC_MINALIGN.
Instead of decoupling it, I'm more into dynamically decreasing it.

Please kindly let me know If I'm missing something ;-)

> > > @@ -851,10 +860,17 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> > >  		flags |= SLAB_ACCOUNT;
> > >  	}
> > >  
> > > -	kmalloc_caches[type][idx] = create_kmalloc_cache(
> > > -					kmalloc_info[idx].name[type],
> > > -					kmalloc_info[idx].size, flags, 0,
> > > -					kmalloc_info[idx].size);
> > > +	if (minalign > ARCH_KMALLOC_MINALIGN) {
> > > +		aligned_size = ALIGN(aligned_size, minalign);
> > > +		aligned_idx = __kmalloc_index(aligned_size, false);
> > > +	}
> > > +
> > > +	if (!kmalloc_caches[type][aligned_idx])
> > > +		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
> > > +					kmalloc_info[aligned_idx].name[type],
> > > +					aligned_size, flags, 0, aligned_size);
> > > +	if (idx != aligned_idx)
> > > +		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
> > 
> > I would prefer detecting minimum kmalloc size in create_kmalloc_caches()
> > in runtime instead of changing behavior of new_kmalloc_cache().
> 
> That was my initial attempt but we have a couple of
> create_kmalloc_cache() (not *_caches) calls directly, one of them in
> mm/slab.c kmem_cache_init(). So I wanted all the minalign logic in a
> single place, hence I replaced the explicit create_kmalloc_cache() call
> with new_kmalloc_cache(). See this patch and patch 9 for some clean-up.
> 
> -- 
> Catalin

-- 
Thanks,
Hyeonggon
