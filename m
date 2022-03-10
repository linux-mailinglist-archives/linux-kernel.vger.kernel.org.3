Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDDD4D4372
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiCJJ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiCJJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:26:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC80139CCC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:25:29 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E4E23F19E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646904328;
        bh=8VH86XSG05XZnr7KhrYjAiNSOrKYTAdZ5E6887Xqi70=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jfLJdnD6zLPRZYHrr+0sV/szU5Tgy4EUUZAG4Ov7mfzHXqB/N6rT+aIc61K1F5JeL
         qCen/7HDhqAwmEM6HOTxRUhGUieJb1UfcCEO1naTZdBtpHG6WY7t+DbPUYkCKuzbOQ
         WQVnKL79nfzL0Q8x4iNBR3m/2z1/p2H9MFLRQ7EfiEO2llXspdMKxD7kja3R3DpY0Z
         H1vqud36DSUGEu1FI+H7T0kiRYqQIjJTIantHDql74eAX38AkwF254dDDfk9RNRgKU
         WlwYA6PWinP4CWZKQgXWT07bpdp52451vS0NJmWPbEzKkeDCB+HR0axgz8LAMHonhu
         BQ+llPD1vsw7Q==
Received: by mail-ed1-f72.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so2775884edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8VH86XSG05XZnr7KhrYjAiNSOrKYTAdZ5E6887Xqi70=;
        b=Ljp5dGcAuMl7E8EcqZjIGdW17tGtX6xEftbIoTu35qi2BWt2JxFS5UnCn4MhCUh36V
         ogz+wWCipVyJzL0p8H6gROeXE76hAwWH3hhnKddl2BjCenMnZ/QGL0FWePHfp44fMRS3
         6bkR4XL2TcvvmgGdpt1U5pnOW+07M0+uQyC7tvQRnPMLBKCldIWUnlusKennqiDJcAqx
         8c33d0EPRH5CgLTLdNOophGl6k5pDQCVjTbsOIzedI3ABZWhi32CwEjSpV5pJ7ZaKdhX
         vZICDfgnlF8Lp5FqVbKOV6ysmR8vn+kwpPfRGvXmCfBeVXJ9sEeJg3SFdMQkOC7jwQ9Q
         Sp5g==
X-Gm-Message-State: AOAM533CnE8pP2hqJ/PbshgpwrT+rEo3jSgE/EdFyXzVPkjSjyK26c/t
        QYoHXE6g899iEAdK8AJlLQitnGNRoWCQ6ESBXPUy6UXgG4ZsZl+jA+hh82pflMHI0GZNsPW0RGG
        ev2aR5xFevXHRykgPby7ty82K+zQtuPhu22o5+UCFag==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id k11-20020a17090666cb00b006cfe4f79504mr3468809ejp.142.1646904327055;
        Thu, 10 Mar 2022 01:25:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7zLQvxZkdMq8Qn/LICz+w12g1uzQpkJyJ7/WO3jbitmNhGvXhoPUNdhbdRtW5mYwdyVEs/g==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id k11-20020a17090666cb00b006cfe4f79504mr3468777ejp.142.1646904326808;
        Thu, 10 Mar 2022 01:25:26 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402254900b00416b0ec98b5sm508583edb.45.2022.03.10.01.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 01:25:26 -0800 (PST)
Message-ID: <ecfe1f3b-3eb7-6676-6f1d-4403b7365ea0@canonical.com>
Date:   Thu, 10 Mar 2022 10:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 06/10] clk: Add Sunplus SP7021 clock driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1646892810.git.qinjian@cqplus1.com>
 <d8b68c5f77cea516504984470c5b93f8df42bbec.1646892811.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <d8b68c5f77cea516504984470c5b93f8df42bbec.1646892811.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 07:28, Qin Jian wrote:
> Add clock driver for Sunplus SP7021 SoC.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Refine the macro DBG_CLK
> Refine the clock_parent_data
> ---
>  MAINTAINERS              |   1 +
>  drivers/clk/Kconfig      |  10 +
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-sp7021.c | 741 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 753 insertions(+)
>  create mode 100644 drivers/clk/clk-sp7021.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90ebb823f..5069f552f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2663,6 +2663,7 @@ W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
>  F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
>  F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
> +F:	drivers/clk/clk-sp7021.c
>  F:	drivers/reset/reset-sunplus.c
>  F:	include/dt-bindings/clock/sp-sp7021.h
>  F:	include/dt-bindings/reset/sp-sp7021.h
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c5b3dc973..39751f9b9 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -334,6 +334,16 @@ config COMMON_CLK_VC5
>  	  This driver supports the IDT VersaClock 5 and VersaClock 6
>  	  programmable clock generators.
>  
> +config COMMON_CLK_SP7021
> +	bool "Clock driver for Sunplus SP7021 SoC"
> +	depends on SOC_SP7021 || COMPILE_TEST
> +	default SOC_SP7021
> +	help
> +	  This driver supports the Sunplus SP7021 SoC clocks.
> +	  It implements SP7021 PLLs/gate.
> +	  Not all features of the PLL are currently supported
> +	  by the driver.
> +
>  config COMMON_CLK_STM32MP157
>  	def_bool COMMON_CLK && MACH_STM32MP157
>  	help
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e42312121..f15bb5070 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
>  obj-$(CONFIG_COMMON_CLK_SI514)		+= clk-si514.o
>  obj-$(CONFIG_COMMON_CLK_SI544)		+= clk-si544.o
>  obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
> +obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
>  obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
>  obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
>  obj-$(CONFIG_COMMON_CLK_STM32MP157)	+= clk-stm32mp1.o
> diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
> new file mode 100644
> index 000000000..35ae19d65
> --- /dev/null
> +++ b/drivers/clk/clk-sp7021.c
> @@ -0,0 +1,741 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + */
> +//#define DEBUG

No dead code, please.


Best regards,
Krzysztof
