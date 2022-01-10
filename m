Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7CF489EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiAJRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiAJRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:55:31 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:55:31 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id f9so14459747qtk.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OPxLFOIrpoh4nUbYG2apHuVRt5Z2LQbPaOlOMgIRdT0=;
        b=x+wlq7/2QJoYQN8uElQpdlrB8Z+Gs7ujr9BS1xq4RU2Begqpgl2J/+1dIitEVyJ32N
         fiylYY6Ka/2CNv+nqQEizBSk5QwMBq27GUCIOQ69cXkTqcfx9MQIGfCaGssrE9v/kchZ
         MItNd+qeV+9x6wzar6ZxXvuXfH5MdeS66sD62Pp1pHgRWe5inh20gIrIrvEefDQEhSvn
         cm3vnSMNMMnRjrdFH78RaaHo1Fb6f0Ls4ghOBUg3eImCa3pxF+5xLQA5JTtdoOStvJSp
         Z0U064YQ7VFWfxNZhdQnsiD6vwpwjtPzisQU8YfAZA2ld3g9gSBCjMg4WsLWVN+olBy9
         5H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OPxLFOIrpoh4nUbYG2apHuVRt5Z2LQbPaOlOMgIRdT0=;
        b=xmzOxloF7Odp2O83rkR1oalxiz6qRQv64ku+sA1K/ur+YkM6ROv2XDC2iG743Vhzau
         Hr28icBG2nmIDr8+pnkQvXqgnNwjF92QlrNIYluc/0Pc99G/4aD3lNlwiLH9+g63emNO
         JyZeUp3myrap4WNhqSXJLbQCXT1WtbXOFSOimNq9L069LTbuHiepHOMCL1G7L+s7MfW5
         s1/D6Zcq44SNtN3PznxuAxwhZO7BZBM0o2KiKoChKcXPm23wpk5ZPjrifUkIwhMCLbOI
         vD5t+Eg1Kvrnf7wCl23fTka8CPw+4XyZz2Vw8xL+gHkkVq6c8XJvoX/dNdbZfP7gs0IW
         IdIA==
X-Gm-Message-State: AOAM5308lVUOTWGNm+jTVBP6EZYRZM9aFqAq4gdGLAETGX6HlgZJ3pG6
        VXJ8N19Zhq4cr2V3OAfdJvy7sFzr2nyvUQ==
X-Google-Smtp-Source: ABdhPJw5wvb7OIGKy3+SoJSgtMVVjrlmIQyxa5s8brLBA/XIh9bwCmkYEK7NSRv0NdpCuvXqRCMAfw==
X-Received: by 2002:ac8:5809:: with SMTP id g9mr743740qtg.312.1641837329670;
        Mon, 10 Jan 2022 09:55:29 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id bj26sm4795667qkb.58.2022.01.10.09.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:55:28 -0800 (PST)
Subject: Re: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>, thara.gopinath@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <cf34f77e-587b-7f97-619f-dcbf431332ff@linaro.org>
Date:   Mon, 10 Jan 2022 12:55:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manaf,

On 1/7/22 1:56 PM, Manaf Meethalavalappu Pallikunhi wrote:
> Whenever a thermal zone is in trip violated state, there is a chance
> that the same thermal zone mode can be disabled either via thermal
> core API or via thermal zone sysfs. Once it is disabled, the framework
> bails out any re-evaluation of thermal zone. It leads to a case where
> if it is already in mitigation state, it will stay the same state
> until it is re-enabled.
> 
> To avoid above mentioned issue, on thermal zone disable request
> reset thermal zone and clear mitigation for each trip explicitly.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>   drivers/thermal/thermal_core.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 51374f4..e288c82 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -447,10 +447,18 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>   
>   	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   
> -	if (mode == THERMAL_DEVICE_ENABLED)
> +	if (mode == THERMAL_DEVICE_ENABLED) {
>   		thermal_notify_tz_enable(tz->id);
> -	else
> +	} else {
> +		int trip;
> +
> +		/* make sure all previous throttlings are cleared */
> +		thermal_zone_device_init(tz);

It looks weird to do a init when you are actually disabling the thermal 
zone.


> +		for (trip = 0; trip < tz->trips; trip++)
> +			handle_thermal_trip(tz, trip);

So this is exactly what thermal_zone_device_update does except that 
thermal_zone_device_update checks for the mode and bails out if the zone 
is disabled.
This will work because as you explained in v2, the temperature is reset 
in thermal_zone_device_init and handle_thermal_trip will remove the 
mitigation if any.

My two cents here (Rafael and Daniel can comment more on this).

I think it will be cleaner if we can have a third mode 
THERMAL_DEVICE_DISABLING and have thermal_zone_device_update handle 
clearing the mitigation. So this will look like
if (mode == THERMAL_DEVICE_DISABLED)
	tz->mode = THERMAL_DEVICE_DISABLING;
else
	tz->mode = mode;

thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);

if (mode == THERMAL_DEVICE_DISABLED)
	tz->mode = mode;

You will have to update update_temperature to set tz->temperature = 
THERMAL_TEMP_INVALID and thermal_zone_set_trips to set 
tz->prev_low_trip = -INT_MAX and tz->prev_high_trip = INT_MAX for
THERMAL_DEVICE_DISABLING mode.

-- 
Warm Regards
Thara (She/Her/Hers)
> +
>   		thermal_notify_tz_disable(tz->id);
> +	}
>   
>   	return ret;
>   }
> 

