Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4053DD6A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbiFERna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiFERn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:43:29 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43024F20;
        Sun,  5 Jun 2022 10:43:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p129so12354603oig.3;
        Sun, 05 Jun 2022 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=syz+aq4yQ+d29HeNVzlXwYRjc0RSf1w//KCrHFy1UjI=;
        b=HKd6XhDFPatoPUjbIKd0NbbWS1cAIibhPK8VWoKf684+ughd317JXWN2kkUr11y4B/
         cNqeL0S5FbwNQRWZWec5AqILzz3hBOW84Voi0F3OW/P/jUHx8+xp1Fgat9c/U9352KVD
         qU8qgVe8dtwY4si9yfE7o/2KqGMIebAEGmjgFsmFNgKoGkn0d8eihrn75cXPLZ95C9C4
         V8UMqNvixUJOxSzKWhiCARZYbFvx/jgq8EsO1nKWTY6jqZye+h1xUaNsxAqEpcKWUlCJ
         E3NzTiUQ+T6XulEQvObcx37+OGxONgiauvN3MbolMYhspOEFb8ioWD0vi5y4Chxs7wGu
         fgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=syz+aq4yQ+d29HeNVzlXwYRjc0RSf1w//KCrHFy1UjI=;
        b=K7VKETSJ1nw/Boo1POwMgoJAVm4VT1eD7qfBtB5RsyK567On3Caz+sxeyTaWHUSMA2
         TFaEJAYbkKhKN6K7KCHhojrJeVWgcKyfBWUO7+pXCghSixGQOtZ61jCejMGK0hoT4JZp
         Bg1I3Kb90ug9gztHNWQgEfY7BQ/i6WfnbQ+Cbbky8nke+vsIidY3QfUQJZVdFSHqK5bH
         lU3bF99z+9H6l++JEpJhLU0Qgs2YZSHH6H4oP3spCztV74qZRut0k35sV11V++2u782X
         Vp/QaJRF54BxG7Sa3bhOzDU8MUmrPRWBJyUonB7AV3Q1ST/trMvKN7zI8q7F6DJqWptm
         dznQ==
X-Gm-Message-State: AOAM532JhFIYlbRxpbkSfcy+nsFnUdrfnZvyqURxhcMn3mzzzCZ1VbzZ
        4jcE+c2z/+gTQxADXsspu14=
X-Google-Smtp-Source: ABdhPJwP1nsRbiB0ogi7pXgVYCtRkB3jEbilYUZHM5g8g8oe1K684F01JBpMxdO04dKrrB3HsJcAKw==
X-Received: by 2002:a05:6808:23c8:b0:32e:53b0:56a0 with SMTP id bq8-20020a05680823c800b0032e53b056a0mr7513732oib.99.1654451008398;
        Sun, 05 Jun 2022 10:43:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m34-20020a056870562200b000f33624baa4sm6000285oao.18.2022.06.05.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 10:43:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 5 Jun 2022 10:43:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Shady Nawara <shady.nawara@outlook.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add support for Strix Z690-a D4
Message-ID: <20220605174326.GA3144889@roeck-us.net>
References: <20220603122758.1561064-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603122758.1561064-1-eugene.shalygin@gmail.com>
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

On Fri, Jun 03, 2022 at 02:27:58PM +0200, Eugene Shalygin wrote:
> From: Shady Nawara <shady.nawara@outlook.com>
> 
> adds T_Sensor and VRM Temp sensors for the Asus Strix z690-a D4 motherboard
> 
> Signed-off-by: Shady Nawara <shady.nawara@outlook.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/asus_ec_sensors.rst |  1 +
>  drivers/hwmon/asus-ec-sensors.c         | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index 78ca69eda877..00d8c46ef9e0 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -19,6 +19,7 @@ Supported boards:
>   * ROG STRIX X570-E GAMING WIFI II
>   * ROG STRIX X570-F GAMING
>   * ROG STRIX X570-I GAMING
> + * ROG STRIX Z690-A GAMING WIFI D4
>  
>  Authors:
>      - Eugene Shalygin <eugene.shalygin@gmail.com>
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 57e11b2bab74..886a71b4c64e 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -54,6 +54,8 @@ static char *mutex_path_override;
>  /* ACPI mutex for locking access to the EC for the firmware */
>  #define ASUS_HW_ACCESS_MUTEX_ASMX	"\\AMW0.ASMX"
>  
> +#define ASUS_HW_ACCESS_MUTEX_RMTW_ASMX	"\\RMTW.ASMX"
> +
>  #define MAX_IDENTICAL_BOARD_VARIATIONS	3
>  
>  /* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
> @@ -139,6 +141,7 @@ enum board_family {
>  	family_unknown,
>  	family_amd_400_series,
>  	family_amd_500_series,
> +	family_intel_600_series
>  };
>  
>  /* All the known sensors for ASUS EC controllers */
> @@ -197,6 +200,12 @@ static const struct ec_sensor_info sensors_family_amd_500[] = {
>  		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
>  };
>  
> +static const struct ec_sensor_info sensors_family_intel_600[] = {
> +	[ec_sensor_temp_t_sensor] =
> +		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
> +	[ec_sensor_temp_vrm] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
> +};
> +
>  /* Shortcuts for common combinations */
>  #define SENSOR_SET_TEMP_CHIPSET_CPU_MB                                         \
>  	(SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_MB)
> @@ -330,6 +339,12 @@ static const struct ec_board_info board_info[] = {
>  		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>  		.family = family_amd_500_series,
>  	},
> +	{
> +		.board_names = {"ROG STRIX Z690-A GAMING WIFI D4"},
> +		.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
> +		.family = family_intel_600_series,
> +	},
>  	{}
>  };
>  
> @@ -799,6 +814,9 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>  	case family_amd_500_series:
>  		ec_data->sensors_info = sensors_family_amd_500;
>  		break;
> +	case family_intel_600_series:
> +		ec_data->sensors_info = sensors_family_intel_600;
> +		break;
>  	default:
>  		dev_err(dev, "Unknown board family: %d",
>  			ec_data->board_info->family);
