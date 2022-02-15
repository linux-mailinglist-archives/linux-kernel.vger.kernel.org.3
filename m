Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8634B60A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiBOCBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:01:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiBOB7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:59:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5B14563E;
        Mon, 14 Feb 2022 17:57:42 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JyPJ10NCDz1FDD4;
        Tue, 15 Feb 2022 09:53:21 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 09:57:40 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 09:57:40 +0800
Subject: Re: Question about nohz and sysidle
To:     <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
CC:     Yu Liao <liaoyu15@huawei.com>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <rcu@vger.kernel.org>
References: <b881759b-d281-fdc3-71b7-4429d84cd734@huawei.com>
 <b6dc758b-492d-1000-24e5-643e38d3166e@huawei.com>
 <20220214105744.GA663287@lothringen>
 <20220214144920.GW4285@paulmck-ThinkPad-P17-Gen-1>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <88b4e601-fa52-c852-5ef5-c782ba13d3b0@huawei.com>
Date:   Tue, 15 Feb 2022 09:57:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20220214144920.GW4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/2/14 22:49, Paul E. McKenney wrote:
> On Mon, Feb 14, 2022 at 11:57:44AM +0100, Frederic Weisbecker wrote:
>> On Mon, Feb 14, 2022 at 05:40:55PM +0800, Yu Liao wrote:
>>
>> Hi Yu Liao,
>>
>>>
>>> On 2022/2/14 16:28, Yu Liao wrote:
>>>> Hi Frederic,
>>>>
>>>> I'm working on an issue about nohz. When NO_HZ_FULL is enabled, CPU 0
>>>> handles the timekeeping duty on behalf of all other CPUs, which means
>>>> CPU 0 never stop tick even in sysidle state. This is a powersaving
>>>> issue.
>>>>
>>>> I found your patchset (nohz: Support sysidle) in the below link.
>>>> https://lore.kernel.org/all/1406569056-30217-1-git-send-email-fweisbec@gmail.com/
>>>>
>>>> But these patches haven't been merged into mainline yet and sysidle
>>>> state detection has been removed by commit fe5ac724d81a (rcu: Remove
>>>> nohz_full full-system-idle state machine) as well.
>>>>
>>>> I tried your patches and it does work, why are we no longer working on
>>>> stopping timekeeping duty when all full dynticks CPUs are idle?
>>
>> Because it was not a priority at that time. There were so many things to handle
>> first (and we are not even done yet) that we postponed that feature until
>> someone ever comes up with powersaving issues on nohz_full. We were waiting for
>> you :)
>>
>> It's possible to unearth this. I think the first step will be to merge the
>> RCU dynticks counters into context tracking, something that was on my queue
>> anyway, and then revive this:
>>
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=sysidle.2017.05.11a&id=fe5ac724d81a3c7803e60c2232718f212f3f38d4
> 
> Given a valid use case, getting that functionality back would be fine
> by me.  But yes, properly merging RCU dynticks into context tracking
> would reduce the resulting idle-entry/exit performance penalty, so it
> would be good to do that first.

I have came across the same issue. The original email is as below.
 https://www.spinics.net/lists/kernel/msg4131382.html
But unfortunately, I also sent to the old email address.

In my situation, all the CPUs are in the same power domain. When nohz_full is
enabled, if one of the CPUs keep receiving tick interrupts, all the CPUs can not
be put into powerdown state, even though all other CPUs are idle.

Thanks,
Xiongfeng

> 
> 							Thanx, Paul
> .
> 
