Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142235805DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiGYUmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiGYUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:42:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0E5639D;
        Mon, 25 Jul 2022 13:42:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c72so12589550edf.8;
        Mon, 25 Jul 2022 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CzlvqtZ4sW/ElEWpOjSICTJbEHD0aNQ9entd4nvbv7Y=;
        b=kB7cXd7d/JNiJw4UHUCysp+SCyNBoKLAZbtLOINNgPIiTgSRGrS1D/B1btIP+jplUD
         hLfdMsEBa6uw9G0hc/4wjTVCyiEZmU8GPJG6U0EgDCyYgbq/k4EX6AfbTnZ3vez6my/S
         FjAdUeKOty6/PS30jBULBSk9jKE/DzPejB6hjxSWI16UhbMkGoqUy6fFJlMW5cxl7GDq
         hdhGJ3sMyv1RP7LLux2UpX25pTDj0FEwd9nuxuLRYd3YIPWdqogqPeQbx5UR4GQybDw6
         rPoTr9e3Ymeh8CsUpWvKGaV6wPrIfEh5jftOQnAOMUtGNfYSVUkMS4/Tfk+Qpb9uvmqP
         kqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzlvqtZ4sW/ElEWpOjSICTJbEHD0aNQ9entd4nvbv7Y=;
        b=mOeRTn9nRpWm53OqHw2Ul7pf4msH1B2E1OyhxPlz7KHEPQhgfmT4i+S0e+9UZattqm
         2F+pD8PCKiLuykE4GPhPEzZ4AUxPy8o6rSvKq7cu7V/L8ggJw6pb69d2VRl34Og6CfmX
         gA4z186sizg8Qircb+IFivf2nB+e9rw8lv6SlgYsXVit0swqigAQThc7TPIFWoUqWsbP
         ks2Lx0H7qIQHT8vf9/5F7EclCc4OQV/RBxAgCYHBXhUuzQypt2nxc1om/h/OG9mAO77a
         C7T21BcyTE5invgUtlKvqwTjtDZKsZpZdOt7p5XBUBaDxPErbeVNelvFt/LNM33Xi1sQ
         23ig==
X-Gm-Message-State: AJIora8kHzTtJb3ktwo+lS9yYJNhaDu4w8UDFEtz9sLZ7M0BzgdvdfRe
        9Hyuiw9Fxyj2YJXO6jJ/umGZTCoGKpNYa2EEX5s=
X-Google-Smtp-Source: AGRyM1sJVhjzVOjASQIpOG0za4qTj18ieNxKgJ9b/Q8r0g76G9F2hNLsedKENR4/v/5jin+j3fdwa6HLNrnYzJ7Ayg0=
X-Received: by 2002:a05:6402:34c5:b0:43a:8f90:e643 with SMTP id
 w5-20020a05640234c500b0043a8f90e643mr15004477edc.88.1658781727930; Mon, 25
 Jul 2022 13:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com> <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
In-Reply-To: <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 22:41:31 +0200
Message-ID: <CAHp75Ve4+r14dL3poOF7dCPMRgAe8etLeuBPNay0tkyNf97UWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 3:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jul 25, 2022 at 11:32 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jul 21, 2022 at 11:32 AM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:
> > >
> > > 74hc4094 and 75hc4094 works similar to 74x164 but has an additional
> > > storage latch associated with each stage for strobing data from the
> > > serial input to parallell buffer tri-state output.
> >
> > parallel
> >
> > > Add support for an optional strobe pin.
> >
> > Sorry for my absence of understanding, but why?
> > SPI has MOSI, CLK, CS, where the last one is exactly for that. No?
>
> Forgive me if I misunderstand, but if you use CS that
> way, the way that the SPI framework works is to assert
> CS then transfer a few chunks over SPI (MOSI/CLK)
> then de-assert CS.
>
> If CS is used for strobe, it is constantly asserted
> during transfer and the sequence will be latched
> out immediately as you write the SPI transfers and
> the data is clocked through the register, making the
> whole train of zeroes and ones flash across the
> output pins before they stabilize after the SPI
> transfer is finished.
>
> If you first do the SPI transfer, then strobe after
> finished, this will not happen.
>
> Then it should be a separate pin, so this doesn't
> happen, right?
>
> Yours,
> Linus Walleij



-- 
With Best Regards,
Andy Shevchenko
