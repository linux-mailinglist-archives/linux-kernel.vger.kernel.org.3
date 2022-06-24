Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5C558C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiFXAsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiFXAsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:48:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86753AA42
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:48:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so1293336pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vT7SI/0dq3kYi1YzDx+CNQqO5F2TeEBjziGGhkphlR0=;
        b=cJK7kkGYzkuw1/SMY2wrCvbdnAA4eaCFG1FuVGxZGs1fHVRTmGorCsHXrrOGBGjwR8
         HH5ZMjkqmmvHoEeVk4dNympY3ENzxIHGQPRmEBCBpLNTWzi4VW03eyjmqZxK6eDCJ6xk
         DXKZ9uxeHt63pNKkUTSv150YrhtkEwcKakQySLlrG9st7iGaYOUVmP4xhlVyWv6PZfm3
         uyRAh53qApCMUazud1hMCTyVjemqWauOm5sh00/i66o6Jab47HFJpT/23lhhiEUlGdDG
         0+wNHdxWYOkmIrUhYLy7k6z0E26LpsLTOhRBBOk8evt9vb1s1Tx8bvSg4iaoOO+PsQD3
         9kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vT7SI/0dq3kYi1YzDx+CNQqO5F2TeEBjziGGhkphlR0=;
        b=FmxMJfoEBnWL7n7y5f1x7gtYxMZeeUbmX62wYJ3k8GZhnf3Hr1uiWRnjdN4kODnZ5j
         0JVWI44/DGwySlE5ZQyGgFkMOItHwM6q/Y9WnxDQGPqdjHsKmMCcKMP3OKWA7tZI47LE
         JS6RnIOYF3NXtQlpkM1fL5h7ns6SC918qerHF4IR2sX4D0vTanFmt+W8SgXdnQt1BJ7W
         3W+wLNakIMcl2GjZkDK6CT2iETfHIW87g4oYIx8tbb0bA4XiAtUJLDQ8gaK2fmjG8pTo
         +HKzGJGSfYpD8XboM3wPwYegzxXGj154gME7pbSQqs03kKxCkZEFpWBhJFENuHGOBG/P
         fjSA==
X-Gm-Message-State: AJIora9WuNV12VkW3Ay6oYg1TN6fNNvH/01nqDo5jdbhkVMr+5J7smCn
        QEpSHfRhWZ6L5fkvXxVEQp8tEQ==
X-Google-Smtp-Source: AGRyM1t3QeybUXk5i3agF3ozxrpy/i3taBdUtkZxi6rAqUowX/nFrq0JKwSCErThiOduLvCrhKq53g==
X-Received: by 2002:a17:90b:3ec6:b0:1ec:ac25:ce6f with SMTP id rm6-20020a17090b3ec600b001ecac25ce6fmr741120pjb.203.1656031714364;
        Thu, 23 Jun 2022 17:48:34 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b0015e8d4eb1d7sm412917plb.33.2022.06.23.17.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 17:48:33 -0700 (PDT)
Date:   Fri, 24 Jun 2022 06:18:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Message-ID: <20220624004831.po35sowzfo4c47b3@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-22, 17:12, Viresh Kumar wrote:
> The OPP core now provides a unified API for setting all configuration
> types, i.e. dev_pm_opp_set_config().
> 
> Lets start using it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/soc/tegra/common.c | 8 ++++++--
>  drivers/soc/tegra/pmc.c    | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index 49a5360f4507..7ba15cb836e8 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -107,6 +107,10 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
>  {
>  	u32 hw_version;
>  	int err;
> +	struct dev_pm_opp_config config = {
> +		.supported_hw = &hw_version,
> +		.supported_hw_count = 1,
> +	};
>  
>  	/* Tegra114+ doesn't support OPP yet */
>  	if (!of_machine_is_compatible("nvidia,tegra20") &&
> @@ -118,9 +122,9 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
>  	else
>  		hw_version = BIT(tegra_sku_info.soc_speedo_id);
>  
> -	err = devm_pm_opp_set_supported_hw(dev, &hw_version, 1);
> +	err = devm_pm_opp_set_config(dev, &config);
>  	if (err) {
> -		dev_err(dev, "failed to set OPP supported HW: %d\n", err);
> +		dev_err(dev, "failed to set OPP config: %d\n", err);
>  		return err;
>  	}

Jon/Dmitry,

Because of the update [1] to previous patch 21/31, I am updating this
file as (fresh diff):

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 9f3fdeb1a11c..cd53e46c4058 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -107,36 +107,42 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 {
        u32 hw_version;
        int err;
-
-       /*
-        * For some devices we don't have any OPP table in the DT, and in order
-        * to use the same code path for all the devices, we create a dummy OPP
-        * table for them via this call. The dummy OPP table is only capable of
-        * doing clk_set_rate() on invocation of dev_pm_opp_set_rate() and
-        * doesn't provide any other functionality.
-        */
-       err = devm_pm_opp_set_clkname(dev, NULL);
-       if (err) {
-               dev_err(dev, "failed to set OPP clk: %d\n", err);
-               return err;
-       }
-
-       /* Tegra114+ doesn't support OPP yet */
-       if (!of_machine_is_compatible("nvidia,tegra20") &&
-           !of_machine_is_compatible("nvidia,tegra30"))
-               return -ENODEV;
-
-       if (of_machine_is_compatible("nvidia,tegra20"))
+       struct dev_pm_opp_config config = {
+               /*
+                * For some devices we don't have any OPP table in the DT, and
+                * in order to use the same code path for all the devices, we
+                * create a dummy OPP table for them via this. The dummy OPP
+                * table is only capable of doing clk_set_rate() on invocation
+                * of dev_pm_opp_set_rate() and doesn't provide any other
+                * functionality.
+                */
+               .clk_names = NULL,
+               .clk_count = 1,
+       };
+
+       if (of_machine_is_compatible("nvidia,tegra20")) {
                hw_version = BIT(tegra_sku_info.soc_process_id);
-       else
+               config.supported_hw = &hw_version;
+               config.supported_hw_count = 1;
+       } else if (of_machine_is_compatible("nvidia,tegra30")) {
                hw_version = BIT(tegra_sku_info.soc_speedo_id);
+               config.supported_hw = &hw_version;
+               config.supported_hw_count = 1;
+       }

-       err = devm_pm_opp_set_supported_hw(dev, &hw_version, 1);
+       err = devm_pm_opp_set_config(dev, &config);
        if (err) {
-               dev_err(dev, "failed to set OPP supported HW: %d\n", err);
+               dev_err(dev, "failed to set OPP config: %d\n", err);
                return err;
        }

+       /*
+        * Tegra114+ doesn't support OPP yet, return early for non tegra20/30
+        * case.
+        */
+       if (!config.supported_hw)
+               return -ENODEV;
+
        /*
         * Older device-trees have an empty OPP table, we will get
         * -ENODEV from devm_pm_opp_of_add_table() in this case.

-------------------------8<-------------------------

The idea here is to always set the clk name (to NULL) and skip other
stuff for SoCs other than tegra 20/30.

Just see if you can find something odd with the review of it, I will
resend it properly later once the issues are settled.

-- 
viresh

[1] https://lore.kernel.org/lkml/20220624002805.anv62ufihdrncwus@vireshk-i7/
