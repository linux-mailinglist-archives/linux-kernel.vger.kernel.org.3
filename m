Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D555B316
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiFZROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiFZROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:14:00 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63072DF51;
        Sun, 26 Jun 2022 10:13:57 -0700 (PDT)
Received: from [10.0.0.163] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 4CC112007F;
        Sun, 26 Jun 2022 19:13:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1656263635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqvmWyTsVuvs/huJ/V36dOyCmwQvHHFwtiV6jD5FiDE=;
        b=HOwivlHYajhNQmpv4nAngJYyDm80OCWMv680pq128OJYichPedj9gbHk3RQksu9nrN1Aq3
        Q8ZfGYkOoVWt623U7QXbPMDUEwQ5aTTEEwQoxbs4eIuOatYAgour3RsgSCdaVn8YZdGC4c
        V5naMI6PtHMwmWUxI1va+QeScy2RLuc=
Message-ID: <8704fbd6-94a1-5692-5ccb-95f66ffaaf6f@ixit.cz>
Date:   Sun, 26 Jun 2022 19:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] dt-bindings: firmware: convert Qualcomm SCM
 binding to the yaml
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Robert Marko <robimarko@gmail.com>
References: <20220626114634.90850-1-david@ixit.cz>
 <20220626114634.90850-3-david@ixit.cz>
 <d00d6c3e-7d65-9021-7a26-486c705a16de@linaro.org>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <d00d6c3e-7d65-9021-7a26-486c705a16de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2022 18:45, Krzysztof Kozlowski wrote:
