Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAF74BE3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356421AbiBULZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:25:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356294AbiBULYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:24:45 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205A1DC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645442365; x=1676978365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gKAptw+SVbYPEm3GtIZqLUTXDNC+E8kNX4YhNwChSCc=;
  b=oQPp2lkvJHtqoxeQR5PC5FwPDlLNDb+OtesD4Ne2f4XSJFC+MPBW14xg
   73NO31YE814uPgMZC9L27GAy4jY8Vp9/foOJp0V6p/Lx1vtDmivV7Km3y
   TYJEMVNG1Jucfh+wuB6LHBG26ZL/T+pNYt7B8AQYrwvWydoyQdoNsnDZg
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Feb 2022 03:19:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 03:19:25 -0800
Received: from [10.216.8.129] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 03:19:22 -0800
Message-ID: <28cbffc9-dcd4-60ac-897a-d1b1604de22c@quicinc.com>
Date:   Mon, 21 Feb 2022 16:48:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] softirq: Remove raise_softirq from
 tasklet_action_common()
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <paulmck@kernel.org>, <will@kernel.org>,
        <dave@stgolabs.net>
References: <1644066805-17212-1-git-send-email-quic_mojha@quicinc.com>
 <20220208230455.GA539926@lothringen>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220208230455.GA539926@lothringen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 2/9/2022 4:34 AM, Frederic Weisbecker wrote:
> On Sat, Feb 05, 2022 at 06:43:25PM +0530, Mukesh Ojha wrote:
>> Think about a scenario when all other cores are in suspend
>> and one core is only running ksoftirqd and it is because
>> some client has invoked tasklet_hi_schedule() only once
>> during that phase.
>>
>> tasklet_action_common() handles that softirq and marks the
>> same softirq as pending again. And due to that core keeps
>> running the softirq handler [1] forever and it is not able to
>> go to suspend.
>>
>> We can get rid of raising softirq from tasklet handler.
>>
>> [1]
>> <idle>-0    [003]   13058.769081:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13058.769085: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13058.769087:  softirq_exit   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13058.769091:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13058.769094: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13058.769097:  softirq_exit   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13058.769100:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13058.769103: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13058.769106:  softirq_exit   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13058.769109:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13059.058923:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> ...
>> ..
>> ..
>> ..
>>
>> <idle>-0    [003]   13059.058951:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13059.058954: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13059.058957:  softirq_exit   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13059.058960:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13059.058963: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13059.058966:  softirq_exit   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13059.058969:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13059.058972: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13059.058975:  softirq_exit   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13059.058978:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13059.058981: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13059.058984:  softirq_exit   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13059.058987:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13059.058990: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13059.058993:  softirq_exit   vec=0  action=HI_SOFTIRQ
>> <idle>-0    [003]   13059.058996:  softirq_entry   vec=0  action=HI_SOFTIRQ
>> <idle>-0     [003]  13059.059000: softirq_raise:        vec=0 [action=HI_SOFTIRQ]
>> <idle>-0    [003]   13059.059002:  softirq_exit   vec=0  action=HI_SOFTIRQ
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   kernel/softirq.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>> index 41f4709..d3e6fb9 100644
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -795,7 +795,6 @@ static void tasklet_action_common(struct softirq_action *a,
>>   		t->next = NULL;
>>   		*tl_head->tail = t;
>>   		tl_head->tail = &t->next;
>> -		__raise_softirq_irqoff(softirq_nr);
>>   		local_irq_enable();
> That requeue happens when the tasklet is already executing on some other CPU
> or when it has been disabled through tasklet_disable().
>
> So you can't just remove that line or you'll break everything.
>
> It would be nice to identify which tasklet keeps being requeued. Is it because
> something called tasklet_disable() to it and never called back tasklet_enable() ?

Hi @Frederic,

Thanks for the reply.
Suppose a scenario where a tasklet is scheduled/queued from one client 
and before running of tasklet handler, same tasklet gets
disabled from some other cpu.
In this scenario, while the handlers runs it will be keep on marking the 
softirq pending even though tasklet is disabled.
Tasklet will be enabled but after coming out of low power mode.
Will it look to be valid case ?

-Mukesh


>
> Thanks.
