Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E248B47BBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhLUIVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:21:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55914
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234183AbhLUIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:21:01 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CB78D3F32C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640074859;
        bh=v0pYSSp/PcIv+PEuO43VB0PAVYtz/J9iayLFB3j6wVE=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=nkOOewOrIJMJrlKiNQWt4QLhTWCV6+7PRgZzLS5VpO/lVAc9kWT2vUQ+EZGu6iy4V
         B3rYtbC0oJw69XqZeLxnvXTK2tssIf9zXq/HFTwZPWEBe1ye9i2/0RUrxzeVr3bi3O
         3Dnotrb56u7nbRshIZgIZjeeuDQJICDToIjqfQWXjNvJEejxeF0ISREXvuGW+1wwH+
         8VTQTl1aK99YEpXQ3mltfEb+RWXgGM9/NuRJMLzpDFr72xSB9dRay0/4o9HqmkaxdU
         ZQJmNJ1EOLWAFO90ZCQ7gbw7FewEU8m/Rvv4wgqctSIfPDBC4PMe/cthbA8YotNFhr
         dCHfn9Jxeq2Rg==
Received: by mail-lf1-f70.google.com with SMTP id g18-20020a05651222d200b0042612bda352so1589653lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=v0pYSSp/PcIv+PEuO43VB0PAVYtz/J9iayLFB3j6wVE=;
        b=aSbCPL3Pim18Y7TR5uwKsCQ4G7PAP5t6NqP6OZ1ar76j/kcN7smQDlzIbIM5NYCn/T
         qQGjktPAwr2KaesD3ymsvfX5fBG7PLvYVJ3SVRcu8V4wdFh6XeGpnhjzYiTcNq2N2RtA
         DwBBofHkDjHozXaPko1YBNP34AhmmAcoKVr1+FyGtYET4WJhMeJvrE8Xx3TV/85g/DwO
         GwZkivMa2jSknucQm+b2/H+oBRifw03ZswEa1jAHJ8YgOZ8QM8Q4bhIlj7+OOuMuLvOc
         vUVa45dUtw89nuOdTi/0VOMIcCNheVJtKhno3CvjqchPnWxORYdPEDp3am4dOswFRcGm
         KEtg==
X-Gm-Message-State: AOAM533rdMfPyj3neB9j2Kt3bWZaMP2wc/Zok1HY2XAW7OpDHxgU/v/Z
        nPu5Wf1ICcuYMxMLyDQCJ05wq7Y9F8ZPFEAlcECYiulzBO9cyDg/5I2gS321Wg6Zl3t2Rj6a3Zu
        J5Jl78kCqYuEUre59Wy/zcCK3sfPGrDNm0o1s6iCydg==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr1760369ljg.68.1640074858377;
        Tue, 21 Dec 2021 00:20:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0OZUFkiXcgS9OL3e05QKQSZ+sUUPAqqBNMDEDrcXVHl2uJzLoQrvQudPyTdiPoAXlwrDzKA==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr1760338ljg.68.1640074858075;
        Tue, 21 Dec 2021 00:20:58 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w12sm881619lfe.256.2021.12.21.00.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 00:20:57 -0800 (PST)
Message-ID: <d10584ac-9ce6-9f8d-aeb9-8497e32f1661@canonical.com>
Date:   Tue, 21 Dec 2021 09:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20211217161549.24836-1-semen.protsenko@linaro.org>
 <20211217161549.24836-2-semen.protsenko@linaro.org>
 <2fdc5c97-6c19-8e70-d717-28b29d86160c@kernel.org>
 <5bd5c0bf-4390-22c2-e4e0-cb02b80dfb9c@canonical.com>
 <CAPLW+4msw_yeG4uDbS9mMULOuc43MK9O6Paya_Z2jBj2t6ZTiA@mail.gmail.com>
 <edd828b4-66ad-1c1e-4332-e1b05931e92a@canonical.com>
In-Reply-To: <edd828b4-66ad-1c1e-4332-e1b05931e92a@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2021 09:19, Krzysztof Kozlowski wrote:
> On 20/12/2021 15:55, Sam Protsenko wrote:
>> On Mon, 20 Dec 2021 at 11:31, Krzysztof Kozlowski
>> <krzysztof.kozlowski@canonical.com> wrote:
>>>
>>> On 19/12/2021 23:29, Sylwester Nawrocki wrote:
>>>> On 17.12.2021 17:15, Sam Protsenko wrote:
>>>>> System Register is used to configure system behavior, like USI protocol,
>>>>> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
>>>>> make it possible to modify SYSREG registers.
>>>>>
>>>>> While at it, add also missing PMU and GPIO clocks, which looks necessary
>>>>> and might be needed for corresponding Exynos850 features soon.
>>>>>
>>>>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>
>>>>> Acked-by: Rob Herring<robh@kernel.org>
>>>>> Acked-by: Chanwoo Choi<cw00.choi@samsung.com>
>>>>> Signed-off-by: Sam Protsenko<semen.protsenko@linaro.org>
>>>>
>>>> Apologies for late reply, this patch is applied now.
>>>>
>>>
>>> Sam,
>>>
>>> The clock is used in the DTSI, so since this was applied, there are only
>>> two choices now:
>>> 1. wait for next cycle with DTSI and DTS,
>>> 2. Resubmit with replacing the newly added clocks in DTSI/DTS with
>>> numbers and a TODO note.
>>>
>>
>> But why? I thought because Sylwester applied my clock patches, those
>> will get into v5.17, and so DTSI/DTS might rely on those clocks? If I
>> get it wrong, please let me know why, and I'll go with item (2) you
>> suggested.
> 
> If I apply the DTSI+DTS, all my builds will start failing. The
> linux-next (since Sylwester's tree is included) should build fine, but
> my tree won't be buildable anymore. Then arm-soc pulls my tree and gets
> said because it does not build. Later, Linus will be unhappy if he pulls

s/said/sad/ obviously :)

> arm-soc (thus mine) before clock tree.
> 
> Other solution, instead of using raw numbers, is to copy-paste the clock
> macros you use directly in DTSI and do not include the clock header.
> This actually might be cleaner choice - changes will be limited to one
> place in DTSI.
> 
> Best regards,
> Krzysztof
> 


Best regards,
Krzysztof
