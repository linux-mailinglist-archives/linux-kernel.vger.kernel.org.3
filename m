Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8257FC17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiGYJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGYJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:13:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272AE13F2A;
        Mon, 25 Jul 2022 02:13:31 -0700 (PDT)
X-UUID: 6f47f0242b804ee9a0ade328cea7e0f5-20220725
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:d45da67b-e461-4ffe-b80d-ed9729f4d661,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:0f94e32,CLOUDID:4c09ded3-912a-458b-a623-74f605a77e93,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 6f47f0242b804ee9a0ade328cea7e0f5-20220725
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 779995484; Mon, 25 Jul 2022 17:13:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 25 Jul 2022 17:13:24 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 25 Jul 2022 17:13:23 +0800
Message-ID: <3747f246650622ef65787159af5271a79401a855.camel@mediatek.com>
Subject: Re: [PATCH v13 3/3] mmc: mediatek: add support for SDIO eint wakup
 IRQ
From:   Axe Yang <axe.yang@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
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
Date:   Mon, 25 Jul 2022 17:13:22 +0800
In-Reply-To: <CACRpkdZ5G2fMCqvkXANVEmZjNcF4U4mSDzZk6aXbqFjYVN3hcA@mail.gmail.com>
References: <20220623090445.1401-1-axe.yang@mediatek.com>
         <20220623090445.1401-4-axe.yang@mediatek.com>
         <CACRpkdZ5G2fMCqvkXANVEmZjNcF4U4mSDzZk6aXbqFjYVN3hcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for the comments, but Ulf and I have some question on pinctrl.

On Fri, 2022-07-22 at 13:21 +0200, Linus Walleij wrote:
> On Thu, Jun 23, 2022 at 11:10 AM Axe Yang <axe.yang@mediatek.com>
> wrote:
> 
> > MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> > turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> > resume, switch GPIO function back to DAT1 mode then turn on clock.
> 
> So what I see is that you have what the electronics chip people call
> an armed pad ring, such that an asynchronous event detector is
> connected
> to the pin when it is in GPIO mode, and in this mode the system
> can enter a lower sleep state (like powering off the MMC block
> silicon...)
> 
> That seems fine, this is definitely how the chip people expected
> it to work.
> 
> > +       if (mmc_card_enable_async_irq(mmc->card) && host-
> > >pins_eint) {
> > +               if (enb) {
> > +                       /*
> > +                        * In
> > dev_pm_set_dedicated_wake_irq_reverse(), eint pin will be set to
> > +                        * GPIO mode. We need to restore it to SDIO
> > DAT1 mode after that.
> > +                        * Since the current pinstate is pins_uhs,
> > to ensure pinctrl select take
> > +                        * affect successfully, we change the
> > pinstate to pins_eint firstly.
> > +                        */
> > +                       pinctrl_select_state(host->pinctrl, host-
> > >pins_eint);
> > +                       ret =
> > dev_pm_set_dedicated_wake_irq_reverse(host->dev, host->eint_irq);
> > +
> > +                       if (ret) {
> > +                               dev_err(host->dev, "Failed to
> > register SDIO wakeup irq!\n");
> > +                               host->pins_eint = NULL;
> > +                               pm_runtime_get_noresume(host->dev);
> > +                       } else {
> > +                               dev_dbg(host->dev, "SDIO eint irq:
> > %d!\n", host->eint_irq);
> > +                       }
> > +
> > +                       pinctrl_select_state(host->pinctrl, host-
> > >pins_uhs);
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
> 
> This looks right.

SDIO DAT1 pin mode is changed to GPIO mode in
dev_pm_set_dedicated_wake_irq_reverse():

https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c#L339

dev_pm_set_dedicated_wake_irq_reverse() -> ... ->request_threaded_irq()
-> __setup_irq() -> irq_request_resources() ->
mtk_eint_irq_request_resources()-> mtk_xt_set_gpio_as_eint()


To restore SDIO DAT1 pin to uhs mode. I have to call
pinctrl_select_state() twice(change pinctrl to another state, then
change back to uhs mode). Ulf worried we might be doing something at
the mmc driver level, which should really be managed at the pinctrl
layer.

Do you have any comment or suggestion on this?


> 
> > +       /* Support for SDIO eint irq ? */
> > +       if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps
> > & MMC_PM_KEEP_POWER)) {
> > +               host->eint_irq = platform_get_irq_byname(pdev,
> > "sdio_wakeup");
> > +               if (host->eint_irq > 0) {
> > +                       host->pins_eint =
> > pinctrl_lookup_state(host->pinctrl, "state_eint");
> 
> I guess one of the other patches adds this to the DT binding?

Yes. The property related change is in patch 1/3

> 
> With that:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

Regards,
Axe


