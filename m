Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5581054AF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356198AbiFNLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356191AbiFNLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:11:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E606B495;
        Tue, 14 Jun 2022 04:10:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x5so11123881edi.2;
        Tue, 14 Jun 2022 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPBHsuQCw6LHS2plx2otL7HeQmFNkV5hfWoP76A3RuI=;
        b=bvmy9uC7Y91x36UUcnI0dZgqvcN99LsDklIpRbe5mWByroOMEilZmL+nJzuVg5/sJX
         JazMirUEJOH4L96Dl3WY3QNnsYlfu4T8BEab/1Zd+Gw+2yRjnYTYk1s/8YqerBT8zbYe
         eCvguRBgN4hFzezCezUmHnAy1U9b3EE4weE/tp6VFkgMpEv9A3jFvf3Mw7I3R8Z19wjE
         mgN51FDicCJmF8p15FjF3yx7eoh2vSuldLwgYr/ODIW950PHqSqZMyIQ3FDXDrWExKFY
         y3DHKdFyKt2GVLpd1OX2Ed+X35v0UZEpYH0xuAA7xK+aMY3b4456xxkUmBLijOIg0R2o
         7qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPBHsuQCw6LHS2plx2otL7HeQmFNkV5hfWoP76A3RuI=;
        b=Z8zDoJ1ATbUIlwXU46LQ5WY3pBOXE96RipeWz7pO39tnm/RmQHLHQoftFEzXhT3LDI
         kV8mujlmH2Sv4Hsl9PuSfWxJ4ntXObnOSXwIhL/AEqBlZVj1rZ52ymnoQ07KdJ7Oy66A
         T6fCVgXuPnuBxwxi+KttVMm1E4ikBCser3Liq3F/lCT3fjdgNhJPPBPFYsyKaDgocbEk
         Cqec9CceiqVgNcXA4lIzN9d++EUkW+42osjmtElk0ReB6h/Hs7S3gCf9NklAXQQagsGW
         pT4KUx53zCtqBYQJeBIf60PhBWjOf6SWzfCb4hAMcPmEaz7ZxJ1i0IXgVJWcKXWaqbHo
         /IRA==
X-Gm-Message-State: AOAM5337Rd9KjPfWqU0Yn35rxNODkBb+YnvP6fUuS4GwrBtx0lkUmoEk
        c55Q66odvaJ5PxaTeYN5StxPPwxrYFh9Vtue0Us=
X-Google-Smtp-Source: ABdhPJzHfPxRHZKBWrh40KmGWV2VLw5jrvhjQmxMw037SGLU2BvNTqYyA1QtJNjaT+QFj6WCBwxH0pY5xCbA8t5p3wk=
X-Received: by 2002:aa7:d989:0:b0:431:75d5:f204 with SMTP id
 u9-20020aa7d989000000b0043175d5f204mr5422612eds.230.1655205057577; Tue, 14
 Jun 2022 04:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-13-brad@pensando.io>
In-Reply-To: <20220613195658.5607-13-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 13:10:20 +0200
Message-ID: <CAHp75Vex0VkECYd=kY0m6=jXBYSXg2UFu7vn271+Q49WZn22GA@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] spi: dw: Add support for AMD Pensando Elba SoC
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, piotrs@cadence.com,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Mon, Jun 13, 2022 at 9:57 PM Brad Larson <brad@pensando.io> wrote:
>
> From: Brad Larson <blarson@amd.com>
>
> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
> with device specific chip-select control.  The Elba SoC
> provides four chip-selects where the native DW IP supports
> two chip-selects.  The Elba DW_SPI instance has two native
> CS signals that are always overridden.

...

> +/*
> + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
> + * gpios for cs 2,3 as defined in the device tree.
> + *
> + * cs:  |       1               0
> + * bit: |---3-------2-------1-------0
> + *      |  cs1   cs1_ovr   cs0   cs0_ovr
> + */

> +#define ELBA_SPICS_SHIFT(cs)           (2 * (cs))

Useless.It takes much more than simply multiplying each time in two
macros. Also see below.

> +#define ELBA_SPICS_MASK(cs)            (0x3 << ELBA_SPICS_SHIFT(cs))

(GENMASK(1, 0) << ((cs) << 1))

Or ((cs) * 2) to show that it takes 2 bits and not two times of CS',

> +#define ELBA_SPICS_SET(cs, val)        \
> +                       ((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))

BIT(0)

So the main point is to use GENMASK() and BIT() the rest is up to you.

-- 
With Best Regards,
Andy Shevchenko
