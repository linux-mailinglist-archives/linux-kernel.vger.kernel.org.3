Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C866A52B8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiERLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiERLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:42:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EB21DA5B;
        Wed, 18 May 2022 04:42:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8C8FD1F44EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652874144;
        bh=qf83SX+V7kjrLVMgax0hyCtsQnOzDUfXGrMJugntals=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eCcwRurnQ+5GicCiLUfL2+f27Skpz0cRymPx++02Gs/+Bm9y8LvMU+6E4zFbDOBbB
         aDxYHbubVrbCA+S5TsXAoq4U9wHNl9b0zGYGbzhdodANtmEmBbhrYx9e+w3rh5TOFb
         Vyps2S9Wcz1EzWXTa9lJTlDZFDQkW3J3QJ9bGZjEJEc85hByE99hCsirLDdS7SoW0w
         B66eXlc+ED801BFn9pFvgK96TKw7BuU6+8dsSUCijtBn62fPvpsJc8uT9XlYafrff6
         yV7b+39Yhj9HoBc5e05dpy412rFo6AmY0TE60FsflL/CVdY2d2PZVklvXG9KaoqU2t
         FAGEC8vUE9EJw==
Message-ID: <2550039f-1cfc-eb5d-bbc9-bf82666e9abd@collabora.com>
Date:   Wed, 18 May 2022 13:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: mediatek: Add phandles for
 mediatek infra/pericfg
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
 <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
 <4cfbc8dd-83d3-80df-630d-6f8fb2efb9fd@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4cfbc8dd-83d3-80df-630d-6f8fb2efb9fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/05/22 13:29, Matthias Brugger ha scritto:
> 
> 
> On 18/05/2022 12:04, AngeloGioacchino Del Regno wrote:
>> Add properties "mediatek,infracfg" and "mediatek,pericfg" to let the
>> mtk_iommu driver retrieve phandles to the infracfg and pericfg syscon(s)
>> instead of performing a per-soc compatible lookup.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/iommu/mediatek,iommu.yaml         | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml 
>> b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>> index 2ae3bbad7f1a..c4af41947593 100644
>> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>> @@ -101,6 +101,10 @@ properties:
>>       items:
>>         - const: bclk
>> +  mediatek,infracfg:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: The phandle to the mediatek infracfg syscon
>> +
>>     mediatek,larbs:
>>       $ref: /schemas/types.yaml#/definitions/phandle-array
>>       minItems: 1
>> @@ -112,6 +116,10 @@ properties:
>>         Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
>>         according to the local arbiter index, like larb0, larb1, larb2...
>> +  mediatek,pericfg:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: The phandle to the mediatek pericfg syscon
>> +
> 
> I didn't explain myself. What I was suguesting was to squash the patch that add 
> requiered mediatek,infracfg with the patch that adds mediatk,infracfg to the 
> binding description. And then squash the both patches adding pericfg as well.

Sorry Matthias, I'm not sure ... I think I'm misunderstanding you again...
...but if I'm not, I don't think that squashing actual code and bindings together
is something acceptable?

I've made that kind of mistake in the past and I was told multiple times that
dt-bindings changes shall be sent separately from the actual driver changes.

Cheers,
Angelo



