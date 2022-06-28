Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4055E407
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbiF1NGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbiF1NGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:06:34 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3260F2DAB0;
        Tue, 28 Jun 2022 06:06:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id d5so22114077yba.5;
        Tue, 28 Jun 2022 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcqCByKXgARY2vD4eS8cKcF5a2ZWnhYeLVSdnQBtrWc=;
        b=WPC/xQpcR/kWgRayCE9njWpVeHlIkS0WnoUfidGH6VahgSUp68zySbYIT8TWDbXNZo
         qVvQfEMHlfwrPrLaD2BD7V8MWPjnpT6Xa/6EoBiIlYAbH85viZZRy3us8vavFog5Ax3p
         dyDhHBp7K/5kVNm+2ZoszS/3S0Fa/dBHR3kGJh0gx1VPMB+Ip/GgmstjjCbP3qgLnT5j
         dn1JZ/JVq68huooyuuY9F7GgAjrN4U/6lwMN7FlFPE0jpVOw1HGPPFZ11jJ/2s9vv55m
         WZjWTxX/+4MLEi1KJSbXD1iryWayU1eXW9QSb0YGVfy9LsBXZpvCmVvfSbb/qNT31cIB
         +s9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcqCByKXgARY2vD4eS8cKcF5a2ZWnhYeLVSdnQBtrWc=;
        b=arJyC1XUaYbGwlVQKfVxMmR+klucocQthPcE0OWk/7xlABl5X7jXR7FDfQBqUI5eg/
         iZIlBmoLbUXg7bHvzA2einsjpMIG2ADVdfVUIu/NmMsfFvyDSUWukGE7zbyGgKhBD5zh
         a4HuDmYJE3GWnpuezbnr0OAjLQwmUoGNLAd4F9z5PQsLm853c1N7CHVHAv0Oj2Jdyfp6
         81vNwJWWDYCor57sheQiosJOULhsTU0dQcf/S0hFc7fVRQD9BigQcvQPxdQhq2PYTq4J
         VjWOSGsFp4Q496hxvnpOeNzbjeoPxQnDqHrXw4Vb9uEcYAvqTQb4nz/J4y5ciKuAZUeX
         tp6A==
X-Gm-Message-State: AJIora/EWdquI/9kspBMeFFr3pdb4TyGSwUQNZNoNXxqqoZYhBEOxXto
        uKWRH66iMix9YIJK7zMtyNXz13Qeu0xMdyYT5xM=
X-Google-Smtp-Source: AGRyM1tpwUDGq+GiED/Gpuk7Nl9aPYbFo0EksSIRGjB0oRbwmxWCa4cRBEiaaJjBESbjijRt4bGttKp4cS2B9eZ+nFE=
X-Received: by 2002:a25:187:0:b0:66c:eaea:71ec with SMTP id
 129-20020a250187000000b0066ceaea71ecmr8966694ybb.570.1656421592101; Tue, 28
 Jun 2022 06:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220609162734.1462625-1-jjhiblot@traphandler.com>
 <20220609162734.1462625-3-jjhiblot@traphandler.com> <CAHp75Veurvhxi0Pg1Sjxav+3XpDTVOdan8WFFmZmdhJbZJiCaQ@mail.gmail.com>
 <20220627084909.GA15970@duo.ucw.cz>
In-Reply-To: <20220627084909.GA15970@duo.ucw.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 15:05:55 +0200
Message-ID: <CAHp75Vc5PKay=OAcp+_9OZVpVAEketLbyJ5z8JJwEJXwY7CFvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] leds: Add driver for the TLC5925 LED controller
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:49 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2022-06-09 18:57:24, Andy Shevchenko wrote:
> > On Thu, Jun 9, 2022 at 6:30 PM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:
> > >
> > > The TLC5925 is a 16-channels constant-current LED sink driver.
> > > It is controlled via SPI but doesn't offer a register-based interface.
> > > Instead it contains a shift register and latches that convert the
> > > serial input into a parallel output.
> >
> > Can you add Datasheet: tag here with the corresponding URL? Rationale
> > is to get a link to the datasheet by just browsing Git log without
> > browsing the source code, which will benefit via Web UIs.
>
> If you want to add datasheet url, add it as a comment to the source,
> not to the git log.

I don't see anything wrong with having it in the Git log. Do you?
(Note, I'm not objecting to have it in the code at the same time)

P.S. Can you review the three patches of the series [1] that have been
submitted day 1 after closing the merge window? It's already a few
weeks passed, or even months if you take into account that the top of
that series has been sent before separately.

[1]: https://lore.kernel.org/linux-leds/20220606164138.66535-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko
