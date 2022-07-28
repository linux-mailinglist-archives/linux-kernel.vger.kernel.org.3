Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4E55836BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiG1CUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiG1CUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:20:34 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCD7995BA;
        Wed, 27 Jul 2022 19:20:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C65111E80D89;
        Thu, 28 Jul 2022 10:20:35 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pEUBs0og3I2Z; Thu, 28 Jul 2022 10:20:32 +0800 (CST)
Received: from [172.30.18.178] (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 59D301E80D72;
        Thu, 28 Jul 2022 10:20:32 +0800 (CST)
Subject: Re: [PATCH] drm/amdkfd: use time_is_before_jiffies(a + b) to replace
 "jiffies - a > b"
To:     Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
References: <20220727025917.22477-1-yuzhe@nfschina.com>
 <17e02cd8-eba1-91b8-2506-91a7893ac967@amd.com>
From:   Yu Zhe <yuzhe@nfschina.com>
Message-ID: <69adb14d-9f70-b118-14b2-92de75596c38@nfschina.com>
Date:   Thu, 28 Jul 2022 10:20:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <17e02cd8-eba1-91b8-2506-91a7893ac967@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022年07月28日 00:04, Felix Kuehling 写道:

> This patch introduces a build warning for me:
>    CC [M]  drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_interrupt.o
> In file included from /home/fkuehlin/compute/kernel/include/linux/spinlock.h:54,
>                   from /home/fkuehlin/compute/kernel/include/linux/mmzone.h:8,
>                   from /home/fkuehlin/compute/kernel/include/linux/gfp.h:6,
>                   from /home/fkuehlin/compute/kernel/include/linux/slab.h:15,
>                   from /home/fkuehlin/compute/kernel/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_interrupt.c:44:
> /home/fkuehlin/compute/kernel/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_interrupt.c: In function ?interrupt_wq?:
> /home/fkuehlin/compute/kernel/include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
>     12 |  (void)(&__dummy == &__dummy2); \
>        |                  ^~
> /home/fkuehlin/compute/kernel/include/linux/jiffies.h:106:3: note: in expansion of macro ?typecheck?
>    106 |   typecheck(unsigned long, b) && \
>        |   ^~~~~~~~~
> /home/fkuehlin/compute/kernel/include/linux/jiffies.h:154:35: note: in expansion of macro ?time_after?
>    154 | #define time_is_before_jiffies(a) time_after(jiffies, a)
>        |                                   ^~~~~~~~~~
> /home/fkuehlin/compute/kernel/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_interrupt.c:159:7: note: in expansion of macro ?time_is_before_jiffies?
>    159 |   if (time_is_before_jiffies(start_jiffies + HZ)) {
>        |       ^~~~~~~~~~~~~~~~~~~~~~
> I think you need to change the the definition of start_jiffies to be
> unsigned long. Do you want to submit a v2 of your patch?

Yes, I will submit v2 patch later.

> That said, I think the existing code was fine, though the type-mismatch
> highlighted by your patch is a bit iffy.

And if the timer wrap changes in the future you won't have to alter your driver code. So I think it's better.

> Regards,
>    Felix
> Am 2022-07-26 um 22:59 schrieb Yu Zhe:
>> time_is_before_jiffies deals with timer wrapping correctly.
>> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
>> ---
>>    drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> index a9466d154395..6397926e059c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> @@ -156,7 +156,7 @@ static void interrupt_wq(struct work_struct *work)
>>        while (dequeue_ih_ring_entry(dev, ih_ring_entry)) {
>>            dev->device_info.event_interrupt_class->interrupt_wq(dev,
>>                                    ih_ring_entry);
>> -        if (jiffies - start_jiffies > HZ) {
>> +        if (time_is_before_jiffies(start_jiffies + HZ)) {
>>                /* If we spent more than a second processing signals,
>>                 * reschedule the worker to avoid soft-lockup warnings
>>                 */
>
