Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F18B4D9B45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348334AbiCOMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244027AbiCOMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:33:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6886B53724;
        Tue, 15 Mar 2022 05:32:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 35C561F432E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647347531;
        bh=1Z3WYmtSapkUOqcYSarNv4HhyfNYFIDqEsyWSavyPgs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ljGdw3Ip+jr3Z4dGZZUGMysJ+M2BzVVuJE8e9k7oreSzkN9AwXZSlSUw3rtBuXK7K
         aTVbvMNkf4+pwj9IohhLu/wL1ppVDDUJiQisksYl7WNes+xpU+JK4nAEaC+nmWMhUG
         2Sc4gNxaqHsLSQqYU3/+2n/UEm6xlN7ZN0iDgxaLCGjfVvz58eEKzRzEsflWFjY2AV
         WTTQpNzIzQfRD9oNhSoBHkkYNHqIBXd0uc5LQd2T4aRvHIZHiTZtxBz6900x0QVPLm
         p4R8LtCqPF4iipRO7nsvutLgNzQv+Hqt+oyjRBLvzb72X6V/LHTA3K/he4G7FwJU4q
         R3Jn2QKzQ/1RQ==
Subject: Re: [PATCH v2] gpio: Restrict usage of gc irq members before
 initialization
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, krisman@collabora.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20220315103813.84407-1-shreeya.patel@collabora.com>
 <CAHp75VdoN+iSu1GLnxWW9BtL-p9uF1sfAw3ZxkFWNpoo44+bZg@mail.gmail.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <b22cea07-aa2e-f5b5-d5aa-071e1084f00b@collabora.com>
Date:   Tue, 15 Mar 2022 18:02:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdoN+iSu1GLnxWW9BtL-p9uF1sfAw3ZxkFWNpoo44+bZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/03/22 4:30 pm, Andy Shevchenko wrote:
> On Tue, Mar 15, 2022 at 12:38 PM Shreeya Patel
> <shreeya.patel@collabora.com> wrote:
>
> Thanks for the update, my comments below.
>
>> gc irq members are exposed before they could be completely
> gc --> GPIO chip
>
>
>> initialized and this leads to race conditions.
> Any example here. like ~3-4 lines of the Oops in question?
>
>> One such issue was observed for the gc->irq.domain variable which
>> was accessed through the I2C interface in gpiochip_to_irq() before
>> it could be initialized by gpiochip_add_irqchip(). This resulted in
>> Kernel NULL pointer dereference.
>>
>> To avoid such scenarios, restrict usage of gc irq members before
> gc --> GPIO chip
>
>> they are completely initialized.
> ...
>
>> +       /*
>> +        * Using barrier() here to prevent compiler from reordering
>> +        * gc->irq.gc_irq_initialized before initialization of above
>> +        * gc irq members.
>> +        */
>> +       barrier();
>> +
>> +       gc->irq.gc_irq_initialized = true;
> There are too many duplications. Why not simply call it 'initialized'?
>
>> -       if (gc->to_irq) {
>> +       if (gc->to_irq && gc->irq.gc_irq_initialized) {
> Why can't this check be added into gpiochip_to_irq() ?
>
>      if (!gc->irq.initialized)
>          return -ENXIO;
>
> ...


Because we don't want to return -ENXIO in case of race condition.

It should return -EPROBE_DEFER similar to how we are doing when gc->to_irq
is NULL.

So in this case when both gc->to_irq = NULL and gc->irq.initialized = FALSE,
we will be returning -EPROBE_DEFER. This will make sure that devices 
like touchscreen
do not become fatal due to returning -ENXIO.

>
>> +       bool gc_irq_initialized;
> Can you move it closer to .init_hw so it will be weakly grouped by
> logic similarities?
> Also see above.

Thanks for your comments, I'll make the necessary changes and send a v3.



Shreeya Patel


