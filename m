Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296224C28A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiBXJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiBXJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:56:58 -0500
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC80E28ADA9;
        Thu, 24 Feb 2022 01:56:22 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id k9so879774vki.4;
        Thu, 24 Feb 2022 01:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaaU3qYErVihNgxgJw4SHNwOEGx/UhY/ytg286+tR04=;
        b=JPlbGO8qyl9Dzq1lI5Tgm2np3C9+me2aiPspPVq0QzqjKmt1CUefYd/0T43Ykz1dt6
         nEge7XJqToKfs3LhCraxdNsFYLBjf7V4ZRR5BDeEUH02AmklI2FUn5PxGd9CHSA078Kt
         ihtC+iiz77d4FiJ8HdcaPBm47ATGJ5Ca2ZeUIYgvrb+NxOacoQNn4BZ2OnT7IjYe56QU
         y5wQi4BlZNkYVs/g+SCB1RqAA7g67ME2xMy2EKY5e50Kn2HELIVVtZIWHA95zjwD5EOj
         vXufRzsX8b09jI3vytBUc3fhMzYjIVKwkQ4/gYs9Tn9njl+Jl3AERL0oCaGLEYhNly6U
         +mDA==
X-Gm-Message-State: AOAM531CzzHZl7SlmcC1MKPPF1OlF0bGXhonduA/fTEItZwF0Cweh0F9
        eF7hAc6Wi0atOJMeF2aE+P35TFbWG7bjcw==
X-Google-Smtp-Source: ABdhPJynvsEgIoJZ2AoCZok9nIYdyhMjWHm927h9o3VujvqmAS1n0AYSWp7++DenJOLYDcbLSK8JoA==
X-Received: by 2002:a1f:1c4:0:b0:321:bdee:acbd with SMTP id 187-20020a1f01c4000000b00321bdeeacbdmr727554vkb.39.1645696581613;
        Thu, 24 Feb 2022 01:56:21 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id b78sm315516vka.56.2022.02.24.01.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 01:56:21 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id g15so610508ual.11;
        Thu, 24 Feb 2022 01:56:21 -0800 (PST)
X-Received: by 2002:a9f:360f:0:b0:341:8a12:8218 with SMTP id
 r15-20020a9f360f000000b003418a128218mr737932uad.14.1645696580955; Thu, 24 Feb
 2022 01:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20220224060448.1856091-1-keescook@chromium.org>
 <CAMuHMdVioQLy_T2LimgWdfWM=j=fomfpayuS1mbXnBLZj4gGQA@mail.gmail.com>
 <d75f1259c3e64387a161ebcb0448d594@AcuMS.aculab.com> <CAMuHMdWtQ+B-01ZOwZNvgQ7pndNsP3V90_jHdR=RS4K7O3Vk9g@mail.gmail.com>
 <95b9c3e8227a4892b26cc0384d1782c2@AcuMS.aculab.com>
In-Reply-To: <95b9c3e8227a4892b26cc0384d1782c2@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Feb 2022 10:56:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU6msvi0j=mS28GFYbm+uMRk7PkYe+zOM4sDmOVxeibLQ@mail.gmail.com>
Message-ID: <CAMuHMdU6msvi0j=mS28GFYbm+uMRk7PkYe+zOM4sDmOVxeibLQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Implement "current_stack_pointer"
To:     David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Kees,

On Thu, Feb 24, 2022 at 10:54 AM David Laight <David.Laight@aculab.com> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 24 February 2022 09:17
> >
> > On Thu, Feb 24, 2022 at 10:12 AM David Laight <David.Laight@aculab.com> wrote:
> > > From: Geert Uytterhoeven
> > > > Sent: 24 February 2022 08:59
> > > ...
> > > > > +register unsigned long current_stack_pointer __asm__("sp");
> > > >
> > > > I don't know what HARDENED_USERCOPY does, so I don't know if you need
> > > > "usp" (see rdusp()) or "sp"?
> > >
> > > HARDENED_USERCOPY significantly slows down some systems calls
> > > (especially things like sendmsg()) by trying to run-time verify
> > > that the kernel buffer doesn't overrun a stack frame or kmalloc()ed
> >
> > Kernel stack frame of user stack frame?
>
> Kernel, the kernel doesn't care if the user stack gets trashed.

OK.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Kees: Do you want me to queue this in the m68k for-v5.18 branch, or do
you want to take it yourself, together with the HARDENED_USERCOPY work?
In case of the latter:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Please let me know. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
