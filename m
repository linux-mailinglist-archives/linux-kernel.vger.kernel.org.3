Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88484791FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhLQQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:54:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:49630 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239413AbhLQQyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:54:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237328891"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="237328891"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 08:54:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="615612291"
Received: from nbothe-mobl1.amr.corp.intel.com (HELO [10.212.77.162]) ([10.212.77.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 08:54:16 -0800
Subject: Re: [PATCH 3/6] ASoC: soc-pcm: Fix and cleanup DPCM locking
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
 <20211207173745.15850-4-pierre-louis.bossart@linux.intel.com>
 <CGME20211217141541eucas1p1bdcb8b91e8a772229391b525d6adbf3b@eucas1p1.samsung.com>
 <9a0abddd-49e9-872d-2f00-a1697340f786@samsung.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f3057dc8-781c-f32a-d4f4-19ebd16d06ee@linux.intel.com>
Date:   Fri, 17 Dec 2021 10:54:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9a0abddd-49e9-872d-2f00-a1697340f786@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/21 8:15 AM, Marek Szyprowski wrote:
> Dear All,
> 
> On 07.12.2021 18:37, Pierre-Louis Bossart wrote:
>> From: Takashi Iwai <tiwai@suse.de>
>>
>> The existing locking for DPCM has several issues
>> a) a confusing mix of card->mutex and card->pcm_mutex.
>> b) a dpcm_lock spinlock added inconsistently and on paths that could
>> be recursively taken. The use of irqsave/irqrestore was also overkill.
>>
>> The suggested model is:
>>
>> 1) The pcm_mutex is the top-most protection of BE links in the FE. The
>> pcm_mutex is applied always on either the top PCM callbacks or the
>> external call from DAPM, not taken in the internal functions.
>>
>> 2) the FE stream lock is taken in higher levels before invoking
>> dpcm_be_dai_trigger()
>>
>> 3) when adding and deleting a BE, both the pcm_mutex and FE stream
>> lock are taken.
>>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> [clarification of commit message by plbossart]
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> This patch recently landed in linux-next (next-20211215) as commit 
> b7898396f4bb ("ASoC: soc-pcm: Fix and cleanup DPCM locking"). I found 
> that after applying it, a warning is triggered on my test boards. This 
> is the one from Exynos4412-based Odroid U3 board:
> 
> # speaker-test -l1
> 
> speaker-test 1.1.8
> 
> Playback device is default
> Stream parameters are 48000Hz, S16_LE, 1 channels
> Using 16 octaves of pink noise
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 128 to 131072
> Period size range from 64 to 65536
> Using max buffer size 131072
> Periods = 4
> was set period_size = 32768
> was set buffer_size = 131072
>   0 - Front Left
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.16.0-rc1-00270-gb2ae80663008 #11109 Not tainted
> --------------------------------------------
> speaker-test/1312 is trying to acquire lock:
> c1d78ca4 (&group->lock){....}-{2:2}, at: dpcm_be_dai_trigger+0x80/0x300
> 
> but task is already holding lock:
> c1d788a4 (&group->lock){....}-{2:2}, at: snd_pcm_action_lock_irq+0x68/0x7c
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&group->lock);
>    lock(&group->lock);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 1 lock held by speaker-test/1312:
>   #0: c1d788a4 (&group->lock){....}-{2:2}, at: 
> snd_pcm_action_lock_irq+0x68/0x7c
> 
> stack backtrace:
> CPU: 0 PID: 1312 Comm: speaker-test Not tainted 
> 5.16.0-rc1-00270-gb2ae80663008 #11109
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0110b30>] (unwind_backtrace) from [<c010c618>] (show_stack+0x10/0x14)
> [<c010c618>] (show_stack) from [<c0b65d24>] (dump_stack_lvl+0x58/0x70)
> [<c0b65d24>] (dump_stack_lvl) from [<c0193740>] 
> (__lock_acquire+0x15ac/0x319c)
> [<c0193740>] (__lock_acquire) from [<c0195dd8>] (lock_acquire+0x14c/0x424)
> [<c0195dd8>] (lock_acquire) from [<c0b745b8>] 
> (_raw_spin_lock_irqsave+0x44/0x60)
> [<c0b745b8>] (_raw_spin_lock_irqsave) from [<c0926b6c>] 
> (dpcm_be_dai_trigger+0x80/0x300)
> [<c0926b6c>] (dpcm_be_dai_trigger) from [<c0927004>] 
> (dpcm_fe_dai_do_trigger+0x124/0x1e4)
> [<c0927004>] (dpcm_fe_dai_do_trigger) from [<c090728c>] 
> (snd_pcm_action+0x74/0xb0)
> [<c090728c>] (snd_pcm_action) from [<c0907eac>] 
> (snd_pcm_action_lock_irq+0x3c/0x7c)
> [<c0907eac>] (snd_pcm_action_lock_irq) from [<c02f13a0>] 
> (sys_ioctl+0x568/0xd44)
> [<c02f13a0>] (sys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x1c)
> Exception stack(0xc4777fa8 to 0xc4777ff0)
> 7fa0:                   004f5210 b6e27394 00000004 00004142 004f5398 
> 004f5398
> 7fc0: 004f5210 b6e27394 00020000 00000036 00000000 00000000 bee588e8 
> 00008000
> 7fe0: b6e277c4 bee58874 b6d8e888 b6c751dc
> Time per period = 0.253397
> max98090 1-0010: PLL unlocked
> BUG: sleeping function called from invalid context at 
> kernel/locking/rwsem.c:1526
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1312, name: 
> speaker-test
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> irq event stamp: 8158
> hardirqs last  enabled at (8157): [<c0b747d0>] 
> _raw_spin_unlock_irqrestore+0x5c/0x60
> hardirqs last disabled at (8158): [<c0b74570>] _raw_spin_lock_irq+0x58/0x5c
> softirqs last  enabled at (7854): [<c0101578>] __do_softirq+0x348/0x610
> softirqs last disabled at (7849): [<c012e7a4>] __irq_exit_rcu+0x144/0x1ec
> Preemption disabled at:
> [<00000000>] 0x0
> CPU: 0 PID: 1312 Comm: speaker-test Not tainted 
> 5.16.0-rc1-00270-gb2ae80663008 #11109
> Hardware name: Samsung Exynos (Flattened Device Tree)
> [<c0110b30>] (unwind_backtrace) from [<c010c618>] (show_stack+0x10/0x14)
> [<c010c618>] (show_stack) from [<c0b65d24>] (dump_stack_lvl+0x58/0x70)
> [<c0b65d24>] (dump_stack_lvl) from [<c0158b04>] 
> (__might_resched+0x1c0/0x288)
> [<c0158b04>] (__might_resched) from [<c0b71898>] (down_write+0x24/0x8c)
> [<c0b71898>] (down_write) from [<c030ed64>] 
> (simple_recursive_removal+0x6c/0x370)
> [<c030ed64>] (simple_recursive_removal) from [<c04d07a4>] 
> (debugfs_remove+0x38/0x4c)
> [<c04d07a4>] (debugfs_remove) from [<c0928784>] 
> (dpcm_be_disconnect+0x160/0x2c4)
> [<c0928784>] (dpcm_be_disconnect) from [<c092895c>] 
> (dpcm_fe_dai_cleanup+0x74/0xb0)
> [<c092895c>] (dpcm_fe_dai_cleanup) from [<c0928d90>] 
> (dpcm_fe_dai_close+0xe8/0x14c)
> [<c0928d90>] (dpcm_fe_dai_close) from [<c090977c>] 
> (snd_pcm_release_substream.part.0+0x3c/0xcc)
> [<c090977c>] (snd_pcm_release_substream.part.0) from [<c0909878>] 
> (snd_pcm_release+0x54/0xa4)
> [<c0909878>] (snd_pcm_release) from [<c02dc400>] (__fput+0x88/0x258)
> [<c02dc400>] (__fput) from [<c014cd44>] (task_work_run+0x8c/0xc8)
> [<c014cd44>] (task_work_run) from [<c010c08c>] 
> (do_work_pending+0x4a4/0x598)
> [<c010c08c>] (do_work_pending) from [<c0100088>] 
> (slow_work_pending+0xc/0x20)
> Exception stack(0xc4777fb0 to 0xc4777ff8)
> 7fa0:                                     00000000 004f5260 004eaa9c 
> 00000000
> 7fc0: 004f5260 004f536c 004f5210 00000006 004fb700 004e6e8c 004d6120 
> bee58cc4
> 7fe0: b6e27e64 bee58928 b6d8eda4 b6d09ac0 60000050 00000004
> 
> Let me know how I can help debugging this issue.

Thanks for testing, much appreciated.

I wasn't really able to detect a smoking gun from the stack trace, but
this seems to point to the use of the FE stream lock

"
2) the FE stream lock is taken in higher levels before invoking
dpcm_be_dai_trigger()
"

I am not sure why we would attempt taking this lock multiple times though.

One possibility (chance of red-herring) is the code in
dpcm_set_fe_update_state(). The comments do mention the possibility of a
race condition and convoluted code. Would you be able to instrument this
code to see if the lock issue happens when this function is invoked?

Takashi may have other ideas to help debug? On our side this has been
used for several weeks and tested in all kinds of configurations.

