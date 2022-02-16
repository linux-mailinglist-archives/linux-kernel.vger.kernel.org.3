Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3194B909F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiBPSox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:44:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiBPSos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:44:48 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08358222DEF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:44:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i14so4943347wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lszB3xceFjSIFmWwB8cITSlsQu8F9SaAJnYIVCoUsFc=;
        b=sbVTqKGlf7xvO45FqWb50YfhQZItyXe2xKSD86hgNjh8yyr2JXznhNFPzd/swEwlHh
         KMuOVe9I7Cb1kewjSd3cnJCUNB6vx/yKdw9OvffbnjnurEfm9scvTyoux4GvNtvLsy49
         uc17nWybjxZKamcEKx/F+42OfvemWwa9angbKZcX7cZL5BfhyLY6Q6yylpifcoVPD/+1
         GByHPcOaaKna6095XTbBFSWNDxb8pMa1awTKwrippYFrYWwLfAhy7sPMzxP+KQ30TUqs
         mTfRtF7Pq+Z5cUNuMaL9baRs1CYnP0MdXCBAZdjAZDYRF6yWPorkZUEKWPGbx1VPLlOg
         5T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lszB3xceFjSIFmWwB8cITSlsQu8F9SaAJnYIVCoUsFc=;
        b=O7DnoE8dntUrqiLx0Ag5JgQ6AXZGQFnY7GZXydORAs4Gv91YlxO6PvEGneM1+Arif2
         KEFws2dcB3ApzVg/Ktif2IJKUiqwIVHmsklK6xxmByYwbVKah+QFnNc4NHk33i7y7+/j
         Vl4fNIVvRKTf/YRtfOsH+A1REkakGs53gnrLfIcqU+yrXpHJYl5lzKXpdtGsyAxWqT8g
         cJ1IJuXKYnLaZzBHXnnlZQJLYSoHEFSCt+G8kszrKunPR/YNDS5QindrQY/Bs97T9Kjo
         bVjzabgvBi8r+XoQVb+f5QloBjRlbcxaKZFZ1A7CPKMIo7s3mCcxb59FIWQx0R5Z8HWE
         IlNQ==
X-Gm-Message-State: AOAM531ayu624/Bkx0jwmqSqmb8onTwMnRRcLVIiw5j4rYDN0Ow092kj
        GdU/PO4kLtNc3yFc3qq0Ni7x+g==
X-Google-Smtp-Source: ABdhPJyQBwxtunRVW/1pojsvJEgADGCFHehYC1r5tdHntm0Zk7lR/GS3+oFU+xnPDUm73wPyWePNFg==
X-Received: by 2002:a5d:634b:0:b0:1e3:3226:8e27 with SMTP id b11-20020a5d634b000000b001e332268e27mr3260753wrw.428.1645037069455;
        Wed, 16 Feb 2022 10:44:29 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id j10sm14282624wmq.20.2022.02.16.10.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 10:44:28 -0800 (PST)
Message-ID: <c07b9fe7-5d28-c72a-a9d9-e612b07b0b75@linaro.org>
Date:   Wed, 16 Feb 2022 19:44:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] drivers: thermal: clear all mitigation when thermal
 zone is disabled
Content-Language: en-US
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1643307093-22501-1-git-send-email-quic_manafm@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1643307093-22501-1-git-send-email-quic_manafm@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 19:11, Manaf Meethalavalappu Pallikunhi wrote:
> Whenever a thermal zone is in trip violated state, there is a chance
> that the same thermal zone mode can be disabled either via
> thermal core API or via thermal zone sysfs. Once it is disabled,
> the framework bails out any re-evaluation of thermal zone. It leads
> to a case where if it is already in mitigation state, it will stay
> the same state forever.
> 
> To avoid above mentioned issue, add support to bind/unbind
> governor from thermal zone during thermal zone mode change request
> and clear all existing throttling in governor unbind_from_tz()
> callback.

Manaf,

can you clarify when / why is needed to disable a thermal zone at runtime?



> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>   drivers/thermal/gov_power_allocator.c |  3 +++
>   drivers/thermal/gov_step_wise.c       | 26 ++++++++++++++++++++++++++
>   drivers/thermal/thermal_core.c        | 31 +++++++++++++++++++++++++++----
>   3 files changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 13e3757..9ff0c5f 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -696,6 +696,9 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
>   
>   	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
>   
> +	tz->passive = 0;
> +	allow_maximum_power(tz, true);
> +
>   	if (params->allocated_tzp) {
>   		kfree(tz->tzp);
>   		tz->tzp = NULL;
> diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
> index 12acb12..2d2186b 100644
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -168,6 +168,31 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>   }
>   
>   /**
> + * step_wise_unbind() - unbind the step_wise governor to a thermal zone
> + * @tz:	thermal zone to unbind it to
> + *
> + * Clear all previous throttling and reset passive counter.
> + *
> + */
> +static void step_wise_unbind(struct thermal_zone_device *tz)
> +{
> +	struct thermal_instance *instance;
> +
> +	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
> +
> +	mutex_lock(&tz->lock);
> +	tz->passive = 0;
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		instance->initialized = false;
> +		instance->target = THERMAL_NO_TARGET;
> +		mutex_lock(&instance->cdev->lock);
> +		__thermal_cdev_update(instance->cdev);
> +		mutex_unlock(&instance->cdev->lock);
> +	}
> +	mutex_unlock(&tz->lock);
> +}
> +
> +/**
>    * step_wise_throttle - throttles devices associated with the given zone
>    * @tz: thermal_zone_device
>    * @trip: trip point index
> @@ -196,6 +221,7 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
>   
>   static struct thermal_governor thermal_gov_step_wise = {
>   	.name		= "step_wise",
> +	.unbind_from_tz	= step_wise_unbind,
>   	.throttle	= step_wise_throttle,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_step_wise);
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 82654dc..34726d3 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -274,6 +274,26 @@ static int __init thermal_register_governors(void)
>   	return ret;
>   }
>   
> +static void thermal_governor_attach(struct thermal_zone_device *tz)
> +{
> +	mutex_lock(&thermal_governor_lock);
> +	if (tz->governor && tz->governor->bind_to_tz) {
> +		if (tz->governor->bind_to_tz(tz))
> +			dev_err(&tz->device,
> +				"governor %s failed to bind to thermal zone %s\n",
> +				tz->governor->name, tz->type);
> +	}
> +	mutex_unlock(&thermal_governor_lock);
> +}
> +
> +static void thermal_governor_detach(struct thermal_zone_device *tz)
> +{
> +	mutex_lock(&thermal_governor_lock);
> +	if (tz->governor && tz->governor->unbind_from_tz)
> +		tz->governor->unbind_from_tz(tz);
> +	mutex_unlock(&thermal_governor_lock);
> +}
> +
>   /*
>    * Zone update section: main control loop applied to each zone while monitoring
>    *
> @@ -449,12 +469,15 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>   
>   	mutex_unlock(&tz->lock);
>   
> -	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> -
> -	if (mode == THERMAL_DEVICE_ENABLED)
> +	if (mode == THERMAL_DEVICE_ENABLED) {
> +		thermal_governor_attach(tz);
> +		thermal_zone_device_init(tz);
> +		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   		thermal_notify_tz_enable(tz->id);
> -	else
> +	} else {
> +		thermal_governor_detach(tz);
>   		thermal_notify_tz_disable(tz->id);
> +	}
>   
>   	return ret;
>   }


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
