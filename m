Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9E457DB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiGVHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbiGVHxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:53:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C89B541;
        Fri, 22 Jul 2022 00:53:40 -0700 (PDT)
X-UUID: dcc7ae14511145f88b172ac08d1091b8-20220722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:80c541d6-197e-4d8a-b4b1-cb97df05da1c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:8ee0fc64-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: dcc7ae14511145f88b172ac08d1091b8-20220722
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 994416257; Fri, 22 Jul 2022 15:53:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 22 Jul 2022 15:53:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jul 2022 15:53:30 +0800
Message-ID: <0ac30efb52ce6489da7402a786b6b738c0f640e9.camel@mediatek.com>
Subject: Re: [PATCH v13 3/3] mmc: mediatek: add support for SDIO eint wakup
 IRQ
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        "Eric Biggers" <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>
Date:   Fri, 22 Jul 2022 15:53:30 +0800
In-Reply-To: <CAPDyKFrT-45bz6_mbWXTKEe_JKfd+p4ava1RxZD=6CyCdTukOg@mail.gmail.com>
References: <20220623090445.1401-1-axe.yang@mediatek.com>
         <20220623090445.1401-4-axe.yang@mediatek.com>
         <CAPDyKFr0gy1sNb=U3j1ErSZm+jcAcvg_jwNmodEs7ip4_LjNZg@mail.gmail.com>
         <621878fea57e70d56640bf6c50f4b723624060ee.camel@mediatek.com>
         <CAPDyKFrT-45bz6_mbWXTKEe_JKfd+p4ava1RxZD=6CyCdTukOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-21 at 12:58 +0200, Ulf Hansson wrote:
