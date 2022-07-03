Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B25649E2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiGCVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiGCVOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:14:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B22DF6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:14:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so1183317wrq.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAJmsrF3a95Q+0VnUpb4xCH/13fcBF1x3IFG7cn4D6k=;
        b=VDmU/+g6+ItGdGObsTugs6F0a9CGNn1LdQrLZ+S4bmMNhGrL4lg6f88t1G7MDd0tR3
         7sOmPekqJ9ptc3wRbJD5hsA4Ks2lFG4iHI6Eg/TDhA7DdATqaNvtC787tfehwGBUO+p7
         +Z9aBKzQIdUpTQVdMoJPoL+Z2LtryBDBETmz9oQcRBUlZ2qibto4P2QZ6uDlLnOE8MIO
         enUinsLsKMH30GwVxt8Boi/c2DJDttX3PV4RnQhFD6+fgfFxXZMzvgC7NVafF3UOiGnO
         dm87EoiKomj7Kg5I6nG4mAJNf9b5spDjBNaVEnIELcKyP0p7rg2exX0xAuXNvlg1dY0g
         aDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAJmsrF3a95Q+0VnUpb4xCH/13fcBF1x3IFG7cn4D6k=;
        b=yo/uE69uvEMaSpQtsi6vKcNIBk3JtCjuJQlhrdk/tdYib3HY99UJ4RDLKURvs2e62Y
         xtE/Zl/kMNXNUDUEcoCdPFo7hmr96wm8b85YbgpK0BfJ1uYXE/sbqVb+D7+c18djrNs4
         0Os3Vg0ZXVWOEdvzf5JQUHjRv+Zr6HtzJ7HI3JMVDUG5M/ZSAKD+yOo1goTG2LsI8UGG
         lzbpnMjcvv361OSx1y+C12nMZNCM792JH9XVtWnFSa23VMToVVqbgJ1gC72NlEUv9wIU
         Q/ABq29VeQlQjiD1PhF/sqpW2nNjUCpwgoRfiSX5G/HWnlDglTz13CW1jVjane6Ka/KQ
         eqSw==
X-Gm-Message-State: AJIora/GUpsMejPYg2mjwq7/+diWk/4orKllkzwpIGjNfUMOxdMLhK3t
        9BUT2JFjDEEw1DNr10CQdgPdsN9Rh7QtNZSZHgM8eA==
X-Google-Smtp-Source: AGRyM1sH61bNNTH4eUqt6H5fB2Y8L9uQgLWLJQfrWDVjSV32291aal/naK+DlItLTHlBuj+i021lzeJmSFz6v8bl+bE=
X-Received: by 2002:a5d:5a15:0:b0:21d:630c:a609 with SMTP id
 bq21-20020a5d5a15000000b0021d630ca609mr6928728wrb.468.1656882871737; Sun, 03
 Jul 2022 14:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-13-brad@pensando.io>
 <CAHp75Vex0VkECYd=kY0m6=jXBYSXg2UFu7vn271+Q49WZn22GA@mail.gmail.com>
In-Reply-To: <CAHp75Vex0VkECYd=kY0m6=jXBYSXg2UFu7vn271+Q49WZn22GA@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 14:14:21 -0700
Message-ID: <CAK9rFnz=Rv3dGEtRAjknY49qe55MdfTsO8+TNegEOTduJZk6vg@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] spi: dw: Add support for AMD Pensando Elba SoC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        blarson@amd.com, Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jun 14, 2022 at 4:10 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 13, 2022 at 9:57 PM Brad Larson <brad@pensando.io> wrote:
> ...
>
> > +/*
> > + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
> > + * gpios for cs 2,3 as defined in the device tree.
> > + *
> > + * cs:  |       1               0
> > + * bit: |---3-------2-------1-------0
> > + *      |  cs1   cs1_ovr   cs0   cs0_ovr
> > + */
>
> > +#define ELBA_SPICS_SHIFT(cs)           (2 * (cs))
>
> Useless.It takes much more than simply multiplying each time in two
> macros. Also see below.
>
> > +#define ELBA_SPICS_MASK(cs)            (0x3 << ELBA_SPICS_SHIFT(cs))
>
> (GENMASK(1, 0) << ((cs) << 1))
>
> Or ((cs) * 2) to show that it takes 2 bits and not two times of CS',
>
> > +#define ELBA_SPICS_SET(cs, val)        \
> > +                       ((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))
>
> BIT(0)
>
> So the main point is to use GENMASK() and BIT() the rest is up to you.

I think you're recommending this approach which I'll change to

static void dw_spi_elba_override_cs(struct dw_spi_elba *dwselba, int
cs, int enable)
{
        regmap_update_bits(dwselba->syscon, ELBA_SPICS_REG,
                           (GENMASK(1, 0) << ((cs) << 1)),
                           ((enable) << 1 | BIT(0)) << ((cs) << 1));
}

Regards,
Brad
