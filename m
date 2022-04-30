Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D85160CD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiD3Wk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3Wky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:40:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB498A328;
        Sat, 30 Apr 2022 15:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4837CB80B12;
        Sat, 30 Apr 2022 22:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BF4C385AF;
        Sat, 30 Apr 2022 22:37:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NDp4rIz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651358245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+iDoApNmZrBzOkGGRMF45E5XlCq10GMqaSSRUq7xoY=;
        b=NDp4rIz1aJ6W3pKPhtbH7uZHeUlBqacS/FwdHa/UcS3yB5axymjs5llq+Lctq92FVIqAdz
        9+ug3PlUJCyLLNefwB7YVA14nmkgeZZU/FhqWDCf5dDcxW9PGQye4Dz7n0NFTeEnmVVGLu
        gxkrFTjCVxAoTjennIuUe2NN7LOpg5Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0dd4c7e5 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 30 Apr 2022 22:37:25 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ec42eae76bso117314247b3.10;
        Sat, 30 Apr 2022 15:37:24 -0700 (PDT)
X-Gm-Message-State: AOAM5307DrX4Lzyng+QXeYonGVlA3uLCjuJPNpIAbapM0l6X3+4lzV6B
        KlMFolPZwyIJmu5/Q+/oct7kIMBL3DbFD66UH6g=
X-Google-Smtp-Source: ABdhPJxYU0UY9+GbGujV1hleABZ56tELHgGQKt7bK1UNe/8NSCWuVTYsay879Flpt7wuESIHe7mw7VD2paMNb7OwCIw=
X-Received: by 2002:a81:86c7:0:b0:2f7:bc6a:964c with SMTP id
 w190-20020a8186c7000000b002f7bc6a964cmr5587305ywf.485.1651358244216; Sat, 30
 Apr 2022 15:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220430122355.2718797-1-Jason@zx2c4.com> <20220430122433.2719029-1-Jason@zx2c4.com>
 <Ym2567zStHwlND35@antec>
In-Reply-To: <Ym2567zStHwlND35@antec>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 1 May 2022 00:37:13 +0200
X-Gmail-Original-Message-ID: <CAHmME9r-=ShRomP=Nrcz-GjP4kv4e9wKHvNdAMiRui7_FSbH-A@mail.gmail.com>
Message-ID: <CAHmME9r-=ShRomP=Nrcz-GjP4kv4e9wKHvNdAMiRui7_FSbH-A@mail.gmail.com>
Subject: Re: [PATCH v8 06/19] openrisc: start CPU timer early in boot
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 12:36 AM Stafford Horne <shorne@gmail.com> wrote:
>
> On Sat, Apr 30, 2022 at 02:24:33PM +0200, Jason A. Donenfeld wrote:
> > In order to measure the boot process, the timer should be switched on as
> > early in boot as possible. This is necessary so that by the time the
> > setup code reaches random_init(), get_cycles() (by way of
> > random_get_entropy()) returns non-zero, indicating that it is actually
> > capable of counting. So this commit enables the timer immediately upon
> > booting up. As well, the commit define the get_cycles macro, like the
> > previous patches in this series, so that generic code is aware that it's
> > implemented by the platform, as is done on other archs.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Changes v7->v8:
> > - Rather than doing get_cycles()+1 to handle the early boot case,
> >   actually start the timer early in boot. This has the huge advantage of
> >   properly measuring the boot sequence timing, which could be a valuable
> >   source of entropy.
> >
> >  arch/openrisc/include/asm/timex.h | 1 +
> >  arch/openrisc/kernel/setup.c      | 7 +++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
> > index d52b4e536e3f..5487fa93dd9b 100644
> > --- a/arch/openrisc/include/asm/timex.h
> > +++ b/arch/openrisc/include/asm/timex.h
> > @@ -23,6 +23,7 @@ static inline cycles_t get_cycles(void)
> >  {
> >       return mfspr(SPR_TTCR);
> >  }
> > +#define get_cycles get_cycles
> >
> >  /* This isn't really used any more */
> >  #define CLOCK_TICK_RATE 1000
> > diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> > index 0cd04d936a7a..1cb7c1770a17 100644
> > --- a/arch/openrisc/kernel/setup.c
> > +++ b/arch/openrisc/kernel/setup.c
> > @@ -220,6 +220,13 @@ void __init setup_cpuinfo(void)
> >
> >  void __init or1k_early_setup(void *fdt)
> >  {
> > +     /* Start the TTCR as early as possible, so that the RNG can make use of
> > +      * measurements of boot time from the earliest opportunity. Especially
> > +      * important is that the TTCR does not return zero by the time we reach
> > +      * rand_initialize().
> > +      */
> > +     mtspr(SPR_TTMR, SPR_TTMR_CR);
> > +
> >       if (fdt)
> >               pr_info("FDT at %p\n", fdt);
> >       else {
>
> It looks like we cross paths on this one.
>
> I can't think of anything better.  Also, I tested this on SMP systems and it
> works fine.
>
> Acked-by: Stafford Horne <shorne@gmail.com>

Oh okay. Do you want me to go with this or with the assembly one?

Jason
