Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045BD500D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbiDNM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243172AbiDNM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:27:04 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3A2982A;
        Thu, 14 Apr 2022 05:24:39 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id t2so3367637qtw.9;
        Thu, 14 Apr 2022 05:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gM58XwROhm0N00VwVwbh3pdnwwjzwvbBSho9O6c+es=;
        b=7WCmfFuA750B4xPaPS6DTWtwympSalaiD/+09mOiyo2GEJwTcgACuB+dCK3XdasEVf
         SpsTuSuQzC8fzFhQYhOoTgaHfdHMTzcYG1zW2sf8UahUuDLnlpX4+2mjcHPNd43eqJNW
         /c9Ci4wnnB+da1eBhqf/FL3/B0QOd+3QsZTf3SqGWsPXfb/gayVZioVF3Oggf2tVdLRz
         ML/6C2nvwC+XBn3oZH7a7mKXOJ/NMKARgYpGFLOfgzvXgC+teym1edFRrDlTQyg9gLTJ
         2qV5tOeDiBsVeP8K+Flef+ub/HsB02iAvB6pGZSoohu9xtSraa4xo2a7NIbNY2koG+Dy
         0odQ==
X-Gm-Message-State: AOAM532AkFS3gldgN/rj6uwWV/rj2nh2SIYj0it8IfQHRToSh8ayASmy
        apXr7OgpgQSRvPaiarNu6YZ9gQU364fIVw==
X-Google-Smtp-Source: ABdhPJx7ar/rr7wqnLhBaxquFM1CnBd9d3LX/i3AOdLI/TlnKnl+YMpLEFGRuz1l4jX34Bvk9thZfw==
X-Received: by 2002:a05:622a:256:b0:2e1:a01b:a538 with SMTP id c22-20020a05622a025600b002e1a01ba538mr1510546qtx.167.1649939078036;
        Thu, 14 Apr 2022 05:24:38 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id g17-20020a05620a279100b0069c29caf433sm937511qkp.73.2022.04.14.05.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 05:24:37 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id t67so9106053ybi.2;
        Thu, 14 Apr 2022 05:24:37 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:63f:8c38:676c with SMTP id
 c4-20020a5b0984000000b0063f8c38676cmr1552530ybq.393.1649939077194; Thu, 14
 Apr 2022 05:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220408122636.505737-1-valentin.caron@foss.st.com>
 <20220408122636.505737-4-valentin.caron@foss.st.com> <CAMuHMdWD8fxeqPUaT_CwnYdq02aaTsnQM_G-YyOGWooS5epCeQ@mail.gmail.com>
 <b29dda44-1596-0456-7331-00012d740f06@foss.st.com>
In-Reply-To: <b29dda44-1596-0456-7331-00012d740f06@foss.st.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 14:24:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVyScZaYPcRqcobnaC2LAdfV80KXzCnxwfBE9-Q+72OYQ@mail.gmail.com>
Message-ID: <CAMuHMdVyScZaYPcRqcobnaC2LAdfV80KXzCnxwfBE9-Q+72OYQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] serial: stm32: add earlycon support
To:     Valentin CARON <valentin.caron@foss.st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Thu, Apr 14, 2022 at 2:17 PM Valentin CARON
<valentin.caron@foss.st.com> wrote:
> On 4/11/22 16:59, Geert Uytterhoeven wrote:
> > On Fri, Apr 8, 2022 at 3:14 PM Valentin Caron
> > <valentin.caron@foss.st.com> wrote:
> >> Add early console support in stm32 uart driver.
> >>
> >> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> >> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> > Thanks for your patch!
> >
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -1264,6 +1264,12 @@
> >>                          address must be provided, and the serial port must
> >>                          already be setup and configured.
> >>
> >> +               stm32,<addr>
> >> +                       Use early console provided by ST Microelectronics
> >> +                       serial driver for STM32 SoCs. A valid base address
> >> +                       must be provided, and the serial port must already
> >> +                       be setup and configured.
> > Why do you need this parameter?
> >
> > Given this driver uses DT, can't it figure out the serial port address
> > from chosen/stdout-path?
>
> I took the example of other serial drivers.
> Both methods work (with earlycon/stdout-path and with
> earlycon=stm32,0xXXXXXXX)
> but your right, the second will probably never used on this driver.
>
> Should I remove it ?

I think you should.  The less platform-specific kernel parameters,
the better. And the less bad examples to copy from.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
