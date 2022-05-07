Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71851E97F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446874AbiEGTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiEGTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:34:32 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D317ABD;
        Sat,  7 May 2022 12:30:40 -0700 (PDT)
Received: from [10.0.0.209] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id E139C2007F;
        Sat,  7 May 2022 21:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1651951836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBgrBctusl2KdU51JeeQGLmL27dGU5bCAkAXZtAGtio=;
        b=hoar1WXaOQHm22+HDxJCebarFpAAnJbBuJsZsiibHs03bj+RCs6LGoSivs1iuoC/SjkQfw
        4RRSH2f3f0ca7eeZzmFXua2ytpzj8b3OnQ5Y88lJOQ3ceRbDhqm+rljcnhrVtmVDW/R4m+
        jDiHdtsq2Pp3judabrORYHSGsvM3b4A=
Message-ID: <dc6a4728-f08d-caa3-29c6-7f4a18e77f11@ixit.cz>
Date:   Sat, 7 May 2022 21:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] dt-bindings: watchdog: improve QCOM compatible parsing
 for modern chips
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     ~okias/devicetree@lists.sr.ht, Rob Herring <robh@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111212310.97566-1-david@ixit.cz>
 <9bcdec7e-2b09-56ac-f798-1c3971a87f46@linaro.org>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <9bcdec7e-2b09-56ac-f798-1c3971a87f46@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/05/2022 19:22, Krzysztof Kozlowski wrote:
> On 11/01/2022 22:23, David Heidelberg wrote:
>> Parse compatible as expected for modern QCOMs.
>>
>> Fixes warnings as:
>> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: watchdog@17980000: compatible: ['qcom,apss-wdt-sdm845', 'qcom,kpss-wdt'] is too long
>>          From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: watchdog@17980000: compatible: Additional items are not allowed ('qcom,kpss-wdt' was unexpected)
>>          From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>> v2:
>>   - updated compatible list as two compatibles has been added upstream
>>   -> resolve merge conflict
>> ---
>>   .../bindings/watchdog/qcom-wdt.yaml           | 37 +++++++++++--------
>>   1 file changed, 21 insertions(+), 16 deletions(-)
> It seems this patch received three reviews but was not picked up. David,
> do you plan to work on this?
>
>> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> index 16c6f82a13ca..4ff8c59c59ab 100644
>> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> @@ -14,22 +14,27 @@ allOf:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - qcom,apss-wdt-qcs404
>> -      - qcom,apss-wdt-sc7180
>> -      - qcom,apss-wdt-sc7280
>> -      - qcom,apss-wdt-sdm845
>> -      - qcom,apss-wdt-sdx55
>> -      - qcom,apss-wdt-sm6350
>> -      - qcom,apss-wdt-sm8150
>> -      - qcom,apss-wdt-sm8250
>> -      - qcom,kpss-timer
>> -      - qcom,kpss-wdt
>> -      - qcom,kpss-wdt-apq8064
>> -      - qcom,kpss-wdt-ipq4019
>> -      - qcom,kpss-wdt-ipq8064
>> -      - qcom,kpss-wdt-msm8960
>> -      - qcom,scss-timer
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - qcom,apss-wdt-qcs404
>> +              - qcom,apss-wdt-sc7180
>> +              - qcom,apss-wdt-sc7280
>> +              - qcom,apss-wdt-sdm845
>> +              - qcom,apss-wdt-sdx55
>> +              - qcom,apss-wdt-sm6350
>> +              - qcom,apss-wdt-sm8150
>> +              - qcom,apss-wdt-sm8250
>> +          - const: qcom,kpss-wdt
>> +      - items:
>> +          - enum:
>> +              - qcom,kpss-wdt
>> +              - qcom,kpss-timer
>> +              - qcom,kpss-wdt-apq8064
>> +              - qcom,kpss-wdt-ipq4019
>> +              - qcom,kpss-wdt-ipq8064
>> +              - qcom,kpss-wdt-msm8960
> These do not look correct without appropriate fallback.

Yes the situation there isn't optimal and I'm afraid I cannot solve it 
in scope of this change.

Previously I was thinking about also merging MSM timer into this 
binding, which shares the compatible, but uses different driver. Sadly, 
currently don't have a time for it (have some WIP patch locally, if 
anyone interested to take a look).

I'm (re-)sending v3 with another S-off, but it solves only warnings 
described in commit message.

David

>
>> +              - qcom,scss-timer
>>   
>>     reg:
>>       maxItems: 1
>
> Best regards,
> Krzysztof

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

