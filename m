Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE2464C70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348921AbhLALSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhLALS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:18:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0DAC061574;
        Wed,  1 Dec 2021 03:15:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E05DECE1DCA;
        Wed,  1 Dec 2021 11:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB200C53FCC;
        Wed,  1 Dec 2021 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638357303;
        bh=ehVTzL9X6BysmNP85++ptIBdmSpHTbsCMyi3z2tu5D0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HjFzzYB/CE/19drSrda2JNv9tdyBGIIOGNr0il7/WmQa5vCF21CUBUS0bqKZAhtJS
         1Y5T6A/VJuGdGKwjxK4C7YXojve9Ebi7/l6p9wXK/12GFeOAY/945ZeMm2h1+k8FD7
         qYTXtZ6UV4jXuP85XZ0bVSeNZ8VUCtIufsHsPcWzwba5KOf27Y7DhN67pxKhflnmod
         l86/bg4KTuPQQUQhI2TUphk1hutcOl2JpIb73VBnCQVRZt4Ugkp35EoJfjvdMwa7RA
         jFA/kWHDls45bQUQYSCpF3EVrB4n7zfQRWJAsKFc56WMXcYl57CamD6qZDBI1L8lAG
         ifEiSWROxQQCw==
Subject: Re: [PATCH 1/4] dt-bindings: memory-controllers: ti,gpmc: Add
 compatible for AM64
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     tony@atomide.com, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211123102607.13002-1-rogerq@kernel.org>
 <20211123102607.13002-2-rogerq@kernel.org>
 <a28532b1-bfa0-031b-91cc-070cad557599@canonical.com>
 <YaafXKXfzBQaNSvq@robh.at.kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <acc05242-8d0a-093a-c076-af35a339333c@kernel.org>
Date:   Wed, 1 Dec 2021 13:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaafXKXfzBQaNSvq@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/12/2021 00:02, Rob Herring wrote:
> On Tue, Nov 23, 2021 at 08:47:57PM +0100, Krzysztof Kozlowski wrote:
>> On 23/11/2021 11:26, Roger Quadros wrote:
>>> AM64 SoC contains the GPMC module. Add compatible for it.
>>>
>>> Newer SoCs don't necessarily map GPMC data region at the same place
>>> as legacy SoCs. Add reg-names "data", to provide this information to
>>> the device driver.
>>>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>  .../bindings/memory-controllers/ti,gpmc.yaml         | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
>>> index 25b42d68f9b3..1869cc6f949b 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
>>> @@ -23,13 +23,20 @@ properties:
>>>      items:
>>>        - enum:
>>>            - ti,am3352-gpmc
>>> +          - ti,am64-gpmc
>>>            - ti,omap2420-gpmc
>>>            - ti,omap2430-gpmc
>>>            - ti,omap3430-gpmc
>>>            - ti,omap4430-gpmc
>>>  
>>>    reg:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: cfg
>>> +      - const: data
>>
>> I see your driver handles cases with only one reg item, but I have other
>> question - is it correct to have older (ARMv7) platform with two reg
>> items? Or can am64-gpmc come with only one reg?
>> IOW, I am surprised there is no if-else case precising this minItems
>> requirement for different SocS.
> 
> I don't think that is needed here. If the assumption is 'reg-names' is 
> only present when there are 2 entries, then it is fine. Maybe 
> 'reg-names' should be required for ti,am64-gpmc though.

Yes, I'll make 'reg-names' property required for ti,am64-gpmc.

cheers,
-roger
