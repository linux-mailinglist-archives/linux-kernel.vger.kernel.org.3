Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2694E3603
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiCVBgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiCVBgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:36:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764EDD2;
        Mon, 21 Mar 2022 18:35:11 -0700 (PDT)
X-UUID: abf182d065b1441099eb1659cab90541-20220322
X-UUID: abf182d065b1441099eb1659cab90541-20220322
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1999322037; Tue, 22 Mar 2022 09:35:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 22 Mar 2022 09:35:03 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Mar 2022 09:35:01 +0800
Message-ID: <b03df175f871ee9a6561862f5bd7bceb9cafbde1.camel@mediatek.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
From:   Axe Yang <axe.yang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
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
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 22 Mar 2022 09:35:01 +0800
In-Reply-To: <YjkKURNzg8JPbXcg@robh.at.kernel.org>
References: <20220321115133.32121-1-axe.yang@mediatek.com>
         <20220321115133.32121-2-axe.yang@mediatek.com>
         <YjkKURNzg8JPbXcg@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-21 at 18:29 -0500, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 07:51:32PM +0800, Axe Yang wrote:
> > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > This feature allow SDIO devices alarm asynchronous interrupt to
> > host
> > even when host stop providing clock to SDIO card. An extra wakeup
> > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > required in this scenario.
> > 
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml       | 23
> > ++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 297ada03e3de..f57774535a1d 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -69,12 +69,23 @@ properties:
> >        - const: ahb_cg
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    description:
> > +      Should at least contain MSDC GIC interrupt. To support SDIO
> > in-band wakeup, an extended
> > +      interrupt is required and be configured as wakeup source
> > irq.
> > +    minItems: 1
> > +    maxItems: 2
> >  
> >    pinctrl-names:
> > +    description:
> > +      Should at least contain default and state_uhs. To support
> > SDIO in-band wakeup, dat1 pin
> > +      will be switched between GPIO mode and SDIO DAT1 mode,
> > state_eint and state_dat1 are
> > +      mandatory in this scenarios.
> > +    minItems: 2
> >      items:
> >        - const: default
> >        - const: state_uhs
> > +      - const: state_eint
> > +      - const: state_dat1
> >  
> >    pinctrl-0:
> >      description:
> > @@ -86,6 +97,16 @@ properties:
> >        should contain uhs mode pin ctrl.
> >      maxItems: 1
> >  
> > +  pinctrl-2:
> > +    description:
> > +      should switch dat1 pin to GPIO mode.
> > +    maxItems: 1
> > +
> > +  pinctrl-3:
> > +    description:
> > +      should switch SDIO dat1 pin from GPIO mode back to SDIO
> > mode.
> 
> How is this different than pinctrl-0?

pinctrl-0 contains default settings for all IO pins(CLK/CMD/DAT).
pinctrl-1 contains settings for all IO pins(CLK/CMD/DAT) in UHS mode.
pinctrl-3 is lightweight pinctrl-1, only keep SDIO DAT1 pin function
switch part.

...

Regards,
Axe

