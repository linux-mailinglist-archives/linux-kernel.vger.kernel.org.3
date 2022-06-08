Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA37543FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiFHXbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiFHXbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:31:00 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D4013D24
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:30:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VFoXUN2_1654731054;
Received: from 192.168.0.205(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VFoXUN2_1654731054)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 07:30:56 +0800
Message-ID: <3f87bc5c-1611-8e8d-0ab1-288b516530b2@linux.alibaba.com>
Date:   Thu, 9 Jun 2022 07:30:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/2] sched: Remove the limitation of WF_ON_CPU on
 wakelist if wakee cpu is idle
Content-Language: en-US
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220608163518.324276-1-dtcccc@linux.alibaba.com>
 <20220608163518.324276-3-dtcccc@linux.alibaba.com>
In-Reply-To: <20220608163518.324276-3-dtcccc@linux.alibaba.com>
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

On 2022/6/9 00:35, Tianchen Ding wrote:
> Wakelist can help avoid cache bouncing and offload the overhead of waker
> cpu. So far, using wakelist within the same llc only happens on
> WF_ON_CPU, and this limitation could be removed to further improve
> wakeup performance.
> 
> The commit 518cd6234178 ("sched: Only queue remote wakeups when
> crossing cache boundaries") disabled queuing tasks on wakelist when
> the cpus share llc. This is because, at that time, the scheduler must
> send IPIs to do ttwu_queue_wakelist. Nowadays, ttwu_queue_wakelist also
> supports TIF_POLLING, so this is not a problem now when the wakee cpu is
> in idle polling.
> 
> Benefits:
>    Queuing the task on idle cpu can help improving performance on waker cpu
>    and utilization on wakee cpu, and further improve locality because
>    the wakee cpu can handle its own rq. This patch helps improving rt on
>    our real java workloads where wakeup happens frequently.
> 
>    Consider the normal condition (CPU0 and CPU1 share same llc)
>    Before this patch:
> 
>           CPU0                                       CPU1
> 
>      select_task_rq()                                idle
>      rq_lock(CPU1->rq)
>      enqueue_task(CPU1->rq)
>      notify CPU1 (by sending IPI or CPU1 polling)
> 
>                                                      resched()
> 
>    After this patch:
> 
>           CPU0                                       CPU1
> 
>      select_task_rq()                                idle
>      add to wakelist of CPU1
>      notify CPU1 (by sending IPI or CPU1 polling)
> 
>                                                      rq_lock(CPU1->rq)
>                                                      enqueue_task(CPU1->rq)
>                                                      resched()
> 
>    We see CPU0 can finish its work earlier. It only needs to put task to
>    wakelist and return.
>    While CPU1 is idle, so let itself handle its own runqueue data.
> 
> This patch brings no difference about IPI.
>    This patch only takes effect when the wakee cpu is:
>    1) idle polling
>    2) idle not polling
> 
>    For 1), there will be no IPI with or without this patch.
> 
>    For 2), there will always be an IPI before or after this patch.
>    Before this patch: waker cpu will enqueue task and check preempt. Since
>    "idle" will be sure to be preempted, waker cpu must send a resched IPI.
>    After this patch: waker cpu will put the task to the wakelist of wakee
>    cpu, and send an IPI.
> 
> Benchmark:
> We've tested schbench, unixbench, and hachbench on both x86 and arm64.
> 
> On x86 (Intel Xeon Platinum 8269CY):
>    schbench -m 2 -t 8
> 
>      Latency percentiles (usec)             before         after
>          50.0000th:                            8             6
>          75.0000th:                           10             7
>          90.0000th:                           11             8
>          95.0000th:                           12             8
>          *99.0000th:                          13            10
>          99.5000th:                           15            11
>          99.9000th:                           18            14
> 
>    Unixbench with full threads (104)
>                                              before        after
>      Dhrystone 2 using register variables  3011862938    3009935994  -0.06%
>      Double-Precision Whetstone              617119.3      617298.5   0.03%
>      Execl Throughput                         27667.3       27627.3  -0.14%
>      File Copy 1024 bufsize 2000 maxblocks   785871.4      784906.2  -0.12%
>      File Copy 256 bufsize 500 maxblocks     210113.6      212635.4   1.20%
>      File Copy 4096 bufsize 8000 maxblocks  2328862.2     2320529.1  -0.36%
>      Pipe Throughput                      145535622.8   145323033.2  -0.15%
>      Pipe-based Context Switching           3221686.4     3583975.4  11.25%
>      Process Creation                        101347.1      103345.4   1.97%
>      Shell Scripts (1 concurrent)            120193.5      123977.8   3.15%
>      Shell Scripts (8 concurrent)             17233.4       17138.4  -0.55%
>      System Call Overhead                   5300604.8     5312213.6   0.22%
> 
>    hackbench -g 1 -l 100000
>                                              before        after
>      Time                                     3.246        2.251
> 
> On arm64 (Ampere Altra):
>    schbench -m 2 -t 8
> 
>      Latency percentiles (usec)             before         after
>          50.0000th:                           14            10
>          75.0000th:                           19            14
>          90.0000th:                           22            16
>          95.0000th:                           23            16
>          *99.0000th:                          24            17
>          99.5000th:                           24            17
>          99.9000th:                           28            25
> 
>    Unixbench with full threads (80)
>                                              before        after
>      Dhrystone 2 using register variables  3536194249    3536476016  -0.01%
>      Double-Precision Whetstone              629383.6      629333.3  -0.01%
>      Execl Throughput                         65920.5       66288.8  -0.49%
>      File Copy 1024 bufsize 2000 maxblocks  1038402.1     1050181.2   1.13%
>      File Copy 256 bufsize 500 maxblocks     311054.2      310317.2  -0.24%
>      File Copy 4096 bufsize 8000 maxblocks  2276795.6       2297703   0.92%
>      Pipe Throughput                      130409359.9   130390848.7  -0.01%
>      Pipe-based Context Switching           3148440.7     3383705.1   7.47%
>      Process Creation                        111574.3      119728.6   7.31%
>      Shell Scripts (1 concurrent)            122980.7      122657.4  -0.26%
>      Shell Scripts (8 concurrent)             17482.8       17476.8  -0.03%
>      System Call Overhead                   4424103.4     4430062.6   0.13%
> 
>      Dhrystone 2 using register variables  3536194249    3537019613   0.02%
>      Double-Precision Whetstone              629383.6      629431.6   0.01%
>      Execl Throughput                         65920.5       65846.2  -0.11%
>      File Copy 1024 bufsize 2000 maxblocks  1063722.8     1064026.8   0.03%
>      File Copy 256 bufsize 500 maxblocks     322684.5      318724.5  -1.23%
>      File Copy 4096 bufsize 8000 maxblocks  2348285.3     2328804.8  -0.83%
>      Pipe Throughput                      133542875.3   131619389.8  -1.44%
>      Pipe-based Context Switching           3215356.1     3576945.1  11.25%
>      Process Creation                        108520.5      120184.6  10.75%
>      Shell Scripts (1 concurrent)            122636.3        121888  -0.61%
>      Shell Scripts (8 concurrent)             17462.1       17381.4  -0.46%
>      System Call Overhead                   4429998.9     4435006.7   0.11%

Oops... I forgot to remove the previous result.
Let me resend one.

