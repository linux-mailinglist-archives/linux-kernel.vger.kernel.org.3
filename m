Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6256480E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGCOY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiGCOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:24:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C714EB07;
        Sun,  3 Jul 2022 07:24:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 64so3164830ybt.12;
        Sun, 03 Jul 2022 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cS/cfinqeIf5OIiB7qn+MoimwKg2hSamwBWQECwEou0=;
        b=k26sRRdowdDjbK9ACcwG4ZFIMKPQmgRpyi+IqWhLBeOom37kXWkG3ZGEydAmKxpGJJ
         MdOh/r1C0/46vXMFxmwxE4aBG5l+LM12ZappnFADiBXbZdOz8aaRaQCoUBHsOUvmIjgC
         a0BbUGaZDOpEnYDQCavA7aF5vYYiQYXOJVSinxCM/GK/tv4Apcz8UmyeGBn7JVF89jM9
         RxssJHY4hpSxGVOlq/pajIUruA9p258ebRmLusXwOhTQNUZ9FjhUPtFt0kr7U9TNux6d
         glL0l2bXT/Ss7r3tXw7f/V5kICpvEZBdw4ZH/ntmflBw/UNzlhTS5gJHy/1l56b+J8Re
         tvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cS/cfinqeIf5OIiB7qn+MoimwKg2hSamwBWQECwEou0=;
        b=fFtDtYV2sSOFTyuA1ID5RKJnQacq/AIIi8k/2G1sXmJafh9dEIpNYKUVnkYea62epx
         CwFVIVVWc0jKrHLiWZLq0pMF4FaR3D4q02+6NgoZD579yU4Ma/nBswbtZAfzbUdJ1v3T
         PVGgNniwxZeIQXwwIU9neEKfPDQm1Hp5l7wXewfA/+kKlKZG+ZrYiiRAeI9iufDXlnLr
         FpyCjahBreSbODFtVQSbpgHUWg5JZ3OCtl2wNRsrjH5DtdvsgOao6DeiT/p6EWa4Mlsu
         mKTW2VM8P8F0P4aC+53iKxQaCeUZYK/Ce+KVKKu9S0Xo1ozyn6Lzx/2aKzdO8Su/2ooo
         EoYg==
X-Gm-Message-State: AJIora8Rgd3CyO7iyL633wKx3BEeQJwDxJg5fyZ4fW2cIkCCvzfk68rl
        1/W8m+ny01WKOp2xw1nzId+GMfOhP/sWt4tMqxI=
X-Google-Smtp-Source: AGRyM1tV0QF2GHqsh8QCRW+pMlSe4eewDy6SMUl9wil0ZFQkdqIFbYQpFo4A2JOY1nqrrsrtyq9tycg1XRzexc10SPI=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr25810818ybu.128.1656858293000; Sun, 03
 Jul 2022 07:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com> <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 16:24:16 +0200
Message-ID: <CAHp75Vc30zZL7LLg6zn7VnMARMOKsYo421KVMDu7RGp4QCtcXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Sun, Jul 3, 2022 at 1:11 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Some GPIO chips require a custom to_irq() callback for mapping
> their IRQs, eg. because their interrupts come from a parent IRQ
> chip where the GPIO offset doesn't map 1-to-1 with hwirq number.

Don't they follow a hierarchical IRQ domain in that case?

And to be honest after the commit ef38237444ce ("gpiolib: add a
warning on gpiochip->to_irq defined") I have no idea how it works in
your case and also I feel this patch is a wrong direction of
development.

-- 
With Best Regards,
Andy Shevchenko
