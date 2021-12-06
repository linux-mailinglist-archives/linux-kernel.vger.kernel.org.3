Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCFB469139
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhLFINz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:13:55 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39636
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238917AbhLFINs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:13:48 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E45733F1B7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638778218;
        bh=TNvD0Sp5JjxJ2jPDnsvCbR9wfcFKlYmseYXSOvUItOc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=VY0VJ338x4wyRR3nR5xg2fPz+HG+B6Xk26nDPRx5NSk4IvSYNJiqXD3fncSRqIM1/
         Ggs98gg9GQtpAs8s5aDQOadlIvWvHDX3xNPuOODbKFdJmPx6gy2Z4YQLIVoHvJ2Pqy
         Or5pc9jM5/8z1wBEHl7+VKWTDSsh1Nk1HPJRcRKPkmgmAWKid6krQjqULL1v3ebrfz
         xOsL3EABq5y4HXSdfXsscbKIydNN3ih9Iv+/cUSQx7a2dyfAqzMivVkruEft39iEp4
         MDfFukUaAwbT+YIdnsFI/hBmd7rmEiK0IwTRIyp3a2rZmMGXFrtYggYWwew9L+AoJA
         XqPnDSKNXPFBA==
Received: by mail-lf1-f71.google.com with SMTP id i6-20020a0565123e0600b00417d29eede4so3537643lfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 00:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TNvD0Sp5JjxJ2jPDnsvCbR9wfcFKlYmseYXSOvUItOc=;
        b=zNFnZU4Msv99vSh8Pr10uCaGOzmgy0wQdYoprotQbb1LnVlkw7s8WDVXN+rWhclB1+
         eiU3z0RqjtciRKjgpt3z/Vp1PUowOt2upqD4686ELjF8Nd7DgOy6PSWd9Xkf/7OEHsfX
         AtLjY3BIv+1gUBNMquHq55PCRI8yTI8upcWEvm5G6B2TSMcJV4lts99LNJO49Yk28x1e
         SAtHLjLI2iCoDRdoJNwYAQ9SEw4XT58m+y58/9RXojnUzOl7ijKCn387OHIbqTvOrUtg
         5Gb4lw5mTyGDBhNZNjdDfihZyWrI92mmDd9LbbTpnX3Lbpn7xRXO9ndNLXrL86KJkFua
         TsVQ==
X-Gm-Message-State: AOAM531wNuzwhbz78ZgRk1FmO5wimaSqkHRLEvMoX9vi+5FwUMKPcva2
        4lp1cL1ihfSX3bZs61EYqJ3mhpo1ugvPVB8TXCOIhUqbS82ydIvbTTqqMFb5r+ywHUXioYuff5c
        1490v/kukXvbGoXOHjN8RyfS1pW9ywnrIIF9V5fER+w==
X-Received: by 2002:a2e:7c16:: with SMTP id x22mr34777594ljc.460.1638778217806;
        Mon, 06 Dec 2021 00:10:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOELswYaEcckDrfkpdzzhH6zAVoX8tSQw+t69lCRWWti3skzA0dAdyJuJJLo6WDbOsruROFg==
X-Received: by 2002:a2e:7c16:: with SMTP id x22mr34777539ljc.460.1638778216967;
        Mon, 06 Dec 2021 00:10:16 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u8sm1248659lje.91.2021.12.06.00.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 00:10:16 -0800 (PST)
Message-ID: <667d2f3a-4cc2-5aee-7b23-72279b70eee4@canonical.com>
Date:   Mon, 6 Dec 2021 09:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 5/7] clk: samsung: clk-pll: Add support for pll1417x
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
References: <20211205230804.202292-1-virag.david003@gmail.com>
 <20211205230804.202292-6-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211205230804.202292-6-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 00:07, David Virag wrote:
> pll1417x is used in Exynos7885 SoC for top-level integer PLLs.
> It is similar enough to pll0822x that practically the same code can
> handle both. The difference that's to be noted is that when defining a
> pl1417x PLL, the "con" parameter of the PLL macro should be set to the
> CON1 register instead of CON3, like this:
> 
>     PLL(pll_1417x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
>         PLL_LOCKTIME_PLL_SHARED0, PLL_CON0_PLL_SHARED0,
>         NULL),
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Nothing
> 
> Changes in v3:
>   - Nothing
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
