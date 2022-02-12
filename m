Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA84B362D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiBLQCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:02:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbiBLQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:02:35 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE99197
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:02:31 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B35733F1C1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644681748;
        bh=l/sqa866xdKsWTgSNCB9rWLOZm4vGLLE7QTLVaTsoZU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MmzNqnxdVutX6P/RxFdKqJ58ChjAJ6+R53XtlqgVQT4xDp5tb2KF7BtYwAWsBthrH
         JbU/5IcYHexLSqqC9V3aGWRbDhK02RUxB6XA5ay09uXV4cDuj+orVtnXv661oTg49L
         kzmFY1qpjUV8TGqiIEX/fAfnpFRY+calvC9v0wBBcmvrhFvi4q/MOmLrb0EVIPBdOK
         vQ5MJZ7iRyX7Uwxpy9Z9skJtCDKCBODg026tPrvZK8YTP0G/M7GgwFKOBP/zhTylgv
         OyxMPzkGcEI7rXfeZWIq5e+6kbwzxMw3qOpT6gWg/VjLd9XASD/Gcd/VXYUNFFg+iN
         FoPovc0JBKhQg==
Received: by mail-ej1-f71.google.com with SMTP id nc21-20020a1709071c1500b006ce37423a02so197702ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l/sqa866xdKsWTgSNCB9rWLOZm4vGLLE7QTLVaTsoZU=;
        b=N+VxNo1XL1x8xkuEQtRGWzXnIBJ7Zj2arGWEZv17xnolOll5I2UhtZERGPES1SmesQ
         CdtIEJ84IJkMjlA18qksaTTDVkoJUgJ8wmxK8YlsCefX/CLb5V3pGQi/PP4Xzg7B1n8G
         mDF076Q2DtPgQh/BzhezdAEjWbL5NEQNCn6n6YcIWAay/otpE6qt96u5BMjh9L36iwnR
         8TOijHWzaRtqq1JPeB2gRNQhOfx5xJ5mhNpHkqmMEk8l4FidYw2k6E3PpXO4wRAZ/6WI
         lwuataiPAGUiQmS1PqEa/9IcWO2tyOmMxlOvr1I4NnXsWrp/tED15ASNhHHUnfVlrqMs
         ZXnA==
X-Gm-Message-State: AOAM531IhQHr1UmAshtXKG3/m+D8mshYkKfCEd3VWpUTxjCol/Aqp/Bv
        0iWZw9mfQ7nxDjWadkHVKizMFwUEocPvNgln7RXu9O5dSH+o4UhY08JVg5uNWLfpVoPUTTc8n0M
        QCbsw7swCeEB6UtDD8/uMWwUzXLE2aHuvBNG8PrkFRw==
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr7182465edb.102.1644681748426;
        Sat, 12 Feb 2022 08:02:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCqbWilwt1HbUpSsc2cvzvmt39AYbiXm7khxjJiFy20aciawo2HRz4CMjXWjBdjSCj4Q/WLQ==
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr7182452edb.102.1644681748216;
        Sat, 12 Feb 2022 08:02:28 -0800 (PST)
Received: from [192.168.0.101] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b14sm5098399ejb.160.2022.02.12.08.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 08:02:27 -0800 (PST)
Message-ID: <78327112-a979-fdc8-50a6-35738c9017a7@canonical.com>
Date:   Sat, 12 Feb 2022 17:02:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: crypto: convert rockchip-crypto to yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220211115925.3382735-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220211115925.3382735-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2022 12:59, Corentin Labbe wrote:
> Convert rockchip-crypto to yaml
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - fixed example
> - renamed to a new name
> - fixed some maxItems
> 
> Change since v2:
> - Fixed maintainers section
> 
>  .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  2 files changed, 66 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
