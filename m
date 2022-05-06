Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9951D69B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391321AbiEFL3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391300AbiEFL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:29:14 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D81B7D7
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:25:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220506112527euoutp024842cde3c1b3ea65e76855484a851477~sgGNSf5JS0831508315euoutp02k
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 11:25:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220506112527euoutp024842cde3c1b3ea65e76855484a851477~sgGNSf5JS0831508315euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651836327;
        bh=EayT0A5t2p3yXP/tr2sJJ0u7Tk/xg/gPZl2/FWIb/bA=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=Gji2n7LatuscZ9DBEN5nZdzXdZCD/9JZ+UevOTrhCaNOke6LeYAwO1nU69RdEZe4L
         rPLqoBnjIq/j0cUfLKde64lFUnMmo8kJrOwu47k3s5Sh4kRyL2yIQSIy3ldVOkssSf
         nXbmfRwkPAa4q2y6sUYObGPlKnFy0IZ2FPh9wFTc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220506112526eucas1p27198035d89303346d599d63d7917e401~sgGMznCoW2747627476eucas1p2F;
        Fri,  6 May 2022 11:25:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4E.37.09887.6A505726; Fri,  6
        May 2022 12:25:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6~sgGMREyAB1724117241eucas1p2j;
        Fri,  6 May 2022 11:25:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220506112526eusmtrp1ccf8df20df2fbf7bbd12bde94e9060b6~sgGMQR9rM2441724417eusmtrp1l;
        Fri,  6 May 2022 11:25:26 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-bf-627505a63755
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.A0.09522.6A505726; Fri,  6
        May 2022 12:25:26 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506112525eusmtip2fc71e7aa8d56e63bdfd312b13b6b1705~sgGLnxD9i0160001600eusmtip2z;
        Fri,  6 May 2022 11:25:25 +0000 (GMT)
