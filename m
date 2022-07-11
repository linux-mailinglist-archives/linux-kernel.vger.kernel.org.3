Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E8570B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiGKURz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKURw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:17:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556F93341A;
        Mon, 11 Jul 2022 13:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657570671; x=1689106671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7QRIbD+k2P4Uf7zNShR6UhofAnNAkSohtHFWigS5ETQ=;
  b=bQUZngXm43ypBT3R/VstrYp2OqFMHN0juIpHU5dRBbs+DqD7ma3NX9xs
   jm1H2lYeWeco8FnfTGr0FKqSSpVlT6EK2IhlZk/RtWtItN1sOS+Lquo7e
   MApSJQU8TFlZ6GhDkVEo39Z3kxQhwHKXdfbndLrwMj6W1zzoEXR/KP8UF
   83ZH2OdaqEltYUxNJ1fMR4+FmJTo5VIeR2zjBm9KGJhzYRY8RSzUY+cm0
   AGGMAaq7420wg3K70+xRURdkX31WHyL0/S5yuoqHFa3Ou3696D4RleN1r
   Oud8Zy9C923R26/LHpO+0k4CDsE9TIEqMRiWWCO6z0cotBPZBHRY9QuH5
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="167352871"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 13:17:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 13:17:49 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 13:17:48 -0700
Date:   Mon, 11 Jul 2022 22:21:50 +0200
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
Subject: Re: [PATCH v3 1/2] pinctrl: ocelot: Fix pincfg for lan966x
Message-ID: <20220711202150.7yoxazefe3zzlzpw@soft-dev3-1.localhost>
References: <20220711192113.3522664-1-horatiu.vultur@microchip.com>
 <20220711192113.3522664-2-horatiu.vultur@microchip.com>
 <CAHp75Vfs8EH-rRn58cS692tZMRFmjFLv6=kB4oqVEGXi5R8BHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75Vfs8EH-rRn58cS692tZMRFmjFLv6=kB4oqVEGXi5R8BHQ@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/11/2022 21:47, Andy Shevchenko wrote:
> 
> On Mon, Jul 11, 2022 at 9:17 PM Horatiu Vultur
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
> 
> ...
> 
> > +       info->pincfg_data = devm_kmemdup(dev, &data->pincfg_data,
> > +                                        sizeof(struct ocelot_match_data),
> 
> sizeof(*info->pincfg_data)
> (isn't it a bug here?)

Yes it looks like it is. I think underneath it still allocates a page so
that could be the reason why I haven't see any crashes when I have tried
it.
I will fix this in the next version.

> 
> > +                                        GFP_KERNEL);
> 
> and missed the NULL check.
> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
