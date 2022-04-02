Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C14EFF3E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbiDBHHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBHHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:07:14 -0400
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 00:05:21 PDT
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF5B10241F;
        Sat,  2 Apr 2022 00:05:21 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id B31FE403F2;
        Sat,  2 Apr 2022 11:59:16 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1648882757; bh=g3dd49ZLEvD3b7UkZq09nzJLTrDcbZhjuvyIkuyxUww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rOhlGsQO/HTUiVU8OGWlJGCELzbuJLDlRNa5zJWC64lw2R6V66Vfo4vQg90/aWOM4
         ptqXOjnOMgkSH236j+4w+8n5Co2yiCluXvASZKsMm7RGMaegx7OqCArSywud4CzGyC
         fy2f5OFuN+er3HLk8tigyOkhM0/UZXdA57bL1C1A9Fq6aRNdBPD3BaiROs8vK0+j94
         XJUVBBGhqHkCT0kscg/JSsO9oNw32bVDRM9JI5VnVT0x66RYA9LLP2gbh76oGZ+839
         RAMeC6r8pcUNXPR/7HvfGHZxGZCVtrkItwCi4vMPx1sBg6Gn01y/TSEryhdP2nLZ6h
         3TWDX5lPmP2wg==
MIME-Version: 1.0
Date:   Sat, 02 Apr 2022 11:59:15 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@pengutronix.de
Subject: Re: [PATCH v6 2/2] pwm: Add clock based PWM output driver
In-Reply-To: <20220328105659.mg3pxbqynlufaq6z@pengutronix.de>
References: <20220220115030.23772-1-nikita@trvn.ru>
 <20220220115030.23772-3-nikita@trvn.ru>
 <20220328105659.mg3pxbqynlufaq6z@pengutronix.de>
Message-ID: <ce9a8bab61485ba06933cdb7fdea50ac@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,DOS_RCVD_IP_TWICE_B,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Uwe Kleine-König писал(а) 28.03.2022 15:56:
> Hello,
> 
> just a few minor things left to criticize, see below.
> 
> On Sun, Feb 20, 2022 at 04:50:30PM +0500, Nikita Travkin wrote:
>> Some systems have clocks exposed to external devices. If the clock
>> controller supports duty-cycle configuration, such clocks can be used as
>> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
>> similar way and an "opposite" driver already exists (clk-pwm). Add a
>> driver that would enable pwm devices to be used via clk subsystem.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> --
>>
>> Changes in v2:
>>  - Address Uwe's review comments:
>>    - Round set clk rate up
>>    - Add a description with limitations of the driver
>>    - Disable and unprepare clock before removing pwmchip
>> Changes in v3:
>>  - Use 64bit version of div round up
>>  - Address Uwe's review comments:
>>    - Reword the limitations to avoid incorrect claims
>>    - Move the clk_enabled flag assignment
>>    - Drop unnecessary statements
>> Changes in v5:
>>  - add missed returns
>> Changes in v6:
>>  - Unprepare the clock on error
>>  - Drop redundant limitations points
>> ---
>>  drivers/pwm/Kconfig   |  10 +++
>>  drivers/pwm/Makefile  |   1 +
>>  drivers/pwm/pwm-clk.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 150 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-clk.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 21e3b05a5153..daa2491a4054 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -140,6 +140,16 @@ config PWM_BRCMSTB
>>  	  To compile this driver as a module, choose M Here: the module
>>  	  will be called pwm-brcmstb.c.
>>
>> +config PWM_CLK
>> +	tristate "Clock based PWM support"
>> +	depends on HAVE_CLK || COMPILE_TEST
> 
> Can you really compile this driver if HAVE_CLK isn't available?
> 

As I can see, clk.h has all the methods stubbed out if CONFIG_HAVE_CLK
is not set. (And I think that all other headers like that do as well)

I've tried to build it without clk right now and it builds with no
errors, neither test robots complained about that.

>> +	help
>> +	  Generic PWM framework driver for outputs that can be
>> +	  muxed to clocks.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-clk.
>> +
>>  config PWM_CLPS711X
>>  	tristate "CLPS711X PWM support"
>>  	depends on ARCH_CLPS711X || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 708840b7fba8..4a860103c470 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
>>  obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
>>  obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
>>  obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
>> +obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
>>  obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>>  obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>>  obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
>> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
>> new file mode 100644
>> index 000000000000..52c9923368cb
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-clk.c
>> @@ -0,0 +1,139 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Clock based PWM controller
>> + *
>> + * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
>> + *
>> + * This is an "adapter" driver that allows PWM consumers to use
>> + * system clocks with duty cycle control as PWM outputs.
>> + *
>> + * Limitations:
>> + * - Due to the fact that exact behavior depends on the underlying
>> + *   clock driver, various limitations are possible.
>> + * - Underlying clock may not be able to give 0% or 100% duty cycle
>> + *   (constant off or on), exact behavior will depend on the clock.
>> + * - When the PWM is disabled, the clock will be disabled as well,
>> + *   line state will depend on the clock.
> 
>  - The clk API doesn't expose the necessary calls to implement
>    .get_state().
> 
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/math64.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/pwm.h>
>> +
>> +struct pwm_clk_chip {
>> +	struct pwm_chip chip;
>> +	struct clk *clk;
>> +	bool clk_enabled;
>> +};
>> +
>> +#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
>> +
>> +static int pwm_clk_apply(struct pwm_chip *pwm_chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct pwm_clk_chip *chip = to_pwm_clk_chip(pwm_chip);
> 
> I'd prefer this was not called chip, as this is how struct pwm_chip
> variables are called usually. My suggestion is:
> 
> 	chip -> pcchip
> 	pwm_chip -> chip
> 

Thanks for the suggestion, I'll use the common naming then.

Nikita

> Best regards
> Uwe
