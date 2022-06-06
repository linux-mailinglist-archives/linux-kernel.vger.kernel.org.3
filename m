Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82EE53ECE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiFFRSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiFFRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C291CFE0D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA4E960F59
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6077DC34115
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654535582;
        bh=x2ZepxeeIeY1f3G4Tpv3PLXujBrPC6tcAoQhFhDaFs0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ula5yoSKegOU7amcLkPQQRcPeOrzsp+FddfyhuaK+BUxtSJeaiBgkB/PJzbKqwUwu
         HKFSETf7VlJaMek73K4/7sYqSwnHpiREfYTe1N09ljDc1XqN7smGASbxjeU6wUODVq
         +PkYHuRef7102f9I2UbUEAWtfjD6fbzIeAuERw9/bWHetdrNDW+06Sk4z0C2KgcaYq
         K/B2E12K17ZZdUyHQgJFq+iQ+yfy3kMJSLLJ8OO7/JyQ3U0b14/NNrUIKLT9uNSpGs
         bw8haiYgww6Y1YPkUpRkJsbcUdV+POviyYq/Iq1bnJNPes8mS0F/3yOsu0sS73mi3U
         lyCXkYFKqEoHQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f2e0a41009so19916664fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 10:13:02 -0700 (PDT)
X-Gm-Message-State: AOAM5333ofNhxi42sih9dE6b3E2VAHbbm2O5JBmyiLlJt09jiSpSwzjS
        7v2eicezOdxY6C6tesyq3NOq4CpQoLim0PV++eg=
X-Google-Smtp-Source: ABdhPJzAlVFGSDorNCgpbzm7GeYWgSOBEMtTA3i62dskqex7sORsqhnqllqdGPInR71puUxdKGm8o15C9eLK0yXiK5g=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr13983694oan.126.1654535581552; Mon, 06
 Jun 2022 10:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220606124858.384-1-thunder.leizhen@huawei.com> <CAMj1kXGCbCnV6FGTq2pBosqBTVv3B8WpNnOuiV0eSgvBMO-+8A@mail.gmail.com>
In-Reply-To: <CAMj1kXGCbCnV6FGTq2pBosqBTVv3B8WpNnOuiV0eSgvBMO-+8A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Jun 2022 19:12:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEoL32qV_xKb9ueBoJFboif2hEC_2+m-4bD5BdDnaES9w@mail.gmail.com>
Message-ID: <CAMj1kXEoL32qV_xKb9ueBoJFboif2hEC_2+m-4bD5BdDnaES9w@mail.gmail.com>
Subject: Re: [PATCH] ARM: Mark the FDT_FIXED sections as shareable
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 at 17:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hello Zhen Lei,
>
> On Mon, 6 Jun 2022 at 14:49, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >
> > commit 7a1be318f579 ("ARM: 9012/1: move device tree mapping out of linear
> > region") use FDT_FIXED_BASE to map the whole FDT_FIXED_SIZE memory area
> > which contains fdt. But it only reserves the exact physical memory that
> > fdt occupied. Unfortunately, this mapping is non-shareable. An illegal or
> > speculative read access can bring the RAM content from non-fdt zone into
> > cache, PIPT makes it to be hit by subsequently read access through
> > shareable mapping(such as linear mapping), and the cache consistency
> > between cores is lost due to non-shareable property.
> >
> > |<---------FDT_FIXED_SIZE------>|
> > |                               |
> >  -------------------------------
> > | <non-fdt> | <fdt> | <non-fdt> |
> >  -------------------------------
> >
> > 1. CoreA read <non-fdt> through MT_ROM mapping, the old data is loaded
> >    into the cache.
> > 2. CoreB write <non-fdt> to update data through linear mapping. CoreA
> >    received the notification to invalid the corresponding cachelines, but
> >    the property non-shareable makes it to be ignored.
> > 3. CoreA read <non-fdt> through linear mapping, cache hit, the old data
> >    is read.
> >
>
> Thanks for the excellent write-up, and for what must have been a lot
> of work to narrow down and diagnose!
>
> > To eliminate this risk, mark the MT_ROM sections as shareable.
> >
> > The other user of MT_ROM is XIP_KERNEL. XIP allows the kernel to run from
> > flash to save RAM space. Not sure if anyone is still using XIP in order to
> > save a little memory and not care about performance degradation. Add a new
> > memory type MT_ROM_XIP to be compatible with it.
> >
> > BTW: Another solution is to memblock_reserve() all the sections that fdt
> > spans, but this will waste 2-4MiB memory.
> >
>
> I agree that we should not add shareable attributes to the memory type
> used by XIP kernels for code regions: NOR flash is not usually
> integrated in a way that allows it to participate in the coherency
> protocol, so that will likely break things.
>
> I think, though, that it would be better to leave MT_ROM alone, and
> introduce a new type MT_MEMORY_RO instead, which is wired up in the
> right way (see below), so that we get NX attributes, and can use it to
> create non-section mappings as well.
>
> Then, as a followup which does not need to go into -stable, we can
> reduce the size of the mapping: there is really no need for the
> permanent mapping to be section granular - this is only for the early
> asm code that is not able to create 2 levels of page tables.
>

Actually, on second thought, I think reducing the size of the FDT
mapping is also needed for correctness, as the non-fdt regions could
potentially be covered by a no-map memory reservation, or get mapped
non-cacheable for things like non-coherent DMA.
