Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29D465F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356129AbhLBIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:32:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47486
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356117AbhLBIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:32:40 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 844FE3F1F3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 08:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638433757;
        bh=dJM/2QbmGXuaChfbXZwdYJJ33P8XYZV5+jNXNkybi/c=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bo6OIDPwsL/8pXziRcycrJmp63ULPN6UvoUJP3HjhqizVLI5NKwLqMglmbtacJhny
         7gAC3KBd0X01effV4ayQSdgtfFpIz9DBk3yo5n22x8hjwAkq/KV6mNROa1+SG2bu/1
         mjhc3fLY+ZukojpefZFw/SOhCnzJwfZrfeGvVi6pGIiPzUPai5r4ieNx5UWrG66A4U
         Xor1ZW6IcFD36Pdqs4eIWZnAsxxQZuZQdz0tuODmZrWP18duRTBrpuA83pF3i5Mq0R
         bd6kIUFO85cR6Hf1wp41yt7bg0nE9aZvbQB5PlcXHkJ9QM262KvAbVhl2Re6jxwnsH
         DisX7sQa5oM5Q==
Received: by mail-lj1-f198.google.com with SMTP id p18-20020a2eb7d2000000b0021ba3ea3c42so7312238ljo.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 00:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dJM/2QbmGXuaChfbXZwdYJJ33P8XYZV5+jNXNkybi/c=;
        b=0ExhV9el5ivWoUsQ+3ElzOLVHLFcUcR6I8mKMPYrRyQCIxAz0HNT9ZgTcq9AgVDuEx
         8pgjpQJVDpwBeFzMLutIS1PamBaQyv316M4JltbrtfzryL9jHEgEBpY5J7yhIFDJWsA9
         OTSpSFxLUS/AeCAOHmLzPBFXx0LAXqkFcQVmDs5GsOtf2kR9/W59A2CfONxxzPucs+6B
         WTgiVVsXN0DyQmdKm9FCiC+7Bsoy8V0A0nx9tTIqAfwQ1FSoWHOC4ScMdF0+uwn5YnhK
         oCcGEofkaS2XHgRwKyOQGOXW9URlvprUV/h4wkWUBc8henBSNl/bRRmAwhgWLi/3o+WM
         1aEg==
X-Gm-Message-State: AOAM531FSrhFTMMbplYg2UDGYia8I6sEE73MkugdzWi5HG7+d7PkyCdh
        +kohVtj6zrCxM5InhrBp+Y+msmr+ExXEEfkrahI94aGB/2nJVf4Bfh4J8MBg5uBrQ7abre+kmsh
        04NPObw0wbVG5NpCbLnMPp37+H490peuAp9nB7ELalA==
X-Received: by 2002:a05:651c:1305:: with SMTP id u5mr10488326lja.15.1638433756941;
        Thu, 02 Dec 2021 00:29:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDqygt/OD7JoDogwHXWV4GwugKqBaDU+m1BJknpEkxNZdFOJ9cYfgh+BKh2OY8TTWvsT6BTg==
X-Received: by 2002:a05:651c:1305:: with SMTP id u5mr10488302lja.15.1638433756784;
        Thu, 02 Dec 2021 00:29:16 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b27sm238199ljf.52.2021.12.02.00.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 00:29:16 -0800 (PST)
Message-ID: <3b625a3a-cbfe-9de3-7b8f-9368843f7708@canonical.com>
Date:   Thu, 2 Dec 2021 09:29:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 4/6] i2c: exynos5: Add support for ExynosAutoV9 SoC
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
 <20211201190455.31646-5-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211201190455.31646-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2021 20:04, Sam Protsenko wrote:
> From: Jaewon Kim <jaewon02.kim@samsung.com>
> 
> ExynosAutoV9 functioning logic mostly follows I2C_TYPE_EXYNOS7, but
> timing calculation and configuration procedure is changed: e.g. only
> timing_s3 has to be set now.
> 
> Another change of HSI2C controller in ExynosAutoV9 SoC is that it's now
> a part of USIv2 IP-core. No changes is needed for I2C driver though, as
> all USI related configuration is done in USI driver.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/i2c/busses/i2c-exynos5.c | 62 +++++++++++++++++++++++++++-----
>  1 file changed, 53 insertions(+), 9 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
