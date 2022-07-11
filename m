Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFDA570B47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiGKUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiGKUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:23:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904ED357FF;
        Mon, 11 Jul 2022 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657570984; x=1689106984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sNVS+KcPsWhAjJnadCcEhTGBjML0xg+WgJRGyIyOaj0=;
  b=WQGwEcncRO4y/T69LEi9bW8XTw18l6X3GxZwokcoR2Zq+OQZYMYrQHly
   1DmYdhDHFpa0/aX8clq345PjFQOf5Q1rgaR+DDke7+Vv3HKiCSkicRqTg
   bt435hT7Ym53uaukaCVCAAxGhN+aVQAWRzzWSEIYmYBbnCeTWPdGTK2ZP
   L5spoxeq03cZoYYiqJDBTC2nJbSqaFvN1ePBvtT2UIKh+vRvDvRsHVz3Y
   U3buYyjlaZKX82qKzIygL21FIt/J08X1LRpa4bWO4E+7lKnteeqqQqkJV
   zMAYYcrQMi+qLihaaruGyEhsX0X7CGIgP7OEscdsfwU1qxrtKei/uRErB
   w==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="103985574"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 13:22:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 13:22:45 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 13:22:45 -0700
Date:   Mon, 11 Jul 2022 22:26:46 +0200
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
Subject: Re: [PATCH v3 2/2] pinctrl: ocelot: Fix pincfg
Message-ID: <20220711202646.om65vrksyifvkfkw@soft-dev3-1.localhost>
References: <20220711192113.3522664-1-horatiu.vultur@microchip.com>
 <20220711192113.3522664-3-horatiu.vultur@microchip.com>
 <CAHp75VdeZSP62qoOdQf=g4b7AheFd4=jNxfjMh-_T7Q1Zi=LbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VdeZSP62qoOdQf=g4b7AheFd4=jNxfjMh-_T7Q1Zi=LbA@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/11/2022 21:51, Andy Shevchenko wrote:
> 
> On Mon, Jul 11, 2022 at 9:17 PM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> >
> > The blamed commit changed to use regmaps instead of __iomem. But it
> > didn't update the register offsets to be at word offset, so it uses byte
> > offset.
> > Another issue with the same commit is that it has a limit of 32 registers
> > which is incorrect. The sparx5 has 64 while lan966x has 77.
> 
> ...
> 
> > -static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
> > +static struct regmap *ocelot_pinctrl_create_pincfg(struct ocelot_pinctrl *info,
> > +                                                  struct platform_device *pdev)
> 
> const?
> 
> And I would leave pdev to be the first parameter, if there are no
> other functions that have them like this.

I will do that in the next version.
Just for my understanding/knowledge why is this desire to have const or
to keep the const?

> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
