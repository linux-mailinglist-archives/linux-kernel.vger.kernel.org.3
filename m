Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3952E010
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbiESWk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbiESWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:40:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D46A011
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:40:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ds11so6524201pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ZQEdNolUQPiRhMJeKJgbf+Cnmh94zniPqxn9XCK4hk=;
        b=BHNShkMSBGRajgbmCkPaZutKY4iz3LIS/Xk/j7mbRuvPEGmatdYHTU72yYjAgPjnTS
         HFBW03kQzOnn8LmmDMFKNIofYy3dphebkupTx5X2xX92ogNC/bZEkx5mPiUsCoI52a9z
         8HtkX4G18AL67ZtCCUrft06ynQemWChYL9I60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ZQEdNolUQPiRhMJeKJgbf+Cnmh94zniPqxn9XCK4hk=;
        b=H06r/GC4Iz0pfVGtlYZbH1een4I5bqW4l6HDkMfXyiicYHrj/iceAPtYd7/paXWcJJ
         mMgwhs1rD0hHHMxoITQON0FtpZM0+LSEVbi449EXg6aIOFnYSs0hEz6VrC18Jbmpktsk
         IaeNLGY+aRNxeC7OqjEaIn+a6s0hwbyB/i9x6ccTyZQMUU24owPWGX8rJC6/WRFPhWfV
         gmhGTiWHDwWy3A7i1ZGm1JBlxUSTGrBLsP5AlHo6pBj863sm7ciki3wruumnJ97DHQTE
         e44BWopZZxntzYsQxh/5CnqnCxeSyRQi7ZwecVIJrtnr9xo2HSNDPMfY4dusgpk5wtYU
         Dxsg==
X-Gm-Message-State: AOAM532b2QwNEYpyUIQiBFt4H1NyVYjNPCrvvUmSMGIWpdKyth5ikva7
        9fDFF4HizjpngRWyaEdxxLnyPA==
X-Google-Smtp-Source: ABdhPJz5BA+IKB7+7JxtlVC3So2qYw3COr3GbpE2eUw8zxbDbCUhSn5WBHaqDaoyX2RDDUWYxVAGxA==
X-Received: by 2002:a17:902:6901:b0:15e:ed3c:4eaf with SMTP id j1-20020a170902690100b0015eed3c4eafmr6978969plk.168.1653000022907;
        Thu, 19 May 2022 15:40:22 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:5332:2096:60a3:3455])
        by smtp.gmail.com with UTF8SMTPSA id f10-20020a63f10a000000b003c2698d199bsm4089335pgi.25.2022.05.19.15.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 15:40:22 -0700 (PDT)
Date:   Thu, 19 May 2022 15:40:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] platform/chrome: cros_kbd_led_backlight: support
 EC PWM backend
Message-ID: <YobHVST2Nfn+z8n6@google.com>
References: <20220321085547.1162312-1-tzungbi@kernel.org>
 <20220321085547.1162312-6-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220321085547.1162312-6-tzungbi@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:55:47PM +0800, Tzung-Bi Shih wrote:
