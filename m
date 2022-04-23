Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18C50C8A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiDWJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiDWJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:33:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF323BDF8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:30:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y21so6207356edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=pkvDUU62lynJQSg3x7Q2ysN7bQVpze/eLNbrFVUvmq4=;
        b=RGyL6EkzJUFNdtTTCvO3YMxWYRwcd7Iluj0CRawSFhhmMurPYboao3CieRHPD6E9Zb
         W/o6UykPOI7eB1MAbE+JUSTSh55jLYRerC6Slx7T9SZgAiKNhR3Q6MU8ctg3pbHTnTaG
         cWgduvoJKRq77qG27GsXAudsX4Qk8Jn83Y5grgAQfkNVoRgpHNDz7hx5FqfV0oUxLx86
         DyDs0UKhOqY2WhYvLyS2njGlXfmKJMwfwkJBMCect0VHCq3g41vgvVxN6vsPUz2YUvnz
         s5Vrg1RqXZfwUFMvnCImrlvo5Xrg8I8M759YWUP2SYYPNiHwMkgg5NtODF9KhQPXaspw
         2+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pkvDUU62lynJQSg3x7Q2ysN7bQVpze/eLNbrFVUvmq4=;
        b=00krs+7QLZaBkh2C9JGZNwTVfYBr1LF42Fa6ouSOC30VZ1RCgpPMhND7U8nhGR9Lkk
         TkK4qbMJ0xGWOTC6f8CMnXD03xQrP8G6BeMLf4NwtN9OWZJI6trkA8j2K2DN8c5hcYnn
         ideJOzwZa3eA4+k+mpNGWzam3yxWMsaaWakc2OXNSp8xyF67FRgBH+G60MZwcCOcca49
         34euAGSJ8oB7qccoofvB8+tPPk/OwgIcchB3IOfWLEqSM62vzk7uZDGrqJlRMJkpjRXZ
         Ajz/1roZPi1iDfrUouv1PUaYWZ6aRda5N0B7PCVuDLjpV1WVYc2S5lky2YnUhYxYCFnj
         W19Q==
X-Gm-Message-State: AOAM530VjhpXB1SFWJY52UQhJweVRP4PrlohA1tKhb83f0PyF627yIzv
        A462LMPFjYglP6ngjIP4020nKg==
X-Google-Smtp-Source: ABdhPJzhZvUE3x+ixRC1vFvxCF/wqqE1T9MfdIhpwHIVY1+9sCJKoBjuE+btJdS/IseO3GpADTLsAA==
X-Received: by 2002:a05:6402:1a42:b0:424:20bb:3e37 with SMTP id bf2-20020a0564021a4200b0042420bb3e37mr9339460edb.29.1650706254422;
        Sat, 23 Apr 2022 02:30:54 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n14-20020a50934e000000b0042053e79386sm1987249eda.91.2022.04.23.02.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 02:30:54 -0700 (PDT)
Message-ID: <3eb57a4c-95b6-0bf5-aa1a-90ee2fd336e1@linaro.org>
Date:   Sat, 23 Apr 2022 11:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] irqchip/aspeed-i2c-ic: Fix irq_of_parse_and_map()
 return value
Content-Language: en-US
To:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
References: <20220422104536.61451-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422104536.61451-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 12:45, Krzysztof Kozlowski wrote:
> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
> 
> Fixes: f48e699ddf70 ("irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/irqchip/irq-aspeed-i2c-ic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
> index a47db16ff960..cef1291ae783 100644
> --- a/drivers/irqchip/irq-aspeed-i2c-ic.c
> +++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
> @@ -77,7 +77,7 @@ static int __init aspeed_i2c_ic_of_init(struct device_node *node,
>  	}
>  
>  	i2c_ic->parent_irq = irq_of_parse_and_map(node, 0);
> -	if (i2c_ic->parent_irq < 0) {
> +	if (!i2c_ic->parent_irq) {
>  		ret = i2c_ic->parent_irq;

This is wrong (same in patch 2). I will send a v2.


Best regards,
Krzysztof