> On 26/06/2022 13:46, David Heidelberg wrote:
>> Convert Qualcomm SCM firmware binding to the yaml format.
>>
>> This commit also:
>>   - adds qcom,scm-mdm9607 into list which has only core clock
>>   - adds qcom,scm-sm6125, qcom,scm-ipq6018
>>   - #reset-cells, because the property is already used
>>
>> Cc: Robert Marko <robimarko@gmail.com>
>> Cc: Guru Das Srinagesh <quic_gurus@quicinc.com>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>> v3:
>>   - add preceding patches for ARM and arm64 adding missing compatible strings
>>   - extended with missing compatible strings
>>   - added two additional maintainers, see https://lkml.org/lkml/2022/6/23/1969
>> v2:
>>   - changed maintainer to Bjorn
>>   - document #reset-cells
>>
>>   .../devicetree/bindings/firmware/qcom,scm.txt |  57 --------
>>   .../bindings/firmware/qcom,scm.yaml           | 131 ++++++++++++++++++
>>   2 files changed, 131 insertions(+), 57 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>>   create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
>> deleted file mode 100644
>> index 0f4e5ab26477..000000000000
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
>> +++ /dev/null
>> @@ -1,57 +0,0 @@
>> -QCOM Secure Channel Manager (SCM)
>> -
>> -Qualcomm processors include an interface to communicate to the secure firmware.
>> -This interface allows for clients to request different types of actions.  These
>> -can include CPU power up/down, HDCP requests, loading of firmware, and other
>> -assorted actions.
>> -
>> -Required properties:
>> -- compatible: must contain one of the following:
>> - * "qcom,scm-apq8064"
>> - * "qcom,scm-apq8084"
>> - * "qcom,scm-ipq4019"
>> - * "qcom,scm-ipq806x"
>> - * "qcom,scm-ipq8074"
>> - * "qcom,scm-mdm9607"
>> - * "qcom,scm-msm8226"
>> - * "qcom,scm-msm8660"
>> - * "qcom,scm-msm8916"
>> - * "qcom,scm-msm8953"
>> - * "qcom,scm-msm8960"
>> - * "qcom,scm-msm8974"
>> - * "qcom,scm-msm8976"
>> - * "qcom,scm-msm8994"
>> - * "qcom,scm-msm8996"
>> - * "qcom,scm-msm8998"
>> - * "qcom,scm-sc7180"
>> - * "qcom,scm-sc7280"
>> - * "qcom,scm-sdm845"
>> - * "qcom,scm-sdx55"
>> - * "qcom,scm-sm6350"
>> - * "qcom,scm-sm8150"
>> - * "qcom,scm-sm8250"
>> - * "qcom,scm-sm8350"
>> - * "qcom,scm-sm8450"
>> - and:
>> - * "qcom,scm"
>> -- clocks: Specifies clocks needed by the SCM interface, if any:
>> - * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
>> -   "qcom,scm-msm8960"
>> - * core, iface and bus clocks required for "qcom,scm-apq8084",
>> -   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
>> -- clock-names: Must contain "core" for the core clock, "iface" for the interface
>> -  clock and "bus" for the bus clock per the requirements of the compatible.
>> -- qcom,dload-mode: phandle to the TCSR hardware block and offset of the
>> -		   download mode control register (optional)
>> -
>> -Example for MSM8916:
>> -
>> -	firmware {
>> -		scm {
>> -			compatible = "qcom,msm8916", "qcom,scm";
>> -			clocks = <&gcc GCC_CRYPTO_CLK> ,
>> -				 <&gcc GCC_CRYPTO_AXI_CLK>,
>> -				 <&gcc GCC_CRYPTO_AHB_CLK>;
>> -			clock-names = "core", "bus", "iface";
>> -		};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> new file mode 100644
>> index 000000000000..17d06e75b82b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -0,0 +1,131 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/firmware/qcom,scm.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> No quotes here.
>
>> +
>> +title: QCOM Secure Channel Manager (SCM)
>> +
>> +description: |
>> +  Qualcomm processors include an interface to communicate to the secure firmware.
>> +  This interface allows for clients to request different types of actions.
>> +  These can include CPU power up/down, HDCP requests, loading of firmware,
>> +  and other assorted actions.
>> +
>> +maintainers:
>> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>> +  - Robert Marko <robimarko@gmail.com>
>> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,scm-apq8064
>> +          - qcom,scm-apq8084
>> +          - qcom,scm-ipq4019
>> +          - qcom,scm-ipq6018
>> +          - qcom,scm-ipq806x
>> +          - qcom,scm-ipq8074
>> +          - qcom,scm-mdm9607
>> +          - qcom,scm-msm8226
>> +          - qcom,scm-msm8660
>> +          - qcom,scm-msm8916
>> +          - qcom,scm-msm8953
>> +          - qcom,scm-msm8960
>> +          - qcom,scm-msm8974
>> +          - qcom,scm-msm8976
>> +          - qcom,scm-msm8994
>> +          - qcom,scm-msm8996
>> +          - qcom,scm-msm8998
>> +          - qcom,scm-sc7180
>> +          - qcom,scm-sc7280
>> +          - qcom,scm-sdm845
>> +          - qcom,scm-sdx55
>> +          - qcom,scm-sm6125
>> +          - qcom,scm-sm6350
>> +          - qcom,scm-sm8150
>> +          - qcom,scm-sm8250
>> +          - qcom,scm-sm8350
>> +          - qcom,scm-sm8450
>> +          - qcom,scm-qcs404
>> +      - const: qcom,scm
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 3
>> +
>> +  clock-names: true
> You should have constraints here - min/maxItems.
>
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  qcom,dload-mode:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to TCSR hardware block
>> +          - description: offset of the download mode control register
>> +    description:
>> +      Should be phandle/offset pair.
> This description is not helpful. Should be something closer to "TCSR
> hardware block".
>
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,scm-apq8064
>> +              - qcom,scm-mdm9607
>> +              - qcom,scm-msm8660
>> +              - qcom,scm-msm8960
>> +    then:
>> +      properties:
>> +        clock-names:
>> +          items:
>> +            - const: core
> Missing constraints (maxItems:2) for clocks.

Why 2? I would put `maxItems: 1` there


>
>> +
>> +      required:
>> +        - clocks
>> +        - clock-names
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,scm-apq8084
>> +              - qcom,scm-msm8916
>> +              - qcom,scm-msm8953
>> +              - qcom,scm-msm8974
>> +              - qcom,scm-msm8976
>> +    then:
>> +      properties:
>> +        clock-names:
>> +          items:
>> +            - const: core
>> +            - const: bus
>> +            - const: iface
> Missing constraints for clocks.
>
>> +
>> +      required:
>> +        - clocks
>> +        - clock-names
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
> Best regards,
> Krzysztof

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

