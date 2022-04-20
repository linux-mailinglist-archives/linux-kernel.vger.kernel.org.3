Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F773508EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbiDTR62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiDTR6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:58:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE20C26555
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:55:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q3so2493595plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W7Xq3UJH3qMZxLkQAcnpRNWA6G5CMmkPBBfWKoowgzU=;
        b=Ajyn322Z12V0rJvJXWWTcaLARY63PnCr9NVHtOH9xff2nsXP6otqyeYCAHxYEaEYbO
         icygtpIBozeNkVBsB8+OwixJl9JIZi5FuSuSAM7Q6Nls/zg029eY8zD9nP0SbhZ0AFGv
         JcnrMuzM7W2v4iYa+ZPyPpJJ5ca0lpVRlVNNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W7Xq3UJH3qMZxLkQAcnpRNWA6G5CMmkPBBfWKoowgzU=;
        b=lFRVfNLo8yRQgK4ZQNya9n4fFwBdN54Hm+9PHqawkkz41ahLlOxPw0Xf50fWN/wrDb
         fXV+uwlRlRwsXnNjIN0P8M9/oyrwEv1uanZFLBaRvMDpKCnyTsAwaCZej4+GDpQTjCy+
         Tg6xM+GXYy71inRSUMQRc5Wf2JNrzCKxZN0JhpFfSuuYQWrfbMEdLJeLkhBik2JtENtH
         ic+sRKPmaUa4wq3WXreNSjhdDxj38y5GZ7iH3vTqb0d+FRDBRtfLs117GoHB8p742xic
         wDhBCmraYinWuHshJD9txFOF3ZIajYm66zJGksiz5lFEbMF1GQJsnL0I8dGRuwgA54zp
         Seaw==
X-Gm-Message-State: AOAM530pct8iaQl7ttkWWxBgvQoMecN/Vw8fgHPh/OVkEa28tHmBfdjS
        xJY7yKClcDHx7sylXOuPE3KvHg==
X-Google-Smtp-Source: ABdhPJwGdoo2DKbawMenjEAKnCXvHj/MNoEW31/sQtannMm66Fj+1WjrwM+hRvkFHK7zTZbAk2V8UA==
X-Received: by 2002:a17:902:7c0f:b0:157:962:c184 with SMTP id x15-20020a1709027c0f00b001570962c184mr21635232pll.111.1650477338373;
        Wed, 20 Apr 2022 10:55:38 -0700 (PDT)
Received: from chromium.org (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id ay33-20020a056a00302100b00508374700b9sm19618740pfb.166.2022.04.20.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:55:37 -0700 (PDT)
Date:   Wed, 20 Apr 2022 17:55:35 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Fabio Baltieri <fabiobaltieri@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v5 2/4] pwm: pwm-cros-ec: add channel type support
Message-ID: <YmBJF2//wGjKA7I9@chromium.org>
References: <20220420141556.681212-1-fabiobaltieri@chromium.org>
 <20220420141556.681212-3-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420141556.681212-3-fabiobaltieri@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 20 14:15, Fabio Baltieri wrote:
