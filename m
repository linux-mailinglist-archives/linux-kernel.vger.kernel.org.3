Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9527C4F7BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbiDGJhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiDGJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CAF7939D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1C961AA9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B8CC385A4;
        Thu,  7 Apr 2022 09:35:08 +0000 (UTC)
Date:   Thu, 7 Apr 2022 10:35:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] mm/slab: Allow dynamic kmalloc() minimum alignment
Message-ID: <Yk6wSNz38Bv1lrmB@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-9-catalin.marinas@arm.com>
 <Yk5endPQFHc/pB1W@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <Yk6lz0UYyKIv5ibI@arm.com>
 <Yk6sWNBSwNRbLdfZ@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk6sWNBSwNRbLdfZ@hyeyoo>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 06:18:16PM +0900, Hyeonggon Yoo wrote:
> On Thu, Apr 07, 2022 at 09:50:23AM +0100, Catalin Marinas wrote:
> > On Thu, Apr 07, 2022 at 03:46:37AM +0000, Hyeonggon Yoo wrote:
> > > On Tue, Apr 05, 2022 at 02:57:56PM +0100, Catalin Marinas wrote:
> > > > --- a/mm/slab_common.c
> > > > +++ b/mm/slab_common.c
> > > > @@ -838,9 +838,18 @@ void __init setup_kmalloc_cache_index_table(void)
> > > >  	}
> > > >  }
> > > >  
> > > > -static void __init
> > > > +unsigned int __weak arch_kmalloc_minalign(void)
> > > > +{
> > > > +	return ARCH_KMALLOC_MINALIGN;
> > > > +}
> > > > +
> > > 
> > > As ARCH_KMALLOC_ALIGN and arch_kmalloc_minalign() may not be same after
> > > patch 10, I think s/ARCH_KMALLOC_ALIGN/arch_kmalloc_minalign/g
> > > for every user of it would be more correct?
> > 
> > Not if the code currently using ARCH_KMALLOC_MINALIGN needs a constant.
> > Yes, there probably are a few places where the code can cope with a
> > dynamic arch_kmalloc_minalign() but there are two other cases where a
> > constant is needed:
> > 
> > 1. As a BUILD_BUG check because the code is storing some flags in the
> >    bottom bits of a pointer. A smaller ARCH_KMALLOC_MINALIGN works just
> >    fine here.
> > 
> > 2. As a static alignment for DMA requirements. That's where the newly
> >    exposed ARCH_DMA_MINALIGN should be used.
> > 
> > Note that this series doesn't make the situation any worse than before
> > since ARCH_DMA_MINALIGN stays at 128 bytes for arm64. Current users can
> > evolve to use a dynamic alignment in future patches. My main aim with
> > this series is to be able to create kmalloc-64 caches on arm64.
> 
> AFAIK there are bunch of drivers that directly calls kmalloc().

Well, lots of drivers call kmalloc() ;).

> It becomes tricky when e.g.) a driver allocates just 32 bytes,
> but architecture requires it to be 128-byte aligned.

That's the current behaviour, a 32 byte allocation would return an
object from kmalloc-128. I want to reduce this to at least kmalloc-64
(or smaller) if the CPU/SoC allows it.

> That's why everything allocated from kmalloc() need to be aligned in
> ARCH_DMA_MINALIGN.

I don't get your conclusion here. Would you mind explaining?

> So I'm yet skeptical on decoupling ARCH_DMA/KMALLOC_MINALIGN. Instead
> of decoupling it, I'm more into dynamically decreasing it.

The reason for decoupling is mostly that there are some static uses of
ARCH_KMALLOC_MINALIGN as per point 1 above. The other is the
__assume_kmalloc_alignment attribute. We shouldn't have such assumed
alignment larger than what a dynamic kmalloc() would return. To me it
makes a lot more sense for ARCH_KMALLOC_MINALIGN to be the minimum
guaranteed in a kernel build but kmalloc() returning a larger alignment
at run-time than the other way around.

Thanks.

-- 
Catalin
