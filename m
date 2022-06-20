Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF54D552715
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbiFTWqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiFTWqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:46:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF91140F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655765199; x=1687301199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HsNQYoVzbJStzX4az+4aldPwMmRKXzHlpXTfHEicD2Q=;
  b=VuNBa0jO9fMRrfmXdJuex/qyAWy/+nL+mD+xY13IyEUSdmL+kVe5Ol2k
   oF0GO874ErLHA8ozYyO9NApkQq+TdpKbEA1Gv2HBp/4M6lA+oI1FNeSG0
   QGwCA0auAd9r6yal3IcGrd6m8akJfwvcidkjv+xjLxHQShHxmGcy0gBlc
   kADv6LixdElI1ajV+d/KAkPGDvkSwIglQO88VdaDsUhfNOWkQJ+ceCc8G
   G7YAT4BpCARXkF4nKhoag506tXNosX7w5ySCzsp1LPkCK2YvCw9BGV+U5
   q6lAD3BIdhOYbSlynTyrcA7vt9Mq6JDt3mlZb+EMabLRxuINWgsE/4/xi
   A==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="315760973"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 06:46:39 +0800
IronPort-SDR: /ksmZOiHgYuP16XFGrO1aKuoW/vWTwNGYwpS0zS40AptWAQy/c6RcB0iolu5NrASP+s9rqBbuP
 jfJeec3h18ayHtLobVOxXOjrmS47/fo7OHf/2l5H9XuIazwPasNiNq6BchVy1Jp2DT0FsHTSjB
 hg+oN3rpT9iyACF00c/Ulxd1Kgn+1L05kYgIDRZUaMJqQM/J8jiPzzSTyLMGSuM9Wjoei+5efp
 ct5hkRuFM9WK/6/1SYfz1P5qQ5h2OwsAQDMS0wCx6CJ6Jj8rFeLZQBgsDEnhFxpV/czphBFmH2
 pJ2u+Nho26AqqVaxAM5N2y/x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 15:09:09 -0700
IronPort-SDR: nt/st3AOFM8P1FgnFXLwewT9CCnON6KMRC+TtJZk87/A1XAGW+qXIS6h4jqLzi6NBrbhfmiY2X
 AxQIXY7psYFaMfvJir0LLBvJOLtp4qcnJ3IXkSP0+Sx/E6yvr4ZQPn7fDA02RWx3wG0jja7Iew
 0trsjaGK+GHOkGcSJOnBY4HC4Dtdmqu7RxiYUYrxaqQEZwIB3iW6EWmRebfKhkVyGpZU/1yfVl
 bo0O5lOfFoyT5tvIRm1XahSMO1MsM+rAlLzAJpXsHIl26mUjCcSarEP+jjzdraZd7fRi7HkLGF
 dbs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 15:46:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRlBQ16v0z1SHwl
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:46:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655765196; x=1658357197; bh=HsNQYoVzbJStzX4az+4aldPwMmRKXzHlpXT
        fHEicD2Q=; b=Lhr+G2WQqfFETrRVbPoA42VhoL4exbeW+icqCZ0jwVxJhg3CSZ/
        dUE6HVuOJ7MGXskvgzZI8kOSwDmY9bZb8zCPvhEsDQsYMkx1d/w+udifSdHRrPhW
        iqrZcUBxGY0AcruBv081/qgu8EdR07l0tTnt1WAVREfgI01BrJXxIJjRKaE3riKw
        qJeHgC3UvCHNiYfXgjSZyhxr47GErsONq7UojQm3JgrIqtzZmTCSOjMwrlNLScIV
        b0SFTbmO5VS9zAHLAv0xt4daAIYk2YJ1kFHMcHYR67uT3EC2qXpMKcKINJm6wv1S
        TNC/wKuUcCFxuQvsnrh1LA11vaJODLe2QoA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9QYz9Yr7u5pG for <linux-kernel@vger.kernel.org>;
        Mon, 20 Jun 2022 15:46:36 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRlBG25pSz1Rvlc;
        Mon, 20 Jun 2022 15:46:30 -0700 (PDT)
Message-ID: <9a1fcb40-9267-d8e6-b3b6-3b03fd789822@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 07:46:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Content-Language: en-US
To:     Conor.Dooley@microchip.com, fancer.lancer@gmail.com,
        mail@conchuod.ie
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <61b0fb86-078d-0262-b142-df2984ce0f97@microchip.com>
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

On 6/21/22 06:06, Conor.Dooley@microchip.com wrote:
> On 20/06/2022 21:56, Serge Semin wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
>>> width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
>>> this.
>>>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
>>>  1 file changed, 35 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> index e25d44c218f2..f2b9e3f062cd 100644
>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>> @@ -135,19 +135,41 @@ properties:
>>>        of the designware controller, and the upper limit is also subject to
>>>        controller configuration.
>>>
>>> -patternProperties:
>>> -  "^.*@[0-9a-f]+$":
>>> -    type: object
>>> -    properties:
>>> -      reg:
>>> -        minimum: 0
>>> -        maximum: 3
>>> -
>>> -      spi-rx-bus-width:
>>> -        const: 1
>>> -
>>> -      spi-tx-bus-width:
>>> -        const: 1
>>> +if:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: snps,dwc-ssi-1.01a
>>> +
>>> +then:
>>> +  patternProperties:
>>> +    "^.*@[0-9a-f]+$":
>>> +      type: object
>>> +      properties:
>>> +        reg:
>>> +          minimum: 0
>>> +          maximum: 3
>>> +
>>> +        spi-rx-bus-width:
>>> +          const: 4
>>> +
>>> +        spi-tx-bus-width:
>>> +          const: 4
>>> +
>>> +else:
>>> +  patternProperties:
>>> +    "^.*@[0-9a-f]+$":
>>> +      type: object
>>> +      properties:
>>> +        reg:
>>> +          minimum: 0
>>> +          maximum: 3
>>> +
>>> +        spi-rx-bus-width:
>>> +          const: 1
>>> +
>>> +        spi-tx-bus-width:
>>> +          const: 1
>>
>> You can just use a more relaxed constraint "enum: [1 2 4 8]" here
> 
> 8 too? sure.
> 
>> irrespective from the compatible string. The modern DW APB SSI
>> controllers of v.4.* and newer also support the enhanced SPI Modes too
>> (Dual, Quad and Octal). Since the IP-core version is auto-detected at
>> run-time there is no way to create a DT-schema correctly constraining
>> the Rx/Tx SPI bus widths. So let's keep the
>> compatible-string-independent "patternProperties" here but just extend
>> the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
>> properties values.
> 
> SGTM!
> 
>>
>> Note the DW APB SSI/AHB SSI driver currently doesn't support the
>> enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
>> bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
>> DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
>> activated by means of the corresponding CSR. So most likely the DW AHB
>> SSI controllers need some specific setups too.
> 
> hmm, well I'll leave that up to people that have Canaan hardware!

I will test this series.

> Thanks,
> Conor.
> 
>>
>> -Sergey
>>
>>>
>>>  unevaluatedProperties: false
>>>
>>> --
>>> 2.36.1
>>>
> 


-- 
Damien Le Moal
Western Digital Research
