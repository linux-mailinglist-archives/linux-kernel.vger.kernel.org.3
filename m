Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3348D835
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiAMMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:50:01 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51050
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231395AbiAMMuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:50:00 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D0A93F1C8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642078199;
        bh=tnCA4HRIcZvjskoSMkqJWo8kfiQaZS4+GQyiSop+DyI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ReQJIthL4k4uPa7DmcHUFzmc+J92246+elVCDzJXUHRU9IaNnLQ7HNf9Csr98CfSa
         nkh9DF3eqlpTIh2IOJZvdNbkr7ZCiG6qHS8267lc0n+k6e8vlCIw/ELCyh9COng+Zt
         NT5gQoRfFJPWBD8aJ8ngiQVY9238Dnpmyow1SPRUMFDEIUSClMKqJNjszDhHUGWyqj
         bEO2Mz6LKpu23Dwd81jn6hZqgh+oMmj1KCQSy99oXjalTiwNpV9k7J9rKhuGB3qZy9
         B5Yd0NLgeSayiE6eeiNpCLY5ln04MgPitBV7QwJ5DLwN8igJHbGYifbat8X0hSNyC1
         0g0tuEH5sv1hA==
Received: by mail-ed1-f69.google.com with SMTP id x11-20020aa7d38b000000b004004e4fc8fdso2717615edq.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tnCA4HRIcZvjskoSMkqJWo8kfiQaZS4+GQyiSop+DyI=;
        b=Z/Qvn9uoDIERmYt83x+3N0mQrUyZPSBYyNeChYKLTSxBBrIEkKEny3b2Z5D/XpkVxL
         TkN1mzym7jvCI4/cuGWZw2DiH+4jDaXkDxXZzHOR/hKMeF7hzS0wAEuc5lbcOaSn6gYj
         Otb4ktYVMxwXKkDIaSYBfS7rs5rFZq6PZLNpE8GoM7JkS9xbOtmra0Wy/cVlg0jAYSKu
         XU/N6i/2YVoES2wQ8JY/pZcz4a4Bzm10pspIMrmAdPqBClHA+RhnSLuOJ4XswnFn1HgQ
         9ITiRmoNuCl3xeXGTRCwcAV+QORYg3QY4riMqeLbcObdAR2Ds0WZXl+/Z1XUaSGV1U87
         TTEQ==
X-Gm-Message-State: AOAM533HCowl0HaGuaR+ztg5h9ojvM+58bV+00BYfqTT4Cl3k91i3yDx
        YqTtQRKYm8TojGECdHNGpjTUFD3voSTUKmtJspu4Sc9TXmulpGFixjULDkZYzj3SzIIKhWuoZeU
        TcIyJjHNLjqbrGkmUYNUb2kA6X/tWqaq4LFCjnK/17w==
X-Received: by 2002:a17:906:4317:: with SMTP id j23mr3386183ejm.748.1642078198630;
        Thu, 13 Jan 2022 04:49:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnkCV8uVHvDvXo+BCsjQfovQrpVX/2Vi4aZsv65zQFi8pZnKx+YHr+3j+KDUCy3wNPScYbjQ==
X-Received: by 2002:a17:906:4317:: with SMTP id j23mr3386170ejm.748.1642078198466;
        Thu, 13 Jan 2022 04:49:58 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id hq35sm849073ejc.54.2022.01.13.04.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 04:49:58 -0800 (PST)
Message-ID: <b9fac286-9227-b26b-221b-7f54b63e6b0b@canonical.com>
Date:   Thu, 13 Jan 2022 13:49:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 03/23] clk: samsung: fsd: Add initial clock support
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122324epcas5p105c53b448b5801813a02a88c6107a2f3@epcas5p1.samsung.com>
 <20220113121143.22280-4-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-4-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> Add initial clock support for FSD (Full Self-Driving) SoC
> which is required to bring-up platforms based on this SoC.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/Makefile  |   1 +
>  drivers/clk/samsung/clk-fsd.c | 308 ++++++++++++++++++++++++++++++++++
>  drivers/clk/samsung/clk-pll.c |   1 +
>  drivers/clk/samsung/clk-pll.h |   1 +
>  4 files changed, 311 insertions(+)
>  create mode 100644 drivers/clk/samsung/clk-fsd.c
> 
> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> index c46cf11e4d0b..d66b2ede004c 100644
> --- a/drivers/clk/samsung/Makefile
> +++ b/drivers/clk/samsung/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-exynos-audss.o
>  obj-$(CONFIG_EXYNOS_CLKOUT)	+= clk-exynos-clkout.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
>  obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
> +obj-$(CONFIG_ARCH_TESLA_FSD)         += clk-fsd.o

It should be rather it's own CONFIG_TESLA_FSD_CLK option, just like
other Exynos designs. This keeps unified approach with existing Samsung
clock Kconfig.

>  obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
>  obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
>  obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
> diff --git a/drivers/clk/samsung/clk-fsd.c b/drivers/clk/samsung/clk-fsd.c
> new file mode 100644
> index 000000000000..e47523106d9e
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-fsd.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Common Clock Framework support for FSD SoC.
> + *
> + * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
> + *             https://www.samsung.com
> + * Copyright (c) 2017-2022 Tesla, Inc.
> + *             https://www.tesla.com
> + *

Drop the line break with empty * comment.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +
> +#include "clk.h"
> +#include <dt-bindings/clock/fsd-clk.h>

dt-bindings headers before local clk.h.

> +
> +/* Register Offset definitions for CMU_CMU (0x11c10000) */



Best regards,
Krzysztof
