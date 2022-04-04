Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401664F111A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiDDImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiDDIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:42:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7907C3AA52;
        Mon,  4 Apr 2022 01:40:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 78AFE1F45934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649061637;
        bh=cyY2WRTj47ZWJuah+bRJ1PD2Fc40hBw+zYOhIhaJPuc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WqS3FMiZNnwkL8MZxuq/MhThpgxdfwDs9pYEIBv5FN3ri911cZtLdCTcJVlJzxuzy
         iRqq4fZsV0V8rXFv2HFLar3p4+l/83ofGVGKyT7cNLAEl/dh14TygAFNTF+zDONvxE
         k1vN+MTKfWJPlcBoHSleLh7cB+bp0I16OncVTp/n9o9zdRa2UWxNMAKPe+O9QFyQp7
         IYCqq0eFrC2mBy2W7jEKN+kRfaIs5gduNuC86JSGUyDKtPgGKSVUkGFlOp9BgsGIqO
         TcDxXLq9BJPCHYGxAOnKY7WimvWh6Cwa2SzfDg6Mzq3poZRWMSjS9lNXSNKCwwfp6L
         lr7HVyV3odKpw==
Message-ID: <7775eb70-692f-3f1b-f226-f7e0fad47e37@collabora.com>
Date:   Mon, 4 Apr 2022 10:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: mfd: syscon: Add support for regmap
 fast-io
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com
References: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
 <20220401135048.23245-3-angelogioacchino.delregno@collabora.com>
 <8588a941-6d3e-9e14-cb21-d7af29b4b2bd@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8588a941-6d3e-9e14-cb21-d7af29b4b2bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/04/22 13:38, Krzysztof Kozlowski ha scritto:
> On 01/04/2022 15:50, AngeloGioacchino Del Regno wrote:
>> The syscon driver now enables the .fast_io regmap configuration when
>> the 'fast-io' property is found in a syscon node.
>>
>> Keeping in mind that, in regmap, fast_io is checked only if we are
>> not using hardware spinlocks, allow the fast-io property only if
>> there is no hwlocks reference (and vice-versa).
> 
> I have doubts you need a property for this. "fast" is subjective in
> terms of hardware, so this looks more like a software property, not
> hardware.
> 
> I think most of MMIOs inside a SoC are considered fast. Usually also the
> syscon/regmap consumer knows which regmap it gets, so knows that it is
> fast or not.
> 

Hello Krzysztof,

well yes, this property is changing how software behaves - specifically,
as you've correctly understood, what regmap does.

It's true that most of MMIOs inside a SoC are considered fast.. the word "most" is
the exact reason why I haven't proposed simply hardcoding '.fast_io = true' in
syscon, or in regmap-mmio...
There are too many different SoCs around, and I didn't want to end up breaking
anything (even if it should be unlikely, since MMIO is fast by principle).


>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> index 13baa452cc9d..85a2e83b5861 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -83,11 +83,26 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       enum: [1, 2, 4, 8]
>>   
>> +  fast-io:
>> +    description:
>> +      Indicates that this bus has a very fast IO, for which
>> +      acquiring a mutex would be significant overhead.
>> +      When present, regmap will use a spinlock instead.
> 
> Regmap is current implementation behind this, but it's not related to
> hardware, so how about removing it from the description? Something like:
> "..., for which different locking methods should be used to reduce
> overhead (e.g. spinlock instead of mutex)."
> 

That's a very good point. I didn't think about any future in which the
implementation would be changed from regmap to *new-name-here*... but
anyway it makes a lot more sense to "speak generic".

I'll change the description to match your proposal, thank you!

Regards,
Angelo
