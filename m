Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4156C5AA8A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiIBHUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIBHUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:20:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92894DF00;
        Fri,  2 Sep 2022 00:20:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x5so842999qtv.9;
        Fri, 02 Sep 2022 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0ztFA8rsuY2vloiv1HdRcTr25R2NxgCLNPLghGc91Mc=;
        b=ItdHuTR9MapOms5sjGNpCkLjWOb+4vrB+PijQJWFD22X+KE4TdlFV7IhXu6ZNfqMv+
         DJHbv3oATrDqCJZZ2Yg7IJOBk2/KKByM67vW09IoR4lumCwo0uTWEFJzVE2lhqaBEoIY
         rbxH//7bPev65d0IFM+vJmhYPM+YXfUGniRBaR/0FfKtNZ7TLewwo41JAHgTKZBzXbJ2
         0EHv3zMxTwxCm4AfGkWAZ6XbboM/4yn8mCDJgK4dn0eVD9QSkEJnyWGcLZZqk5eU640V
         E5fr1bdwhlmHJ67XVbOstsYNteZphRUFcntHDMvpjEacSphh18dPitnwP75C21Qz8DNG
         wUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0ztFA8rsuY2vloiv1HdRcTr25R2NxgCLNPLghGc91Mc=;
        b=gzSKs8cNMaOq4KOwYR44CTGu5EkbJWPjP4GQCBYtY2YxtrFh7SqIb0UlmcgLqy6sf6
         fqOlimnEC13NvzUGzmScb5SUXskHRUwaHfTtpbs7sY5Gdulbh+yYxnh8gFQeL9MO+UTh
         BaH3IQIybjXCsmtSeqoxz7gxUZhcqJGkH3c1venJwKyXn6bKUJJrvBzbK++VZXwJwS7k
         oqlYBMIjIzmxbBBKXW+soRb/a0Gc8J1YwJaEZDCbaR/7WnO5ODEmPDkNKBNsfghcmOxX
         xpvX5mtfafl0giay53AplBzv4sBL8vGOTysqnODRZSSikmh2IwVsvTtqDBfhgAuIAMsR
         Jc0Q==
X-Gm-Message-State: ACgBeo3+5BmMIwvy350I8szapmXLlkz84RZ9J/DEwTcDyUloOZYBTots
        3ABaXmb5rneBiRVNlET3YsaOLcs6MurZXRlF0xY=
X-Google-Smtp-Source: AA6agR4mVHw0REbRDals331L5SGq4UqqF6ji289fQzeaZkZ17hBU/O0z3ZAWFjnXzie2LBfMTWQqCAAE0IYEXONvJUY=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr26872765qta.429.1662103244912; Fri, 02
 Sep 2022 00:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220831055811.1936613-1-s.hauer@pengutronix.de>
 <20220831055811.1936613-2-s.hauer@pengutronix.de> <CAHp75VfbNespbCZ81xcvA7zsr3K8nbb3LBrpXOjH04R-hEFumw@mail.gmail.com>
 <20220902071601.GU24324@pengutronix.de>
In-Reply-To: <20220902071601.GU24324@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 10:20:08 +0300
Message-ID: <CAHp75VchGZV-cPzZnDRBmd_+jEiRap7oA2oFz6w8dBw=7LNtbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: Add gpio latch driver
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sascha Hauer <kernel@pengutronix.de>
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

On Fri, Sep 2, 2022 at 10:16 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Sep 02, 2022 at 09:42:21AM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 31, 2022 at 9:02 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > >
> > > This driver implements a GPIO multiplexer based on latches connected to
> > > other GPIOs. A set of data GPIOs is connected to the data input of
> > > multiple latches. The clock input of each latch is driven by another
> > > set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> > > 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> > > are output only.
> >
> > So, this is for only one type of latches, now I'm wondering why
> > gpio-74xx-mmio can't cover this case (with probably small
> > modifications to the code)?
>
> gpio-74xx-mmio is about latches connected to a parallel bus. You can
> access the GPIOs by doing readl/writel operations. The latches are
> driven by the bus logic and likely an additional address decoder.
>
> What I have here instead is a latch fully driven by GPIOs.

But this reminds me of some kind of gpio-aggregator with a specific
layer on top. To me it really feels that we are (semi-)reinventing a
wheel between the lines...

> Yes, with enough force you could implement it in the gpio-74xx-mmio
> driver, but that wouldn't be mmio at all and likely completely different
> code pathes.

Got it, thanks for elaboration.

-- 
With Best Regards,
Andy Shevchenko
