Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A675A135F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiHYOUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbiHYOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:19:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49547B2DAC;
        Thu, 25 Aug 2022 07:19:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 954A4D6E;
        Thu, 25 Aug 2022 07:19:13 -0700 (PDT)
Received: from [10.57.16.12] (unknown [10.57.16.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEFB73F67D;
        Thu, 25 Aug 2022 07:19:07 -0700 (PDT)
Message-ID: <5fd3f684-1d20-c646-04a4-09f32d765f8d@arm.com>
Date:   Thu, 25 Aug 2022 15:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RESEND] rtc: hym8563: try multiple times to init device
Content-Language: en-GB
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
References: <20220821122613.245026-1-linux@fw-web.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220821122613.245026-1-linux@fw-web.de>
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

On 2022-08-21 13:26, Frank Wunderlich wrote:
> From: Peter Geis <pgwipeout@gmail.com>
> 
> RTC sometimes does not respond the first time in init.
> Try multiple times to get a response.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> discussion from v1
> https://patchwork.kernel.org/project/linux-rockchip/patch/20220608161150.58919-2-linux@fw-web.de/
> 
> On Fri, Jul 8, 2022 at 12:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> FWIW, given that HYM8563 is fairly common on RK3288 boards - I can't say
>> I've ever noticed an issue with mine, for instance - it seems dubious
>> that this would be a general issue of the chip itself. Are you sure it's
>> not a SoC or board-level issue with the I2C bus being in a funny initial
>> state, timings being marginal, or suchlike?
> 
> Peter Geis <pgwipeout@gmail.com>:
> I don't think this is an SoC issue since this is the first instance
> I've encountered it. Mind you we don't have the reset lines hooked up
> at all for the Rockchip i2c driver, so it's possible that's the case,
> but I'd imagine it would be observed more broadly if that was the
> case. I've tried pushing the timings out pretty far as well as bumping
> up the drive strength to no change. It seems to occur only with the
> hym rtc used on this board. I suspect it's a new variant of the hym
> that has slightly different behavior.

Sure, if it's documented somewhere that Hayou (or if the BPI-R2 Pro 
schematic is to be believed, AnalogTek) decided to innovate a new 
"sometimes doesn't work" feature for a chip that's been in production 
for a decade or more, and that 2 retries at 20ms intervals is what's 
recommended, then I'm open to believing that this isn't a complete hack. 
Or at least if someone can say they've scoped the pins and confirmed 
that nothing looks suspect at the protocol level when this happens that 
could explain it.

Otherwise, I'll remain unconvinced that it isn't a coincidence that this 
has shown up while bringing up a new board with a new SoC, and hacking a 
mature common driver to bodge around an issue that isn't fully 
understood, and could very conceivably lie elsewhere, is not the right 
answer. Especially when it involves a board vendor... let's say, whose 
reputation proceeds them.

Since I'm not above wasting 20 minutes of my time to prove a point, for 
starters the schematic seems to imply that it's using a variant of RK809 
where LDO4, used as the I/O supply for i2c3, is off by default, so on 
the face of it it could be something as stupidly simple as the RTC probe 
racing with the PMIC or I/O domain probe. Sure, the DT claims it's 
already on at boot, but *is* it? Maybe that was true with some 
downstream bootloader, but do we know that's what you're using to boot 
mainline? Maybe this something so obvious that you've already confirmed 
and taken it for granted, but the patch as presented doesn't give me the 
confidence to rule *anything* out.

Thanks,
Robin.

> ---
>   drivers/rtc/rtc-hym8563.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
> index cc710d682121..d9d0b6615a07 100644
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
