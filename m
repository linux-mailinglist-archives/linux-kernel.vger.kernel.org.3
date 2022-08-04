Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51FA58A23C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbiHDUl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiHDUlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:41:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCB1D0C5;
        Thu,  4 Aug 2022 13:41:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i14so1390828ejg.6;
        Thu, 04 Aug 2022 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DgPQGcLCx4o5iwg9jMEpN6NueK/NQSopmOAMiTK1bZU=;
        b=dD36ISaDTLRolSwmb4G+3fkwRUURHTNxqNY6ZpN8HlLPjYJPx4fE6UCbU8DYglqVKZ
         lpr3qAqtIU8+hdtCreMn+nrnqXml//PIMLzufzHteWcdkvezExwGCChgyvlx2NC4yrvG
         EAZ2WBOScEoJsMOrlklU0BUtvlzoZXE84nGcwbFAKYPvLCu66C9Hh9LD20f28G4RmmQE
         9GsLMMOUVAvXTNSBYvCif5D8Lbnp6gtYnWxzogiuSSEmU5N2OYEfnPqsJRRI2beLo7NT
         stOvwh8AazmbD4YpM0E1xp5+N/Ua2Zl0AHD0Zl7/rY1Rcyt3wd3uZ9NerGpJ+I8J5dDJ
         TcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DgPQGcLCx4o5iwg9jMEpN6NueK/NQSopmOAMiTK1bZU=;
        b=y2UoYMOpEKKi+Wkjpd2/c2R6hPbEwo2jo7WqweovZlNalbrOMOe7q1zijn+fjDKOak
         qxbEzDNx+Td26p21VOGbXrN6g6nVosIWjeFcKAPnwhmf5wbhlpbWVsw9FyeEo45Lkz8R
         gyXdZPHKnEhn7ZIMnrm4cvrxeSiGDowUfrPR0RI3K71TsAM0efGau2nGmS20RWLymr3e
         Gsscbx0DVZXmcZFgolphJ0QW7UkR3aHl4dvdfCFLl90/Fx64IrgPaDRYU6Rfd3davrN8
         S2sjVFoe5z6kGyf8bSMNQMW6U7KLzL5zdIx268xzxVHXm7uJAO1htMDYUOnpHRZJnKSn
         1COA==
X-Gm-Message-State: ACgBeo2Of3OvNIOyw25CDJVvPLMgXfVfuKvG/UX2WUtqdYF7+CEDrXDF
        o7JY6sY/NRtoxC1Y7YlU2VTZ1b823D39ABGJO6k=
X-Google-Smtp-Source: AA6agR7JWDOq8bOOvnUuAID4aBlwLQ91blsIUwrbX3ClUsXNa8bPtDlMZF2DVJjA7eC2mZWrngDj9GtNuvnG3yshSUc=
X-Received: by 2002:a17:907:2dab:b0:72f:f7:bdd6 with SMTP id
 gt43-20020a1709072dab00b0072f00f7bdd6mr2660728ejc.330.1659645681595; Thu, 04
 Aug 2022 13:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-3-jjhiblot@traphandler.com> <CAHp75Vdu-EJRRxkK7+TfuE=zEDkJye1QCXSB+cDLrqxuykJjkA@mail.gmail.com>
 <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com>
In-Reply-To: <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Aug 2022 22:40:44 +0200
Message-ID: <CAHp75Ve9tug8HzYXx+9HU09=Bae+=M24HwH1n1XOpL=RsUOpQw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED controller
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
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

On Thu, Aug 4, 2022 at 10:23 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> On 31/07/2022 21:28, Andy Shevchenko wrote:
> > On Fri, Jul 22, 2022 at 10:14 AM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:
> >> The TLC5925 is a 16-channels constant-current LED sink driver.
> >> It is controlled via SPI but doesn't offer a register-based interface.
> >> Instead it contains a shift register and latches that convert the
> >> serial input into a parallel output.
> >>
> >> Datasheet: https://www.ti.com/lit/ds/symlink/tlc5925.pdf
> >> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sorry for my slowpokeness, but I just realized that this driver may
> > not be needed. What is the difference to existing gpio-74x164?
>
> It might work. However it might not be as practical and efficient as the
> dedicated LED driver.

I'm not sure what efficiency you are talking about? Using LED GPIO +
GPIO? But the chip, even if marketed as an LED driver, might be used
not for LEDs, right? Technically speaking it's a GPIO with powerful
(by current sink) outputs. With LED + GPIO you get flexibility to
configure and describe your system exactly how it is designed on the
PCB level.

Note, we have already examples of other chips (like PWM) being used as
GPIO. In different cases in Linux we have different approaches on how
to solve that. In general, Linux kernel pin control misses some
special functions of the pins that may be assigned to them, while
being a simple pin control (or even GPIO expander).

> I'll give a try.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
