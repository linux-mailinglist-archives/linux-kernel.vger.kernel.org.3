Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC6D4E84E7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 03:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiC0BZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 21:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiC0BZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 21:25:38 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.46.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006BB2703
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 18:24:00 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 00E33400D3174
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 20:24:00 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id YHbTnodBCb6UBYHbTnxccY; Sat, 26 Mar 2022 20:21:59 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RtzdmQ/bTMAtmnstrZxDAEBEe9Eg03nZ7kVPMBFtQ4s=; b=Hur61BFRol4YRhtdwa9xjpmE5e
        /vPFnV/Tsu6fyI3Qj6FZk9Gbdi/lGWxTsv5UpFZd5uyQsbMcauZL9L1tTWqyuOULOHidkt1nz9Yxn
        h1jA5KqVKEGZQ6fJEejmcO5kFBAG6Fo1JYxFdlcel2avgU0tIN6yf59yKsLKtmR6Jba/b0ehPqXOS
        y2ly5ZPcTCmUEOjVsx5rBKFunYRDxzEnKHFv8EDFW8OyjKwFiVdMut79jrOp7kfrNf0AQZUhxghdl
        VQyY1i2gzc4QpzPX3YUl/D3LoWy1MJZc8UrB1Qqa6jekFrcC6B7I+Peu7aShsQNTF2wAIGeY8CzJi
        U8xOkRTg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54490)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nYHbT-001Zd8-5K; Sun, 27 Mar 2022 01:21:59 +0000
