Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3164D56AB3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiGGTEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiGGTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:04:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B9D1EADB;
        Thu,  7 Jul 2022 12:04:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o12so7690979pfp.5;
        Thu, 07 Jul 2022 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lfedw5Q6kj9MYHK76JYN4i5YQeu/OcQq9f2Hbxue1dE=;
        b=Q92DfUFfGBSBq2rMRhTimcdKdE75oTaXk1j89PBY2orftuKs0EYufzZAPruBtKc/e1
         cz7355enxMLNE3kMcxEudu5jCPpdMmlpEu3CQ7l+U1h50RFnZQtUhO8qdR3B7vF/+KLC
         auGbW7DBqB0we/sImYcsljLCICyMgE1cz7HU3SNPykLHDvZLKgZqbTEHZaUrRqFRc+cY
         DTnfDOKitxgDhMzCjiMi3d6cCOVF5ObhWNxyg8nQ0SMeGhv0ThvXEqILg61Sk609PGqU
         /gHF30qaBJM8YRG1RlsMSgAMYmNt0l706Yl5egbme5AGzgwiRMGgWTzJltOYUIfFUPWO
         yCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lfedw5Q6kj9MYHK76JYN4i5YQeu/OcQq9f2Hbxue1dE=;
        b=Ck3SmV9D/0WYSu+mmqiH39smAtbMaeHWZ8kM+s38uH/FGi3Mh7WXN64XCwK42NkbAO
         kzYxrkEPOUMpi6qNjnz3ZLts6vekzELv+dbxU5aS8ktZgA30zI0CdHPFtwefJZ9rQgPW
         BBJqn+mkvhptpsLX5expFpK3Vdo/RgTb5NKBwYfhaAl/tRE9kir4jKsHVihasF7IJhK3
         JZIaZhlEhdveXE8wyjTwOVAiljhhIvnWaUh1bgf0xN7kZznY/x31GXDDSx8e/ffZnsUm
         ppU7HTo0t225NopGozmejS7adYdKnY2rJfYqkaJN+A+zg/1nAUL6eh1a0RqUlYgmK0CV
         sGzA==
X-Gm-Message-State: AJIora+Vpu+Ic8sz0G0eM+KgE8K3YZbv7dRZMFQQgXQbKOxZHlG5koJr
        M1pNuV/1MemuNplcJY/X2ao=
X-Google-Smtp-Source: AGRyM1vBMTVoI5fmKr4hV9WCTP7Jok/033MBAoEPhbyZTPfHRnGcZZW1OFagAJqNbMyMz7kb/cenUw==
X-Received: by 2002:a05:6a00:14c5:b0:525:3797:fd3b with SMTP id w5-20020a056a0014c500b005253797fd3bmr52910828pfu.27.1657220646748;
        Thu, 07 Jul 2022 12:04:06 -0700 (PDT)
Received: from [172.30.1.47] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id rm12-20020a17090b3ecc00b001efc839ac97sm2073696pjb.3.2022.07.07.12.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 12:04:06 -0700 (PDT)
Message-ID: <bc08957c-4ebc-7c17-cbf4-ad6718862127@gmail.com>
Date:   Fri, 8 Jul 2022 04:04:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 02/20] OPP: Make dev_pm_opp_set_regulators() accept
 NULL terminated list
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
References: <cover.1656935522.git.viresh.kumar@linaro.org>
 <9730e011004b7526e79c6f409f5147fb235b414a.1656935522.git.viresh.kumar@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <9730e011004b7526e79c6f409f5147fb235b414a.1656935522.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 22. 7. 4. 21:07, Viresh Kumar wrote:
> Make dev_pm_opp_set_regulators() accept a NULL terminated list of names
> instead of making the callers keep the two parameters in sync, which
> creates an opportunity for bugs to get in.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c                |  9 ++++-----
>  drivers/cpufreq/ti-cpufreq.c                |  7 +++----
>  drivers/devfreq/exynos-bus.c                |  4 ++--
>  drivers/gpu/drm/lima/lima_devfreq.c         |  3 ++-
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c |  4 ++--
>  drivers/opp/core.c                          | 18 ++++++++++++------
>  drivers/soc/tegra/pmc.c                     |  4 ++--
>  include/linux/pm_opp.h                      |  9 ++++-----
>  8 files changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8fcaba541539..be0c19b3ffa5 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -193,7 +193,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>  	struct private_data *priv;
>  	struct device *cpu_dev;
>  	bool fallback = false;
> -	const char *reg_name;
> +	const char *reg_name[] = { NULL, NULL };
>  	int ret;
>  
>  	/* Check if this CPU is already covered by some other policy */
> @@ -218,10 +218,9 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>  	 * OPP layer will be taking care of regulators now, but it needs to know
>  	 * the name of the regulator first.
>  	 */
> -	reg_name = find_supply_name(cpu_dev);
> -	if (reg_name) {
> -		priv->opp_table = dev_pm_opp_set_regulators(cpu_dev, &reg_name,
> -							    1);
> +	reg_name[0] = find_supply_name(cpu_dev);
> +	if (reg_name[0]) {
> +		priv->opp_table = dev_pm_opp_set_regulators(cpu_dev, reg_name);
>  		if (IS_ERR(priv->opp_table)) {
>  			ret = PTR_ERR(priv->opp_table);
>  			if (ret != -EPROBE_DEFER)
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 8f9fdd864391..560d67a6bef1 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -173,7 +173,7 @@ static struct ti_cpufreq_soc_data omap34xx_soc_data = {
>   *    seems to always read as 0).
>   */
>  
> -static const char * const omap3_reg_names[] = {"cpu0", "vbb"};
> +static const char * const omap3_reg_names[] = {"cpu0", "vbb", NULL};
>  
>  static struct ti_cpufreq_soc_data omap36xx_soc_data = {
>  	.reg_names = omap3_reg_names,
> @@ -326,7 +326,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  	struct opp_table *ti_opp_table;
>  	struct ti_cpufreq_data *opp_data;
> -	const char * const default_reg_names[] = {"vdd", "vbb"};
> +	const char * const default_reg_names[] = {"vdd", "vbb", NULL};
>  	int ret;
>  
>  	match = dev_get_platdata(&pdev->dev);
> @@ -387,8 +387,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  		if (opp_data->soc_data->reg_names)
>  			reg_names = opp_data->soc_data->reg_names;
>  		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
> -							 reg_names,
> -							 ARRAY_SIZE(default_reg_names));
> +							 reg_names);
>  		if (IS_ERR(ti_opp_table)) {
>  			dev_pm_opp_put_supported_hw(opp_data->opp_table);
>  			ret =  PTR_ERR(ti_opp_table);
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index e689101abc93..541baff93ee8 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -180,10 +180,10 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  {
>  	struct device *dev = bus->dev;
>  	struct opp_table *opp_table;
> -	const char *vdd = "vdd";
> +	const char *supplies[] = { "vdd", NULL };
>  	int i, ret, count, size;
>  
> -	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
> +	opp_table = dev_pm_opp_set_regulators(dev, supplies);
>  	if (IS_ERR(opp_table)) {
>  		ret = PTR_ERR(opp_table);
>  		dev_err(dev, "failed to set regulators %d\n", ret);

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

(snip)

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
