Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A254A3146
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352903AbiA2SAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 13:00:52 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36408
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346282AbiA2SAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 13:00:50 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 85E3A3F1CA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643479249;
        bh=wj26dowE18UBChU4iJsZoK9hW1bTUvEBWMZ3lDSEVB4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EBzzHRFTnVrkMZu5tdokGIpM1OLGDE53QzTBM4lTF5Z0vcAtJq32DA2hd4Vsmhb98
         5vacAbJ/YBVLW7fGcZk8z0FZHdtgV8e7eOo/eTW7usQgyLj6GRqBBiTSZ5fI6xpf+R
         6vGs9oY8isv20zXQBKP2F3G3wGHAXcB6YPrDeI3oLmPCRg1wjcwKcu7Tvux1kpT2dH
         +kej8l1icvKffitQsZ5m/M6S/061qDtsodIVrFTmWxQP/1nL7EwIdd5YXSdEPD9t9G
         6HeqwC0quhIkpLVv8EazZd6WLnT3M8BOHKYEL9ymxZ95XhM9wTHxK6hHqDK+LCnj8c
         YstVFcFV+eP9w==
Received: by mail-ed1-f69.google.com with SMTP id a18-20020aa7d752000000b00403d18712beso4682123eds.17
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 10:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wj26dowE18UBChU4iJsZoK9hW1bTUvEBWMZ3lDSEVB4=;
        b=O3jgjF1Z0IyqQUVUkAlBpAkrmwAE+r1YFGzE1phSQ91zZ6IYwXaTCkw32nalOrfd+D
         UHJDC5e81xrPZ7yTfrITF0ZvEV4UGGSgesWlIMTUqavbK1uO6qCfKtY9jukOWQG9fElW
         eQjCXonstLmUG42DuN9wK5mBqgSMAwIGranMUQAPivcTkQSGilf3eXsSG807sZB4kkVh
         n/jdpLYEQu253q582Vi++/LnQsjCDPNO1M1MsZpe0YgQogTSiYSdgauz52pe7O032eAo
         D75N8QKAaCd+8xYRtvDNAOvUBFW6urzOsPFFZecHkq1RwQfX7zNvpuUWhPZuWPiJnFfY
         ZpfA==
X-Gm-Message-State: AOAM5312wjPFCZiRzOMNMBOsUBxvmxdQMUyL6HXsm95rpgJkiDZqQ1AM
        b3On9TmgC30vmQCkQu6hnWK+KwyNO3hf/GoGphzMCaL6w/3IcadDafA3b3lxfwwFxJvyVrZQYx9
        hddzpqE5YEBnQXkgTIl+rn/JhL7gKLLTpJNfePD9p8w==
X-Received: by 2002:a05:6402:184d:: with SMTP id v13mr13614168edy.109.1643479249166;
        Sat, 29 Jan 2022 10:00:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6bjwiCDZCxOplOaDglUSHk7pmnpQn3kHhZBBmcKVaRe2EwfObgQ4fcdEMeY8GoW/rPHhUnA==
X-Received: by 2002:a05:6402:184d:: with SMTP id v13mr13614158edy.109.1643479249044;
        Sat, 29 Jan 2022 10:00:49 -0800 (PST)
Received: from [192.168.0.71] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c2sm14849032edj.24.2022.01.29.10.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 10:00:48 -0800 (PST)
Message-ID: <47ff2b5a-745e-a32c-6c24-80f8e72ea8a3@canonical.com>
Date:   Sat, 29 Jan 2022 19:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk: samsung: fix missing Tesla FSD dependency on Exynos
Content-Language: en-US
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20220129173407.278591-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220129173407.278591-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2022 18:34, Krzysztof Kozlowski wrote:
> The Tesla FSD clock controller driver uses shared parts from Exynos
> ARM64 clock drivers, so add proper dependency to fix COMPILE_TEST build
> errors like:
> 
>   /usr/bin/aarch64-linux-gnu-ld: drivers/clk/samsung/clk-fsd.o: in function `fsd_cmu_probe':
>   clk-fsd.c:(.init.text+0x9c): undefined reference to `exynos_arm64_register_cmu'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e3f3dc3810d3 ("clk: samsung: fsd: Add cmu_peric block clock information")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/clk/samsung/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

What I forgot to mention - the commit being fixes is in my tree, so this
should go as well via Samsung SoC.


Best regards,
Krzysztof
