Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A0D58895F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiHCJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiHCJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:25:57 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C55A14F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:25:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VLGENyx_1659518750;
Received: from 30.178.80.143(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VLGENyx_1659518750)
          by smtp.aliyun-inc.com;
          Wed, 03 Aug 2022 17:25:51 +0800
Message-ID: <10f7d339-c451-8284-ccd8-ce9a0fe14f48@linux.alibaba.com>
Date:   Wed, 3 Aug 2022 17:25:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
 <Yuo0U2aWUZRLBAsA@gmail.com>
 <c4058896-947d-c802-ac57-bf03eb986378@linux.alibaba.com>
 <Yuo7eYzQnzqx4u7F@gmail.com>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <Yuo7eYzQnzqx4u7F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * Liu Song <liusong@linux.alibaba.com> wrote:
>
>>> * Liu Song <liusong@linux.alibaba.com> wrote:
>>>
>>>> From: Liu Song <liusong@linux.alibaba.com>
>>>>
>>>> If the number of CPUs is large, "sysrq_sched_debug_show" will execute for
>>>> a long time. Every time I execute "echo t > /proc/sysrq-trigger" on my
>>>> 128-core machine, the rcu stall warning will be triggered. Moreover,
>>>> sysrq_sched_debug_show does not need to be protected by rcu_read_lock,
>>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> and no rcu stall warning will appear after adjustment.
>>>>
>>> That doesn't mean it doesn't have to be protected by *any* lock - which
>>> your patch implements AFAICS.
>>>
>>> There's a couple of lines such as:
>>>
>>>           for_each_online_cpu(cpu) {
>> Hi,
>>
>> Here I refer to the implementation of "sysrq_timer_list_show", and I don't
>> see any lock.
>>
>> Maybe there is a problem with the implementation of "sysrq_timer_list_show".
> But we are talking about sysrq_sched_debug_show(), which your patch tries
> to relax the RCU locking of.

Hi,

I'm not sure for_each_online_cpu && print_cpu must need a lock to 
protect, so I refer to other codes

under kernel that reference the implementation. It looks like some 
places use "get_online_cpus" to prevent

cpu hotplug, but many places don't have obvious protection, so I'm also 
confused if protection is necessarily

required.


Thanks

>
> Thanks,
>
> 	Ingo
