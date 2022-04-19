Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7E5060E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiDSAZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiDSAZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:25:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AED1E3DE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:22:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 2so14345318pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/T3Gfhb5CSWhS7QaQyFowl3g2EEqiZwzzNcN5K4b934=;
        b=mr5hjsKLWIaVgCMHEJew99IYxMNEuaOWASs5DrU5g9iF9JUPbyLmBJrgEFkHYXV5mB
         Ywc8DKuhcX/wLw8r1PlYG4VOgA9xdCdouf9XkQEutQpiYY/5Ge9Lya6T5n7gBwABKK4K
         5ADNap9+GO8fzEL/0xBODMvWl1xvRKFCS4mQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/T3Gfhb5CSWhS7QaQyFowl3g2EEqiZwzzNcN5K4b934=;
        b=ZTc1CzfmzwoApW8Reyxbw8WXsLRMCpo16irkuPqM3F+VA4guBIhB51fR+MeF3cMAD6
         PhyqjZqBV0Uxz+B51/H5mwmKwu0J7uKCnv9dgRwRQ/NA47OlVUcYQ9EwZk7zP4V0MQW3
         I+kYzOek5NMABZtBlw77X6htzGfC0g2zREP4wf6/aAp3Ts2rwVyoQ3nBMsSw/rb7e85q
         KiDLv8w5/pCxABBDO7XIl3GeYwQIBqMOx8QBL99CVQS2DtAshnbHMlU8nZZpHa1/+z2R
         QcmZCQmXOxWGZAK5LFc9XD0HmiiVwplXnndljGD5Ck6A8USZfSyjIvTy97KLCfMSCwxO
         WIQA==
X-Gm-Message-State: AOAM532IupYxG3FJYikDZqV2WFaFOMH37JIn2eRsYCY+rXejnkEPzaw6
        /JFbrMzao04acJQBl6/AAJBzIg==
X-Google-Smtp-Source: ABdhPJz1Uune6rls+uYCQI8xlokCjnbrs+GKB5C70SiB731oO+AVHbTwXu6E34kzN8S1R/sAPKlcWw==
X-Received: by 2002:a17:902:d70a:b0:158:7f07:e7c9 with SMTP id w10-20020a170902d70a00b001587f07e7c9mr13176936ply.109.1650327740972;
        Mon, 18 Apr 2022 17:22:20 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id ay13-20020a056a00300d00b0050a5af3fbc7sm8685963pfb.220.2022.04.18.17.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 17:22:20 -0700 (PDT)
Date:   Tue, 19 Apr 2022 00:22:19 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2] mfd: cros_ec_dev: Only register PCHG device if present
Message-ID: <Yl4Au/O/am/ZbX9J@chromium.org>
References: <20220419000408.3202635-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419000408.3202635-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Stephen,

On Apr 18 17:04, Stephen Boyd wrote:
> Don't create a device for the peripheral charger (PCHG) if there aren't
> any peripheral charger ports. This removes a device on most ChromeOS
> systems, because the peripheral charger functionality isn't always
> present.
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Daisuke Nojiri <dnojiri@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <chrome-platform@lists.linux.dev>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
FWIW:
Reviewed-by: Prashant Malani <pmalani@chromium.org>

> ---
> 
> Changes from v1 (https://lore.kernel.org/r/20220415003253.1973106-1-swboyd@chromium.org):
>  * Use cros_ec_command()
>  * Drop the other patches that aren't needed anymore
> 
>  drivers/mfd/cros_ec_dev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 546feef851ab..596731caf407 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -114,6 +114,9 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
>  	{ .name = "cros-ec-chardev", },
>  	{ .name = "cros-ec-debugfs", },
>  	{ .name = "cros-ec-sysfs", },
> +};
> +
> +static const struct mfd_cell cros_ec_pchg_cells[] = {
>  	{ .name = "cros-ec-pchg", },
>  };
>  
> @@ -137,6 +140,7 @@ static int ec_device_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
>  	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
> +	struct ec_response_pchg_count pchg_count;
>  	int i;
>  
>  	if (!ec)
> @@ -242,6 +246,21 @@ static int ec_device_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * The PCHG device cannot be detected by sending EC_FEATURE_GET_CMD, but
> +	 * it can be detected by querying the number of peripheral chargers.
> +	 */
> +	retval = cros_ec_command(ec->ec_dev, 0, EC_CMD_PCHG_COUNT, NULL, 0,
> +				 &pchg_count, sizeof(pchg_count));
> +	if (retval >= 0 && pchg_count.port_count) {
> +		retval = mfd_add_hotplug_devices(ec->dev,
> +					cros_ec_pchg_cells,
> +					ARRAY_SIZE(cros_ec_pchg_cells));
> +		if (retval)
> +			dev_warn(ec->dev, "failed to add pchg: %d\n",
> +				 retval);
Tiny nit: Can this fit in 1 line (100 chars[1])?


BR,

-Prashant

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
