Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA54D7DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiCNIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiCNIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:37:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435F43FBDF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:36:07 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B8583F79B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647246965;
        bh=eKjUtd7ByB5BRtEYaGOQ6lKKOtW7nvc1QYzmEKc7RCs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=P+i4epapW0od3nVrJed4wQwW8DkwOtnnJiauN+RJRoXnFc3SqO7GSEvQfPx2MAOLW
         NOp1OJda3JpMldAoVVfYCA26cliQ5cZ/O/LJbQ00KfTsyd+ym4Xp2FleRdiVeAauEs
         sICEcenK4yUUnJg0HwPWlf9blQLFeDA/etnbogY4a7hV/cO16FMS6Z9Mn4/Kb3DOHC
         oCva5oFdGCLa0GMrFEfTG+tkkswHRw2Ma3w6QrXbzUHHRR9KisscbtBoYAgXr9qUNK
         YC2eKpsn1qHDb6pH6nfSXu2ugSuFMW3uC8ClnT3voiLRKGjygdUv03Tuf6ecEVG9u3
         irtVxWPvIoPBQ==
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso8275886edh.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eKjUtd7ByB5BRtEYaGOQ6lKKOtW7nvc1QYzmEKc7RCs=;
        b=LgFQDU8LB1kNo7+5idVR9WBNIr80wCSJ4gx0N6otYu+LQTkoA3qDLg2r0A9oUYUtrH
         WmPNX0p+X11omaoK/kTczmB4Cs2LED9DmD2MhSnsI46ndz+VNyqVDiGZmFdrm0iJhxXk
         FoKbjXz3ziZ1qlojMSy6KgbQqNKd//YDIjbh8GQMK5ULofKkMI1wQE0p0yyX/lzf8vbz
         aSXPT6aqWBrdQA29E2hjHwGW11b6w5a8WJEGDooSmvKQR6jTS92NVq+9HRsfpKnAKdPi
         j0uxuulEAtMI56wswtlChm0ZeSDHj8MrCSb4Zs924eUHaDXqINx5vTb8n+WijCsdG73A
         NkUw==
X-Gm-Message-State: AOAM533B9hND10tIA4Th7REUqtoWNsXBTPajnYGYNkZEDO5sBRaZNMrY
        9v1mUFHU14R3xbFTbXQ1nf/ji4HR+Ogo5E/sndOrZ59KdC9KMXY8fVm30QGH76ceR+yLpXN2j0P
        hZ/pCDyA1XfoWJUjfzy2yf6VHuI+hZav6qnryBZNC+w==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr19814954edt.186.1647246964836;
        Mon, 14 Mar 2022 01:36:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZkFoJYS5BSY8Z5fUfZgL7U2bI7mlWLX45AeUH2LOa4L1NioNNryVlI/34QqHMTfIflzb2bw==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr19814933edt.186.1647246964581;
        Mon, 14 Mar 2022 01:36:04 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id qt22-20020a170906ecf600b006da6ef9b820sm6500282ejb.112.2022.03.14.01.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 01:36:04 -0700 (PDT)
Message-ID: <c88396f4-4cfe-d375-1dcd-b34a6496cb06@canonical.com>
Date:   Mon, 14 Mar 2022 09:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com
References: <1646288011-32242-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com>
 <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
 <20220314032952.GA27561@hu-pkondeti-hyd.qualcomm.com>
 <f1621a67-a0ff-f111-c4da-9401924e7f4a@canonical.com>
 <20220314081613.GA28402@hu-pkondeti-hyd.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220314081613.GA28402@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 09:16, Pavan Kondeti wrote:
> Hi Krzysztof,
> 
> On Mon, Mar 14, 2022 at 08:39:57AM +0100, Krzysztof Kozlowski wrote:
>> On 14/03/2022 04:29, Pavan Kondeti wrote:
>>> Hi Krzysztof,
>>>
>>> On Thu, Mar 03, 2022 at 04:59:22PM +0100, Krzysztof Kozlowski wrote:
>>>> On 03/03/2022 07:13, Sandeep Maheswaram wrote:
>>>>> Add device tree bindings for SNPS phy tuning parameters.
>>>>>
>>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>>> ---
>>>>>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 125 +++++++++++++++++++++
>>>>>  1 file changed, 125 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>>> index 0dfe691..227c097 100644
>>>>> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>>> @@ -50,6 +50,131 @@ properties:
>>>>>    vdda33-supply:
>>>>>      description: phandle to the regulator 3.3V supply node.
>>>>>  
>>>>> +  qcom,hs-disconnect:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description:
>>>>> +      This adjusts the voltage level for the threshold used to
>>>>> +      detect a disconnect event at the host. Possible values are.
>>>>
>>>> ':', instead of full stop.
>>>>
>>>>> +      7 -> +21.56%
>>>>> +      6 -> +17.43%
>>>>> +      5 -> +13.32%
>>>>> +      4 -> +9.73%
>>>>> +      3 -> +6.3
>>>>> +      2 -> +3.17%
>>>>> +      1 -> 0, Design default%
>>>>
>>>> Use "default:" instead. Here and in other places.
>>>>
>>>>> +      0 -> -2.72%
>>>>
>>>> In current form this should be an enum... but actually current form is
>>>> wrong. You should not store register values in DT. What if next version
>>>> of hardware has a different meaning of these values?
>>>>
>>>> Instead, you should store here meaningful values, not register values.
>>>>
>>>
>>> Thanks for the feedback.
>>>
>>> The values in % really makes the tuning easy. People look at the eye diagram
>>> and decided whether to increase/decrease the margin. The absolute values
>>> may not be that useful. All we need is an "adjustment" here. The databook
>>> it self does not give any absolute values.
>>>
>>> I agree to the "enum" suggestion which we have been following for the
>>> qusb2 driver already. 
>>>
>>> The values have not changed in the last 5 years for this hardware block, so
>>> defining enums for the % values would be really helpful. 
>>
>> I did not say you cannot store here percentages. Quite opposite - store
>> here the percentages. Just do not store register value. No. Please read
>> my comment again - meaningful values are needed.
>>
> 
> IIUC, you are asking us to come up with a meaningful values to encode the
> percentage values. However, all the % increments are not linear, so we can't
> come up with {min, max} scheme. Lets take an example of hostdisconnect
> threshold.
> 
> As per the data book,
> 
> +      7 -> +21.56%
> +      6 -> +17.43%
> +      5 -> +13.32%
> +      4 -> +9.73%
> +      3 -> +6.3
> +      2 -> +3.17%
> +      1 -> 0, Design default%
> +      0 -> -2.72%
> 
> so how do we give meaningful values here? Does the below scheme make sense
> to you?

By "meaningful value" I mean something which has a understandable
meaning to reader of this code or to hardware designer. For example
percentage values or some units (ms, ns, Hz, mA, mV). The value used in
register is not meaningful in that way to us because it has a meaning
only to the hardware block. Storing register values is more difficult to
read later, non-portable and non-scalable.

> 
> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_NEG_2P72	(-272)
> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_DEFAULT	0
> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_3P17	317
> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_6P3	63

This is some define in driver, does not look related to bindings.

> In the driver, we have a mapping (which can be per SoC if required in future)
> that takes these values and convert to the correct values for a given
> register.

You focus on driver but I am talking here only about bindings.

What could be the meaningful value? Percentage could work. You have
there a negative value, so I wonder what type of percentage is it? What
is the formula?

Your defines above look absolute, so maybe encode there absolute uV value?

Best regards,
Krzysztof
