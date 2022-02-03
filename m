Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAF4A87C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351881AbiBCPiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:38:24 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36076
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236258AbiBCPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:38:22 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 19A2D40259
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643902701;
        bh=ceC2gcL0mrIihsL0BnsbH0nguKuEzDfg49WOJYvpHjs=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=sjETIXmh0cYWhxLlZuFPA/t3ugUzgSk6Njhov3QnHfO2+ayqab0/x/ZIIpdEF2dPt
         DKqy2Ta6XoAGLrj+XTelWl+JtqFTdTYiKgAcPUwpHrViV3XboigEVH4frC8rgaMQkv
         69a6Wke/OvyB8LYObc4BvndyPGCutlelHn6FkZUNkFjCiLN6Yog+ZXw1fU0Rpu2dlU
         /tKi7z9KbI3+kEJzbekZ0spgoNsQaqwIXK82WqJMoKyUCDe5UugB0d7wVlf1Bh0jQl
         fw54M4H7+4Q/jMlOFBx8pe9OBz4UCRbt06rO79dzR9e6xY1xju59aEkVTbZRinXSJ6
         JhoE7gAM4tSbA==
Received: by mail-ed1-f72.google.com with SMTP id k10-20020a50cb8a000000b00403c8326f2aso1657714edi.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ceC2gcL0mrIihsL0BnsbH0nguKuEzDfg49WOJYvpHjs=;
        b=QmCYKRy2EfrX1eoFPmUlWk4f5EEXiBbixllqSqusHkK2Wcy2Dyw36kkFLXmPwgoN7J
         TPjsG3oMm+pJSxOBLIYT/DnFGzHj350aQ6U+9wiABQoAWLFIF2A4kbK/jrhFwBN8xO9v
         zt+7Z2SniqcdBITSWxHFIIx6SVaIImUAJIhVlFkQDn59kQaogbP6Ck9Pv+oVY7brw367
         fqBVsMRXWFQmux7gyvPJlnRR/mm+S6nbGBIz4EYqHoUImxi1nhUsdHT3tsdqlirfxaGg
         AGgkKD+F/obQLc8pmc6VxMauTxVCPtBh3YVDTB3jVD3gN9hYLJFGwOlnMchNNWPphsHH
         FYFA==
X-Gm-Message-State: AOAM5337B8TF1PVZM3gMiUREy2SC3EbZqI8vGW7AnnoBazrsFcSitkQi
        0KheCqAm8XTePY1U9/gwOa3CYJQhul5KrNtn3pGWImuBofajidfdLpjj73Re+0TWa5PRKrLM4+S
        xUkmUuARq49kXW3dB1/btTypWXrjbrBOTbLfOr73JPQ==
X-Received: by 2002:a17:907:72c6:: with SMTP id du6mr30002401ejc.220.1643902700243;
        Thu, 03 Feb 2022 07:38:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAlF4VO+3+huXx+8cZu7b5cA+B5MxPjq2AnlQQoxec/Nz+wrYqg6yvzwA6CuuoFJ6CoCaqQg==
X-Received: by 2002:a17:907:72c6:: with SMTP id du6mr30002391ejc.220.1643902700086;
        Thu, 03 Feb 2022 07:38:20 -0800 (PST)
Received: from [192.168.0.81] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h7sm16852146ejk.69.2022.02.03.07.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 07:38:19 -0800 (PST)
Message-ID: <2f85f510-4ba4-f178-4c50-e4202a9a8f58@canonical.com>
Date:   Thu, 3 Feb 2022 16:38:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] ARM: defconfig: add smb347 charger driver for p4note
Content-Language: en-US
To:     =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5d15937b6a7c4ae82a8f0d164fa28a4d4ad46325.1643757744.git.martin.juecker@gmail.com>
 <aba0d1ffe6a34ed09022cb8ea6e780b01b7d70c0.1643757744.git.martin.juecker@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <aba0d1ffe6a34ed09022cb8ea6e780b01b7d70c0.1643757744.git.martin.juecker@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2022 17:34, Martin Jücker wrote:
> The Summit SMB347 charger has been added to the p4note device tree,
> enable the driver in exynos and multi_v7 defconfigs.

These commits go via different paths and are loosely related, so the
moment this is applied, the SMB347 charger is not yet in P4Note DTS.

Just write that SMB347 is being used by P4Note family of devices, e.g.
Samsung Galaxy Note 10.1 (GT-N8010/N8013).

> 
> Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
> ---
>  arch/arm/configs/exynos_defconfig   | 1 +
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index c58877cfdc9d..9d3191de96b6 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -159,6 +159,7 @@ CONFIG_CHARGER_MAX14577=y
>  CONFIG_CHARGER_MAX77693=y
>  CONFIG_CHARGER_MAX8997=y
>  CONFIG_CHARGER_MAX8998=y
> +CONFIG_CHARGER_SMB347=y
>  CONFIG_CHARGER_TPS65090=y
>  CONFIG_SENSORS_LM90=y
>  CONFIG_SENSORS_NTC_THERMISTOR=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 1c2c3e9f0e05..bfbcb57e2083 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -510,6 +510,7 @@ CONFIG_CHARGER_MAX14577=m
>  CONFIG_CHARGER_MAX77693=m
>  CONFIG_CHARGER_MAX8997=m
>  CONFIG_CHARGER_MAX8998=m
> +CONFIG_CHARGER_SMB347=m
>  CONFIG_CHARGER_TPS65090=y
>  CONFIG_SENSORS_ARM_SCMI=y
>  CONFIG_SENSORS_ASPEED=m


Best regards,
Krzysztof
