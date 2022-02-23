Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C64C17BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiBWPvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiBWPvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:51:18 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D1C12FD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645631451; x=1677167451;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=275kG1B43cmbHLrhV54SbLKC/9pKr9oKpKf6fSRnus4=;
  b=LJD7LmQHohdoU0Z4rYRFbBhakOTlB+OkyadoiaYog3H4PqY5gXLlJI8/
   xNFWS3inu5EO0gFgP1kx8VnEn1BGU/6GTJycBY21/gCLHBMAEkhwnsUQt
   0UTLKdGfDfP76p4rN89EvXamOFz0lUfZfOujdXNv4CHhvwFhJOLMyjSz2
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 07:50:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:50:50 -0800
Received: from [10.216.51.220] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 23 Feb
 2022 07:50:47 -0800
Message-ID: <e75ed72f-9f4f-00cf-9935-640fbef21e69@quicinc.com>
Date:   Wed, 23 Feb 2022 21:20:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] softirq: Remove raise_softirq from
 tasklet_action_common()
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <paulmck@kernel.org>, <will@kernel.org>,
        <dave@stgolabs.net>
References: <1644066805-17212-1-git-send-email-quic_mojha@quicinc.com>
 <20220208230455.GA539926@lothringen>
 <28cbffc9-dcd4-60ac-897a-d1b1604de22c@quicinc.com>
In-Reply-To: <28cbffc9-dcd4-60ac-897a-d1b1604de22c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/2022 4:48 PM, Mukesh Ojha wrote:
>
> On 2/9/2022 4:34 AM, Frederic Weisbecker wrote:
>> On Sat, Feb 05, 2022 at 06:43:25PM +0530, Mukesh Ojha wrote:
>>> Think about a scenario when all other cores are in suspend
>>> and one core is only running ksoftirqd and it is because
>>> some client has invoked tasklet_hi_schedule() only once
>>> during that phase.
>>>
>>> tasklet_action_common() handles that softirq and marks the
>>> same softirq as pending again. And due to that core keeps
>>> running the softirq handler [1] forever and it is not able to
>>> go to suspend.
>>>
>>> We can get rid of raising softirq from tasklet handler.
>>>
>>> [1]
>>> <idle>-0    [003]   13058.769081:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13058.769085: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13058.769087:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13058.769091:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13058.769094: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13058.769097:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13058.769100:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13058.769103: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13058.769106:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13058.769109:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13059.058923:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> ...
>>> ..
>>> ..
>>> ..
>>>
>>> <idle>-0    [003]   13059.058951:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13059.058954: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13059.058957:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13059.058960:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13059.058963: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13059.058966:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13059.058969:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13059.058972: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13059.058975:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13059.058978:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13059.058981: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13059.058984:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13059.058987:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13059.058990: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13059.058993:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>> <idle>-0    [003]   13059.058996:  softirq_entry vec=0  
>>> action=HI_SOFTIRQ
>>> <idle>-0     [003]  13059.059000: softirq_raise: vec=0 
>>> [action=HI_SOFTIRQ]
>>> <idle>-0    [003]   13059.059002:  softirq_exit   vec=0 
>>> action=HI_SOFTIRQ
>>>
>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> ---
>>>   kernel/softirq.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>>> index 41f4709..d3e6fb9 100644
>>> --- a/kernel/softirq.c
>>> +++ b/kernel/softirq.c
>>> @@ -795,7 +795,6 @@ static void tasklet_action_common(struct 
>>> softirq_action *a,
>>>           t->next = NULL;
>>>           *tl_head->tail = t;
>>>           tl_head->tail = &t->next;
>>> -        __raise_softirq_irqoff(softirq_nr);
>>>           local_irq_enable();
>> That requeue happens when the tasklet is already executing on some 
>> other CPU
>> or when it has been disabled through tasklet_disable().
>>
>> So you can't just remove that line or you'll break everything.
>>
>> It would be nice to identify which tasklet keeps being requeued. Is 
>> it because
>> something called tasklet_disable() to it and never called back 
>> tasklet_enable() ?
>
> Hi @Frederic,
>
> Thanks for the reply.
> Suppose a scenario where a tasklet is scheduled/queued from one client 
> and before running of tasklet handler, same tasklet gets
> disabled from some other cpu.
> In this scenario, while the handlers runs it will be keep on marking 
> the softirq pending even though tasklet is disabled.
> Tasklet will be enabled but after coming out of low power mode.
> Will it look to be valid case ?


Never mind, we should call tasklet_kill() followed by tasklet_disable().
I suspect, the issue is in client code, some race is setting schedule 
bit and marking the softirq pending  even after doing tasklet_kill => 
tasklet_disable in cleanup path.

-Mukesh


>
> -Mukesh
>
>
>>
>> Thanks.
