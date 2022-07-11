Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BD156D719
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiGKHwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGKHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:52:22 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C1C1C922;
        Mon, 11 Jul 2022 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=7zyLGVcEIyQkC+gl1zpwEzMAKU5QvqQXdssCJTKoXVE=; b=WL1SOL694htlJ6V9kixrsLc3+l
        nkMyBDfR9rX8pFnBzj16yzkxbOI5mDNEA88W49Rrh6H2+wX+1oe4XuFX5PqFpvZcoB05p64TvrQDq
        LDQKKyhQa060vAMecHWOLaP1r64sTnAp4dL4iyIYKJ/scUwMl6LNarizhLn5+fkMOLvBa+DdPT4qn
        MIGoJ60RTFIHjRnRvLvl7xgT0ab2CccVoO6Onov7mlznOlUjAyDsE7X5WRdx+35jeu+C7RtF6Cy8M
        FpSYfp13IEh8x5zctziqSeDc/dl3Y3f8pQKLDMdgMgqAsOpLS6dBgNGAdbPKWVthzOPg/1neSg143
        hUewiJbg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1oAoDA-000Cc6-7p; Mon, 11 Jul 2022 09:52:08 +0200
Received: from [2001:a61:2a49:8301:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1oAoD9-000551-Rv; Mon, 11 Jul 2022 09:52:07 +0200
Message-ID: <6b81cb4d-4080-188d-df7c-1529e55ddf7f@metafoo.de>
Date:   Mon, 11 Jul 2022 09:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 27/33] iio/drivers/sun4i_gpadc: Switch to new of
 thermal API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-28-daniel.lezcano@linexp.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220710212423.681301-28-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26597/Sun Jul 10 09:56:43 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 23:24, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach.
>
> Use this new API.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 2d393a4dfff6..7aebfd337871 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -412,9 +412,9 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
>   	return 0;
>   }
>   
> -static int sun4i_gpadc_get_temp(void *data, int *temp)
> +static int sun4i_gpadc_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
> -	struct sun4i_gpadc_iio *info = data;
> +	struct sun4i_gpadc_iio *info = tz->devdata;
>   	int val, scale, offset;
>   
>   	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
> @@ -428,7 +428,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
>   	return 0;
>   }
>   
> -static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
> +static struct thermal_zone_device_ops sun4i_ts_tz_ops = {
>   	.get_temp = &sun4i_gpadc_get_temp,
>   };
Why is the const removed? If the framework modifies the structure you 
need a per device copy of the struct.
>   
> @@ -637,9 +637,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>   	pm_runtime_enable(&pdev->dev);
>   
>   	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> -		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
> -							    0, info,
> -							    &sun4i_ts_tz_ops);
> +		info->tzd = thermal_of_zone_register(info->sensor_device,
> +						     0, info,
> +						     &sun4i_ts_tz_ops);
>   		/*
>   		 * Do not fail driver probing when failing to register in
>   		 * thermal because no thermal DT node is found.


