Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104A64A4AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379673AbiAaPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:35:22 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51044
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349325AbiAaPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:35:20 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 333CA3F1F0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643643319;
        bh=Z5b/EBNw9uOt5Huvnc3qpF7pqyx4e7DzrtSCyAXGzd0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=b5bQdf95YzBLarC7FApKHouhzqdNZA0cBvLdwL+Ukig92iFlScZGVR6Ii81Ixdxxa
         uuTjO00tWSm3UEl36EpfV2h+vvEGPOK8Fhc14wmfymk1Or1WALW6PFHq8MLcikZz4h
         9gw+ILW84M18gehjhnwKxpNrjxZD1p/wGMhT4nyaDsH1EH+RHFIjjd06VaC2NPRUYF
         k5DdtjCvbh4+71/ymPwwoq/i1uhSG26VrpcZsAv8FMgSQ83Iemc2kEso0FyoWCkXNR
         QBx95te/p+qhQPMgnG2nDH6OtJXL6PFBh16Dgar4boAf65mKgxmxDn1IZV1msW0Tjv
         un5B89BXviXMA==
Received: by mail-ej1-f69.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso5143055ejc.21
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z5b/EBNw9uOt5Huvnc3qpF7pqyx4e7DzrtSCyAXGzd0=;
        b=nR3nHdZGAMkksRX4T7bUFmQHniQsJMa1V3IOtWOfLrZMLvCOp7eSCJjITN177LrW+w
         +0WmWCYR24rFtc4homTK9jn5rDsWo3R/lPD0FCI6rW076wPFRbOwxvE+HpBKEEVGkJ8i
         OU3VMWfrnoF8L6tX0QJym0wZcSg1FdRKX7nNMlkKi6CVlw9/gcsuuSmkLBdlgcVIWo+p
         515awS3tdj15azawHaJwtpnDimOMCD9USW73yTcmSL4sHN80evbhpVG5yG7oMxB95HzE
         TfF29m/Jyh6x1vZnRwWTK9s93Wexlu5EfOllTnZrhrJl/Ux2yiub+1sjpN1DuMZYhlJU
         9+6Q==
X-Gm-Message-State: AOAM531C0JnEwFSjqimnvqXx4UkLdXOCpgdMwsEFvt0NJFbMhNR8SCWd
        arLU2Ezsrc8ip1eTJubVDGkGjpx/qsrjfdnKL5XqHPS9Bfy7H6EOhTMacm5AFNzTmmzcaIrQCWW
        glGuQeWdq7hy7HDWHTUMUqAVtQAp0WtdBoMlNLQVvBw==
X-Received: by 2002:a50:ef16:: with SMTP id m22mr20906043eds.340.1643643318893;
        Mon, 31 Jan 2022 07:35:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvhi9AwQxRpZJOEpikHkJ1BPhM8MD3Qh6i+q7FjAIG86ry6+d6e16F+8z0bK3phu/eNvlQlQ==
X-Received: by 2002:a50:ef16:: with SMTP id m22mr20906022eds.340.1643643318699;
        Mon, 31 Jan 2022 07:35:18 -0800 (PST)
Received: from [192.168.0.74] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id qa30sm6667123ejc.158.2022.01.31.07.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 07:35:17 -0800 (PST)
Message-ID: <7941a6b8-4bca-797e-2fa9-ebd82bed70fa@canonical.com>
Date:   Mon, 31 Jan 2022 16:35:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-8-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206153124.427102-8-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 16:31, David Virag wrote:
> Add initial Exynos7885 device tree nodes with dts for the Samsung Galaxy
> A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> Currently this includes some clock support, UART support, and I2C nodes.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Remove address-cells, and size-cells from dts, since they are
>     already in the dtsi.
>   - Lower case hex in memory node
>   - Fix node names with underscore instead of hyphen
>   - Fix line breaks
>   - Fix "-key" missing from gpio keys node names
>   - Use the form without "key" in gpio key labels on all keys
>   - Suffix pin configuration node names with "-pins"
>   - Remove "fimc_is_mclk" nodes from pinctrl dtsi for now
>   - Use macros for "samsung,pin-con-pdn", and "samsung,pin-con-pdn"
>   - Add comment about Arm PMU
>   - Rename "clock-oscclk" to "osc-clock"
>   - Include exynos-syscon-restart.dtsi instead of rewriting its contents
> 
> Changes in v3:
>   - Fix typo (seperate -> separate)
> 
> Changes in v4:
>   - Fixed leading 0x in clock-controller nodes
>   - Actually suffixed pin configuration node names with "-pins"
>   - Seperated Cortex-A53 and Cortex-A73 PMU
> 


Hi David,

I hope you are well and did not get discouraged with this patchset. The
clock changes got merged, so if you fix the comments pointed here, I
could merge it.

One more change will be needed - use "-gpio-bank" suffix, like here:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=for-v5.18/dt-pinctrl&id=71b8d1253b7fe0be0ecf79a7249389c8711f0f94


Best regards,
Krzysztof
