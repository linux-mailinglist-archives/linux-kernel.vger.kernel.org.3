Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD46C4705CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbhLJQie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:38:34 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:15753 "HELO
        mailgate01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S243564AbhLJQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:38:33 -0500
Received: from mail.didiglobal.com (unknown [172.20.36.95])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id 26FDCD833101D;
        Sat, 11 Dec 2021 00:34:54 +0800 (CST)
Received: from BJSGEXMBX12.didichuxing.com (172.20.15.142) by
 BJSGMBX001.didichuxing.com (172.20.15.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.17; Sat, 11 Dec 2021 00:34:54 +0800
Received: from [172.31.0.211] (172.31.0.211) by BJSGEXMBX12.didichuxing.com
 (172.20.15.142) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 00:34:53 +0800
Message-ID: <c66981ec-ebe9-3678-22a8-a0bdd3f8326b@didichuxing.com>
Date:   Sat, 11 Dec 2021 00:34:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/3] sched/fair: prevent cpu burst too many periods
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
X-MD-SrcIP: 172.20.36.95
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <YbH/6H+QtjFlw+19@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.31.0.211]
X-ClientProxiedBy: BJEXCAS05.didichuxing.com (172.20.36.127) To
 BJSGEXMBX12.didichuxing.com (172.20.15.142)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/9 21:08, Peter Zijlstra wrote:
> On Wed, Dec 08, 2021 at 10:50:38PM +0800, Honglei Wang wrote:
>> Tasks might get more cpu than quota in persistent periods due to the
>> cpu burst introduced by commit f4183717b370 ("sched/fair: Introduce the
>> burstable CFS controller").
> 
>> For example, one task group whose quota is
>> 100ms per period and can get 100ms burst, and its avg utilization is
>> around 105ms per period.
> 
> That would be a mis-configuration, surely..
> 

Well, it's a lame example to describe the spreading of the burst..

>> Once this group gets a free period which
>> leaves enough runtime, it has a chance to get computting power more
>> than its quota for 10 periods or more in common bandwidth configuration
>> (say, 100ms as period).
> 
> Sure, if it, for some miraculous reason, decides to sleep for a whole
> period and then resume, it can indeed consume up to that 100ms extra,
> which, if as per the above, done at 5ms per perios, would be 20 periods
> until depleted.
> 
>> It means tasks can 'steal' the bursted power to
>> do daily jobs because all tasks could be scheduled out or sleep to help
>> the group get free periods.
> 
> That's the design,,
> 
>> I believe the purpose of cpu burst is to help handling bursty worklod.
>> But if one task group can get computting power more than its quota for
>> persistent periods even there is no bursty workload, it's kinda broke.
> 
> So if that was were bursty, it could consume that 100ms extra in a
> single go and that would be fine, but spreading that same amount over 20
> periods is somehow a problem? -- even though the interference is less.
> 

The key thought I make the change is that If the spreading of burst 
power always happen, it indicates the quota is not comfortable, the 
better way is to do quota re-config for the container, but not always 
get extra power from spreading the burst part which is not in the 
consideration of high level container dispatcher such as k8s scheduler. 
Container dispatcher might dispatch jobs oversale. The containers get 
more power from the burst spreading is outside the sense of the 
dispatcher. It might mislead the estimation of the entire ability of the 
host.

IMO, cpu burst should be focus on the real burst workload, sharp and 
short term.

Well, if 2 periods are a bit short for some huge cpu calculation jobs, 
maybe we can add an option to define the burstable periods to let the 
user make the decision based on the workload if you think this limit 
periods idea make sense.

Thanks,
Honglei

>> This patch limits the burst to 2 periods so that it won't break the
>> quota limit for long. Permitting 2 periods can help on the scenario that
>> periods refresh lands in the middle of a burst workload. With this, we
>> can give task group more cpu burst power to handle the real burst
>> workload and don't worry about the 'stealing'.
> 
> I've yet so see an actual reason for any of this...
> 
