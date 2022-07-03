Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE0564A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiGCXYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiGCXYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:24:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805938A1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:24:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z12so1435890wrq.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SrqIW34AjFbZmMaYUREgVew+EkjbRkWGdQzlKX5pYM=;
        b=LtX4h8J6Zs44uTrB55u4wk7Bv0k+Fu8IQesnHE/LJDVzldiS1rLasN8CFxMk3rheJn
         dJJewgoCajXoXyPZcAZ7VZJ0o8zbgmxRlv1CTD+Z6u0avrH+CYwhY+NqdbT1bHyR398l
         dMXmiZ0DYmQ7KfjahfnncgOX2dZHhjnVK2tkwRDSIGD2PYACdL1PlGO1CEdRKQPXmiLj
         W8ncmw/ItuytTnhNuOSWwbt4OSfG3ILNrg6lQ3DJGDJTQCKOSwOizxPOzwhoxxbp9G5n
         hgfNlKiGcox8q8afEB0rRMX+jH163vwqDzHdUNdMcwr2zjcYvKRaa/gX9l1jbm58XKX5
         aygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SrqIW34AjFbZmMaYUREgVew+EkjbRkWGdQzlKX5pYM=;
        b=dj7Iyw1W5d/S9juwbzfLnnxQGjMq9WwJbkmaRXX6B2tc/nl21EXSA+3lPfPYjYloMS
         Cfa3XND8YeYb+uATg9bzS07Dpc9ZxkIspxHkvBtUxBpEQ5muYtIHZRBA+PDU1Lv6R3uw
         Tx50DQg7YRPN76L7xSTLAbm679w8aYPfLasz9k7RiI/pkcnWLT5zhwrx6orFw2QeLuJs
         4BwycsF9KMz4j4ExGqiV7Fb+680+yHCmgKP49QJuVQqEtU8PYuJE1884kbYQ27JV1RBN
         YomfX51cxryJuShQ/1QdRk3YUkWS94QoL6pylXcgDzry4cJ4aOrB2oWYNhTDhm2vqmFh
         tKeg==
X-Gm-Message-State: AJIora+tyQdft6tcivzVyMA8Pcm6iwlw79MG6TsXDLDnlMhI7SS2Ce0o
        esglbcc/bU47VNgzeIlrkUBDTlXfLvsBApGRQhu2zA==
X-Google-Smtp-Source: AGRyM1ukXmbDBTUmgfEPfq4g0fSzjZCODNwoenxaj+ZuQ6nSFKMHhpapVUul8KEv56TfB2SshRb0iwtzlnz8MQ5zEAU=
X-Received: by 2002:a05:6000:192:b0:21a:3c91:df05 with SMTP id
 p18-20020a056000019200b0021a3c91df05mr25306379wrx.655.1656890656277; Sun, 03
 Jul 2022 16:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-16-brad@pensando.io>
 <20220614213428.GA2684278-robh@kernel.org>
In-Reply-To: <20220614213428.GA2684278-robh@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:24:05 -0700
Message-ID: <CAK9rFnzy6GTg+DYicrSzgXpRCO3XgFtVDP1Fjg=oiUgZusNn_Q@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] reset: elbasr: Add AMD Pensando Elba SR Reset Controller
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Jun 14, 2022 at 2:34 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:56:58PM -0700, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > This patch adds the reset controller functionality for the
> > AMD Pensando Elba System Resource Chip.
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  drivers/reset/Kconfig                         |  9 ++
> >  drivers/reset/Makefile                        |  1 +
> >  drivers/reset/reset-elbasr.c                  | 94 +++++++++++++++++++
> >  .../reset/amd,pensando-elba-reset.h           | 11 +++
>
> This goes with the binding patch

I must have misinterpreted an earlier request to put the bindings
separately up front in the patch set.  For a new driver the binding
and driver should be in one patch which I'll change for the next version.

> ...
> > --- /dev/null
> > +++ b/drivers/reset/reset-elbasr.c
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> Kernel code is GPL-2.0-only generally.

Did something change versus earlier request for dual license?

> Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
> - by Rob Herring @ 2021-10-27 21:37 UTC [8%]

> > +// SPDX-License-Identifier: GPL-2.0

> Do you care about using with non-GPL OS? Dual license is preferred.

Regards,
Brad
