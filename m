Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CC5117DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiD0LsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiD0LsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:48:08 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8048334
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:44:56 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220427114452euoutp01cd6249d8613ead8917bad668a4dbb451~pvjmVJ0Jb1668916689euoutp012
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:44:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220427114452euoutp01cd6249d8613ead8917bad668a4dbb451~pvjmVJ0Jb1668916689euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651059892;
        bh=Rnaim7SrYTNkdIa6u+GiTXMQG22ohz+VE5CTQJTyB2s=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=p5HjNQmGZd8NfK7scDj7vY9J0nsY9vzEn+d3YTeXxIUyPDLIvwkkATdEXEp/uHVv6
         tDSVKF3UgXMxjs1A4RSROHU6S2KiXf9JE5EW6fdrVOo/I35v6khOn2zl4jWPvM3+6j
         msm70J2/+G6073eBk76PhK5jEtI8Wh/VemQFpzTY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427114452eucas1p272e4ad2628b9ed38b7091dcb234c52eb~pvjl_aEal0247502475eucas1p2-;
        Wed, 27 Apr 2022 11:44:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.3D.10260.4BC29626; Wed, 27
        Apr 2022 12:44:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220427114452eucas1p1ffa9335daa4d0666cbb5da3e8752264f~pvjlnUGgk2387223872eucas1p1E;
        Wed, 27 Apr 2022 11:44:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427114452eusmtrp1cd84a379556c658c46334fb9bf66384a~pvjlmivyL1823118231eusmtrp1A;
        Wed, 27 Apr 2022 11:44:52 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-f3-62692cb44599
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8D.8D.09522.4BC29626; Wed, 27
        Apr 2022 12:44:52 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220427114451eusmtip115ef2bc072518c95f53296939db71a18~pvjlHJCXF2564225642eusmtip1O;
        Wed, 27 Apr 2022 11:44:51 +0000 (GMT)
Message-ID: <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
Date:   Wed, 27 Apr 2022 13:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Ymjy3rHRenba7r7R@alley>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87pbdDKTDLYdlLVoXryezWLblfmM
        Fgtmc1tc3jWHzeL/46+sFvs6HjBZ7N64iM1i86apzA4cHrMbLrJ4tOy7xe7x7tw5do/9c9ew
        e2xeUu+xfstVFo/Pm+QC2KO4bFJSczLLUov07RK4MjYu7GUq+GFZcWTzXcYGxtu6XYycHBIC
        JhJXb7SwdjFycQgJrGCU2PX6OBOE84VR4tTZSWwQzmdGiak/LzDBtDxet4IVxBYSWM4oseJ2
        MkTRR0aJ18duMYMkeAXsJPbN72AHsVkEVCUuf3nNAhEXlDg58wmYLSqQJDF33z2geg4OYYEI
        iba9oSBhZgFxiVtP5oPtEhFQkng1/y4zRHwBk0RrQxqIzSZgKNH1tosNxOYEGv9qylN2iBp5
        ie1v5zCD3CMh8IFD4sWDbjaIo10klt2/xQphC0u8Or6FHcKWkTg9uYcF5AYJgXyJvzOMIcIV
        Etder2GGsK0l7pz7xQZSwiygKbF+lz5E2FFiyq8+dohOPokbbwUhLuCTmLRtOjNEmFeio00I
        olpNYtbxdXA7D164xDyBUWkWUpDMQvL7LCS/zELYu4CRZRWjeGppcW56arFxXmq5XnFibnFp
        Xrpecn7uJkZgWjr97/jXHYwrXn3UO8TIxMF4iFGCg1lJhPfL7owkId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUxRd5O3aPjN+vp1hV7pfqs7rsF8K03O
        H3yd9XWtwcHVf2NNwn1OLnxQaHxmx7X5J307TnhbOJ68ypXIuGP2effngvLqDZNMf6rMvH9e
        w8Wdd/2fdbM13/2dqN6eqezlWb+y4qe01IzUDvkfojVOubZPcqKvX7CRWVDUfbhzll3d9pN7
        g86WyV99f7KMefXafYE9TK8//zhwQErQdMOcoollOovntN7sdb3T5DtDwq+dr68uYe1CuSO5
        Zo32a843HTxXsVhW75aUyTHn+adj7rm235u1gj3zwb7+PoYzasxcrn7vpbSy6w2uRd/RLdFh
        VLlxTMCEY959gQJlc53Nz6W6TA6fP8vWkmn8cfGZN9uVWIozEg21mIuKEwGRrLA1ugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7pbdDKTDH5/YrFoXryezWLblfmM
        Fgtmc1tc3jWHzeL/46+sFvs6HjBZ7N64iM1i86apzA4cHrMbLrJ4tOy7xe7x7tw5do/9c9ew
        e2xeUu+xfstVFo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0MjYu7GUq+GFZcWTzXcYGxtu6XYycHBICJhKP161g7WLk4hASWMoocW7e
        NGaIhIzEyWkNrBC2sMSfa11sEEXvGSUm3pnPCJLgFbCT2De/gx3EZhFQlbj85TULRFxQ4uTM
        J2C2qECSxIttz4HqOTiEBSIk3veChZkFxCVuPZnPBGKLCChJvJp/lxlkPrPAAiaJdYvWMEIs
        +8okMbnlJ9gVbAKGEl1vQa7g5OAEWvZqylN2iElmEl1buxghbHmJ7W/nME9gFJqF5I5ZSBbO
        QtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIERue3Yz807GOe9+qh3iJGJg/EQ
        owQHs5II75fdGUlCvCmJlVWpRfnxRaU5qcWHGE2BgTGRWUo0OR+YEvJK4g3NDEwNTcwsDUwt
        zYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphYds3YtTvUVa9k88zF5rlN32Yn2KusDozR
        2TitK3573vl91rWpz8TXVFad2dXHHNlbF81lyS4fxZR+jrUx49yO189FrEsyFa1LqtQZ2RnF
        p/5UypjH/XR6wJ83VjuUOO8YhB7u9hViuPXzXN3rB3uaO/K3t5mdv/Fz0bQnloHFyVPn3jko
        6R+VsUfU0Veiu2ITW/w0tQ4OlsiXVf1Na05xzlh6pyvsmfqthCmvW/6qyu+5+9JZlZMjeFXa
        mfvswh9fKf3zyfI9KepxYOJRM/UIHq/ytYe2OjQwVBqHGC07euTk3AJPj1mdJudS97bx/NnA
        9ufdzdnxs5x5umzFAmOesiwz/3Az9Qa/3OaCLUosxRmJhlrMRcWJAM1IO3dRAwAA
