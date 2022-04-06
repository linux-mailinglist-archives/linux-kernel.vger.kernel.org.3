Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6134F6302
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiDFPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiDFPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:11:19 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963B19E3A9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:11:07 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so2537248pjm.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VxvVdkfuigSD3d66lzCfSLqAWuJHzoxORHDZPeqJF20=;
        b=gk7I0dlOY5WPCoG3b9ssw9G/zUZAVZVhKwSj1GQpWxKfK4U/SDf5qRArFLruvhHAG4
         4P1l76QSu5NHDh9jGLhDyx1w35dD+1nqtkDyymhGzVwPNqvb8PxF9M9xpcaosAJI11N0
         ypXPXx5KRUjx49Da7bbuyh0RROCxksK7lvw8TELhxxuV3kT+1ntAHCT5gcV3h1I7tJwM
         ChrTm6lFfbaWqxVJjoo+pazTLkvB1CA6tm/OeELa5I5BaZdB9jbeefQAbPfs/FqLY/Fp
         nhV0qRCEHZScFi3sqXQhLIbe6K0JnF8xY7aLMbcNL+Qu021bl86o6ln0jXdBUkPkvB0K
         Z7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VxvVdkfuigSD3d66lzCfSLqAWuJHzoxORHDZPeqJF20=;
        b=dv2cDVqGsrcdpUThobHjC+9UpjTFuZTOltanR+LDohJdNWD4zZzJVHVIMr1Q2qX/nn
         u2TklEnWTmgWDTp8Q8yna84A7f3s6oUb/HWv+fg0Or2cM7R/lJvpNS4tpYG5ZNDa8MV+
         y5TuoQsD028zbB4uMpe8raz4pzda77eAW3x1nafqhi9X1lTPlou7juP/DHUem21FaFOE
         rhJ8MRahDZRYo1iJ+vx1KUmS/3xl5gLrfCK0gJJ3OsOLZhN9PV3sfL5Q7+ZaJqBTURgJ
         O0I6UUJewuKfwcWS9RDzMhxvpEDTkeUKvkJ5uZ0RZyRSlMEYtZ8eIUGHkp/uqRhP7Lt5
         5UYQ==
X-Gm-Message-State: AOAM533Bbf03wpT70ZzB4l8j46o3E6Llw3pXTpHAdLbyabea+vZPpCxV
        3G8gktX3U2a0dhg6xZW/DwM=
X-Google-Smtp-Source: ABdhPJzPv/0s/hoXyGUY/9nqEVuptmFoaFod8nip9pDQC/6pHYBrhMCyczDafCZIp0OrrjUqAMCzgw==
X-Received: by 2002:a17:902:7296:b0:151:62b1:e2b0 with SMTP id d22-20020a170902729600b0015162b1e2b0mr8189883pll.165.1649246964817;
        Wed, 06 Apr 2022 05:09:24 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a060800b001c7936791d1sm5417690pjj.7.2022.04.06.05.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:09:23 -0700 (PDT)
Date:   Wed, 6 Apr 2022 21:09:14 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>, roman.gushchin@linux.dev
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <Yk2C6jLR8BSeHRkm@hyeyoo>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-2-catalin.marinas@arm.com>
 <YkzX1nM0Ca7apVBt@hyeyoo>
 <CAK8P3a1K0=jwYEHVu=X7oAWk9dzaOYAdFsidwVRKCJVReSV3+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1K0=jwYEHVu=X7oAWk9dzaOYAdFsidwVRKCJVReSV3+g@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:29:19AM +0200, Arnd Bergmann wrote:
> On Wed, Apr 6, 2022 at 1:59 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > On Tue, Apr 05, 2022 at 02:57:49PM +0100, Catalin Marinas wrote:
> > > In preparation for supporting a dynamic kmalloc() minimum alignment,
> > > allow architectures to define ARCH_KMALLOC_MINALIGN independently of
> > > ARCH_DMA_MINALIGN. In addition, always define ARCH_DMA_MINALIGN even if
> > > an architecture does not override it.
> > >
> >
> > [ +Cc slab maintainer/reviewers ]
> >
> > I get why you want to set minimum alignment of kmalloc() dynamically.
> > That's because cache line size can be different and we cannot statically
> > know that, right?
> >
> > But I don't get why you are trying to decouple ARCH_KMALLOC_MINALIGN
> > from ARCH_DMA_MINALIGN. kmalloc'ed buffer is always supposed to be DMA-safe.
> >
> > I'm afraid this series may break some archs/drivers.
> >
> > in Documentation/dma-api-howto.rst:
> > > 2) ARCH_DMA_MINALIGN
> > >
> > >   Architectures must ensure that kmalloc'ed buffer is
> > >   DMA-safe. Drivers and subsystems depend on it. If an architecture
> > >   isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
> > >   the CPU cache is identical to data in main memory),
> > >   ARCH_DMA_MINALIGN must be set so that the memory allocator
> > >   makes sure that kmalloc'ed buffer doesn't share a cache line with
> > >   the others. See arch/arm/include/asm/cache.h as an example.
> > >
> > >   Note that ARCH_DMA_MINALIGN is about DMA memory alignment
> > >   constraints. You don't need to worry about the architecture data
> > >   alignment constraints (e.g. the alignment constraints about 64-bit
> > >   objects).
> >
> > If I'm missing something, please let me know :)
> 
> It helps in two ways:
> 
> - you can start with a relatively large hardcoded ARCH_DMA_MINALIGN
>   of 128 or 256 bytes, depending on what the largest possible line size
>   is for any machine you want to support, and then drop that down to
>   32 or 64 bytes based on runtime detection. This should always be safe,
>   and it means a very sizable chunk of wasted memory can be recovered.
>

I agree this part.

> - On systems that are fully cache coherent, there is no need to align
>   kmallloc() allocations for DMA safety at all, on these, we can drop the
>   size even below the cache line. This does not apply on most of the
>   cheaper embedded or mobile SoCs, but it helps a lot on the machines
>   you'd find in a data center.

Now I get the point. Thank you for explanation!
Going to review this series soon.

> 
>         Arnd

-- 
Thanks,
Hyeonggon
