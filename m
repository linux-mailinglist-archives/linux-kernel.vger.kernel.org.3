Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505894FBBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244808AbiDKMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbiDKMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:13:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B906429;
        Mon, 11 Apr 2022 05:10:45 -0700 (PDT)
X-UUID: b3d4348c781f464c8f6c0433de27ffe1-20220411
X-UUID: b3d4348c781f464c8f6c0433de27ffe1-20220411
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1197825930; Mon, 11 Apr 2022 20:10:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 11 Apr 2022 20:10:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 20:10:42 +0800
Message-ID: <fe7d2b878c18a42ff36ebd9911ecb562fe29c953.camel@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: mediatek: Add mtk cci
 devfreq dt-bindings
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <cw00.choi@samsung.com>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>
CC:     <khilman@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 11 Apr 2022 20:10:42 +0800
In-Reply-To: <855d7daa-45d1-d6d8-32bd-51778cf58392@linaro.org>
References: <20220408052150.22536-1-johnson.wang@mediatek.com>
         <20220408052150.22536-2-johnson.wang@mediatek.com>
         <855d7daa-45d1-d6d8-32bd-51778cf58392@linaro.org>
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

Hi Krzysztof,
On Fri, 2022-04-08 at 10:17 +0200, Krzysztof Kozlowski wrote:
> On 08/04/2022 07:21, Johnson Wang wrote:
> > Add devicetree binding of mtk cci devfreq on MediaTek SoC.
> > 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > ---
> >  .../devicetree/bindings/devfreq/mtk-cci.yaml  | 72
> > +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/devfreq/mtk-
> > cci.yaml
> 
> Filename with vendor prefix, so something like:
> 
> mediatek,cci.yaml

Thank you for your review.
I will take your advice in the next version.
> 
> Also please put it in the "interconnect" directory.
> 

I don't really know about "interconnect".
However, it looks like a Linux framework about data transfer and "NoC".

While this cci driver is more like a power managment which is
responsible for adjusting voltages and frequencies.
In my opinion, "devfreq" should be more suitable.

Please correct me if my understanding is wrong.

> > diff --git a/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml 
> > b/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> > new file mode 100644
> > index 000000000000..ef4ea951025c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/devfreq/mtk-cci.yaml*__;Iw!!CTRNKA9wMg0ARbw!yd_wfLu2nSv0GsJZOGP1S8McsGD9A2SC4Qe0Xg1wEb_yEMVcqHRqdvs-M8YKOGckaagO$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!yd_wfLu2nSv0GsJZOGP1S8McsGD9A2SC4Qe0Xg1wEb_yEMVcqHRqdvs-M8YKOERouJvA$
> >  
> > +
> > +title: MediaTek Cache Coherent Interconnect (CCI) frequency and
> > voltage scaling
> > +
> > +maintainers:
> > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > +
> > +description: |
> > +  MediaTek Cache Coherent Interconnect (CCI) uses the software
> > devfreq module
> 
> Do not reference software implementation (devfreq).

I will modify it in the next version.

> 
> > +  to scale the clock frequency and adjust the voltage. MediaTek
> > CCI shares
> > +  the same power supplies with CPU, so the scheduling involves
> > with CPUfreq.
> 
> The same - cpufreq.
> 
> Instead, focus on the hardware, what do you describe here?

I will focus on hardware description in the next version.

> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8183-cci
> > +      - mediatek,mt8186-cci
> > +
> > +  clocks:
> > +    items:
> > +      - description:
> > +          The multiplexer for clock input of CPU cluster.
> > +      - description:
> > +          A parent of "cpu" clock which is used as an intermediate
> > clock source
> > +          when the original CPU is under transition and not stable
> > yet.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: cci
> > +      - const: intermediate
> > +
> > +  operating-points-v2:
> > +    description:
> > +      For details, please refer to
> > +      Documentation/devicetree/bindings/opp/opp-v2.yaml
> 
> No need for description. Just "operating-points-v2: true".
> 
> "opp-table:true" could stay. My previous comment about its removal
> was a
> wrong advice, because opp-table is used for a table being a children
> of
> this device node.
> 
> Best regards,
> Krzysztof


I will remove it and add "opp-table:true"(also example) in the next
version.

Thanks.

BRs,
Johnson Wang

