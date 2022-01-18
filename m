Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46458492D56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348061AbiARSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:31:15 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36318
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244209AbiARSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:31:08 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE33F407F7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642530667;
        bh=YFaw660kiMtbZw2aFgls+WQSIT2y3r6EjVtjCEIvW6Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oZ4e3IZ1FuDZEcmRuM46tyr2vrvKPNkqMUll/mWd+pMKeDA44/ugSg5PH+60e/Bsq
         5KhGGRGvaoNqNJNjfP2xk4jZdbh/d2qRR+vCiFJk2qAUzQuyBwgjUwjsB7+j0jig3Y
         ub+wdwq9TGKLSuJwyLmfzKObGNltMQZ+GrE+K64Rh6QjZ2nAUkWzR++kxdxESNGTew
         d3eSoT8usJ6bEEs3qRSWxXogn2c7FbrT0GQzWmn8V+Mmjw6ZC9tM4HI/zgq4FWg4Ns
         67TjuOo+qnTT5G3OgZXT6ct00PACvErGkfamg7bfx6UQpHOAEEAxGxdg7TMSaWVXkj
         6Ps3UYXa9sB5w==
Received: by mail-ed1-f69.google.com with SMTP id t5-20020aa7db05000000b00402670daeb9so6882536eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YFaw660kiMtbZw2aFgls+WQSIT2y3r6EjVtjCEIvW6Q=;
        b=AgX/8D+bl8ghBbX1rIqEQ9iZyMJ3sBUgJ/BclIoXxLejQusiqx1VPVaBVn5ZmPpyA7
         5FNlqCupptCEblLr+muqe//fIp0okO5MDRzYprT7sypqtnEQlFUPh/ofKEpf/E6qxtAi
         j5p0w40uTeDq3XYGWPYzUePSOfQzO1GtEUokeNkcF7q6E0DoKf3DQvzj02/hSgeGFqbg
         InZUt7cQWtQ9ZlwBASZ0ptxmBdMcpnmGRbi8eGYCOA009HMAXcszYtx7AKgX4lwKJoFE
         7RDKG4K+Q+Y1J8tgs+GsEV1YEsUmAXYFy8TEbYvnEkWljzdY07AZczzp1KST0aafHxb9
         nl0w==
X-Gm-Message-State: AOAM533iWUTaJkZPPjyynKvwvBNe5onyEPHRuT1hXF9rEy/xzCi5+SAh
        SqWPo+dwj9V3cnJg5X7Be/4GR1kAlfPrTXPrx5ZGmsOWHENMsRtEb4NLXeqepTnYx8mUY5PBMlJ
        0hHIwbpVFKzZ6ehmUfSxnxpF5VNFr52PkIF8Xkn1rDQ==
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr21825592ejw.529.1642530667585;
        Tue, 18 Jan 2022 10:31:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBs0IMBJhfVZZtUf76zLh8JdoHRYNhTeK8f/e7FszXsAagZM7tbUlsGRQqUmDXyORjeRz+lQ==
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr21825569ejw.529.1642530667370;
        Tue, 18 Jan 2022 10:31:07 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p23sm3741934ejr.191.2022.01.18.10.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 10:31:06 -0800 (PST)
Message-ID: <b35fa0ff-18a0-2a9d-5a1b-378ef2fef66f@canonical.com>
Date:   Tue, 18 Jan 2022 19:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 04/16] clk: samsung: fsd: Add initial clock support
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
 <CGME20220118150028epcas5p282c05b78f28a9b11d46da94e78330f0c@epcas5p2.samsung.com>
 <20220118144851.69537-5-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118144851.69537-5-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:48, Alim Akhtar wrote:
> Add initial clock support for FSD (Full Self-Driving) SoC
> which is required to bring-up platforms based on this SoC.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/Kconfig   |   7 +
>  drivers/clk/samsung/Makefile  |   1 +
>  drivers/clk/samsung/clk-fsd.c | 308 ++++++++++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-pll.c |   1 +
>  drivers/clk/samsung/clk-pll.h |   1 +
>  5 files changed, 318 insertions(+)
>  create mode 100644 drivers/clk/samsung/clk-fsd.c
> 
> diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
> index 0e18d6ff2916..11587eb87fc4 100644
> --- a/drivers/clk/samsung/Kconfig
> +++ b/drivers/clk/samsung/Kconfig
> @@ -124,3 +124,10 @@ config S3C2443_COMMON_CLK
>  	help
>  	  Support for the clock controller present on the Samsung
>  	  S3C2416/S3C2443 SoCs. Choose Y here only if you build for this SoC.
> +
> +config TESLA_FSD_COMMON_CLK
> +	bool "Tesla FSD clock controller support" if COMPILE_TEST
> +	depends on COMMON_CLK_SAMSUNG
> +	help
> +	  Support for the clock controller present on the Tesla FSD SoC.
> +	  Choose Y here only if you build for this SoC.

The clock drivers Kconfig is organized in a way, that platform should
select only COMMON_CLK_SAMSUNG (first comment in a file), so let's keep
it consistent also for FSD. "select TESLA_FSD_COMMON_CLK if ARM64 &&
ARCH_TESLA_FSD" and skip the select in Kconfig.platform in following patch.


Best regards,
Krzysztof
