Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8779755283D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347682AbiFTXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347406AbiFTXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:22:33 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1171922BC6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655767049; x=1687303049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Iz6YFZtbcFYcwcjopjjArKVT0IuGvxeSilsHzUbATU=;
  b=mWDMM1sEhlWv2sJ4APLG4+AqZa3ROcVpHKCCAXWixxpfl8lvAhKGOmPM
   uqDr99ZbXgPxuZwqc77yhkWVhH9KsmMLoQ3f/ycyBU++wwRKYXHEIcgyr
   lJNWxLbw7JvUO96VEvUqzKqLNPHwoFhZ8CuF1/AHxageigSVhGU9aHAbq
   hycl/ZflgRTOeNtogk3yhJWZIJHMiWlf17EyddDWYwrTRxOvjZZW9o1IQ
   NbwdYos4Q056uV3PuAg/3SeFxWH5y+JSUNBHlDYVV4sfQ+x7uRsnrZ9II
   SwzZ5b/HWQdZwhYGOu9pw9a54NvvRikYYTtBx0CL1hkjT3DoXr6RF3J6P
   A==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="208521896"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 07:17:29 +0800
IronPort-SDR: 7TSKbOgwroc+VZdpHOBpTp26VgXkxfCF17PjIxaHnGRq0aNaCmR4HNNxnvzpgQe0toGKLCdG/T
 xK2idPjKD/eRrP5MYN6S9XsEoK01/H/v4TwC37kD6GRn5iiCx+qDyV6cOX90IXKvYGU60spjQM
 iafnPXIUX9Q9c7ducoYqPfpEmtQ0OiMy+iemcMtZFTqUUHC6lmppQeoEvpx1t99XnYUyjL1Kh7
 Dpu4Zs5FbHiEIKOC0JJ74d1FC13oCBW3mfSdTnH2oJQDE6jg0MZb2baiVN9G46Rm6zh7rL0i7i
 xlOHNgRvTACo2uTPMiHkGxVd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 15:39:59 -0700
IronPort-SDR: +IYXd6+UJQHJO99cHuL5luCC1pR6nci0oQilUIWeODq4Lym0ZtYhmaEXpuXzwis2BlpmmGlaLQ
 l8CYUd8dPbJ/VN4JxTxNdbOhxg2EHl2VfdPJiKW+xKijoS3WHdDj0oydmE6NSfslGtsPG0qvgp
 1kuRtVdD1ZYGJKWyEVAXEks8tV8vkCF3pc+8Keh6AZrRxQ0l2eSk2LYcuC0vVLH0BI0Y3VcFl8
 NSWbFaWfR3JPUI6hqd6LFb+RzXDgKePAaa5Wt3AUgqgepWd8MYSnfOyFWDgtFIG3x2GQa7FXGz
 f0c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:17:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRlt01K80z1SVnx
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 16:17:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655767047; x=1658359048; bh=8Iz6YFZtbcFYcwcjopjjArKVT0IuGvxeSil
        sHzUbATU=; b=UQxdQIO/DgiT8AvQoecraHX41EUJtYAtz6fgPeku15XW9M5Stm3
        LY7Hc/LYEdpIRpDooBsIzkWFCA2tZYmcebwwwMCIzwTYfeVjWFVJ7QavztL4GxHp
        H2KdJA/p/Qu1y+y9xjt05HheIEUjOdHrEDmIp6Plnv+acg2GR2vOOXckPsmjyGDk
        YNaxlUEefaB6rBauRplBz4zbwmT2bypE85jX90H5sdA7lJASFEtjlPUeZb2wmJmk
        KFzNIap5bdwTDtRhIqj9ctHa46mvrWGNEX90XkZliFW94X3nEHIdVC9noWGvp9NI
        6mVz4a2o9C8N9hcfAiiirGYDj2/7hMhTVKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fz4uBmdu3M94 for <linux-kernel@vger.kernel.org>;
        Mon, 20 Jun 2022 16:17:27 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRlss3Tsdz1Rvlc;
        Mon, 20 Jun 2022 16:17:21 -0700 (PDT)
