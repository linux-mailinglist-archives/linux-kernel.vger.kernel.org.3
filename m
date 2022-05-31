Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7042539577
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346564AbiEaRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346060AbiEaRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:30:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9602993471
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:30:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so27946713ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJ1Dv/ORClSlD+t4yWurULyU8Rzqx47jCXHy+bRYEDE=;
        b=s4SFXEhIZO0VXaghT5MstJ3pOKhlcr6UMVHN6702O+K4zb4HghdAQ8ECXuhr5e3cwa
         1tn6ZRRajJe94KKFptIBpCnK3mbwFFuLTEx/3W4v7zOn6xBBXd1Pmrdu1VoTmzqhztY2
         NrHukB0XSDydD1LWnNSwgH9eSXZJO+j4JCGIgg1eV/E7+ciDUtFLDsmQ7hEDjxV3xpL3
         dVg4f+mifOcN7CBo9rgfLB3IdEL8+gnUWSSrAWXeVAtRh5lq7S3aiEQtDBfAefsQ87iC
         3AMxOmxb5BhxG08XHEmQnRxN0cXK1lq9cGTHNzRsl0sZwOagACD5DfxA4Cp1WGYxLP+1
         oQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJ1Dv/ORClSlD+t4yWurULyU8Rzqx47jCXHy+bRYEDE=;
        b=1veRCYJh7QsuyxURi31NA/zyaRBuVifG2+1vFI6eam1hXgfwU0TgC5QKXaDbxy++tS
         MSR7jy2sgGSahtMFpEXtGbCM+LcCIt1TddpQUKDRhiUrNYrxhpqd2Xmp7HoD8ZRk0aKq
         sQ6k4Jy3rCloJYZO5/FD7bm9u7OlpwvWGEvSGaCtZD2wPbDAa7q0OsAoZ3hj65NGTdPT
         UiGj59RyOjPkuIFVR3vMOH2pngRSKNdyk0K8y6ACBaMrgG3BMeiX6QdkfhH5lx8amD/F
         EXV4BULyrIRgSVKen8jp5h3mMRH+k0zgvZpvXo7AedGLMUMQPzJ/l1SBHp1t8MZK3W3+
         f1/A==
X-Gm-Message-State: AOAM530wW3Avp0p1ukoBlbgYE5unfeB0nGmh3R9baipC6qLAMm6AaxU4
        +mQuqt9r/zbO4WhzEkoXcDl++Nw2FNVQw6r2yGalUFOPTMg=
X-Google-Smtp-Source: ABdhPJxI+z0snHnBf/Eaz2ZZc3jiRyd33cbbpdKNUYxpFQhigJqknYAUGo56NcUOO8dLH+cZ0kBsp+5vp5BwrNLulUw=
X-Received: by 2002:a17:907:6eab:b0:6fe:b5e2:7b0e with SMTP id
 sh43-20020a1709076eab00b006feb5e27b0emr48517985ejc.736.1654018217174; Tue, 31
 May 2022 10:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220427144620.9105-1-pmalgujar@marvell.com> <20220427144620.9105-2-pmalgujar@marvell.com>
 <CAMRc=Mf91eMF7D6CRtA8-HQ7pdtP343WUGhLG4qti_9zJF4ELQ@mail.gmail.com> <20220525131738.GA10532@Dell2s-9>
In-Reply-To: <20220525131738.GA10532@Dell2s-9>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 31 May 2022 19:30:06 +0200
Message-ID: <CAMRc=Mds_cKkdDJUV5h7prfPg-rBms33uFad_S-zzPaws=qfLg@mail.gmail.com>
Subject: Re: [PATCH 1/5] gpio: thunderx: avoid potential deadlock
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Richter <rric@kernel.org>, cchavva@marvell.com,
        wsadowski@marvell.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 3:17 PM Piyush Malgujar <pmalgujar@marvell.com> wrote:
>
> On Mon, May 02, 2022 at 01:18:49PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Apr 27, 2022 at 4:46 PM Piyush Malgujar <pmalgujar@marvell.com> wrote:
> > >
> > > Using irqsave/irqrestore locking variants to avoid any deadlock.
> > >
> >
> > I see you'll be resending this anyway so would you mind providing an
> > example of a deadlock that is possible with no-irqsave variants?
> > Thanks.
> >
> > Bart
> >
> Hi Bartosz,
>
> Thanks for the review.
>
> Please find below the issue scenario:
> In the case when HARDIRQ-safe -> HARDIRQ-unsafe lock order is detected
> and interrupt occurs, deadlock could occur.
>
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 5.18.0-rc6 #4 Not tainted
> --------------------------------------------------------
> swapper/3/0 just changed the state of lock:
> ffff000110904cd8 (lock_class){-...}-{2:2}, at: handle_fasteoi_ack_irq+0x2c/0x1b0
> but this lock took another, HARDIRQ-unsafe lock in the past:
>  (&txgpio->lock){+.+.}-{2:2}
>
>
> and interrupts could create inverse lock ordering between them.
>
>
> other info that might help us debug this:
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&txgpio->lock);
>                                local_irq_disable();
>                                lock(lock_class);
>                                lock(&txgpio->lock);
>   <Interrupt>
>     lock(lock_class);
>
>  *** DEADLOCK ***
>
> ==========================================================
>
> Thanks,
> Piyush
> > > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > > ---

Thanks. What I meant exactly was: resend it with that info in the
commit message.

Bart
