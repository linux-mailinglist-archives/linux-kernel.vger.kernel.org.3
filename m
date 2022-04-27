Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6510F512140
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiD0Ppy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiD0Ppr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:45:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C4BC3D495
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:42:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B4DED1;
        Wed, 27 Apr 2022 08:42:20 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B1033F73B;
        Wed, 27 Apr 2022 08:42:18 -0700 (PDT)
Message-ID: <18bac780-457b-8f33-7ba9-f149996fc1f0@arm.com>
Date:   Wed, 27 Apr 2022 16:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clocksource/drivers/sp804: avoid error on multiple
 instances
Content-Language: en-GB
To:     Andre Przywara <andre.przywara@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
References: <20220427142759.4138694-1-andre.przywara@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220427142759.4138694-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-27 15:27, Andre Przywara wrote:
> When a machine sports more than one SP804 timer instance, we only bring
> up the first one, since multiple timers of the same kind are not useful
> to Linux. As this is intentional behaviour, we should not return an
> error message, as we do today:
> ===============
> [    0.000800] Failed to initialize '/bus@8000000/motherboard-bus@8000000/iofpga-bus@300000000/timer@120000': -22
> ===============
> 
> Replace the -EINVAL return with an informative message and return 0
> instead.
> 
> Also we do not reach the init function anymore if the DT node is
> disabled (as this is now handled by OF_DECLARE), so remove the explicit
> check for that case.
> 
> This fixes a long standing bogus error when booting ARM's fastmodels.

And on Juno too, hooray! :)

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   drivers/clocksource/timer-sp804.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index 401d592e85f5a..30cbc580e0448 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -259,6 +259,12 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
>   	struct clk *clk1, *clk2;
>   	const char *name = of_get_property(np, "compatible", NULL);
>   
> +	if (initialized) {
> +		pr_info("%s: only instantiating one timer\n",
> +			of_node_full_name(np));

Nit: %pOF? However, do we really need to print anything at all? As it 
is, the message already looks ambiguously like it might be saying that 
this node *is* the one timer that we're instantiating, however we'll 
have already logged the registration of an SP804 clocksource, so further 
messages about what we *aren't* doing seem little more useful than 
pr_info("not waxing an owl") IMO.

Cheers,
Robin.

> +		return 0;
> +	}
> +
>   	base = of_iomap(np, 0);
>   	if (!base)
>   		return -ENXIO;
> @@ -270,11 +276,6 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
>   	writel(0, timer1_base + timer->ctrl);
>   	writel(0, timer2_base + timer->ctrl);
>   
> -	if (initialized || !of_device_is_available(np)) {
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -
>   	clk1 = of_clk_get(np, 0);
>   	if (IS_ERR(clk1))
>   		clk1 = NULL;
