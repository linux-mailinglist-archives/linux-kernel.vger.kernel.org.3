Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D496246CC52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbhLHEZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:25:04 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20243 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240015AbhLHEZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638937292; x=1670473292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WGYUwENwhwrcTAj8R8NXzjceL6AMSrTKjaF2zNQQDF8=;
  b=mn7VBN6Imnn6T2VenU8Z2Ys4wDr70KWDpr73yU9LUsilF1jAC8jPz59+
   c4Pu6BnuHhOp3WyqFRSyuKus994NoCdSfiPJTS3DJv9UpkfyMlULfbpsU
   uVc7z0ehp2MubH3pOqdShzFncgPpjFPv9z50+MWjknKjWObI5cVevp02R
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 07 Dec 2021 20:21:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 20:21:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 20:21:16 -0800
Received: from [10.48.241.161] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 7 Dec 2021
 20:21:15 -0800
Message-ID: <12bf346e-9807-dbce-0c66-7974001896c1@quicinc.com>
Date:   Tue, 7 Dec 2021 20:21:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] clk: Fix children not voting entire parent chain during
 init
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, <mturquette@baylibre.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211109043438.4639-1-quic_mdtipton@quicinc.com>
 <20211208015324.86282C341C5@smtp.kernel.org>
From:   Mike Tipton <quic_mdtipton@quicinc.com>
In-Reply-To: <20211208015324.86282C341C5@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2021 5:53 PM, Stephen Boyd wrote:
> Quoting Mike Tipton (2021-11-08 20:34:38)
>> If a child's parent is set by calling __clk_init_parent() while the
>> parent is still being registered in __clk_register(), then it can result
>> in the child voting its direct parent without those votes propagating up
>> the entire parent chain.
> 
> More details please!

Sure, will be happy to provide more. There are several ways in which the 
race can manifest, so I initially just tried to stick to the high-level 
summary. But I'll try to provide more details.

> 
>>
>> __clk_register() sets hw->core before grabbing the prepare_lock and
>> before initializing hw->core->parent. Since hw->core is used indirectly
>> by __clk_init_parent(), then children can find their parents before
>> they're fully initialized. If children vote for their parents during
>> this window, then those votes won't propagate past the direct parent.
> 
> Is the crucial detail that's missing here the fact that we now let
> __clk_init_parent() find a struct clk_hw before that clk has been
> published to the clk tree in __clk_core_init()? I can see the following
> scenario

Essentially, yes.

