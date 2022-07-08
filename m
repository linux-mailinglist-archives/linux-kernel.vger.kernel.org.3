Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ED156C48C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiGHThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiGHThS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:37:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2B65D52;
        Fri,  8 Jul 2022 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657309035; x=1688845035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lm5ZpyWdcwQjlYsBBiZlq62XmFMEHwCGoAEYptsewiQ=;
  b=m5B5jaC5ZoYPE5N8WV9zQd+D+LTBzG972dQRrasM6C2+iEj9K19GnVF2
   ai5miAA4/M6JhpsPGbYwofHn4jlvy7fjb7FdtF4/bt4SAIrImD6vC5S/K
   CSeBfFnRCQEGnJIdWDzKmCjde/cHTlu0yMmTpDOBDINgsuQePo5E8A5aY
   3OPCJDygrjTLa93auOxXWZhqY2BZbLfSgjTYdtgdLtbmuP4/Q78GBpCoO
   bJ1amGkdrlcBvNkOrdoLs44exaChoo+iL9Wn0K6djn1hKyMqXuQc5baNZ
   jpxiZA5qs2IHVpKdKZ7NR+7DiUlQcFEsv0zYVeSaFue9u4xvslRXj98qF
   w==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="171652679"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 12:37:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 12:37:14 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 12:37:13 -0700
Date:   Fri, 8 Jul 2022 21:41:12 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Colin Foster <colin.foster@in-advantage.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <kavyasree.kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: Fix pincfg
Message-ID: <20220708194112.wkbn5uw5ous6hzwz@soft-dev3-1.localhost>
References: <20220707185342.2697569-1-horatiu.vultur@microchip.com>
 <20220707185342.2697569-3-horatiu.vultur@microchip.com>
 <Ysd64LTu7CtBjV4R@COLIN-DESKTOP1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Ysd64LTu7CtBjV4R@COLIN-DESKTOP1.localdomain>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/07/2022 17:31, Colin Foster wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi Horatiu,

Hi Colin,

> 
> On Thu, Jul 07, 2022 at 08:53:42PM +0200, Horatiu Vultur wrote:
> > The blamed commit changed to use regmaps instead of __iomem. But it
> > didn't update the register offsets to be at word offset, so it uses byte
> > offset.
> >
> > Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> Sorry about this one. It sounded familiar though:
> https://patchwork.ozlabs.org/project/linux-gpio/patch/20220125161245.418882-1-horatiu.vultur@microchip.com/
> 
> The only takeaway from that was the use of regmap_get_reg_stride, which
> was done in
> commit baf927a833ca ("microchip-sgpio: Fix support for regmap")

That is correct. I will update this to use regmap_get_reg_stride.

> 
> And I see it is only for pincfg - which I don't have any hardware to
> test that. Apologies again!

No worries.

> 
> > ---
> >  drivers/pinctrl/pinctrl-ocelot.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
> > index 6212abe2b66f..e84f2f82901f 100644
> > --- a/drivers/pinctrl/pinctrl-ocelot.c
> > +++ b/drivers/pinctrl/pinctrl-ocelot.c
> > @@ -303,6 +303,13 @@ static const char *const ocelot_function_names[] = {
> >       [FUNC_RCVRD_CLK]        = "rcvrd_clk",
> >  };
> >
> > +const struct regmap_config regmap_pincfg = {
> > +             .reg_bits = 32,
> > +             .val_bits = 32,
> > +             .reg_stride = 4,
> > +             .name = "pincfg",
> > +};
> > +
> >  struct ocelot_pmx_func {
> >       const char **groups;
> >       unsigned int ngroups;
> > @@ -1334,7 +1341,8 @@ static int ocelot_hw_get_value(struct ocelot_pinctrl *info,
> >       if (info->pincfg) {
> >               u32 regcfg;
> >
> > -             ret = regmap_read(info->pincfg, pin, &regcfg);
> > +             ret = regmap_read(info->pincfg, pin * regmap_pincfg.reg_stride,
> > +                               &regcfg);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1368,14 +1376,16 @@ static int ocelot_pincfg_clrsetbits(struct ocelot_pinctrl *info, u32 regaddr,
> >       u32 val;
> >       int ret;
> >
> > -     ret = regmap_read(info->pincfg, regaddr, &val);
> > +     ret = regmap_read(info->pincfg, regaddr * regmap_pincfg.reg_stride,
> > +                       &val);
> >       if (ret)
> >               return ret;
> >
> >       val &= ~clrbits;
> >       val |= setbits;
> >
> > -     ret = regmap_write(info->pincfg, regaddr, val);
> > +     ret = regmap_write(info->pincfg, regaddr * regmap_pincfg.reg_stride,
> > +                        val);
> >
> >       return ret;
> >  }
> > @@ -1940,21 +1950,13 @@ static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
> >  {
> >       void __iomem *base;
> >
> > -     const struct regmap_config regmap_config = {
> > -             .reg_bits = 32,
> > -             .val_bits = 32,
> > -             .reg_stride = 4,
> > -             .max_register = 32,
> > -             .name = "pincfg",
> > -     };
> > -
> > -     base = devm_platform_ioremap_resource(pdev, 1);
> > +             base = devm_platform_ioremap_resource(pdev, 1);
> >       if (IS_ERR(base)) {
> >               dev_dbg(&pdev->dev, "Failed to ioremap config registers (no extended pinconf)\n");
> >               return NULL;
> >       }
> >
> > -     return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
> > +     return devm_regmap_init_mmio(&pdev->dev, base, &regmap_pincfg);
> >  }
> >
> >  static int ocelot_pinctrl_probe(struct platform_device *pdev)
> > --
> > 2.33.0
> >

-- 
/Horatiu
