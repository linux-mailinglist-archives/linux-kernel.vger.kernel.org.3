Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB646916A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbhLFIbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:31:06 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37830
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239064AbhLFIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:31:05 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E7A7C3F1F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638779255;
        bh=bKEJIZAQjQgq4md0kg/pxei579CQyZfJWJdDIldzueQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ahNfux5CFlXfrQpZB9nkUXPBTDqABr99/HT6BMzbjbi7jrfG+m1szPOwBX5pd8Pi3
         1+uARP05iop73KLGGZavLhj29mqRpbTBdCjxvl0sSkRhHHMdQtdbGE12okAPB0vklB
         6ux1BhZjhZNLsj5iAQiTsIOrn+7ckuiuMIO0EmhTGDiSTJ4E/57q7S6qQ23+KQlzB3
         Ab68PsOrbqSqbHHwIg+9EkOwD7gy59ftP9KFIDsEAV9OlXa2UNQCpfAzciuhlyRmQ/
         +UwfHdvVeXK10HUoUWE+yYw/id8WlEXns1pgdjM8y0noMTyPS3E+AEpJnArT1FatUf
         ztBXRuNLcrSwQ==
Received: by mail-lj1-f199.google.com with SMTP id y11-20020a2e978b000000b00218df7f76feso3167808lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 00:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bKEJIZAQjQgq4md0kg/pxei579CQyZfJWJdDIldzueQ=;
        b=CpJoEWCxBSLQDWtpNGlei2hfqFhmqb+jga9rkIxyqSFiJ82gIY8R7Cwmj2aAwgOFYs
         bqcZWU2RK/HJW4H3GGoX8dxSY3RhZa1pXT46dKo+mUutTKo8CDdSGP79jA32yHhr72gT
         WQEj6ZjRnEMXeoT7mZ/v8mr1HOyhK4Ar2YQZv4nmOBLMSAl22x4TyPCWXnX9ouIUh96N
         FofSYFuAllnBbFd1LZ1j5CAxFS1BQtAY/I+gPfZsqY2srga8qCpkrSnb8G1Cd8uMVRS6
         48eRR5o0iL6XRXKNA+1AVmRABzSP33dA/k+QOe0rUlJI/IKQwbSuGFiNBALxNhsWcsGF
         ot+Q==
X-Gm-Message-State: AOAM530oGbwSOuqFkam/wXcddy5i/ZBvzW0S5Gk6CTL/ctZFzGWAhFgo
        MyEnktQ0U9vKL9FBJQR7F9/mBShue9ebdc+ba60jLGgpp6b/s/tsHTGK5yc2x4yYU/MY4RLCrq3
        a0w16sa+gz7BFc68Wpe2VhlJ3raC5Dip03Uv4kDA4ew==
X-Received: by 2002:a19:4312:: with SMTP id q18mr34592508lfa.299.1638779255275;
        Mon, 06 Dec 2021 00:27:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzjKn8LjK/5lmCMNpVPgrp0RN3Vobgp5kXibfWPy43zCCeGy55FntekQYEglNs6rllZXWBUw==
X-Received: by 2002:a19:4312:: with SMTP id q18mr34592489lfa.299.1638779255102;
        Mon, 06 Dec 2021 00:27:35 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f22sm1287181lfa.171.2021.12.06.00.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 00:27:34 -0800 (PST)
Message-ID: <98414edc-18fa-c759-9c73-490078d8c93c@canonical.com>
Date:   Mon, 6 Dec 2021 09:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 RESEND 3/8] dt-bindings: i2c: exynos5: Add bus clock
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20211204215820.17378-1-semen.protsenko@linaro.org>
 <20211204215820.17378-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211204215820.17378-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2021 22:58, Sam Protsenko wrote:
> In new Exynos SoCs (like Exynos850) where HSI2C is implemented as a
> part of USIv2 block, there are two clocks provided to HSI2C controller:
>   - PCLK: bus clock (APB), provides access to register interface
>   - IPCLK: operating IP-core clock; SCL is derived from this one
> 
> Both clocks have to be asserted for HSI2C to be functional in that case.
> 
> Modify bindings doc to allow specifying bus clock in addition to
> already described operating clock.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Added 'clock-names' property to 'required:' in case of ExynosAutoV9
>   - Added example for two clocks case
> 
>  .../devicetree/bindings/i2c/i2c-exynos5.yaml  | 59 +++++++++++++++++--
>  1 file changed, 53 insertions(+), 6 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
