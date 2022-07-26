Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C1580E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbiGZHqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbiGZHqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:46:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726E21EC45;
        Tue, 26 Jul 2022 00:46:43 -0700 (PDT)
X-UUID: 9886849c35ce484996f3f0e089e87278-20220726
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:c9437132-4ba2-4ef5-811a-421fe6f21749,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:c9437132-4ba2-4ef5-811a-421fe6f21749,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:9f5e84b3-06d2-48ef-b2dd-540836705165,C
        OID:167e827dc092,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9886849c35ce484996f3f0e089e87278-20220726
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 533270541; Tue, 26 Jul 2022 15:46:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 26 Jul 2022 15:46:35 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jul 2022 15:46:34 +0800
Message-ID: <aface69bc8eeb0a34805428fa36d13f7909f694d.camel@mediatek.com>
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
Date:   Tue, 26 Jul 2022 15:46:34 +0800
In-Reply-To: <CACRpkdZP-FBP8hsBfeMn1M8=VR_cYG+j9GQc9VdV-HjkvSo73w@mail.gmail.com>
References: <20220623090445.1401-1-axe.yang@mediatek.com>
         <20220623090445.1401-4-axe.yang@mediatek.com>
         <CACRpkdZ5G2fMCqvkXANVEmZjNcF4U4mSDzZk6aXbqFjYVN3hcA@mail.gmail.com>
         <3747f246650622ef65787159af5271a79401a855.camel@mediatek.com>
         <CACRpkdZP-FBP8hsBfeMn1M8=VR_cYG+j9GQc9VdV-HjkvSo73w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-25 at 14:46 +0200, Linus Walleij wrote:
> On Mon, Jul 25, 2022 at 11:13 AM Axe Yang <axe.yang@mediatek.com>
> wrote:
> > On Fri, 2022-07-22 at 13:21 +0200, Linus Walleij wrote:
> > > On Thu, Jun 23, 2022 at 11:10 AM Axe Yang <axe.yang@mediatek.com>
> > > wrote:
> > SDIO DAT1 pin mode is changed to GPIO mode in
> > dev_pm_set_dedicated_wake_irq_reverse():
> > 
> > 
https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c*L339__;Iw!!CTRNKA9wMg0ARbw!zE3kmi37pZw4HiBNeRipWbi3gbAqrljLVQc5JVz-WP_NaIWTVhXshkakjFNh478e$
> >  
> > 
> > dev_pm_set_dedicated_wake_irq_reverse() -> ...
> > ->request_threaded_irq()
> > -> __setup_irq() -> irq_request_resources() ->
> > mtk_eint_irq_request_resources()-> mtk_xt_set_gpio_as_eint()
> 
> This doesn't seem to have much to do with pin control?
> No pin control functions are called on this execution path,
> no pin control state is changed, right?

That's right, no pin control state is changed.

> 
> If what you mean is that
> it happens to poke into the same hardware registers that is
> mainly a matter of concurrency in the driver, sometimes two
> abstractions happen to have to poke into the same hardware
> registers and then it is up to the driver to maintain state for
> the hardware, this is not a question for the framework.
> 
> How is Mediatek developers thinking about this thing in general?
> You are a few people who developed the driver so certainly
> you must have some design idea to why irq_request_resources()
> poke around in these registers? Does it even perform pin
> control behind the back of the pin control framework?

I see. It is sensible to reset pin function to GPIO mode when trying to
register the pin to eint mode, and the operation is out of pinctrl
framework.

Seems like maintain the pin state in driver is the only way to fix the
pin function conflict.

> 
> > To restore SDIO DAT1 pin to uhs mode. I have to call
> > pinctrl_select_state() twice(change pinctrl to another state, then
> > change back to uhs mode). Ulf worried we might be doing something
> > at
> > the mmc driver level, which should really be managed at the pinctrl
> > layer.
> > 
> > Do you have any comment or suggestion on this?
> 
> The pin control state transitions are really just finite automata.
> 
> Your pin control needs to be different when using wakeup from
> when being used for SDIO and this is perfectly fine, it's no
> different from the fact that the regulator and clock might need
> to be in different states, so I don't quite understand the
> question?

I see. At first I thought that pinctrl framework should be aware of
the hidden modification of pin function. But as you said, it is just
a finite automata. Driver should correct GPIO settings by itself if pin
state be changed outside pin control state mechanical.
Sorry for the noise, and thanks for your comment again.

> 
> 
Regards,
Axe

