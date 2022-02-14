Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4D4B5CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiBNVhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:37:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiBNVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:37:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970112D0B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:37:25 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A69553F1E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644874644;
        bh=kT/ZbStYKrIw4n+GRbiyCeyEm9jDf9nRetcAQkPpfiI=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=aUTtIIzvYfj0v/80+GqkQ0QLTMiXM8o0ZmSbuRnOkQ0BmnHHv0bfig37ndQLNxJiB
         mtgs+oGET55UI6eaqwijQZqEzvaZ2KVMDGeDxNUiuw6ShL6zw7utWpzI9T1PUYU2Dg
         8suyKmx01OCZhtWEK7jYxP4MMdOVxXBL+b2QCwjG1FZjjab3ZnQ3dxj3uG0Y0NxDYU
         vsV1RhCTFGNZKT7rRd/QsKNTCDi3QYJZJL+MKMw29a89twTMN1IMQvsx2AS48Krv9V
         A+Y8mGstpM/5nI6B5Tkkdxl3P1LrZCXacfKLRwTFK9kdYmPa5prrR7DbIX5oAXLLHR
         QaF6cRLfwHLuQ==
Received: by mail-wr1-f69.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so7391245wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kT/ZbStYKrIw4n+GRbiyCeyEm9jDf9nRetcAQkPpfiI=;
        b=5+gHcTfp/yzP+lfZLoZvmU48VYlU5zaW3owKsJIoPEryFdHObmKP2KmJ9hc2VIrJrT
         O5NJ4IkF9Zjr6WUKKpnIiCMYAecl3Ra4raDShOCZVlzl/cPfzJsWTqTHHH8Yo/hKklFT
         bNFCuFkTy3caGdEBGYDEAhYfvxQ3o8tl1Vi9S4o3qK50JwbDYJat6HI8eueDDQyjXQ4O
         6SYP8fWMxWPaSj1Q9N4FieB0oTaF0W60T/UWF0dHH1gCtb+otjtD6uLbKpfhjMVgYYdd
         Y9LL6oe5/w4ohGpqPv/8Ax4RFkpDELZ57G9lIh9B34y7EINLOaLv1t5Jb0zjdPcKYvMT
         J8Jw==
X-Gm-Message-State: AOAM533+ZzSNlAWIQrkxxwC685DoRIbKzzkm9L9+HkFPHZjzgDTVxttF
        9+Sl4e3odcY0GiYzHUCzA0HRWAESRTWbe/++Xo0GDwYpa+jt1r4CwhfTQT5/M/h4qG6trU9ZqjA
        5cGkgeaVrBQPc35X0+8o25JJQFQqO/va19HSSmn25iQ==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr716526wrs.275.1644874643595;
        Mon, 14 Feb 2022 13:37:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy8FAd8AthJ50nYJRkJC2MLR9VdV0C5UiWk2N5lGhZra0fVO3q6DDUwAMpmDmMD2+Wryc6ZQ==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr716511wrs.275.1644874643350;
        Mon, 14 Feb 2022 13:37:23 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b15sm26932080wri.96.2022.02.14.13.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 13:37:22 -0800 (PST)
Message-ID: <a7ab4c1e-99d9-b78e-4c49-c565432f081d@canonical.com>
Date:   Mon, 14 Feb 2022 22:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 1/4] iio:frequency:admv1014: add support for ADMV1014
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220214073418.4528-1-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214073418.4528-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 08:34, Antoniu Miclaus wrote:
> The ADMV1014 is a silicon germanium (SiGe), wideband,
> microwave downconverter optimized for point to point microwave
> radio designs operating in the 24 GHz to 44 GHz frequency range.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v7.
>  drivers/iio/frequency/Kconfig    |  10 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1014.c | 824 +++++++++++++++++++++++++++++++
>  3 files changed, 835 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1014.c
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 2c9e0559e8a4..493221f42077 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -50,6 +50,16 @@ config ADF4371
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
>  
> +config ADMV1014
> +	tristate "Analog Devices ADMV1014 Microwave Downconverter"
> +	depends on SPI && COMMON_CLK && 64BIT
> +	help
> +	  Say yes here to build support for Analog Devices ADMV1014
> +	  24 GHz to 44 GHz, Wideband, Microwave Downconverter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv1014.
> +
>  config ADRF6780
>          tristate "Analog Devices ADRF6780 Microwave Upconverter"
>          depends on SPI
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index ae3136c79202..5f0348e5eb53 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,4 +7,5 @@
>  obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
> +obj-$(CONFIG_ADMV1014) += admv1014.o
>  obj-$(CONFIG_ADRF6780) += adrf6780.o
> diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
> new file mode 100644
> index 000000000000..59a6b1f3b7cb
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -0,0 +1,824 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1014 driver
> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>

Where do you use/define clock provider?

Best regards,
Krzysztof
