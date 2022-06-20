Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9676550EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiFTDmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiFTDmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:42:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C966264;
        Sun, 19 Jun 2022 20:42:05 -0700 (PDT)
X-UUID: 060d0ace9c6d4967b1d11c07e9d1014d-20220620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:e49ae9f1-1a36-4560-a5cd-c49208319b95,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:ce8ef5e9-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 060d0ace9c6d4967b1d11c07e9d1014d-20220620
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 63311185; Mon, 20 Jun 2022 11:42:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 20 Jun 2022 11:41:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Jun 2022 11:41:57 +0800
Message-ID: <c1d2d51c016ad74dc9516c7f9ac85343f79f9d9a.camel@mediatek.com>
Subject: Re: [RESEND v12 3/3] mmc: mediatek: add support for SDIO eint wakup
 IRQ
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
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
Date:   Mon, 20 Jun 2022 11:41:57 +0800
In-Reply-To: <CAPDyKFqq64L3_Mco2aEbu6mC_W98pPpwk4kd1F1um0pHVR5oOw@mail.gmail.com>
References: <20220525015140.384-1-axe.yang@mediatek.com>
         <20220525015140.384-4-axe.yang@mediatek.com>
         <CAPDyKFqq64L3_Mco2aEbu6mC_W98pPpwk4kd1F1um0pHVR5oOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 16:13 +0200, Ulf Hansson wrote:
