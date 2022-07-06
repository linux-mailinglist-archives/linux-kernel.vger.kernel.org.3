Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF98E568406
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiGFJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGFJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:50:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 249561580C;
        Wed,  6 Jul 2022 02:50:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3259A1042;
        Wed,  6 Jul 2022 02:50:30 -0700 (PDT)
Received: from [10.57.42.44] (unknown [10.57.42.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DB933F66F;
        Wed,  6 Jul 2022 02:50:25 -0700 (PDT)
Message-ID: <f545c1f4-0cb5-ec4e-66e8-dbed6b992085@arm.com>
Date:   Wed, 6 Jul 2022 10:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3.1 02/20] OPP: Make dev_pm_opp_set_regulators() accept
 NULL terminated list
Content-Language: en-GB
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <9730e011004b7526e79c6f409f5147fb235b414a.1656935522.git.viresh.kumar@linaro.org>
 <bcabb1a90a5158628ee1633c10f8886544723fb9.1657095331.git.viresh.kumar@linaro.org>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <bcabb1a90a5158628ee1633c10f8886544723fb9.1657095331.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 09:18, Viresh Kumar wrote:
> Make dev_pm_opp_set_regulators() accept a NULL terminated list of names
> instead of making the callers keep the two parameters in sync, which
> creates an opportunity for bugs to get in.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V3.1:
> - Update panfrost_drv.c to include the NULL element.
> 
>  drivers/cpufreq/cpufreq-dt.c                |  9 ++++-----
>  drivers/cpufreq/ti-cpufreq.c                |  7 +++----
>  drivers/devfreq/exynos-bus.c                |  4 ++--
>  drivers/gpu/drm/lima/lima_devfreq.c         |  3 ++-
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c |  3 +--
>  drivers/gpu/drm/panfrost/panfrost_drv.c     | 15 ++++++++++-----
>  drivers/opp/core.c                          | 18 ++++++++++++------
>  drivers/soc/tegra/pmc.c                     |  4 ++--
>  include/linux/pm_opp.h                      |  9 ++++-----
>  9 files changed, 40 insertions(+), 32 deletions(-)
> 
[...]
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 194af7f607a6..5110cd9b2425 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -101,8 +101,7 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>  		return 0;
>  	}
>  
> -	ret = devm_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
> -					 pfdev->comp->num_supplies);
> +	ret = devm_pm_opp_set_regulators(dev, pfdev->comp->supply_names);
>  	if (ret) {
>  		/* Continue if the optional regulator is missing */
>  		if (ret != -ENODEV) {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 7fcbc2a5b6cd..8a4bef65d38c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -625,24 +625,29 @@ static int panfrost_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const char * const default_supplies[] = { "mali" };
> +/*
> + * The OPP core wants the supply names to be NULL terminated, but we need the
> + * correct num_supplies value for regulator core. Hence, we NULL terminate here
> + * and then initialize num_supplies with ARRAY_SIZE - 1.
> + */
> +static const char * const default_supplies[] = { "mali", NULL };
>  static const struct panfrost_compatible default_data = {
> -	.num_supplies = ARRAY_SIZE(default_supplies),
> +	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
>  	.supply_names = default_supplies,
>  	.num_pm_domains = 1, /* optional */
>  	.pm_domain_names = NULL,
>  };
>  
>  static const struct panfrost_compatible amlogic_data = {
> -	.num_supplies = ARRAY_SIZE(default_supplies),
> +	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
>  	.supply_names = default_supplies,
>  	.vendor_quirk = panfrost_gpu_amlogic_quirk,
>  };
>  
> -static const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
> +static const char * const mediatek_mt8183_supplies[] = { "mali", "sram", NULL };
>  static const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
>  static const struct panfrost_compatible mediatek_mt8183_data = {
> -	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
> +	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies) - 1,
>  	.supply_names = mediatek_mt8183_supplies,
>  	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
>  	.pm_domain_names = mediatek_mt8183_pm_domains,

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks for the rework, much cleaner.

Steve

