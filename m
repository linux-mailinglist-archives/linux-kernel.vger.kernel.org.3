Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2841F5AC48C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiIDNto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiIDNti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:49:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260E7EE29;
        Sun,  4 Sep 2022 06:49:35 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxV8b-1pJeKH3jY1-00xpCC; Sun, 04 Sep 2022 15:49:13 +0200
Message-ID: <9afe7000-d4c7-0b67-1dfd-7200efe73c0e@i2se.com>
Date:   Sun, 4 Sep 2022 15:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] clk: bcm2835: Round UART input clock up
Content-Language: en-US
To:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220829132943.144608-1-iivanov@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220829132943.144608-1-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YOR8PzuYn1YtGuD1bVX7oiT3qrgTf+omYyvhdw/ZqL9xDSoCYBE
 duBCBWHQLt4IqsOAASUfFThCrPFeNw09587dL2dmbn57MDbW0/a0dZQkLEgkB0huJL6yz+S
 1+KAZ/dVlwbSiCZmHL38WVdijHZew1gGX/Qt12rTYnhyX/7JXUNnRCd0LQE6cbHjZ0bc71w
 Tisgjs0VduAyK3loe7fgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xopYdvfmTH4=:gvtCwvn2iaYlN2XuPpbNiT
 1WogNH/P9FxWmF+trKS87e0Fs+fHvpyJSu5CRzoFK5HI8Ho038VRqq/atYUVh92GGdlP3wkqw
 5srDZi+OtEuIWQLm7tO16Jyxs6KzyaSafzaHgKVGGIxG74myCHettadrjhDYPAW6+aW63BwW4
 vBGG25FzehgMFU9ugL5hT7wE45ywORC2wDF5EpByixunDaa1NxaWcO+8r0PGIp2X//Wj0dgJP
 xixsIGyDttQ+Mk+MA9MaPA040tzRI0hxmq5/BYY0EAwfShnnu5KOfvmiHxRHjsWJ6d+L3kgbP
 NZS3R6ycD4Fan/2uw2doL5gkxW9LJom20LZS7cVoQYLv+nq2cTsttd1veJlZVXNsC57q/NCM4
 D4433raH5Oi8qHC4EOSsnKhnaFOdsPdgh4JSZLPLTjOcXnteQ3RJrBh/tmhvlQiQOSQWUig0g
 pnkTtetBVMEU7JLQdIiDvq/txUknq/xMZsKPHbKxqRUx4j+cmymslK9YUvC4nDx4eTkvnxqcB
 A5w5ZpUSckrBevKCBQvX2+fqxOqxGZEjZAc7q1fYZneIuczp/Ebk8d74Z/oiDBRhq9vM7aiMI
 AO9Q+SdwLrmantfZD8V9ma/pmp91fBg6kVhDK1NN2TKJdGlz+nXYCT26I9ypPBInH2oTA4oZY
 lVH+70kgxCAi9YyYpWx3HcHb+TsS3lIQZuNN4YJs7MqZcA212UyVxr0npttSjbqESBU7zY2da
 b3mKGSRqCC0fvyqqejz+Urxj9nym7OY+FyqmCVcL3iQgjGKERb80Ap5jFEXFxBX+iQwKaO4of
 qSylrvI
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 29.08.22 um 15:29 schrieb Ivan T. Ivanov:
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
>
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1188238
> [2] https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
>
> Cc: Phil Elwell <phil@raspberrypi.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>
> Changes since v3
> * Rework 'scaler' calculation to avoid overflow
> * Update Phil Elwell email address
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
>   drivers/clk/bcm/clk-bcm2835.c | 35 +++++++++++++++++++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 48a1eb9f2d55..26a5c9a0dd34 100644
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
> @@ -993,12 +996,34 @@ static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
>   	return temp;
>   }
>   
> +static unsigned long bcm2835_clock_round(unsigned long clk)
sorry, i missed this in my last mail. Please use "rate" instead of "clk" 
here.
> +{
> +	unsigned long scaler;
> +	unsigned long limit;;
> +
> +	limit = clk / 100000;
> +
> +	scaler = 1;
> +	while (scaler < limit)
> +		scaler *= 10;
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
>   
