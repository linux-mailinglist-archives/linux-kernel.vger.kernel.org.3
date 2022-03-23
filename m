Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184264E5011
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiCWKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiCWKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:12:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A0987666C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:10:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0DD823A;
        Wed, 23 Mar 2022 03:10:49 -0700 (PDT)
Received: from [10.57.39.153] (unknown [10.57.39.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29DB73F73B;
        Wed, 23 Mar 2022 03:10:48 -0700 (PDT)
Message-ID: <a704e21e-c1a6-6ffd-439c-e715a2633319@arm.com>
Date:   Wed, 23 Mar 2022 10:10:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] cpu/hotplug: Set st->cpu earlier
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20220316153637.288199-1-steven.price@arm.com>
 <878rt2atre.ffs@tglx> <bc66bee6-7c99-b289-f5e9-ccaf03d5605d@arm.com>
 <87wngla932.ffs@tglx>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <87wngla932.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look at this.

On 22/03/2022 22:58, Thomas Gleixner wrote:
> On Tue, Mar 22 2022 at 15:59, Vincent Donnefort wrote:
>> On 22/03/2022 15:31, Thomas Gleixner wrote:
>>> On Wed, Mar 16 2022 at 15:36, Steven Price wrote:
>>>> Setting the 'cpu' member of struct cpuhp_cpu_state in cpuhp_create() is
>>>> too late as other callbacks can be made before that point.
>>>
>>> What?
>>>
>>>          CPUHP_OFFLINE = 0,
>>>          CPUHP_CREATE_THREADS,
>>>
>>> The create threads callback is the very first callback which is invoked
>>> for a to be plugged CPU on the control CPU. So which earlier callback
>>> can be invoked and fail?
>>>
>>> Thanks,
>>>
>>>          tglx
>>
>>
>> CPUHP_CREATE_THREADS itself can fail, before st->cpu is set.
> 
> Sure. But that does not explain the problem.
> 
>> Also, that value is used outside of the callbacks (cpuhp_set_state()
>> in _cpu_up()).
> 
> And why on earth is this not spelled out in the changelog?

I apologies for that, I'm not very familiar with the code and I have to
admit I have been struggling to identify exactly what is going on here.
The actual issue I saw was if the callback fails then the rollback code
leaves things in a messed up state. By the looks of things that callback
that fails is indeed the first (CPUHP_CREATE_THREADS).

>> But indeed this description could be refined a bit.
> 
> Indeed. But the description is not the only problem here:
> 
> It's completely uncomprehensible from the code in _cpu_up() _WHY_ this
> 
>      st->cpu = cpu;
>      
> assignment has to be there.
> 
> It's non-sensical if you really think about it, right?

I entirely agree, and I did ask in my v1 posting[1] if anyone could
point me to a better place to do the assignment. Vincent suggested
moving it earlier in _cpu_up() which is this v2.

But it still seems out-of-place to me. I've just had a go at simply
removing the 'cpu' member and it doesn't look too bad. I'll post that
patch as a follow up. I'm open to other suggestions for the best way to
fix this.

Thanks,

Steve

[1]
https://lore.kernel.org/all/20220225134918.105796-1-steven.price@arm.com/

> That said, I'm pretty sure you can come up with:
> 
>  - a proper one time initialization of @st which solves your problem
> 
>  - a proper changelog which explains it
> 
> Thanks,
> 
>         tglx