> EC PWM backend uses EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT and
> EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT for setting and getting the brightness
> respectively.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v2:
> - Turn CROS_KBD_LED_BACKLIGHT_EC_PWM to boolean.
> - Use #ifdef for boolean CROS_KBD_LED_BACKLIGHT_EC_PWM.
> 
> Changes from v1:
> - Update email address accordingly.
> 
>  drivers/platform/chrome/Kconfig               |   6 +
>  .../platform/chrome/cros_kbd_led_backlight.c  | 126 +++++++++++++++---
>  2 files changed, 117 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 3f74679a556c..e02789d7c0d4 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -142,6 +142,12 @@ config CROS_KBD_LED_BACKLIGHT_ACPI
>  	help
>  	  ChromeOS keyboard backlight ACPI backend.
>  
> +config CROS_KBD_LED_BACKLIGHT_EC_PWM
> +	bool "ChromeOS keyboard backlight EC PWM backend"
> +	depends on CROS_EC && CROS_KBD_LED_BACKLIGHT
> +	help
> +	  ChromeOS keyboard backlight EC PWM backend.
> +
>  config CROS_EC_CHARDEV
>  	tristate "ChromeOS EC miscdevice"
>  	depends on MFD_CROS_EC_DEV
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index 5cbe27cb4610..8c35dd2fa607 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -11,10 +11,17 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  
> +struct keyboard_led_private {

Why 'private', isn't this more a 'cros_ec_kdb_bl' or similar?

> +	struct led_classdev cdev;
> +	struct cros_ec_device *ec;
> +};
> +
>  /**
>   * struct keyboard_led_drvdata - keyboard LED driver data.
>   * @init:			Init function.
> @@ -40,6 +47,8 @@ struct keyboard_led_drvdata {
>  	enum led_brightness max_brightness;
>  };
>  
> +#define KEYBOARD_BACKLIGHT_MAX 100
> +
>  #ifdef CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI
>  
>  /* Keyboard LED ACPI Device must be defined in firmware */
> @@ -47,8 +56,6 @@ struct keyboard_led_drvdata {
>  #define ACPI_KEYBOARD_BACKLIGHT_READ	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBQC"
>  #define ACPI_KEYBOARD_BACKLIGHT_WRITE	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBCM"
>  
> -#define ACPI_KEYBOARD_BACKLIGHT_MAX		100
> -
>  static void keyboard_led_set_brightness_acpi(struct led_classdev *cdev,
>  					     enum led_brightness brightness)
>  {
> @@ -107,7 +114,7 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
>  	.init = keyboard_led_init_acpi,
>  	.brightness_set = keyboard_led_set_brightness_acpi,
>  	.brightness_get = keyboard_led_get_brightness_acpi,
> -	.max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX,
> +	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
>  };
>  
>  #else /* CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI */
> @@ -123,34 +130,122 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
>  
>  #endif /* CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI */
>  
> +#ifdef CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM
> +
> +static int
> +keyboard_led_set_brightness_blocking_ec_pwm(struct led_classdev *cdev,
> +					    enum led_brightness brightness)

nit: since there is only a blocking version of .set_brightness you could omit
'blocking' in the function name.

> +{
> +	struct {
> +		struct cros_ec_command msg;
> +		struct ec_params_pwm_set_keyboard_backlight params;
> +	} __packed buf;
> +	struct ec_params_pwm_set_keyboard_backlight *params = &buf.params;
> +	struct cros_ec_command *msg = &buf.msg;
> +	struct keyboard_led_private *private =
> +		container_of(cdev, struct keyboard_led_private, cdev);
> +
> +	memset(&buf, 0, sizeof(buf));
> +
> +	msg->version = 0;

not strictly needed since you do the memset above, I guess it's
fine to keep the assignment if you want to be explicit about the
version.

> +	msg->command = EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT;
> +	msg->insize = 0;
> +	msg->outsize = sizeof(*params);
> +
> +	params->percent = brightness;
> +
> +	return cros_ec_cmd_xfer_status(private->ec, msg);
> +}
> +
> +static enum led_brightness
> +keyboard_led_get_brightness_ec_pwm(struct led_classdev *cdev)
> +{
> +	struct {
> +		struct cros_ec_command msg;
> +		struct ec_response_pwm_get_keyboard_backlight resp;
> +	} __packed buf;
> +	struct ec_response_pwm_get_keyboard_backlight *resp = &buf.resp;
> +	struct cros_ec_command *msg = &buf.msg;
> +	struct keyboard_led_private *private =
> +		container_of(cdev, struct keyboard_led_private, cdev);
> +	int ret;
> +
> +	memset(&buf, 0, sizeof(buf));
> +
> +	msg->version = 0;
> +	msg->command = EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT;
> +	msg->insize = sizeof(*resp);
> +	msg->outsize = 0;
> +
> +	ret = cros_ec_cmd_xfer_status(private->ec, msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return resp->percent;
> +}
> +
> +static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
> +{
> +	struct keyboard_led_private *private = platform_get_drvdata(pdev);
> +
> +	private->ec = dev_get_drvdata(pdev->dev.parent);
> +	if (!private->ec) {
> +		dev_err(&pdev->dev, "no parent EC device\n");
> +		return -EINVAL;
> +	}

The only thing this 'init' function does is assigning private->ec. Wouldn't
it be clearer to do this directly in probe() from where callback is called?
It could be with the condition that the device as a DT node.

Is it actually possible that the keyboard backlight device gets instantiated
if there is no EC parent?

> +
> +	return 0;
> +}
> +
> +static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
> +	.init = keyboard_led_init_ec_pwm,
> +	.brightness_set_blocking = keyboard_led_set_brightness_blocking_ec_pwm,
> +	.brightness_get = keyboard_led_get_brightness_ec_pwm,
> +	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
> +};
> +
> +#else /* CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM */
> +
> +static int keyboard_led_init_ec_pwm_null(struct platform_device *pdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
> +	.init = keyboard_led_init_ec_pwm_null,

Is this really needed?

keyboard_led_probe() checks if .init is assigned before invoking the callback:

	if (drvdata->init) {
		error = drvdata->init(pdev);

The whole 'else' branch could be eliminated if .of_match_table of the driver
only is assigned when CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM is set. IMO that
would preferable over creating 'stubs'.

> +};
> +
> +#endif /* CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM */
> +
>  static int keyboard_led_probe(struct platform_device *pdev)
>  {
> -	struct led_classdev *cdev;
>  	const struct keyboard_led_drvdata *drvdata;
> +	struct keyboard_led_private *private;
>  	int error;
>  
>  	drvdata = device_get_match_data(&pdev->dev);
>  	if (!drvdata)
>  		return -EINVAL;
>  
> +	private = devm_kzalloc(&pdev->dev, sizeof(*private), GFP_KERNEL);
> +	if (!private)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, private);
> +
>  	if (drvdata->init) {
>  		error = drvdata->init(pdev);
>  		if (error)
>  			return error;
>  	}
>  
> -	cdev = devm_kzalloc(&pdev->dev, sizeof(*cdev), GFP_KERNEL);
> -	if (!cdev)
> -		return -ENOMEM;
> -
> -	cdev->name = "chromeos::kbd_backlight";
> -	cdev->flags |= LED_CORE_SUSPENDRESUME;
> -	cdev->max_brightness = drvdata->max_brightness;
> -	cdev->brightness_set = drvdata->brightness_set;
> -	cdev->brightness_set_blocking = drvdata->brightness_set_blocking;
> -	cdev->brightness_get = drvdata->brightness_get;
> +	private->cdev.name = "chromeos::kbd_backlight";
> +	private->cdev.flags |= LED_CORE_SUSPENDRESUME;
> +	private->cdev.max_brightness = drvdata->max_brightness;
> +	private->cdev.brightness_set = drvdata->brightness_set;
> +	private->cdev.brightness_set_blocking = drvdata->brightness_set_blocking;
> +	private->cdev.brightness_get = drvdata->brightness_get;
>  
> -	error = devm_led_classdev_register(&pdev->dev, cdev);
> +	error = devm_led_classdev_register(&pdev->dev, &private->cdev);
>  	if (error)
>  		return error;
>  
> @@ -169,6 +264,7 @@ MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
>  static const struct of_device_id keyboard_led_of_match[] = {
>  	{
>  		.compatible = "google,cros-kbd-led-backlight",
> +		.data = &keyboard_led_drvdata_ec_pwm,
>  	},
>  	{}
>  };
> -- 
> 2.35.1.894.gb6a874cedc-goog
> 
