Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A871C4E226F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbiCUIsn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Mar 2022 04:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345388AbiCUIsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:48:40 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8E4A5E9B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:47:15 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id gi14so109265qvb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5gk+/j84Xzw+Bz6trp5c4rDqGZSiryYy0T6cty9/gyU=;
        b=eVOKFBYvvNM82R8WVxlJlTrA4s9qUny1EPeKeZ72wuyPvdzCW3OySSr6i5ilOhgrEM
         yMQhd7xJxGHZHhEfaLZxUAL+Q7HRFXQNGmtLiGHPmdrL1kuROZOPqx0o4VDA9/l0+lyP
         O+IwmCjkA6R25Yd3+PzodnVJq3oTqIQ9EQjxChibEhCUy12YOFd69fNJ4zQfIBcXAWbW
         Mh24tdLCS8b8Z869KdfiLLwVLyCb63ZIED4aQyPviZRfAI+cj+itrjI19tSKzLVYI2vM
         eKycYm1aABOs0M/UuhC88eG/1j/KeiHIdtBiF+ZngmbQE9y/dbGJfth+PQt67NU2avew
         TOLQ==
X-Gm-Message-State: AOAM532j6EEIaPDx1ZFM4/MK5leMFGoes6hl7z/sRfnk/FqzYfkf96pM
        O6/zzlX6QSv/EfNlectKClnJQEGJ0/+XEQ==
X-Google-Smtp-Source: ABdhPJxw9BGEWqaPgRewXLUAF0H5FHzPsUK4Np/DvBlNdUfM0zZeb7uPXEBteOEr99M9b1EYZH3Pxw==
X-Received: by 2002:ad4:5965:0:b0:440:fee0:bef2 with SMTP id eq5-20020ad45965000000b00440fee0bef2mr10310422qvb.68.1647852434169;
        Mon, 21 Mar 2022 01:47:14 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 64-20020a370343000000b0067b31f32693sm7594975qkd.109.2022.03.21.01.47.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:47:13 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2e64a6b20eeso7768907b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:47:13 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr23075844ywb.132.1647852433271; Mon, 21
 Mar 2022 01:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <d987663bbed18d7dbf106db6066a759040b4e57a.1647837028.git.fthain@linux-m68k.org>
 <5291a177-9a67-b23a-515f-7faa3cc887e8@csgroup.eu> <e8398356-8ba3-e9de-8da0-3591907340b5@linux-m68k.org>
In-Reply-To: <e8398356-8ba3-e9de-8da0-3591907340b5@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Mar 2022 09:47:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXqzWo1+gAfEjOQEZHeprbPEzWyCaUqLKx0_4nrDG+5Uw@mail.gmail.com>
Message-ID: <CAMuHMdXqzWo1+gAfEjOQEZHeprbPEzWyCaUqLKx0_4nrDG+5Uw@mail.gmail.com>
Subject: Re: [PATCH] macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Mon, Mar 21, 2022 at 9:29 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On Mon, 21 Mar 2022, Christophe Leroy wrote:
> > Le 21/03/2022 à 05:30, Finn Thain a écrit :
> > > drivers/macintosh/via-pmu-event.o: In function `via_pmu_event':
> > > via-pmu-event.c:(.text+0x44): undefined reference to `input_event'
> > > via-pmu-event.c:(.text+0x68): undefined reference to `input_event'
> > > via-pmu-event.c:(.text+0x94): undefined reference to `input_event'
> > > via-pmu-event.c:(.text+0xb8): undefined reference to `input_event'
> > > drivers/macintosh/via-pmu-event.o: In function `via_pmu_event_init':
> > > via-pmu-event.c:(.init.text+0x20): undefined reference to `input_allocate_device'
> > > via-pmu-event.c:(.init.text+0xc4): undefined reference to `input_register_device'
> > > via-pmu-event.c:(.init.text+0xd4): undefined reference to `input_free_device'
> > > make[1]: *** [Makefile:1155: vmlinux] Error 1
> > > make: *** [Makefile:350: __build_one_by_one] Error 2
> > >
> > > Don't call into the input subsystem unless CONFIG_INPUT is built-in.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > > ---
> > > This is equivalent to the patch I sent a couple of days ago. This one
> > > is slightly longer and adds a new symbol so that Kconfig logic can been
> > > used instead of Makefile logic in case reviewers prefer that.
> > > ---
> > >   drivers/macintosh/Kconfig   | 5 +++++
> > >   drivers/macintosh/Makefile  | 3 ++-
> > >   drivers/macintosh/via-pmu.c | 2 ++
> > >   3 files changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> > > index 5cdc361da37c..b9102f051bbb 100644
> > > --- a/drivers/macintosh/Kconfig
> > > +++ b/drivers/macintosh/Kconfig
> > > @@ -67,6 +67,11 @@ config ADB_PMU
> > >       this device; you should do so if your machine is one of those
> > >       mentioned above.
> > >
> > > +config ADB_PMU_EVENT
> > > +   bool
> > > +   depends on ADB_PMU && INPUT=y
> > > +   default y
> >
> > Could be reduced to
> >
> > config ADB_PMU_EVENT
> >       def_bool y if ADB_PMU && INPUT=y
>
> That's great but my question remains unanswered: why the aversion to
> conditionals in Makefiles, when that would be simpler (no new symbol)?

While conditionals in Makefiles do exist, they are far less common, and
can be confusing.  They're also harder to grep for.
E.g. "git grep via-pmu-event.o" after your alternative patch would
give:

    obj-$(CONFIG_ADB_PMU)          += via-pmu-event.o

but would miss the important surrounding part:

    ifeq ($(CONFIG_INPUT), y)
    obj-$(CONFIG_ADB_PMU)          += via-pmu-event.o
    endif

Keeping configuration logic in a single place (the Kconfig file)
avoids that.  The extra symbol is invisible, so it doesn't hurt much.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
