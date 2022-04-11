Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74CC4FC31C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348831AbiDKR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348817AbiDKR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:27:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC615A06
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:24:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w4so23998788wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bO+BsNy1FuaSIt/iszQlx7cNNV6R1RPoXlTl3HVm+SU=;
        b=Ef23PlWCxktDuXJojezEz7rTy41ev5OFZTSYEluyUMFaMBN5r3VkoTROanB9xCAs+7
         r2momPwTkkAPaDDS6xRjwJ5+LzLxZWnr/0zlAiYEROFcxuv1v8GXUee6yWyu87ZPUg8F
         w/vYU/1YlIqQcJQap4eIO0Q4+JPnLrJsb8F9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bO+BsNy1FuaSIt/iszQlx7cNNV6R1RPoXlTl3HVm+SU=;
        b=Vp9qNzYwSlTg7aAVUt6X6LPCczT0FLhgZEAGiVm4EPImCvKG13kI61xJycUs3OcGuY
         PtWg5iDT9tmM5hw3ARGQN98tr87ytLAUoi7TwQRGLcf9wmftuKMDfgfipiVOyqvk53i6
         Uzh7RQdKXfOjVrBpnPot/7Gk+rv39NHQ7d2Pwc63lXqZW93Rt0Y56Nt+f0k+P4LYg257
         TTKWLGpYXKBPTDkP7/ngYH8RcO7t+M2ELSv/jPMvzYlkL5y2cnyl3o4w1VokOlQfM4/5
         MFCWdJM78RaJp/HYunbbg2SPBlWyFebs8IEV3MuBrfrEnCtb5SLt0ufx1CxEDPVFqUsC
         KWtA==
X-Gm-Message-State: AOAM530BfIozJ7+OyGRFmCmSTHI07qLM09HYff2bso/Py5kxeUVX+ALS
        938Mkcb6JllAoy9OMNq96rljJQ==
X-Google-Smtp-Source: ABdhPJyVwSrN9QTx39nQx4YTCuMJy+ixVzZdD7j27qLoaF+61nhle+4/lc6ixo13tBZnovp5oT0hgg==
X-Received: by 2002:a05:6000:1689:b0:204:19f5:541f with SMTP id y9-20020a056000168900b0020419f5541fmr25763937wrd.704.1649697884800;
        Mon, 11 Apr 2022 10:24:44 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm130326wmp.14.2022.04.11.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 10:24:44 -0700 (PDT)
Date:   Mon, 11 Apr 2022 17:24:42 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3 2/4] drivers: pwm: pwm-cros-ec: add channel type
 support
Message-ID: <YlRkWnVKp1ZBZEo8@google.com>
References: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
 <20220411152114.2165933-3-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411152114.2165933-3-fabiobaltieri@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
> 
> Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>

Hey Tzung-Bi, ended up not adding your "Reviewed-by" tag since I changed
a chunk of this patch after Rob's comment and there's few options for
handling the DT compatibles, feel free to take another look.

Thanks
Fabio

> ---
>  drivers/pwm/pwm-cros-ec.c | 109 ++++++++++++++++++++++++++++++--------
>  1 file changed, 86 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 5e29d9c682c3..83c33958d52b 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -6,23 +6,30 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/slab.h>
>  
> +#include <dt-bindings/mfd/cros_ec.h>
> +
> +#define OF_CROS_EC_PWM_TYPE ((void *)1)
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
> @@ -58,14 +65,31 @@ static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
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
> @@ -75,14 +99,25 @@ static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
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
> @@ -102,8 +137,17 @@ static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
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
> @@ -133,7 +177,7 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 */
>  	duty_cycle = state->enabled ? state->duty_cycle : 0;
>  
> -	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
> +	ret = cros_ec_pwm_set_duty(ec_pwm, pwm->hwpwm, duty_cycle);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -149,7 +193,7 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
>  	int ret;
>  
> -	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
> +	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
>  	if (ret < 0) {
>  		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
>  		return;
> @@ -204,13 +248,13 @@ static const struct pwm_ops cros_ec_pwm_ops = {
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
> @@ -232,10 +276,27 @@ static int cros_ec_num_pwms(struct cros_ec_device *ec)
>  	return U8_MAX;
>  }
>  
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
> @@ -285,14 +356,6 @@ static int cros_ec_pwm_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id cros_ec_pwm_of_match[] = {
> -	{ .compatible = "google,cros-ec-pwm" },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
> -#endif
> -
>  static struct platform_driver cros_ec_pwm_driver = {
>  	.probe = cros_ec_pwm_probe,
>  	.remove = cros_ec_pwm_remove,
> -- 
> 2.35.1.1178.g4f1659d476-goog
> 

-- 
Fabio Baltieri
