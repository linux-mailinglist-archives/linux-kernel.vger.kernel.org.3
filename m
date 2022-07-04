Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D29564FDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiGDIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiGDIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:38:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88529B7C0;
        Mon,  4 Jul 2022 01:38:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CACC23A;
        Mon,  4 Jul 2022 01:38:53 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4A693F792;
        Mon,  4 Jul 2022 01:38:51 -0700 (PDT)
Message-ID: <d938932a-d2ab-e47d-5c49-4d68cfc6050b@arm.com>
Date:   Mon, 4 Jul 2022 09:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 10/12] thermal/of: Store the trips in the thermal zone
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-11-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-11-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/22 19:30, Daniel Lezcano wrote:
> As the thermal zone contains the trip point, we can store them
> directly in the when registering the thermal zone. That will allow

'directly in the' is there something missing?
maybe: in the thermal zone when registering

> another step forward to remove the duplicate thermal zone structure we
> find in the thermal_of code.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/thermal_of.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 16eb18c24430..16b6b90a2390 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -1117,11 +1117,9 @@ int __init of_parse_thermal_zones(void)
>   		tzp->slope = tz->slope;
>   		tzp->offset = tz->offset;
>   
> -		zone = thermal_zone_device_register(child->name, tz->ntrips,
> -						    mask, tz,
> -						    ops, tzp,
> -						    tz->passive_delay,
> -						    tz->polling_delay);
> +		zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
> +							       mask, tz, ops, tzp, tz->passive_delay,
> +							       tz->polling_delay);
>   		if (IS_ERR(zone)) {
>   			pr_err("Failed to build %pOFn zone %ld\n", child,
>   			       PTR_ERR(zone));

'num_trips' ?
Apart from that LGTM
