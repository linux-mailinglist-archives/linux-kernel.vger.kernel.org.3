Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586BA4C0E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiBWIjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiBWIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:39:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 425254CD4A;
        Wed, 23 Feb 2022 00:39:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CAF1ED1;
        Wed, 23 Feb 2022 00:39:10 -0800 (PST)
Received: from [10.57.9.184] (unknown [10.57.9.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14F233F5A1;
        Wed, 23 Feb 2022 00:39:07 -0800 (PST)
Message-ID: <ae28b0be-5b71-d53e-31ee-49d4d01a0910@arm.com>
Date:   Wed, 23 Feb 2022 08:39:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [[PATCH v2 1/2] dt-bindings: opp: Add 'opp-microwatt' entry in
 the OPP
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-2-lukasz.luba@arm.com>
 <20220223055006.zlcwco7oducggxjw@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220223055006.zlcwco7oducggxjw@vireshk-i7>
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



On 2/23/22 05:50, Viresh Kumar wrote:
> On 22-02-22, 14:07, Lukasz Luba wrote:
>> Add new entry for the OPP which provides information about power
>> expressed in micro-Watts. It is useful for the Energy Model framework.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> index 15a76bcd6d42..3f07a279ed2a 100644
>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> @@ -93,6 +93,13 @@ patternProperties:
>>           minItems: 1
>>           maxItems: 8   # Should be enough regulators
>>   
>> +      opp-microwatt:
>> +        description:
>> +          Power for the OPP
>> +
>> +          A value representing power for the OPP in micro-Watts.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
> 
> I was expecting a much larger change here. Look at how opp-microvolt and
> opp-microamp is defined in this file.
> 
> Should this value be made per-supply/regulator, just like voltage/current ?
> 

For the EM we need only one value. If there would be some other users
of this field in future we might add the multiple power values support.
Currently there is no need I would say, unless it's a hard requirement
to be aligned with opp-microvolt.
