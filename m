Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EE353FEA7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbiFGMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbiFGMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407EFB43F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:21:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFFDC61774
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1E7C34119
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654604487;
        bh=ksFFNe7xm0oX79tCDDomZZrarZbbV5nWWlbLyEOTlgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T3dW7KqeOlbw6vNZ+A1ENczdRQnjOofrTjCfa9nO9hGXI+Ry4NR9hBt+dTF9Etins
         FNF+8i64Vc2Uced8qWB33PXka4jNAPDQIDqPoqzK1pSpOY9yuOc13pbaBpXz3OOx5/
         e/yihUo/0B0WkLwUmcQGSdrMwXaY1VXNdaYJNhRKrevuAJopct2zitPJZaT0ocQ5dq
         lnzJROuCAuP09nOlB6uULbg3+a0W3Hdu5KMYNFGNPIOG9BtBTkxcYLXtv6KjQMeQgO
         /rtoLnutJXxs+vUBa+NIYSq+xyOoS50xC5deWAXHtyIARaNexlWMkzjBNKXTtpn9Ei
         JYe9jrvcXGplw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-f2e0a41009so22922718fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:21:27 -0700 (PDT)
X-Gm-Message-State: AOAM531L/B1jwcktANunt4k7wAVM1pHS6WdHWZg18rHBBjEh4hbanUm5
        eGW7vdFNRPhbtBv/f14CNDNz3oNTc6FXL2zEPUs=
X-Google-Smtp-Source: ABdhPJwF9WaK98yWUyqrrQMSRr8QQvyarEiVENFU+gfpjxrB+sdK+dC0buBYdz8WbuehbhbY3YvjNy1ULHb17/71pOM=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr16341810oan.126.1654604486249; Tue, 07
 Jun 2022 05:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220607100210.683136-1-Jason@zx2c4.com> <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
 <Yp8oOH+9V336LrLk@zx2c4.com> <Yp8rcFrqK/IkzKXj@zx2c4.com> <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
 <Yp8wz2Ey4J4u+ZlK@zx2c4.com> <CAMj1kXFK9pFUdOABKP0Zp7tEJNVS1dTjxp5DgSwqzM8TEYJLTQ@mail.gmail.com>
 <Yp839NjwW3scZEqi@zx2c4.com> <CAMj1kXF7NToZgAW66puCOwc1+d7ZTmVm_CbDYEeH+j0XJH1vug@mail.gmail.com>
 <Yp9BmEyOvVitZICT@zx2c4.com>
In-Reply-To: <Yp9BmEyOvVitZICT@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 14:21:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHfs46UKjkVoWwtSGiRACP0v69x0mr8_J_BWmx-WCVMhw@mail.gmail.com>
Message-ID: <CAMj1kXHfs46UKjkVoWwtSGiRACP0v69x0mr8_J_BWmx-WCVMhw@mail.gmail.com>
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

On Tue, 7 Jun 2022 at 14:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> On Tue, Jun 07, 2022 at 02:03:28PM +0200, Ard Biesheuvel wrote:
> > On Tue, 7 Jun 2022 at 13:35, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Tue, Jun 07, 2022 at 01:10:52PM +0200, Ard Biesheuvel wrote:
> > > > Fair enough. What I would like is to remove the need to play around
> > > > with the placement of jump_label_init() across architectures. Jump
> > > > labels are fundamentally a performance optimization, so unless you can
> > > > explain how setting it as early as possible makes a material
> > > > difference, performance or otherwise, I really think we should pursue
> > > > a solution that does the static key manipulation at some later time.
> > >
> > > Alright. It sounds like Catalin also prefers the same. This seems simple
> > > enough with minimal downsides: https://lore.kernel.org/lkml/20220607113238.769088-1-Jason@zx2c4.com/
> > >
> >
> > That looks simple enough. Do we risk causing any boot stalls due to
> > the crediting being deferred? Or new warnings about randomness being
> > used before CRNG is ready?
>
> We don't risk boot stalls. But there will be warnings for developers who
> have enabled the CONFIG_WARN_ALL_UNSEEDED_RANDOM debug option.
>
>
> > > So maybe we should just go that route.
> > >
> >
> > It is not my preferred approach, but I can live with it.
>
> I'm not sure what your preferred approach is at this point in time
> actually. I'll summarize all the approaches discussed so far:
>
> 1) Fix archs to initialize jump labels earlier:
>    https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=73e2d827a501
>    https://lore.kernel.org/lkml/20220603121543.360283-1-Jason@zx2c4.com/
>
> 2) Defer mixing & crediting until random_init():
>    https://lore.kernel.org/lkml/20220607111514.755009-1-Jason@zx2c4.com/
>
> 3) Defer crediting (but not mixing) until random_init():
>    https://lore.kernel.org/lkml/20220607113238.769088-1-Jason@zx2c4.com/
>
> 4) Defer changing the static branch (but neither mixing nor crediting) until random_init():
>    https://lore.kernel.org/lkml/20220607100210.683136-1-Jason@zx2c4.com/
>
>
> My first choice is (1) if it's feasible.
>
> (2) is not possible without introducing a copy, so that's out.
>
> What's your preferred approach? Or is there a number 5 you have in mind?
>

Seems like we need a mutex instead of going back concurrently on two
different threads :-)

I'll shut up now and wait for your reply on the other thread.