Message-ID: <7c82d795-889a-bf42-adf8-807d61eb517b@roeck-us.net>
Date:   Sat, 26 Mar 2022 18:21:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/4] lib: add generic polynomial calculation
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220326192347.2940747-1-michael@walle.cc>
 <20220326192347.2940747-2-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220326192347.2940747-2-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nYHbT-001Zd8-5K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54490
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/22 12:23, Michael Walle wrote:
> Some temperature and voltage sensors use a polynomial to convert between
> raw data points and actual temperature or voltage. The polynomial is
> usually the result of a curve fitting of the diode characteristic.
> 
> The BT1 PVT hwmon driver already uses such a polynonmial calculation
> which is rather generic. Move it to lib/ so other drivers can reuse it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>   include/linux/polynomial.h | 35 ++++++++++++++
>   lib/Kconfig                |  3 ++
>   lib/Makefile               |  2 +
>   lib/polynomial.c           | 95 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 135 insertions(+)
>   create mode 100644 include/linux/polynomial.h
>   create mode 100644 lib/polynomial.c
> 
> diff --git a/include/linux/polynomial.h b/include/linux/polynomial.h
> new file mode 100644
> index 000000000000..9e074a0bb6fa
> --- /dev/null
> +++ b/include/linux/polynomial.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> + */
> +
> +#ifndef _POLYNOMIAL_H
> +#define _POLYNOMIAL_H
> +
> +/*
> + * struct polynomial_term - one term descriptor of a polynomial
> + * @deg: degree of the term.
> + * @coef: multiplication factor of the term.
> + * @divider: distributed divider per each degree.
> + * @divider_leftover: divider leftover, which couldn't be redistributed.
> + */
> +struct polynomial_term {
> +	unsigned int deg;
> +	long coef;
> +	long divider;
> +	long divider_leftover;
> +};
> +
> +/*
> + * struct polynomial - a polynomial descriptor
> + * @total_divider: total data divider.
> + * @terms: polynomial terms, last term must have degree of 0
> + */
> +struct polynomial {
> +	long total_divider;
> +	struct polynomial_term terms[];
> +};
> +
> +long polynomial_calc(const struct polynomial *poly, long data);
> +
> +#endif
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 087e06b4cdfd..6a843639814f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -737,3 +737,6 @@ config PLDMFW
>   
>   config ASN1_ENCODER
>          tristate
> +
> +config POLYNOMIAL
> +       tristate
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b9ffc1bd1ee..89fcae891361 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -263,6 +263,8 @@ obj-$(CONFIG_MEMREGION) += memregion.o
>   obj-$(CONFIG_STMP_DEVICE) += stmp_device.o
>   obj-$(CONFIG_IRQ_POLL) += irq_poll.o
>   
> +obj-$(CONFIG_POLYNOMIAL) += polynomial.o
> +
>   # stackdepot.c should not be instrumented or call instrumented functions.
>   # Prevent the compiler from calling builtins like memcmp() or bcmp() from this
>   # file.
> diff --git a/lib/polynomial.c b/lib/polynomial.c
> new file mode 100644
> index 000000000000..63ea2bdc545f
> --- /dev/null
> +++ b/lib/polynomial.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic polynomial calculation using integer coefficients.
> + *
> + * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> + *
> + * Authors:
> + *   Maxim Kaurkin <maxim.kaurkin@baikalelectronics.ru>
> + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/polynomial.h>
> +
> +/*
> + * Originally this was part of drivers/hwmon/bt1-pvt.c.
> + * There the following conversion is used and should serve as an example here:
> + *
> + * The original translation formulae of the temperature (in degrees of Celsius)
> + * to PVT data and vice-versa are following:
> + *
> + * N = 1.8322e-8*(T^4) + 2.343e-5*(T^3) + 8.7018e-3*(T^2) + 3.9269*(T^1) +
> + *     1.7204e2
> + * T = -1.6743e-11*(N^4) + 8.1542e-8*(N^3) + -1.8201e-4*(N^2) +
> + *     3.1020e-1*(N^1) - 4.838e1
> + *
> + * where T = [-48.380, 147.438]C and N = [0, 1023].
> + *
> + * They must be accordingly altered to be suitable for the integer arithmetics.
> + * The technique is called 'factor redistribution', which just makes sure the
> + * multiplications and divisions are made so to have a result of the operations
> + * within the integer numbers limit. In addition we need to translate the
> + * formulae to accept millidegrees of Celsius. Here what they look like after
> + * the alterations:
> + *
> + * N = (18322e-20*(T^4) + 2343e-13*(T^3) + 87018e-9*(T^2) + 39269e-3*T +
> + *     17204e2) / 1e4
> + * T = -16743e-12*(D^4) + 81542e-9*(D^3) - 182010e-6*(D^2) + 310200e-3*D -
> + *     48380
> + * where T = [-48380, 147438] mC and N = [0, 1023].
> + *
> + * static const struct polynomial poly_temp_to_N = {
> + *         .total_divider = 10000,
> + *         .terms = {
> + *                 {4, 18322, 10000, 10000},
> + *                 {3, 2343, 10000, 10},
> + *                 {2, 87018, 10000, 10},
> + *                 {1, 39269, 1000, 1},
> + *                 {0, 1720400, 1, 1}
> + *         }
> + * };
> + *
> + * static const struct polynomial poly_N_to_temp = {
> + *         .total_divider = 1,
> + *         .terms = {
> + *                 {4, -16743, 1000, 1},
> + *                 {3, 81542, 1000, 1},
> + *                 {2, -182010, 1000, 1},
> + *                 {1, 310200, 1000, 1},
> + *                 {0, -48380, 1, 1}
> + *         }
> + * };
> + */
> +
> +/*
> + * Here is the polynomial calculation function, which performs the

This should be a proper doc string.

> + * redistributed terms calculations. It's pretty straightforward. We walk
> + * over each degree term up to the free one, and perform the redistributed
> + * multiplication of the term coefficient, its divider (as for the rationale
> + * fraction representation), data power and the rational fraction divider
> + * leftover. Then all of this is collected in a total sum variable, which
> + * value is normalized by the total divider before being returned.
> + */
> +long polynomial_calc(const struct polynomial *poly, long data)
> +{
> +	const struct polynomial_term *term = poly->terms;
> +	long total_divider = poly->total_divider ?: 1;
> +	long tmp, ret = 0;
> +	int deg;
> +
> +	do {
> +		tmp = term->coef;
> +		for (deg = 0; deg < term->deg; ++deg)
> +			tmp = mult_frac(tmp, data, term->divider);
> +		ret += tmp / term->divider_leftover;
> +	} while ((term++)->deg);
> +
> +	return ret / total_divider;
> +}
> +EXPORT_SYMBOL_GPL(polynomial_calc);
> +
> +MODULE_DESCRIPTION("Generic polynomial calculations");
> +MODULE_LICENSE("GPL");

