Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9D518447
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiECMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiECMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:30:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4FD36E3C;
        Tue,  3 May 2022 05:26:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 917831F441C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651580779;
        bh=LlBmjlHQSS35SPjCWj3dgSTZw3msR7REos5gfSK3Ax4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PkOtHZLorH/YOUjW9gqgLkQUauN4xvNqLdgUWSJ9SQdywZy/6df1mU500jZoYGG7e
         KWnMdgSZ+lwUMfVn+eWt/o7ztBSpNIO4yRiskjKgtKRpuqu1tCVCfpKE07ztDkXutw
         sAHYPgIA84KFaDD4KAW62ToiVORvcjtAC/Pgs9FFFVV/culsbUX+8Rhx6z9vHe3Nmx
         5YF7/L7wfKuEQGn742MYzKXe/MKmV4MXIBIMQl5R+gIZCGdEy+BdpZgevj732oEUdS
         /ravPbw/cVWQnX6RRdu9OzUfRukuaGNkSeTXEm33+ZrPqL4T05yme0tyeJ6xlFhK9v
         GWvKLIr0i0PrA==
Message-ID: <4bf2343b-3760-6ebf-7463-0b25fe9d942e@collabora.com>
Date:   Tue, 3 May 2022 14:26:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Fix optional
 reg-names for mtk,scp
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220429211111.2214119-1-nfraprado@collabora.com>
 <20220429211111.2214119-2-nfraprado@collabora.com>
 <a95fc4a9-af6b-e2c2-ef41-df9742d393de@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a95fc4a9-af6b-e2c2-ef41-df9742d393de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 14:19, Krzysztof Kozlowski ha scritto:
> On 29/04/2022 23:11, Nícolas F. R. A. Prado wrote:
>> The SCP has three memory regions: sram, l1tcm and cfg. Only sram is
>> required, the other two are optional. Fix the dt-binding so that the
>> optional regions can be omitted and passed in any order.
> 
> No, cannot be passed in any order.
> 
>>
>> Also add the missing minItems to the reg property and update the
>> description.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> ---
>>
>>   .../devicetree/bindings/remoteproc/mtk,scp.yaml      | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
>> index 823a236242de..ec9ddeb6ca2c 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
>> @@ -24,14 +24,20 @@ properties:
>>     reg:
>>       description:
>>         Should contain the address ranges for memory regions SRAM, CFG, and
>> -      L1TCM.
>> +      L1TCM. Only SRAM is required, while CFG and L1TCM are optional.
>> +    minItems: 1
>>       maxItems: 3
>>   
>>     reg-names:
>> +    minItems: 1
>>       items:
>>         - const: sram
>> -      - const: cfg
>> -      - const: l1tcm
>> +      - enum:
>> +          - l1tcm
>> +          - cfg
>> +      - enum:
>> +          - l1tcm
>> +          - cfg
> 
> This allows them in any combination which is not what we want. If both
> are optional and both can appear, then last should be a const:l1tcm.
> 
> Best regards,
> Krzysztof

Nicolas, I think that you weren't clear about what you're trying to solve with this
commit in the description.

I remember you had this kind of instance, but I don't really remember if it was
about mtk,scp or (and?) something else.... so.... are you trying to fix issues
with devicetrees declaring

	reg-names = "sram", "l1tcm"; ?

Was this giving dtbs_check errors?

Cheers,
Angelo
