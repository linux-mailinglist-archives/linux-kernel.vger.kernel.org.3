Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06594FD458
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388292AbiDLJWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377938AbiDLHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:54:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F256209;
        Tue, 12 Apr 2022 00:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D764B81B58;
        Tue, 12 Apr 2022 07:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C95C385A5;
        Tue, 12 Apr 2022 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748725;
        bh=Q00BETgFTrmU/q7T1FdvzQYcdJLp4PmeOg+OowHQNhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTI2mQf0MCbJiTv9DaUxqUVUzksobTkDS5QOT7hjig8DNV+ts93iEQ4mB9j9FyX6C
         ximBbJ17+6wDLMcqdRTJ+mDCC92LHEZhg3q9a1DlsKXp6fvCoctynGGJtRz6xO8Mby
         diVfj396JUUs0KEbk/TEKPANJw0M0pt74zA9ZRrUNZuG0dfJEYj0N63YOYXwnvYHXE
         ui+0HxtqGPFVtNtGu7guF+c1SF8J8Q7F7v91HKhOyFOE1viDWvep6vDTiQ34yumw47
         vbNQ7Qh1DS2A4CV73Bj2tw62JDEdMFI/qcV9+OgIdVjTZFJAluMuNTsm+e1Vexb7Ry
         jB/ToJShnETLw==
Date:   Tue, 12 Apr 2022 15:32:01 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] drivers: pwm: pwm-cros-ec: add channel type
 support
Message-ID: <YlUq8W+xjdxqYCo5@google.com>
References: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
 <20220411152114.2165933-3-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411152114.2165933-3-fabiobaltieri@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 03:21:12PM +0000, Fabio Baltieri wrote:
> Add support for EC_PWM_TYPE_DISPLAY_LIGHT and EC_PWM_TYPE_KB_LIGHT pwm
> types to the PWM cros_ec_pwm driver. This allows specifying one of these
> PWM channel by functionality, and let the EC firmware pick the correct
> channel, thus abstracting the hardware implementation from the kernel
> driver.
> 
> To use it, define the node with the "google,cros-ec-pwm-type"
> compatible.

Not sure whether you decide to leave the prefix as is or not[1], just another
reminder: to be neat, suggest to remove "drivers: " prefix from the commit
title.

[1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220331125818.3776912-3-fabiobaltieri@chromium.org/

> +#ifdef CONFIG_OF
> +static const struct of_device_id cros_ec_pwm_of_match[] = {
> +	{
> +		.compatible = "google,cros-ec-pwm",
> +	},
> +	{
> +		.compatible = "google,cros-ec-pwm-type",
> +		.data = OF_CROS_EC_PWM_TYPE,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
> +#else
> +#define cros_ec_pwm_of_match NULL
> +#endif
> +
>  static int cros_ec_pwm_probe(struct platform_device *pdev)
>  {
>  	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct device *dev = &pdev->dev;
> +	const struct of_device_id *id;
>  	struct cros_ec_pwm_device *ec_pwm;
>  	struct pwm_chip *chip;
>  	int ret;
> @@ -251,17 +312,27 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
>  	chip = &ec_pwm->chip;
>  	ec_pwm->ec = ec;
>  
> +	id = of_match_device(cros_ec_pwm_of_match, dev);
> +	if (id && id->data == OF_CROS_EC_PWM_TYPE)
> +		ec_pwm->use_pwm_type = true;
> +
[...]
> -#ifdef CONFIG_OF
> -static const struct of_device_id cros_ec_pwm_of_match[] = {
> -	{ .compatible = "google,cros-ec-pwm" },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
> -#endif
> -

Use dev->driver->of_match_table to access the table so that the table
declaration doesn't actually need a move.  Instead, the helper function
of_device_get_match_data() is preferred.

Alternatively, it could use
of_device_is_compatible(..."google,cros-ec-pwm-type") so that it doesn't
need to introduce OF_CROS_EC_PWM_TYPE and reduce some bits.  I would prefer
this way.
