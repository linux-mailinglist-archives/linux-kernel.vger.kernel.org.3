Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E1E4BF32C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiBVIHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBVIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:07:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A50E149BAD;
        Tue, 22 Feb 2022 00:06:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5AB41063;
        Tue, 22 Feb 2022 00:06:57 -0800 (PST)
Received: from [10.57.9.152] (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D11473F5A1;
        Tue, 22 Feb 2022 00:06:55 -0800 (PST)
Message-ID: <147e48e5-e310-cd8f-ba8c-ff32e3094be3@arm.com>
Date:   Tue, 22 Feb 2022 08:06:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC][PATCH 1/2] dt-bindings: power: add Energy Model bindings
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220221225131.15836-1-lukasz.luba@arm.com>
 <20220221225131.15836-2-lukasz.luba@arm.com>
 <20220222030337.ijnfrh367illmidr@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220222030337.ijnfrh367illmidr@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Thanks for having a look at it.

On 2/22/22 03:03, Viresh Kumar wrote:
> On 21-02-22, 22:51, Lukasz Luba wrote:
>> Add DT bindings for the Energy Model information.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   .../bindings/power/energy-model.yaml          | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/energy-model.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/energy-model.yaml b/Documentation/devicetree/bindings/power/energy-model.yaml
>> new file mode 100644
>> index 000000000000..804a9b324925
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/energy-model.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/energy-model.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Energy Model Bindings
>> +
>> +maintainers:
>> +  - Lukasz Luba <lukasz.luba@arm.com>
>> +
>> +description: |+
>> +  Devices work at specific performance states (frequencies). The power which
>> +  is used at a given performance state is an important information. A framework
>> +  which maintains this information is Energy Model. This document defines
>> +  bindings for these Energy Model performance states applicable across wide
>> +  range of devices. For illustration purpose, this document uses GPU as a device.
>> +
>> +  This binding only supports frequency-power pairs.
>> +
>> +select: true
>> +
>> +properties:
>> +  operating-points:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    items:
>> +      items:
>> +        - description: Frequency in kHz
>> +        - description: Power in uW
>> +
>> +
>> +additionalProperties: true
>> +examples:
>> +    {
>> +       gpu_energy_model: energy-model {
>> +               compatible = "energy-model";
>> +               energy-model-entries = <
>> +                               200000 300000
>> +                               297000 500000
>> +                               400000 800000
>> +                               500000 1400000
>> +                               600000 2000000
>> +                               800000 2800000
>> +                               >;
>> +       };
>> +    };
>> +
>> +    &gpu {
>> +       energy-model = <&gpu_energy_model>;
>> +    };
> 
> What about getting this from the OPP table instead? There is no point adding
> similar tables for a device.
> 

I'm not sure if that would be flexible enough to meet the requirement:
power for each OPP might be different in one board vs. other board.

Power can be different because of static power, which might vary due to
different temperature that the SoC operates at a particular OPP. It can
be due to: better heat sink (or no at all like on dev board), bigger PCB
with fat copper layers, different location of hot devices (like PMIC) on 
the PCB, missing some hot devices on the PCB (fast charger), case, etc.

The 'advanced' EM and this DT array allows to provide avg power from
measurements for a particular board and for each OPP independently.

AFAIK the OPP definition is more SoC specific. I'm particularly
interested in this SC7180 SoC and it's GPU power [1]. There is
also a nice OPP definition in that node.
As you can see there is one SoC file and quite a few boards next to
it. Some of them have a decent thermal design (inside Chromebook) but
some are 'just' dev boards. The power would be different for those
boards.

Similar issue would be e.g. for Rk3399 SoC (Chromebook, Pine64, IoT and
some dev boards).

IMO the OPP table might be to much hassle and heavy for those boards.

[1] 
https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/qcom/sc7180.dtsi#L1953
