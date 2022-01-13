Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B691D48D912
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiAMNgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:36:35 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53096
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233675AbiAMNgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:36:33 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC6533F1E4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642080992;
        bh=LK8TIW5kBMgN60TTr9MsN0Nx6njpiR3Rbad9G3zx4zY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Nl/fJpmdl1iwO8i2Nk4M4UUAN5A8HFJvKfhMYIvgUEfiGebw3BzTvzr3rgAwnIMDF
         RJtxMh6CHHG+OJN5d5CTb/+/CRD/vXIGojquDg816x8kZHGIyc2012i6jMyiZ4ZHpB
         bk9mOFxlo8scwZVgyvDh3z6BeRXj79uPcFC7BApn3yKyf30lUlptfMWsFfv6D66Der
         xoYsgQYr2G8Ug4X2rEydT9zh1+47jJVg8CXm9ol45dQyKo6OwNvAZwoMZCZCXjU+K1
         +w0Q5lV3nj+4zemH2RMqHRN9KC3BIfp1kntn8alyoSlp5ONUowXJxZdQDgDvoKdJfr
         G1ZcYUiwxWYEQ==
Received: by mail-ed1-f72.google.com with SMTP id m16-20020a056402431000b003fb60bbe0e2so5347961edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 05:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LK8TIW5kBMgN60TTr9MsN0Nx6njpiR3Rbad9G3zx4zY=;
        b=8QE5kIjF4wYttBoxuysNZbSHMWkm5qRlYrEOglR19HEtVohPbOW7m7EFqWd/zQ4TZF
         stIjh75q2MAqaBZCq6eriG44Yn/5TCHAC6Ablbmfo5ZyDm24zJOyOxgdrHyg5oeSxfuB
         qf9UH0Y6IA8xsBh2h7BgD4jq/JmAkyApfDj7bNiK9hF26YncfubjGNlh/ldHW277gStA
         v7MkwsfTekCk1XF8QE7uKGfYjXMdsd6iy1+rUgOwVKyzs7tdMhmjZNsioS0FLY3t2JNt
         sBQQK1C5dUaOjbLS8aoPs1o4XhZZiD++roir5lGDhi9fDYhe8+o3JdtPK4ChU+xXmRwi
         a9TA==
X-Gm-Message-State: AOAM5338myD9PsNuhtQDydlzW0MEE5+sebdz4Ct/yTYrybSbPqM3iAbI
        HWQXzDh9Pjo52ClQ5wLWV5cdCUJp6mmYy3nzUxyWnjX0FvMsrk7iX9L3QWdL1lw63/+/uV8JIOl
        RGvvY7FDf4L4bF5nnOX6//7wocVq3nGfV/ha9HrtDDQ==
X-Received: by 2002:a05:6402:26c2:: with SMTP id x2mr4125829edd.6.1642080992284;
        Thu, 13 Jan 2022 05:36:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyz+FRblvd+YpkczXpBN7hT+oLurYDM4lo3dJdgM0Xz6YialsePTUBoBhaDXrvPv1Q1WUuYrw==
X-Received: by 2002:a05:6402:26c2:: with SMTP id x2mr4125807edd.6.1642080992132;
        Thu, 13 Jan 2022 05:36:32 -0800 (PST)
Received: from [192.168.0.30] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id k22sm1182368edv.22.2022.01.13.05.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 05:36:31 -0800 (PST)
Message-ID: <6719ffa5-f765-6ed1-6347-6558471e6bbb@canonical.com>
Date:   Thu, 13 Jan 2022 14:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 23/23] clocksource: exynos_mct: Add support for handling
 three clusters
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        Aswani Reddy <aswani.reddy@samsung.com>, linux-fsd@tesla.com
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122502epcas5p37747b0c5c242c0571d294b9245963a1c@epcas5p3.samsung.com>
 <20220113121143.22280-24-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-24-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> From: Aswani Reddy <aswani.reddy@samsung.com>
> 
> This patch adds support for handling thress clusters
> (upto 12 CPUs)
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 5e3e96d3d1b9..ba3af940a687 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -78,6 +78,10 @@ enum {
>  	MCT_L5_IRQ,
>  	MCT_L6_IRQ,
>  	MCT_L7_IRQ,
> +	MCT_L8_IRQ,
> +	MCT_L9_IRQ,
> +	MCT_L10_IRQ,
> +	MCT_L11_IRQ,

I think this should be variable, based on SoC compatible. The mistake
was done already when adding Exynos5420 support by Linaro/Samsung, but
at least let's correct it now.

Older MCTs/SoCs do not support 12 local interrupts, so they do not need
and should not register so many interrupts.


Best regards,
Krzysztof
