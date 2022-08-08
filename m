Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A458CAD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243151AbiHHO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbiHHO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E9F7DEA3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659970588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q81adJEOTwFc/hg5uP+tJ9s7aedbQ4D0T6kDguRSfeM=;
        b=bafJu1Q+hIRQnmx4tsWb0Cd3eEGxT8c8hdBvggZco2LaFTmBR4JXTog7H8BreOB0P2jJx4
        ls1w7m3eJ7TogQq2PtjNShZXjyqqY9UPxl2e9ZzH1ygtfVuXlPGUwfgATC2TFgPAjy0ImA
        FEuWBhgRD+H0N6a5RKlJb9vM5Bca7Qw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-xFodAKb9OHCoi9CWOfoHLA-1; Mon, 08 Aug 2022 10:56:27 -0400
X-MC-Unique: xFodAKb9OHCoi9CWOfoHLA-1
Received: by mail-ed1-f72.google.com with SMTP id v19-20020a056402349300b0043d42b7ddefso5729196edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Q81adJEOTwFc/hg5uP+tJ9s7aedbQ4D0T6kDguRSfeM=;
        b=fJZErBGcPHwMT9PGqhuwedIo7wMivgdRPHd+c3fDiiEesHNbUeJxqA3PRNnYfsxnQm
         z8eUs0pV4ZssaSOxaX3PrzwLt9In3CGuqw0kzPn4J5PsbEq0Sx4XWMK80QbnonDseSZz
         9OC4fbCaWON8Q0JRKzXv4GAB6TLuJqCH3V0SCVA0qFQUD3rlkTV95HFqYibzSf2qXWsk
         qncNAu8rtYRx3PGS2h3r+Nkl4leSgRBsvEg4AjzIwPZt3iAtc8D8jN6/L6ZTQzJVlDHs
         9iq0LaHBEjga5MtIGFJtkbQmBKiFXEhJJqcAv6j2+xoQQ04M68MocuJVhmCh0HoafaEL
         OsjQ==
X-Gm-Message-State: ACgBeo0WRzQRsICVXZP4khgbkynNH3PC0oplsdYeqZYxcB5/jtcijJvT
        084zoItzCP7xYZWOr+kG9b5pcY/qiKKFegvFNgCoTO+nGnI7BImN3IZXLETAscs04YFSx0r/t1Z
        ESBk06gznhwX5VL6/M2mofkvi
X-Received: by 2002:a17:907:6096:b0:72f:1d74:b71b with SMTP id ht22-20020a170907609600b0072f1d74b71bmr13975056ejc.272.1659970586180;
        Mon, 08 Aug 2022 07:56:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6iE1RlTukWMvsEMA1thEekevbdE2HkKHb8PUGj3hcIsyNE8ALGkMyoQeJyjqpaCrXoUhlvEw==
X-Received: by 2002:a17:907:6096:b0:72f:1d74:b71b with SMTP id ht22-20020a170907609600b0072f1d74b71bmr13975042ejc.272.1659970585913;
        Mon, 08 Aug 2022 07:56:25 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id u19-20020aa7db93000000b0043bbb3535d6sm4656016edt.66.2022.08.08.07.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 07:56:25 -0700 (PDT)
Message-ID: <67bf0109-0606-a44c-7a58-606101bdb52d@redhat.com>
Date:   Mon, 8 Aug 2022 16:56:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 23/26] thermal/drivers/acerhdf: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Kaestle <peter@piie.net>,
        Mark Gross <markgross@kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
 <20220805145729.2491611-24-daniel.lezcano@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220805145729.2491611-24-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/5/22 16:57, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks, patch looks good to me, feel free to merge this
