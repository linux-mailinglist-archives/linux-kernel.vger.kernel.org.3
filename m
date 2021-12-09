Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1D46EB13
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhLIP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:28:12 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:13134 "HELO
        mailgate01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S236184AbhLIP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:28:11 -0500
X-Greylist: delayed 88426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 10:28:11 EST
Received: from mail.didiglobal.com (unknown [172.20.36.245])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id A3A8DD988C807;
        Thu,  9 Dec 2021 23:24:35 +0800 (CST)
Received: from BJSGEXMBX12.didichuxing.com (172.20.15.142) by
 BJSGEXMBX15.didichuxing.com (172.20.15.132) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 9 Dec 2021 23:24:35 +0800
Received: from [172.31.5.120] (172.31.5.120) by BJSGEXMBX12.didichuxing.com
 (172.20.15.142) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Dec
 2021 23:24:34 +0800
Message-ID: <24777493-e182-d641-9e21-41102b0962c8@didichuxing.com>
Date:   Thu, 9 Dec 2021 23:24:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/3] sched/fair: avoid burst statistic if it's not set
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        Honglei Wang <jameshongleiwang@126.com>
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.245
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <YbH08Nw3WpyxElE9@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.31.5.120]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX12.didichuxing.com (172.20.15.142)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/9 20:22, Peter Zijlstra wrote:
> On Wed, Dec 08, 2021 at 10:50:18PM +0800, Honglei Wang wrote:
>> It's not necessary to do burst associated statistic and calculation for
>> runtime if the burst feature is not set at all. Just return at the very
>> start point if so.
>>
>> Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
>> ---
>>   kernel/sched/fair.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6e476f6d9435..2cd626c22912 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4640,6 +4640,11 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>>   	if (unlikely(cfs_b->quota == RUNTIME_INF))
>>   		return;
>>   
>> +	if (cfs_b->burst == 0 && cfs_b->runtime_snap == cfs_b->quota) {
>> +		cfs_b->runtime = cfs_b->quota;
>> +		return;
>> +	}
>> +
>>   	cfs_b->runtime += cfs_b->quota;
>>   	runtime = cfs_b->runtime_snap - cfs_b->runtime;
>>   	if (runtime > 0) {
> 
> What actual purpose does this patch serve, other than to increase the
> line-count?
> 

Yep, there is no functional improvement with this tiny section. The 
original thought is why do we do the judgement, calculation and 
comparing for one feature if it is not even set? Could we go a bit 
faster if skip the stuff?

I disassembled the function when finished the code. If the burst feature 
is not open, we just need 8 instructions (it's 6 at most cases) with the 
change VS 12 ones without it. So seems there is a bit help? And it can 
be cut to 5 instructions if we don't mind loss 1 potential nr_burst 
statistic.

000000000000b530 <__refill_cfs_bandwidth_runtime>:
{
     b530:       e8 00 00 00 00          callq  b535 
<__refill_cfs_bandwidth_runtime+0x5>
         if (unlikely(cfs_b->quota == RUNTIME_INF))
     b535:       48 8b 47 10             mov    0x10(%rdi),%rax
     b539:       48 83 f8 ff             cmp    $0xffffffffffffffff,%rax
     b53d:       74 45                   je     b584 
<__refill_cfs_bandwidth_runtime+0x54>
         if (cfs_b->burst == 0 && cfs_b->runtime_snap == cfs_b->quota) {
     b53f:       48 8b 77 20             mov    0x20(%rdi),%rsi---->1,3
     b543:       48 8b 57 28             mov    0x28(%rdi),%rdx---->1,3
     b547:       48 85 f6                test   %rsi,%rsi---------->1,3
     b54a:       75 05                   jne    b551 -------------->1,3 
<__refill_cfs_bandwidth_runtime+0x21>
     b54c:       48 39 d0                cmp    %rdx,%rax---------->1
     b54f:       74 35                   je     b586 
<__refill_cfs_bandwidth_runtime+0x56> ---------------------------->1
         cfs_b->runtime += cfs_b->quota;
     b551:       48 8b 4f 18             mov    0x18(%rdi),%rcx---->2
     b555:       48 01 c1                add    %rax,%rcx---------->2
         runtime = cfs_b->runtime_snap - cfs_b->runtime;
     b558:       48 29 ca                sub    %rcx,%rdx---------->2
         cfs_b->runtime += cfs_b->quota;
     b55b:       48 89 4f 18             mov    %rcx,0x18(%rdi)---->2
         if (runtime > 0) {
     b55f:       48 85 d2                test   %rdx,%rdx---------->2
     b562:       7e 0e                   jle    b572 
<__refill_cfs_bandwidth_runtime+0x42>----------------------------->2
                 cfs_b->burst_time += runtime;
     b564:       48 01 97 e8 00 00 00    add    %rdx,0xe8(%rdi)
                 cfs_b->nr_burst++;
     b56b:       83 87 d8 00 00 00 01    addl   $0x1,0xd8(%rdi)
         cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
     b572:       48 01 f0                add    %rsi,%rax---------->2
     b575:       48 39 c8                cmp    %rcx,%rax---------->2
     b578:       48 0f 47 c1             cmova  %rcx,%rax---------->2
     b57c:       48 89 47 18             mov    %rax,0x18(%rdi)---->2
         cfs_b->runtime_snap = cfs_b->runtime;
     b580:       48 89 47 28             mov    %rax,0x28(%rdi)---->2
}
     b584:       f3 c3                   repz retq----------------->2
                 cfs_b->runtime = cfs_b->quota;
     b586:       48 89 47 18             mov    %rax,0x18(%rdi)---->1
                 return;
     b58a:       c3                      retq---------------------->1
     b58b:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
