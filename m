Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA392502546
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiDOGGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiDOGGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A65A94CA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB6161EF4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1625C385AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650002647;
        bh=CfFBFrsOrM1D6QuDY5JL6c2VKraxHdnJ8iQxVuMosgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rQq1sZ4J1sg22E9oqdhg4EJn8neJLzquXI+ZjaLeifOERti0Wc+sHK1ca9AEuAedm
         amy5K2gapC1d/YsBm8lKYZa4FJlvxfvg2uMYXZW+FECTSlN5rRK7n46i4eYJiT8dUP
         NtiYz25I/4SLS+ajSx8TMqQAykzYQpMyTAcuLWze4mw13G0A4DVOegWZUDW0M2S/tI
         uzeS54JMWY8wDnTklfomrz11JZpKfoakRJTc9X4u3F2pgMPd0kcfv1uydJuck6C97z
         CHIcWL2MuEdFh32B9IwZ2OpEt+7syLJujcZiPCe8uAwUQ8XxGWdZKvFcfl9sbse5l2
         wrEusSELhVbcw==
Received: by mail-oi1-f178.google.com with SMTP id w127so7600737oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:04:07 -0700 (PDT)
X-Gm-Message-State: AOAM5320qMOarSF12xHRn9dWtAT1WnQ1WfI1AJpL9FrsboACXl1csYwS
        cdohbWdmB2Q0a/EoG4Ch57ynRv1FrjZqQHiHqzM=
X-Google-Smtp-Source: ABdhPJz2xwpnXQaQcae68WnDv78hot7NwSWZe+t2TtHgLprVUTWzxwQZi9+tdzNS0HtyfFS5Ou/0nwNdizG5ZHLSuiQ=
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id
 t22-20020a056808159600b002f75d89eec7mr1017334oiw.228.1650002646826; Thu, 14
 Apr 2022 23:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <Yk/6ts5sVDMDpKj3@arm.com> <Yk/8QExHlggU8KgC@gondor.apana.org.au>
 <YlVHSvkyUBXZPUr2@arm.com> <YlVJKjXkcHqkwyt4@gondor.apana.org.au>
 <YlVOTsaTVkBOxthG@arm.com> <YlVSBuEqMt2S1Gi6@gondor.apana.org.au>
 <YlVxGAHHD/j6lW3c@arm.com> <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <CAHk-=wjr9-n7vHiVdm-L-KX4kXWyY45++8jenFA1QV5oc=yhZg@mail.gmail.com>
 <Ylh61CCMkESmurIp@arm.com> <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
In-Reply-To: <CAHk-=wjwupOLq3xh8z02CpXe8-=Lb_z0kXXQJYQ5YaQPpi3MiA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Apr 2022 08:03:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGA4NH-Kg6rWRq2kUAsefwrOGUqTp47aFQTeaQoSB_1Cg@mail.gmail.com>
Message-ID: <CAMj1kXGA4NH-Kg6rWRq2kUAsefwrOGUqTp47aFQTeaQoSB_1Cg@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 at 00:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 14, 2022 at 12:49 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > It's a lot worse, ARCH_KMALLOC_MINALIGN is currently 128 bytes on arm64.
> > I want to at least get it down to 64 with this series while preserving
> > the current kmalloc() semantics.
>
> So here's a thought - maybe we could do the reverse of GFP_DMA, and
> add a flag to the places that want small allocations and know they
> don't need DMA?
>
> Because even 64 bytes is _huge_ for those small allocations. And 128
> bytes is just insane.
>
> Maybe we don't have a ton of them, but I just checked my desktop, and
> if my laptop had 17k 8-byte allocation, on my desktop it's currently
> sitting at 43k of them. And I've got a lot of 16- and 32-byte ones
> too:
>
>   kmalloc-32         51529  51712     32  128    1 :
>   kmalloc-16         45056  45056     16  256    1 :
>   kmalloc-8          43008  43008      8  512    1 :
>
> Don't ask me what they are. It's probably fairly easy to find out, and
> it's probably something silly like sysfs private pointer data or
> whatever.
>
> If I did my math right, with a 128-byte minimum allocation, that is
> 16MB of wasted memory.
>
> Yeah, yeah, I've got 64GB or RAM in this thing, and there are things
> that take a lot more memory than the above (mem_map etc), and 64MB is
> peanuts at just 0.1% of RAM.
>

Actually, I think the impact on D-cache efficiency is a much bigger
concern, although I don't have any data to back that up. On arm64,
every 8 byte allocation takes up an entire cacheline, pushing out
other data that we could meaningfully keep there. And the doubling to
128 that is unnecessary on most arm64 systems probably has an
additional negative effect, as it means those allocations are heavily
skewed to use even indexes into the cache sets, causing extra
contention.

> Maybe nobody cares. But I really feel bad about that kind of egregious
> waste. The mem_map[] array may be big, it may use 1.5% of the memory I
> have, but at least it *does* something.
>
> And it could be that if I have 150k of those smallish allocations, a
> server with lots of active users might have millions. Not having
> looked at where they come from, maybe that isn't the case, but it
> *might* be.
>
> Maybe adding something like a
>
>         static int warn_every_1k = 0;
>         WARN_ON(size < 32 && (1023 & ++warn_every_1k));
>
> to kmalloc() would give us a statistical view of "lots of these small
> allocations" thing, and we could add GFP_NODMA to them. There probably
> aren't that many places that have those small allocations, and it's
> certainly safer to annotate "this is not for DMA" than have the
> requirement that all DMA allocations must be marked.
>
> Then just teach kmalloc() something like
>
>         align = (gfp_flags & __GFP_NODMA) ? 8 : 128;
>
> on arm.
>

Sounds like a lot of churn as well, tbh. But perhaps there are a few
hot spots that we can fix that would alleviate the bulk of the issue,
who knows?
