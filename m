Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90339550F73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbiFTEm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 00:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFTEmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:42:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF26C42
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:42:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso8289188pjd.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+qD5oJD5pwRVHMYyuv6dIhRRxn/7fc+uDTelAP64E9M=;
        b=Af+7C6s3YbdNOO9PX23VXIqItWHG7PIQsbq1V1/mALgYLAoAegp3S9AGltjAMh4Nob
         y1BbkJ+P2PIGUAp3IQiraoFt8tzNT5k2YooDlvu+aOhrpJAVXG2rEw9z8sY3CzJOQK8W
         vnWqeGFKGS0x2UaPtv85kuEG1HyhMra2I5ma8waloSHCiUAJ7TqR0Y4KebH7td6b/Z4K
         o8JLAr98kkZt6wOc/MzGfKZguBgv41apjwYxAJp1vVryMhxF19cNmDIas1ftgOlfQrQ7
         MLuzwenqIghXnn0upUwYE8mpa4WVnM3SNLOBdgnZud6GQ1IfFyZuNwMCj4NgJieqynhP
         zByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qD5oJD5pwRVHMYyuv6dIhRRxn/7fc+uDTelAP64E9M=;
        b=y/viQv2DbSwQIcTy4YVAh2opUGkd9htEDpddshPLIb0NTzIivrw3LL9akU31GEaHYL
         N9jF+cnXbKFf9/eig2yRcVgCT0ep+ZpQqcOHlIHJ/IQ3e4HcUNZYJ/N+n15Rt1orzmie
         lKDx41TWWdHposT3/HBHISGY6W1QqIrhKlxAVviaHXA1OFRCWLFn4eJvCQGScXzbXmc3
         leJffXy2G6OlJULbFparpFxe+sGF7L2JYBoiA9n171rEeXVZSJ+r83hj/sYbrXM9o8xG
         SQ8wBXznKAp4v/L6E+FklKxRkNlXAnYZHuzkMRLQf3wJ4weoVSeBuTa/6F/+KJs9ZIcI
         5TbQ==
X-Gm-Message-State: AJIora8jz5X4gaM1ldlr0/+mDRhZCzZd7GX1qS+AvYapx7LYYWIerA0U
        hvd09QYGDq4cL4R17AA5rj6JCA==
X-Google-Smtp-Source: AGRyM1szVyxEGnAxt8i/GzxdmN2ytoRk0A1gssQ4uLTVg0Xmw7Tc52+asTsf9l1jW25eQT5VYqm1zg==
X-Received: by 2002:a17:90b:48cf:b0:1e8:789c:4a9c with SMTP id li15-20020a17090b48cf00b001e8789c4a9cmr36207847pjb.98.1655700173208;
        Sun, 19 Jun 2022 21:42:53 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b0016a087cfad8sm5150133plb.264.2022.06.19.21.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 21:42:52 -0700 (PDT)
Date:   Mon, 20 Jun 2022 10:12:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liang He <windhl@126.com>
Cc:     rafael@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pmac32-cpufreq: Fix refcount leak bug
Message-ID: <20220620044242.fbknfhv5uqbrl232@vireshk-i7>
References: <20220618022545.4056299-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618022545.4056299-1-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-22, 10:25, Liang He wrote:
> In pmac_cpufreq_init_MacRISC3(), we need to add corresponding
> of_node_put() for the three node pointers whose refcount have
> been incremented by of_find_node_by_name().
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/cpufreq/pmac32-cpufreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> index 20f64a8b0a35..4b8ee2014da6 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -470,6 +470,10 @@ static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
>  	if (slew_done_gpio_np)
>  		slew_done_gpio = read_gpio(slew_done_gpio_np);
>  
> +	of_node_put(volt_gpio_np);
> +	of_node_put(freq_gpio_np);
> +	of_node_put(slew_done_gpio_np);
> +
>  	/* If we use the frequency GPIOs, calculate the min/max speeds based
>  	 * on the bus frequencies
>  	 */

Applied. Thanks.

-- 
viresh
