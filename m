Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB04937FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353490AbiASKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:11:52 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:41912 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353474AbiASKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:11:51 -0500
X-UUID: b0ba83a4b0f0412b94a673a793878491-20220119
X-UUID: b0ba83a4b0f0412b94a673a793878491-20220119
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 599025123; Wed, 19 Jan 2022 18:11:47 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 18:11:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 Jan
 2022 18:11:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 18:11:44 +0800
Message-ID: <068c965a0243486f0e1cabbafb8904a6a8ddcc9f.camel@mediatek.com>
Subject: Re: [RESEND v3 3/3] mmc: mediatek: add support for SDIO eint IRQ
From:   Axe Yang <axe.yang@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
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
Date:   Wed, 19 Jan 2022 18:11:43 +0800
In-Reply-To: <CAHp75VdkKYujGZOdGkLK-tzC9q+RjkX59fFZe5cHajGOnDdL2w@mail.gmail.com>
References: <20220117082539.18713-1-axe.yang@mediatek.com>
         <20220117082539.18713-4-axe.yang@mediatek.com>
         <CAHp75VdkKYujGZOdGkLK-tzC9q+RjkX59fFZe5cHajGOnDdL2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 11:18 +0200, Andy Shevchenko wrote:
> On Mon, Jan 17, 2022 at 7:33 PM Axe Yang <axe.yang@mediatek.com>
> wrote:
> > 
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
> 
> ...
> 
> > +static irqreturn_t msdc_sdio_eint_irq(int irq, void *dev_id)
> > +{
> > +       struct msdc_host *host = dev_id;
> > +       struct mmc_host *mmc = mmc_from_priv(host);
> > +       unsigned long flags;
> 
> Same Q as per v2. Why do you need this?
> 
> Yes, you did the first step to the answer, but I want you to go
> deeper
> and tell me why you need the spin_lock_irqsave() variant.

You are right, no need to save/restore flags in irq handler.
Will fix it in new version.
Thanks.

> 
> > +       spin_lock_irqsave(&host->lock, flags);
> > +       if (likely(host->sdio_irq_cnt > 0)) {
> > +               disable_irq_nosync(host->eint_irq);
> > +               disable_irq_wake(host->eint_irq);
> > +               host->sdio_irq_cnt--;
> > +       }
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +       sdio_signal_irq(mmc);
> > +
> > +       return IRQ_HANDLED;
> > +}
> 
> 

