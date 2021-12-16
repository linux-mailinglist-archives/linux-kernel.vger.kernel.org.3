Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7E476B73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhLPIJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:09:31 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45155 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230324AbhLPIJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:09:30 -0500
Received: from [192.168.0.3] (ip5f5aecd0.dynamic.kabel-deutschland.de [95.90.236.208])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 68A8961E64846;
        Thu, 16 Dec 2021 09:09:28 +0100 (CET)
Message-ID: <712c7ae8-fde1-fa49-bf4d-49024b436438@molgen.mpg.de>
Date:   Thu, 16 Dec 2021 09:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
Content-Language: en-US
To:     Song Liu <song@kernel.org>, Yajun Deng <yajun.deng@linux.dev>
Cc:     stockhausen@collogia.de, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, linux-raid@vger.kernel.org,
        masahiroy@kernel.org, williams@redhat.com
References: <20211214031553.16435-1-yajun.deng@linux.dev>
 <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev>
 <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
 <3ed867e06f7f9bb9d89beaafc50905c8@linux.dev>
 <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Song, dear Yajun,


Am 16.12.21 um 07:39 schrieb Song Liu:
> On Wed, Dec 15, 2021 at 6:15 PM <yajun.deng@linux.dev> wrote:
>>
>> December 16, 2021 12:52 AM, "Song Liu" <song@kernel.org> wrote:
>>
>>> On Tue, Dec 14, 2021 at 6:14 PM <yajun.deng@linux.dev> wrote:
>>>
>>>> December 15, 2021 1:27 AM, "Song Liu" <song@kernel.org> wrote:
>>>>
>>>> On Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>
>>>> We found an abnormally high latency when executing modprobe raid6_pq, the
>>>> latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=y, greater than
>>>> 67ms when CONFIG_PREEMPT=y, and greater than 16ms when CONFIG_PREEMPT_RT=y.
>>>> This is caused by disable the preemption, this time is too long and
>>>> unreasonable. We just need to disable migration. so used migrate_disable()/
>>>> migrate_enable() instead of preempt_disable()/preempt_enable(). This is
>>>> beneficial for CONFIG_PREEMPT=y or CONFIG_PREEMPT_RT=y, but no effect for
>>>> CONFIG_PREEMPT_VOLUNTARY=y.
>>>>
>>>> Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions")
>>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>>>
>>>> We measure the speed of different RAID algorithms.If we don't disable
>>>> preempt, the result may be inaccurate, right? IIUC, we only disable preempt
>>>> for 16 jiffies. Why do we see 1.2 second delay?
>>>>
>>>> Here are the command of my test：
>>>> Execute "sudo cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m" in one terminal and "sudo modprobe
>>>> raid6_pq" in the other terminal.
>>>>
>>>> Here are the results of my test：
>>>> CONFIG_PREEMPT_VOLUNTARY=y，CONFIG_HZ_250=y
>>>> T: 0 ( 3092) P:95 I:1000 C: 8514 Min: 1 Act: 2 Avg: 1 Max: 6
>>>> T: 1 ( 3093) P:95 I:1000 C: 8511 Min: 1 Act: 2 Avg: 1 Max: 14
>>>
>>> I am not very familiar with the RT work, so please forgive me for some
>>> rookie questions.
>>>
>>>  From the result, I think the CONFIG_PREEMPT_VOLUNTARY=y and the
>>> CONFIG_PREEMPT=y cases failed to preempt during the preempt enabled period in
>>> raid6_choose_gen(). Is this expected?
>>>
>>
>> No, This is due to disable preemption causing ksoftirqd fail to schedule, we can use bcc tools see that.
>>
>>> OTOH, the 16ms latency with CONFIG_PREEMPT_RT=y is more or less expected.
>>> Is this acceptable? If not, is 1ms latency acceptable?
>>>
>>
>> Here are the test results after adding patch：
>> CONFIG_PREEMPT=y  or CONFIG_PREEMPT_RT=y
>> T: 0 ( 3167) P:95 I:1000 C:  13958 Min:      1 Act:    2 Avg:    1 Max:       5
>> T: 1 ( 3168) P:95 I:1000 C:  13956 Min:      1 Act:    2 Avg:    1 Max:       7
>> T: 2 ( 3169) P:95 I:1000 C:  13946 Min:      1 Act:    2 Avg:    1 Max:      12
>> T: 3 ( 3170) P:95 I:1000 C:  13951 Min:      1 Act:    2 Avg:    1 Max:       5
>> T: 4 ( 3171) P:95 I:1000 C:  13949 Min:      1 Act:    2 Avg:    1 Max:       3
>> T: 5 ( 3172) P:95 I:1000 C:  13947 Min:      1 Act:    2 Avg:    1 Max:      16
>> T: 6 ( 3173) P:95 I:1000 C:  13945 Min:      1 Act:    2 Avg:    2 Max:       7
>> T: 7 ( 3174) P:95 I:1000 C:  13942 Min:      1 Act:    2 Avg:    1 Max:       3
>> T: 8 ( 3175) P:95 I:1000 C:  13940 Min:      1 Act:    2 Avg:    1 Max:       3
>> T: 9 ( 3176) P:95 I:1000 C:  13938 Min:      1 Act:    1 Avg:    1 Max:       3
>> T:10 ( 3177) P:95 I:1000 C:  13936 Min:      1 Act:    2 Avg:    1 Max:       6
>> T:11 ( 3178) P:95 I:1000 C:  13933 Min:      1 Act:    2 Avg:    1 Max:       3
>> T:12 ( 3179) P:95 I:1000 C:  13931 Min:      1 Act:    2 Avg:    1 Max:       4
>> T:13 ( 3180) P:95 I:1000 C:  13929 Min:      1 Act:    2 Avg:    1 Max:       7
>> T:14 ( 3181) P:95 I:1000 C:  13927 Min:      1 Act:    2 Avg:    1 Max:       6
>> T:15 ( 3182) P:95 I:1000 C:  13925 Min:      1 Act:    2 Avg:    1 Max:       4
>> T:16 ( 3183) P:95 I:1000 C:  13923 Min:      1 Act:    2 Avg:    1 Max:       5
>> T:17 ( 3184) P:95 I:1000 C:  13921 Min:      1 Act:    2 Avg:    1 Max:       5
>> T:18 ( 3185) P:95 I:1000 C:  13919 Min:      1 Act:    2 Avg:    1 Max:       4
>> T:19 ( 3186) P:95 I:1000 C:  13916 Min:      1 Act:    2 Avg:    1 Max:       4
>> T:20 ( 3187) P:95 I:1000 C:  13914 Min:      1 Act:    2 Avg:    1 Max:       4
>> T:21 ( 3188) P:95 I:1000 C:  13912 Min:      1 Act:    2 Avg:    1 Max:      10
>> T:22 ( 3189) P:95 I:1000 C:  13910 Min:      1 Act:    2 Avg:    1 Max:       5
>> T:23 ( 3190) P:95 I:1000 C:  13908 Min:      1 Act:    2 Avg:    1 Max:       5
>> T:24 ( 3191) P:95 I:1000 C:  13906 Min:      1 Act:    2 Avg:    1 Max:      18
>> T:25 ( 3192) P:95 I:1000 C:  13904 Min:      1 Act:    2 Avg:    1 Max:       7
>> T:26 ( 3193) P:95 I:1000 C:  13902 Min:      1 Act:    2 Avg:    1 Max:       5
>> T:27 ( 3194) P:95 I:1000 C:  13900 Min:      1 Act:    1 Avg:    1 Max:      11
>> T:28 ( 3195) P:95 I:1000 C:  13898 Min:      1 Act:    2 Avg:    1 Max:       3
>> T:29 ( 3196) P:95 I:1000 C:  13896 Min:      1 Act:    2 Avg:    1 Max:       5
>> T:30 ( 3197) P:95 I:1000 C:  13894 Min:      1 Act:    2 Avg:    1 Max:       4
>> T:31 ( 3198) P:95 I:1000 C:  13892 Min:      1 Act:    2 Avg:    1 Max:       3
>>
>> we can see the latency will not greater than 100us，so 1ms latency is also too long for CONFIG_PREEMPT=y  or CONFIG_PREEMPT_RT=y.
>> use migrate_disable()/migrate_enable() instead of preempt_disable()/preempt_enable() will not affect the speed of different RAID algorithms and the latency can be reduced to a reasonable range.
> 
> I think allowing preempt may still affect the speed comparison. But
> such discrepancy should be acceptable. I will apply this to md-next.

Could the commit message please be extended, how to reproduce this? No 
idea, where to find `cyclictest` for example. Was `initcall_debug` used 
to measure the execution time of the init method?

Lastly, only one Fixes: tag is added, but the mentioned one only added 
one of the changed `preempt_enabled()`/`preempt_disable()`. Should all 
be listed?

The commit message could also say something like:

> Reduce high latency by using migrate instead of preempt


Kind regards,

Paul
