Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842215035CD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 11:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiDPJoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 05:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiDPJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 05:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16CB165B0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 02:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7104360DBA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 09:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8477BC385A3;
        Sat, 16 Apr 2022 09:42:08 +0000 (UTC)
Date:   Sat, 16 Apr 2022 10:42:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlqPbJtZliPUy0/a@arm.com>
References: <YlVHSvkyUBXZPUr2@arm.com>
 <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com>
 <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com>
 <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <Ylh61CCMkESmurIp@arm.com>
 <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:25:59PM -0700, Linus Torvalds wrote:
> On Thu, Apr 14, 2022 at 12:49 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > It's a lot worse, ARCH_KMALLOC_MINALIGN is currently 128 bytes on arm64.
> > I want to at least get it down to 64 with this series while preserving
> > the current kmalloc() semantics.
> 
> So here's a thought - maybe we could do the reverse of GFP_DMA, and
> add a flag to the places that want small allocations and know they
> don't need DMA?

I wonder whether that's a lot more churn than trying to identify places
where a small kmalloc()'ed buffer is passed to the DMA API. DMA into
kmalloc() buffers should be a small fraction of the total kmalloc()
uses.

For kmem_cache we have the SLAB_HWCACHE_ALIGN flag. We can add a similar
GFP_ flag as that's what we care about for DMA safety. It doesn't even
need to force the alignment to ARCH_DMA_MINALIGN but just
cache_line_size() (typically 64 on arm64 while ARCH_DMA_MINALIGN is 128
for about three platforms that have this requirement).

Functions like dma_map_single() can be made to track down the origin of
the buffer when size < cache_line_size() and warn if the slab is not
correctly aligned.

-- 
Catalin
