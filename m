Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998C84AF9F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiBIS3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiBIS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:29:03 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC8C05CB86;
        Wed,  9 Feb 2022 10:29:06 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p7so2502121qvk.11;
        Wed, 09 Feb 2022 10:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PzVf0KveynQIygGhQd/LrRGeBUE4pFRytDZ84NY3N/g=;
        b=T6lGBSaL/3OruJFHgArFuER/e/PKIJfjSbyW1s3fjGFfTBagY1y00u4MiJqe/+IPac
         RkWMrFjNgwPDoP5JIjd2OVBx32XHJzBvlKhkIZDRSiEOeP7e0HBrdhfBcPlKDjglZxu9
         X8pIUptfBcq8jDUMwW4DHurgFuH3Vr74wtRD4lSlJe/Pu6jwoBbhVkMYi1NwM4+jkc6+
         I+6OFzvjSLt67MJ7bvabe+vDect8gtjKrgR0CjWTbAok6RhplZ5RAbmHC8IUmS2BGrXH
         KkDSPDdRIyhNsJG3LgnFzAyX3XArdZzhZous5FNCmWGy7qDZ+cdmJxAD7j9mfJDUi8Z3
         7YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PzVf0KveynQIygGhQd/LrRGeBUE4pFRytDZ84NY3N/g=;
        b=w7YkSCQyqaiGWfRTg7YnRrLT8NKCWMOft6Q0eaEYqzIa9ZpMM2FFjYf/0cK/f+MOLm
         nTR7eaCHaMMYr6yoU8A68mcGYSktfoy214iIMZ5VkMF8OlbpWPtifOX9oDCPs9RXX2xR
         kjtTgGLIcRbRWIwpcxhdlmdO58r1oSqbEGc1ugf6/bR0zbMYP1BR/GEe3oJsvdl40pZQ
         H77WPcNN2lWZnXb5TR+GyY8AXSevG1qFeMAtUCapy0TdX5DaW9t7McoFdHsXeZ+b4Kdf
         lhlQO6QoQp8B9zDEkV+wIkcdw3o0BTxndIFu0UbZgg5dhPqZDfxjsU98khf5SUIs/QL9
         UwUQ==
X-Gm-Message-State: AOAM5331WgdjDemvz6EUA7R/KX240QWOh0S9sJpCSwg9+2q5uOSSV+7H
        b30tg8ZXYyv6IjuHWeGczU4=
X-Google-Smtp-Source: ABdhPJyDVIivM6oORJ2ERX52QaSmjnCW422Y3k6n8aLbdRifSiUWu9R6XWlQWE7aVijGKenJFxoZww==
X-Received: by 2002:ad4:5ec7:: with SMTP id jm7mr2559021qvb.46.1644431345933;
        Wed, 09 Feb 2022 10:29:05 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.googlemail.com with ESMTPSA id d6sm9209849qty.40.2022.02.09.10.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 10:29:05 -0800 (PST)
Subject: Re: [PATCH] pinctrl: k210: Fix bias-pull-up
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220209182822.640905-1-seanga2@gmail.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <9e10e17b-f815-46be-eec8-246c9d827444@gmail.com>
Date:   Wed, 9 Feb 2022 13:29:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20220209182822.640905-1-seanga2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 1:28 PM, Sean Anderson wrote:
> Using bias-pull-up would actually cause the pin to have its pull-down
> enabled. Fix this.
> 
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
>   drivers/pinctrl/pinctrl-k210.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
> index 49e32684dbb2..1ad61b32ec88 100644
> --- a/drivers/pinctrl/pinctrl-k210.c
> +++ b/drivers/pinctrl/pinctrl-k210.c
> @@ -527,7 +527,7 @@ static int k210_pinconf_set_param(struct pinctrl_dev *pctldev,
>   	case PIN_CONFIG_BIAS_PULL_UP:
>   		if (!arg)
>   			return -EINVAL;
> -		val |= K210_PC_PD;
> +		val |= K210_PC_PU;
>   		break;
>   	case PIN_CONFIG_DRIVE_STRENGTH:
>   		arg *= 1000;
> 

This should have

Fixes: d4c34d09ab03 ("pinctrl: Add RISC-V Canaan Kendryte K210 FPIOA driver")