Message-ID: <bb5cadc3-0940-7f5c-7a1b-8120ddac9039@samsung.com>
Date:   Fri, 6 May 2022 13:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Content-Language: en-US
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87rLWEuTDN5cMbI49/g3i8Xp/e9Y
        LJoXr2ez2HZlPqPFxP1n2S0u75rDZvH/8VdWi30dD5gsdm9cxGaxedNUZgcuj9kNF1k8Wvbd
        YvfYtKqTzePOtT1sHu/OnWP32D93DbvH+i1XWTw+b5IL4IjisklJzcksSy3St0vgynj/6jtz
        wWznikP9D1gaGKdZdjFyckgImEhcWPCSvYuRi0NIYAWjxJ0tr1ggnC+MEqc+nGeGcD4zSlxf
        vZEdpuXTg2dQVcsZJQ5+amGFcD4yShzbdYgZpIpXwE5i6ZcjYDaLgIrEgi+97BBxQYmTM5+w
        gNiiAkkSb95cBarh4BAWiJBo2xsKEmYWEJe49WQ+E4jNJmAo0fW2iw3EFhHwlnh79gzYrcwC
        T5kkNu44DjaHU8BeonnPLhaIZnmJ5q2zwc6WEGjnlJj0ey7U2S4Sf47MZoGwhSVeHd8CFZeR
        OD25hwXkCAmBfIm/M4whwhUS116vYYawrSXunPvFBlLCLKApsX6XPkTYUeLcll3MEJ18Ejfe
        CkJcwCcxadt0qDCvREebEES1msSs4+vgdh68cIl5AqPSLKQwmYXk+VlIfpmFsHcBI8sqRvHU
        0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwOR1+t/xLzsYl7/6qHeIkYmD8RCjBAezkgiv8KyS
        JCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1M3hPSPjRF
        t13Ptzj7Tvb2vcYtts8vG/Tc33dzp7XE13iVbaIxNwQTvnQ08Am/vp7NlPog62C2hpRC+v1n
        GqtOH07yrnsk1Rp+7vYS8dh2pTpTNrulzG4XXzIkxKwqnjsj4Mw+0V2uq0sdv7WvEZ5w3Ftc
        +Qzn7N/+s0OjjRdW7X4iPOnGygMCS7d9frts++NZauqHLU5tmWLRsfBVs0OAcneXXvzD3uwn
        cQ77ot5xP7pwKydjVoWJ240fLKeCS2snhd9O+SOkFfZBhFXU7Hq8a+GxDceDFX+YBjQv/Xzs
        US37/l8/claV/VANnb95fvf+C6ZJM6xsL1iFH/2/ctIqfTbGJ9+O+7AJX8zfe93mpRJLcUai
        oRZzUXEiACmy7O7NAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7rLWEuTDD5857Y49/g3i8Xp/e9Y
        LJoXr2ez2HZlPqPFxP1n2S0u75rDZvH/8VdWi30dD5gsdm9cxGaxedNUZgcuj9kNF1k8Wvbd
        YvfYtKqTzePOtT1sHu/OnWP32D93DbvH+i1XWTw+b5IL4IjSsynKLy1JVcjILy6xVYo2tDDS
        M7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3j/6jtzwWznikP9D1gaGKdZdjFyckgI
        mEh8evCMpYuRi0NIYCmjxIfd/cwQCRmJk9MaWCFsYYk/17rYIIreAxVtecECkuAVsJNY+uUI
        WAOLgIrEgi+97BBxQYmTM58A1XBwiAokSRw5zA9iCgtESLzvBetkFhCXuPVkPhOIzSZgKNH1
        FmQ8J4eIgLfE27Nn2CFqnjJJbLkqBLG2jUmiZ8MsRpAEp4C9RPOeXVCDzCS6tnYxQtjyEs1b
        ZzNPYBSaheSKWUj2zULSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiB8brt2M/N
        Oxjnvfqod4iRiYPxEKMEB7OSCK/wrJIkId6UxMqq1KL8+KLSnNTiQ4ymwKCYyCwlmpwPTBh5
        JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MnBeMf+zJ+aq+IcXg
        VJVD/STL2VELppk3L3wv/+u73aTJxzftERI9LfS0/e1fGY14l6yCwsj5zJVnmYqOam5ge1bZ
        U5F9IFg5ZIXQvrZ4XecPS0o8F/Q85ms+zueyj+1o0DLL46wmTL4FMVnh587EVpyLXLTAQuBj
        1MyqyvRbkwODitvMmlK9nieE+QWwzHz4NGf9jjvty7McbycJ5Zdt+W7m9nfZLD12rcJ7Sw1v
        n3rQIGTG8CDg/prIp7/KlT5Kt8m463f5y/qH/5e+a8m9ToCV+dfrj2/+yodMYgszNGOLWPil
        8eS83Yr1DRG1z49P+rHcbj2Dqu2M+g/B3p2cM6c/ZY53z9W04luw3F+JpTgj0VCLuag4EQA9
        V3/aYAMAAA==