X-CMS-MailID: 20220427114452eucas1p1ffa9335daa4d0666cbb5da3e8752264f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
References: <20220421212250.565456-1-john.ogness@linutronix.de>
        <20220421212250.565456-15-john.ogness@linutronix.de>
        <878rrs6ft7.fsf@jogness.linutronix.de> <Ymfgis0EAw0Oxoa5@alley>
        <Ymfwk+X0CHq6ex3s@alley>
        <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
        <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com> <Ymjy3rHRenba7r7R@alley>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27.04.2022 09:38, Petr Mladek wrote:
> On Wed 2022-04-27 09:08:33, Marek Szyprowski wrote:
>> On 26.04.2022 15:16, Petr Mladek wrote:
>>> On Tue 2022-04-26 14:07:42, Petr Mladek wrote:
>>>> On Mon 2022-04-25 23:04:28, John Ogness wrote:
>>>>> Currently threaded console printers synchronize against each
>>>>> other using console_lock(). However, different console drivers
>>>>> are unrelated and do not require any synchronization between
>>>>> each other. Removing the synchronization between the threaded
>>>>> console printers will allow each console to print at its own
>>>>> speed.
>>>>>
>>>>> But the threaded consoles printers do still need to synchronize
>>>>> against console_lock() callers. Introduce a per-console mutex
>>>>> and a new console boolean field @blocked to provide this
>>>>> synchronization.
>>>>>
>>>>> console_lock() is modified so that it must acquire the mutex
>>>>> of each console in order to set the @blocked field. Console
>>>>> printing threads will acquire their mutex while printing a
>>>>> record. If @blocked was set, the thread will go back to sleep
>>>>> instead of printing.
>>>>>
>>>>> The reason for the @blocked boolean field is so that
>>>>> console_lock() callers do not need to acquire multiple console
>>>>> mutexes simultaneously, which would introduce unnecessary
>>>>> complexity due to nested mutex locking. Also, a new field
>>>>> was chosen instead of adding a new @flags value so that the
>>>>> blocked status could be checked without concern of reading
>>>>> inconsistent values due to @flags updates from other contexts.
>>>>>
>>>>> Threaded console printers also need to synchronize against
>>>>> console_trylock() callers. Since console_trylock() may be
>>>>> called from any context, the per-console mutex cannot be used
>>>>> for this synchronization. (mutex_trylock() cannot be called
>>>>> from atomic contexts.) Introduce a global atomic counter to
>>>>> identify if any threaded printers are active. The threaded
>>>>> printers will also check the atomic counter to identify if the
>>>>> console has been locked by another task via console_trylock().
>>>>>
>>>>> Note that @console_sem is still used to provide synchronization
>>>>> between console_lock() and console_trylock() callers.
>>>>>
>>>>> A locking overview for console_lock(), console_trylock(), and the
>>>>> threaded printers is as follows (pseudo code):
>>>>>
>>>>> console_lock()
>>>>> {
>>>>>           down(&console_sem);
>>>>>           for_each_console(con) {
>>>>>                   mutex_lock(&con->lock);
>>>>>                   con->blocked = true;
>>>>>                   mutex_unlock(&con->lock);
>>>>>           }
>>>>>           /* console_lock acquired */
>>>>> }
>>>>>
>>>>> console_trylock()
>>>>> {
>>>>>           if (down_trylock(&console_sem) == 0) {
>>>>>                   if (atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0) {
>>>>>                           /* console_lock acquired */
>>>>>                   }
>>>>>           }
>>>>> }
>>>>>
>>>>> threaded_printer()
>>>>> {
>>>>>           mutex_lock(&con->lock);
>>>>>           if (!con->blocked) {
>>>>> 		/* console_lock() callers blocked */
>>>>>
>>>>>                   if (atomic_inc_unless_negative(&console_kthreads_active)) {
>>>>>                           /* console_trylock() callers blocked */
>>>>>
>>>>>                           con->write();
>>>>>
>>>>>                           atomic_dec(&console_lock_count);
>>>>>                   }
>>>>>           }
>>>>>           mutex_unlock(&con->lock);
>>>>> }
>>>>>
>>>>> The console owner and waiter logic now only applies between contexts
>>>>> that have taken the console_lock via console_trylock(). Threaded
>>>>> printers never take the console_lock, so they do not have a
>>>>> console_lock to handover. Tasks that have used console_lock() will
>>>>> block the threaded printers using a mutex and if the console_lock
>>>>> is handed over to an atomic context, it would be unable to unblock
>>>>> the threaded printers. However, the console_trylock() case is
>>>>> really the only scenario that is interesting for handovers anyway.
>>>>>
>>>>> @panic_console_dropped must change to atomic_t since it is no longer
>>>>> protected exclusively by the console_lock.
>>>>>
>>>>> Since threaded printers remain asleep if they see that the console
>>>>> is locked, they now must be explicitly woken in __console_unlock().
>>>>> This means wake_up_klogd() calls following a console_unlock() are
>>>>> no longer necessary and are removed.
>>>>>
>>>>> Also note that threaded printers no longer need to check
>>>>> @console_suspended. The check for the @blocked field implicitly
>>>>> covers the suspended console case.
>>>>>
>>>>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>>>> Nice, it it better than v4. I am going to push this for linux-next.
>>>>
>>>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>>> JFYI, I have just pushed this patch instead of the one
>>> from v4 into printk/linux.git, branch rework/kthreads.
>>>
>>> It means that this branch has been rebased. It will be
>>> used in the next refresh of linux-next.
>> This patchset landed in linux next-20220426. In my tests I've found that
>> it causes deadlock on all my Amlogic Meson G12B/SM1 based boards: Odroid
>> C4/N2 and Khadas VIM3/VIM3l. The deadlock happens when system boots to
>> userspace and getty (with automated login) is executed. I even see the
>> bash prompt, but then the console is freezed. Reverting this patch
>> (e00cc0e1cbf4) on top of linux-next (together with 6b3d71e87892 to make
>> revert clean) fixes the issue.
> Thanks a lot for the report!
>
> Just by chance, do you have the log from the dead-locked boot stored
> in userspace and can you share it? I mean the log stored in
> /var/log/dmesg or journaltctl.

If there would be any messages, I expect them to be visible on the 
serial kernel console.

> In the worst case, it might help to see log from the boot with
> the reverted patch. I would help us to see the ordering of various
> console-related operations on your system.
>
> And regarding the console. Is it the graphics console (ttyX)
> or a serial one (ttyS) or yet another one?

Serial console, /dev/ttyAML0 with kernel console enabled. Later a DRM 
driver is loaded (meson_drm), which initializes its fbdev emulation with 
its console.

However it looks that I've trusted automatic bisect a bit too much and 
had a bit of luck while checking the reverts on top of linux-next. The 
issue is not 100% reproducible, so I've did this bisection again 
manually with more tries. The real commit causing the issue is 
09c5ba0aa2fc ("printk: add kthread console printers"). Reverting the 
following 3 commits 6b3d71e878920b085dd823bc422951bb6f143505, 
e00cc0e1cbf4ea5a63d66c8de8d79519855fb231 and 
09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7 on top of linux-next makes the 
system fully operational again.

I've also tried to disable the DRM driver and its fbdev and console (by 
adding modprobe.blacklist=meson_drm to kernel cmdline), but this didn't 
help. Here is the full serial console log:

https://pastebin.com/E5CDH88L

If there is anything you would like me to try, let me know.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

