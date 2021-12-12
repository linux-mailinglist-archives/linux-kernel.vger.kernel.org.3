Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D965471C37
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhLLSXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:23:44 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41266
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231307AbhLLSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:23:43 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1EA8E3F1D7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639333422;
        bh=zsFvDymLAE62cochR5JV+hqkToOtqvgjd65ScGiDZ8Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kNdwRhJvPvuvp1HhVDaWOwUv5W+UeCecVmW4E/A96J7PxyfdA2ktS6pOKp5YqicpB
         kvLfp7KvegmUNXjZrST0ml05JTIQ7zLzbgxEnlrACb0TFKZTcQPvonYgRisUxmK54V
         TbVmOXKgLEStLf+2Qmvync6mrDRbWdbbvbhBrT/W/u2QCm/HMElrSMCE98zBpXbmIm
         sK6gpUjHMsPPVmF2h1Jmex5Kqwr5lXkcETvXXlbCRZ8qEc9dlcUdfPhcAePkyBXbXq
         5GhDhDfk9S0/qPKf4pT8eJuhFswBfdeH2VI3e+RH7eykWW70VgFrVRbbEv2HBn0ggF
         ZcI0JEdd25Frg==
Received: by mail-lf1-f72.google.com with SMTP id d2-20020a0565123d0200b0040370d0d2fbso6465396lfv.23
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zsFvDymLAE62cochR5JV+hqkToOtqvgjd65ScGiDZ8Q=;
        b=Sq4kmlv0HSIy0GUCjPFYxrxJ0cCG15mhEKtGPo6yYCxnyh5brpaIxjt63t40m7yaEx
         5uYx/ULynMSbF8HdXA2B+5XJ5Koe2+2L6pP8RYsOti4a2pKDkut59RKjIfOuHTLBhkw3
         nTWVqrOtOy4D4MQ1/7t9FbHGVS4Ped/Z4uZejuBl77yfjPkWZKIZeCjTYTqj+lfhREB2
         iU2QLHIjUTnwALhbzjhn0v1nL2USc/+JvQapuc6ijsq1TTG+ctQ0fTqeYJOdGPkOh9Qh
         6nqBpazwJVePfiaedpqlGHDiRID+T0SKNRoOOluHZLA4xy9TP4NJhj0jEYX+XSSfdVuR
         B0vQ==
X-Gm-Message-State: AOAM530XrpGeEhX0ndv2853Zo8c+dqlxEZLoPZQlx/qh4M2Yii74sMqF
        VTE2cZ5cvTNfVc/b5ztQ4HkdT0Xxd9putivLqGfS0oqjEpLVDYdwkQAKJnhk2Wg1MfSZMpaFKvS
        pUPiewBKOHrTdLAxEe8xENenVXH7FAl1+W5ehp+FNiQ==
X-Received: by 2002:a19:f241:: with SMTP id d1mr24604059lfk.131.1639333421356;
        Sun, 12 Dec 2021 10:23:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdFZTcAiz+yLH3ynk5vBF+dbiNtcpA+ioYNpceWPBWGhHfcQ30v344oKq6PRrfsrAO9LYLCw==
X-Received: by 2002:a19:f241:: with SMTP id d1mr24604048lfk.131.1639333421187;
        Sun, 12 Dec 2021 10:23:41 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k6sm1111431lfu.218.2021.12.12.10.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 10:23:40 -0800 (PST)
Message-ID: <ad05297f-9252-15b3-fc9d-e358052bd983@canonical.com>
Date:   Sun, 12 Dec 2021 19:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] i2c: exynos5: Fix getting the optional clock
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211212181057.20210-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211212181057.20210-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2021 19:10, Sam Protsenko wrote:
> "hsi2c_pclk" clock is optional and may not be present for some SoCs
> supported by this driver. Nevertheless, in case the clock is provided
> but some error happens during its getting, that error should be handled
> properly. Use devm_clk_get_optional() API for that. Also report possible
> errors using dev_err_probe() to handle properly -EPROBE_DEFER error (if
> clock provider is not ready by the time I2C probe function is executed).
> 
> Fixes: c93ac09df2a8 ("i2c: exynos5: Add bus clock support")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/i2c/busses/i2c-exynos5.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
