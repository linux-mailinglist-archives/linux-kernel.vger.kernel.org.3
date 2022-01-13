Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AEA48D23B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiAMGG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:06:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46144 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229735AbiAMGG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:06:27 -0500
X-UUID: 5f6d5294ddcc45a5baa37963d31ac327-20220113
X-UUID: 5f6d5294ddcc45a5baa37963d31ac327-20220113
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1853387206; Thu, 13 Jan 2022 14:06:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 14:06:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 14:06:20 +0800
Message-ID: <1eb2bc6432aa5a1c0371542457a86764df77153b.camel@mediatek.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: memory: mtk-smi: Fix the larb
 clock/clock-names dtbs warning
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <lc.kan@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Thu, 13 Jan 2022 14:06:20 +0800
In-Reply-To: <b8b8fe77-2ea8-d05c-5fa2-d4cae01baba5@canonical.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
         <20220111063904.7583-3-yong.wu@mediatek.com>
         <b8b8fe77-2ea8-d05c-5fa2-d4cae01baba5@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-12 at 11:18 +0100, Krzysztof Kozlowski wrote:
> On 11/01/2022 07:39, Yong Wu wrote:
> > Mute the warning from "make dtbs_check":
> > 
> > larb@14017000: clock-names: ['apb', 'smi'] is too short
> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > burnet.dt.yaml
> > 	...
> > 
> > larb@16010000: clock-names: ['apb', 'smi'] is too short
> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > burnet.dt.yaml
> > 
> > larb@17010000: clock-names: ['apb', 'smi'] is too short
> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > burnet.dt.yaml
> > 
> > If a platform's larb supports gals, there will be some larbs have
> > one
> > more "gals" clock while the others still only need "apb"/"smi"
> > clocks,
> > then the minItems for clock and clock-names are 2.
> > 
> > Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to
> > DT schema")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 6
> > +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-
> > controllers/mediatek,smi-larb.yaml
> > b/Documentation/devicetree/bindings/memory-
> > controllers/mediatek,smi-larb.yaml
> > index 80907e357892..884c0c74e5e4 100644
> > --- a/Documentation/devicetree/bindings/memory-
> > controllers/mediatek,smi-larb.yaml
> > +++ b/Documentation/devicetree/bindings/memory-
> > controllers/mediatek,smi-larb.yaml
> > @@ -80,10 +80,10 @@ allOf:
> >      then:
> >        properties:
> >          clock:
> 
> Separate patch:
> This should be clocks. The same in second if. Now it is simply not
> working...
> 
> > -          items:
> 
> Putting min/maxItems under items is wrong. The second if also needs
> the
> fixing. Please make it a separate patch before this one.

Oh. I will use a new patch for renaming "clock" to "clocks" and
removing the "items".

Thanks.

> 
> The schema was clearly not tested before...
> 
> 
> > -            minItems: 3
> > -            maxItems: 3
> > +          minItems: 2
> > +          maxItems: 3
> >          clock-names:
> > +          minItems: 2
> >            items:
> >              - const: apb
> >              - const: smi
> > 
> 
> 
> Best regards,
> Krzysztof

