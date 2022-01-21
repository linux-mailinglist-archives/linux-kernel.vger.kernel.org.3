Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B099496517
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381964AbiAUSd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:33:27 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56380
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343584AbiAUSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:33:25 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE31A3F1C4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642789997;
        bh=mXZlfPhqAVSv8NPi2Pl5gmTb003b75PhYIJqXglSUqA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=QCd21mY0oU+lponYpnmTxcH55sXVs7FNdpXDlhBaA/oS80BOAarh0DnawVYvJ2THk
         LTYsTcvLNwtpuErOh2Fo+BpBCWTqlVxS/GHsVXS2TTx6B8Sec9NtDLNz0Etq286BIW
         5I1o5SIDq2w0UCADqCOTKso7bqy3s7t8oueSw+KblUZ2QGKFgTIP8AUviW7NlRsIuV
         l3eZtNUzSndGlZHMsALwdjDZLZ5ptkaCakMDJtHJJ/aHGQ0Cr6d8SPf0vmi9mj6O77
         VSgBatYXe5SDeFuXAhgIjCtX6YrxJSvTpEZNpwANqjgr8FyAVMTebYy0iPeac/fV8d
         D60rUFqrUTdlw==
Received: by mail-ej1-f72.google.com with SMTP id q19-20020a1709064c9300b006b39291ff3eso408179eju.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mXZlfPhqAVSv8NPi2Pl5gmTb003b75PhYIJqXglSUqA=;
        b=WFyEtqwsPA/CxnWopsbNNly9cZkStn/g2q8wleSUiOua2qjp+tu1WILc92WblPxC9M
         RxSDzxwjRcMzf6G9EnnNesGsZeU0F53DPClnrsjIpefF585dp8RtlsNyvUJ46LqQB7ow
         /ghxpJY+gecTJ0iEz/nl1AMH58o4oQyNhkEB9Lkdm17Yz+AvGh+BkcZwxWuDCCAnLEnw
         ELQePebWECeyAQ0GQ2exI7Q0w4J8XGUzubFtokeOqXOAF3aj/ppUTETRac0YWT2q/7OU
         4EJA3KTyX8EJKthuYCXOq8sLHa32AEs0E1HRQwy6LWahL1sSoPgOSv8veST1RlalD7rd
         IuOQ==
X-Gm-Message-State: AOAM533FNaEtaFFyLl6Q4fF8BiugJf3jf2+e96G+O/sHpq1MXbRlo1Mf
        gXX23I99XYEB/kmaHLJbq6OBFHVR5yZxfmOYakU45dNuU7NFFBvpWWAgv95tSepICCXZUxeNRAS
        csbjcm5z/y1/nP4DIUy6806tRhDTKVRWMdyR5pz9GJA==
X-Received: by 2002:a17:907:7858:: with SMTP id lb24mr4306535ejc.629.1642789997373;
        Fri, 21 Jan 2022 10:33:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOKjPuqYPtjHGgNKA+6097tyEbgBqQY22vvlACKfaO33upCODhf6sV7Otiz0IHhhh/a2hzSQ==
X-Received: by 2002:a17:907:7858:: with SMTP id lb24mr4306522ejc.629.1642789997159;
        Fri, 21 Jan 2022 10:33:17 -0800 (PST)
Received: from [192.168.0.51] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e11sm2268231ejd.188.2022.01.21.10.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 10:33:16 -0800 (PST)
Message-ID: <aa172f14-2328-fc7c-0063-5c0033970d1d@canonical.com>
Date:   Fri, 21 Jan 2022 19:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: samsung: Add fsd spi compatible
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, broonie@kernel.org, andi@etezian.org,
        linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        Adithya K V <adithya.kv@samsung.com>
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
 <CGME20220120193613epcas5p238851849d212e01d7d830d78ca7d6379@epcas5p2.samsung.com>
 <20220120192438.25555-2-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120192438.25555-2-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 20:24, Alim Akhtar wrote:
> Adds spi controller dt-binding compatible information for
> Tesla Full Self-Driving (FSD) SoC.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Adithya K V <adithya.kv@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)

I think you forgot to mention - in cover letter - that this depends on
my Samsung SPI bindings conversion to dtschema.

I'll be sending v6 of it after merge window, with minor changes.

> 
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> index 61c77088e8ee..bf9a76d931d2 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -21,6 +21,7 @@ properties:
>            - samsung,s3c6410-spi
>            - samsung,s5pv210-spi # for S5PV210 and S5PC110
>            - samsung,exynos5433-spi
> +          - tesla,fsd-spi
>        - const: samsung,exynos7-spi
>          deprecated: true
>  
> 


Best regards,
Krzysztof
