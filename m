Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79B4FC392
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348950AbiDKRmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiDKRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:42:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863E21257
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB718B817F9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75909C385A4;
        Mon, 11 Apr 2022 17:39:41 +0000 (UTC)
Date:   Mon, 11 Apr 2022 18:39:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 02/10] drivers/base: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YlRn2Wal4ezjvomZ@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-3-catalin.marinas@arm.com>
 <CAHp75Ve85_gDMUN91ZOhRLO3TkxmdO1crAcYjb1TGDCBmWbmFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve85_gDMUN91ZOhRLO3TkxmdO1crAcYjb1TGDCBmWbmFQ@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:57:08PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 6, 2022 at 2:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> > operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> > alignment.
> 
> ...
> 
> > -        * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
> > +        * Thus we use ARCH_DMA_MINALIGN here and get at least the same
> >          * buffer alignment as if it was allocated by plain kmalloc().
> 
> But then it becomes not true either, because the kmalloc() has other
> alignment constraints.

Maybe the comment could be improved a bit but I think it's still valid.
After this patch, struct devres becomes:

struct devres {
	struct devres_node		node;
	u8 __aligned(ARCH_DMA_MINALIGN) data[];
};

While we no longer guarantee the ARCH_DMA_MINALIGN alignment (which is
too big on most arm64 SoCs), what we need is for devres.data[] to be
aligned to the newly introduced arch_kmalloc_minalign(). This would give
us the DMA safety guarantees.

Since devres.data[] is at an offset multiple of ARCH_DMA_MINALIGN, in
order for the array to be aligned to arch_kmalloc_minalign(), all we
need is for ARCH_DMA_MINALIGN to be a multiple of
arch_kmalloc_minalign(). I actually had to write down some simple
equations to convince myself.

devres.data[] is at an offset multiple of ARCH_DMA_MINALIGN (after this
patch), even when struct devres is included in another structure, so we
have:

  offsetof(struct devres, data) = m * ARCH_DMA_MINALIGN

ARCH_DMA_MINALIGN is a power of two while arch_kmalloc_minalign() is
also a power of two, equal to or less than ARCH_DMA_MINALIGN:

  ARCH_DMA_MINALIGN = n * arch_kmalloc_minalign()

A kmalloc()'ed object of struct devres (or a container of) is aligned to
arch_kmalloc_minalign() by definition so:

  kmalloc() = p * arch_kmalloc_minalign()

From the above, we can conclude that the data[] pointer is at a multiple
of arch_kmalloc_minalign():

  devres.data = (p + m * n) * arch_kmalloc_minalign()

Where m, n, p are all positive integers (n is also power of two).

If we did not change the devres structure, the alignment of
ARCH_KMALLOC_MINALIGN would no no be longer sufficient since the dynamic
arch_kmalloc_minalign() can be greater than ARCH_KMALLOC_MINALIGN on
specific SoCs (the first offsetof equation is no longer true).

-- 
Catalin
