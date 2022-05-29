Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7A5371C1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiE2QTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiE2QTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 12:19:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB7522F4;
        Sun, 29 May 2022 09:19:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id CF4FE1F425DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653841166;
        bh=9CTrQDgqxEHtWS8xx4NJ+2bx1b2qoRlEGrZziKFdKbw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ANb5jUtNOy9iFNOez1Gig/+CTOoRldVhAuinlkRe+HhgDMj8Z28vNX3PaJ+9n/9T/
         6lSBaePrhllsdkpvfjarXyMyDAczBaz+l11zJY4GhOjAsOeftqd6xzHIo6Ws822kZM
         BJ6Am5mPm6c0/KaYZIUOeEm3rTJnymLcJEkdfqFOMUUMyMG/qn+FBgsWGwkrEph5pJ
         D9AQXdKdE2wEj++SCA47qqOUwnG+L+fuuAfaNUMeDMNVquVmv0N6XLD3QkrHm3SHNd
         8PVS9QpqkKS8ZdIT1EueqL6gaa0q3ez0/yI0Dqn83b8T3Wc2ZaA7ZGzRLZ2zD+fWUB
         w/SEeXtPzqZjQ==
Message-ID: <793e49ea-aeb0-a47a-9fe8-742a6397bb35@collabora.com>
Date:   Sun, 29 May 2022 19:19:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 08/31] cpufreq: tegra20: Migrate to
 dev_pm_opp_set_config()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <4b38ceed657bfcf87ff9ab0dd69dd1f2f5658b24.1653564321.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <4b38ceed657bfcf87ff9ab0dd69dd1f2f5658b24.1653564321.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 14:42, Viresh Kumar wrote:
> The OPP core now provides a unified API for setting all configuration
> types, i.e. dev_pm_opp_set_config().
> 
> Lets start using it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index e8db3d75be25..2c73623e3abb 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -34,7 +34,7 @@ static bool cpu0_node_has_opp_v2_prop(void)
>  
>  static void tegra20_cpufreq_put_supported_hw(void *opp_table)
>  {
> -	dev_pm_opp_put_supported_hw(opp_table);
> +	dev_pm_opp_clear_config(opp_table);
>  }
>  
>  static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
> @@ -49,6 +49,10 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>  	struct device *cpu_dev;
>  	u32 versions[2];
>  	int err;
> +	struct dev_pm_opp_config config = {
> +		.supported_hw = versions,
> +		.supported_hw_count = ARRAY_SIZE(versions),
> +	};
>  
>  	if (!cpu0_node_has_opp_v2_prop()) {
>  		dev_err(&pdev->dev, "operating points not found\n");
> @@ -71,10 +75,10 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>  	if (WARN_ON(!cpu_dev))
>  		return -ENODEV;
>  
> -	opp_table = dev_pm_opp_set_supported_hw(cpu_dev, versions, 2);
> -	err = PTR_ERR_OR_ZERO(opp_table);
> +	opp_table = dev_pm_opp_set_config(cpu_dev, &config);
> +	err = PTR_ERR(opp_table);

Please keep the PTR_ERR_OR_ZERO.

tegra20-cpufreq tegra20-cpufreq: failed to set OPP config: -1042688000

-- 
Best regards,
Dmitry
