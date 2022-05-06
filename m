Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB251DDBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443858AbiEFQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443847AbiEFQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:45:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53E3560DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:42:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16FB3113E;
        Fri,  6 May 2022 09:42:02 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7028A3F85F;
        Fri,  6 May 2022 09:42:00 -0700 (PDT)
Message-ID: <6c148e83-3244-d47a-37e3-1a1f01fe35bc@arm.com>
Date:   Fri, 6 May 2022 17:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] clocksource/drivers/sp804: avoid error on multiple
 instances
Content-Language: en-GB
To:     Andre Przywara <andre.przywara@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220506162522.3675399-1-andre.przywara@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220506162522.3675399-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-06 17:25, Andre Przywara wrote:
> When a machine sports more than one SP804 timer instance, we only bring
> up the first one, since multiple timers of the same kind are not useful
> to Linux. As this is intentional behaviour, we should not return an
> error message, as we do today:
> ===============
> [    0.000800] Failed to initialize '/bus@8000000/motherboard-bus@8000000/iofpga-bus@300000000/timer@120000': -22
> ===============
> 
> Replace the -EINVAL return with a debug message and return 0 instead.
> 
> Also we do not reach the init function anymore if the DT node is
> disabled (as this is now handled by OF_DECLARE), so remove the explicit
> check for that case.
> 
> This fixes a long standing bogus error when booting ARM's fastmodels.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v1 .. v2:
> - demote pr_info() to pr_debug(), to avoid output at all
> - use %pOF and reword message
> 
>   drivers/clocksource/timer-sp804.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index 401d592e85f5a..e6a87f4af2b50 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -259,6 +259,11 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
>   	struct clk *clk1, *clk2;
>   	const char *name = of_get_property(np, "compatible", NULL);
>   
> +	if (initialized) {
> +		pr_debug("%pOF: skipping further SP804 timer device\n", np);
> +		return 0;
> +	}
> +
>   	base = of_iomap(np, 0);
>   	if (!base)
>   		return -ENXIO;
> @@ -270,11 +275,6 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
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
