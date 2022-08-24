Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2FA59F711
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbiHXKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiHXKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:04:55 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7612C13B;
        Wed, 24 Aug 2022 03:04:53 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqK2d-1pDGwt1ElX-00nQRs; Wed, 24 Aug 2022 12:04:08 +0200
Message-ID: <23a323e6-81b7-6b9a-fdfe-faddec9e7a75@i2se.com>
Date:   Wed, 24 Aug 2022 12:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] clk: bcm2835: Round UART input clock up
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220527102900.144894-1-iivanov@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220527102900.144894-1-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:y6rJ9aKKhNo8kI15r9PCLQuQEt4hloO6g13Pi+AroxJGv69tX0g
 Z3SDdv37Wf3OsKsTbGJ9lQB/OZ93h4x9Z4P0j6NrcMLw8ZXaNGUO/itN0Yxs0vSJ3HZr84D
 3WPKD+iJkOSwN64owlVgTpdv+sRdvBvUGuskb+3yt4w+LhWJJRGeR8NaspoFfDwmwHDW+/j
 QAV9HXYKcjbnPB/PgnTEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdSZPrQAPkA=:GahMTjw1AMlSx1QALm5iyJ
 bT2FPDePKY8xmtBQ/OSwxjLX4/R8xIVDqNudMJX6iEbEabgm745rzxH/QM6C0vfzdTclbXZ1l
 fEqEXCiY03Asv6fXx+SXP2RZgRiS2rZEgwauPUm1bSq0NHtaSRc81ppkB9AjaqiiUq3kj548c
 i7ZfZyLVWD6IDwyhxM2PCEC0BeDtosRoXtJn7V5Y8CLed9bidhcMTmCJ+pWWLXA0yaa3jG3WF
 VPm2SzWVQODK2lvSyg5BiN2rvKSwqzyU5F1Zx9n56/MEDv8n/EkekZW3HrpqWr6DDtWzxnw6f
 yK9LeNVQiK2+D/vZZeL8f1401zGQ47or2Dqt2HnujM1bVJStmxgKcztQMa3bJxLGzssG8Nrwu
 RzqRI4I1EGWRpE8n11c5Am46KPs0Y5/OcnxqgDM4IA7KiA0054JxCkgRMzANwSWIQIQKjVVxJ
 VPnsSx2lAhsf+bPqQ/DHSKSph4JCFRN6Q85VmImGbDB396INptYKSyCtR0kieS5m9Dp8AwlVl
 rpdMbLZoRrhY1SWog2JpEbcRGu3iKXwuf4ZOv9/fpKpPymfh64pR3S+xQKuIFSMwPxJAlK0vv
 K7gPPD09PirJlD/f5WMUeE0KadJP6WKgiOYZqfmQ2rvRZ2yzr0kU9TR/oe7KSY+yMbJJO7NW1
 eelgN3cmfdkbGXU+IuTUdkQ/1RlWIc3y/wFF7fBZH53yfM38GRyvT46WCZAzuTEJuTbltSHnu
 G9aOgevjQGJEfWS/Vl7cquMd1UlSHUsrrw6/DCd5tsXNIsyPdfu1ROWCulA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 27.05.22 um 12:29 schrieb Ivan T. Ivanov:
> It was reported that RPi3[1] and RPi Zero 2W boards have issues with
> the Bluetooth. It turns out that when switching from initial to
> operation speed host and device no longer can talk each other because
> host uses incorrect UART baud rate.
>
> The UART driver used in this case is amba-pl011. Original fix, see
> below Github link[2], was inside pl011 module, but somehow it didn't
> look as the right place to fix. Beside that this original rounding
> function is not exactly perfect for all possible clock values. So I
> deiced to move the hack to the platform which actually need it.
>
> The UART clock is initialised to be as close to the requested
> frequency as possible without exceeding it. Now that there is a
> clock manager that returns the actual frequencies, an expected
> 48MHz clock is reported as 47999625. If the requested baud rate
> == requested clock/16, there is no headroom and the slight
> reduction in actual clock rate results in failure.
>
> If increasing a clock by less than 0.1% changes it from ..999..
> to ..000.., round it up.
i'm fine with this approach.
>
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1188238
> [2] https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
>
> Cc: Phil Elwell <phil@raspberrypi.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>
> Changes since v2
> * Added more information in commit message
> * Changed hand crafted round function with the one form math.h
>
> Changes since v1
> Make bcm2835_clock_round() static to fix following warning
> when compiling for riscv:
> drivers/clk/bcm/clk-bcm2835.c:997:15: warning: no previous prototype for 'bcm2835_clock_round' [-Wmissing-prototypes]
> Reported-by: kernel test robot <lkp@intel.com>
>
>   drivers/clk/bcm/clk-bcm2835.c | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 48a1eb9f2d55..cee59990a57b 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -30,6 +30,7 @@
>   #include <linux/debugfs.h>
>   #include <linux/delay.h>
>   #include <linux/io.h>
> +#include <linux/math.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
> @@ -502,6 +503,8 @@ struct bcm2835_clock_data {
>   	bool low_jitter;
>   
>   	u32 tcnt_mux;
> +
> +	bool round_up;
>   };
>   
>   struct bcm2835_gate_data {
> @@ -993,12 +996,31 @@ static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
>   	return temp;
>   }
>   
> +static unsigned long bcm2835_clock_round(unsigned long clk)
> +{
> +	unsigned long scaler;
> +
> +	scaler = 1;
> +	while (scaler * 100000 < clk)
> +		scaler *= 10;

I'm not sure about overflow behavior for this loop. But it's better to 
avoid any potential endless loops here.

Best regards

> +
> +	/*
> +	 * If increasing a clock by less than 0.1% changes it
> +	 * from ..999.. to ..000.., round up.
> +	 */
> +	if ((clk + scaler - 1) / scaler % 1000 == 0)
> +		clk = roundup(clk, scaler);
> +
> +	return clk;
> +}
> +
>   static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>   					    unsigned long parent_rate)
>   {
>   	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
>   	struct bcm2835_cprman *cprman = clock->cprman;
>   	const struct bcm2835_clock_data *data = clock->data;
> +	unsigned long rate;
>   	u32 div;
>   
>   	if (data->int_bits == 0 && data->frac_bits == 0)
> @@ -1006,7 +1028,12 @@ static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
>   
>   	div = cprman_read(cprman, data->div_reg);
>   
> -	return bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +	rate = bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +
> +	if (data->round_up)
> +		rate = bcm2835_clock_round(rate);
> +
> +	return rate;
>   }
>   
>   static void bcm2835_clock_wait_busy(struct bcm2835_clock *clock)
> @@ -2143,7 +2170,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>   		.div_reg = CM_UARTDIV,
>   		.int_bits = 10,
>   		.frac_bits = 12,
> -		.tcnt_mux = 28),
> +		.tcnt_mux = 28,
> +		.round_up = true),
>   
>   	/* TV encoder clock.  Only operating frequency is 108Mhz.  */
>   	[BCM2835_CLOCK_VEC]	= REGISTER_PER_CLK(
