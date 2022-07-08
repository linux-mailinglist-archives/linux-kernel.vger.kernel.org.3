Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31356BED1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiGHQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiGHQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:18:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22D76796BA;
        Fri,  8 Jul 2022 09:18:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FDB7106F;
        Fri,  8 Jul 2022 09:18:23 -0700 (PDT)
Received: from [10.57.86.102] (unknown [10.57.86.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2FDB3F66F;
        Fri,  8 Jul 2022 09:18:20 -0700 (PDT)
Message-ID: <5611d1c5-44db-4144-3c46-256323d39fe3@arm.com>
Date:   Fri, 8 Jul 2022 17:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] rtc: hym8563: try multiple times to init device
Content-Language: en-GB
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
References: <20220608161150.58919-1-linux@fw-web.de>
 <20220608161150.58919-2-linux@fw-web.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220608161150.58919-2-linux@fw-web.de>
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

On 2022-06-08 17:11, Frank Wunderlich wrote:
> From: Peter Geis <pgwipeout@gmail.com>
> 
> RTC sometimes does not respond the first time in init.
> Try multiple times to get a response.

FWIW, given that HYM8563 is fairly common on RK3288 boards - I can't say 
I've ever noticed an issue with mine, for instance - it seems dubious 
that this would be a general issue of the chip itself. Are you sure it's 
not a SoC or board-level issue with the I2C bus being in a funny initial 
state, timings being marginal, or suchlike?

Robin.

> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   drivers/rtc/rtc-hym8563.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
> index 90e602e99d03..9adcedaa4613 100644
> --- a/drivers/rtc/rtc-hym8563.c
> +++ b/drivers/rtc/rtc-hym8563.c
> @@ -13,6 +13,7 @@
>   #include <linux/clk-provider.h>
>   #include <linux/i2c.h>
>   #include <linux/bcd.h>
> +#include <linux/delay.h>
>   #include <linux/rtc.h>
>   
>   #define HYM8563_CTL1		0x00
> @@ -438,10 +439,16 @@ static irqreturn_t hym8563_irq(int irq, void *dev_id)
>   
>   static int hym8563_init_device(struct i2c_client *client)
>   {
> -	int ret;
> +	int ret, i;
>   
>   	/* Clear stop flag if present */
> -	ret = i2c_smbus_write_byte_data(client, HYM8563_CTL1, 0);
> +	for (i = 0; i < 3; i++) {
> +		ret = i2c_smbus_write_byte_data(client, HYM8563_CTL1, 0);
> +		if (ret == 0)
> +			break;
> +		msleep(20);
> +	}
> +
>   	if (ret < 0)
>   		return ret;
>   
