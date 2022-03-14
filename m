Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283A54D8014
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiCNKmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiCNKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:42:40 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538E343AF4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:41:31 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D89433FDC7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647254489;
        bh=cR8L9DGP3yJSDi44x8gY1TGjdeDaEHMP44/lzSW8rUQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uZ1YNzHChHmCeH+THODOAPEsCaIwQg65eSDPPYJu4McYWuq9pumNDgtR2wYIVQVuv
         DPDYLKURuGTvJTBPwPrbBQaoNKxezHUDyHTqrQaTItMXmgYe2surs3nryfu7KO8xx2
         7I8aYTM52kGQOjrDfYswCL8R8oVQcsC1KqlJwJ2uVSURDAItNG0VU/L+Ox78/5kHXX
         Dv7VVWdLh4GXZntNWj9L9SuNn89F+nHaWwkskyS8sNivhioMmQtFKTFvCL4jpAvkzV
         uBi92J7/cpR/mvKx6L1DDTTBTbQ5IffRfysUHPrP7BGKuFVfiE0SuCGTqt2OXHO8aF
         MwCqZfGfJcYkw==
Received: by mail-ed1-f72.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so8469784edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cR8L9DGP3yJSDi44x8gY1TGjdeDaEHMP44/lzSW8rUQ=;
        b=Z6rmS/3k+NWUKWB/1uXsox0oQLVofxTJbIu7Izsrv84YE9icqrMRy8NAR6z24KpIaR
         WQpy6zQcv9aSA2Tt/cYcrpDPM5Cp9RZ2KhuZdMYs1ASo40IqrRjvBHC4Pza+IUlfHu3D
         aDGoaamasYBVN5z0BYz3vMJFJ0ELTqXLqtlRVoKwY0b4NAyGzFioi6V9n3+DHTRlH5Vp
         CF8LgfPAfCN4GAvt9ZC+Y7m26uPFnqBHYJ8dpwlgb7J1ydC03Ig7kmhULg60NB9rrtsp
         1JUAtVzqbpqcR4DV3T7R8z6pJD0CvjgaLxSdaAhHF3UBjmpavTF81APoEDQMjTQ5VMfr
         Go0w==
X-Gm-Message-State: AOAM530cLS59+6/rDF3QfYxFdo/ADde+yyYF/+7KUQPY3v2Cy6xMWZVO
        q0LB30RTACIzknqxUDKRgRXbPC364TIjQBKXBmJckDN+L2QjKCJAHIDjibvkZFTbFiK8Pvb3mlf
        vuxdkHZcuN7TpBmf2zxGb9DsHYVJb4u6ckoJ1tyH8VQ==
X-Received: by 2002:a17:906:c116:b0:6d6:f8b3:cd47 with SMTP id do22-20020a170906c11600b006d6f8b3cd47mr18639533ejc.501.1647254489238;
        Mon, 14 Mar 2022 03:41:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSOTbmSAF6uG3GM22YAt0E/KC7wWNF2wsOIEvYm9csbBjNR+5AfgsSfbdmR5FElce7jWg1qA==
X-Received: by 2002:a17:906:c116:b0:6d6:f8b3:cd47 with SMTP id do22-20020a170906c11600b006d6f8b3cd47mr18639508ejc.501.1647254489015;
        Mon, 14 Mar 2022 03:41:29 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id er12-20020a056402448c00b00413d03ac4a2sm7380218edb.69.2022.03.14.03.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 03:41:28 -0700 (PDT)
Message-ID: <fadbc93f-8741-58c6-d0e5-dc740e0f0724@canonical.com>
Date:   Mon, 14 Mar 2022 11:41:27 +0100
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
 <c88396f4-4cfe-d375-1dcd-b34a6496cb06@canonical.com>
 <20220314094054.GB28402@hu-pkondeti-hyd.qualcomm.com>
 <b45b3b7e-e1c0-79b6-81c0-53c70427dd10@canonical.com>
 <20220314103045.GA31533@hu-pkondeti-hyd.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220314103045.GA31533@hu-pkondeti-hyd.qualcomm.com>
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

On 14/03/2022 11:30, Pavan Kondeti wrote:
> Hi Krzysztof,
> 
>>
>> Ah, I did not get it. That's not the solution for this case. defines in
>> dt-bindings are for constants which already can be in DT, e.g. IDs. Your
>> register values should not be stored in DT.
>>
> These are again not register definitions. These are encodings that dT and
> driver can use. These would be constants only, no?

What do you mean it is not a register value? I don't have access to
datasheet/manual but I can clearly see code:

+	if (or->hs_disconnect.override)
+		qcom_snps_hsphy_write_mask(hsphy->base,
+			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
+			HS_DISCONNECT_MASK,
+			or->hs_disconnect.value << HS_DISCONNECT_SHIFT);

You read the value from DT (e.g. "3" which means 6.3% for hs-disconnect)
and you write it to a register. Directly. 3 is a value for the hardware,
meaningless outside of it. It has meaning only in this one hardware
programming model. For humans it means nothing. For humans 6.3% means
something.

>>>
>>>>
>>>> What could be the meaningful value? Percentage could work. You have
>>>> there a negative value, so I wonder what type of percentage is it? What
>>>> is the formula?
>>>
>>> I just multiplied by 100 since device tree has no support for floating (as per
>>> my knowledge). The negative value represents it lowers the disconnect
>>> threshold by 2.72% of the default value. if it makes sense, we could also
>>> start from 0 like below.
>>
>> ok
>>
>>>
>>> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_NEG_2P72_PCT 0
>>> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_DEFAULT	1
>>> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_3P17_PCT	2
>>> #define QCOM_SNPS_FEMTO_HS_DISCONNECT_6P3_PCT	3
>>>
>>> The driver can have a table to map these bindings. This looks much better
>>> than those x100 formula values.
>>
>> Again mention driver how he can map it. I mostly don't care about the
>> driver. :)
>>
>> I think we are getting around the problem, so to emphasize again: do not
>> store register values in the bindings/DT but its meaning, so in your
>> case most likely percentages (or permille or ratio or some other value).
>>
> 
> I am really confused on what is that you mean by not storing the registers
> here. We are only giving enum values for specific percentages supported by
> the PHY. 

The enum consists of values used in hardware registers. Values having
meaning only to this one particular hardware. Any other hardware will
not understand them.

IOW, you embed the hardware programming model in the DT. No.

> if you see -2.72 corresponds to 0 value on 0:2 bits of a register.
> I did not mention that in the device tree. we are giving constant values
> (enums) for all the possible percentage values. The user can see the
> dt-bindings file and pass the approriate value based on the compliance
> results. What is the objection?

You use some unrelated arguments. How does it matter what user can see
or cannot see?

> 
> can you please give an example if you have something in mind? 

I gave you an example - use percentages. Another example how it was done
wrong is here:
https://lore.kernel.org/linux-devicetree/c6607953-927e-4d85-21cb-72e01a121453@kernel.org/


Best regards,
Krzysztof
