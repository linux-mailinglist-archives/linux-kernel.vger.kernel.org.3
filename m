Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E876D4C5387
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 04:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiBZDPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 22:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiBZDPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 22:15:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8ED274862;
        Fri, 25 Feb 2022 19:14:42 -0800 (PST)
X-UUID: e21475f7b4c549fc9a0f10ba516aafd6-20220226
X-UUID: e21475f7b4c549fc9a0f10ba516aafd6-20220226
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 196907578; Sat, 26 Feb 2022 11:14:36 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 26 Feb 2022 11:14:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 26 Feb
 2022 11:14:35 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Feb 2022 11:14:34 +0800
Message-ID: <f879ce25aab1d7e4a413455cb2a2454930cc9164.camel@mediatek.com>
Subject: Re: [PATCH V2 5/6] dt-bindings: spi: support spi-hclk
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Sat, 26 Feb 2022 11:14:34 +0800
In-Reply-To: <YhkoEJiLMs8jfUAm@robh.at.kernel.org>
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
         <20220221040717.3729-6-leilk.liu@mediatek.com>
         <YhkoEJiLMs8jfUAm@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-25 at 13:03 -0600, Rob Herring wrote:
> On Mon, Feb 21, 2022 at 12:07:16PM +0800, Leilk Liu wrote:
> > this patch support spi-hclk.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 2
> > ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > index 241c0f5880d3..6920ced5451e 100644
> > --- a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > @@ -55,12 +55,14 @@ properties:
> >        - description: clock used for the parent clock
> >        - description: clock used for the muxes clock
> >        - description: clock used for the clock gate
> > +      - description: clock used for the AHB bus, this clock is
> > optional
> 
> Not optional unless you have minItems.
> 
OK, I'll add minItems,thanks for your comment.

> >  
> >    clock-names:
> 
>        minItems: 3
> 
Got it, thanks

> 
> >      items:
> >        - const: parent-clk
> >        - const: sel-clk
> >        - const: spi-clk
> > +      - const: spi-hclk
> >  
> >    mediatek,pad-select:
> >      $ref: /schemas/types.yaml#/definitions/uint32-array
> > -- 
> > 2.25.1
> > 
> > 

