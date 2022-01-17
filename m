Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534B4902F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiAQHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:36:02 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:34772 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232208AbiAQHgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:36:00 -0500
X-UUID: 0248352516b94cd1a40ba274f513aa84-20220117
X-UUID: 0248352516b94cd1a40ba274f513aa84-20220117
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1741393476; Mon, 17 Jan 2022 15:35:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 17 Jan 2022 15:35:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 15:35:53 +0800
Message-ID: <2205eedc9ecd10f83994138974b261baa0aee55a.camel@mediatek.com>
Subject: Re: [PATCH v2 3/3] mmc: mediatek: add support for SDIO eint irq
From:   Axe Yang <axe.yang@mediatek.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lucas Stach" <dev@lynxeye.de>, Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 17 Jan 2022 15:35:53 +0800
In-Reply-To: <Yd1uJ+dX2CTEJfYY@smile.fi.intel.com>
References: <20220111014046.5864-1-axe.yang@mediatek.com>
         <20220111014046.5864-4-axe.yang@mediatek.com>
         <Yd1uJ+dX2CTEJfYY@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy, patchset v3 is uploaded. I fixed most of the defect you pointed
out.
And in msdc_sdio_eint_irq(), you asked why do we need flags, the flags
is for spin lock irq save/restore, so I keep it.

On Tue, 2022-01-11 at 13:46 +0200, Andy Shevchenko wrote:
> On Tue, Jan 11, 2022 at 09:40:46AM +0800, Axe Yang wrote:
> > Add support for eint irq when MSDC is used as an SDIO host. This
> 
> IRQ
> 
> > feature requires SDIO device support async irq function. With this
> 
> IRQ
> 
> > feature,SDIO host can be awakened by SDIO card in suspend state,
> 
> feature, SDIO
> 
> > without additional pin.
> > 
> > MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> > turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> > resume, switch GPIO function back to DAT1 mode then turn on clock.
> > 
> > Some device tree property should be added or modified in msdc node
> 
> MSDC
> 
> > to support SDIO eint irq. Pinctrls named state_dat1 and state_eint
> 
> IRQ
> 
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
> 
> ...
> 
> > - * Copyright (c) 2014-2015 MediaTek Inc.
> > + * Copyright (c) 2014-2022 MediaTek Inc.
> 
> Shouldn't it be rather like
> 
>  * Copyright (c) 2014-2015,2022 MediaTek Inc.
> 
> ?
> 
> ...
> 
> > +static irqreturn_t msdc_sdio_eint_irq(int irq, void *dev_id)
> > +{
> > +	unsigned long flags;
> > +	struct msdc_host *host = (struct msdc_host *)dev_id;
> 
> No casting is needed.
> 
> > +	struct mmc_host *mmc = mmc_from_priv(host);
> 
> Perhaps reversed xmas tree order
> 
> 	struct msdc_host *host = dev_id;
> 	struct mmc_host *mmc = mmc_from_priv(host);
> 	unsigned long flags;
> 
> ?
> 
> But hey, why do you need flags?

falgs is for spin lock irq save/restore. 

> 
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	if (likely(host->sdio_irq_cnt > 0)) {
> > +		disable_irq_nosync(host->eint_irq);
> > +		disable_irq_wake(host->eint_irq);
> > +		host->sdio_irq_cnt--;
> > +	}
> > +	spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +	sdio_signal_irq(mmc);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> ...
> 
> > +static int msdc_request_dat1_eint_irq(struct msdc_host *host)
> > +{
> > +	struct gpio_desc *desc;
> > +	int irq, ret;
> > +
> > +	desc = devm_gpiod_get(host->dev, "eint", GPIOD_IN);
> > +	if (IS_ERR(desc))
> > +		return PTR_ERR(desc);
> > +
> > +	ret = gpiod_to_irq(desc);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	irq = ret;
> > +	ret = devm_request_threaded_irq(host->dev, irq, NULL,
> > msdc_sdio_eint_irq,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT
> > | IRQF_NO_AUTOEN,
> > +					"sdio-eint", host);
> > +
> 
> Redundant blank line.
> 
> > +	if (!ret)
> > +		host->eint_irq = irq;
> > +
> > +	return ret;
> 
> I guess I have already commented on this, i.e. use standard pattern
> 
> 	if (ret)
> 		return ret;
> 
> 	...
> 	return 0;
> 
> > +}
> 
> ...
> 
> > +		host->pins_eint = pinctrl_lookup_state(host->pinctrl,
> > "state_eint");
> > +		if (IS_ERR(host->pins_eint)) {
> > +			dev_dbg(&pdev->dev, "Cannot find pinctrl
> > eint!\n");
> 
> In debug mode of pin control this will bring a duplicate message.
> 
> > +		} else {
> > +			host->pins_dat1 = pinctrl_lookup_state(host-
> > >pinctrl, "state_dat1");
> > +			if (IS_ERR(host->pins_dat1)) {
> > +				ret = dev_err_probe(&pdev->dev,
> > PTR_ERR(host->pins_dat1),
> > +						    "Cannot find
> > pinctrl dat1!\n");
> > +				goto host_free;
> > +			}
> > +
> > +			host->sdio_eint_ready = true;
> > +		}
> > +	}
> 
> 

