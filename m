Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD584946FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 06:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358598AbiATFeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 00:34:15 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60516 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229989AbiATFeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 00:34:14 -0500
X-UUID: 79d0c64fb85748de93dbc62341103159-20220120
X-UUID: 79d0c64fb85748de93dbc62341103159-20220120
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1240064530; Thu, 20 Jan 2022 13:34:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Jan 2022 13:34:09 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Jan 2022 13:34:08 +0800
Message-ID: <0b6ef0ce05bb92cd458043be2441101e20166242.camel@mediatek.com>
Subject: Re: [PATCH v4 3/3] mmc: mediatek: add support for SDIO eint IRQ
From:   Axe Yang <axe.yang@mediatek.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lucas Stach" <dev@lynxeye.de>, Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yong Mao <yong.mao@mediatek.com>
Date:   Thu, 20 Jan 2022 13:34:08 +0800
In-Reply-To: <Yehq7L36yfJ8D/j2@smile.fi.intel.com>
References: <20220119103212.13158-1-axe.yang@mediatek.com>
         <20220119103212.13158-4-axe.yang@mediatek.com>
         <Yehq7L36yfJ8D/j2@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 21:47 +0200, Andy Shevchenko wrote:
> On Wed, Jan 19, 2022 at 06:32:12PM +0800, Axe Yang wrote:
> > Add support for eint IRQ when MSDC is used as an SDIO host. This
> > feature requires SDIO device support async IRQ function. With this
> > feature, SDIO host can be awakened by SDIO card in suspend state,
> > without additional pin.
> > 
> > MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> > turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> > resume, switch GPIO function back to DAT1 mode then turn on clock.
> > 
> > Some device tree property should be added or modified in MSDC node
> > to support SDIO eint IRQ. Pinctrls named state_dat1 and state_eint
> > are mandatory. And cap-sdio-async-irq flag is necessary since this
> > feature depends on asynchronous interrupt:
> >         &mmcX {
> >                 ...
> >                 pinctrl-names = "default", "state_uhs",
> > "state_eint",
> >                                 "state_dat1";
> >                 ...
> >                 pinctrl-2 = <&mmc2_pins_eint>;
> >                 pinctrl-3 = <&mmc2_pins_dat1>;
> >                 ...
> >                 cap-sdio-async-irq;
> >                 ...
> >         };
> > 
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> 
> The submitters SoB must be last among all SoB tags. Please, read
> Submitting
> Patches document carefully.
> 
> > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> 
> Who is they, why their SoB appeared here?
> 

Yong Mao is the co-developer of this patch, I will reorder the SoB
chains.

> ...
> 
> >  /*
> > - * Copyright (c) 2014-2015 MediaTek Inc.
> > + * Copyright (c) 2022 MediaTek Inc.
> 
> This doesn't feel right. Why did you remove old years?

I should keep the publish year 2014 of this driver.
But I still think range 2014-2022 is the most appropriate way to change
the copyright time. Over these years, mediatek is keeping maintaining
this driver continuously. What do you think?

> 
> >   * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
> >   */
> 
> ...
> 
> > +	desc = devm_gpiod_get(host->dev, "eint", GPIOD_IN);
> > +	if (IS_ERR(desc))
> > +		return PTR_ERR(desc);
> > +	ret = gpiod_to_irq(desc);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	irq = ret;
> 
> Since both of them are local variables and there is no specific use
> of the
> returned value, I believe it's fine just to
> 
> 	irq = gpiod_to_irq(desc);
> 	...

I agree, will fix in next version.

> Hmm... I was wondering if you can use fwnode_irq_get_byname().
> Ah, it's not (yet) in upstream.
> 
> ...
> 
> >  static int __maybe_unused msdc_runtime_suspend(struct device *dev)
> >  {
> > +	unsigned long flags;
> 
> Can you keep reversed xmas tree order?
> 
> >  	struct mmc_host *mmc = dev_get_drvdata(dev);
> >  	struct msdc_host *host = mmc_priv(mmc);
> 
> (it means to add new variable here)

Will fix it in next version.

> 
> >  	return 0;
> >  }
> 
> ...
> 
> >  static int __maybe_unused msdc_runtime_resume(struct device *dev)
> >  {
> > +	unsigned long flags;
> 
> Ditto.

Will fix it in next version.

> 
> >  	struct mmc_host *mmc = dev_get_drvdata(dev);
> >  	struct msdc_host *host = mmc_priv(mmc);
> >  	int ret;
> >  	return 0;
> >  }
> 

--
Best Regard,
Axe Yang