> + Linus Walleij
> 
> On Tue, 19 Jul 2022 at 12:35, Axe Yang <axe.yang@mediatek.com> wrote:
> > 
> > On Mon, 2022-07-18 at 14:21 +0200, Ulf Hansson wrote:
> > > On Thu, 23 Jun 2022 at 11:05, Axe Yang <axe.yang@mediatek.com>
> > > wrote:
> > > > 
> > > > Add support for eint IRQ when MSDC is used as an SDIO host.
> > > > This
> > > > feature requires SDIO device support async IRQ function. With
> > > > this
> > > > feature, SDIO host can be awakened by SDIO card in suspend
> > > > state,
> > > > without additional pin.
> > > > 
> > > > MSDC driver will time-share the SDIO DAT1 pin. During suspend,
> > > > MSDC
> > > > turn off clock and switch SDIO DAT1 pin to GPIO mode. And
> > > > during
> > > > resume, switch GPIO function back to DAT1 mode then turn on
> > > > clock.
> > > > 
> > > > Some device tree property should be added or modified in MSDC
> > > > node
> > > > to support SDIO eint IRQ. Pinctrls "state_eint" is mandatory.
> > > > Since
> > > > this feature depends on asynchronous interrupts, "wakeup-
> > > > source",
> > > > "keep-power-in-suspend" and "cap-sdio-irq" flags are necessary,
> > > > and
> > > > the interrupts list should be extended(the interrupt named with
> > > > sdio_wakeup):
> > > >         &mmcX {
> > > >                 ...
> > > >                 interrupt-names = "msdc", "sdio_wakeup";
> > > >                 interrupts-extended = <...>,
> > > >                                       <&pio xxx
> > > > IRQ_TYPE_LEVEL_LOW>;
> > > >                 ...
> > > >                 pinctrl-names = "default", "state_uhs",
> > > > "state_eint";
> > > >                 ...
> > > >                 pinctrl-2 = <&mmc2_pins_eint>;
> > > >                 ...
> > > >                 cap-sdio-irq;
> > > >                 keep-power-in-suspend;
> > > >                 wakeup-source;
> > > >                 ...
> > > >         };
> > > > 
> > > > Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> > > > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > > > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > > 
> > > My apologies for the delay in reviewing this.
> > 
> > It is okay. Glad to receive your reply.
> > 
> > > 
> > > > ---
> > > >  drivers/mmc/host/mtk-sd.c | 84
> > > > ++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 78 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-
> > > > sd.c
> > > > index 195dc897188b..f907b96cfd87 100644
> > > > --- a/drivers/mmc/host/mtk-sd.c
> > > > +++ b/drivers/mmc/host/mtk-sd.c
> > > > @@ -1,6 +1,6 @@
> > > >  // SPDX-License-Identifier: GPL-2.0-only
> > > >  /*
> > > > - * Copyright (c) 2014-2015 MediaTek Inc.
> > > > + * Copyright (c) 2014-2015, 2022 MediaTek Inc.
> > > >   * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
> > > >   */
> > > > 
> > > > @@ -20,6 +20,7 @@
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm.h>
> > > >  #include <linux/pm_runtime.h>
> > > > +#include <linux/pm_wakeirq.h>
> > > >  #include <linux/regulator/consumer.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/spinlock.h>
> > > > @@ -440,8 +441,10 @@ struct msdc_host {
> > > >         struct pinctrl *pinctrl;
> > > >         struct pinctrl_state *pins_default;
> > > >         struct pinctrl_state *pins_uhs;
> > > > +       struct pinctrl_state *pins_eint;
> > > >         struct delayed_work req_timeout;
> > > >         int irq;                /* host interrupt */
> > > > +       int eint_irq;           /* interrupt from sdio device
> > > > for
> > > > waking up system */
> > > >         struct reset_control *reset;
> > > > 
> > > >         struct clk *src_clk;    /* msdc source clock */
> > > > @@ -1520,17 +1523,46 @@ static void
> > > > __msdc_enable_sdio_irq(struct
> > > > msdc_host *host, int enb)
> > > > 
> > > >  static void msdc_enable_sdio_irq(struct mmc_host *mmc, int
> > > > enb)
> > > >  {
> > > > -       unsigned long flags;
> > > >         struct msdc_host *host = mmc_priv(mmc);
> > > > +       unsigned long flags;
> > > > +       int ret;
> > > > 
> > > >         spin_lock_irqsave(&host->lock, flags);
> > > >         __msdc_enable_sdio_irq(host, enb);
> > > >         spin_unlock_irqrestore(&host->lock, flags);
> > > > 
> > > > -       if (enb)
> > > > -               pm_runtime_get_noresume(host->dev);
> > > > -       else
> > > > -               pm_runtime_put_noidle(host->dev);
> > > > +       if (mmc_card_enable_async_irq(mmc->card) && host-
> > > > > pins_eint) {
> > > > 
> > > > +               if (enb) {
> > > > +                       /*
> > > > +                        * In
> > > > dev_pm_set_dedicated_wake_irq_reverse(), eint pin will be set
> > > > to
> > > > +                        * GPIO mode. We need to restore it to
> > > > SDIO
> > > > DAT1 mode after that.
> > > > +                        * Since the current pinstate is
> > > > pins_uhs,
> > > > to ensure pinctrl select take
> > > > +                        * affect successfully, we change the
> > > > pinstate to pins_eint firstly.
> > > > +                        */
> > > > +                       pinctrl_select_state(host->pinctrl,
> > > > host-
> > > > > pins_eint);
> > > 
> > > I am sorry, but I don't understand what goes on here. Why do you
> > > need
> > > to change the pinctrl setting to "pins_eint" here?
> > > 
> > > The bellow call to dev_pm_set_dedicated_wake_irq_reverse()
> > > doesn't
> > > change the pinctrl setting as the comment suggests above.
> > > 
> > 
> > Actually, the pinctrl setting is changed:
> > In dev_pm_set_dedicated_wake_irq_reverse() -> ... ->
> > request_threaded_irq() -> __setup_irq() -> irq_request_resources()
> > ->
> > mtk_eint_irq_request_resources()-> mtk_xt_set_gpio_as_eint(), the
> > SDIO
> > DAT1 pin will be force reset to GPIO mode:
> 
> Aha. That looks a bit weird, but I get the problem now.
> 
> I have looped in Linus (the pintctrl maintainer) to get his opinion
> on this.
> 
Okay.

> > 
> > 
https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c*L339__;Iw!!CTRNKA9wMg0ARbw!10fxyOdpvC-aCfRRWEGS5lXRPC6qJ0Z79tnrnTNbOu8VgamIxVATeM_wDz-obpEJ$
> >  
> > 
> > So, I have to call pinctrl_select_state() to restore SDIO DAT1 pin
> > mode(pins_uhs). But pinctrl_select_state() return directly because
> > MSDC
> > driver still wrongly thinks current DAT1 state is SDIO DAT1 mode:
> > 
> > 
https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/core.c*L1344__;Iw!!CTRNKA9wMg0ARbw!10fxyOdpvC-aCfRRWEGS5lXRPC6qJ0Z79tnrnTNbOu8VgamIxVATeM_wD2q7InpM$
> >  
> > , which means I have to call pinctrl_select_state() in pairs:
> > Change
> > pinctrl to another state(pins_eint), then change it back to
> > pins_uhs
> > mode.
> 
> I see. So a call to pinctrl_select_state("pins_uhs") would not take
> effect, unless we call pinctrl_select_state("pins_eint") first. That
> sounds like the internal state of the pinctrl isn't maintained
> properly.
> 
That is correct. The GPIO mode is modified in a very hidden way, by
pass pinctrl mechanism.

> Let's see what Linus thinks about this.
> 
> Note that, I am happy to pick the patch as is around this, but I am
> worried we might be doing something at the mmc driver level, which
> should really be managed at the pinctrl layer.
> 
Okay. I will release patch V14 after Linus replies.

> > 
> > 
> > > dev_pm_set_dedicated_wake_irq_reverse() will register the
> > > wakeirq,
> > > but
> > > more importantly, it should also leave the wakeirq disabled,
> > > right?
> > 
> > Yes. wakeirq will be registered, and disabled. But SDIO DAT1 pin
> > mode
> > will be changed too.
> > 
> > > 
> > > > +                       ret =
> > > > dev_pm_set_dedicated_wake_irq_reverse(host->dev, host-
> > > > >eint_irq);
> > > > +
> > > > +                       if (ret) {
> > > > +                               dev_err(host->dev, "Failed to
> > > > register SDIO wakeup irq!\n");
> > > > +                               host->pins_eint = NULL;
> > > > +                               pm_runtime_get_noresume(host-
> > > > >dev);
> > > > +                       } else {
> > > > +                               dev_dbg(host->dev, "SDIO eint
> > > > irq:
> > > > %d!\n", host->eint_irq);
> > > > +                       }
> > > > +
> > > > +                       pinctrl_select_state(host->pinctrl,
> > > > host-
> > > > > pins_uhs);
> > > 
> > > According to my comment above, I also don't understand why you
> > > need
> > > this. Why can't you just leave the pinctrl in the "pins_uhs"
> > > state?
> > > 
> > 
> > I have to call pinctrl_select_state() in pairs.
> > 
> > 
> > > > +               } else {
> > > > +                       dev_pm_clear_wake_irq(host->dev);
> > > > +               }
> > > > +       } else {
> > > > +               if (enb) {
> > > > +                       /* Ensure host->pins_eint is NULL */
> > > > +                       host->pins_eint = NULL;
> > > > +                       pm_runtime_get_noresume(host->dev);
> > > > +               } else {
> > > > +                       pm_runtime_put_noidle(host->dev);
> > > > +               }
> > > > +       }
> > > >  }
> 
> [...]
> 
> 
Regards,
Axe

