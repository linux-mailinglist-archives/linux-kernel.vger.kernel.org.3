Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD0B591D53
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiHNAmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbiHNAlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:41:51 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0E78BFC;
        Sat, 13 Aug 2022 17:41:48 -0700 (PDT)
Received: from [192.168.1.101] (abxi168.neoplus.adsl.tpnet.pl [83.9.2.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5ABC31F613;
        Sun, 14 Aug 2022 02:41:44 +0200 (CEST)
Message-ID: <f8cfc271-a674-8d0b-f65e-cd1e9aac06e1@somainline.org>
Date:   Sun, 14 Aug 2022 02:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: qcom: pm6350: add temp sensor and thermal
 zone config
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220812114421.1195044-1-luca.weiss@fairphone.com>
 <81ae6a31-1f37-a677-f8f8-2340e37d3a63@linaro.org>
 <CM43WTWNP8MM.3145TGVN4208B@otso> <YvaErMmLIQaDolKR@google.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <YvaErMmLIQaDolKR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.08.2022 18:49, Matthias Kaehlcke wrote:
> On Fri, Aug 12, 2022 at 04:06:47PM +0200, Luca Weiss wrote:
>> Hi Krzysztof,
>>
>> +CC Matthias Kaehlcke (author of patch mentioned further below)
>>
>> On Fri Aug 12, 2022 at 3:36 PM CEST, Krzysztof Kozlowski wrote:
>>> On 12/08/2022 14:44, Luca Weiss wrote:
>>>> Add temp-alarm device tree node and a default configuration for the
>>>> corresponding thermal zone for this PMIC. Temperatures are based on
>>>> downstream values.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>> With this config I'm getting this in dmesg, not sure if it's a warning
>>>> that should be solved or just an informative warning.
>>>>
>>>> [    0.268256] spmi-temp-alarm c440000.spmi:pmic@0:temp-alarm@2400: No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140 C! Configuring stage 2 shutdown at 140 C.
>>>>
>>>> As far as I can tell, based on downstream dts this PMIC doesn't have an
>>>> ADC.
> 
> I don't seem to have access to the datasheet, in any case that the ADC isn't
> configured in the downstream dts doesn't necessarily mean the PMIC doesn't
> have one. The PM6150 has one, and it is probably relatively close to the
> PM6350.
> 
>>> You configure 145 and driver believes 140 is the limit, so it seems
>>> warning should be addressed.
>>
>> Hm...
>>
>>>
>>> From where did you get 145 degrees as limit? Downstream DTS?
>>
>> Yes, downstream dts[0].
>>
>> From what I can see in the downstream driver, it always disabled this
>> "software override of stage 2 and 3 shutdowns"[1]
>>
>> In mainline only since f1599f9e4cd6 ("thermal: qcom-spmi: Use PMIC
>> thermal stage 2 for critical trip points") this check exists, which is
>> not part of downstream (wasn't in 4.19 yet), where this software
>> override tries to get enabled so that thermal core can handle this.
>>
>> Any suggestion what I can do here? Maybe looking at msm-5.4 sources (and
>> associated dts) might reveal something..?
> 
> I wouldn't necessarily consider QC downstream code as a reliable source of
> truth ...
> 
>> Maybe newer SoCs/PMICs have a different config?
> 
> Commit aa92b3310c55 ("thermal/drivers/qcom-spmi-temp-alarm: Add support
> for GEN2 rev 1 PMIC peripherals") added support for gen2 PMICs, which
> actually have lower thresholds than gen1. From the log it seems that the
> PM6350 is identified as gen1 device (max stage 2 threshold = 140 degC).
> 
> It seems setting the limit to 140 degC or one of the other stage 2
> thresholds would be a reasonable course of action. stage 2 is the
> threshold at which the PMIC is so hot that the system should shut
> down, and 140 degC is the highest of the stage 2 thresholds. Even
> if it was possible, what would be gained from setting the trip
> point 5 degC higher?
Eeeh, if it ran at anything near that for prolonged time, the heat
would likely spread around the device causing the battery to
eventually combust.. Qualcomm DTs say one thing, but vendor
userspace daemons are far more conservative. Not sure if they're
still around (should be iirc), but I would definitely
object allowing anything inside [mainly] mobile devices to reach
that kind of temperature..

Konrad
