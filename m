Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01E548B279
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbiAKQnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:43:25 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58138
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240545AbiAKQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:43:24 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9240F4002A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 16:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641919403;
        bh=7tovFhdsBRLFi8z4L+nr20D8IySCU7+t0s1+Rx0EAjs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=RrRagHzhjiEMonHo+l9W4aXCTWuBJ4miWs/OH8GtMTOqsIYBm72smPL7wY3x0R9EH
         FIVxcNmHyaSMEVmLVqLOMHFFDFFMKLEr77HdANeZVObjYhK6sGHB8r0Hnmzzw8uE7G
         DK8WwIdpKpHg96W2cXCyJHG7dBwurHMEWtL6Z7lesAHU5ZI3wsDlEINxcI4AWPRUJq
         EonVwk3o9jZODj89Ve1MMUjA/q10JMxCXA1eYyX3iCVJpZxIL87e/fi6cugNE+i/FB
         7N3CXYNhsE6jhmOjRCTrDAtZBGB5b4wZXVdNSVehzx7lKZj9kDyCs1J1jHPA0E/9yS
         /MRJdHZbtk65w==
Received: by mail-ed1-f69.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so13889625edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7tovFhdsBRLFi8z4L+nr20D8IySCU7+t0s1+Rx0EAjs=;
        b=bqy5Z5nAishliGIQr8y09cDLZQl0uY+VhaUR1Ckd6dH9K7DGKVEGiZA3TTGqRr3wzY
         R2wrzEH16Pt0XRX46lbC6N4aKMwIF9BdzQNsbNXWRtYEPdvxvT3ocm90Q8TZRfLg31Zc
         mTHTPB3CpI6WA47jpeSlAY9jA5MAeRncojuOo5bULoP3TgA9yQw9P+bJ5k29mhyJffbK
         o8Oq0lwzR0BjT+JHeNtxOzxk9OveZX2kjr1hm2HVgyTcGP2FJZsAQywlVH0iasu25Y74
         kokBjtuFfLJTIkUb7eOjZBd69WHtC5dZnn3zDV/q8CXxYK5wZ/r7HBORpTlCc3DaZl7e
         lpyA==
X-Gm-Message-State: AOAM530GB6ij2OuIl/6Lmxj2BrDMD7ccwIkvGDStr3RzdXuWuc7LVSIL
        e3hDfsTxHo2ZxP4lV+dqHEeJd1oG+2+FonSm4GRFDQEEvOGnCwGYGEhwXLYUeQSnE94jcty7JO+
        2rtBnWpdnbSjecjXvDwyp3A7tBIRvlmx0bdBwHgllJA==
X-Received: by 2002:aa7:d383:: with SMTP id x3mr5119040edq.392.1641919402847;
        Tue, 11 Jan 2022 08:43:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzp8us62KWjAB+me6PcR6TH8dk+EOXoM7bcu94wmzxcAseIUSo3tny4V2OWWzjkd+I9QynjEg==
X-Received: by 2002:aa7:d383:: with SMTP id x3mr5119027edq.392.1641919402631;
        Tue, 11 Jan 2022 08:43:22 -0800 (PST)
Received: from [192.168.0.25] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id kz3sm3715117ejc.71.2022.01.11.08.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:43:22 -0800 (PST)
Message-ID: <a5feb8ad-e6af-0222-db07-eeaea184dbba@canonical.com>
Date:   Tue, 11 Jan 2022 17:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/3] regulator: dt-bindings: maxim,max77802: Convert to
 dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211228164305.35877-1-krzysztof.kozlowski@canonical.com>
 <20211228164305.35877-3-krzysztof.kozlowski@canonical.com>
 <YdRoyQsABBGen54D@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YdRoyQsABBGen54D@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2022 16:33, Rob Herring wrote:
