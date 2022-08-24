Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D359F898
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiHXL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiHXL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:27:10 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BE7FF9D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:27:08 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id QoXGo4BrMTLjwQoXGoElgv; Wed, 24 Aug 2022 13:27:07 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Aug 2022 13:27:07 +0200
X-ME-IP: 90.11.190.129
Message-ID: <c74a42f7-7d9a-6b52-85b2-d87dacd91be6@wanadoo.fr>
Date:   Wed, 24 Aug 2022 13:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Content-Language: en-US
To:     Conor.Dooley@microchip.com, Daire.McNamara@microchip.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org
References: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
 <f76fb247-5160-61ed-a0a3-037d2f40d2f9@microchip.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <f76fb247-5160-61ed-a0a3-037d2f40d2f9@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/08/2022 à 11:58, Conor.Dooley@microchip.com a écrit :
> Hey Christope,
> Thanks for your patch.
> 
> On 24/08/2022 09:18, Christophe JAILLET wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> The devm_clk_get_enabled() helper:
>>      - calls devm_clk_get()
>>      - calls clk_prepare_enable() and registers what is needed in order to
>>        call clk_disable_unprepare() when needed, as a managed resource.
>>
>> This simplifies the code, the error handling paths and avoid the need of
>> a dedicated function used with devm_add_action_or_reset().
>>
>> That said, mpfs_rtc_init_clk() is the same as devm_clk_get_enabled(), so
>> use this function directly instead.
> 
> Firstly, I think something is missing from the commit description here.
> devm_clk_get_enabled() is not just a blanket "use this instead of get(),
> prepare_enable()" & is only intended for cases where the clock would
> be kept prepared or enabled for the whole lifetime of the driver. I think
> it is worth pointing that out to help people who do not keep up with
> every helper that is added.

Ok, I'll update my commit log for other similar patches or should a v2 
be needed.

> 
> I had a bit of a look through the documentation to see if the block would
> keep track of time without the AHB clock enabled, but it does not seem to.
> There is no reason to turn off the clock here (in fact it would seem
> counter productive to disable it..) so it looks like the shoe fits in that
> regard.
> 
> However...
> 
>>
>> This also fixes an (unlikely) unchecked devm_add_action_or_reset() error.
>>
>> Based on my test with allyesconfig, this reduces the .o size from:
>>      text    data     bss     dec     hex filename
>>      5330    2208       0    7538    1d72 drivers/rtc/rtc-mpfs.o
>> down to:
>>      5074    2208       0    7282    1c72 drivers/rtc/rtc-mpfs.o
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> devm_clk_get_enabled() is new and is part of 6.0-rc1
>> ---
>>    drivers/rtc/rtc-mpfs.c | 19 +------------------
>>    1 file changed, 1 insertion(+), 18 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
>> index 944ad1036516..2a479d44f198 100644
>> --- a/drivers/rtc/rtc-mpfs.c
>> +++ b/drivers/rtc/rtc-mpfs.c
>> @@ -193,23 +193,6 @@ static int mpfs_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>>           return 0;
>>    }
>>
>> -static inline struct clk *mpfs_rtc_init_clk(struct device *dev)
>> -{
>> -       struct clk *clk;
>> -       int ret;
>> -
>> -       clk = devm_clk_get(dev, "rtc");
>> -       if (IS_ERR(clk))
>> -               return clk;
>> -
>> -       ret = clk_prepare_enable(clk);
>> -       if (ret)
>> -               return ERR_PTR(ret);
>> -
>> -       devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
> 
> ... this bit here concerns me a little. I don't think we should be
> registering a callback here at all - if we power down Linux this is
> going to end up stopping the RTC isn't it?
> 
> I think this is left over from the v1 driver submission that reset
> the block during probe & should be removed.

My point is only that what is done must be undone at some point.

What if an error occurs in the probe after the clk_get("rtc")?
Is there any point keeping it prepared and enabled?


There is a .remove function in this driver, so, it looks that it is 
expected that it can be unloaded.

So undoing this clk operations via a managed resource looks the correct 
thing to do.

Just my 2c, you must know this driver and the expected behavior better 
than me.

CJ

> 
> Thanks,
> Conor.
> 
>> -       return clk;
>> -}
>> -
>>    static irqreturn_t mpfs_rtc_wakeup_irq_handler(int irq, void *dev)
>>    {
>>           struct mpfs_rtc_dev *rtcdev = dev;
>> @@ -251,7 +234,7 @@ static int mpfs_rtc_probe(struct platform_device *pdev)
>>           /* range is capped by alarm max, lower reg is 31:0 & upper is 10:0 */
>>           rtcdev->rtc->range_max = GENMASK_ULL(42, 0);
>>
>> -       clk = mpfs_rtc_init_clk(&pdev->dev);
>> +       clk = devm_clk_get_enabled(&pdev->dev, "rtc");
>>           if (IS_ERR(clk))
>>                   return PTR_ERR(clk);
>>
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