through the thermal tree together with the rest of the series:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/x86/acerhdf.c | 73 ++++++++++++----------------------
>  1 file changed, 26 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 3463629f8764..cf757f3a1e6b 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -46,6 +46,8 @@
>   * measured by the on-die thermal monitor are within 0 <= Tj <= 90. So,
>   * assume 89°C is critical temperature.
>   */
> +#define ACERHDF_DEFAULT_TEMP_FANON 60000
> +#define ACERHDF_DEFAULT_TEMP_FANOFF 53000
>  #define ACERHDF_TEMP_CRIT 89000
>  #define ACERHDF_FAN_OFF 0
>  #define ACERHDF_FAN_AUTO 1
> @@ -70,8 +72,8 @@ static int kernelmode;
>  #endif
>  
>  static unsigned int interval = 10;
> -static unsigned int fanon = 60000;
> -static unsigned int fanoff = 53000;
> +static unsigned int fanon = ACERHDF_DEFAULT_TEMP_FANON;
> +static unsigned int fanoff = ACERHDF_DEFAULT_TEMP_FANOFF;
>  static unsigned int verbose;
>  static unsigned int list_supported;
>  static unsigned int fanstate = ACERHDF_FAN_AUTO;
> @@ -137,6 +139,15 @@ struct ctrl_settings {
>  	int mcmd_enable;
>  };
>  
> +static struct thermal_trip trips[] = {
> +	[0] = { .temperature = ACERHDF_DEFAULT_TEMP_FANON,
> +		.hysteresis = ACERHDF_DEFAULT_TEMP_FANON - ACERHDF_DEFAULT_TEMP_FANOFF,
> +		.type = THERMAL_TRIP_ACTIVE },
> +
> +	[1] = { .temperature = ACERHDF_TEMP_CRIT,
> +		.type = THERMAL_TRIP_CRITICAL }
> +};
> +
>  static struct ctrl_settings ctrl_cfg __read_mostly;
>  
>  /* Register addresses and values for different BIOS versions */
> @@ -326,6 +337,15 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
>  		fanon = ACERHDF_MAX_FANON;
>  	}
>  
> +	if (fanon < fanoff) {
> +		pr_err("fanoff temperature (%d) is above fanon temperature (%d), clamping to %d\n",
> +		       fanoff, fanon, fanon);
> +		fanoff = fanon;
> +	};
> +	
> +	trips[0].temperature = fanon;
> +	trips[0].hysteresis  = fanon - fanoff;
> +	
>  	if (kernelmode && prev_interval != interval) {
>  		if (interval > ACERHDF_MAX_INTERVAL) {
>  			pr_err("interval too high, set to %d\n",
> @@ -424,43 +444,6 @@ static int acerhdf_change_mode(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  
> -static int acerhdf_get_trip_type(struct thermal_zone_device *thermal, int trip,
> -				 enum thermal_trip_type *type)
> -{
> -	if (trip == 0)
> -		*type = THERMAL_TRIP_ACTIVE;
> -	else if (trip == 1)
> -		*type = THERMAL_TRIP_CRITICAL;
> -	else
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static int acerhdf_get_trip_hyst(struct thermal_zone_device *thermal, int trip,
> -				 int *temp)
> -{
> -	if (trip != 0)
> -		return -EINVAL;
> -
> -	*temp = fanon - fanoff;
> -
> -	return 0;
> -}
> -
> -static int acerhdf_get_trip_temp(struct thermal_zone_device *thermal, int trip,
> -				 int *temp)
> -{
> -	if (trip == 0)
> -		*temp = fanon;
> -	else if (trip == 1)
> -		*temp = ACERHDF_TEMP_CRIT;
> -	else
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
>  				 int *temperature)
>  {
> @@ -474,13 +457,9 @@ static struct thermal_zone_device_ops acerhdf_dev_ops = {
>  	.unbind = acerhdf_unbind,
>  	.get_temp = acerhdf_get_ec_temp,
>  	.change_mode = acerhdf_change_mode,
> -	.get_trip_type = acerhdf_get_trip_type,
> -	.get_trip_hyst = acerhdf_get_trip_hyst,
> -	.get_trip_temp = acerhdf_get_trip_temp,
>  	.get_crit_temp = acerhdf_get_crit_temp,
>  };
>  
> -
>  /*
>   * cooling device callback functions
>   * get maximal fan cooling state
> @@ -710,10 +689,10 @@ static int __init acerhdf_register_thermal(void)
>  	if (IS_ERR(cl_dev))
>  		return -EINVAL;
>  
> -	thz_dev = thermal_zone_device_register("acerhdf", 2, 0, NULL,
> -					      &acerhdf_dev_ops,
> -					      &acerhdf_zone_params, 0,
> -					      (kernelmode) ? interval*1000 : 0);
> +	thz_dev = thermal_zone_device_register_with_trips("acerhdf", trips, ARRAY_SIZE(trips),
> +							  0, NULL, &acerhdf_dev_ops,
> +							  &acerhdf_zone_params, 0,
> +							  (kernelmode) ? interval*1000 : 0);
>  	if (IS_ERR(thz_dev))
>  		return -EINVAL;
>  

