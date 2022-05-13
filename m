Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CAF525BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377658AbiEMHFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377655AbiEMHFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:05:34 -0400
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8413429BC6D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:05:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VD24UDT_1652425525;
Received: from 30.30.111.38(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VD24UDT_1652425525)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 May 2022 15:05:27 +0800
Message-ID: <b470a016-3b5d-4edf-2a54-9e70f9849bc2@linux.alibaba.com>
Date:   Fri, 13 May 2022 15:05:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220513062427.2375743-1-dtcccc@linux.alibaba.com>
 <20220513063729.GF76023@worktop.programming.kicks-ass.net>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20220513063729.GF76023@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/13 14:37, Peter Zijlstra wrote:
> On Fri, May 13, 2022 at 02:24:27PM +0800, Tianchen Ding wrote:
>> We notice the commit 518cd6234178 ("sched: Only queue remote wakeups
>> when crossing cache boundaries") disabled queuing tasks on wakelist when
>> the cpus share llc. This is because, at that time, the scheduler must
>> send IPIs to do ttwu_queue_wakelist.
> 
> No; this was because of cache bouncing.

As I understand, avoiding cache bouncing is the reason to do 
queue_wakelist accross llc. This can be the same reason why we try to do 
queue_wakelist within the same llc now. It should be better for the 
wakee cpu handling its own rq. Will there be some other side effects?

> 
>> Nowadays, ttwu_queue_wakelist also
>> supports TIF_POLLING, so this is not a problem now when the wakee cpu is
>> in idle polling.
>>
>> Benefits:
>>    Queuing the task on idle cpu can help improving performance on waker cpu
>>    and utilization on wakee cpu, and further improve locality because
>>    the wakee cpu can handle its own rq. This patch helps improving rt on
>>    our real java workloads where wakeup happens frequently.
>>
>> Does this patch bring IPI flooding?
>>    For archs with TIF_POLLING_NRFLAG (e.g., x86), there will be no
>>    difference if the wakee cpu is idle polling. If the wakee cpu is idle
>>    but not polling, the later check_preempt_curr() will send IPI too.
>>
>>    For archs without TIF_POLLING_NRFLAG (e.g., arm64), the IPI is
>>    unavoidable, since the later check_preempt_curr() will send IPI when
>>    wakee cpu is idle.
>>
>> Benchmark:
>> running schbench -m 2 -t 8 on 8269CY:
>>
>> without patch:
>> Latency percentiles (usec)
>>          50.0000th: 10
>>          75.0000th: 14
>>          90.0000th: 16
>>          95.0000th: 16
>>          *99.0000th: 17
>>          99.5000th: 20
>>          99.9000th: 23
>>          min=0, max=28
>>
>> with patch:
>> Latency percentiles (usec)
>>          50.0000th: 6
>>          75.0000th: 8
>>          90.0000th: 9
>>          95.0000th: 9
>>          *99.0000th: 10
>>          99.5000th: 10
>>          99.9000th: 14
>>          min=0, max=16
>>
>> We've also tested unixbench and see about 10% improvement on Pipe-based
>> Context Switching, and no performance regression on other test cases.
>>
>> For arm64, we've tested schbench and unixbench on Kunpeng920, the
>> results show that,
> 
> What is a kunpeng and how does it's topology look?

It's an arm64 processor produced by Huawei. It's topology has NUMA and 
cluster. See the commit log of c5e22feffdd7 ("topology: Represent 
clusters of CPUs within a die") for detail.
In fact I also tried to test on Ampere. But there maybe sth wrong on my 
machine and the kernel only get upto l2 cache info. (Which means each 
cpu has a different sd_llc_id so the patch will take no effect.) :-(

> 
>> the improvement is not as obvious as on x86, and
>> there's no performance regression.
> 
> x86 is wide and varied; what x86 did you test?

I've tested on Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz. Do you 
need more info on other machines?
