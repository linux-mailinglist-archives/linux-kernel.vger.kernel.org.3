Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037C048D850
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiAMM5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:57:46 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54788
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234787AbiAMM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:57:45 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 82017402A8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642078664;
        bh=XykCHjye4PKyxXgJO3MC0n+RYOsNv5yCNxf0ZTkuzFM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LvqVQ/w5vvFKEAH3kNMaammVz48o7TwG9KYbIyWAuhIDO2uR/qnWECvbj05nnfidu
         AmfGl7RItrg7KCLAmJRdCSyfogQmQphV7tGbE0NbRJShOd4ijEmSdhDqLZw9mZGs+1
         b2wh52aWfprO/1OE7l+naor/3lffx8cBrWcyGRJFpTIK9BV9R2cyoqZzDT0YJFlybx
         WR+FjI701gs7OKvRfLxMk+y+y+TNUgwP3bbB3Rno0+eetDkImJQ9PmzxZXBbmnVMHg
         AaYhtuM7HLhBcAY2bLbQ9YrHN5UkQts0gw1BJkdMnMWUufTkwx018b69RMUGt9dCxk
         nAZGK2ZLSGmXw==
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a056402271200b003fa16a5debcso5251947edd.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XykCHjye4PKyxXgJO3MC0n+RYOsNv5yCNxf0ZTkuzFM=;
        b=FQMjBeo2sDi3+cDEe6VYvwul6TCN5R8IEBPck8MVde18WfpaTVVrLzcBVz/qe8jKtX
         f6mURI+Gzl2RE+zmoNWHmDRm+2/ECnKc5No2bXrZm19Ly8qpJwDK9lbw+XKuWilWFaCc
         GnHtgH5ofRB+mVE6Six2HNG7P4rlDZQj7uhegllfsKhDd4SQat4ZoWFg2wlte5M3fXa9
         w81ScMnYIDkwKgt+8jVDtWeGC05A5m61ONqgdWCkeFq0VnLx65ypXTf34V683z3DyWp0
         6ePRo90D1QPFuWho3V/DtXg24erbe/oqLD0Q2OtodlWnM3kFKn5MgVPeO2twOcbTyL5c
         39Mg==
X-Gm-Message-State: AOAM532znQtziLo1eX6zG9BRV68CgpgMCznkQP5bldF1/FaS7I7mLf4m
        fOrdgEvPVkm4uy7ofmqmq76VcfZK3HiedSKix8VJKx88AZYBIVqwqIv3J5LUiOaJayjyqmb/7zD
        FgeJlOTSNZ2LDyEwp4jvFGzqy4XUosmKWbeGerEaxiw==
X-Received: by 2002:a17:907:16a8:: with SMTP id hc40mr3325139ejc.210.1642078664150;
        Thu, 13 Jan 2022 04:57:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqDqj73QTr7awMwMImwrv690LattEX7bVhb23zjB/pqzjFWBLNXPedpeJ8s8RHApVDZww0WQ==
X-Received: by 2002:a17:907:16a8:: with SMTP id hc40mr3325128ejc.210.1642078663980;
        Thu, 13 Jan 2022 04:57:43 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id la21sm856948ejc.137.2022.01.13.04.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 04:57:43 -0800 (PST)
Message-ID: <4b8cc931-1d87-dd8b-133e-106dd987e0b0@canonical.com>
Date:   Thu, 13 Jan 2022 13:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 11/23] pinctrl: samsung: add FSD SoC specific data
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Ajay Kumar <ajaykumar.rs@samsung.com>
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122400epcas5p34363ba8f477b4c273d601d0b64324afa@epcas5p3.samsung.com>
 <20220113121143.22280-12-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-12-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> This patch adds Tesla FSD SoC specific data to enable pinctrl.
> FSD SoC has similar pinctrl controller as found in the most
> samsung/exynos SoCs.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 71 +++++++++++++++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c     |  2 +
>  drivers/pinctrl/samsung/pinctrl-samsung.h     |  1 +
>  3 files changed, 74 insertions(+)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> index 6b77fd24571e..b9175b4911ac 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
> @@ -646,3 +646,74 @@ const struct samsung_pinctrl_of_match_data exynosautov9_of_data __initconst = {
>  	.ctrl		= exynosautov9_pin_ctrl,
>  	.num_ctrl	= ARRAY_SIZE(exynosautov9_pin_ctrl),
>  };
> +
> +/*
> + * Pinctrl driver data for Tesla FSD SoC. FSD SoC includes three
> + * gpio/pin-mux/pinconfig controllers.
> + */
> +
> +/* pin banks of FSD pin-controller 0 (FSYS) */
> +static const struct samsung_pin_bank_data fsd_pin_banks0[] __initconst = {
> +	EXYNOS850_PIN_BANK_EINTG(7, 0x00, "gpf0", 0x00),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x20, "gpf1", 0x04),
> +	EXYNOS850_PIN_BANK_EINTG(3, 0x40, "gpf6", 0x08),
> +	EXYNOS850_PIN_BANK_EINTG(2, 0x60, "gpf4", 0x0c),
> +	EXYNOS850_PIN_BANK_EINTG(6, 0x80, "gpf5", 0x10),
> +};
> +
> +/* pin banks of FSD pin-controller 1 (PERIC) */
> +static const struct samsung_pin_bank_data fsd_pin_banks1[] __initconst = {
> +	EXYNOS850_PIN_BANK_EINTG(4, 0x000, "gpc8", 0x00),
> +	EXYNOS850_PIN_BANK_EINTG(7, 0x020, "gpf2", 0x04),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x040, "gpf3", 0x08),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x060, "gpd0", 0x0c),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x080, "gpb0", 0x10),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x0a0, "gpb1", 0x14),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x0c0, "gpb4", 0x18),
> +	EXYNOS850_PIN_BANK_EINTG(4, 0x0e0, "gpb5", 0x1c),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x100, "gpb6", 0x20),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x120, "gpb7", 0x24),
> +	EXYNOS850_PIN_BANK_EINTG(5, 0x140, "gpd1", 0x28),
> +	EXYNOS850_PIN_BANK_EINTG(5, 0x160, "gpd2", 0x2c),
> +	EXYNOS850_PIN_BANK_EINTG(7, 0x180, "gpd3", 0x30),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x1a0, "gpg0", 0x34),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x1c0, "gpg1", 0x38),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x1e0, "gpg2", 0x3c),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x220, "gpg4", 0x44),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x240, "gpg5", 0x48),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x260, "gpg6", 0x4c),
> +	EXYNOS850_PIN_BANK_EINTG(8, 0x280, "gpg7", 0x50),
> +};
> +
> +/* pin banks of FSD pin-controller 2 (PMU) */
> +static const struct samsung_pin_bank_data fsd_pin_banks2[] __initconst = {
> +	EXYNOS850_PIN_BANK_EINTN(3, 0x00, "gpq0"),
> +};
> +
> +const struct samsung_pin_ctrl fsd_pin_ctrl[] __initconst = {
> +	{
> +		/* pin-controller instance 0 FSYS0 data */
> +		.pin_banks	= fsd_pin_banks0,
> +		.nr_banks	= ARRAY_SIZE(fsd_pin_banks0),

No wake-up interrupts (eint_wkup_init)? It's fine not to have them but
just looks incomplete.

In general looks ok, except discussion about compatibles.

> +		.eint_gpio_init = exynos_eint_gpio_init,
> +		.suspend	= exynos_pinctrl_suspend,
> +		.resume		= exynos_pinctrl_resume,
Best regards,
Krzysztof
