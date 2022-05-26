Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720153502A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbiEZNqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiEZNqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:46:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D72BE02E;
        Thu, 26 May 2022 06:45:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D829A1688;
        Thu, 26 May 2022 06:45:57 -0700 (PDT)
Received: from [10.1.37.22] (e122027.cambridge.arm.com [10.1.37.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F10E3F73D;
        Thu, 26 May 2022 06:45:55 -0700 (PDT)
Message-ID: <a6172ae4-d15f-ce89-fac8-0fb3efc623ce@arm.com>
Date:   Thu, 26 May 2022 14:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 15/31] drm/panfrost: Migrate to dev_pm_opp_set_config()
Content-Language: en-GB
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <2a0970a5cf1fc92e16eb2b782798a6b609594cdc.1653564321.git.viresh.kumar@linaro.org>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <2a0970a5cf1fc92e16eb2b782798a6b609594cdc.1653564321.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 12:42, Viresh Kumar wrote:
> The OPP core now provides a unified API for setting all configuration
> types, i.e. dev_pm_opp_set_config().
> 
> Lets start using it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 194af7f607a6..7826d9366d35 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -91,6 +91,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>  	struct devfreq *devfreq;
>  	struct thermal_cooling_device *cooling;
>  	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
> +	struct dev_pm_opp_config config = {
> +		.regulator_names = pfdev->comp->supply_names,
> +		.regulator_count = pfdev->comp->num_supplies,
> +	};
>  
>  	if (pfdev->comp->num_supplies > 1) {
>  		/*
> @@ -101,13 +105,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>  		return 0;
>  	}
>  
> -	ret = devm_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
> -					 pfdev->comp->num_supplies);
> +	ret = devm_pm_opp_set_config(dev, &config);
>  	if (ret) {
>  		/* Continue if the optional regulator is missing */
>  		if (ret != -ENODEV) {
>  			if (ret != -EPROBE_DEFER)
> -				DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
> +				DRM_DEV_ERROR(dev, "Couldn't set OPP config\n");
>  			return ret;
>  		}
>  	}

