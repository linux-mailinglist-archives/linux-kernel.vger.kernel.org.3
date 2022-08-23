Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F111B59CEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbiHWCuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiHWCuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:50:18 -0400
Received: from mail-m11885.qiye.163.com (mail-m11885.qiye.163.com [115.236.118.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500135A3D4;
        Mon, 22 Aug 2022 19:50:16 -0700 (PDT)
Received: from [192.168.111.100] (unknown [58.22.7.114])
        by mail-m11885.qiye.163.com (Hmail) with ESMTPA id D79B04C0485;
        Tue, 23 Aug 2022 10:50:13 +0800 (CST)
Message-ID: <5cb0a457-b667-76e5-d383-6e93457d5d12@rock-chips.com>
Date:   Tue, 23 Aug 2022 10:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/2] gpio/rockchip: Toggle edge trigger mode after acking
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>
References: <20220820095933.20234-1-jeffy.chen@rock-chips.com>
 <20220820095933.20234-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X0qJ2OC1SrAmhSQ5YeKEwvsSCbfVGPh457YYEuPCbRtg@mail.gmail.com>
Content-Language: en-US
From:   Chen Jeffy <jeffy.chen@rock-chips.com>
In-Reply-To: <CAD=FV=X0qJ2OC1SrAmhSQ5YeKEwvsSCbfVGPh457YYEuPCbRtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSk9MVkgdHUofSh5PTE9KHVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITkhVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDI6Qhw6Sj08AQkwShYuEjkN
        QwMwCUJVSlVKTU1KSUlIS0pPTktLVTMWGhIXVREeHR0CVRgTHhU7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQ01LNwY+
X-HM-Tid: 0a82c89b8ecb2eb9kusnd79b04c0485
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

It's been a long time, hope you're doing well :)

On 8/23 星期二 1:08, Doug Anderson wrote:
> Hi,
> 
> On Sat, Aug 20, 2022 at 3:07 AM Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>>
>> Otherwise the trigger mode might be out-of-sync when a level change
>> occurred in between.
>>
>> Fixes: 53b1bfc76df2 ("pinctrl: rockchip: Avoid losing interrupts when supporting both edges")
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   drivers/gpio/gpio-rockchip.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
>> index a98351cd6821..736b4d90f1ca 100644
>> --- a/drivers/gpio/gpio-rockchip.c
>> +++ b/drivers/gpio/gpio-rockchip.c
>> @@ -338,7 +338,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
>>                  irq = __ffs(pend);
>>                  pend &= ~BIT(irq);
>>
>> -               dev_dbg(bank->dev, "handling irq %d\n", irq);
>> +               generic_handle_domain_irq(bank->domain, irq);
>>
>>                  /*
>>                   * Triggering IRQ on both rising and falling edge
>> @@ -370,8 +370,6 @@ static void rockchip_irq_demux(struct irq_desc *desc)
>>                                                       bank->gpio_regs->ext_port);
>>                          } while ((data & BIT(irq)) != (data_old & BIT(irq)));
>>                  }
>> -
>> -               generic_handle_domain_irq(bank->domain, irq);
> 
> I'm happy to let others say for sure, but from my point of view I'm
> not convinced. It feels like with your new code you could lose edges.
> 
> The abstraction I always assume for edge triggered interrupts is that
> multiple edges are coalesced into one IRQ but that if an edge comes in
> after the first line of the IRQ handler starts executing then the IRQ
> handler will run again. In other words:
> 
> - edge A
> - edge B
> - IRQ handler starts running (once for A/B)
> - IRQ handler finishes running
> - <idle>
> - edge C
> - IRQ handler starts running (for C)
> - edge D
> - edge E
> - IRQ handler finishes running
> - IRQ handler starts running (for D/E)
> - IRQ handler finishes running
> - <idle>

The thing is, we are currently toggling the trigger mode to make sure it 
matches the current GPIO level (e.g. level low -> rising edge mode), 
than ack it in gpio IRQ handler.

So if an edge come in between, that new IRQ status would be 
acked(cleared) in the following GPIO irq handler as well as the old one, 
without triggering another IRQ demux() to toggle the trigger mode.

- rising edge
- toggle to falling edge mode
- GPIO high with falling edge mode <-- correct
- falling edge
- IRQ handler acked that IRQ
- IRQ handler finished
- GPIO low with falling edge mode <-- oops
- rising edge <-- missed

> 
> For your new code I don't think that will necessarily be the case. I
> think this can happen with your new code:
> 
> - rising edge
> - IRQ handler starts running for rising edge
> - IRQ handler finishes running for rising edge
> - falling edge (not latched since we're looking for rising edges)
> - notice that level is low
> - keep it configured for rising edge
> 
> ...in other words an edge happened _after_ the IRQ handler ran but we
> didn't call the IRQ handler again. I don't think this is right.
> 

Right, so guessing we could somehow move the IRQ ack into the toggling 
flow to make sure that it would not clear the new IRQ?

And it looks like there are quite a few drivers having this kind of 
need, would it make sense to handle it in the framework?

> 
> What problem are you trying to solve?
> 
> -Doug
> 

