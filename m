Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960634BDF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381224AbiBUQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:48:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381217AbiBUQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:48:15 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5922237D3;
        Mon, 21 Feb 2022 08:47:50 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id p14so34694196ejf.11;
        Mon, 21 Feb 2022 08:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mZ7odzxcmDDBexe3fFOiFTjovI32DikZ8MnOePBH+K0=;
        b=w55BJ08KXCDc2Sipb2qmL3L9V6KJzglK+gEAtA1pD85LjdNzIIFdIxQ6iXIyZbkYWn
         4KYFEO2fhcDBYbt0xAQsOzC/tkHT384JDdEVpDDz+zCusCmKWdr5X9Y91KDfGVZa9Mu0
         uwv9CirEK1cD4JTkZjLv0K8XOG5tq37Sh/RYaD8vq/rflClPRfatQibT9J5V0+d/HmaA
         GorR1YOQT9fIfCJDHOUrVucavXtUiw2GlT4cUs95pq8J4WpqIujEo8Ejkezmu5TocHUn
         SCAbONlMNHfMp+XH8Utua4xb9LG+iTA2zQN6dgoOyyndNGpSNfy8Ad/Neh/UWG/5n64l
         bYeQ==
X-Gm-Message-State: AOAM530mTZzjVwHU1x8wGQ1qQ9dfTDwWEyMMwLqlUFriMwSLkA23ndh/
        9n/laPZIS8H8snpeUyKNfZs=
X-Google-Smtp-Source: ABdhPJz1lfB8HRKxtm3xhZlXPU6kX8QkEphtvOWWgrhPcuihASzwLyN2YObNMVXiCsJ4gYVIAHfqxQ==
X-Received: by 2002:a17:906:4752:b0:6ce:61d9:b632 with SMTP id j18-20020a170906475200b006ce61d9b632mr17067189ejs.694.1645462069126;
        Mon, 21 Feb 2022 08:47:49 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id 5sm5529448ejl.32.2022.02.21.08.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:47:47 -0800 (PST)
Message-ID: <394261d1-f1df-e80d-3591-10f2d649e731@kernel.org>
Date:   Mon, 21 Feb 2022 17:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Content-Language: en-US
To:     Edwin Chiu <edwinchiu0505tw@gmail.com>, edwin.chiu@sunplus.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2022 08:26, Edwin Chiu wrote:
> Create cpuidle driver for sunplus sp7021 chip
> 
> Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
> ---
> Changes in v3
>  - Rearrangement #include sequence
>  - Change remark style to /*~*/
>  - Align author email address to same as sob
>  - Optimal code
> Changes in v4
>  - According Rob Herringrobh's comment
>    There is no need for this binding.
>    Just wanting a different driver is not a reason
>    for a duplicate schema.
>    So remove yaml file and submit driver again.
> Changes in v5
>  - According Krzysztof's comment
>    You either use appropriate compatible in DT
>    or add your compatible to cpuidle-arm.
>    Even if this did not work, then the solution is to
>    use common parts, not to duplicate entire driver.
>    According Sudeep's comment
>    In short NACK for any dedicated driver for this platform,
>    use the generic cpuidle-arm driver with appropriate platform hooks
>    Create cpuidle-sunplus.c in arch/arm/mach-sunplus/
>    for hook generic cpuidle-arm driver
> 
>  MAINTAINERS                                   |  6 ++
>  arch/arm/mach-sunplus/cpuidle-sunplus.c       | 88 +++++++++++++++++
>  include/linux/platform_data/cpuidle-sunplus.h | 12 ++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 arch/arm/mach-sunplus/cpuidle-sunplus.c
>  create mode 100644 include/linux/platform_data/cpuidle-sunplus.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0dca8f..5c96428 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18252,6 +18252,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS CPUIDLE DRIVER
> +M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
> +S:	Maintained
> +F:	arch/arm/mach-sunplus/cpuidle-sunplus.c
> +F:	include/linux/platform_data/cpuidle-sunplus.h
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> diff --git a/arch/arm/mach-sunplus/cpuidle-sunplus.c b/arch/arm/mach-sunplus/cpuidle-sunplus.c
> new file mode 100644
> index 0000000..e9d9738
> --- /dev/null
> +++ b/arch/arm/mach-sunplus/cpuidle-sunplus.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SP7021 cpu idle Driver.
> + * Copyright (C) Sunplus Tech / Tibbo Tech.
> + */
> +#define pr_fmt(fmt) "CPUidle arm: " fmt
> +
> +#include <linux/cpuidle.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_data/cpuidle-sunplus.h>
> +
> +#include <asm/cpuidle.h>
> +
> +typedef int (*idle_fn)(void);
> +
> +static DEFINE_PER_CPU(idle_fn*, sp7021_idle_ops);
> +
> +static int sp7021_cpuidle_enter(unsigned long index)
> +{
> +	return __this_cpu_read(sp7021_idle_ops)[index]();
> +}
> +static int sp7021_cpu_spc(void)
> +{
> +	cpu_v7_do_idle();   /* idle to WFI */
> +	return 0;
> +}
> +static const struct of_device_id sp7021_idle_state_match[] = {
> +	{ .compatible = "arm,idle-state", .data = sp7021_cpu_spc },
> +	{ },
> +};

This is confusing. You want to have two drivers to bind to the same
compatible? As I wrote in the previous messages, you should simply use
arm,idle-state just like few other architectures.


Best regards,
Krzysztof