X-CMS-MailID: 20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6
References: <20220421212250.565456-1-john.ogness@linutronix.de>
        <20220421212250.565456-15-john.ogness@linutronix.de>
        <878rrs6ft7.fsf@jogness.linutronix.de> <Ymfgis0EAw0Oxoa5@alley>
        <Ymfwk+X0CHq6ex3s@alley> <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
        <CGME20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6@eucas1p2.samsung.com>
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 27.04.2022 09:08, Marek Szyprowski wrote:
> On 26.04.2022 15:16, Petr Mladek wrote:
>> On Tue 2022-04-26 14:07:42, Petr Mladek wrote:
>>> On Mon 2022-04-25 23:04:28, John Ogness wrote:
>>>> Currently threaded console printers synchronize against each
>>>> other using console_lock(). However, different console drivers
>>>> are unrelated and do not require any synchronization between
>>>> each other. Removing the synchronization between the threaded
>>>> console printers will allow each console to print at its own
>>>> speed.
>>>>
>>>> But the threaded consoles printers do still need to synchronize
>>>> against console_lock() callers. Introduce a per-console mutex
>>>> and a new console boolean field @blocked to provide this
>>>> synchronization.
>>>>
>>>> console_lock() is modified so that it must acquire the mutex
>>>> of each console in order to set the @blocked field. Console
>>>> printing threads will acquire their mutex while printing a
>>>> record. If @blocked was set, the thread will go back to sleep
>>>> instead of printing.
>>>>
>>>> The reason for the @blocked boolean field is so that
>>>> console_lock() callers do not need to acquire multiple console
>>>> mutexes simultaneously, which would introduce unnecessary
>>>> complexity due to nested mutex locking. Also, a new field
>>>> was chosen instead of adding a new @flags value so that the
>>>> blocked status could be checked without concern of reading
>>>> inconsistent values due to @flags updates from other contexts.
>>>>
>>>> Threaded console printers also need to synchronize against
>>>> console_trylock() callers. Since console_trylock() may be
>>>> called from any context, the per-console mutex cannot be used
>>>> for this synchronization. (mutex_trylock() cannot be called
>>>> from atomic contexts.) Introduce a global atomic counter to
>>>> identify if any threaded printers are active. The threaded
>>>> printers will also check the atomic counter to identify if the
>>>> console has been locked by another task via console_trylock().
>>>>
>>>> Note that @console_sem is still used to provide synchronization
>>>> between console_lock() and console_trylock() callers.
>>>>
>>>> A locking overview for console_lock(), console_trylock(), and the
>>>> threaded printers is as follows (pseudo code):
>>>>
>>>> console_lock()
>>>> {
>>>>          down(&console_sem);
>>>>          for_each_console(con) {
>>>>                  mutex_lock(&con->lock);
>>>>                  con->blocked = true;
>>>>                  mutex_unlock(&con->lock);
>>>>          }
>>>>          /* console_lock acquired */
>>>> }
>>>>
>>>> console_trylock()
>>>> {
>>>>          if (down_trylock(&console_sem) == 0) {
>>>>                  if (atomic_cmpxchg(&console_kthreads_active, 0, 
>>>> -1) == 0) {
>>>>                          /* console_lock acquired */
>>>>                  }
>>>>          }
>>>> }
>>>>
>>>> threaded_printer()
>>>> {
>>>>          mutex_lock(&con->lock);
>>>>          if (!con->blocked) {
>>>>         /* console_lock() callers blocked */
>>>>
>>>>                  if 
>>>> (atomic_inc_unless_negative(&console_kthreads_active)) {
>>>>                          /* console_trylock() callers blocked */
>>>>
>>>>                          con->write();
>>>>
>>>> atomic_dec(&console_lock_count);
>>>>                  }
>>>>          }
>>>>          mutex_unlock(&con->lock);
>>>> }
>>>>
>>>> The console owner and waiter logic now only applies between contexts
>>>> that have taken the console_lock via console_trylock(). Threaded
>>>> printers never take the console_lock, so they do not have a
>>>> console_lock to handover. Tasks that have used console_lock() will
>>>> block the threaded printers using a mutex and if the console_lock
>>>> is handed over to an atomic context, it would be unable to unblock
>>>> the threaded printers. However, the console_trylock() case is
>>>> really the only scenario that is interesting for handovers anyway.
>>>>
>>>> @panic_console_dropped must change to atomic_t since it is no longer
>>>> protected exclusively by the console_lock.
>>>>
>>>> Since threaded printers remain asleep if they see that the console
>>>> is locked, they now must be explicitly woken in __console_unlock().
>>>> This means wake_up_klogd() calls following a console_unlock() are
>>>> no longer necessary and are removed.
>>>>
>>>> Also note that threaded printers no longer need to check
>>>> @console_suspended. The check for the @blocked field implicitly
>>>> covers the suspended console case.
>>>>
>>>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>>> Nice, it it better than v4. I am going to push this for linux-next.
>>>
>>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>> JFYI, I have just pushed this patch instead of the one
>> from v4 into printk/linux.git, branch rework/kthreads.
>>
>> It means that this branch has been rebased. It will be
>> used in the next refresh of linux-next.
>
> This patchset landed in linux next-20220426. In my tests I've found 
> that it causes deadlock on all my Amlogic Meson G12B/SM1 based boards: 
> Odroid C4/N2 and Khadas VIM3/VIM3l. The deadlock happens when system 
> boots to userspace and getty (with automated login) is executed. I 
> even see the bash prompt, but then the console is freezed. Reverting 
> this patch (e00cc0e1cbf4) on top of linux-next (together with 
> 6b3d71e87892 to make revert clean) fixes the issue.
>
The Amlogic Meson related issue has been investigated and fixed:

