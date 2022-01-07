Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE448740C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbiAGIUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:20:00 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:51544 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229747AbiAGIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:19:59 -0500
X-UUID: e9acf4ff940041b7899a31d39b7fe6e8-20220107
X-UUID: e9acf4ff940041b7899a31d39b7fe6e8-20220107
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 608333862; Fri, 07 Jan 2022 16:19:57 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 Jan 2022 16:19:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 Jan
 2022 16:19:55 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 16:19:54 +0800
Message-ID: <21ba4c9d2f3a7a3d8c12b303fc6bea4b19ef092f.camel@mediatek.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: add cap-sdio-async-int flag
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
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 7 Jan 2022 16:19:54 +0800
In-Reply-To: <YdTLI/Nms4JiNutt@robh.at.kernel.org>
References: <20211227083641.12538-1-axe.yang@mediatek.com>
         <20211227083641.12538-2-axe.yang@mediatek.com>
         <YdTLI/Nms4JiNutt@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-04 at 16:33 -0600, Rob Herring wrote:
> On Mon, Dec 27, 2021 at 04:36:39PM +0800, Axe Yang wrote:
> > Asynchronous interrupt is a mechanism that allow SDIO devices alarm
> > interrupt when host stop providing clock to card. Add a DT flag to
> > enable this feature if it is supported by SDIO card.
> 
> A card property should be in the card node. Is this not discoverable?

Thank you for your comment.
Async interrupt is not a 'card property', but more like a protocol.
The intention of this flag is to decide whether to support this feature
on SDIO host side.
Before that, host need to confirm that async interrupt is supported on
card side(by read and parse Support Async Interrupt segment in CCCR
from card).

> 
> > 
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5
> > +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-
> > controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-
> > controller.yaml
> > index 25ac8e200970..7230421583c6 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > @@ -165,6 +165,11 @@ properties:
> >      description:
> >        eMMC hardware reset is supported
> >  
> > +  cap-sdio-async-int:
> 
> Perhaps be consistent with the next property and use 'irq'.

Will fix it in next version.

> 
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      SDIO async interrupt is supported.
> > +
> >    cap-sdio-irq:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:
> > -- 
> > 2.25.1
> > 
> > 

