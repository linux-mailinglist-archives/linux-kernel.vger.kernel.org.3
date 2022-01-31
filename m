Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219A84A46EF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359767AbiAaMYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:24:46 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46302
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241079AbiAaMYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:24:43 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 434793F1C6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643631878;
        bh=RS8b/Wq/sjAzqIIpV7S5JBsz6wb8tK0SUM0mXHn4sk0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pmUWDbCKKoffVwJ9D5QMiDkTZ1JxHgH7bMYMLFlhKhr2e7tPoZI1gxxLHFODD2jjZ
         MNwSCRslOlXJI6kXsySJozf26UI03A1FiJqf1GI/Z1bBCRpailLThDvqgWNuTCTKxP
         PIj/zjRpyeW0qubSIK+h+7vwDsFMIB7J4s8AeAFly9sN6rim1Riynos7LSCt5uUQY5
         3R3si0JRm3yVltCNZahzGdiHCQItb4QQajVkiXvUfLV0sgCVp63b/o8HlChSudsXDv
         PqnsBlrJXIQMDJ1H1GmXuoL18n+VYCYbefEtQ+6ASOM/wHhwa0FoKw2K3fLimXm+V9
         6vu4gYk6OnHtw==
Received: by mail-ed1-f69.google.com with SMTP id k10-20020a50cb8a000000b00403c8326f2aso6876823edi.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RS8b/Wq/sjAzqIIpV7S5JBsz6wb8tK0SUM0mXHn4sk0=;
        b=Smt29xIaN2b+c5cqLCVytHlrhgqa3VkOIu6qCdfTV93TF8aHpJlznYBSXuFRVcekZI
         R1MrrQOEha+gSMuOqy84edZQ2QHkIWHPSSZyQlddUEkj0AJ/kAzaxUjY6Levioq0tO0z
         0l+FI5r0AZ8OUcsQfJ5iA7gfJQyHqPU2w1g9QTJjgMeprFINdP5Ry0yTccdtirCLGkvj
         Pz3GcqFouiRaMr6NgJIJu6jr5ran+Z8ijD0Llvz1a4ct/Xz8ARNbKUwLu6RocGkTHfWG
         o+uvDWae2N0DpDvwTz090U6WSdqKE8mpFDDt9t4sSQvRnNPbQq5m4smKdixvs168Oiwq
         Vbhw==
X-Gm-Message-State: AOAM530AHE91BjkwPeln7AyJw5bOaboR8grn1jXcD9LqY9M5RDaE74AC
        Ut2KnKXXpm79Ctcw9Jkvsle91BIx8XMukhKpN+0W6x+Y80q/XWr7iILNxg3QVViCBlaqTPkFQKy
        gCAzkXSoJqZi2rRJZBrVQXF13KZnLEuXttY2Bm6no5g==
X-Received: by 2002:a17:906:5d0e:: with SMTP id g14mr16809389ejt.211.1643631877674;
        Mon, 31 Jan 2022 04:24:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNtuvn5vB5b3DM+JHOgOOezTxGo5qVfsW4JApSUhBXJObPfK5NT15b1j1a986n8t0sT14T+w==
X-Received: by 2002:a17:906:5d0e:: with SMTP id g14mr16809378ejt.211.1643631877535;
        Mon, 31 Jan 2022 04:24:37 -0800 (PST)
Received: from [192.168.0.73] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id a23sm17585360eda.94.2022.01.31.04.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 04:24:37 -0800 (PST)
Message-ID: <1b04c8b0-389b-8937-ef2c-47719e771a25@canonical.com>
Date:   Mon, 31 Jan 2022 13:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: add 533 MHz step to p4note GPU opp table
Content-Language: en-US
To:     =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220129221452.GA36524@adroid>
 <131c9bd9-b035-8a75-ca27-f9c2b3993566@canonical.com>
 <20220131121559.GA4022@adroid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220131121559.GA4022@adroid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2022 13:15, Martin Jücker wrote:
> On Mon, Jan 31, 2022 at 09:54:00AM +0100, Krzysztof Kozlowski wrote:
>> On 29/01/2022 23:14, Martin Jücker wrote:
>>> The p4note devices support 533 MHz GPU speed, so let's make use of it.
>>>
>>
>> If there is going to be resend, please add prefix "exynos:" in subject.
>> Just like other commits (git log --oneline arch/arm/boot/dts/exynos*).
>>
>>> Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/exynos4412-p4note.dtsi | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
>>> index 4ae6eb3091c4..d277b2337ae0 100644
>>> --- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
>>> @@ -355,6 +355,13 @@ &gpu {
>>>  	status = "okay";
>>>  };
>>>  
>>> +&gpu_opp_table {
>>> +	opp-533000000 {
>>> +		opp-hz = /bits/ 64 <533000000>;
>>> +		opp-microvolt = <1075000>;
>>> +	};
>>> +};
>>
>> This looks like Exynos4412 Prime. Please check also CPU frequencies and
>> if they match, just include exynos4412-prime.dtsi (like Odroid U3).
>>
>>> +
>>>  &hsotg {
>>>  	vusb_a-supply = <&ldo12_reg>;
>>>  	dr_mode = "peripheral";
>>
>>
>> Best regards,
>> Krzysztof
> 
> I just noticed, that I overlooked a condition in the code which
> decreases the step count by one which eliminates the 533 MHz step.
> Please ignore this patch.

Yeah:
	if(samsung_rev() < EXYNOS4412_REV_2_0)
		step_num = MALI_DVFS_STEPS - 1;

Your case, although possible, would be unlikely.

Best regards,
Krzysztof
