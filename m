Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98948D7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiAMM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:27:34 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50372
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbiAMM1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:27:31 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D69F3F1C8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642076850;
        bh=nWMCwBQ8qvto3g6GTsUmmbjQ5M6s0nUnB5kDMDyzI/g=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NY2XkyypJfAUe+CR4evsCF0239IV6QOdkIjIG6Z0SDuWUOEmuXSP4aKUHCiUQiTRv
         KOz42HUCybFssrJcYYyJGXQC2KeVjmt6MdLxsxgSaHZiv/oD6TN64k2kzCzN2kff3X
         1YPhUYKjauzNSREqMoY6fS2dEDAJ9r/8q/93wSuFxSJWO3xZkUUp1Xe4sq7dmXzp8b
         5J2SkFWMkKe+nqFlWGj9P3/Uihe1MpKe/9BdR18WpnmYCUlycDSD0AGq4DGFeEgdu2
         sxC/ZMvhYu9fYi8JnMWz63GLGO/GTaxNALPbezrAL7CxqH8ZgKEVkFtIz3mH0YRW68
         VDN54OKE1XHwA==
Received: by mail-wm1-f71.google.com with SMTP id d4-20020a05600c34c400b00345d5d47d54so3528706wmq.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWMCwBQ8qvto3g6GTsUmmbjQ5M6s0nUnB5kDMDyzI/g=;
        b=jefgm9Ey7YUVEltDUZL6CCDu9kh0qyIlFfMU//LH/v/zvwyQ4dELnDnRkf1hdsmefv
         2WGbMuSSZl1+PjyFDH6Y+4HV6lJAV0zyImiYad/ViaJMNZ3RZIVAe+0LqDwKyuAE0NNq
         02PxdEb9y+RHp0uXPfC7s70YbvVTHpfFVHo4HBubK0kQ1uPyY2ykJmztIyQhENJ1ghHu
         rTnKhVlLywY9UOaBNjQqW/9esS6jbg15Jd+dTOLBQL//L8QXAtIkzuVn94Qru71b0n9q
         6yBJSidMscfZmCmRPPgZz7jm905TrkyzHFriJLcYE1W8q5+5AKhdKK3BPpow81D13ISc
         8E5Q==
X-Gm-Message-State: AOAM530gKccIo2/hQy4kptqkHIKvAURHohQuSkClSNXu/RtC5RGU4p4R
        b3DwkO45CUWJrvoyAtvi9BErqzh8I1Lf7VNqkz2l90LCU2x5rw+3l6LESiJK7PcIbYja5fKngi3
        YX2YZGXwPg2hnDKStO3sSELFQQIbgSciNoL/x9ud3Gg==
X-Received: by 2002:a05:600c:602a:: with SMTP id az42mr3740579wmb.27.1642076849971;
        Thu, 13 Jan 2022 04:27:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzedcYD/WlL7vOvIVMshZ/IWP+2akJUFLDFNrlxlTqOjVhXt7ld4JHBwe6pD2xPZ5jcRCsI9A==
X-Received: by 2002:a05:600c:602a:: with SMTP id az42mr3740566wmb.27.1642076849775;
        Thu, 13 Jan 2022 04:27:29 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c7sm3267537wri.21.2022.01.13.04.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 04:27:29 -0800 (PST)
Message-ID: <849c7772-0f7e-32ff-6ea6-c46aa6837bb4@canonical.com>
Date:   Thu, 13 Jan 2022 13:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 10/23] dt-bindings: pinctrl: samsung: Add compatible for
 Tesla FSD SoC
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75@epcas5p1.samsung.com>
 <20220113121143.22280-11-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-11-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> Add compatible for Tesla Full Self-Driving SoC. The
> pinctrl hardware IP is similar to what found on most of the
> exynos series of SoC, so this new compatible is added in
> samsung pinctrl binding.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> index b8b475967ff9..ba972998a0e4 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> @@ -24,6 +24,7 @@ Required Properties:
>    - "samsung,exynos7-pinctrl": for Exynos7 compatible pin-controller.
>    - "samsung,exynos850-pinctrl": for Exynos850 compatible pin-controller.
>    - "samsung,exynosautov9-pinctrl": for ExynosAutov9 compatible pin-controller.
> +  - "tesla,fsd-pinctrl": for Tesla FSD SoC compatible pin-controller.
>  

Please rebase this on my latest Samsung pinctrl dtschema patches. You
also need a tesla vendor prefix patch (separate).


Best regards,
Krzysztof