Message-ID: <c272728f-f610-77df-bd9b-c9fee6b727f8@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 08:17:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, Conor.Dooley@microchip.com,
        fancer.lancer@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        sam@ravnborg.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, daniel.lezcano@linaro.org,
        palmer@dabbelt.com, palmer@rivosinc.com, tglx@linutronix.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        masahiroy@kernel.org, geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, jee.heng.sia@intel.com,
        joabreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-7-mail@conchuod.ie>
 <20220620205654.g7fyipwytbww5757@mobilestation>
 <61b0fb86-078d-0262-b142-df2984ce0f97@microchip.com>
 <9a1fcb40-9267-d8e6-b3b6-3b03fd789822@opensource.wdc.com>
 <a2d85598-76d1-c9dc-d50d-e5aa815997cf@conchuod.ie>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a2d85598-76d1-c9dc-d50d-e5aa815997cf@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 07:49, Conor Dooley wrote:
> 
> 
> On 20/06/2022 23:46, Damien Le Moal wrote:
>> On 6/21/22 06:06, Conor.Dooley@microchip.com wrote:
>>> On 20/06/2022 21:56, Serge Semin wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
>>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>>
>>>>> snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
>>>>> width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
>>>>> this.
>>>>>
>>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>>> ---
>>>>>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
>>>>>  1 file changed, 35 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>>> index e25d44c218f2..f2b9e3f062cd 100644
>>>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>>> @@ -135,19 +135,41 @@ properties:
>>>>>        of the designware controller, and the upper limit is also subject to
>>>>>        controller configuration.
>>>>>
>>>>> -patternProperties:
>>>>> -  "^.*@[0-9a-f]+$":
>>>>> -    type: object
>>>>> -    properties:
>>>>> -      reg:
>>>>> -        minimum: 0
>>>>> -        maximum: 3
>>>>> -
>>>>> -      spi-rx-bus-width:
>>>>> -        const: 1
>>>>> -
>>>>> -      spi-tx-bus-width:
>>>>> -        const: 1
>>>>> +if:
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      contains:
>>>>> +        const: snps,dwc-ssi-1.01a
>>>>> +
>>>>> +then:
>>>>> +  patternProperties:
>>>>> +    "^.*@[0-9a-f]+$":
>>>>> +      type: object
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          minimum: 0
>>>>> +          maximum: 3
>>>>> +
>>>>> +        spi-rx-bus-width:
>>>>> +          const: 4
>>>>> +
>>>>> +        spi-tx-bus-width:
>>>>> +          const: 4
>>>>> +
>>>>> +else:
>>>>> +  patternProperties:
>>>>> +    "^.*@[0-9a-f]+$":
>>>>> +      type: object
>>>>> +      properties:
>>>>> +        reg:
>>>>> +          minimum: 0
>>>>> +          maximum: 3
>>>>> +
>>>>> +        spi-rx-bus-width:
>>>>> +          const: 1
>>>>> +
>>>>> +        spi-tx-bus-width:
>>>>> +          const: 1
>>>>
>>>> You can just use a more relaxed constraint "enum: [1 2 4 8]" here
>>>
>>> 8 too? sure.
>>>
>>>> irrespective from the compatible string. The modern DW APB SSI
>>>> controllers of v.4.* and newer also support the enhanced SPI Modes too
>>>> (Dual, Quad and Octal). Since the IP-core version is auto-detected at
>>>> run-time there is no way to create a DT-schema correctly constraining
>>>> the Rx/Tx SPI bus widths. So let's keep the
>>>> compatible-string-independent "patternProperties" here but just extend
>>>> the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
>>>> properties values.
>>>
>>> SGTM!
>>>
>>>>
>>>> Note the DW APB SSI/AHB SSI driver currently doesn't support the
>>>> enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
>>>> bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
>>>> DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
>>>> activated by means of the corresponding CSR. So most likely the DW AHB
>>>> SSI controllers need some specific setups too.
>>>
>>> hmm, well I'll leave that up to people that have Canaan hardware!
>>
>> I will test this series.
>>
> 
> Cool, thanks.
> I'll try to get a respin out tomorrow w/ the memory node "unfixed".

OK. I will test that then :)

> Conor.
> 
>>> Thanks,
>>> Conor.
>>>
>>>>
>>>> -Sergey
>>>>
>>>>>
>>>>>  unevaluatedProperties: false
>>>>>
>>>>> --
>>>>> 2.36.1
>>>>>
>>>
>>
>>


-- 
Damien Le Moal
Western Digital Research
