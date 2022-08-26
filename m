Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A45A23C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245360AbiHZJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245551AbiHZJLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:11:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B0D11ED
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:11:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d21so1994190eje.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EHyZfx9f30GYvoWGWrL1/d31tZ2j1jnuSexhcB0B028=;
        b=H4E8O/FZWenOUNLemv28DGZCdkWQLC1IHud8bPn1Zt5jaLswZKwZ4GWY7Kc+M5rne0
         tpnyVWL+K70RTKeP6Bi8rlmmmKFJoH2Mr2fMWrJ6n7yZt6SXe/jVP4fIlidg2biWXXN0
         Y8rKFfD9nTJwjEPs7e7k//u4sUtCL0mi9DCoCyyN5qUUwXJ1jiNv7YgjeURYOUbaviXg
         pa7H5LGylpM4+N7+ZDMbT9UESKOsCUS4rQUGz7Nal5bwJmhHY8tHsZ4YysgvyYJzqJQw
         7fqodXyghB4EZTmrIPPiAqhO3pE0vXrgJCRjYWOmJ8cPMSL+azcEJDf5q6VpSkMBPq7L
         rtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EHyZfx9f30GYvoWGWrL1/d31tZ2j1jnuSexhcB0B028=;
        b=2Uq+4p4rnEriuKjD7+RYTeV/BYHW0h0v4yPLAHJETkf6TxY+k3Kg9BNGKENcWMad7e
         mevReMgU2MmhzWo3ES2XcAsl4vVbibWnenXR5fmfmf5PA5ZWe6ug9uX135opD+8a9YnO
         PVQEx8khOOzbcHzeCQwhALufft+cx3FR7i98Bl8HYL57kTtMx85+bFIVH23AZVxdkH3W
         pR9/1g+7Q2Komlg0+cq2S0EaurJ19VI7Zy+M1M+5b+s1DAfoSPB6Dsod0DPNyXK4zYpd
         lWc6QCRupu2HZj9YVRWK8NrVxVEzvvwxeXds8ET7jadXeN8NAY38JxNTsJB6DiWe++2n
         2Y+A==
X-Gm-Message-State: ACgBeo0kRQftw1fxtyfcUDumSXc5VLBKLlHE9MEugOdWqqjO5bUdCmUw
        QBuPey/NbbvQZAdBpkDChezYDMxc5xgOeu2iZAexvw==
X-Google-Smtp-Source: AA6agR5U9DH1rbFPNvHxj4z3/uS3uREKQVB/qGqSV8z1JZu3or4hPsIAC6EDv2Kf4X2wkJYTbMZlZ+2xYACgMT5wbTI=
X-Received: by 2002:a17:906:478f:b0:73d:7919:b23 with SMTP id
 cw15-20020a170906478f00b0073d79190b23mr4546844ejc.690.1661505073018; Fri, 26
 Aug 2022 02:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-3-jjhiblot@traphandler.com> <CAHp75Vdu-EJRRxkK7+TfuE=zEDkJye1QCXSB+cDLrqxuykJjkA@mail.gmail.com>
 <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com> <20220804210412.GA30210@duo.ucw.cz>
 <0663c616-97c8-444c-f390-275fae402453@traphandler.com> <CAHp75Vf1cT81cx38VQ80PbyG9i9xbiegMnQoMWwZEZf+7fWJuQ@mail.gmail.com>
 <5bb9955e-4c2f-ca55-0e77-c082a868371a@traphandler.com> <CAHp75Vc5g0OL6YUY2WsUZA6bovB+sdJE3Bv3SWp-1pRh3kyiow@mail.gmail.com>
In-Reply-To: <CAHp75Vc5g0OL6YUY2WsUZA6bovB+sdJE3Bv3SWp-1pRh3kyiow@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 11:11:01 +0200
Message-ID: <CACRpkdYs03HhXNwx3BmzrvNx6biGc1FPEUE2eoc9XZ-9O5M4Rg@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:19 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> > >> I don't know if this is enough to make a dedicated TLC5925 driver
> > >> desirable in the kernel.
> > > I don't think you have enough justification for a new driver.

One thing to keep in mind is that LEDs are MMI (man-machine-interface)
and designed as such, so small glitches etc are fine as long as they are
not noticeable by human perception...

> After this message I first must withdraw my Rb tag, and turn my voice
> against this driver because of the above. On the contrary we might ask
> the GPIO library for a specific API to have what you do with the
> user's consent of side effects. Linus, Bart, I'm talking of the
> delayed (async) version of gpio_set_multiple(). But personally I think
> it's not so easy to implement in a bugless manner (because we need to
> synchronize it forcibly at any time we call another GPIO API against
> the same chip).

I suppose this can just be a gpio-led using the GPIO driver
underneath?

If the usecase for TLC5925 is such that it is often (as defined by
experienced developers having seen it on boards in the wild) used
as a GPIO expander rather than a pure LED driver, then it is better
to have this in the GPIO subsystem in some or other form.

If it is always just used for LEDs then my first comment about
this being MMI applies I suppose. Or rather, ask the question
from an operator point of view rather than a logic level point of
view. (I think that was Andy's point though.)

I agree that we probably need some generic library to properly handle
the jungle of funny TTL-type constructs that is popping up left and
right for GPIO. Someone should ideally sit down and think about
what is common among these.

Yours,
Linus Walleij
