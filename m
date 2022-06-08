Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904BC543795
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbiFHPiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbiFHPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:38:43 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC3DDD2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:38:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VFmlR9q_1654702713;
Received: from 30.15.195.212(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VFmlR9q_1654702713)
          by smtp.aliyun-inc.com;
          Wed, 08 Jun 2022 23:38:34 +0800
Message-ID: <e34de686-4e85-bde1-9f3c-9bbc86b38627@linux.alibaba.com>
Date:   Wed, 8 Jun 2022 23:38:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] sched: Fix the check of nr_running at queue
 wakelist
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220602040645.275555-1-dtcccc@linux.alibaba.com>
 <20220602040645.275555-2-dtcccc@linux.alibaba.com>
 <xhsmh4k0y84ah.mognet@vschneid.remote.csb>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <xhsmh4k0y84ah.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/6 18:39, Valentin Schneider wrote:
> On 02/06/22 12:06, Tianchen Ding wrote:
>> The commit 2ebb17717550 ("sched/core: Offload wakee task activation if it
>> the wakee is descheduling") checked nr_running <= 1 to avoid task
>> stacking when WF_ON_CPU. Consider the order of p->on_rq and p->on_cpu,
>> if we have WF_ON_CPU here then we must have !p->on_rq, so the deactivate
>> has happened, thus the task being alone on the rq implies nr_running==0.
>> Change the check to !cpu_rq(cpu)->nr_running to fix it.
>>
> 
> I'd flesh this out a bit as in the below:
> 
> """
> The commit 2ebb17717550 ("sched/core: Offload wakee task activation if it
> the wakee is descheduling") checked rq->nr_running <= 1 to avoid task
> stacking when WF_ON_CPU.
> 
> Per the ordering of writes to p->on_rq and p->on_cpu, observing p->on_cpu
> (WF_ON_CPU) in ttwu_queue_cond() implies !p->on_rq, IOW p has gone through
> the deactivate_task() in __schedule(), thus p has been accounted out of
> rq->nr_running. As such, the task being the only runnable task on the rq
> implies reading rq->nr_running == 0 at that point.
> 
> Change the check to !cpu_rq(cpu)->nr_running.
> """
> 
> Also, this is lacking some mention of tests that have been run to verify
> this isn't causing a regression. This does however make sense to me, so as
> long as nothing gets hurt by the change:
> 

I've run the complete test cases of unixbench and it seems no regression (which 
is expected). The result of Pipe-based Context Switching seems to be stable when 
I simply type "./Run" to run all cases. :-/

On x86 (Intel Xeon Platinum 8269CY):
   schbench -m 2 -t 8

     Latency percentiles (usec)             before         after
         50.0000th:                            8             8
         75.0000th:                           10            10
         90.0000th:                           11            11
         95.0000th:                           12            12
         *99.0000th:                          15            13
         99.5000th:                           16            15
         99.9000th:                           20            18

   Unixbench with full threads (104)
                                             before        after
     Dhrystone 2 using register variables  3004715731    3011862938   0.24%
     Double-Precision Whetstone              616685.8      617119.3   0.07%
     Execl Throughput                         27162.1       27667.3   1.86%
     File Copy 1024 bufsize 2000 maxblocks   786221.4      785871.4  -0.04%
     File Copy 256 bufsize 500 maxblocks     209420.6      210113.6   0.33%
     File Copy 4096 bufsize 8000 maxblocks  2340458.8     2328862.2  -0.50%
     Pipe Throughput                      145249195.6   145535622.8   0.20%
     Pipe-based Context Switching           3195567.7     3221686.4   0.82%
     Process Creation                        100597.6      101347.1   0.75%
     Shell Scripts (1 concurrent)            120943.6      120193.5  -0.62%
     Shell Scripts (8 concurrent)             17289.7       17233.4  -0.33%
     System Call Overhead                   5286847.6     5300604.8   0.26%

On arm64 (Ampere Altra):
   schbench -m 2 -t 8

     Latency percentiles (usec)             before         after
         50.0000th:                           14            14
         75.0000th:                           19            19
         90.0000th:                           22            22
         95.0000th:                           23            23
         *99.0000th:                          23            24
         99.5000th:                           23            24
         99.9000th:                           28            28

   Unixbench with full threads (80)
                                             before        after
     Dhrystone 2 using register variables  3536273441    3536194249   0.00%
     Double-Precision Whetstone              629406.9      629383.6   0.00%
     Execl Throughput                         66419.3       65920.5  -0.75%
     File Copy 1024 bufsize 2000 maxblocks  1060185.2     1063722.8   0.33%
     File Copy 256 bufsize 500 maxblocks     317495.4      322684.5   1.63%
     File Copy 4096 bufsize 8000 maxblocks  2350706.8     2348285.3  -0.10%
     Pipe Throughput                      133516462.4   133542875.3   0.02%
     Pipe-based Context Switching           3227430.6     3215356.1  -0.37%
     Process Creation                        108958.3      108520.5  -0.40%
     Shell Scripts (1 concurrent)            122821.4      122636.3  -0.15%
     Shell Scripts (8 concurrent)             17456.5       17462.1   0.03%
     System Call Overhead                   4430303.2     4429998.9  -0.01%

> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> 

Thanks. Will update my patch and send v4 soon.
