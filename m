Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8766E50BA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448663AbiDVOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445426AbiDVOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:32:18 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273ED5BD21;
        Fri, 22 Apr 2022 07:29:25 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nhuHj-0000bB-DF; Fri, 22 Apr 2022 16:29:23 +0200
Message-ID: <2ce27899-684f-4fe2-4401-a66649b35d60@leemhuis.info>
Date:   Fri, 22 Apr 2022 16:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [REGRESSION] Missing IRQ via amd_gpio
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <s5ha6cdtglj.wl-tiwai@suse.de>
 <e4c9bb60-210d-243a-e225-6b3546c0b42b@leemhuis.info>
In-Reply-To: <e4c9bb60-210d-243a-e225-6b3546c0b42b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1650637765;661b59ac;
X-HE-SMSGID: 1nhuHj-0000bB-DF
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.04.22 16:17, Thorsten Leemhuis wrote:
> Hi Takashi! Thx for CCing the regression list.
> 
> On 22.04.22 15:03, Takashi Iwai wrote:
>> Hi,
>>
>> we received a bug report for 5.17.3 kernel showing a new error:
>>
>>  amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x003D to IRQ, err -517
>>
>> Not only an error message but in practice this leads to a missing IRQ
>> assignment; the IRQ 27 is no longer assigned to amd_gpio driver.
>>
>> As the error number (EPROBE_DEFER) indicates, this seems to be the
>> side-effect of the recent fix, the upstream commit 5467801f1fcb
>> ("gpio: Restrict usage of GPIO chip irq members before
>> initialization").  As far as I understand, the problem is in
>> acpi_gpiochip_request_interrupts() call that is called from
>> gpiochip_add_irqchip() itself.  Since it's called before the
>> initialized flag set, it always fails now.
>>
>> Below is a temporary quick fix and it seems working.  But I'm not sure
>> whether I overlooked something obvious...
> 
> A patch that afaics will fix this hopefully should get merged really
> soon now:
> 
> https://lore.kernel.org/all/20220422131452.20757-1-mario.limonciello@amd.com/
> 
> See also v1:
> 
> https://lore.kernel.org/all/20220414025705.598-1-mario.limonciello@amd.com/

Sorry, I shouldn't have stripped the rest of the message, mario might be
interested in at least the link, so here it is:

>> -- 8< --
>> From: Takashi Iwai <tiwai@suse.de>
>> Subject: [PATCH] gpio: Fix missing IRQ assginment for ACPI gpiochip
>> 
>> The recent fix for gpiolib caused an error like:
>>   amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x003D to IRQ, err -517
>> It indicates -EPROBE_DEFER, and since the function
>> acpi_gpiochip_request_interrupts() doesn't handle the deferred probe,
>> this leads to the missing IRQs. 
>> 
>> The problem is that acpi_gpiochip_request_interrupts() itself is
>> called from gpiochip_add_irqchip() but before gc->irq.initialized flag
>> is set.  For fixing the regression, let's move the call of
>> acpi_gpiochip_request_interrupts() after the initialized flag setup.
>> 
>> Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members before initialization")
>> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1198697
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> ---
>>  drivers/gpio/gpiolib.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 085348e08986..b7694171655c 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -1601,8 +1601,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>>  
>>  	gpiochip_set_irq_hooks(gc);
>>  
>> -	acpi_gpiochip_request_interrupts(gc);
>> -
>>  	/*
>>  	 * Using barrier() here to prevent compiler from reordering
>>  	 * gc->irq.initialized before initialization of above
>> @@ -1612,6 +1610,8 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>>  
>>  	gc->irq.initialized = true;
>>  
>> +	acpi_gpiochip_request_interrupts(gc);
>> +
>>  	return 0;
>>  }
