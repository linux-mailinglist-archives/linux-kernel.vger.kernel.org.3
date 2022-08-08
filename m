Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E8458CE9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiHHThS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHHThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:37:17 -0400
X-Greylist: delayed 156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 12:37:15 PDT
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.18.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D98913DEF;
        Mon,  8 Aug 2022 12:37:15 -0700 (PDT)
Received: from [109.90.180.58] (helo=[192.168.1.27])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <peter@piie.net>)
        id 1oL8WY-0006MF-26; Mon, 08 Aug 2022 21:34:50 +0200
Message-ID: <fdaba367-c657-0d85-7244-918b99569337@piie.net>
Date:   Mon, 8 Aug 2022 21:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 23/26] thermal/drivers/acerhdf: Use generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
 <20220805145729.2491611-24-daniel.lezcano@linaro.org>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter@piie.net>
In-Reply-To: <20220805145729.2491611-24-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Df-Sender: cGV0ZXJAcGlpZS5uZXQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

some comments.  Please merge if those are considered.  Thanks.


On 05.08.22 16:57, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Peter Kästle <peter@piie.net>

> ---
>   drivers/platform/x86/acerhdf.c | 73 ++++++++++++----------------------
>   1 file changed, 26 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 3463629f8764..cf757f3a1e6b 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c

[...]

> @@ -137,6 +139,15 @@ struct ctrl_settings {
>   	int mcmd_enable;
>   };
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
>   static struct ctrl_settings ctrl_cfg __read_mostly;
>   
>   /* Register addresses and values for different BIOS versions */
> @@ -326,6 +337,15 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
>   		fanon = ACERHDF_MAX_FANON;
>   	}
>   
> +	if (fanon < fanoff) {
> +		pr_err("fanoff temperature (%d) is above fanon temperature (%d), clamping to %d\n",
> +		       fanoff, fanon, fanon);
> +		fanoff = fanon;
> +	};
> +	

Tab whitespace, please remove.

> +	trips[0].temperature = fanon;
> +	trips[0].hysteresis  = fanon - fanoff;
> +	

Tab whitespace, please remove

>   	if (kernelmode && prev_interval != interval) {
>   		if (interval > ACERHDF_MAX_INTERVAL) {
>   			pr_err("interval too high, set to %d\n",

I don't know the current behavior of the thermal layer well enough.
Is it ensured, that those new trips[0].temperature / trips[0].hysteresis 
values are taken into account?


-- 
best regards,
--peter;
