Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE34F54DE77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiFPJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFPJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:52:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3C950008
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:51:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cx11so996450pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pd3vKUxuz7Neq/KsDVniIvd+pYB4Tm3B3eTO5pzeGQU=;
        b=SlDq10xywGLpgTKhUH0vz5t7ob9J/Q3FoEn6Lu7EjDpni4O1kOmB4nX5w3WdaUUyh3
         aoqxroMy9K/NM687xue8G45rCtWmGAuUpgD5q3WU6Gqf18cjQCH+jAlMFGQBCY3kFZOR
         DNe5Udq2r5+3GxFp/qj/D9JqEqITvcfM1QNgWvE6i3odZTDGHuJyS7LQWVNAXl46MxPT
         Do0fYf5iftTJROvVTe1ykm/uDxCM4pw4CyTXmBr+A5DwTq15vkrYQjgkoddlss2HpuCY
         xCg+vddXZi2zhDJX7Fo9fCBY3HHKiVwA8W144rOs+BCT7UZa5hvFeUnCDLd54YOY9+e+
         TMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pd3vKUxuz7Neq/KsDVniIvd+pYB4Tm3B3eTO5pzeGQU=;
        b=CK2saV9dPfmMuBA3Ig61oGKVatvJeTsXV06eEoedcp6ImN4TGUx36qLy+Nb3teUHKq
         C/seF5RQIKGq1p1a5RlnyYPHWVC1HT7tVEAMlZ+05tzWcQ6BJxbjz7uuq+FACb4hC6w4
         YxC++Z76td4YkLNq0+uHj3Tq+N3DU4MA4b7+PqbNVRsIdV9Ap+uBIrGfmcpcUpke/a0T
         xhrdE5DSpAEhDPy5GI2OcMwQ5yGD5ULuFkeg4OL+TU06sYLcgeXtftg+okDd8kL+ZU5U
         Vk6T6TjdlvlkVfXwq1hsxsCh/3SOwcSOYxDDcDiHdUhFvnsAxpPm8sxTZxN9K8iD/R7m
         5DRA==
X-Gm-Message-State: AJIora8H9/xX0FLaNb0iu7AsW/MIgHjupd34c+RxsnEySLU2ZUYTzxPj
        StL0bzY1giZmri3UbGKcg87npA==
X-Google-Smtp-Source: AGRyM1uhUab8hspyAC4ENwVpVPnptGHEppx2G/Up3Tvw1+Ro/aUeS1M2CUAGVRLeVMLEvV73bMO7kA==
X-Received: by 2002:a17:903:1c5:b0:167:71bd:462f with SMTP id e5-20020a17090301c500b0016771bd462fmr4034415plh.65.1655373119282;
        Thu, 16 Jun 2022 02:51:59 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a639f11000000b004085adf1372sm1250564pge.77.2022.06.16.02.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 02:51:58 -0700 (PDT)
Date:   Thu, 16 Jun 2022 15:21:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liang He <windhl@126.com>
Cc:     vireshk@kernel.org, shiraz.linux.kernel@gmail.com, soc@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm: mach-spear: Add missing of_node_put() in time.c
Message-ID: <20220616095156.clyiogsvrxbmyrd6@vireshk-i7>
References: <20220616093027.3984903-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616093027.3984903-1-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-22, 17:30, Liang He wrote:
> In spear_setup_of_timer(), of_find_matching_node() will return a
> node pointer with refcount incrementd. We should use of_node_put()
> in each fail path or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  changelog:
>  
>  v2: use goto-label patch style suggested by Viresh.
>  v1: use plain of_node_put in each fail path.
> 
>  arch/arm/mach-spear/time.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index d1fdb6066f7b..c7c17c0f936c 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -218,13 +218,13 @@ void __init spear_setup_of_timer(void)
>  	irq = irq_of_parse_and_map(np, 0);
>  	if (!irq) {
>  		pr_err("%s: No irq passed for timer via DT\n", __func__);
> -		return;
> +		goto err_put_np;
>  	}
>  
>  	gpt_base = of_iomap(np, 0);
>  	if (!gpt_base) {
>  		pr_err("%s: of iomap failed\n", __func__);
> -		return;
> +		goto err_put_np;
>  	}
>  
>  	gpt_clk = clk_get_sys("gpt0", NULL);
> @@ -239,6 +239,8 @@ void __init spear_setup_of_timer(void)
>  		goto err_prepare_enable_clk;
>  	}
>  
> +	of_node_put(np);
> +
>  	spear_clockevent_init(irq);
>  	spear_clocksource_init();
>  
> @@ -248,4 +250,6 @@ void __init spear_setup_of_timer(void)
>  	clk_put(gpt_clk);
>  err_iomap:
>  	iounmap(gpt_base);
> +err_put_np:
> +	of_node_put(np);
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
