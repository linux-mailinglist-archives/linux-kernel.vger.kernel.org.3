Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4E53FE90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiFGMRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbiFGMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:16:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879BEF6898
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:15:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 001776176E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6651DC36AFE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654604141;
        bh=Jb9E0V2zg2oPVNPxcUTvoa/A+aVMyp1PhGwqF1vtsog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fbqSrlekrNTZZVmXei9TMPFP2HSnfbEwdG0PIZTrBF4K29pMVDTefdgYIYqiEeK9E
         nv9ppX0IUL1VP5ierwoJfn3eA5mckkjnMMP9+Ry0tYIxyB53SAiDGydGgka4Ggh82x
         2C1iHhk3ZyxQqTuDh/VuaKn5/IEYn2h+XMKSLPITK6IZB0WXUzTUWuxkEkjQ5w+vNg
         lA1t064oS5mvwNkvkrTVyT/uQo/8DpGG0/GBfZGSFYLRW/s9UFjyxUCLNe7f9eon9f
         LbBYdtwzP2lEZtN/gyD61GDcGielcg/MYCAJ6fO6+eWAL3QUNWesLmotwjCUtGAkH7
         eqnpY2tI0G1Gw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f2cbceefb8so22877585fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:15:41 -0700 (PDT)
X-Gm-Message-State: AOAM532tzXe90n2ctkan3UQ48Q1l+gGBzHgJrrlrGCLlDpWzHfROsIGH
        1Sii7wPREws28oRsUY8S59oxAuF+26EhNGs1eY8=
X-Google-Smtp-Source: ABdhPJyavVbwzHeLyjFiqXkE+r1dLErK39HgrscOo4TKX+8oeK+bEPg70+jChjQ3whGnBB0SgWrJPTjeoAfvU7UKY0U=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr35027420oap.228.1654604140393; Tue, 07
 Jun 2022 05:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220607111514.755009-1-Jason@zx2c4.com> <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
 <Yp8+6Y+bEcmR1LS0@zx2c4.com>
In-Reply-To: <Yp8+6Y+bEcmR1LS0@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 14:15:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFPxP3y6Ma1AonMSiW5DP0veB+NAj+ggfvrWvAARsOmgA@mail.gmail.com>
Message-ID: <CAMj1kXFPxP3y6Ma1AonMSiW5DP0veB+NAj+ggfvrWvAARsOmgA@mail.gmail.com>
Subject: Re: [PATCH] random: defer use of bootloader randomness to random_init()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
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

On Tue, 7 Jun 2022 at 14:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Tue, Jun 07, 2022 at 01:55:37PM +0200, Ard Biesheuvel wrote:
> > This is not going to work, I'm afraid - please see below.
> >
> > The next line says it all, really: the seed is in a firmware table
> > somewhere, and only gets mapped temporarily here. Note that we cannot
> > copy it either, as we are running way before we have discovered where
> > RAM is to begin with.
>
> Oh, darn. Okay. The v2 might be a bit more palpable then. It mixes
> immediately, but defers crediting:
>
> [1] https://lore.kernel.org/lkml/20220607113238.769088-1-Jason@zx2c4.com/
>
> > - Even if very convincing replies can be given to the previous two
> > points, wouldn't it be betterr to simply revert the -stable backport
> > that introduces the use of the static key, and find a robust and
> > portable solution for after v5.19?
>
> This has already been done:
>
> [2] https://lore.kernel.org/stable/20220607084005.666059-1-Jason@zx2c4.com/
>
> And mentioned here:
>
> [3] https://lore.kernel.org/lkml/CAHmME9rJif3ydZuFJcSjPxkGMofZkbu2PXcHBF23OWVgGQ4c+A@mail.gmail.com/
>
> You're on this thread.
>

OK, excellent, thanks for confirming. There are so many threads now
going on at the same time that I lost track.

> > So could we please go back to some basic questions here;
> > - Why do we need/want a static key here to begin with? Is is for performance?

You still haven't answered this question, f5bda35fba61 only reasons
about how we can use a static branch but not why we should.

Note that jump labels use asm() blocks, which are opaque to the
compiler, and so it is not guaranteed that codegen will be better than
a single conditional branch that will always be predicted correctly at
runtime. And it clutters up the code, given that you need to use the
execute_in_process_context() helper to perform the static key
manipulation outside of the calling context.

> > - Why do we need to enable this static key so early?
>
> We don't need to enable it especially early. I've now sent three
> different approaches for deferring it until later and you suggested one.
> The first of mine is kind of ugly (checking static_key_initialized and
> such at different points).  Your suggested one after that did the same
> but deferred into crng_reseed(), which I'm not a fan of. My second one
> is this patch, which is flawed for the reason you pointed out. But
> perhaps my third one is the right amount of simple and okay? That's the
> one I linked up top, [1]. Let me know what you think of that.
>
> My motivation for not wanting to defer it is that if the arch solution
> winds up being easy and straight forward (as it was for arm64), then it
> would be nice to not need to clutter up random.c as a result.

If clutter is a concern, how about getting rid of the
execute_in_process_context() dance, and just use a late_initcall()
instead?

> But if
> the arch solution winds up looking fragile or problematic somehow, then
> one of these solutions should do the trick. In particular [1] seems nice
> enough that it doesn't really even clutter things up too much as feared.
>

As I replied there, I think that patch is not as bad as the other ones
that have been suggested (including mine). But I still feel we are
going through a lot of trouble to enable something that we really
don't need here.
