Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3625511972
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiD0NhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiD0NhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:37:00 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E94049FA4;
        Wed, 27 Apr 2022 06:33:48 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.1.67])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 3FD17F98A9DE;
        Wed, 27 Apr 2022 15:33:46 +0200 (CEST)
Received: from [192.168.1.42] (88.125.132.16) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 15:33:45 +0200
Message-ID: <fc42f228-9fbc-be0d-7585-71c5a908c125@traphandler.com>
Date:   Wed, 27 Apr 2022 15:33:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <tzungbi@kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20220413082527.155740-1-jjhiblot@traphandler.com>
 <20220413082527.155740-3-jjhiblot@traphandler.com>
 <CAMuHMdXLpuoTiOn7yDwTTnjkqWJ4PXuhdCLiLcOP2uyzyV6==A@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAMuHMdXLpuoTiOn7yDwTTnjkqWJ4PXuhdCLiLcOP2uyzyV6==A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.125.132.16]
X-ClientProxiedBy: DAG4EX1.emp2.local (172.16.2.31) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 5060357132539935221
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefudekvedugffhteduvefhhffhkeejiedugedtheeuvefgvdegiedvieefvdenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlrdgvugifohhrthhhhiesrhgvnhgvshgrshdrtghomh
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/04/2022 14:32, Geert Uytterhoeven wrote:
> Hi Jean-Jacques,
>
> On Wed, Apr 13, 2022 at 10:25 AM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>
>> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
>> very limited timeout capabilities. However, it can reset the device.
>> To do so, the corresponding bits in the SysCtrl RSTEN register need to
>> be enabled. This is not done by this driver.
>>
>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Thanks for your patch!
>
>> --- /dev/null
>> +++ b/drivers/watchdog/rzn1_wdt.c
>> +static int rzn1_wdt_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct rzn1_watchdog *wdt;
>> +       struct device_node *np = dev->of_node;
>> +       struct clk *clk;
>> +       int ret;
>> +       int irq;
>> +
>> +       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> +       if (!wdt)
>> +               return -ENOMEM;
>> +
>> +       wdt->base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(wdt->base))
>> +               return PTR_ERR(wdt->base);
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0)
>> +               return irq;
>> +
>> +       ret = devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
>> +                              np->name, wdt);
>> +       if (ret) {
>> +               dev_err(dev, "failed to request irq %d\n", irq);
>> +               return ret;
>> +       }
>> +
>> +       clk = devm_clk_get(dev, NULL);
>> +       if (IS_ERR(clk)) {
>> +               dev_err(dev, "failed to get the clock\n");
>> +               return PTR_ERR(clk);
>> +       }
>> +
>> +       ret = clk_prepare_enable(clk);
>> +       if (ret) {
>> +               dev_err(dev, "failed to prepare/enable the clock\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = devm_add_action_or_reset(dev, rzn1_wdt_clk_disable_unprepare,
>> +                                      clk);
>> +       if (ret) {
>> +               dev_err(dev, "failed to register clock unprepare callback\n");
> Please remove this error message.
> devm_add_action_or_reset() only fails when running out of memory,
> in which case the memory allocation core has already printed an
> error message.

OK. I'll remove this.

Thanks,

JJ

>
>> +               return ret;
>> +       }
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
