Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81CA4F5F36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiDFNNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiDFNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:12:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B14E1D1E;
        Wed,  6 Apr 2022 02:49:44 -0700 (PDT)
X-UUID: 61da098c1a8f4141b6812e69d4ab8532-20220406
X-UUID: 61da098c1a8f4141b6812e69d4ab8532-20220406
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1250012946; Wed, 06 Apr 2022 17:38:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 6 Apr 2022 17:38:38 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 17:38:37 +0800
Message-ID: <d7c0b9573e32d68c25444e48e6df1bba0eb64262.camel@mediatek.com>
Subject: Re: [PATCH v9 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
From:   Axe Yang <axe.yang@mediatek.com>
To:     Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
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
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 6 Apr 2022 17:38:37 +0800
In-Reply-To: <Ykc53EmCaA7TadRK@robh.at.kernel.org>
References: <20220329032913.8750-1-axe.yang@mediatek.com>
         <20220329032913.8750-2-axe.yang@mediatek.com>
         <CAPDyKFqoTN1pF-L6qCHxpdMCmPtHP0aHHaDURN2QJsN3v+wZBw@mail.gmail.com>
         <Ykc53EmCaA7TadRK@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-01 at 12:43 -0500, Rob Herring wrote:
> On Fri, Apr 01, 2022 at 11:22:13AM +0200, Ulf Hansson wrote:
> > On Tue, 29 Mar 2022 at 05:29, Axe Yang <axe.yang@mediatek.com>
> > wrote:
> > > 
> > > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > > This feature allow SDIO devices alarm asynchronous interrupt to
> > > host
> > > even when host stop providing clock to SDIO card. An extra wakeup
> > > interrupt and pinctrl states for SDIO DAT1 pin state switching
> > > are
> > > required in this scenario.
> > > 
> > > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/mmc/mtk-sd.yaml         | 17
> > > ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > index 297ada03e3de..3872a6ce2867 100644
> > > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > @@ -69,12 +69,22 @@ properties:
> > >        - const: ahb_cg
> > > 
> > >    interrupts:
> > > -    maxItems: 1
> > > +    description:
> > > +      Should at least contain MSDC GIC interrupt. To support
> > > SDIO in-band wakeup, an extended
> > > +      interrupt is required and be configured as wakeup source
> > > irq.
> > 
> > If I understand correctly, the extended interrupt (a GPIO irq) may
> > not
> > necessarily share the same interrupt parent as the primary device
> > interrupt.
> > 
> > Perhaps it's then better to extend this with "interrupts-extended"
> > instead. See Documentation/devicetree/bindings/interrupt-
> > controller/interrupts.txt.
> 
> 'interrupts-extended' is interchangeable with 'interrupts'. For
> schemas, 
> use 'interrupts' and the tools take care of supporting both forms.
> 

hello Ulf, you are right, the wakeup interrupt(parent is &pio) do not
share same parent as primary interrupt(parent is &gic). And as you
said, I am using "interrupts-extended" to declare the wakeup irq, see
commit message in patch 3/3:
         &mmcX {
                 ...
                 interrupts-extended = <...>,
                                       <&pio xxx IRQ_TYPE_LEVEL_LOW>;
                 ...
                 pinctrl-names = "default", "state_uhs", "state_eint";
                 ...
                 pinctrl-2 = <&mmc2_pins_eint>;
                 ...
                 cap-sdio-irq;
                 keep-power-in-suspend;
                 wakeup-source;
                 ...
         };

But the wakup interrupt is for SDIO only, in most instances, MSDC is
been used as eMMC/SD card host, they do not need this interrupt. So as
Rob suggested, I think we'd better keep using 'interrupts'. And I will
update the description for 'interrupts', suggest to use 'interrupts-
extended' to declare SDIO wakeup interrupt.

And 'interrupt-names' is a good idea, I will add this property to
document too. Thank you for the advice.

Regards,
Axe


