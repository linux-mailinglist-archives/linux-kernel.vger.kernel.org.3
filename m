Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6302E535303
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiEZR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiEZR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:58:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BFEDFD7;
        Thu, 26 May 2022 10:58:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id DA6701F458C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653587881;
        bh=vKrfmc3boXboPynKhfGf6a+AgAeTRHxWWw/3jLM5Jic=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DGkTuUPwewZwysjZztrVad/lb9S/kXm3+CYcMvUjKexgsyXtFd1nxFQrKIctmAXDE
         Dg4zWR6Lg/z3Q5upNyDit2RITf3OMKBlmER62SyW0U42xsGGg6QU60mHzng41heGyk
         NU4P7ccBQDG8c0W5TBR01+lyJcSnh8zyQ8X4MXL0wbrfDi55ocZBn4f47Yq+Qm9r/l
         dkOwFM8+qVn8evQindIk4K2aIF4MZIQ+S647V8zghD5pI/2CMgkfBp23fAj8XzYIZ6
         3Mt5DrdIKw58s6+5PISOPPMbS6bEZtDYTHtKIafhS/zxXwZl9zGfofl5uvRKsINlUj
         HSzFw1AXzb0JQ==
Message-ID: <45c29859-f7a6-48e5-be48-bd8191ac299a@collabora.com>
Date:   Thu, 26 May 2022 20:57:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 21/31] soc/tegra: Remove the call to
 devm_pm_opp_set_clkname()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <1e88b248352afe03cd3bf0e887b1f2be86b5afb5.1653564321.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1e88b248352afe03cd3bf0e887b1f2be86b5afb5.1653564321.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 14:42, Viresh Kumar wrote:
> The OPP core already performs devm_pm_opp_set_clkname() with name as
> NULL, the callers shouldn't be doing the same unless they have a
> different clock name to add here.
> 
> Drop the call.
> 
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/soc/tegra/common.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index 32c346b72635..49a5360f4507 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -108,12 +108,6 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
>  	u32 hw_version;
>  	int err;
>  
> -	err = devm_pm_opp_set_clkname(dev, NULL);
> -	if (err) {
> -		dev_err(dev, "failed to set OPP clk: %d\n", err);
> -		return err;
> -	}
> -
>  	/* Tegra114+ doesn't support OPP yet */
>  	if (!of_machine_is_compatible("nvidia,tegra20") &&
>  	    !of_machine_is_compatible("nvidia,tegra30"))

I can't see where OPP core performs devm_pm_opp_set_clkname().

-- 
Best regards,
Dmitry
