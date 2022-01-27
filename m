Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7649DF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiA0Kh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:37:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:33930 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiA0Kh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643279877; x=1674815877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQQW6o4yavoDToUKue4f/G6mHjTCqpN91pJTYtcfuhw=;
  b=h0kI/w6U839UWRpOC2TzDuyPzn+PZaCKTp60LSaOaFJjJ1qIGqPS7T/h
   +YF5GgKZYthJS2hEeN8TP06wkfCjEBIzen2PhPMItMBgtHn2hLB4VIGcZ
   rP3RpTYvCTiqTZrc0q5TixaaB75JwZOqHx4s2irE0lBsWyvUiF6sJ1lnZ
   +GICeBI+L0nXzqRiv1dexUaBzWKqQUiAhtwpjVLFV5ClzPnMNjPUUMjsF
   /x68zLthg+d3oOCnf0SD+8px37dYhulzk4ughc8YHq5xV5BG8CyNR+wTF
   ZfIlapZUqQ6l1lPAW/+NkNOjble06R27zMbxlrj6+Cvs8TJpmKAHf4jiS
   A==;
IronPort-SDR: vfO46qe7nWI4oxy+PtqppYt4Njs8migAVIj+1pcs3WPbmpsOkyJRegg7tOMcrh0arJctFKSi3x
 3KgMDhXbmMzbElmp1vxTRE9QK20TEKIZsv+wO314oGlsZQvWoWIQXNtAVub/6eHkENZW0ckcVz
 7xhFhmsIQ+72t7tc76/6WdsJCcAAqxUmA1R3kUqsPZEd2yvLQo0q/9VwNOM5yBqctEfT50R+86
 bC279OuYGF3DxZfN8TpBBjlYgSl29HjrqeH1vWWgKBrSaQEfFLPDk5pmqcjSgdT0pBZwbvULtZ
 Tjaxt+FIk5FIvBmnjBowBFF6
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="83851515"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2022 03:37:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 03:37:56 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 27 Jan 2022 03:37:56 -0700
Date:   Thu, 27 Jan 2022 11:40:23 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Colin Foster <colin.foster@in-advantage.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: microchip-sgpio: Fix support for regmap
Message-ID: <20220127104023.5dwcrod7toi4hpb7@soft-dev3-1.localhost>
References: <20220125161245.418882-1-horatiu.vultur@microchip.com>
 <20220125164659.GA31440@COLIN-DESKTOP1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20220125164659.GA31440@COLIN-DESKTOP1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 01/25/2022 08:46, Colin Foster wrote:
> 
> Hi Horatiu,

Hi Colin,

> 
> On Tue, Jan 25, 2022 at 05:12:45PM +0100, Horatiu Vultur wrote:
> > Initially the driver accessed the registers using u32 __iomem but then
> > in the blamed commit it changed it to use regmap. The problem is that now
> > the offset of the registers is not calculated anymore at word offset but
> > at byte offset. Therefore make sure to multiply the offset with word size.
> >
> 
> Sorry about this one. I see it must have slipped through the cracks
> because I had made the same change in my tree. The only difference is I
> had copied reg_stride into sgpio_priv instead of making regmap_config
> file-scope. For what its worth, with apologies:

No worries, sorry that I missed your patch initially. And thanks for
reviewing this patch.

> 
> Reviewed-by: Colin Foster <colin.foster@in-advantage.com>



> 
> > Fixes: 2afbbab45c261a ("pinctrl: microchip-sgpio: update to support regmap")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/pinctrl/pinctrl-microchip-sgpio.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> > index 8e081c90bdb2..2999c98bbdee 100644
> > --- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
> > +++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
> > @@ -98,6 +98,12 @@ static const struct sgpio_properties properties_sparx5 = {
> >       .regoff = { 0x00, 0x06, 0x26, 0x04, 0x05, 0x2a, 0x32, 0x3a, 0x3e, 0x42 },
> >  };
> >
> > +static const struct regmap_config regmap_config = {
> > +             .reg_bits = 32,
> > +             .val_bits = 32,
> > +             .reg_stride = 4,
> > +};
> > +
> >  static const char * const functions[] = { "gpio" };
> >
> >  struct sgpio_bank {
> > @@ -137,7 +143,7 @@ static inline int sgpio_addr_to_pin(struct sgpio_priv *priv, int port, int bit)
> >
> >  static inline u32 sgpio_get_addr(struct sgpio_priv *priv, u32 rno, u32 off)
> >  {
> > -     return priv->properties->regoff[rno] + off;
> > +     return (priv->properties->regoff[rno] + off) * regmap_config.reg_stride;
> >  }
> >
> >  static u32 sgpio_readl(struct sgpio_priv *priv, u32 rno, u32 off)
> > @@ -821,11 +827,6 @@ static int microchip_sgpio_probe(struct platform_device *pdev)
> >       struct clk *clk;
> >       u32 __iomem *regs;
> >       u32 val;
> > -     struct regmap_config regmap_config = {
> > -             .reg_bits = 32,
> > -             .val_bits = 32,
> > -             .reg_stride = 4,
> > -     };
> >
> >       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >       if (!priv)
> > --
> > 2.33.0
> >

-- 
/Horatiu
