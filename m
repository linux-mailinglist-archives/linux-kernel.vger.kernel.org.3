Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD92558C40
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 02:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiFXA2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 20:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiFXA2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 20:28:12 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B01180D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:28:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e63so932872pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P4Yje83rZYDRwuL9uo9EpMh58B6jkiYDBp8jSKu+8xU=;
        b=IUqbXQUyFPdxLRIJZ1sfcGFJ6lHDyH0SdlPGW96Ps+WO1W4m4JbAiwTZdMkKacl+MM
         D5DjVbMguKKKfOEV6Yl7t72SfBwhAbK41aGj+mBhVLVvxmMIHEFzk4sjh5+rBvGALNqO
         S8Gh5ygMb3xtpnxKqjFVqaOSvF9ykpbsXzfCOPU5EUZ0FlEC4iAXFhvTstnDtI1yLm+M
         xr+F1GL0yzIohwkliEUKWoxjNr9v+ywYg/NrPryFnFrmULKs5kAeouQDX+51rEAxuH3s
         ukYigjwuqbpal/SjKujJSmPK9uKTCEV6aWpTqgK24biQzsVZP6+UYL/wqYWc4g+StEYW
         xi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P4Yje83rZYDRwuL9uo9EpMh58B6jkiYDBp8jSKu+8xU=;
        b=YsxQN55xaawp5IMpVdt/eos5jXFCHZEDw2GR+LJS++XKcIVaxJCi/b1ULbOHu+P+yK
         bGQ/lPEPb5msQKEDth34qfltOmM1la7tktx6Iz/GNZMJv5PvRHgAH31ObsiAt+Qt/8nM
         gPce2t0PHQW1yQCZl0Xt/xvVv/JBWg3kThzk264Usz1rCHDYdY4y1BQm548DTuYImFwW
         HUbFQAzHxBlOtj4ki5/83vbNGNiOXtCz1O5+jHiXlnX+lmMbp8OWVePKImkmYYMQ9noA
         n8kmS7ViEtgp+xgDYAPn6rVSdMfA5epiRBFHCeQu3a9CBjL8Emrup0q4H3mZ/+M2sGDp
         sXpQ==
X-Gm-Message-State: AJIora8tE7ShswYFj71uyQX6LoQNI4Yb6EtjxZFvh3G1a11B/cGxxVAh
        eyBDfT80M7VjvViRPHirJ7kmcA==
X-Google-Smtp-Source: AGRyM1s4tA8aTDDu3gGkINrxoWIx2aC28XlcSQwcSIGGo+MPKiMLb03umdr2bcjVfA21s3ZLy9ye1w==
X-Received: by 2002:a63:7046:0:b0:40c:af8d:a6 with SMTP id a6-20020a637046000000b0040caf8d00a6mr9703157pgn.38.1656030488471;
        Thu, 23 Jun 2022 17:28:08 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b001620eb3a2d6sm374708plq.203.2022.06.23.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 17:28:07 -0700 (PDT)
Date:   Fri, 24 Jun 2022 05:58:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/31] soc/tegra: Remove the call to
 devm_pm_opp_set_clkname()
Message-ID: <20220624002805.anv62ufihdrncwus@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <1e88b248352afe03cd3bf0e887b1f2be86b5afb5.1653564321.git.viresh.kumar@linaro.org>
 <12c085af-1202-95cf-e9ad-ddcfbdadf0d6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c085af-1202-95cf-e9ad-ddcfbdadf0d6@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-22, 22:15, Jon Hunter wrote:
> On 26/05/2022 12:42, Viresh Kumar wrote:
> > diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> > index 32c346b72635..49a5360f4507 100644
> > --- a/drivers/soc/tegra/common.c
> > +++ b/drivers/soc/tegra/common.c
> > @@ -108,12 +108,6 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
> >   	u32 hw_version;
> >   	int err;
> > -	err = devm_pm_opp_set_clkname(dev, NULL);
> > -	if (err) {
> > -		dev_err(dev, "failed to set OPP clk: %d\n", err);
> > -		return err;
> > -	}
> > -
> >   	/* Tegra114+ doesn't support OPP yet */
> >   	if (!of_machine_is_compatible("nvidia,tegra20") &&
> >   	    !of_machine_is_compatible("nvidia,tegra30"))
> 
> 
> This appears to be breaking a few Tegra drivers. For example, on Tegra210
> Jetson TX1 I am seeing the following and the eMMC is no longer working ...
> 
> [    0.526729] sdhci-tegra 700b0600.mmc: dev_pm_opp_set_rate: device's opp table doesn't exist
> [    0.526733] sdhci-tegra 700b0600.mmc: failed to set clk rate to 400000Hz: -19
> [    0.528830] sdhci-tegra 700b0600.mmc: dev_pm_opp_set_rate: device's opp table doesn't exist
> [    0.528833] sdhci-tegra 700b0600.mmc: failed to set clk rate to 400000Hz: -19
> 
> I have seen another instance of this on Jetson Xavier NX ...
> 
> [   12.301336] tegra-pwm 32d0000.pwm: dev_pm_opp_set_rate: device's opp table doesn't exist
> [   12.301350] tegra-pwm 32d0000.pwm: Failed to set max frequency: -19
> 
> Bisect is point to this commit and so something is not working as
> expected.

Thanks again Jon.

This is what happens when the special code doesn't have a comment
attached with it. Neither the reviewer, nor the author remember why
the special piece was required :)

I had to go through the whole sequence, along with DT to understand
what might have broken this stuff :)

I will drop this patch and add this comment in its place:

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 32c346b72635..9f3fdeb1a11c 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -108,6 +108,13 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
        u32 hw_version;
        int err;

+       /*
+        * For some devices we don't have any OPP table in the DT, and in order
+        * to use the same code path for all the devices, we create a dummy OPP
+        * table for them via this call. The dummy OPP table is only capable of
+        * doing clk_set_rate() on invocation of dev_pm_opp_set_rate() and
+        * doesn't provide any other functionality.
+        */
        err = devm_pm_opp_set_clkname(dev, NULL);
        if (err) {
                dev_err(dev, "failed to set OPP clk: %d\n", err);


Though there will still be a problem here with my changes, we don't
accept NULL clkname anymore for the set-clkname API. And tegra does
this to pick the first clock available in DT (at index 0) I think.
Other drivers (mostly qcom) who need such dummy OPP table, provide a
real clock name instead. Will it be possible to pass that here somehow
?

-- 
viresh
