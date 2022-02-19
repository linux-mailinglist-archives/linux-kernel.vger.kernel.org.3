Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3372D4BC8F6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiBSOsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:48:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbiBSOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:48:02 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213FFDB854;
        Sat, 19 Feb 2022 06:47:43 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id b13so1490897qkj.12;
        Sat, 19 Feb 2022 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zN8ShQniHMkwlolIAZVSp1jp83r/ryOlvEvaz8JqkhM=;
        b=okWKBH1dI3TGIarbcbsEVfrrpelE1JsFrlwwZ5GBa3fu1MTlGPyn8guTdWs6TZIepX
         TpV1rJ/1EnjVPSYyzZiR5EM6fNFyvGSVocQRlr/EaNYFkCK2Zy87Y6S6oDiMutTjd17c
         /w+SekaPBc+4/H+2C/QmCpkhx9uqCT902qfFOq49jaiEIXgK6nC19/wEzYjGHkz5xqV0
         1wQuIBiqmwGTC5n9SB5uvHM5zNKTC2opnxFt7OZKzv6soqTjtPUgyL6Sfo0Awz+ZxyE6
         mWOx9pkRTZ4JNpLbRXtfw+2tEiq1P5//icKmj61WnCKnqteVCme6DWe0RzU5Q0zfmhg9
         p+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=zN8ShQniHMkwlolIAZVSp1jp83r/ryOlvEvaz8JqkhM=;
        b=I9ORaVSyYyct1+8uiQnsNI28RFkR/4Ft/jwT3cgg03d+bGEvjH8nt0qkfDrfOEngAK
         5t5eifD0zOtGSt6RXgmLDerinfxe/jcvEyW9055adtCgf3SN1Sijx4a2v9A1vrnpm++I
         DFzsCOl/WGScjgDGlMaBcOtWHRNZkOj1BLvu2OUaf9S+fXxAsw0QqJ0kmf9OKYUFYWpc
         MRepQp1rSWKcFdNbpYeqk5W3bIRG/toFVG3q3IPzLNO+bsFD3I90i6g4mQq1QvNjbRpi
         SjFx6O6GoEJjSARailvT2gH8ovcXRNbKknXVTnaLAUjXczkoe2Me47ORWWcWf5FZ5Tph
         wZyA==
X-Gm-Message-State: AOAM5315c7BJCq/IqGbJ/8fF8vdgX0LEpHPOolE2qhNVtRXHT/TRXLXx
        gIo14dq+FwTeLAhLYELYdEY=
X-Google-Smtp-Source: ABdhPJyK45u96kVMTloRkfYB0yTikMNMn2j7ucddEvWsqv+y8z89TRg+7Au2lviOoH+zRDVsWu7cQg==
X-Received: by 2002:a05:620a:4507:b0:530:2994:f189 with SMTP id t7-20020a05620a450700b005302994f189mr7536499qkp.318.1645282062937;
        Sat, 19 Feb 2022 06:47:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9sm24993090qkn.121.2022.02.19.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:47:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Feb 2022 06:47:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] hwmon: (dell-smm) Make fan/temp sensor number a u8
