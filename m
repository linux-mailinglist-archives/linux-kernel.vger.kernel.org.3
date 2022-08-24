Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6959F74C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiHXKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbiHXKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:19:11 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB975383;
        Wed, 24 Aug 2022 03:19:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id b2so12493708qvp.1;
        Wed, 24 Aug 2022 03:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=A8eOmbFD5R8cCPQMqUHoUv9zLlrHEiXgVk4D0zzGcsI=;
        b=FrP22utlBCXIaUoML5oy+pY7TkvNuAbuSmyroEsUl5/4L7p7ScDLYEI+RhCoD72CfG
         exFKUJ1za6KrKpFJaNOOM/MlQ4L2CqK6Lu9kTaG4EQjGf5h+Hr3m6vf1yanFDAehErlc
         ZM/CiuwBKG4V7fNfqVYcLqMYOxtRi/S0lBiqxhEzv2KHSQmZ3pCRQdiM2BA32SN7ssTG
         jHKuubUe3zJwMfpuxkFv5vK0/UUKZsWfskBrbcxORHyPhZsobFBz76a9gBsdBJOP+gad
         CItwRf63cA18yS02y0nIeUKuPQWZg4O6LNFnqQyiBqJ9OorGdhbdZRKcK4Lkhpj88xC6
         /Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=A8eOmbFD5R8cCPQMqUHoUv9zLlrHEiXgVk4D0zzGcsI=;
        b=PELL44bLrSJ1Ljt7aBL0c2MECXGexYlBpsv93Q/3Tdu6D37NgXS7iOuN+h3tzt+2On
         Jha4IAIjWKDN0uzCIXBR3CJg5PfJUPhVNCH09JBUL/ER6uofE2UTpakuv0OW9mM8n3vb
         vZZCP5uus0Thi3SN6BVwccVBr9HT99+tlr9aXxBTn0WntNma5mhglvfsRZAloSsuSZv6
         QbcrulsXIQVl1vE5Ay/p8Rzo+mBGnHctHRbdDAetkLPf6VKmYyHWTSNx+4YKcOeFB0k+
         8BetTSqd0tDpDtluUnNOXXXRuPNaro0yBpL04cEl/75k1cmteUdpakng1b2fMWwimhFD
         q9RQ==
X-Gm-Message-State: ACgBeo0El8ZtuM+2Agmz2mB+QWN5KC+8+uar95c1UQOVU7bS1a7ulRHh
        OcCUjaFZxqOfmv2gtYsnMakGk3gUZ1NRxMXsrvA=
X-Google-Smtp-Source: AA6agR7dP4gEfsC9IFZ9dWOgXfWlpFKV76iGJHBCOdyB6C2QNPjBsdO/YLZXptAD/FtgNrHsTL8t3BHL+LNLzV9OWNU=
X-Received: by 2002:a05:6214:29c2:b0:497:8b2:442 with SMTP id
 gh2-20020a05621429c200b0049708b20442mr5044808qvb.97.1661336349050; Wed, 24
 Aug 2022 03:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-3-jjhiblot@traphandler.com> <CAHp75Vdu-EJRRxkK7+TfuE=zEDkJye1QCXSB+cDLrqxuykJjkA@mail.gmail.com>
 <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com> <20220804210412.GA30210@duo.ucw.cz>
 <0663c616-97c8-444c-f390-275fae402453@traphandler.com> <CAHp75Vf1cT81cx38VQ80PbyG9i9xbiegMnQoMWwZEZf+7fWJuQ@mail.gmail.com>
 <5bb9955e-4c2f-ca55-0e77-c082a868371a@traphandler.com>
In-Reply-To: <5bb9955e-4c2f-ca55-0e77-c082a868371a@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 13:18:32 +0300
Message-ID: <CAHp75Vc5g0OL6YUY2WsUZA6bovB+sdJE3Bv3SWp-1pRh3kyiow@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED controller
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

+Cc: GPIO maintainers

On Wed, Aug 24, 2022 at 12:58 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> On 24/08/2022 10:55, Andy Shevchenko wrote:
> > On Wed, Aug 24, 2022 at 11:39 AM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:

...

> >> - with this approach, every time a LED status is changed the whole
> >> register has to be sent on the SPI bus. In other words, changes cannot
> >> be coalesced.
> > But isn't it the same as what you do in your driver? To me it looks
> > like you send the entire range of the values each time you change one
> > LED's brightness. I don't see any differences with the GPIO driver.
> No. The TLC5925 driver updates the register asynchronously: the cached
> value of the register is updated synchronously and then it is
> transferred over SPI using a workqueue. This way if multiple LED are set
> in a short time, the changes are coalesced into a single SPI transfer.
> This is however probably not a must-have feature.

Ah, thanks for elaboration. But GPIO supports this type of ops.

And the more I think about this feature I find it more harmful than
useful. The problem is that delayed operation may take an
unpredictable amount of time and on the heavily loaded machine the
event might be lost (imagine the blinking LED informing about some
critical issue and it blinks only once and then, for example, machine
reboots or so). I believe we both understand that for the GPIO is a
no-go feature for sure, because sequence of the GPIO signals is highly
important (imagine bit-banging of any of the protocols).

> >> I don't know if this is enough to make a dedicated TLC5925 driver
> >> desirable in the kernel.
> > I don't think you have enough justification for a new driver.

After this message I first must withdraw my Rb tag, and turn my voice
against this driver because of the above. On the contrary we might ask
the GPIO library for a specific API to have what you do with the
user's consent of side effects. Linus, Bart, I'm talking of the
delayed (async) version of gpio_set_multiple(). But personally I think
it's not so easy to implement in a bugless manner (because we need to
synchronize it forcibly at any time we call another GPIO API against
the same chip).

Summarize this:
 - you may add a compatible string to the GPIO driver and DT schema,
and we are done.

-- 
With Best Regards,
Andy Shevchenko
