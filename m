Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5F479A68
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhLRKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:50:55 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41298
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbhLRKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:50:54 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E53C402EB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 10:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639824653;
        bh=Wa9ILGMaRHRGBy0aLVrTaW+lHyiaTJlPeVGkAqUVXAA=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=eyaMlDydNFdKarqgfHMjOPQAyYlqUCOSzWfK816ES8G/0agnxMyZWUTfBPQIQEUDu
         GCOYGaYpuQOFUVryDoKLU0PHwANrzqkSy2TR13Wfpx0Vcd6undnwTVE1c+UsHXcZqh
         i9ZYvSPJy4CP3qFGfj1/Knd32PLRwPQWxPCQlozW8Ow/gy1+mi+IEGxcbuRvB+TYyp
         JjJUKgEhiAysiytfyQ6u/48Ug1xjzkwa37TBis/0kGYiB2CqEMi8XCnxPgDrXgqDxu
         8MtuN/0j6hf43NyF6Yz7II+aAZQbp4lsq0vZnKz8gVXi8JkGK2o5IPeOcd8Siu5qZS
         IkBuRQDUEKiow==
Received: by mail-lf1-f72.google.com with SMTP id c40-20020a05651223a800b004018e2f2512so2151029lfv.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 02:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Wa9ILGMaRHRGBy0aLVrTaW+lHyiaTJlPeVGkAqUVXAA=;
        b=NuZx5WjuBazLWmwK45FIs3gZGxRdfu03Cg92uhlDnlgYE8SljLowThiaMhftiz0Xas
         NexAmza6cK6E8y7tYVUTfTEu/8QJD5+TqeY0JPHL04EqxVNuQRV7MmavP68OCzBo6aW3
         +9r0Hr768WySZ+haNnzrn3it43yYhhnrXAFSvVJrWWY6f4Wd/SQerjz+7N172twSl/5R
         SMbFXtlmdA/6VejH/NbosSNUCoUeVda/NOWSwiFazvLER26oLW5FzuAcv53yV116i5lg
         4n80xVXX/GnjOZ8/40+US0GYeL8M1BTftPy6ky2D0xO69TwHpZL9R23AL9rPzlHlyk6o
         Lf2Q==
X-Gm-Message-State: AOAM532fCbchp2ZvwxbAeL1t019N4Xfx2LXI+rfmefBbsYRadI5r1sux
        8uoBnrcKNyE54j3bMp3tPUV72J+mz4pAiCUqmjVZUEjEtKMddvbXUM5V+FXBTi4RcmNC67JYdzz
        XGiEl3IFXwYZE5+5RBCswzzbzmfBGTOuLCinF+AEaHg==
X-Received: by 2002:a05:6512:33a6:: with SMTP id i6mr5149393lfg.663.1639824652342;
        Sat, 18 Dec 2021 02:50:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI58O3aQ14JoDf1qzpEQ5Fr4XSXIQcCangkv6BKEfjOW3enxwPtjDy0n9OK2tsKPthEVp8EA==
X-Received: by 2002:a05:6512:33a6:: with SMTP id i6mr5149381lfg.663.1639824652175;
        Sat, 18 Dec 2021 02:50:52 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s4sm1676721lfp.198.2021.12.18.02.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 02:50:51 -0800 (PST)
Message-ID: <5ad0b0e7-1c09-b7eb-87a3-e62e9e3d12af@canonical.com>
Date:   Sat, 18 Dec 2021 11:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/2] dt-bindings: clock: exynos850: Add bindings for
 Exynos850 sysreg clocks
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        David Virag <virag.david003@gmail.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20211126203641.24005-1-semen.protsenko@linaro.org>
 <YagPWOj0CLxE/+ER@robh.at.kernel.org>
 <CAPLW+4=LTd8i2Tqr7Wa0NDRTJ5mRJXP=EvRCx84WxnwCDQ1eVg@mail.gmail.com>
 <CAPLW+4nk7Y8Psg9ZVacvzJeAV3VAGWfi+9hTPWgTeAWqh67AKQ@mail.gmail.com>
 <146b173e-f445-bebc-d44c-afd41123eb80@canonical.com>
In-Reply-To: <146b173e-f445-bebc-d44c-afd41123eb80@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 17:20, Krzysztof Kozlowski wrote:
> On 14/12/2021 17:15, Sam Protsenko wrote:
>> On Tue, 7 Dec 2021 at 22:54, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>>>
>>> On Thu, 2 Dec 2021 at 02:12, Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Fri, 26 Nov 2021 22:36:40 +0200, Sam Protsenko wrote:
>>>>> System Register is used to configure system behavior, like USI protocol,
>>>>> etc. SYSREG clocks should be provided to corresponding syscon nodes, to
>>>>> make it possible to modify SYSREG registers.
>>>>>
>>>>> While at it, add also missing PMU and GPIO clocks, which looks necessary
>>>>> and might be needed for corresponding Exynos850 features soon.
>>>>>
>>>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>>>> ---
>>>>>  include/dt-bindings/clock/exynos850.h | 12 +++++++++---
>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>
>>>>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>
>>> Hi Sylwester,
>>>
>>> Can you please review and apply this series, if it's ok?
>>>
>>
>> Hi Krzysztof,
>>
>> Do you think it's possible to take this series in your tree? Once it's
>> applied, I can send the board support (dts) series -- this is the only
>> remaining blocker for that right now.
> 
> I would need an Ack from Sylwester anyway. If you have dependencies (the
> DTS), you should send them together with it. Once Sylwester applies this
> patch, the DTS either waits till next release or it has to be modified
> to not depend on this patch.

Sylwester,

We need decision from your side. The apply-window is slowly closing, so
at least take it so DTSI will be free to go next cycle.

Best regards,
Krzysztof
