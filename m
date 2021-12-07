Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9D246B727
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhLGJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:36:36 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60124
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233765AbhLGJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:36:35 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 353423F1B7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638869585;
        bh=BEdVsoIuFxM799cTbQkXLyx5ca2h6q0N/IASsw9oLV4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=WJfpJf9yzKjRLd13tGz/qbf0vAw8krN5pm7AuyHUBNC7nuuPTL7E8n0YFnKi1OqA0
         zMaObJD4Ihm2VFCjhvux3wkCD0/qml6Amlc0+R2oWXowG4RxdW8FNKHKOr9YcmWf9u
         yCTnNPW0UOKhcC2v5GZUhHvghThQ1C5KteLw6EO2l9XbZrviGQGDzBQ6Iqm728QooT
         WjNViXFSbijmeeb8nv/uC7wVxhrvDjcWz8ugvaQM4zl0XdZ1ufuD3I4BeN5yZgmTMe
         zx4yKVeKdaIb8i7r8nRJOQfHfvaTfP6EdvSdKnDaS3BJFBr8XA2MHT7c85qUV3Gob3
         Adyb0+MgiHNJA==
Received: by mail-lf1-f72.google.com with SMTP id i6-20020a0565123e0600b00417d29eede4so5088428lfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 01:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BEdVsoIuFxM799cTbQkXLyx5ca2h6q0N/IASsw9oLV4=;
        b=A1vZoWxMWzXhP8Z/5qq7itwGdxInvpsG3o/7kFwZSMrL4ay+LKluc3msHrgaOiaGaS
         tHmdUlcCSEdOdh744fOr4aa8QZCcEoI/nQNEUKzl5oPFPAWMJKcsPPM1Q1jnCoeZrBeG
         sf2hlUB1yLMTO3Yb7tAOhF3qTYU+deLT1gpUUlmhPwf9GKlz8H4/72KPMKPp3qXhi8LN
         JFmgOMei8DN73pgCzVe1SGiYwlfF+TFfWX/NFmEGeVZbargFAneNU7ybkKpvFZo2mn+a
         3hyyVWiiyS34EE7nVvcAQVzaNfSns4T8WKT9/nmwWEbWInKuASwer9i7YUa1wYh065ad
         WPbQ==
X-Gm-Message-State: AOAM531EkfNWKykSVGpPgXzZqOJhYCTepkQOCJTdGOa/hf+Yqpwpo8ab
        j0+JojvimyJvegG0pRiXAJgqvWHpnRAOL1QtVLYrQzOnQ3s/eF9tX4f47aLUSt3sYudkqCq8H3z
        bH31wMikpURGDoFzDrsse1YoNA6v4WlP6Nnj5qw+XoQ==
X-Received: by 2002:ac2:4568:: with SMTP id k8mr39785442lfm.80.1638869584475;
        Tue, 07 Dec 2021 01:33:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJnVDk3iH40oUmSMxetPRxhkoJ0C7h06clV4jQucaTt6d1WFAgv+kKH51sPo13Jm0l9iRrdA==
X-Received: by 2002:ac2:4568:: with SMTP id k8mr39785427lfm.80.1638869584282;
        Tue, 07 Dec 2021 01:33:04 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id l5sm1553513ljh.66.2021.12.07.01.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:33:03 -0800 (PST)
Message-ID: <314c4616-7151-f854-2ee4-9ab8d25ef0fb@canonical.com>
Date:   Tue, 7 Dec 2021 10:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 6/7] clk: samsung: Add initial Exynos7885 clock driver
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
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
 <20211206153124.427102-7-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206153124.427102-7-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 16:31, David Virag wrote:
> This is an initial implementation adding basic clocks, such as UART,
> USI, I2C, WDT, ect. and their parent clocks. It is heavily based on the
> Exynos850 clock driver at 'drivers/clk/samsung/clk-exynos850.c' which
> was made by Sam Protsenko, thus the copyright and author lines were
> kept.
> 
> Bus clocks are enabled by default as well to avoid hangs while trying to
> access CMU registers.
> 
> Only the parts of CMU_TOP needed for CMU_CORE and CMU_PERI, a bit of
> CMU_CORE, and most of CMU_PERI is implemented as of now.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Use shared code between Exynos850 and 7885 clock drivers
>   - As the code that was from the Exynos850 clock driver was moved to
>     clk-exynos-arm64.c and what remains is mostly SoC specific data,
>     move the Linaro copyright and Sam Protsenko author lines there.
> 
> Changes in v3:
>   - Nothing
> 
> Changes in v4:
>   - Fixed missing headers
> 
>  drivers/clk/samsung/Makefile         |   1 +
>  drivers/clk/samsung/clk-exynos7885.c | 597 +++++++++++++++++++++++++++
>  2 files changed, 598 insertions(+)
>  create mode 100644 drivers/clk/samsung/clk-exynos7885.c
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
