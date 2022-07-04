Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF33564ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiGDHiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiGDHiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:38:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B3ADC23;
        Mon,  4 Jul 2022 00:38:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3928F2B;
        Mon,  4 Jul 2022 00:38:12 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671053F792;
        Mon,  4 Jul 2022 00:38:10 -0700 (PDT)
Message-ID: <99526f90-f4c9-2785-f159-beace854b4a0@arm.com>
Date:   Mon, 4 Jul 2022 08:38:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 01/12] thermal/core: Remove duplicate information when
 an error occurs
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-2-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-2-daniel.lezcano@linexp.org>
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
> The pr_err already tells it is an error, it is pointless to add the
> 'Error:' string in the messages. Remove them.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/thermal_core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index cdc0552e8c42..e22e7d939c54 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1198,23 +1198,23 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>   	struct thermal_governor *governor;
>   
>   	if (!type || strlen(type) == 0) {
> -		pr_err("Error: No thermal zone type defined\n");
> +		pr_err("No thermal zone type defined\n");
>   		return ERR_PTR(-EINVAL);
>   	}
>   
>   	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> -		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
> +		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
>   		       type, THERMAL_NAME_LENGTH);
>   		return ERR_PTR(-EINVAL);
>   	}
>   
>   	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
> -		pr_err("Error: Incorrect number of thermal trips\n");
> +		pr_err("Incorrect number of thermal trips\n");
>   		return ERR_PTR(-EINVAL);
>   	}
>   
>   	if (!ops) {
> -		pr_err("Error: Thermal zone device ops not defined\n");
> +		pr_err("Thermal zone device ops not defined\n");
>   		return ERR_PTR(-EINVAL);
>   	}
>   

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
