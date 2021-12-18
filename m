Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A7479A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhLRKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:37:52 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56778
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhLRKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:37:50 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 07BB13FFDD
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 10:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639823868;
        bh=LDSDrmQFQEPs0AYtnIdv1IgjreVq4x1VFmfenDdMBLE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IkAA1d1H5ke08ERa0RKwPDAUBIhwCP0swVSOeGeWBrBshVKgO+G06aawl3g3h9geG
         CJEBwn5eHceQSfLfhdbYhTd27hzYlbNNnCjaAlygU4n3TRRBKgo7YYRYElSwa9TlJm
         ezezcWv+4Ni/4dW0cAsRKqlup9AIiNfeEiTqt8rvbPGjK1Uqhid3tOeqCEgIKZQjeK
         vbkKvIQz1dhhQQvqk2IMyRXosuUKqPfas1DyO3Xs8yQt1k02ISDEfPzGEfQSk5vM93
         p7Gn/0MOs9loKV3P1j1gGJHJDD0EfQMd4eBMBUaA+x49hyzWSt7OCul4qsjyX5P3RW
         Z3jXolp0Q94Rw==
Received: by mail-lf1-f71.google.com with SMTP id c40-20020a05651223a800b004018e2f2512so2140674lfv.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 02:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LDSDrmQFQEPs0AYtnIdv1IgjreVq4x1VFmfenDdMBLE=;
        b=aw8gzxRDW0KQretn2S/ey+s0caijp9u96ukIW29b0FTlt4+I7aAaXk/O/GLVvrGOaL
         SzTK5mh+dLiXE5ZbUo5N5rhexEnHNk8yB799c1z47frrmh34X3XdslUgAe65ueC2XWwU
         35rvrAR89e3NfkeStxGd+DGdYKzZ7Jf3/9qXcCt5AwwxyBlcMs49RPa9p1UixSwHrOTb
         Z3Hy/45abPwe6W9We+w4wTcUIEDfhQiv3WqAWBYEXHxarsFZiJNyqzdY+SP6Nav/YfVy
         bCLfWCbfxgvmJcN1kBHN/kxBufF7EGlcCJW9ttf8ReoAgZXfsjXn+GlnSoer5JydGi3c
         W80Q==
X-Gm-Message-State: AOAM530D+UG2sxBITtomhkr6VHKUeZKoU8CsyXi+hvOLJOD5CFDasVm4
        16kZmxSNbQ4A/cf9wgJ3YK9EO0LmMnG2QTGgR8+mIuwLRtH/EB/I1bd9uNDOtfaLb+d9RzZ1PaO
        HjsoU+Oq8m0rklnuy50M1Mp8rbPw8QI5FZnFGntUkiQ==
X-Received: by 2002:ac2:57db:: with SMTP id k27mr6746127lfo.652.1639823867318;
        Sat, 18 Dec 2021 02:37:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFPjW4FhzC6siK+EU1JldkI45ctb06HwBavX8cSF/Dm+d0Cp+CPDqvzJoTiq7Mk6+JWyBNUA==
X-Received: by 2002:ac2:57db:: with SMTP id k27mr6746110lfo.652.1639823867154;
        Sat, 18 Dec 2021 02:37:47 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b17sm1054lfq.238.2021.12.18.02.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 02:37:46 -0800 (PST)
Message-ID: <cd97d5f8-42ff-98a4-2dfe-7d8076cf5e53@canonical.com>
Date:   Sat, 18 Dec 2021 11:37:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 6/7] arm64: dts: exynos: Add initial Exynos850 SoC support
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@gmail.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
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
        open list <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
 <20211215160906.17451-7-semen.protsenko@linaro.org>
 <CAGOxZ52h-PL7ii-qDVy0tn51gmvgU3uhZC6NYH3hgxWiHrRJEA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAGOxZ52h-PL7ii-qDVy0tn51gmvgU3uhZC6NYH3hgxWiHrRJEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2021 17:46, Alim Akhtar wrote:
> Hi Sam,
> 
> On Thu, Dec 16, 2021 at 1:36 AM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>>
>> Samsung Exynos850 is ARMv8-based mobile-oriented SoC. This patch adds
>> initial SoC support. It's not comprehensive yet, some more devices will
>> be added later. Right now only crucial system components and most needed
>> platform devices are defined.
>>
>> Crucial features (needed to boot Linux up to shell with serial console):
>>
>>   * Octa cores (Cortex-A55), supporting PSCI v1.0
>>   * ARM architected timer (armv8-timer)
>>   * Interrupt controller (GIC-400)
>>   * Pinctrl nodes for GPIO
>>   * Serial node
>>
>> Basic platform features:
>>
>>   * Clock controller CMUs
>>   * OSCCLK clock
>>   * RTC clock
>>   * MCT timer
>>   * ARM PMU (Performance Monitor Unit)
>>   * Chip-id
>>   * RTC
>>   * Reset
>>   * Watchdog timers
>>   * eMMC
>>   * I2C
>>   * HSI2C
>>   * USI
>>
>> All those features were already enabled and tested on E850-96 board with
>> minimal BusyBox rootfs.
>>
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
>>  .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 755 ++++++++++++++++++
>>  arch/arm64/boot/dts/exynos/exynos850.dtsi     | 755 ++++++++++++++++++
> Instead of such a large patch, it is good to logically divide the
> patches as per IP for easy of review
> e.g.
> Put everything in one patch which is good enough to get you a Linux
> prompt, followed
> by one or a couple of IPs dtsi, dts entries.

The patch is not that big and splitting it into several addons does not
bring benefits. You still add new DTSI - either in one or two patches,
there is going to be the same amount of code to review. One still has to
review everything.

It would be different if DTSI was already applied - then incremental
updates make sense. Another reason for splitting is for different
topics, when doing multiple separate actions, like fix + add, change + add.


Best regards,
Krzysztof
