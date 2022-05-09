Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE68520496
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiEISis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbiEISio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:38:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E46A017;
        Mon,  9 May 2022 11:34:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h29so25357931lfj.2;
        Mon, 09 May 2022 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=udQyw+DhWCn+rKR8KsicvB5NUKY/PggLFMaO+ooAS+E=;
        b=LkkY77gEBT77IYxp9bRLSLV3T+LCjFGAtTs8aU6JncwwAGh5tNM1r0duXSnSkx5JOC
         wIlw81feNeZB2TcLX7n3jbx57S+2xtilSHVdX8P0fwA7AGdNa8dPqJGCrb7ygCsz5hOD
         ySJyVtfqspC+nCaWdMPC8MmObsCrLn4Eky9tIpkxKB+VpcmaebYEXO5iG3blL/Af8RAN
         xc+LUluyUWi5Xlsqoc0Dns/ziPhuUbooMa61M9Wd1dsICWCRx1zxu1CFAxVM2k+tWvUM
         J0HJiTDTJ6+PopEzHlwCFHKrU7qM6gQM5+9V105fPf8GqkzIxyx5TsalNuqSC4dBdFS+
         GxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udQyw+DhWCn+rKR8KsicvB5NUKY/PggLFMaO+ooAS+E=;
        b=NBEbDceLm4BEENKR3O5mEfbDeWdX4WlpMaoXqEjo/5uLoXRayC5mZEcNkQ8IQb6sJ7
         HViwSFVfpNXGFPJZITyMVCoD4YEwsoVeawPMzBg767svqOp73lkLAcPvkEfDSZxJ5+ul
         bBrIqKf9mks0sHdgXCangNTq47Nl2ArHemcYHRZdRCD4muLUiLe16oCgoazqy2bq5F5y
         Zc40zOBU2hLpU/n3tsk3OX9B9VXEWz9zy1yvhGkpPS9S60hsmIgodUN1V7Kyf32Dys0U
         OMqUvp0tcRPnzfJHrp1T+vnlAh52Eplj043QiycBwLbxS4lhXq4ykBTw2thOpqozlqt+
         y7mQ==
X-Gm-Message-State: AOAM533uUMXXSGNfqh/MPJtQ8jZVIfguyIkfPpQtQzfaEYAzZyyESffA
        uIhp4DSx9hH6oNDgT2KjGSI=
X-Google-Smtp-Source: ABdhPJzbP4BJRcGFlfs9fuWO/TIfRn/IPBGJNw6wigGxQ2vRVKCffAuRVtUnsXnIIb61VYQxe/qeng==
X-Received: by 2002:a05:6512:b1c:b0:474:193a:755c with SMTP id w28-20020a0565120b1c00b00474193a755cmr8301046lfu.340.1652121288278;
        Mon, 09 May 2022 11:34:48 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.75.57])
        by smtp.gmail.com with ESMTPSA id c2-20020a05651200c200b0047255d211ebsm2007062lfp.282.2022.05.09.11.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 11:34:47 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] gpio: gpiolib: Allow free() callback to be
 overridden
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <6eeaf18c-ac3d-1c1d-eb79-92bc508ce03c@gmail.com>
Date:   Mon, 9 May 2022 21:34:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220509050953.11005-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/9/22 8:09 AM, Lad Prabhakar wrote:

> Allow free() callback to be overridden from irq_domain_ops for
> hierarchical chips.
> 
> This allows drivers to free any resources which are allocated during
> populate_parent_alloc_arg().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/gpio/gpiolib.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index b7694171655c..7be01c70ee4e 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1187,15 +1187,18 @@ static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
>  	ops->activate = gpiochip_irq_domain_activate;
>  	ops->deactivate = gpiochip_irq_domain_deactivate;
>  	ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
> -	ops->free = irq_domain_free_irqs_common;
>  
>  	/*
> -	 * We only allow overriding the translate() function for
> +	 * We only allow overriding the translate() and free() function for

   Functions now?

>  	 * hierarchical chips, and this should only be done if the user
> -	 * really need something other than 1:1 translation.
> +	 * really need something other than 1:1 translation for translate()
> +	 * callback and free if user wants to free up any resources which
> +	 * were allocated during callbacks for example populate_parent_alloc_arg.
                                          ^ need comma here?

[...]

MBR, Sergey
