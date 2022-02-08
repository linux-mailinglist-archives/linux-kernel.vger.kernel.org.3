Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9184AE56E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiBHXax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiBHXaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:30:52 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA31C061576;
        Tue,  8 Feb 2022 15:30:51 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s24so760712oic.6;
        Tue, 08 Feb 2022 15:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kRP2HNPEgA51ktTqz6c5mvV5tDkfXVjA3Z29dovDE7o=;
        b=hhkcVGxHalmedmzlxc9moGRICBzJ+DZGGsKBwoIh5kcr2r8GF4HMTfmbOoaBffVKQx
         8dsgynO2Go9iyfGpslfHDZjOelqq40tYA++bPS3SZN0vASrld9MK5BFySX6jJCJrZXGd
         H0ieTVx56US1ZG9dxVgV3I5YjlKA6qMrqoll62h+hvKBI6kJCzz9uYAK60wuedADnHGB
         H3XIeomV0fA+Fq/a4Qdu/T2ugeZjn4+FXqrfiv6MlghHDU/cJyYVTWgPfCJJGxwDjPK0
         /ckgyitDp+lAkjeDHGdv5s37uNCBDeA5dDZOqoSYV2dHcor4Dfzxoxddg5rLfgtgQdtl
         wfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=kRP2HNPEgA51ktTqz6c5mvV5tDkfXVjA3Z29dovDE7o=;
        b=SVM8Hizo+cNVJ9m2psmFHTs3d7xMt7SMX7UHpd4uHS0RdJzYSHSNdKAYFZt99mbuyW
         hhl+ZZzjfMaj9Y+mpSNPHkDyYD/1Uf++XrZ5m33uxjhpZm5MelCv3NO8TkLW2gSVLai+
         i73+yJSims6rcHP4Ug4kWqHVa5dDD5snNnkKQ2Ygczv9nOe35xKit9W4OYtZ9gjDh+3Q
         +qDee3tWc0GIEqhjN0hQOgTvgOLaH/w5yDgApPNwyS1bQ+AR1fMv6GDVav50RbaxCCxA
         57IU3oym8xXUfFWJvH81+UB6ewoVwKLTWYqrUCgav5jUJKM2eg2eh5XK0CatpJrkgMka
         I45w==
X-Gm-Message-State: AOAM532vB2XowVa/4A9B75I0LsfzMXPij9NEgZeL3E38R2ccz9I7ROwx
        KD7zL6RYu5tJArCj9Xg3QluiEyixcqT4nA==
X-Google-Smtp-Source: ABdhPJxY6sbMwmNC2tVHyAY9AZ4CM+WN/QDogSNoZ6CiKTcRqAjmiieT8YOGi06vx5FHmCcQ33dc2A==
X-Received: by 2002:a05:6808:1899:: with SMTP id bi25mr175916oib.38.1644363050765;
        Tue, 08 Feb 2022 15:30:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1sm6652731oad.38.2022.02.08.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:30:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 8 Feb 2022 15:30:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add CPU core voltage
Message-ID: <20220208233048.GA2970774@roeck-us.net>
References: <20220208094244.1106312-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208094244.1106312-1-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:42:43AM +0100, Eugene Shalygin wrote:
> A user discovered [1] the CPU Core voltage sensor, which spans 2
> registers and provides output in mV. Althroug the discovery was made
> with a X470 chipset, the sensor is present in X570 (tested with C8H).
> For now simply add it to each board with the CPU current sensor present.
> 
> [1] https://github.com/zeule/asus-ec-sensors/issues/12
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Tested-by: Denis Pauk <pauk.denis@gmail.com>


Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/asus_ec_sensors.rst |  1 +
>  drivers/hwmon/asus-ec-sensors.c         | 29 ++++++++++++++++---------
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index 22de1b037cfb..e7e8f1640f45 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -39,6 +39,7 @@ The driver is aware of and reads the following sensors:
>  9. Readings from the "Water flow meter" header (RPM)
>  10. Readings from the "Water In" and "Water Out" temperature headers
>  11. CPU current
> +12. CPU core voltage
>  
>  Sensor values are read from EC registers, and to avoid race with the board
>  firmware the driver acquires ACPI mutex, the one used by the WMI when its
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index dd7b207d062f..bfac08a5dc57 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -18,6 +18,7 @@
>   * - VRM Heat Sink fan RPM
>   * - Water Flow fan RPM
>   * - CPU current
> + * - CPU core voltage
>   */
>  
>  #include <linux/acpi.h>
> @@ -100,6 +101,8 @@ enum ec_sensors {
>  	ec_sensor_temp_t_sensor,
>  	/* VRM temperature [℃] */
>  	ec_sensor_temp_vrm,
> +	/* CPU Core voltage [mV] */
> +	ec_sensor_in_cpu_core,
>  	/* CPU_Opt fan [RPM] */
>  	ec_sensor_fan_cpu_opt,
>  	/* VRM heat sink fan [RPM] */
> @@ -121,6 +124,7 @@ enum ec_sensors {
>  #define SENSOR_TEMP_MB BIT(ec_sensor_temp_mb)
>  #define SENSOR_TEMP_T_SENSOR BIT(ec_sensor_temp_t_sensor)
>  #define SENSOR_TEMP_VRM BIT(ec_sensor_temp_vrm)
> +#define SENSOR_IN_CPU_CORE BIT(ec_sensor_in_cpu_core)
>  #define SENSOR_FAN_CPU_OPT BIT(ec_sensor_fan_cpu_opt)
>  #define SENSOR_FAN_VRM_HS BIT(ec_sensor_fan_vrm_hs)
>  #define SENSOR_FAN_CHIPSET BIT(ec_sensor_fan_chipset)
> @@ -139,6 +143,8 @@ static const struct ec_sensor_info known_ec_sensors[] = {
>  	[ec_sensor_temp_t_sensor] =
>  		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
>  	[ec_sensor_temp_vrm] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
> +	[ec_sensor_in_cpu_core] =
> +		EC_SENSOR("CPU Core", hwmon_in, 2, 0x00, 0xa2),
>  	[ec_sensor_fan_cpu_opt] =
>  		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
>  	[ec_sensor_fan_vrm_hs] = EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2),
> @@ -172,32 +178,34 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "Pro WS X570-ACE",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
> -		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> +		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII DARK HERO",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
>  		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> -		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> +		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII FORMULA",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
>  		SENSOR_TEMP_VRM | SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_CURR_CPU),
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG CROSSHAIR VIII HERO",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
>  		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
>  		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> +		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII HERO (WI-FI)",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
>  		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
>  		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> -		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> +		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII IMPACT",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> +		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-E GAMING",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>  		SENSOR_TEMP_T_SENSOR |
> @@ -205,17 +213,19 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX B550-I GAMING",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>  		SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS | SENSOR_CURR_CPU),
> +		SENSOR_TEMP_VRM | SENSOR_FAN_VRM_HS |
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-E GAMING",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>  		SENSOR_TEMP_T_SENSOR |
> -		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> +		SENSOR_TEMP_VRM | SENSOR_FAN_CHIPSET |
> +		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-F GAMING",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB |
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-I GAMING",
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> -		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),
> +		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE),
>  	{}
>  };
>  
> @@ -467,7 +477,6 @@ static long scale_sensor_value(s32 value, int data_type)
>  	switch (data_type) {
>  	case hwmon_curr:
>  	case hwmon_temp:
> -	case hwmon_in:
>  		return value * MILLI;
>  	default:
>  		return value;
