Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08855A1EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbiHZCnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbiHZCnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:43:33 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41ECD50E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:43:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VNHDA4g_1661481784;
Received: from IT-C02ZG85SLVDL.local(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0VNHDA4g_1661481784)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 10:43:06 +0800
Subject: Re: [PATCH] sched/fair: select waker's cpu for wakee on sync wakeup
To:     Mel Gorman <mgorman@suse.de>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <1508aa17d1a169077c8d8d8c22d2bd529101af0e.1661313074.git.rocking@linux.alibaba.com>
 <20220824084614.kykmtbhyawcei67z@suse.de>
 <093acf40-9e57-d011-d90b-ea216700edc3@linux.alibaba.com>
 <20220825090932.4cfxvt4ktm24guur@suse.de>
From:   Peng Wang <rocking@linux.alibaba.com>
Message-ID: <3e248fab-9ee3-3041-f4d5-99d6313f018b@linux.alibaba.com>
Date:   Fri, 26 Aug 2022 10:43:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220825090932.4cfxvt4ktm24guur@suse.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 17:09, , Mel Gorman wrote:
> On Thu, Aug 25, 2022 at 02:45:05PM +0800, Peng Wang wrote:
>> On 24/08/2022 16:46, , Mel Gorman wrote:
>>> On Wed, Aug 24, 2022 at 12:37:50PM +0800, Peng Wang wrote:
>>>> On sync wakeup, waker is about to sleep, and if it is the only
>>>> running task, wakee can get warm data on waker's cpu.
>>>>
>>>> Unixbench, schbench, and hackbench are tested on
>>>> Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz (192 logic CPUs)
>>>>
>>>> Unixbench get +20.7% improvement with full threads mainly
>>>> because of the pipe-based context switch and fork test.
>>>>
>>>> No obvious impact on schbench.
>>>>
>>>> This change harms hackbench with lower concurrency, while gets improvement
>>>> when concurrency increases.
>>>>
>>>
>>> Note that historically patches in this direction have been hazardous because
>>> it makes a key assumption "sync wakers always go to sleep in the near future"
>>> when the sync hint is not that reliable. Networking from a brief glance
>>> still uses sync wakeups where wakers could have a 1:N relationship between
>>> work producers and work consumers that would then stack multiple tasks on
>>> one CPU for multiple consumers. The workloads mentioned in the changelog
>>> are mostly strictly-synchronous wakeups (i.e. the waker definitely goes
>>> to sleep almost immediately) and benefit from this sort of patch but it's
>>> not necessarily a universal benefit.
>>
>> Hi, Mel
>>
>> Thanks for your clarification.
>>
>> Besides these benchmarks, I also find a similar strictly-synchronous wakeup
>> case [1].
>>
>> [1]https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1478754.html
>>
> 
> Yep, but it falls under the same heading, sometimes the caller knows it's
> a strict sync wakeup but not always.
> 
>>>
>>> Note that most of these hazards occurred *LONG* before I was paying much
>>> attention to how the scheduler behaved so I cannot state "sync is still
>>> unreliable" with absolute certainty. However, long ago there was logic
>>> that tried to track the accuracy of the sync hint that was ultimately
>>> abandoned by commit e12f31d3e5d3 ("sched: Remove avg_overlap"). AFAIK,
>>> the sync hint is still not 100% reliable and while stacking sync works
>>> for some workloads, it's likely to be a regression magnet for network
>>> intensive workloads or client/server workloads like databases where
>>> "synchronous wakeups are not always synchronous".
>>>
>> Yes, you are right. Perhaps in such situation, a strong contract from user
>> is a better alternative than struggling with the weak hint in kernel.
>>
> 
> Even the kernel doesn't always know if a wakeup is really sync or not
> because it lacks valuable context and the number of tasks on the runqueue is
> insufficient if there are multiple wakeups in quick succession. At best,
> there could be two WF_SYNC hints and hope every caller gets it right
> (hint, they won't because even if it's right once, cargo cult copying
> will eventually get it wrong and there is an API explosion issue such as
> wake_up_interruptible_*). A user hint would be tricky. Core libraries
> couldn't use it because it has no idea if the linked application wants
> a strictly sync wakeup or not, a core library couldn't tell given just
> a pthread_mute_t for example. Even if it was true at one point in time,

OK, I get it now, thanks!

If we passed more information dealing with pthread_mute_t, it would
bring too much changes through user core libraries to this kernel
scheduling decision.

And the current weak sync-wakeup hint can only bring us a candidate
in the same LLC cache domain at most.

> it might not be true later if the application design changed leading to
> application bugs being blamed on the kernel for poor placement decisions.
> 