> Add support for EC_PWM_TYPE_DISPLAY_LIGHT and EC_PWM_TYPE_KB_LIGHT pwm
> types to the PWM cros_ec_pwm driver. This allows specifying one of these
> PWM channel by functionality, and let the EC firmware pick the correct
> channel, thus abstracting the hardware implementation from the kernel
> driver.
> 
> To use it, define the node with the "google,cros-ec-pwm-type"
> compatible.
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/pwm/pwm-cros-ec.c | 82 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 5e29d9c682c3..7f10f56c3eb6 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -12,17 +12,21 @@
>  #include <linux/pwm.h>
>  #include <linux/slab.h>
>  
> +#include <dt-bindings/mfd/cros_ec.h>
> +
>  /**
>   * struct cros_ec_pwm_device - Driver data for EC PWM
>   *
>   * @dev: Device node
>   * @ec: Pointer to EC device
>   * @chip: PWM controller chip
> + * @use_pwm_type: Use PWM types instead of generic channels
>   */
>  struct cros_ec_pwm_device {
>  	struct device *dev;
>  	struct cros_ec_device *ec;
>  	struct pwm_chip chip;
> +	bool use_pwm_type;
>  };
>  
>  /**
> @@ -58,14 +62,31 @@ static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  	kfree(channel);
>  }
>  
> -static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
> +static int cros_ec_dt_type_to_pwm_type(u8 dt_index, u8 *pwm_type)
>  {
> +	switch (dt_index) {
> +	case CROS_EC_PWM_DT_KB_LIGHT:
> +		*pwm_type = EC_PWM_TYPE_KB_LIGHT;
> +		return 0;
> +	case CROS_EC_PWM_DT_DISPLAY_LIGHT:
> +		*pwm_type = EC_PWM_TYPE_DISPLAY_LIGHT;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm, u8 index,
> +				u16 duty)
> +{
> +	struct cros_ec_device *ec = ec_pwm->ec;
>  	struct {
>  		struct cros_ec_command msg;
>  		struct ec_params_pwm_set_duty params;
>  	} __packed buf;
>  	struct ec_params_pwm_set_duty *params = &buf.params;
>  	struct cros_ec_command *msg = &buf.msg;
> +	int ret;
>  
>  	memset(&buf, 0, sizeof(buf));
>  
> @@ -75,14 +96,25 @@ static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
>  	msg->outsize = sizeof(*params);
>  
>  	params->duty = duty;
> -	params->pwm_type = EC_PWM_TYPE_GENERIC;
> -	params->index = index;
> +
> +	if (ec_pwm->use_pwm_type) {
> +		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
> +		if (ret) {
> +			dev_err(ec->dev, "Invalid PWM type index: %d\n", index);
> +			return ret;
> +		}
> +		params->index = 0;
> +	} else {
> +		params->pwm_type = EC_PWM_TYPE_GENERIC;
> +		params->index = index;
> +	}
>  
>  	return cros_ec_cmd_xfer_status(ec, msg);
>  }
>  
> -static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
> +static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
>  {
> +	struct cros_ec_device *ec = ec_pwm->ec;
>  	struct {
>  		struct cros_ec_command msg;
>  		union {
> @@ -102,8 +134,17 @@ static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
>  	msg->insize = sizeof(*resp);
>  	msg->outsize = sizeof(*params);
>  
> -	params->pwm_type = EC_PWM_TYPE_GENERIC;
> -	params->index = index;
> +	if (ec_pwm->use_pwm_type) {
> +		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
> +		if (ret) {
> +			dev_err(ec->dev, "Invalid PWM type index: %d\n", index);
> +			return ret;
> +		}
> +		params->index = 0;
> +	} else {
> +		params->pwm_type = EC_PWM_TYPE_GENERIC;
> +		params->index = index;
> +	}
>  
>  	ret = cros_ec_cmd_xfer_status(ec, msg);
>  	if (ret < 0)
> @@ -133,7 +174,7 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 */
>  	duty_cycle = state->enabled ? state->duty_cycle : 0;
>  
> -	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
> +	ret = cros_ec_pwm_set_duty(ec_pwm, pwm->hwpwm, duty_cycle);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -149,7 +190,7 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
>  	int ret;
>  
> -	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
> +	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
>  	if (ret < 0) {
>  		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
>  		return;
> @@ -204,13 +245,13 @@ static const struct pwm_ops cros_ec_pwm_ops = {
>   * of PWMs it supports directly, so we have to read the pwm duty cycle for
>   * subsequent channels until we get an error.
>   */
> -static int cros_ec_num_pwms(struct cros_ec_device *ec)
> +static int cros_ec_num_pwms(struct cros_ec_pwm_device *ec_pwm)
>  {
>  	int i, ret;
>  
>  	/* The index field is only 8 bits */
>  	for (i = 0; i <= U8_MAX; i++) {
> -		ret = cros_ec_pwm_get_duty(ec, i);
> +		ret = cros_ec_pwm_get_duty(ec_pwm, i);
>  		/*
>  		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
>  		 * responses; everything else is treated as an error.
> @@ -236,6 +277,7 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
>  {
>  	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct cros_ec_pwm_device *ec_pwm;
>  	struct pwm_chip *chip;
>  	int ret;
> @@ -251,17 +293,26 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
>  	chip = &ec_pwm->chip;
>  	ec_pwm->ec = ec;
>  
> +	if (of_device_is_compatible(np, "google,cros-ec-pwm-type"))
> +		ec_pwm->use_pwm_type = true;

Isn't it possible to just use an optional boolean property
(for example: "use-pwm-type") instead of defining a new compatible
string?

> +
>  	/* PWM chip */
>  	chip->dev = dev;
>  	chip->ops = &cros_ec_pwm_ops;
>  	chip->of_xlate = cros_ec_pwm_xlate;
>  	chip->of_pwm_n_cells = 1;
> -	ret = cros_ec_num_pwms(ec);
> -	if (ret < 0) {
> -		dev_err(dev, "Couldn't find PWMs: %d\n", ret);
> -		return ret;
> +
> +	if (ec_pwm->use_pwm_type) {
> +		chip->npwm = CROS_EC_PWM_DT_COUNT;
> +	} else {
> +		ret = cros_ec_num_pwms(ec_pwm);
> +		if (ret < 0) {
> +			dev_err(dev, "Couldn't find PWMs: %d\n", ret);
> +			return ret;
> +		}
> +		chip->npwm = ret;
>  	}
> -	chip->npwm = ret;
> +
>  	dev_dbg(dev, "Probed %u PWMs\n", chip->npwm);
>  
>  	ret = pwmchip_add(chip);
> @@ -288,6 +339,7 @@ static int cros_ec_pwm_remove(struct platform_device *dev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id cros_ec_pwm_of_match[] = {
>  	{ .compatible = "google,cros-ec-pwm" },
> +	{ .compatible = "google,cros-ec-pwm-type" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
> -- 
> 2.36.0.rc0.470.gd361397f0d-goog
> 
> 