> 
> 	struct clk_hw clkBad;
> 	struct clk_hw clkA;
> 
> 	clkA.init.parent_hws = { &clkBad }
> 
> 	clk_hw_register(&clkA);
> 
> And now clkA has a reference to clkBad in the clk tree but the clk isn't
> published to the clk tree yet. Except, clk_core_fill_parent_index() will
> fail to find the parent because hw->core isn't set yet. So now I'll
> write up a two CPU scenario to try to clarify.
> 
> 
>    CPU0                                     CPU1
>    ----                                     ----
>    struct clk_hw clkBad;
>    struct clk_hw clkA;
>    
>    clkA.init.parent_hws = { &clkBad };
>    
>    clk_hw_register(&clkA)                   clk_hw_register(&clkBad)
>                                              __clk_register()
> 					     hw->core = core
> 					     ...
>     __clk_register()
>      __clk_core_init()
>       clk_prepare_lock()
>       __clk_init_parent()
>        clk_core_get_parent_by_index()
>         clk_core_fill_parent_index()
>          if (entry->hw) {
> 	 parent = entry->hw->core;
> 	 <boom>

Yes, that's one problematic scenario. Not the specific one we were 
hitting, but it's one of them. More details on one of our specific 
scenarios below.

> 
>>
>> This can happen when:
>>      1. CRITICAL clocks are enabled in __clk_core_init().
>>      2. Reparenting enabled orphans in clk_core_reparent_orphans_nolock().
> 
> I didn't really follow these two points. I guess you're saying this is a
> problem if we're enabling critical clks and the parents aren't
> registered yet or we're reparenting a whole subtree into the clk tree
> but they're still technically orphans because the parent isn't
> registered.

Normally, if the parent isn't registered yet then there's no problem, 
since an enabled orphan will just propagate the enable/prepare counts to 
the parent once the parent is registered and orphan reparented. The 
problem comes when the parent is only partially initialized with just 
hw->core set.

My points above aren't actually exhaustive. If the child->parent crosses 
providers, then even normal client calls to clk_prepare()/clk_enable() 
could trigger the race condition. But for the issues we were seeing, the 
problematic orphan/parent pair was within a single provider. And the 
orphan in that case is only temporary until after the provider is 
finished initializing. And before it's finished initializing we haven't 
added the provider yet, so clients wouldn't be able to request these 
clocks in this problematic state. But points (1) and (2) are ways that 
can trigger this situation without client involvement while the provider 
is still being initialized.

Here's a concrete example of one of the scenarios we hit. A provider is 
in the middle of registering its clocks (including some temporary 
orphans) when another unrelated provider is added.

CPU0                                           CPU1
----                                           ----
                                                <orphan registered>
                                                <orphan enabled>
of_clk_add_hw_provider()
  clk_core_reparent_orphans()
   clk_prepare_lock()
                                                clk_hw_register(&parent)
                                                 __clk_register()
                                                  hw->core = core
   clk_core_reparent_orphans_nolock()
    parent = __clk_init_parent(orphan)
    if (parent) {
     __clk_set_parent_before(orphan, parent);
      if (core->prepare_count) {
       clk_core_prepare_enable(parent);
       <boom>

While reparenting orphans, CPU0 finds the direct parent since CPU1 has 
set the parent's hw->core. And since the orphan is already prepared, it 
propagates the prepare/enable counts to the new parent. But since the 
parent hasn't finished __clk_core_init() yet, then we haven't set the 
*parent's* parent yet. So the propagation stops early. Later, when the 
child is disabled after the parent has finished initializing, then the 
disable/unprepare calls *are* propagated fully. But since we never 
propagated all the enable/prepare calls, then there's a mismatch and we 
get "already disabled" or "already unprepared" warnings on the parents 
and return errors to the clients.

There are more possible cases than just these. So I should probably just 
describe the underlying problem a bit more clearly and not try to 
enumerate each possible resulting race.

> 
>>
>> Fix this by not setting hw->core until we've already grabbed the
>> prepare_lock in __clk_core_init(). This prevents orphaned children from
>> finding and voting their parents before the parents are fully
>> initialized.
>>
>> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
> 
> Thanks! Looks correct. It would be good to describe how this commit
> broke it though. Something like:
> 
> When parent clks could only be found via string name we had to wait
> until the parent clk was added to a list in __clk_core_init() before we
> could find it, but after commit fc0c209c147f ("clk: Allow parents to be
> specified without string names") the parent clk can be found once we set
> hw->core in __clk_register().

Sure, I can add more details here.

> 
>> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
>> ---
>>
>> This is very difficult to reproduce. We can't reproduce it at all
>> internally, in fact. But some customers are able to reproduce it fairly
>> easily and this patch fixes it for them.
> 
> This doesn't instill very much confidence in the fix if you can't
> reproduce it and can't describe the scenario where it happens. It would
> have helped signal boost the patch if the customers could reply to the
> list indicating this fixes things for them with tested-by tags :(

We can't reproduce it in-house reliably, but we have multiple customers 
who *can* reproduce it reliably in their test farms with multiple hits 
per-day. We've had no reports from them after merging this patch. Some 
customers have been running with this for over a month without any new 
occurrences.

> 
>>
>>   drivers/clk/clk.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index f467d63bbf1e..af562af9d54d 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -3418,6 +3418,13 @@ static int __clk_core_init(struct clk_core *core)
>>   
>>          clk_prepare_lock();
>>   
>> +       /*
>> +        * Set hw->core after grabbing the prepare_lock to prevent race
>> +        * conditions with orphans finding and voting their parents before the
>> +        * parents are fully initialized.
> 
> Let's make this comment better by talking about
> clk_core_fill_parent_index() only caring if hw->core is set to a
> non-NULL value. "race conditions" is nebulous.

Sure, I can update this comment to be more specific.

> 
>> +        */
>> +       core->hw->core = core;
>> +
>>          ret = clk_pm_runtime_get(core);
>>          if (ret)
>>                  goto unlock;
>> @@ -3582,8 +3589,10 @@ static int __clk_core_init(struct clk_core *core)
>>   out:
>>          clk_pm_runtime_put(core);
>>   unlock:
>> -       if (ret)
>> +       if (ret) {
>>                  hlist_del_init(&core->child_node);
>> +               core->hw->core = NULL;
>> +       }
>>   
>>          clk_prepare_unlock();
>>   
>> @@ -3847,7 +3856,6 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>>          core->num_parents = init->num_parents;
>>          core->min_rate = 0;
>>          core->max_rate = ULONG_MAX;
>> -       hw->core = core;
>>   
>>          ret = clk_core_populate_parent_map(core, init);
>>          if (ret)
>> @@ -3865,7 +3873,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>>                  goto fail_create_clk;
>>          }
>>   
>> -       clk_core_link_consumer(hw->core, hw->clk);
>> +       clk_core_link_consumer(core, hw->clk);
>>   
>>          ret = __clk_core_init(core);
>>          if (!ret)
> 
> Let me see if I can fix this up on application >