https://lore.kernel.org/all/b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com/

but I just found that there is one more issue.


It appears on QCom-based DragonBoard 410c SBC 
(arch/arm64/boot/dts/qcom/apq8016-sbc.dts). To see it on today's linux 
next-20220506, one has to revert 
42cd402b8fd4672b692400fe5f9eecd55d2794ac, otherwise lockdep triggers 
other warning and it is turned off too early:

================================
WARNING: inconsistent lock state
5.18.0-rc5-next-20220506+ #11869 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff80000aaa8478 (&port_lock_key){?.+.}-{2:2}, at: msm_uart_irq+0x38/0x750
{HARDIRQ-ON-W} state was registered at:
   lock_acquire.part.0+0xe0/0x230
   lock_acquire+0x68/0x84
   _raw_spin_lock+0x5c/0x80
   __msm_console_write+0x1ac/0x220
   msm_console_write+0x48/0x60
   __console_emit_next_record+0x188/0x420
   printk_kthread_func+0x3a0/0x3bc
   kthread+0x118/0x11c
   ret_from_fork+0x10/0x20
irq event stamp: 12182
hardirqs last  enabled at (12181): [<ffff800008e3d2a8>] 
cpuidle_enter_state+0xc4/0x30c

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc5-next-20220506+ #11869
Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
Call trace:
  dump_backtrace.part.0+0xd0/0xe0
  show_stack+0x18/0x6c
  dump_stack_lvl+0x8c/0xb8
  dump_stack+0x18/0x34
  print_usage_bug.part.0+0x208/0x22c
  mark_lock+0x710/0x954
  __lock_acquire+0x9fc/0x20cc
  lock_acquire.part.0+0xe0/0x230
  lock_acquire+0x68/0x84
  _raw_spin_lock_irqsave+0x80/0xcc
  msm_uart_irq+0x38/0x750
  __handle_irq_event_percpu+0xac/0x3d0
  handle_irq_event+0x4c/0x120
  handle_fasteoi_irq+0xa4/0x1a0
  generic_handle_domain_irq+0x3c/0x60
  gic_handle_irq+0x44/0xc4
  call_on_irq_stack+0x2c/0x54
  do_interrupt_handler+0x80/0x84
  el1_interrupt+0x34/0x64
  el1h_64_irq_handler+0x18/0x24
  el1h_64_irq+0x64/0x68
  cpuidle_enter_state+0xcc/0x30c
  cpuidle_enter+0x38/0x50
  do_idle+0x22c/0x2bc
  cpu_startup_entry+0x28/0x30
  rest_init+0x110/0x190
  arch_post_acpi_subsys_init+0x0/0x18
  start_kernel+0x6c4/0x704
  __primary_switched+0xc0/0xc8
  INIT: version 2.88 booting
[info] Using makefile-style concurrent boot in runlevel S.


Reverting the following patches on top of linux next-20220506 
fixes/hides this lockdep warning:

6b3d71e87892 ("printk: remove @console_locked")
8e274732115f ("printk: extend console_lock for per-console locking")
09c5ba0aa2fc ("printk: add kthread console printers")


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

