Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0469D53FD11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbiFGLLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbiFGLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:11:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0265F120B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98FBBB81F68
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F2FC385A5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654600266;
        bh=PIkzzbA01Ke1e/RvnsMMOC+0QlwVwbLmLPr3rdaNonU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NpkMadAVWM+8qyvEpWsUhzhB+bfwyX/YxFEzg6lTh6fkXOfa7vjRQWNPcsCo9L9GC
         yF8xCzHKzvQed+DO6cYsIgTFLgGkIE4+j282R2+4EOxqz89JM9PKY+0hueMhKvrvu9
         M75u5kWdy88pyHNKWnqYewAvL8SX0In4UA23S06Xo/te+8qYIzC1yF+F15a5z9eY58
         7AlfvEU8dJ6Weu7H0m6JTbkTiMfY25razWKB42jpSidP6lflLf3NkJ/OtOg3K7RCR3
         /hYWLb97qOk5GJ3N8K/Wy+f1+ufg4m+3/PMZyBI6ZDjxbyIjIrYuJcP06GzMY8Qg/V
         liLERutnYuwcg==
Received: by mail-oi1-f176.google.com with SMTP id s8so18161059oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 04:11:06 -0700 (PDT)
X-Gm-Message-State: AOAM532voL2al5PCbmTsFlJAMpAS2BRJ0fFeUgEgnuyEV529ySPQWeCs
        W+8XvCikQwUrdPFtElPhn+cNvuCL3ecz0rqVV+o=
X-Google-Smtp-Source: ABdhPJx1A/CvRWfOQ3GFWIDzS3fTiGPqRgRi8dTUnmjkP0XSzpYtlEYcz6hvOOgD5Zoh3259OdkBrVt9FP81qFpcuLs=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr16693579oib.126.1654600265478; Tue, 07
 Jun 2022 04:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220607100210.683136-1-Jason@zx2c4.com> <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
 <Yp8oOH+9V336LrLk@zx2c4.com> <Yp8rcFrqK/IkzKXj@zx2c4.com> <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
 <Yp8wz2Ey4J4u+ZlK@zx2c4.com>
In-Reply-To: <Yp8wz2Ey4J4u+ZlK@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 13:10:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFK9pFUdOABKP0Zp7tEJNVS1dTjxp5DgSwqzM8TEYJLTQ@mail.gmail.com>
Message-ID: <CAMj1kXFK9pFUdOABKP0Zp7tEJNVS1dTjxp5DgSwqzM8TEYJLTQ@mail.gmail.com>
Subject: Re: [PATCH] random: do not use jump labels before they are initialized
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Tue, 7 Jun 2022 at 13:04, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> On Tue, Jun 07, 2022 at 12:56:20PM +0200, Ard Biesheuvel wrote:
> > Could we do this to defer the static key manipulation? That way, the
> > first call to crng_reseed() that occurs after the static keys API
> > becomes available will set the static key, and patch itself away at
> > the same time.
>
> That's almost the same as the patch I just posted, except you
> pushed the logic down into crng_reseed() instead of credit_init_bits().

Sure.

> (A previous mini-project aimed to remove as much logic as possible from
> crng_reseed(), counting on those blocks in crng_init_bits() to only ever
> run once.) What this means is that the static key won't get changed
> until whenever the next reseeding is. I guess that's "fine" but I think
> I'd prefer to keep the entropy counting stuff as separate from the init
> bits stuff as possible.
>

Fair enough. What I would like is to remove the need to play around
with the placement of jump_label_init() across architectures. Jump
labels are fundamentally a performance optimization, so unless you can
explain how setting it as early as possible makes a material
difference, performance or otherwise, I really think we should pursue
a solution that does the static key manipulation at some later time.

> >> As a third, I could just defer doing anything with the bootloader seed
> >> until random_init(). This might actually be the simplest solution...
> >> I'll sketch something out. A downside, which might be sort of
> >> significant, is that a few odd things actually use randomness before
> >> random_init() is called. So these would miss out on having that seed.
> >> I'll have to look what exactly to see if we're actually getting anything
> >> real out of that.
> >>
> >
> > This is kind of the point of using a firmware provided seed, i.e.,
> > that it is available much earlier than anything else.
>
> I'll send a patch for this anyway because I'm sort of curious now. Maybe
> it'll be a dead end, for the reason you mentioned, but I think I'll
> still try to evaluate it.
>

Sure. Anything that can be deferred to an initcall() should be, as the
early arch code is much too fragile to much around with.
