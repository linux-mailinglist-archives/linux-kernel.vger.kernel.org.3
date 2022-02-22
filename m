Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F34BF6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiBVK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiBVK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:58:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3DB9B10A7;
        Tue, 22 Feb 2022 02:58:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A1C4106F;
        Tue, 22 Feb 2022 02:58:28 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C17833F70D;
        Tue, 22 Feb 2022 02:58:26 -0800 (PST)
Date:   Tue, 22 Feb 2022 10:58:23 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v10 03/18] rtc: sun6i: Fix time overflow handling
Message-ID: <20220222105823.0cf9b008@donnerap.cambridge.arm.com>
In-Reply-To: <20220211122643.1343315-4-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com>
        <20220211122643.1343315-4-andre.przywara@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 12:26:28 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

Hi Alessandro, Alexandre,

I was wondering if you would consider taking this (as a fix)?
This (time_gap > U32_MAX) comparison looks flawed by design, and we should
use time_t these days anyway.

Also, do you have an opinion on the other RTC patches? The linear day
patch (v10 04/18)[1] and the broken-down alarm registers (v10 05/18)[2]
were on the list for a while now and are needed by other SoCs as well
(R329[3] and the RISC-V D1).

Cheers,
Andre
[1] https://lore.kernel.org/linux-arm-kernel/20220211122643.1343315-5-andre.przywara@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20220211122643.1343315-6-andre.przywara@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20210802062212.73220-3-icenowy@sipeed.com/

> Using "unsigned long" for UNIX timestamps is never a good idea, and
> comparing the value of such a variable against U32_MAX does not do
> anything useful on 32-bit systems.
> 
> Use the proper time64_t type when dealing with timestamps, and avoid
> cutting down the time range unnecessarily. This also fixes the flawed
> check for the alarm time being too far into the future.
> 
> The check for this condition is actually somewhat theoretical, as the
> RTC counts till 2033 only anyways, and 2^32 seconds from now is not
> before the year 2157 - at which point I hope nobody will be using this
> hardware anymore.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 35b34d14a1db..dc3ae851841c 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -139,7 +139,7 @@ struct sun6i_rtc_dev {
>  	const struct sun6i_rtc_clk_data *data;
>  	void __iomem *base;
>  	int irq;
> -	unsigned long alarm;
> +	time64_t alarm;
>  
>  	struct clk_hw hw;
>  	struct clk_hw *int_osc;
> @@ -511,10 +511,8 @@ static int sun6i_rtc_setalarm(struct device *dev,
> struct rtc_wkalrm *wkalrm) struct sun6i_rtc_dev *chip =
> dev_get_drvdata(dev); struct rtc_time *alrm_tm = &wkalrm->time;
>  	struct rtc_time tm_now;
> -	unsigned long time_now = 0;
> -	unsigned long time_set = 0;
> -	unsigned long time_gap = 0;
> -	int ret = 0;
> +	time64_t time_now, time_set;
> +	int ret;
>  
>  	ret = sun6i_rtc_gettime(dev, &tm_now);
>  	if (ret < 0) {
> @@ -529,9 +527,7 @@ static int sun6i_rtc_setalarm(struct device *dev,
> struct rtc_wkalrm *wkalrm) return -EINVAL;
>  	}
>  
> -	time_gap = time_set - time_now;
> -
> -	if (time_gap > U32_MAX) {
> +	if ((time_set - time_now) > U32_MAX) {
>  		dev_err(dev, "Date too far in the future\n");
>  		return -EINVAL;
>  	}
> @@ -540,7 +536,7 @@ static int sun6i_rtc_setalarm(struct device *dev,
> struct rtc_wkalrm *wkalrm) writel(0, chip->base + SUN6I_ALRM_COUNTER);
>  	usleep_range(100, 300);
>  
> -	writel(time_gap, chip->base + SUN6I_ALRM_COUNTER);
> +	writel(time_set - time_now, chip->base + SUN6I_ALRM_COUNTER);
>  	chip->alarm = time_set;
>  
>  	sun6i_rtc_setaie(wkalrm->enabled, chip);

