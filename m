Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796FE545BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbiFJFxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243710AbiFJFxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:53:05 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C46B5C65D;
        Thu,  9 Jun 2022 22:53:03 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25A5qxCv060735;
        Fri, 10 Jun 2022 00:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654840379;
        bh=0fIRRl1QTOUs4hyP2zBUCxjB4G7FbYWfjqnJT01UtYg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=OVswT/XaTicQdoy3rfmp3PwhR+Qlhhem/tePc70Mzs/vyfdTVFiu1l9kUUnw9NZ9E
         TSVvZuoKpxrJXJOkVqBkxSJhUsHCy/utx/GJIOASje8+QT//xTOUzn70YSZ5SOw32c
         kXd/sO/2zJIHxGRIprR4DQy6/DxgB+0oDUkE7cgI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25A5qx1I022690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jun 2022 00:52:59 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 10
 Jun 2022 00:52:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 10 Jun 2022 00:52:59 -0500
Received: from [172.24.145.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25A5quLX120544;
        Fri, 10 Jun 2022 00:52:57 -0500
Message-ID: <140522b0-6b17-0c11-ace7-a3c3f4606ccb@ti.com>
Date:   Fri, 10 Jun 2022 11:22:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] gpio: davinci: Add support for system suspend/resume PM
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Devarsh Thakkar <devarsht@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220607060851.10838-1-a-govindraju@ti.com>
 <CAMRc=Mdcqu5__eZPQSP3egEpw=axeeAFgGjgKdChj6tN5v1Asg@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <CAMRc=Mdcqu5__eZPQSP3egEpw=axeeAFgGjgKdChj6tN5v1Asg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 09/06/22 20:05, Bartosz Golaszewski wrote:
> On Tue, Jun 7, 2022 at 8:08 AM Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> From: Devarsh Thakkar <devarsht@ti.com>
>>
>> Add support for system suspend/resume PM hooks, save the
>> register context of all the required gpio registers on suspend
>> and restore the context on resume.
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  drivers/gpio/gpio-davinci.c | 84 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 84 insertions(+)
>>
>> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
>> index f960587f86a3..aca352337c46 100644
>> --- a/drivers/gpio/gpio-davinci.c
>> +++ b/drivers/gpio/gpio-davinci.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/irqchip/chained_irq.h>
>>  #include <linux/spinlock.h>
>>
>> +#include <linux/pm_runtime.h>
> 
> The below can stay here but please move the pm_runtime include
> together with the other linux includes.
> 

moved this in the respin.

