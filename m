Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF653C04B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiFBVLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiFBVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:11:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9CE103
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52B6FB82188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 21:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1B4C3411E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 21:11:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J3QEqc4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654204258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tUmPQIJUL4+NtOzBFIJo7+QbnFFXVwwaSJN2qOuZG+s=;
        b=J3QEqc4/7f/oCewQMUXIA7sGO4TxpQpUWqpatExzE7amuYnSgqxHDmbatojLvKJxulbS9H
        q0lAQ4JaKCIoH0h8XH4LFSQgcm8Mn5rm8/9PeikipA3+3Nu4h7K5tU3U7FH2PoHRA44x5B
        ILr5afDyrDPj9COwCq088KMmNT+y2KM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5e55c5eb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 2 Jun 2022 21:10:58 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ff7b90e635so64529647b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 14:10:58 -0700 (PDT)
X-Gm-Message-State: AOAM533THESB2NaPQ+fK3kDvsemXSSbhDq2QYeMflvKXdRq6QzgE+rSj
        viDv0PWz9JFVx4nJsH8AjXJbd3OmaCKLRs5Ngow=
X-Google-Smtp-Source: ABdhPJz4aD5dVJBqZ1Vb7U2MlE3y+pqqnB+n0yW1keIUBWEPiO6NL2LyPnAEVK8FLPA5ZsxQE2sPyJvRTPY1zWHo2bI=
X-Received: by 2002:a0d:ef03:0:b0:2fa:245:adf3 with SMTP id
 y3-20020a0def03000000b002fa0245adf3mr8030036ywe.100.1654204256504; Thu, 02
 Jun 2022 14:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220602022109.780348-1-swboyd@chromium.org> <165419885870.2681883.10934677413962491141.b4-ty@arm.com>
 <CAHmME9qBOwb==N9AWSSb8VhCXANsieWi7JpiiiUMvjU2rdb5XA@mail.gmail.com>
 <YpkTjv6i+IlO32wM@arm.com> <CAHmME9pU+t_rvQULcOwQmhU74ye3ShWi4Tgz5JdGrzW29XO+Kg@mail.gmail.com>
 <Ypkm2YLFO5gDlenP@arm.com>
In-Reply-To: <Ypkm2YLFO5gDlenP@arm.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 2 Jun 2022 23:10:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9ocwrUZoi=AyTsaWoBLyy_FL_uVenZ+3N5wFHbOHR-vSg@mail.gmail.com>
Message-ID: <CAHmME9ocwrUZoi=AyTsaWoBLyy_FL_uVenZ+3N5wFHbOHR-vSg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Initialize jump labels before setup_machine_fdt()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Will Deacon <will@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, patches@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Greg

Hi Catalin,

On Thu, Jun 2, 2022 at 11:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Jun 02, 2022 at 10:18:04PM +0200, Jason A. Donenfeld wrote:
> > On Thu, Jun 2, 2022 at 9:46 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Thu, Jun 02, 2022 at 09:42:49PM +0200, Jason A. Donenfeld wrote:
> > > > On Thu, Jun 2, 2022 at 9:41 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > On Wed, 1 Jun 2022 19:21:09 -0700, Stephen Boyd wrote:
> > > > > > A static key warning splat appears during early boot on arm64 systems
> > > > > > that credit randomness from devicetrees that contain an "rng-seed"
> > > > > > property. This is because setup_machine_fdt() is called before
> > > > > > jump_label_init() during setup_arch(). Let's swap the order of these two
> > > > > > calls so that jump labels are initialized before the devicetree is
> > > > > > unflattened and the rng seed is credited.
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Applied to arm64 (for-next/core), thanks!
> > > > >
> > > > > [1/1] arm64: Initialize jump labels before setup_machine_fdt()
> > > > >       https://git.kernel.org/arm64/c/73e2d827a501
> > > >
> > > > I'm not sure precisely what your for-next tag corresponds to, but just
> > > > FYI, this should probably go into 5.19 asap and be marked for stable@.
> > >
> > > The for-next/core branch should go in 5.19-rc1 (I'll send a pull request
> > > tomorrow). There's no need to cc stable since the fixed commit just went
> > > in (unless you mean something else by "marked for stable").
> >
> > It is actually in stable, so please do CC. Otherwise I'll just forward manually.
>
> Ah, I didn't know this (the fixed commit doesn't have a cc stable
> either). So please forward it manually once Linus pulls it.

Will do.

Jason
