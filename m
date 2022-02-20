Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DA4BCDDA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiBTKC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:02:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbiBTKC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:02:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D8C36E3E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:01:57 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 76FE63FDC7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645351315;
        bh=h/yuAaqPGQGM7QsM1OKmPTsCKWn2XUQ3eAZ4j+I7pq4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kBlnkhlwVPp7++YCRNTo2AVokUoMHsnE3ok9kOj2yuA/la7RkG0B2b0k2Wk+eS8Go
         tmGUS2NXGknt4QCtnoLRutTJ3VbNz15qNVMPp2AYkx0ZwYkBt/98qEnJfzi7ZD9C1Z
         Zmdc4YAoh2G5LythfvilzkxVTtUg8wtXI6pEMbV+E3a2jMn2exzGJEI3ikgSgDvraF
         XDwYIKKVgJr2HPEsq0Aq6+WifX1gz6w7Lqv6di4iKy9tOox8sv3hXC6eOaEsi/fhE9
         XUwahHf0BRiRy1+rRts3m3FB4eP+71Q5KEAw8pl5M0qxtJOETnp61niSpR363axefe
         xDKeCuE0G0zvg==
Received: by mail-wr1-f69.google.com with SMTP id e1-20020adfa741000000b001e2e74c3d4eso5675959wrd.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h/yuAaqPGQGM7QsM1OKmPTsCKWn2XUQ3eAZ4j+I7pq4=;
        b=xErcsI1Ay8CLX7ixvcrGvRTXOEN+YFHMuvxweFY/7GpsrlhceR//m5hJbXKKHeSKxn
         y3k85+EmpnVjdIwWJ2YZQthcHqjUnsaRzN8JaLa86lcnnHB/km/3GqBrS6jiWJSQqCCJ
         RC70qBv21+sdeY9zbL6Zt7F2y81ch0fUQ5ZF3DTqY5PQuIpJzOTV3qirw9frH90+0+gb
         Aby/LqCx19PrhFAqINE7j3sYcK1n1emcGQRBL4Flpqku3YXEbtFV1EWXYjOSK+Bxz9F2
         cg6y+oaFQ7hswq0bn6KvjeFQNrNsOZUAjxywSZO5XFWvbpczAdePA1GMZEpRSyH2iZ3h
         y2iw==
X-Gm-Message-State: AOAM532Gnq/nY79xTLkmzciTm0DM4ScYCWjKUUX/umW82l10D0OlxbMz
        PwBNrcaYeTmuCUc/MMZCObzddRRv9NhT6l2LW6R1lv/Hk07ebfet+egis7DOny5JDEgUYE5+my3
        jpK66TmAxZFDJ6wGmMywj3vsx7IjaO3gWZwxqR2nwnQ==
X-Received: by 2002:a05:6000:1a8f:b0:1e8:3301:1273 with SMTP id f15-20020a0560001a8f00b001e833011273mr11914056wry.707.1645351315090;
        Sun, 20 Feb 2022 02:01:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrFTR0DbwozDQn/7295tKObTgtOU/PyXe0N9s9UQMlz1DetvYZfo7VjgXm21EZ015Z8nTbUg==
X-Received: by 2002:a05:6000:1a8f:b0:1e8:3301:1273 with SMTP id f15-20020a0560001a8f00b001e833011273mr11914034wry.707.1645351314863;
        Sun, 20 Feb 2022 02:01:54 -0800 (PST)
Received: from [192.168.0.117] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id f14sm4884389wmq.3.2022.02.20.02.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 02:01:54 -0800 (PST)
Message-ID: <72848f6c-adc7-2d36-edcd-9a5fac655bbc@canonical.com>
Date:   Sun, 20 Feb 2022 11:01:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: Remove mct interrupt
 index enum
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com
References: <CGME20220219175832epcas5p399b652e6da610ada233376651694b42c@epcas5p3.samsung.com>
 <20220219181003.12739-1-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220219181003.12739-1-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2022 19:10, Alim Akhtar wrote:
> MCT driver define an enum which list global and local timer's
> irq index. Most of them are not used but MCT_G0_IRQ and
> MCT_L0_IRQ and these two are at a fixed offset/index.
> Get rid of this enum and use a #define for the used irq index.
> 
> While at it, bump-up maximum number of MCT IRQ to match the
> binding documentation. And also change the name variable to be
> more generic.
> 
> No functional changes expected.

There is a functional change - you increase MCT_NR_IRQS from 12 to 20
which affects size of mct_irqs. Can you increase it in separate commit?

> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> - currently tested on exynos7 platform, appreciate testing on
>  exynos-{3,4,5} platforms
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 6db3d5511b0f..4aea9cd3f7ba 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -60,27 +60,18 @@
>  #define MCT_CLKEVENTS_RATING		350
>  #endif
>  
> +/* There are four Global timers starting with 0 offset */
> +#define MCT_G0_IRQ	0
> +/* Local timers count starts after global timer count */
> +#define MCT_L0_IRQ	4
> +/* Max number of MCT IRQ as per binding document */
> +#define MCT_NR_IRQS	20
> +
>  enum {
>  	MCT_INT_SPI,
>  	MCT_INT_PPI
>  };
>  
> -enum {
> -	MCT_G0_IRQ,
> -	MCT_G1_IRQ,
> -	MCT_G2_IRQ,
> -	MCT_G3_IRQ,
> -	MCT_L0_IRQ,
> -	MCT_L1_IRQ,
> -	MCT_L2_IRQ,
> -	MCT_L3_IRQ,
> -	MCT_L4_IRQ,
> -	MCT_L5_IRQ,
> -	MCT_L6_IRQ,
> -	MCT_L7_IRQ,
> -	MCT_NR_IRQS,
> -};
> -
>  static void __iomem *reg_base;
>  static unsigned long clk_rate;
>  static unsigned int mct_int_type;
> @@ -89,7 +80,7 @@ static int mct_irqs[MCT_NR_IRQS];
>  struct mct_clock_event_device {
>  	struct clock_event_device evt;
>  	unsigned long base;
> -	char name[10];
> +	char name[MCT_NR_IRQS - 1];

This does not look related MCT_NR_IRQS and using here MCT_NR_IRQS
confuses. This is a "mct_tick%d" with number of local timers, so maybe
make it just 11?

>  };
>  
>  static void exynos4_mct_write(unsigned int value, unsigned long offset)


Best regards,
Krzysztof