>>  #include <asm-generic/gpio.h>
>>
>>  #define MAX_REGS_BANKS 5
>> @@ -62,6 +63,8 @@ struct davinci_gpio_controller {
>>         void __iomem            *regs[MAX_REGS_BANKS];
>>         int                     gpio_unbanked;
>>         int                     irqs[MAX_INT_PER_BANK];
>> +       struct davinci_gpio_regs context[MAX_REGS_BANKS];
>> +       u32                     binten_context;
>>  };
>>
>>  static inline u32 __gpio_mask(unsigned gpio)
>> @@ -622,6 +625,86 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
>>         return 0;
>>  }
>>
>> +static void davinci_gpio_save_context(struct davinci_gpio_controller *chips,
>> +                                     u32 nbank)
>> +{
>> +       struct davinci_gpio_regs __iomem *g = NULL;
>> +       struct davinci_gpio_regs *context = NULL;
>> +       u32 bank = 0;
>> +       void __iomem *base = NULL;
> 
> Only initialize variables that need it, please.
> 

Removed the intializations in the respin.


Thank you for reviewing the patch. I have posted a respin v2,

https://patchwork.ozlabs.org/project/linux-gpio/patch/20220610054622.21281-1-a-govindraju@ti.com/

Regards,
Aswath

>> +
>> +       base = chips->regs[0] - offset_array[0];
>> +       chips->binten_context = readl_relaxed(base + BINTEN);
>> +
>> +       for (bank = 0; bank < nbank; bank++) {
>> +               g = chips->regs[bank];
>> +               context = &chips->context[bank];
>> +               context->dir = readl_relaxed(&g->dir);
>> +               context->set_data = readl_relaxed(&g->set_data);
>> +               context->set_rising = readl_relaxed(&g->set_rising);
>> +               context->set_falling = readl_relaxed(&g->set_falling);
>> +       }
>> +
>> +       /* Clear Bank interrupt enable bit */
>> +       writel_relaxed(0, base + BINTEN);
>> +
>> +       /* Clear all interrupt status registers */
>> +       writel_relaxed(0xFFFFFFFF, &g->intstat);
>> +}
>> +
>> +static void davinci_gpio_restore_context(struct davinci_gpio_controller *chips,
>> +                                        u32 nbank)
>> +{
>> +       struct davinci_gpio_regs __iomem *g = NULL;
>> +       struct davinci_gpio_regs *context = NULL;
>> +       u32 bank = 0;
>> +       void __iomem *base = NULL;
>> +
>> +       base = chips->regs[0] - offset_array[0];
>> +
>> +       if (readl_relaxed(base + BINTEN) != chips->binten_context)
>> +               writel_relaxed(chips->binten_context, base + BINTEN);
>> +
>> +       for (bank = 0; bank < nbank; bank++) {
>> +               g = chips->regs[bank];
>> +               context = &chips->context[bank];
>> +               if (readl_relaxed(&g->dir) != context->dir)
>> +                       writel_relaxed(context->dir, &g->dir);
>> +               if (readl_relaxed(&g->set_data) != context->set_data)
>> +                       writel_relaxed(context->set_data, &g->set_data);
>> +               if (readl_relaxed(&g->set_rising) != context->set_rising)
>> +                       writel_relaxed(context->set_rising, &g->set_rising);
>> +               if (readl_relaxed(&g->set_falling) != context->set_falling)
>> +                       writel_relaxed(context->set_falling, &g->set_falling);
>> +       }
>> +}
>> +
>> +static int __maybe_unused davinci_gpio_suspend(struct device *dev)
>> +{
>> +       struct davinci_gpio_controller *chips = dev_get_drvdata(dev);
>> +       struct davinci_gpio_platform_data *pdata = dev_get_platdata(dev);
>> +       u32 nbank = DIV_ROUND_UP(pdata->ngpio, 32);
>> +
>> +       davinci_gpio_save_context(chips, nbank);
>> +
>> +       return 0;
>> +}
>> +
>> +static int __maybe_unused davinci_gpio_resume(struct device *dev)
>> +{
>> +       struct davinci_gpio_controller *chips = dev_get_drvdata(dev);
>> +       struct davinci_gpio_platform_data *pdata = dev_get_platdata(dev);
>> +       u32 nbank = DIV_ROUND_UP(pdata->ngpio, 32);
>> +
>> +       davinci_gpio_restore_context(chips, nbank);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct dev_pm_ops davinci_gpio_dev_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(davinci_gpio_suspend, davinci_gpio_resume)
>> +};
>> +
>>  static const struct of_device_id davinci_gpio_ids[] = {
>>         { .compatible = "ti,keystone-gpio", keystone_gpio_get_irq_chip},
>>         { .compatible = "ti,am654-gpio", keystone_gpio_get_irq_chip},
>> @@ -634,6 +717,7 @@ static struct platform_driver davinci_gpio_driver = {
>>         .probe          = davinci_gpio_probe,
>>         .driver         = {
>>                 .name           = "davinci_gpio",
>> +               .pm = &davinci_gpio_dev_pm_ops,
>>                 .of_match_table = of_match_ptr(davinci_gpio_ids),
>>         },
>>  };
>> --
>> 2.17.1
>>
> 
> Bart
