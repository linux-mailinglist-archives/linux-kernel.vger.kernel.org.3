Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CCD56D4E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGKGp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiGKGpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:45:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D01A07A;
        Sun, 10 Jul 2022 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657521950; x=1689057950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MWY15pYP25DoOSvO190tlSEvb8WGYicdBk2zrpZS23w=;
  b=q3hGi7xDfF9vYPTiCEMbimwie5cW3Oirp/zHpkwUA+BfvpiMCCyXHaZh
   qdeBp1SA6hIjCdFwX8T3v6Q5AFXSQjctl1IbRBIpTLZWlYasFV6qHlXfe
   Ry1vm0CaqymyMf54Fe1KyGdSiWBzLYONHiN7RZ+QfQqXHoKXBBzs1GAb4
   naOHz4Reluke/fm5zHgTlHtEcEr3lkl/Qywep0IVErh6/zPjJsT2d7+Y2
   dcR51mtbHZjiVLhT7XXsvEq1IgdQyqFe/uhqylCuKD0ZtkZoHCt+SbgoB
   P/9qArAd45RST7GngahDR2FdcfQdTykuiK37W3ZwFdBpEE4k0uytE/0I0
   A==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="181566024"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2022 23:45:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 10 Jul 2022 23:45:49 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 10 Jul 2022 23:45:49 -0700
Date:   Mon, 11 Jul 2022 08:49:50 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <kavyasree.kotagiri@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 1/2] pinctrl: ocelot: Fix pincfg for lan966x
Message-ID: <20220711064950.3fqhuat3b23uabkj@soft-dev3-1.localhost>
References: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
 <20220708195510.2951661-2-horatiu.vultur@microchip.com>
 <CAHp75VdPi8rT_EJd8L8-waAkH_Lm947WVKMLHjjW5MpFW9A06Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdPi8rT_EJd8L8-waAkH_Lm947WVKMLHjjW5MpFW9A06Q@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/08/2022 23:58, Andy Shevchenko wrote:

Hi Andy,

> 
> On Fri, Jul 8, 2022 at 10:10 PM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> >
> > The blamed commit introduce support for lan966x which use the same
> > pinconf_ops as sparx5. The problem is that pinconf_ops is specific to
> > sparx5. More precisely the offset of the bits in the pincfg register are
> > different and also lan966x doesn't have support for
> > PIN_CONFIG_INPUT_SCHMITT_ENABLE.
> >
> > Fix this by making pinconf_ops more generic such that it can be also
> > used by lan966x. This is done by introducing 'ocelot_pincfg_data' which
> > contains the offset and what is supported for each SOC.
> 
> ...
> 
> > +struct ocelot_pincfg_data {
> > +       bool has_schmitt;
> > +       u8 schmitt_bit;
> > +       u8 pd_bit;
> > +       u8 pu_bit;
> > +       u8 drive_bits;
> 
> I would go with mandatory fields first and leave optional (that is
> with boolean flag) at last.
> 
> > +};
> 
> ...
> 
> >  struct ocelot_pinctrl {
> >         struct device *dev;
> >         struct pinctrl_dev *pctl;
> > @@ -330,6 +331,12 @@ struct ocelot_pinctrl {
> >         struct pinctrl_desc *desc;
> >         struct ocelot_pmx_func func[FUNC_MAX];
> >         u8 stride;
> > +       struct ocelot_pincfg_data *pincfg_data;
> 
> It might waste too many bytes in some cases. I would recommend moving
> it somewhere above, definitely before the u8 member.
> 
> > +};
> 
> Yes, I understand that for a certain architecture it might be the same
> result in sizeof(), the rationale is to make code better in case
> somebody copies'n'pastes pieces or ideas from it.
> 
> ...
> 
> >                 if (param == PIN_CONFIG_BIAS_DISABLE)>                         val = (val == 0);
> >                 else if (param == PIN_CONFIG_BIAS_PULL_DOWN)
> > -                       val = (val & BIAS_PD_BIT ? true : false);
> > +                       val = (val & info->pincfg_data->pd_bit ? true : false);
> >                 else    /* PIN_CONFIG_BIAS_PULL_UP */
> > -                       val = (val & BIAS_PU_BIT ? true : false);
> > +                       val = (val & info->pincfg_data->pu_bit ? true : false);
> >                 break;
> 
> > +               val = (val & info->pincfg_data->schmitt_bit ? true : false);
> 
> 
> !!(val & ...) will be a much shorter equivalent to ternary.
> 
> >                 break;
> 
> ...
> 
> > +static struct ocelot_match_data ocelot_desc = {
> > +       .desc = {
> > +               .name = "ocelot-pinctrl",
> > +               .pins = ocelot_pins,
> > +               .npins = ARRAY_SIZE(ocelot_pins),
> > +               .pctlops = &ocelot_pctl_ops,
> > +               .pmxops = &ocelot_pmx_ops,
> > +               .owner = THIS_MODULE,
> > +       }
> 
> Please, keep a comma here. It's definitely not a terminating entry, so
> it might help in the future.
> 
> Ditto for all cases like this.
> 
> >  };
> 
> ...
> 
> > +       struct ocelot_match_data *data;
> 
> Any specific reason why this is not const?
> 
> ...
> 
> > +       data = (struct ocelot_match_data *)device_get_match_data(dev);
> 
> And here you drop the qualifier...
> 
> I would recommend making it const and dropping the cast completely.

If I make this const, but then few lines after I will get the following
warnings:

drivers/pinctrl/pinctrl-ocelot.c:1983:13: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
1983 |  info->desc = &data->desc;
     |             ^
drivers/pinctrl/pinctrl-ocelot.c:1984:20: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
1984 |  info->pincfg_data = &data->pincfg_data;
     |                    ^

Of course I can make also info->desc and info->pincfg_data const but
then I will get the following warning:

drivers/pinctrl/pinctrl-ocelot.c: In function ‘ocelot_pinctrl_register’:
drivers/pinctrl/pinctrl-ocelot.c:1723:53: warning: passing argument 2 of ‘devm_pinctrl_register’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
1723 |  info->pctl = devm_pinctrl_register(&pdev->dev, info->desc, info);
     |                                                 ~~~~^~~~~~
In file included from include/linux/gpio/driver.h:10,
                 from drivers/pinctrl/pinctrl-ocelot.c:10:
                      include/linux/pinctrl/pinctrl.h:166:26: note: expected ‘struct pinctrl_desc *’ but argument is of type ‘const struct pinctrl_desc *’
166 |     struct pinctrl_desc *pctldesc,
    |     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~

> 
> > +       if (!data)
> > +               return -EINVAL;
> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
