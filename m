Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9E4B7682
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbiBOTiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:38:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiBOTiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:38:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414C9627D;
        Tue, 15 Feb 2022 11:37:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7091FB81BE4;
        Tue, 15 Feb 2022 19:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD099C340EB;
        Tue, 15 Feb 2022 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953867;
        bh=u5Q7TysgiABO3PGXeNAE+IzNlfP0uAbXnbfmkzC94zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9yFTdediVIWwyRutFDlHJg8aVVgNvPfleRB+SfdsZAwVVuu01gQXZUCOjJ66HYb8
         4WUViBK8nPWBV+DO7KJo1hbqrRbyE/GW1+g54+V74v2baLQGqlV3mNtF8If9/+k9by
         yO6nGP4UUgknqdBD2dilEzq/Z9L4BwaIFTc3ry56/Xf+5FxbSvM/F43PIdeJHIvJf7
         AH3ViUsJDoPP/Ov1kmxsYULlMpBtw7XksbfviT62adSApnhb5e0USWX5dTE8yuHGeG
         XpjXZKzp393hKTVyGo1J66/PB7txcaODk9Twxgo6uhoKc75Dbs+V/AEVSRFjSoAJ0v
         i2PkoEhAkWx4w==
Received: by pali.im (Postfix)
        id 77405F13; Tue, 15 Feb 2022 20:37:44 +0100 (CET)
Date:   Tue, 15 Feb 2022 20:37:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] hwmon: (dell-smm) Make fan/temp sensor number a u8
Message-ID: <20220215193744.vujcuuc3l52unvxf@pali>
References: <20220215191113.16640-1-W_Armin@gmx.de>
 <20220215191113.16640-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215191113.16640-4-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2022 20:11:09 Armin Wolf wrote:
> Right now, we only use bits 0 to 7 of the fan/temp sensor number
> by doing number & 0xff. Passing the value as a u8 makes this
> step unnecessary. Also add checks to the ioctl handler since
> users might get confused when passing 0x00000101 does the same
> as passing 0x00000001.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 68 ++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 23 deletions(-)
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
> --
> 2.30.2
> 
