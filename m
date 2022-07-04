Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD725564FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiGDIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiGDIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:24:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91B9865C5;
        Mon,  4 Jul 2022 01:24:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7CAE23A;
        Mon,  4 Jul 2022 01:24:47 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C55A3F792;
        Mon,  4 Jul 2022 01:24:45 -0700 (PDT)
Message-ID: <4ad311e5-62e1-d06b-7c5e-315ed923b5a5@arm.com>
Date:   Mon, 4 Jul 2022 09:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 07/12] thermal/core: Rename trips to ntrips
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-8-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-8-daniel.lezcano@linexp.org>
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
> In order to use thermal trips defined in the thermal structure, rename
> the 'trips' field to 'ntrips' to have the 'trips' field containing the
> thermal trip points.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/gov_fair_share.c        |  6 +++---
>   drivers/thermal/gov_power_allocator.c   |  4 ++--
>   drivers/thermal/tegra/tegra30-tsensor.c |  2 +-
>   drivers/thermal/thermal_core.c          | 20 ++++++++++----------
>   drivers/thermal/thermal_helpers.c       |  4 ++--
>   drivers/thermal/thermal_netlink.c       |  2 +-
>   drivers/thermal/thermal_sysfs.c         | 22 +++++++++++-----------
>   include/linux/thermal.h                 |  2 +-
>   8 files changed, 31 insertions(+), 31 deletions(-)


[snip]

> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 6289b0bb1c97..3a57878a2a6c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h

Missing updated ne name in comment here:
  * @trips:      number of trip points the thermal zone supports


> @@ -165,7 +165,7 @@ struct thermal_zone_device {
>   	struct thermal_attr *trip_hyst_attrs;
>   	enum thermal_device_mode mode;
>   	void *devdata;
> -	int trips;
> +	int ntrips;
>   	unsigned long trips_disabled;	/* bitmap for disabled trips */
>   	unsigned long passive_delay_jiffies;
>   	unsigned long polling_delay_jiffies;

Maybe this is only my bias, but this new name 'ntrips' looks
like negation in electronics.

We have examples like: num_cpus, num_pins, num_leds, num_groups,
num_locks, num_buffers, num_phys, etc...

Could we have 'num_trips' and follow to this convention here as well?


