Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5646748E6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiANIjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:39:25 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43773 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232992AbiANIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:39:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0V1nflZW_1642149557;
Received: from 30.21.164.228(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0V1nflZW_1642149557)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jan 2022 16:39:18 +0800
Message-ID: <d2380831-0205-3ac1-9d64-63a27e148b9d@linux.alibaba.com>
Date:   Fri, 14 Jan 2022 16:39:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH] sched: introduce group balancer
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
References: <98f41efd-74b2-198a-839c-51b785b748a6@linux.alibaba.com>
 <Yd6Xlw1qvEbWFSwU@hirez.programming.kicks-ass.net>
 <11d4c86a-40ef-6ce5-6d08-e9d0bc9b512a@linux.alibaba.com>
 <Yd/2aRcQlxm3Sh41@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
In-Reply-To: <Yd/2aRcQlxm3Sh41@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/1/13 下午5:52, Peter Zijlstra 写道:
> On Thu, Jan 13, 2022 at 03:18:01PM +0800, 王贇 wrote:
> 
>>>> How To Use:
>>>>
>>>> To create partition, for example run:
>>>>     echo disable > /proc/gb_ctrl
>>>>     echo "0-15;16-31;32-47;48-63;" > /proc/gb_ctrl
>>>>     echo enable > /proc/gb_ctrl
>>>
>>> That's just never going to happen; please look at the cpuset partition
>>> stuff.
>>
>> Could you please give more details in here?
>>
>> We actually looking forward a way to config several cpuset partition
>> together, like here 4 cpuset partitions 0-15, 16-31, 32-47 and 48-63,
>> but can't find any existing approach...
> 
> You could extend the partitions support:
> 
>   https://lkml.kernel.org/r/20211205183220.818872-1-longman@redhat.com
> 
> And have a parent partition type that soft balances between child
> partitions or something.
Hmm.. got two ways in mind, for eg when we have cgroup hierarchy:

     CG_A
     |
     |_________
     |         |
     CG_B      CG_C
               |
               |_______
               |       |
               CG_D    CG_E

One way is to add 'cpuset.gb_cpus' which only accept one partition,
CG_A collect these partition info from B,C and balance them between
these partitions, when it's 'cpuset.gb_enable' was turned on.

But this way got problem when to turn on 'cpuset.gb_enable' in CG_C,
since C could run into the partition of B, it's child can also too,
the rule of 'parent balance child between partitions they provided'
will be broken...

Another way is to add 'cpuset.gb_partitions' just like the 'gb_ctrl'
here, then CG_B,C will join group balancer following by D,E, when
C got it's own partition configured, D,E can follow C instead.

In this way the rule 'parent balance child between partitions' could
work, IMHO this way sounds much more practical , still require the new
interface to accept multiple partitions, but now managed by cpuset
cgroup in the hierarchy way.

Not sure if we understand the suggestion correctly... please let me
know if it's not, we would like to try the second way see if it's 
working as expected firstly.

Regards,
Michael Wang

> 