> On Wed, 25 May 2022 at 03:51, Axe Yang <axe.yang@mediatek.com> wrote:
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
> > to support SDIO eint IRQ. Pinctrls "state_eint" is mandatory. Since
> > this feature depends on asynchronous interrupts, "wakeup-source",
> > "keep-power-in-suspend" and "cap-sdio-irq" flags are necessary, and
> > the interrupts list should be extended(the interrupt named with
> > sdio_wakeup):
> >         &mmcX {
> >                 ...
> >                 interrupt-names = "msdc", "sdio_wakeup";
> >                 interrupts-extended = <...>,
> >                                       <&pio xxx
> > IRQ_TYPE_LEVEL_LOW>;
> >                 ...
> >                 pinctrl-names = "default", "state_uhs",
> > "state_eint";
> >                 ...
> >                 pinctrl-2 = <&mmc2_pins_eint>;
> >                 ...
> >                 cap-sdio-irq;
> >                 keep-power-in-suspend;
> >                 wakeup-source;
> >                 ...
> >         };
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 80
> > ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 74 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 195dc897188b..2d5b23616df6 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * Copyright (c) 2014-2015 MediaTek Inc.
> > + * Copyright (c) 2014-2015, 2022 MediaTek Inc.
> >   * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
> >   */
> > 
> > @@ -20,6 +20,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/pm_wakeirq.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > @@ -440,8 +441,10 @@ struct msdc_host {
> >         struct pinctrl *pinctrl;
> >         struct pinctrl_state *pins_default;
> >         struct pinctrl_state *pins_uhs;
> > +       struct pinctrl_state *pins_eint;
> >         struct delayed_work req_timeout;
> >         int irq;                /* host interrupt */
> > +       int eint_irq;           /* interrupt from sdio device for
> > waking up system */
> >         struct reset_control *reset;
> > 
> >         struct clk *src_clk;    /* msdc source clock */
> > @@ -1520,17 +1523,41 @@ static void __msdc_enable_sdio_irq(struct
> > msdc_host *host, int enb)
> > 
> >  static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> >  {
> > -       unsigned long flags;
> >         struct msdc_host *host = mmc_priv(mmc);
> > +       unsigned long flags;
> > +       int ret;
> > 
> >         spin_lock_irqsave(&host->lock, flags);
> >         __msdc_enable_sdio_irq(host, enb);
> >         spin_unlock_irqrestore(&host->lock, flags);
> > 
> > -       if (enb)
> > -               pm_runtime_get_noresume(host->dev);
> > -       else
> > -               pm_runtime_put_noidle(host->dev);
> > +       if (mmc_card_enable_async_irq(mmc->card) && host-
> > >pins_eint) {
> > +               if (enb) {
> > +                       pinctrl_select_state(host->pinctrl, host-
> > >pins_eint);
> 
> This looks a bit odd to me. The pins are not supposed to be
> configured
> for wakeirq at this point, right?
> 
> As I understand it, the pin state for wakeirq should be set from the
> ->runtime_suspend() callback, no?

Yes, it is odd, but necessary.
In dev_pm_set_dedicated_wake_irq_reverse() -> ... ->
request_threaded_irq() -> __setup_irq() -> irq_request_resources() ->
mtk_eint_irq_request_resources(), the SDIO DAT1 pin will be force reset
to GPIO mode.
I have to call pinctrl_select_state() in pairs to restore DAT1 pin
state to MSDC mode.

> 
> > +                       ret =
> > dev_pm_set_dedicated_wake_irq_reverse(host->dev, host->eint_irq);
> > +
> > +                       if (ret) {
> > +                               dev_err(host->dev, "Failed to
> > register SDIO wakeup irq!\n");
> > +                               host->pins_eint = NULL;
> > +                               pm_runtime_get_noresume(host->dev);
> > +                       } else {
> > +                               dev_info(host->dev, "SDIO eint irq:
> > %d!\n", host->eint_irq);
> 
> If you want to log a message, please use a dev_dbg for this instead.

Sure, will change to dev_dbg in next version.

> 
> > +                               device_init_wakeup(host->dev,
> > true);
> 
> To me, it looks like this is better called from ->probe(), once.

Will move it to probe() in next version.

> 
> > +                       }
> > +
> > +                       pinctrl_select_state(host->pinctrl, host-
> > >pins_uhs);
> 
> Assuming that we can drop the earlier call to pinctrl_select_state()
> to set "host->pins_eint", this call can be dropped too.

Can not drop this call, it is for restore DAT1 pinmux to MSDC mode.

> 
> > +               } else {
> > +                       dev_pm_clear_wake_irq(host->dev);
> > +               }
> > +       } else {
> > +               if (enb) {
> > +                       /* Ensure host->pins_eint is NULL */
> > +                       host->pins_eint = NULL;
> > +                       pm_runtime_get_noresume(host->dev);
> > +               } else {
> > +                       pm_runtime_put_noidle(host->dev);
> > +               }
> > +       }
> >  }
> > 
> >  static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32
> > intsts)
> > @@ -2631,6 +2658,19 @@ static int msdc_drv_probe(struct
> > platform_device *pdev)
> >                 goto host_free;
> >         }
> > 
> > +       /* Support for SDIO eint irq ? */
> > +       if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps
> > & MMC_PM_KEEP_POWER)) {
> > +               host->eint_irq = platform_get_irq_byname(pdev,
> > "sdio_wakeup");
> > +               if (host->eint_irq > 0) {
> > +                       host->pins_eint =
> > pinctrl_lookup_state(host->pinctrl, "state_eint");
> > +                       if (IS_ERR(host->pins_eint)) {
> > +                               dev_err_probe(&pdev->dev,
> > PTR_ERR(host->pins_eint),
> > +                                             "Cannot find pinctrl
> > eint!\n");
> 
> We can probably use dev_err() instead of dev_err_probe() as
> pinctrl_lookup_state() should never return -EPROBE_DEFER, I think.

Yes. will update that in next version.

> 
> > +                               host->pins_eint = NULL;
> > +                       }
> > +               }
> > +       }
> > +
> >         msdc_of_property_parse(pdev, host);
> > 
> >         host->dev = &pdev->dev;
> > @@ -2845,6 +2885,12 @@ static int __maybe_unused
> > msdc_runtime_suspend(struct device *dev)
> >         struct msdc_host *host = mmc_priv(mmc);
> > 
> >         msdc_save_reg(host);
> > +
> > +       if (sdio_irq_claimed(mmc) && host->pins_eint) {
> > +               disable_irq(host->irq);
> > +               pinctrl_select_state(host->pinctrl, host-
> > >pins_eint);
> > +               sdr_clr_bits(host->base + SDC_CFG,
> > SDC_CFG_SDIOIDE);
> 
> __msdc_enable_sdio_irq() also calls "sdr_clr_bits(host->base +
> MSDC_INTEN, MSDC_INTEN_SDIOIRQ);"
> 
> Perhaps we should call __msdc_enable_sdio_irq() here instead? To be
> consistent.

Yes, we can call __msdc_enable_sdio_irq() instead. Will update that in
next verison.

> 
> > +       }
> >         msdc_gate_clock(host);
> >         return 0;
> >  }
> > @@ -2860,12 +2906,19 @@ static int __maybe_unused
> > msdc_runtime_resume(struct device *dev)
> >                 return ret;
> > 
> >         msdc_restore_reg(host);
> > +
> > +       if (sdio_irq_claimed(mmc) && host->pins_eint) {
> 
> msdc_restore_reg() already calls __msdc_enable_sdio_irq(), but based
> only upon whether sdio_irq_claimed() returns true.
> 
Will remove redundancy MSDC_INTEN_SDIOIRQ control in
msdc_runtion_resume() in next version.

> It looks like we should align the code in
> msdc_runtime_resume|suspend(). Perhaps sdio_irq_claimed() should
> indicate in both cases that __msdc_enable_sdio_irq() needs to be
> called, while "host->pins_eint" means that we have also additional
> wakeup configurations (pins and irqs) to handle.

sdr_set_bits(..., SDC_CFG_SDIOIDE) is only needed when wake up irq is
enabled. So, maybe I can refactor this part as below:
   if (host->pins_eint) {
   	...
   	if (sdio_irq_claimed()) 
   		__msdc_enable_sdio_irq(host, 0);
   	...
   }
in msdc_runtime_suspend() ?

in msdc_runtime_resume(), __msdc_enable_sdio_irq() is called in
msdc_restore_reg(). 
While in msdc_runtime_suspend(), it is called only if  host->pins_eint
return true.
In this case, msdc_runtime_resume|suspend() are not prefectly aligned.
Any better way to do that?

> 
> > +               sdr_set_bits(host->base + SDC_CFG,
> > SDC_CFG_SDIOIDE);
> > +               pinctrl_select_state(host->pinctrl, host-
> > >pins_uhs);
> > +               enable_irq(host->irq);
> > +       }
> >         return 0;
> >  }
> > 
> >  static int __maybe_unused msdc_suspend(struct device *dev)
> >  {
> >         struct mmc_host *mmc = dev_get_drvdata(dev);
> > +       struct msdc_host *host = mmc_priv(mmc);
> >         int ret;
> > 
> >         if (mmc->caps2 & MMC_CAP2_CQE) {
> > @@ -2874,11 +2927,26 @@ static int __maybe_unused
> > msdc_suspend(struct device *dev)
> >                         return ret;
> >         }
> > 
> > +       if (sdio_irq_claimed(mmc) && host->pins_eint) {
> > +               pm_runtime_put_sync_suspend(dev);
> > +
> > +               return 0;
> > +       }
> > +
> 
> I assume the point with the above is to trigger rpm_suspend() to be
> called for the device, so that the wakeirq can be enabled, correctly?

Yes, the intention is to trigger rpm_suspend|resume(), with these two
functions all operations on wakeirq can be performed completely.
But with pm_rumtime_force_resume(), dev->power.needs_force_resume is
false, the function goto out directly everytime.

> 
> However, this isn't the correct way to do it (for various reasons I
> can explain, if you want). Instead I think there are two options
> going
> forward:
> 1. Deal with the wakeirq from the system suspend/resume callbacks,
> locally in the driver.
> 2. Extend pm_runtime_force_suspend|resume() to let it deal with the
> wakeirq for us. Similar to what rpm_suspend|resume() do.
> 
> I am inclined to try with option 2) first, as this would prevent the
> boilerplate code that otherwise gets introduced by option 1). To help
> out, I have prepared a patch that I am about to send, I will keep you
> posted.

Thanks for the patch. And I still need to use pm_runtime_get_noresume()
to bump up runtime PM usage counter to ensure pm_rumtime_force_resume()
can be fully executed.

> 
> >         return pm_runtime_force_suspend(dev);
> >  }
> > 
> >  static int __maybe_unused msdc_resume(struct device *dev)
> >  {
> > +       struct mmc_host *mmc = dev_get_drvdata(dev);
> > +       struct msdc_host *host = mmc_priv(mmc);
> > +
> > +       if (sdio_irq_claimed(mmc) && host->pins_eint) {
> > +               pm_runtime_get_sync(dev);
> 
> Similar comments apply to this as for msdc_suspend().

pm_runtime_put_noidle() will be added here to decrement runtime PM
usage counter. Do you have any comments on this?

> 
> > +
> > +               return 0;
> > +       }
> > +
> >         return pm_runtime_force_resume(dev);
> >  }
> > 
> 
> Kind regards
> Uffe

Regards,
Axe