> On Tue, Dec 28, 2021 at 05:43:04PM +0100, Krzysztof Kozlowski wrote:
>> Convert the regulators of Maxim MAX77802 PMIC to DT schema format.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/regulator/max77802.txt           | 111 ----------------
>>  .../bindings/regulator/maxim,max77802.yaml    | 118 ++++++++++++++++++
>>  2 files changed, 118 insertions(+), 111 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
>>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/max77802.txt b/Documentation/devicetree/bindings/regulator/max77802.txt
>> deleted file mode 100644
>> index b82943d83677..000000000000
>> --- a/Documentation/devicetree/bindings/regulator/max77802.txt
>> +++ /dev/null
>> @@ -1,111 +0,0 @@
>> -Binding for Maxim MAX77802 regulators
>> -
>> -This is a part of device tree bindings of MAX77802 multi-function device.
>> -More information can be found in bindings/mfd/max77802.txt file.
>> -
>> -The MAX77802 PMIC has 10 high-efficiency Buck and 32 Low-dropout (LDO)
>> -regulators that can be controlled over I2C.
>> -
>> -Following properties should be present in main device node of the MFD chip.
>> -
>> -Optional properties:
>> -- inb1-supply:  The input supply for BUCK1
>> -- inb2-supply:  The input supply for BUCK2
>> -- inb3-supply:  The input supply for BUCK3
>> -- inb4-supply:  The input supply for BUCK4
>> -- inb5-supply:  The input supply for BUCK5
>> -- inb6-supply:  The input supply for BUCK6
>> -- inb7-supply:  The input supply for BUCK7
>> -- inb8-supply:  The input supply for BUCK8
>> -- inb9-supply:  The input supply for BUCK9
>> -- inb10-supply: The input supply for BUCK10
>> -- inl1-supply:  The input supply for LDO8 and LDO15
>> -- inl2-supply:  The input supply for LDO17, LDO27, LDO30 and LDO35
>> -- inl3-supply:  The input supply for LDO3, LDO5, LDO6 and LDO7
>> -- inl4-supply:  The input supply for LDO10, LDO11, LDO13 and LDO14
>> -- inl5-supply:  The input supply for LDO9 and LDO19
>> -- inl6-supply:  The input supply for LDO4, LDO21, LDO24 and LDO33
>> -- inl7-supply:  The input supply for LDO18, LDO20, LDO28 and LDO29
>> -- inl9-supply:  The input supply for LDO12, LDO23, LDO25, LDO26, LDO32 and LDO34
>> -- inl10-supply: The input supply for LDO1 and LDO2
>> -
>> -Optional nodes:
>> -- regulators : The regulators of max77802 have to be instantiated
>> -  under subnode named "regulators" using the following format.
>> -
>> -	regulator-name {
>> -		standard regulator constraints....
>> -	};
>> -	refer Documentation/devicetree/bindings/regulator/regulator.txt
>> -
>> -The regulator node name should be initialized with a string to get matched
>> -with their hardware counterparts as follow. The valid names are:
>> -
>> -	-LDOn 	:	for LDOs, where n can lie in ranges 1-15, 17-21, 23-30
>> -			and 32-35.
>> -			example: LDO1, LDO2, LDO35.
>> -	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 10.
>> -			example: BUCK1, BUCK5, BUCK10.
>> -
>> -The max77802 regulator supports two different operating modes: Normal and Low
>> -Power Mode. Some regulators support the modes to be changed at startup or by
>> -the consumers during normal operation while others only support to change the
>> -mode during system suspend. The standard regulator suspend states binding can
>> -be used to configure the regulator operating mode.
>> -
>> -The regulators that support the standard "regulator-initial-mode" property,
>> -changing their mode during normal operation are: LDOs 1, 3, 20 and 21.
>> -
>> -The possible values for "regulator-initial-mode" and "regulator-mode" are:
>> -	1: Normal regulator voltage output mode.
>> -	3: Low Power which reduces the quiescent current down to only 1uA
>> -
>> -The valid modes list is defined in the dt-bindings/regulator/maxim,max77802.h
>> -header and can be included by device tree source files.
>> -
>> -The standard "regulator-mode" property can only be used for regulators that
>> -support changing their mode to Low Power Mode during suspend. These regulators
>> -are: BUCKs 2-4 and LDOs 1-35. Also, it only takes effect if the regulator has
>> -been enabled for the given suspend state using "regulator-on-in-suspend" and
>> -has not been disabled for that state using "regulator-off-in-suspend".
>> -
>> -Example:
>> -
>> -	max77802@9 {
>> -		compatible = "maxim,max77802";
>> -		interrupt-parent = <&wakeup_eint>;
>> -		interrupts = <26 0>;
>> -		reg = <0x09>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -
>> -		inb1-supply = <&parent_reg>;
>> -
>> -		regulators {
>> -			ldo1_reg: LDO1 {
>> -				regulator-name = "vdd_1v0";
>> -				regulator-min-microvolt = <1000000>;
>> -				regulator-max-microvolt = <1000000>;
>> -				regulator-always-on;
>> -				regulator-initial-mode = <MAX77802_OPMODE_LP>;
>> -			};
>> -
>> -			ldo11_reg: LDO11 {
>> -				regulator-name = "vdd_ldo11";
>> -				regulator-min-microvolt = <1900000>;
>> -				regulator-max-microvolt = <1900000>;
>> -				regulator-always-on;
>> -				regulator-state-mem {
>> -					regulator-on-in-suspend;
>> -					regulator-mode = <MAX77802_OPMODE_LP>;
>> -				};
>> -			};
>> -
>> -			buck1_reg: BUCK1 {
>> -				regulator-name = "vdd_mif";
>> -				regulator-min-microvolt = <950000>;
>> -				regulator-max-microvolt = <1300000>;
>> -				regulator-always-on;
>> -				regulator-boot-on;
>> -			};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
>> new file mode 100644
>> index 000000000000..01e1c40685ff
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
>> @@ -0,0 +1,118 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/maxim,max77802.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX77802 Power Management IC regulators
>> +
>> +maintainers:
>> +  - Javier Martinez Canillas <javier@dowhile0.org>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +
>> +description: |
>> +  This is a part of device tree bindings for Maxim MAX77802 Power Management
>> +  Integrated Circuit (PMIC).
>> +
>> +  The Maxim MAX77686 provides 10 high-efficiency Buck and 32 Low-DropOut (LDO)
>> +  regulators.
>> +
>> +  See also Documentation/devicetree/bindings/mfd/maxim,max77802.yaml for
>> +  additional information and example.
>> +
>> +  Certain regulators support "regulator-initial-mode" and "regulator-mode".
>> +  The valid modes list is defined in the dt-bindings/regulator/maxim,max77802.h
>> +  and their meaning is:
>> +    1 - Normal regulator voltage output mode.
>> +    3 - Low Power which reduces the quiescent current down to only 1uA
>> +
>> +  The standard "regulator-mode" property can only be used for regulators that
>> +  support changing their mode to Low Power Mode during suspend. These
>> +  regulators are: bucks 2-4 and LDOs 1-35. Also, it only takes effect if the
>> +  regulator has been enabled for the given suspend state using
>> +  "regulator-on-in-suspend" and has not been disabled for that state using
>> +  "regulator-off-in-suspend".
>> +
>> +patternProperties:
>> +  # LDO1, LDO3, LDO20, LDO21
>> +  "^LDO([13]|2[01])$":
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    unevaluatedProperties: false
>> +    description:
>> +      LDOs supporting the regulator-initial-mode property and changing their
>> +      mode during normal operation.
>> +
>> +    properties:
>> +      regulator-initial-mode: true
> 
> Same issues here as the other series.

Right.

> 
>> +
>> +    patternProperties:
>> +      regulator-state-(standby|mem|disk):
>> +        type: object
>> +        properties:
>> +          regulator-mode: true
> 
> Is this the only valid property? 
> 
No. I will skip entire patternProperties for regulators where there are
no constraints about other properties.

Best regards,
Krzysztof
