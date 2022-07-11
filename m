Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFB56D712
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiGKHuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiGKHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:50:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8E911C932;
        Mon, 11 Jul 2022 00:50:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F41176B;
        Mon, 11 Jul 2022 00:50:42 -0700 (PDT)
Received: from [10.57.12.169] (unknown [10.57.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D850E3F70D;
        Mon, 11 Jul 2022 00:50:38 -0700 (PDT)
Message-ID: <5b3d0cea-482c-a908-8575-e5846e43b286@arm.com>
Date:   Mon, 11 Jul 2022 08:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Content-Language: en-US
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <CAB8ipk8w1=cMJV2_ZjWuX6T9RH9VXCMdUaZhLEkCziarhpy-5w@mail.gmail.com>
 <9ade9d43-3ed1-1239-f26e-73145856275a@arm.com>
 <CAB8ipk_Y5vaUMnRQVJsbHUue_J00qqy0E1ifu3W_hFSspL1r1w@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk_Y5vaUMnRQVJsbHUue_J00qqy0E1ifu3W_hFSspL1r1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/22 08:43, Xuewen Yan wrote:
> On Mon, Jul 11, 2022 at 3:32 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Xuewen,
>>
>> On 7/11/22 08:21, Xuewen Yan wrote:
>>> Hi all
>>>
>>> This deadlock is inevitable, any comment?
>>
>> Could you tell me how to reproduce this?
>> Is there a need of special cgroup setup?
> 
> This deadlock occurs when we run the monkey test on an Android phone,
> at the same time, randomly put online or offline a cpu core.
> Indeed the thread-A which get the cgroup_threadgroup_rwsem and waiting
> for the cpu_hotplug_lock is the thread whose name is "OomAdjuster" in
> android.

Thanks, let me have a look. We have some hotplug stress tests in our
EAS mainline integration tests, which haven't triggered this issue.
I'll try to trigger this on mainline kernel.

> 
> And I see the cpu_hotplug_lock is added by the patch:
> https://lore.kernel.org/all/20220121101210.84926-1-zhangqiao22@huawei.com/

Thanks for the pointer.
