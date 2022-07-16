Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70608577193
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 23:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiGPVgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 17:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPVgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 17:36:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FB5186C6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:36:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ez10so14788647ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5MNxF6HQt18ArNx99k1EypgpgmCjDyR8Pgj+dEhqhE=;
        b=B7B0Xx/vBB5LIfAfDpoYoyPOQo37uenioUBXSGhILkCVV4sHVWRC83NB0qjuxYFTzS
         rzVH6KZBFO4wYFFdNm0C7hvH70V/FyLc0FuEtb4VuqsHQNobrz1MVOQiXpWwdXpdxmCx
         YvaLa+rtQZIXTV5+sBkl0CNz3WyXmqhFu1vac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5MNxF6HQt18ArNx99k1EypgpgmCjDyR8Pgj+dEhqhE=;
        b=1wkg19p+8E99XDqvC7LPNMRUo+sz+f/54xWUGDMf5mmvmFPZOKmNZS9fJbSbDbEIQZ
         5prlIY/UQJaQRLOcou0P3OqVT0OFZX2iVlQvQQL6lZWiWHqHEMlOWC9LNZ0PM8/7Pq9J
         YxTrPVi4uPLKSbuhM8bpIiFh73WXclIISsUhvCmQbP9pZ25o7/UZ1YsAsDizJX8bWeiH
         YiH659aH/I1beF1qhueeC8+XMi3ZPvD7ZiE+87Wb1owRc3iXT6fvTHmRqZMCIZMT+4UT
         jdRe6Tibgd5h+qyQ+86Zv9eo4WlqslKzGTw0C6gz5kAzojrNJXpawq7pQ5yMI9rISOZX
         T7QQ==
X-Gm-Message-State: AJIora9MxL9wNQP7cR2Owt0WrVriuxqFTBakLlp6zIF9tPgabtzf6OML
        GGZ3MM5LhizF5cB8MDeCvMhGo9RZqih7Imrs
X-Google-Smtp-Source: AGRyM1vhmGfuUbd/JmofojW7SND8kcCwVbn0yMwRg99pBVNJildXfTw/1gZHczkI4M9iyl9RCbGtBQ==
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id i4-20020a1709064fc400b006dab4c6fadbmr19698884ejw.282.1658007371813;
        Sat, 16 Jul 2022 14:36:11 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906148a00b00705cdfec71esm3653759ejc.7.2022.07.16.14.36.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 14:36:10 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so2676546wmi.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 14:36:10 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr19959278wmq.8.1658007370148; Sat, 16 Jul
 2022 14:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twM75GDM9t+9-CSCPDZG3QdcEpQ-X+FzQ4CLUCM7cKLkw@mail.gmail.com>
 <YtHXe4PcWXfihF9Q@dev-arch.thelio-3990X>
In-Reply-To: <YtHXe4PcWXfihF9Q@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Jul 2022 14:35:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5DB+OL2QvWPqRhpLLCqW7u_bLucFJpm4v6rZT3T5+zQ@mail.gmail.com>
Message-ID: <CAHk-=wh5DB+OL2QvWPqRhpLLCqW7u_bLucFJpm4v6rZT3T5+zQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.19-rc7
To:     Nathan Chancellor <nathan@kernel.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 2:09 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Jul 15, 2022 at 01:36:17PM +1000, Dave Airlie wrote:
> > Matthew Auld (1):
> >       drm/i915/ttm: fix sg_table construction
>
> This patch breaks i386_defconfig with both GCC and clang:
>
>   ld: drivers/gpu/drm/i915/i915_scatterlist.o: in function `i915_rsgt_from_mm_node':
>   i915_scatterlist.c:(.text+0x1a7): undefined reference to `__udivdi3'

Yeah, we definitely don't want arbitrary 64x64 divides in the kernel,
and the fact that we don't include libgcc.a once again caught this
horrid issue.

The offending code is

        if (sg_alloc_table(st, DIV_ROUND_UP(node->size, segment_pages),
                           GFP_KERNEL)) {

and I have to say that all of those games with "u64 page_alignment"
that commit aff1e0b09b54 ("drm/i915/ttm: fix sg_table construction")
introduces are absolutely disgusting.

And they are just *pointlessly* disgusting.

Why is that "page_alignment" a "u64"?

And why is it a "size", instead of being a "number of bits"?

The code literally does things like

        const u64 max_segment = round_down(UINT_MAX, page_alignment);

which means that

 (a) page_alignment must be a power-of-two for this to work
(round_down() only works in powers of two)

 (b) the result obviously must fit in an "unsigned int", since it's
rounding down a UINT_MAX!

So (a) makes it doubtful that "page_alignment" should have been a
value (as opposed to mask), and (b) then questions why was that made
an "u64" value when it cannot have a u64 range?

And if max_segments cannot have a 64-bit range, then segment_pages here:

        u64 segment_pages = max_segment >> PAGE_SHIFT;

sure cannot.

Fixing those then uncovers other things:

                len = min(block_size, max_segment - sg->length);

now complains about mixing types ("max_segment - sg->length" being
u32), because 'block_size' is 64, bit, and that does seem to make some
amount of sense:

        block_size = node->size << PAGE_SHIFT;

with the 'node->size' being from drm_mm_node, and that size is a
'u64'. That I *could* see being more than 32 bits on a 64-bit
architecture. Ok.

But then that means that 'len' cannot be a 64-bit value either, and it
should probably have been

                u32 len;
    ..
                len = min_t(u64, block_size, max_segment - sg->length);

and that would just have been a lot nicer on 32-bit x86, avoiding a
lot of pointlessly 64-bit things.

That said, even those type simplifications do not fix the fundamental
issue. That "DIV_ROUND_UP()" still ends up being a 64-bit divide,
although now it's at least a "64-by-32" bit divide.

Which needs to be handled by "do_div()" rather than the generic
DIV_ROUND_UP() helper, because sadly, at least gcc still generates a
full __udivdi3() even for the 64-by-32 divides.

Can Intel GPU people please take a look?

             Linus
