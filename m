Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460805A092A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiHYGvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiHYGuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:50:24 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 23:50:21 PDT
Received: from out30-45.freemail.mail.aliyun.com (unknown [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF7275F1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:50:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VNC1Xus_1661409908;
Received: from IT-C02ZG85SLVDL.local(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0VNC1Xus_1661409908)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 14:45:09 +0800
Subject: Re: [PATCH] sched/fair: select waker's cpu for wakee on sync wakeup
To:     Mel Gorman <mgorman@suse.de>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <1508aa17d1a169077c8d8d8c22d2bd529101af0e.1661313074.git.rocking@linux.alibaba.com>
 <20220824084614.kykmtbhyawcei67z@suse.de>
From:   Peng Wang <rocking@linux.alibaba.com>
Message-ID: <093acf40-9e57-d011-d90b-ea216700edc3@linux.alibaba.com>
Date:   Thu, 25 Aug 2022 14:45:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220824084614.kykmtbhyawcei67z@suse.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 16:46, , Mel Gorman wrote:
> On Wed, Aug 24, 2022 at 12:37:50PM +0800, Peng Wang wrote:
>> On sync wakeup, waker is about to sleep, and if it is the only
>> running task, wakee can get warm data on waker's cpu.
>>
>> Unixbench, schbench, and hackbench are tested on
>> Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz (192 logic CPUs)
>>
>> Unixbench get +20.7% improvement with full threads mainly
>> because of the pipe-based context switch and fork test.
>>
>> No obvious impact on schbench.
>>
>> This change harms hackbench with lower concurrency, while gets improvement
>> when concurrency increases.
>>
> 
> Note that historically patches in this direction have been hazardous because
> it makes a key assumption "sync wakers always go to sleep in the near future"
> when the sync hint is not that reliable. Networking from a brief glance
> still uses sync wakeups where wakers could have a 1:N relationship between
> work producers and work consumers that would then stack multiple tasks on
> one CPU for multiple consumers. The workloads mentioned in the changelog
> are mostly strictly-synchronous wakeups (i.e. the waker definitely goes
> to sleep almost immediately) and benefit from this sort of patch but it's
> not necessarily a universal benefit.

Hi, Mel

Thanks for your clarification.

Besides these benchmarks, I also find a similar strictly-synchronous 
wakeup case [1].

[1]https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1478754.html

> 
> Note that most of these hazards occurred *LONG* before I was paying much
> attention to how the scheduler behaved so I cannot state "sync is still
> unreliable" with absolute certainty. However, long ago there was logic
> that tried to track the accuracy of the sync hint that was ultimately
> abandoned by commit e12f31d3e5d3 ("sched: Remove avg_overlap"). AFAIK,
> the sync hint is still not 100% reliable and while stacking sync works
> for some workloads, it's likely to be a regression magnet for network
> intensive workloads or client/server workloads like databases where
> "synchronous wakeups are not always synchronous".
>
Yes, you are right. Perhaps in such situation, a strong contract from 
user is a better alternative than struggling with the weak hint in kernel.