Message-ID: <20220219144741.GA1032777@roeck-us.net>
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215191113.16640-4-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:11:09PM +0100, Armin Wolf wrote:
> Right now, we only use bits 0 to 7 of the fan/temp sensor number
> by doing number & 0xff. Passing the value as a u8 makes this
> step unnecessary. Also add checks to the ioctl handler since
> users might get confused when passing 0x00000101 does the same
> as passing 0x00000001.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Pali Rohár <pali@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 68 ++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 23 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 3b49e55d060f..a102034a1d38 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -21,6 +21,7 @@
>  #include <linux/errno.h>
>  #include <linux/hwmon.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> @@ -254,46 +255,52 @@ static int i8k_smm(struct smm_regs *regs)
>  /*
>   * Read the fan status.
>   */
> -static int i8k_get_fan_status(const struct dell_smm_data *data, int fan)
> +static int i8k_get_fan_status(const struct dell_smm_data *data, u8 fan)
>  {
> -	struct smm_regs regs = { .eax = I8K_SMM_GET_FAN, };
> +	struct smm_regs regs = {
> +		.eax = I8K_SMM_GET_FAN,
> +		.ebx = fan,
> +	};
> 
>  	if (data->disallow_fan_support)
>  		return -EINVAL;
> 
> -	regs.ebx = fan & 0xff;
>  	return i8k_smm(&regs) ? : regs.eax & 0xff;
>  }
> 
>  /*
>   * Read the fan speed in RPM.
>   */
> -static int i8k_get_fan_speed(const struct dell_smm_data *data, int fan)
> +static int i8k_get_fan_speed(const struct dell_smm_data *data, u8 fan)
>  {
> -	struct smm_regs regs = { .eax = I8K_SMM_GET_SPEED, };
> +	struct smm_regs regs = {
> +		.eax = I8K_SMM_GET_SPEED,
> +		.ebx = fan,
> +	};
> 
>  	if (data->disallow_fan_support)
>  		return -EINVAL;
> 
> -	regs.ebx = fan & 0xff;
>  	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * data->i8k_fan_mult;
>  }
> 
>  /*
>   * Read the fan type.
>   */
> -static int _i8k_get_fan_type(const struct dell_smm_data *data, int fan)
> +static int _i8k_get_fan_type(const struct dell_smm_data *data, u8 fan)
>  {
> -	struct smm_regs regs = { .eax = I8K_SMM_GET_FAN_TYPE, };
> +	struct smm_regs regs = {
> +		.eax = I8K_SMM_GET_FAN_TYPE,
> +		.ebx = fan,
> +	};
> 
>  	if (data->disallow_fan_support || data->disallow_fan_type_call)
>  		return -EINVAL;
> 
> -	regs.ebx = fan & 0xff;
>  	return i8k_smm(&regs) ? : regs.eax & 0xff;
>  }
> 
> -static int i8k_get_fan_type(struct dell_smm_data *data, int fan)
> +static int i8k_get_fan_type(struct dell_smm_data *data, u8 fan)
>  {
>  	/* I8K_SMM_GET_FAN_TYPE SMM call is expensive, so cache values */
>  	if (data->fan_type[fan] == INT_MIN)
> @@ -305,14 +312,16 @@ static int i8k_get_fan_type(struct dell_smm_data *data, int fan)
>  /*
>   * Read the fan nominal rpm for specific fan speed.
>   */
> -static int __init i8k_get_fan_nominal_speed(const struct dell_smm_data *data, int fan, int speed)
> +static int __init i8k_get_fan_nominal_speed(const struct dell_smm_data *data, u8 fan, int speed)
>  {
> -	struct smm_regs regs = { .eax = I8K_SMM_GET_NOM_SPEED, };
> +	struct smm_regs regs = {
> +		.eax = I8K_SMM_GET_NOM_SPEED,
> +		.ebx = fan | (speed << 8),
> +	};
> 
>  	if (data->disallow_fan_support)
>  		return -EINVAL;
> 
> -	regs.ebx = (fan & 0xff) | (speed << 8);
>  	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * data->i8k_fan_mult;
>  }
> 
> @@ -333,7 +342,7 @@ static int i8k_enable_fan_auto_mode(const struct dell_smm_data *data, bool enabl
>  /*
>   * Set the fan speed (off, low, high, ...).
>   */
> -static int i8k_set_fan(const struct dell_smm_data *data, int fan, int speed)
> +static int i8k_set_fan(const struct dell_smm_data *data, u8 fan, int speed)
>  {
>  	struct smm_regs regs = { .eax = I8K_SMM_SET_FAN, };
> 
> @@ -341,33 +350,35 @@ static int i8k_set_fan(const struct dell_smm_data *data, int fan, int speed)
>  		return -EINVAL;
> 
>  	speed = (speed < 0) ? 0 : ((speed > data->i8k_fan_max) ? data->i8k_fan_max : speed);
> -	regs.ebx = (fan & 0xff) | (speed << 8);
> +	regs.ebx = fan | (speed << 8);
> 
>  	return i8k_smm(&regs);
>  }
> 
> -static int __init i8k_get_temp_type(int sensor)
> +static int __init i8k_get_temp_type(u8 sensor)
>  {
> -	struct smm_regs regs = { .eax = I8K_SMM_GET_TEMP_TYPE, };
> +	struct smm_regs regs = {
> +		.eax = I8K_SMM_GET_TEMP_TYPE,
> +		.ebx = sensor,
> +	};
> 
> -	regs.ebx = sensor & 0xff;
>  	return i8k_smm(&regs) ? : regs.eax & 0xff;
>  }
> 
>  /*
>   * Read the cpu temperature.
>   */
> -static int _i8k_get_temp(int sensor)
> +static int _i8k_get_temp(u8 sensor)
>  {
>  	struct smm_regs regs = {
>  		.eax = I8K_SMM_GET_TEMP,
> -		.ebx = sensor & 0xff,
> +		.ebx = sensor,
>  	};
> 
>  	return i8k_smm(&regs) ? : regs.eax & 0xff;
>  }
> 
> -static int i8k_get_temp(int sensor)
> +static int i8k_get_temp(u8 sensor)
>  {
>  	int temp = _i8k_get_temp(sensor);
> 
> @@ -500,6 +511,9 @@ static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
>  		if (copy_from_user(&val, argp, sizeof(int)))
>  			return -EFAULT;
> 
> +		if (val > U8_MAX || val < 0)
> +			return -EINVAL;
> +
>  		val = i8k_get_fan_speed(data, val);
>  		break;
> 
> @@ -507,6 +521,9 @@ static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
>  		if (copy_from_user(&val, argp, sizeof(int)))
>  			return -EFAULT;
> 
> +		if (val > U8_MAX || val < 0)
> +			return -EINVAL;
> +
>  		val = i8k_get_fan_status(data, val);
>  		break;
> 
> @@ -517,6 +534,9 @@ static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
>  		if (copy_from_user(&val, argp, sizeof(int)))
>  			return -EFAULT;
> 
> +		if (val > U8_MAX || val < 0)
> +			return -EINVAL;
> +
>  		if (copy_from_user(&speed, argp + 1, sizeof(int)))
>  			return -EFAULT;
> 
> @@ -924,7 +944,8 @@ static int __init dell_smm_init_hwmon(struct device *dev)
>  {
>  	struct dell_smm_data *data = dev_get_drvdata(dev);
>  	struct device *dell_smm_hwmon_dev;
> -	int i, state, err;
> +	int state, err;
> +	u8 i;
> 
>  	for (i = 0; i < DELL_SMM_NO_TEMP; i++) {
>  		data->temp_type[i] = i8k_get_temp_type(i);
> @@ -1245,7 +1266,8 @@ static int __init dell_smm_probe(struct platform_device *pdev)
>  {
>  	struct dell_smm_data *data;
>  	const struct dmi_system_id *id, *fan_control;
> -	int fan, ret;
> +	int ret;
> +	u8 fan;
> 
>  	data = devm_kzalloc(&pdev->dev, sizeof(struct dell_smm_data), GFP_KERNEL);
>  	if (!data)
