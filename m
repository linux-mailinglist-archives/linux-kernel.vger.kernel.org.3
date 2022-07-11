Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57A156D4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiGKGvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGKGvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:51:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFE1581F;
        Sun, 10 Jul 2022 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657522307; x=1689058307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IA6Hs6HQ3nxy4zbFA9FS5RsA1pexaRNyRW/91aJDYls=;
  b=zNv0IHU+W5XGymssUSz/Qx24FNXSfWK9kjZJRtrxl7zrUJPMYrKjwlzT
   C1rGH5S9OinaPLPZeJXX3U2XCyoklRfL5OE2fjDMECAvekGmcXS5Ztfiv
   kjsaixek78v40ZeIZykgRanotI+jA95LDzF5x5gHeZ4+k2Gi3jjnCQOfq
   fgfEPCPyrRCobzZ9d2XXmiKNcas30vHZ5unx4xelWu/CpgJ6mNG0YnGha
   AKWIpZLAGz9esF1n8uoKr1BqtDF2V9CC/o3y/o71I336c+rwMSP/mMIRB
   phreImC+RG+9r5WW9AtSiDTg2Shiy9DvYI1/d4UK61XQAo2VzdUsMaRzR
   A==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="171554269"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2022 23:51:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 10 Jul 2022 23:51:46 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 10 Jul 2022 23:51:46 -0700
Date:   Mon, 11 Jul 2022 08:55:47 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Colin Foster <colin.foster@in-advantage.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <kavyasree.kotagiri@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 2/2] pinctrl: ocelot: Fix pincfg
Message-ID: <20220711065547.drpgq466ueujkxah@soft-dev3-1.localhost>
References: <20220708195510.2951661-1-horatiu.vultur@microchip.com>
 <20220708195510.2951661-3-horatiu.vultur@microchip.com>
 <YsiQhA9pHaX4s3R8@colin-ia-desktop>
 <CAHp75Vc0EasS2Z3x=cgTv==osXprPU3Zkc-Q9DMf4BMz2p6oLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc0EasS2Z3x=cgTv==osXprPU3Zkc-Q9DMf4BMz2p6oLw@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/09/2022 00:02, Andy Shevchenko wrote:

Hi Colin, Andy,

> 
> On Fri, Jul 8, 2022 at 10:17 PM Colin Foster
> <colin.foster@in-advantage.com> wrote:
> > On Fri, Jul 08, 2022 at 09:55:10PM +0200, Horatiu Vultur wrote:
> > > The blamed commit changed to use regmaps instead of __iomem. But it
> > > didn't update the register offsets to be at word offset, so it uses byte
> > > offset.
> > > Another issue with the same commit is that it a limit of 32 registers
> 
> it has a limit
> 
> > > which is incorrect. The sparx5 has 64 while lan966x has 77.
> 
> ...
> 
> > > -             .max_register = 32,
> >
> > What happens in /sys/kernel/debug/regmap/*-pincfg/{range,registers} when
> > there's no max register?
> 
> Good question!

If .max_register is missing then I got the following:

# cd /sys/kernel/debug/regmap/e2004064.pinctrl-pincfg/
# cat range
0-0
# cat registers
0: 00000005

> 
> > Should it be this?
> >
> > struct regmap_config regmap_config = {
> >     ...
> > };
> > regmap_config.max_register = info->desc->npins * regmap_config.reg_stride;
> >
> > >               .name = "pincfg",
> > >       };
> 
> If regmap configuration may be const, I would prefer to have a
> hardcoded value and different configuration based on the chip, but if
> it's not feasible, then this could suffice.

What about if we do something like:

const struct regmap_config regmap_config = {
    ...
    .max_register = info->desc->npins * 4,
    ...
};

This is based on what Colin suggested only that we keep the const.

> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
