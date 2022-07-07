Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7756ABD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiGGTaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiGGTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:30:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F7F20BFE;
        Thu,  7 Jul 2022 12:30:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x184so7999283pfx.2;
        Thu, 07 Jul 2022 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rNjW1kwIEY/5kZagqWsC214U8GWp+x3M7qVK2GMrOLI=;
        b=E1vFwX9SAFs6L7n5gRjxI/pxygtN8qYO0JGr7AtKRs/kCmd9Y8DoGc2ob5uARbk178
         +N5ZitQyQV4IwDD/fU+pPDuibd7LZnfhZBFB4G4jQNg0mXh6SgluSAD0saMj3dNEVurI
         w1I3LkMJgTd87dK2KQ/HKFZl2EM5RU1BtZSX/7jOJep4sd/23NOt95fAvRLuX4aHlXGQ
         Li35EzLsZd1a+7Wi1V5EH8HfHVw89xT3G9DLe8L+xuLGJoMuyK7O4xlryDMgCBAlxIXG
         /nXCvX108iKCwn+0Q465T4kbyJ2DOVtJBbd92MlpltWJazipX8ZoXhW046kralGWmQR0
         oqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rNjW1kwIEY/5kZagqWsC214U8GWp+x3M7qVK2GMrOLI=;
        b=rtAlblJo8CAmBbP5oNMiFae56q3EFgsAaDGRidRy8oLrGbq0DnwTjTxBSYePYA40D4
         Q8Vc+OItMzWRGOh9DoOeHq1tgokhwfDlMK4Cbf57FsfRTL7hVeo9aP7RDhHSa33twSxX
         dVPzUl99Wn3iaRxqxnVozdtVxccihEAjiDOXBe3PZHY3lOdwuGP6FBp+1m6ccQjB/8y/
         nZMciZBQwy7uG/6SBsf97UrfsANv7h25PjCSdgvp2E9lz+mB0a+vHyZrEMweBLPOPYS6
         wv1WDWoHoKF6Dl5PJIcT56H8Hs7MaEyAmiSDL+1bM4P9vm9L0yjXLLSxi8BAmZEx/51Q
         iqyA==
X-Gm-Message-State: AJIora+DXzuF8fLOW9YG92NhF6ASKybUr8JR+GzD5kKQVjeoIVpNTvkd
        KilfCJcCCWjcXm1La9yYcJQ=
X-Google-Smtp-Source: AGRyM1tnlvQyJtAHuwz1B3mqv0X0N/6H4lbbTRErdmjx2oQEL0l0hJhce9UgvBKXtrTx18hTVOlk4Q==
X-Received: by 2002:a62:542:0:b0:525:a313:fe28 with SMTP id 63-20020a620542000000b00525a313fe28mr55479583pff.73.1657222199790;
        Thu, 07 Jul 2022 12:29:59 -0700 (PDT)
Received: from [172.30.1.47] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0040cff9def93sm25909782pga.66.2022.07.07.12.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 12:29:59 -0700 (PDT)
Message-ID: <c4f66e4d-727e-254c-2a36-6949813f8031@gmail.com>
Date:   Fri, 8 Jul 2022 04:29:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3 10/20] OPP: Migrate set-regulators API to use
 set-config helpers
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1656935522.git.viresh.kumar@linaro.org>
 <57b3f53e71550be92e28f4e2fa619f93bb5f3d78.1656935522.git.viresh.kumar@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <57b3f53e71550be92e28f4e2fa619f93bb5f3d78.1656935522.git.viresh.kumar@linaro.org>
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
> Now that we have a central API to handle all OPP table configurations,
> migrate the set-regulators family of helpers to use the new
> infrastructure.
> 
> The return type and parameter to the APIs change a bit due to this,
> update the current users as well in the same commit in order to avoid
> breaking builds.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 12 ++---
>  drivers/devfreq/exynos-bus.c | 19 +++-----
>  drivers/opp/core.c           | 91 ++++++++----------------------------
>  include/linux/pm_opp.h       | 44 ++++++++++-------
>  4 files changed, 60 insertions(+), 106 deletions(-)
> 

(snip)

> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 541baff93ee8..d1235242367f 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -33,7 +33,7 @@ struct exynos_bus {
>  
>  	unsigned long curr_freq;
>  
> -	struct opp_table *opp_table;
> +	int opp_token;
>  	struct clk *clk;
>  	unsigned int ratio;
>  };
> @@ -161,8 +161,7 @@ static void exynos_bus_exit(struct device *dev)
>  
>  	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
> -	dev_pm_opp_put_regulators(bus->opp_table);
> -	bus->opp_table = NULL;
> +	dev_pm_opp_put_regulators(bus->opp_token);
>  }
>  
>  static void exynos_bus_passive_exit(struct device *dev)
> @@ -179,18 +178,16 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  					struct exynos_bus *bus)
>  {
>  	struct device *dev = bus->dev;
> -	struct opp_table *opp_table;
>  	const char *supplies[] = { "vdd", NULL };
>  	int i, ret, count, size;
>  
> -	opp_table = dev_pm_opp_set_regulators(dev, supplies);
> -	if (IS_ERR(opp_table)) {
> -		ret = PTR_ERR(opp_table);
> +	ret = dev_pm_opp_set_regulators(dev, supplies);
> +	if (ret < 0) {
>  		dev_err(dev, "failed to set regulators %d\n", ret);
>  		return ret;
>  	}
>  
> -	bus->opp_table = opp_table;
> +	bus->opp_token = ret;
>  
>  	/*
>  	 * Get the devfreq-event devices to get the current utilization of
> @@ -236,8 +233,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>  	return 0;
>  
>  err_regulator:
> -	dev_pm_opp_put_regulators(bus->opp_table);
> -	bus->opp_table = NULL;
> +	dev_pm_opp_put_regulators(bus->opp_token);
>  
>  	return ret;
>  }
> @@ -459,8 +455,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
>  err_reg:
> -	dev_pm_opp_put_regulators(bus->opp_table);
> -	bus->opp_table = NULL;
> +	dev_pm_opp_put_regulators(bus->opp_token);
>  
>  	return ret;
>  }

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks.


(snip)


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
