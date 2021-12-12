Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329E7471C43
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhLLSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:39:17 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48604
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231719AbhLLSjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:39:16 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 65EEA402FB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639334355;
        bh=QOLe+d7csrM+OPfnGCO79vniT112Eujdhj2JN4MALTY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EhYTMidWnkMC4/98ccp/2uKKFhs15LOCnpaLwlU69K9+DlBISSwTQooCrUvOmCTjf
         idvlJtTuqHSk0ey5dmfQREu8ERYguOcl5vPGg8XwlBYwPwJpgArLaT4CFWWa59s6al
         Ccyj0CT1uOntR4IZKjbUdH+3DLnOlnPUsoAH92zd4pqcPyLG1iYUNvQNF4P1JWZUpe
         hUCk8x9MSxLIncEVT/w3DVsVRE1Eg6dD/j/5JOw8fmpb1hobceGHfR3ufsxzIZjtsE
         EL3IibOzseEUg4xg9RECiJsw2CTTjbOdJ2mcCIJZRdjLOu9DPDh//jWb2vRLMJBVeR
         JgyL8x9XVPLeQ==
Received: by mail-lj1-f199.google.com with SMTP id 83-20020a2e0556000000b00218db3260bdso3994236ljf.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QOLe+d7csrM+OPfnGCO79vniT112Eujdhj2JN4MALTY=;
        b=1ICXl/IWK+UT4raFXd9CtPq0onuFbz5ETrAJWwjotPalz431bRzZSilGjvzZOsLid+
         It08/EBgo59LjK/EBlR/mChhSYhKqIyC0r3IkI5Ha+0ldWc7geffzb8BYWzizetp5QCe
         0rJIoylYUot0ESrUq8m/RykZNQHX5qrFuP1UW5M7oo5pKrEF2lLDCZPPQ9nlGpFEfWx2
         9+5WOPJERbQVE3MnmaBJ4tXYj/LastSeUN6sJR0ncsE64Y24oaJ69y7GbotRFJm6/iWJ
         fn/3mWTu72DRlnNjrIAGsngQNa35d+jJRVqz9aXE/hrsYqpP5w6tLDFXtCpIdcr2oISp
         XaRg==
X-Gm-Message-State: AOAM530S8tjSeFlHoh/1mHQwCNxtdvbRxak+iaZmPYL7ZtVl+L/IA5OJ
        ImCIqPLEU/DQBpTXGnbScdSrOzX5MY+nVofBaPLC0jF5ZcyZSlPshdnlyVwOR+f5Re11qmaVavk
        dhin1QWbgQuPIV+G/ikCNGl2UolxDhJcMDKFOnAMR1Q==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr24843147ljh.363.1639334354451;
        Sun, 12 Dec 2021 10:39:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx71+OYijueDFlqmStOqg4sDXiEX31XHw2Ry8T7iC/wKfGFnQGSIzUB9ek+aU57Ro0uZLRFZg==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr24843135ljh.363.1639334354271;
        Sun, 12 Dec 2021 10:39:14 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id 1sm1101519ljq.102.2021.12.12.10.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 10:39:13 -0800 (PST)
Message-ID: <aa76e303-95ac-20ff-c0a9-26f7f8c6b2cb@canonical.com>
Date:   Sun, 12 Dec 2021 19:39:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add bindings definitions for
 Exynos7885 CMU
Content-Language: en-US
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        David Virag <virag.david003@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-2-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206153124.427102-2-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 16:31, David Virag wrote:
> Just like on Exynos850, the clock controller driver is designed to have
> separate instances for each particular CMU, so clock IDs start from 1
> for each CMU in this bindings header too.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Added R-b tag by Krzysztof Kozlowski
> 
> Changes in v3:
>   - Nothing
> 
> Changes in v4:
>   - Nothing
> 
>  include/dt-bindings/clock/exynos7885.h | 115 +++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 include/dt-bindings/clock/exynos7885.h
> 

Hi Sylwester,

The DTS/DTSI patch (7/7) depends on this one, just like the clock driver.

Since some time Arnd and Olof prefer not to have external trees going
into the arm-soc, even if this is only the header change. They recommend
one of:
1. to hard-code the numbers in DTS and replace numbers->macros later,
2. merge headers to arm-soc tree with DTS and provide the header to an
external (e.g. clk) tree,
3. wait with merging DTSI till headers reach mainline.

I propose that I take the clock headers, put on separate branch and
provide them to you as stable tag. You can base clk driver changes on
top of it.

Are you okay with this?

Best regards,
Krzysztof
