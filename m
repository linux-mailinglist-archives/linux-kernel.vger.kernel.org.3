Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979AD56C1B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiGHWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiGHWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 18:02:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D55784EC2;
        Fri,  8 Jul 2022 15:02:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 6so11046099ybc.8;
        Fri, 08 Jul 2022 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2u1zHtkYnpDwEfAUW7nEKjfU14t5rnPhoACc6h227U=;
        b=bBTRJIORm9ieZSXfdT/Uuorn3jS1wFhkpQJFg1fmR+fPtqupYIuo/E8K3WFpCxWHcF
         SiiAyqKSXPGs7s0ZrQUnqBXldQt4/f89C5Rbxt0doPqXT36em19NXK/eD6Ix7QAJ6ULP
         e74ofT7y4eKSIcrnxjS/NEI0Gnxee+d2Ozkqv9Dw/IsYQNwevi2urzCKKv9+nXET/iDA
         Sp9NBcQbD5XS3PqCZRkopcLEZ9uD3edUWd0YONuQYZdZx8smTbtN8omFQiubQi6gCJGx
         MHGVlDINQRhX0/5v3l+NMVgNTDD3Or0LpCwWPUQKtQ9yM60sila4OK50/uwhpLtFisjv
         pszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2u1zHtkYnpDwEfAUW7nEKjfU14t5rnPhoACc6h227U=;
        b=wQ0kLAE4mQWT/bpk3knUWH0y+faIgdunbuEsZBhiLXFeg/q8tcV1ToZWUfUtpf2px9
         6Y0EdMqVWQMjHVvIDdhDU682mzUlP39ULXKTnQNh9nXzHT1MgmvMEoCqgSFsj0PWrQ2F
         +xfMiTUVhgwDFMFsSrDFFp9btX30ZDGoN842RIQEml0soc2DHQMF3VKX7FGTTuiZ2IGR
         XXxZZ72FsJmTpVulnoMtwwgftn6zSd7bTJzY4kqKANO0g/EGAbkA1XNbdorsNwREnOed
         AS1UFIo8p0czzW1u03vyuWMq1zIEN/iUOUZu3D/asouqQ8yTl+/9lx2WDJuWgDCbRUTA
         DHxA==
X-Gm-Message-State: AJIora9UvkZCEofnFHyej2SGsNMSZ/SwNDe94XLKn1nt8f0FvV4IG0k2
        OYtjYGweNT452MQAySYlULnprSoj3sSbKBOZQU4=
X-Google-Smtp-Source: AGRyM1s6L9VAdS8oWVJev1EU+2rONvuvH6Uios5YxmkrJYv/y64Suc0TdqrUrQNbwvydktEtdaKIXKuuaCzCOpmpBc8=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr6096119ybu.128.1657317771326; Fri, 08
 Jul 2022 15:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
 <20220708195510.2951661-3-horatiu.vultur@microchip.com> <YsiQhA9pHaX4s3R8@colin-ia-desktop>
In-Reply-To: <YsiQhA9pHaX4s3R8@colin-ia-desktop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 Jul 2022 00:02:14 +0200
Message-ID: <CAHp75Vc0EasS2Z3x=cgTv==osXprPU3Zkc-Q9DMf4BMz2p6oLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: ocelot: Fix pincfg
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kavyasree.kotagiri@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
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

On Fri, Jul 8, 2022 at 10:17 PM Colin Foster
<colin.foster@in-advantage.com> wrote:
> On Fri, Jul 08, 2022 at 09:55:10PM +0200, Horatiu Vultur wrote:
> > The blamed commit changed to use regmaps instead of __iomem. But it
> > didn't update the register offsets to be at word offset, so it uses byte
> > offset.
> > Another issue with the same commit is that it a limit of 32 registers

it has a limit

> > which is incorrect. The sparx5 has 64 while lan966x has 77.

...

> > -             .max_register = 32,
>
> What happens in /sys/kernel/debug/regmap/*-pincfg/{range,registers} when
> there's no max register?

Good question!

> Should it be this?
>
> struct regmap_config regmap_config = {
>     ...
> };
> regmap_config.max_register = info->desc->npins * regmap_config.reg_stride;
>
> >               .name = "pincfg",
> >       };

If regmap configuration may be const, I would prefer to have a
hardcoded value and different configuration based on the chip, but if
it's not feasible, then this could suffice.

-- 
With Best Regards,
Andy Shevchenko
