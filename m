Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1D465F56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356103AbhLBIbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:31:45 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47444
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356096AbhLBIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:31:43 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6ABB04003A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 08:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638433700;
        bh=1eBIeWyYOLfAkd1ORESuyZ3/vrhRYjsquv2xZv/KG6g=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TKhYJHSJREzSAqp5lzqMarIR48iFr+DQamRzcmhqd82kBIXnPGOPkpeoHvZLstfmp
         GMoRo+7+bRuO8/0FXnLJadFBODRj/A80Me/sZEO0wsBd/mRHflD6zYoBeJH1Jc2m5/
         OmCE94YCNv6ydu9/HHVhum3kOPDq/EAaVhXiFW6tha5QYoEyDFkH8TxFew/+j5drRn
         xLMUsXRwwB78aW5jzWBgDPE/Vv0TS81Sf5MXW9qDGymXcfTYhUNeJZYbla++OFfqfb
         bvQ2PUs7BR65Fh/GYSxA5XHYQuEaB2iQ2dSwAP8k4o6yxmpchVEjYfj2RqikSOQ1PV
         UfjNNIpjrQNgA==
Received: by mail-lf1-f71.google.com with SMTP id c14-20020a056512104e00b004036d17f91bso10944712lfb.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 00:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1eBIeWyYOLfAkd1ORESuyZ3/vrhRYjsquv2xZv/KG6g=;
        b=rbP2638BDgcJHJ0rZSUQSzOBttqhW1nzDh+WmnCkHoCabFb02cnhvZDmeyKQ69YLa5
         cDo8iu3xhQp1zUrlIeB6g3jufDm+Z3NqCUKuT7zQH56KyqgWAJzol4ilo+b1HAan8Jrz
         nUpoKTdkeby+nhgUl3ufYf6UsEBLK4R4baETo6DHG27wGrbP4NKtHCfsQc+bDVv9EVkm
         Oy7frVO304vgHiSuUKUwUBNaT7g9ej0XFXOd4RHaf5rR0XOJCKgDYspAHZasKIIN//7f
         kSqwNsVW/QcfULn445N47gd4AdPsgJgOJM4K9bkiV9OJWGpGdFtF7xhGHjj8bIQrFqOS
         89jw==
X-Gm-Message-State: AOAM533+9NvLb68tfuIw2t/BzivK+zh56xe9hoanM66OFM29VTeAd/Bx
        DQ4ZR+zin+jL/BW55BhV8k7y++GSrpkci8P/ZgyCx0f4p+BCj5UdcYJsP/QcM+Wz9GLMX84/n1j
        mQzeY9cz+1bTKZq7LR0aDL8mh7GZRbusTkrYO2pGChg==
X-Received: by 2002:a2e:8090:: with SMTP id i16mr10469533ljg.125.1638433699893;
        Thu, 02 Dec 2021 00:28:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeJ/jbkXZLjr07M46afb4m/Ji/F2WVbQsP2Rfg1PNpFWz/eDCLOEHIBPBg9cOh30Cj6//snw==
X-Received: by 2002:a2e:8090:: with SMTP id i16mr10469505ljg.125.1638433699723;
        Thu, 02 Dec 2021 00:28:19 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c1sm234837ljr.111.2021.12.02.00.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 00:28:19 -0800 (PST)
Message-ID: <38601fab-816c-37aa-1839-96fa7c6a3959@canonical.com>
Date:   Thu, 2 Dec 2021 09:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 5/6] i2c: exynos5: Add bus clock support
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
References: <20211201190455.31646-1-semen.protsenko@linaro.org>
 <20211201190455.31646-6-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211201190455.31646-6-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 20:04, Sam Protsenko wrote:
> In new Exynos SoCs (like Exynos850) where HSI2C is implemented as a
> part of USIv2 block, there are two clocks provided to HSI2C controller:
>   - PCLK: bus clock (APB), provides access to register interface
>   - IPCLK: operating IP-core clock; SCL is derived from this one
> 
> Both clocks have to be asserted for HSI2C to be functional in that case.
> 
> Add code to obtain and enable/disable PCLK in addition to already
> handled operating clock. Make it optional though, as older Exynos SoC
> variants only have one HSI2C clock.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/i2c/busses/i2c-exynos5.c | 46 ++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 

You could use clk_bulk API, but for two clocks, where one is optional,
it won't reduce much of code, so I am fine here:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
