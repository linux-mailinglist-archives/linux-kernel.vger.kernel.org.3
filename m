Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDA49DB65
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiA0HYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:24:46 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35232
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233739AbiA0HYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:24:43 -0500
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F4323F1CC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643268275;
        bh=2EcT5EJ8UI+o/Ys5+M67bQkoP+QAgsb522s0Pfb1Agk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qapwjp6SYRN8v0N4Gm1kOP42Pn/SNSySbP1WE1cweKt9UvEqRU2WfkIyUmB1DbE6t
         3NIV/DH1h26oZTayp4aZGwAYiQSQgYsB3qHx44byb3ubd0iaCHVc/MK+xfkq85d2mB
         Qwj+8jy5yNZ4aXtnYj1/0LIRQtjmnwqcX8oo6uUtH0yw8F9KiQwFl8E3FtGPxAXNPW
         5M5kdJthBCq0W7gUvghyZcU8/qVGfz1v7omynTjig5vWT6HLlAuuQZ997V/kxSeD8T
         RpRs/y50aJsg4AIlrS8j6vL+F8EGbrfVHgXfxsnmj8TguU/dgaN1eGfaSAfQqoxrRP
         x912a5IsYT83A==
Received: by mail-ej1-f71.google.com with SMTP id d18-20020a1709063ed200b006a5eeb2ee4dso916544ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2EcT5EJ8UI+o/Ys5+M67bQkoP+QAgsb522s0Pfb1Agk=;
        b=HenR7YeqWyawOZBcKHjyfbNnyYLQFRuHhQM5gZzNq6XCmkbSHoP2IV11tL6rXWR18c
         Iu834GUSYiFt2SMsUP3XxmdrYEBFwUL5Ux1OJjV2sC2h/1KrXck/O9EUCHGZrfnqM4PH
         op/XGPvrvyjlXJQVacFeSJHpS1hwQsGKtPyX0XFo/DvIAke41vvkR72di6t7HD0izXfs
         Q7/kzZT/f5RgcL4b0MP5/c4BhbxEcjrlwA9yL3kQp2um0Zu0J0qfipc+jF0Tes45rD4H
         CU3oz0vsllezCO9E2bXS12SNBmyDfFXjDgvZJUPaltqbQ9PGr39RhQNEKqwiJDuBvjEb
         mN1g==
X-Gm-Message-State: AOAM530ED5noUV7W3J3npwkvDOEBM5fe38jqyPHhm3UUUunQZnjo7OuI
        rriBKpA8Bxev2kCQ7FIxFvPJQMkLZOxz/NuapMC1Dprx1OjSCChIAyGky+O3rjFxowZiC0wzMgM
        nIB0I91S1pKWzFriyM1psvKbxRWCusuPOigESXkateg==
X-Received: by 2002:a17:906:1454:: with SMTP id q20mr1923077ejc.461.1643268275267;
        Wed, 26 Jan 2022 23:24:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtU2EdH4ioS0aMxUEH5h2Wibr/B48T4c2n82kNh44zPnwQD33NBPuvPT458iPvV0bmFRHbvA==
X-Received: by 2002:a17:906:1454:: with SMTP id q20mr1923070ejc.461.1643268275068;
        Wed, 26 Jan 2022 23:24:35 -0800 (PST)
Received: from [192.168.0.62] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id u9sm8310737ejo.119.2022.01.26.23.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 23:24:34 -0800 (PST)
Message-ID: <984330af-c2c0-18b1-6d72-f1b910fbfc3d@canonical.com>
Date:   Thu, 27 Jan 2022 08:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: regulator: maxim,max8973: Drop Tegra
 specifics from example
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220126231250.1635021-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220126231250.1635021-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 00:12, Rob Herring wrote:
> There's no need to complicate examples with a platform specific macro.
> It also complicates example parsing to figure out the number of interrupt
> cells in examples (based on the bracketing).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/regulator/maxim,max8973.yaml         | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
