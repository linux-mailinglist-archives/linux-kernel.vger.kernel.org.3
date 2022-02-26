Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626184C538D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 04:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiBZDZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 22:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiBZDZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 22:25:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3922A66FA;
        Fri, 25 Feb 2022 19:24:51 -0800 (PST)
X-UUID: 4e154502a2f54f34b9485a1a52a4924e-20220226
X-UUID: 4e154502a2f54f34b9485a1a52a4924e-20220226
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 354081521; Sat, 26 Feb 2022 11:24:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 26 Feb 2022 11:24:46 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Feb 2022 11:24:46 +0800
Message-ID: <55a65e5aa412f101e02c81ddb5fa38c128743db2.camel@mediatek.com>
Subject: Re: [PATCH V2 3/6] dt-bindings: spi: Add compatible for Mediatek
 IPM IP with quad mode
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Sat, 26 Feb 2022 11:24:46 +0800
In-Reply-To: <YhknmEtjpN7Lmoru@robh.at.kernel.org>
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
         <20220221040717.3729-4-leilk.liu@mediatek.com>
         <YhknmEtjpN7Lmoru@robh.at.kernel.org>
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

On Fri, 2022-02-25 at 13:01 -0600, Rob Herring wrote:
> On Mon, Feb 21, 2022 at 12:07:14PM +0800, Leilk Liu wrote:
> > This patch adds dt-binding documentation for Mediatek SPI IPM IP
> > with
> > quad mode.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1
> > +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > index 0a2fc0404cb3..241c0f5880d3 100644
> > --- a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > @@ -42,6 +42,7 @@ properties:
> >                - mediatek,mt8173-spi
> >                - mediatek,mt8183-spi
> >                - mediatek,ipm-spi-single
> > +              - mediatek,ipm-spi-quad
> 
> Can't you use the existing width properties to distinguish? Or is
> the 
> programming not a superset?
> 
"mediatek,ipm-spi-quad" include the feature of "mediatek,ipm-spi-
single".

> Is 'ipm' an SoC? If not, these need to be SoC specific.
> 
IPM is an version of SPI ip, we use this IP with ICs now.
So I define a compatible strings "mediatek,ipm-spi-xxx", then I can
reuse this strings with many ICs.
Currently, we plan to upstream MT7986 IC, this IC has two spi
controller ports, one support single mode only, the other support
single & quad mode both.
for example:
spi0 {
  ...
  compatible = "mediatek,ipm-spi-single";
  ...
}

spi1 {
  ...
  compatible = "mediatek,ipm-spi-quad";
  ...
}


> Rob

