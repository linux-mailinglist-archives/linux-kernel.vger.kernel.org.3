Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335424DDF9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbiCRRJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiCRRJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:09:14 -0400
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.143.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E33326D6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:07:53 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 4A2F546838
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:07:53 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id VG4vnkivZ22u3VG4vnGBk5; Fri, 18 Mar 2022 12:07:53 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+vwOnZYRDpc2Rxn+99Q9oUmqHMKcPiKJ6cR9bSvL4fE=; b=s/TaCA+migd+hqrUX+CszoPfcF
        0OcMHlWEzUvRiTbYsC0dqK5fmzsJowGB2hn23eys/MJgpyk050gHDAiirHKmBJGF4sFWjjaz68Gs2
        AP9mw+Fsj77Z7AoeO7vG9iPpgRxNxVtpOr9M6yrZ3h6pxxr4cq9B1rwIqxKdRH6ej+qN/qy5V4bTw
        sNTMCFU5Ti6UwTnWhBymArT8CBdEimjRxvy0/hG3m+NXhwBBi/FgkddSt9etaXNP3DEy3PYzicOti
        TXkUKlk/dz/Guwkb9GOXlPuOwhgp1oCbd5MMTBkvV2NIO8orp8Dc2APs3j2BAC9xSMl2ISE5WoV5m
        8CXRSlhQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57544 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nVG4u-000fXT-IW; Fri, 18 Mar 2022 17:07:52 +0000
Date:   Fri, 18 Mar 2022 10:07:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] platform/chrome: cros_kbd_led_backlight: support
 EC PWM backend
Message-ID: <20220318170751.GA687500@roeck-us.net>
References: <20220314090835.3822093-1-tzungbi@kernel.org>
 <20220314090835.3822093-6-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314090835.3822093-6-tzungbi@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nVG4u-000fXT-IW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57544
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 05:08:35PM +0800, Tzung-Bi Shih wrote:
> EC PWM backend uses EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT and
> EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT for setting and getting the brightness
> respectively.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> Changes from v1:
> - Update email address accordingly.
> 
>  drivers/platform/chrome/Kconfig               |   6 +
>  .../platform/chrome/cros_kbd_led_backlight.c  | 126 +++++++++++++++---
>  2 files changed, 117 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 3f74679a556c..298a49550857 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -142,6 +142,12 @@ config CROS_KBD_LED_BACKLIGHT_ACPI
>  	help
>  	  ChromeOS keyboard backlight ACPI backend.
>  
> +config CROS_KBD_LED_BACKLIGHT_EC_PWM
> +	tristate "ChromeOS keyboard backlight EC PWM backend"

This is not a standa-alone module and should therefore be bool,
not tristate.

Thanks,
Guenter

> +	depends on CROS_EC && CROS_KBD_LED_BACKLIGHT
> +	help
> +	  ChromeOS keyboard backlight EC PWM backend.
> +
>  config CROS_EC_CHARDEV
>  	tristate "ChromeOS EC miscdevice"
>  	depends on MFD_CROS_EC_DEV
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index 1f2750c830d4..05a93b71d222 100644
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
>  #if IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI)
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
>  #else /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI) */
> @@ -123,34 +130,122 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
>  
>  #endif /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI) */
>  
> +#if IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM)

#ifdef (with bool) should do.

> +
> +static int
> +keyboard_led_set_brightness_blocking_ec_pwm(struct led_classdev *cdev,
> +					    enum led_brightness brightness)
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
> +#else /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM) */
> +
> +static int keyboard_led_init_ec_pwm_null(struct platform_device *pdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
> +	.init = keyboard_led_init_ec_pwm_null,
> +};
> +
> +#endif /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM) */
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
