Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE83478871
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhLQKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:11:57 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38578 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhLQKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:11:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211217101154euoutp023c85b1ff3842d16d804a275e1d5c042e~BgyBZRsvi1679616796euoutp02C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:11:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211217101154euoutp023c85b1ff3842d16d804a275e1d5c042e~BgyBZRsvi1679616796euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639735914;
        bh=0jlDFTzK4qEWW3cjcWyoPQu+PYJZvi/IhsvkmhwkrHk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Kyp4FqULYOBsXvHLsVrbPol8PHHgJlwTh5dKaVJ62QvF5R0uR9kh+6YPEY2nPhy4X
         kH9LCQUf5bGj8VBZtM78Xeq9V57aeElm1Qt5vX9ZB0soYDQAPTP7cqRbVbRKDmQK71
         NlbaEoQz2xoF5T2Kk/dOQ9+OeCfjl6Np6Bmmk/tY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211217101153eucas1p111b0e8a876095754428156f2773dcf6b~BgyAkwRsE1882618826eucas1p1o;
        Fri, 17 Dec 2021 10:11:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 22.D0.10260.9626CB16; Fri, 17
        Dec 2021 10:11:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211217101152eucas1p14ea09622edde5118ddd832c3ebaebdde~Bgx-8tDru0173201732eucas1p1-;
        Fri, 17 Dec 2021 10:11:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211217101152eusmtrp23280a2402aa8ecacaba04fe4855782a4~Bgx-7o5763209632096eusmtrp2L;
        Fri, 17 Dec 2021 10:11:52 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-ba-61bc62698b61
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.FE.09522.8626CB16; Fri, 17
        Dec 2021 10:11:52 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211217101151eusmtip2d8141d23af9e2a227e415252dc18b6ef~Bgx_60ot81620716207eusmtip2S;
        Fri, 17 Dec 2021 10:11:51 +0000 (GMT)
Message-ID: <660cd57a-d445-63ba-b0bf-6bf6168ffee0@samsung.com>
Date:   Fri, 17 Dec 2021 11:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 4/6] ASoC: soc-pcm: serialize BE triggers
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20211207173745.15850-5-pierre-louis.bossart@linux.intel.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7djP87qZSXsSDfb0iVhcuXiIyWLqwyds
        FvO+pFtcufOW3eL8+Q3sFq8O72K0+Halg8ni8q45bBYzzu9jsujc1c9qceS5ksWv/8+YLO6u
        +8ticfhNO6tFxx01iw3f1zJavNz8hsli550TzBZbftU4CHts+NzE5rFz1l12j02rOtk85p0M
        9Ohtfsfmse/tMjaPb2cmsnj0bVnF6LF+y1UWj82nqz0+b5IL4I7isklJzcksSy3St0vgypg2
        1argeGjFhHkXWRoYG9y6GDk4JARMJFpbbbsYuTiEBFYwSvw+3MwK4XxhlNh7qYMdwvnMKPFr
        +hy2LkZOsI4Tp/6zQSSWM0pMO7uUEcL5yCjxZ2kfK0gVr4CdxML/B9hBbBYBVYntvWuZIOKC
        EidnPmEBsUUFkiRaO/6AxYUFbCVmb9kI1sssIC5x68l8sLiIQJzE8i/nwc5gFpjNKjHn2kVG
        kASbgKFE19susJM4BbwkDrfvZ4Nolpdo3jqbGaRBQuAWp8SDu9vYIe52kfjavw3qB2GJV8e3
        QMVlJP7vBNkG0tDMKPHw3Fp2CKeHUeJy0wxGiCpriTvnfrGBwoxZQFNi/S59iLCjxIlJe9gh
        QcknceOtIMQRfBKTtk1nhgjzSnS0CUFUq0nMOr4Obu3BC5eYJzAqzUIKl1lI/p+F5J1ZCHsX
        MLKsYhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECEyWp/8d/7qDccWrj3qHGJk4GA8xSnAw
        K4nwKi7fnSjEm5JYWZValB9fVJqTWnyIUZqDRUmcNzlzQ6KQQHpiSWp2ampBahFMlomDU6qB
        KXvhDY1lqvPEOruzXlu9ZV9+naP2W/s0mVI3Sy6LljL+tK0b53pdFg9+wLxT0U0krOP/FvF5
        vG4br2c/E7gXsMyj8N2yhBZvz4szlretZlAI7L/huXftV90l4VYe/lp+1u9VZ8772Pd7xj8j
        qXsl3/5b5cWuubclRdJl1eL3rqVfbXR9OMUL2A/o5Ud/ubOxxDTp50mr1JsZ/HmVO1q2Coh2
        WdyXW8K0J6BR+43uRYX7CaZNOZvWtCcs+ejxobBfuPvOrOXTTRZrf/J2fMmyseAJu9p2waWf
        j3Pf+/l7+xreMtl0bv4dduVXON9tNflcaux4r73RoXPnVvk9Plwf1rpfqptxcof3HTfuSzP3
        KLEUZyQaajEXFScCAIdJQTAFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Pd2MpD2JBjM/K1pcuXiIyWLqwyds
        FvO+pFtcufOW3eL8+Q3sFq8O72K0+Halg8ni8q45bBYzzu9jsujc1c9qceS5ksWv/8+YLO6u
        +8ticfhNO6tFxx01iw3f1zJavNz8hsli550TzBZbftU4CHts+NzE5rFz1l12j02rOtk85p0M
        9Ohtfsfmse/tMjaPb2cmsnj0bVnF6LF+y1UWj82nqz0+b5IL4I7SsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5g21argeGjFhHkXWRoYG9y6GDk5
        JARMJE6c+s/WxcjFISSwlFFix/pHTBAJGYmT0xpYIWxhiT/XuqCK3jNKzLp/B6yIV8BOYuH/
        A+wgNouAqsT23rVQcUGJkzOfsIDYogJJErvXbWUDsYUFbCVmb9kINpRZQFzi1pP5YPUiAnES
        uxceYgFZwCwwl1Wi7+FtZohtnYwST1cdBatiEzCU6HrbBTaJU8BL4nD7fjaISWYSXVu7GCFs
        eYnmrbOZJzAKzUJyyCwkC2chaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwPSw
        7djPzTsY5736qHeIkYmD8RCjBAezkgiv4vLdiUK8KYmVValF+fFFpTmpxYcYTYGhMZFZSjQ5
        H5ig8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamBzsF2850nK4
        Uv/GV7c+62e1TXz3u2b+vnXqcKbjS+ngP/Ybv9SUBszjYnuwovi1yNIJN18lqZRu+fTv69V3
        f5/fiKy272KfIsC6P+YiW/6nE6fOFF7dd/SduoBGoXh5rFWrfg3nXk/mGY8/q0ct11RbZvzr
        Qcy5uRO7rqmyMuhmhP2pknh60P/Jvhvrb3B3Hmx6H3SBYfejlCRdYye+F3t2Nc5v6JoiUFly
        9f/BXW+0CqMbcx4VPZpT/yuhJL6Mh/vi7ysCT/aZvpmvsVe1RFVu+Z4VXhl98QfPvpCSCJgX
        OvFDbPxuic9p7nYnGp8WubxTPhXCUeDj/VN3xsxtdYbbXnOdm85Z3fCroSqYp0KJpTgj0VCL
        uag4EQBEIIIUmAMAAA==
X-CMS-MailID: 20211217101152eucas1p14ea09622edde5118ddd832c3ebaebdde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211217101152eucas1p14ea09622edde5118ddd832c3ebaebdde
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211217101152eucas1p14ea09622edde5118ddd832c3ebaebdde
References: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
        <20211207173745.15850-5-pierre-louis.bossart@linux.intel.com>
        <CGME20211217101152eucas1p14ea09622edde5118ddd832c3ebaebdde@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

On 07.12.2021 18:37, Pierre-Louis Bossart wrote:
> From: Takashi Iwai <tiwai@suse.de>
>
> When more than one FE is connected to a BE, e.g. in a mixing use case,
> the BE can be triggered multiple times when the FE are opened/started
> concurrently. This race condition is problematic in the case of
> SoundWire BE dailinks, and this is not desirable in a general
> case.
>
> This patch relies on the existing BE PCM lock, which takes atomicity into
> account. The locking model assumes that all interactions start with
> the FE, so that there is no deadlock between FE and BE locks.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [test, checkpatch fix and clarification of commit message by plbossart]
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

This patch recently landed in linux-next (next-20211215) as commit 
b2ae80663008 ("ASoC: soc-pcm: serialize BE triggers"). I found that it 
triggers a warning on my test boards. This is the one from 
Exynos4412-based Odroid U3 board:

# speaker-test -l1

speaker-test 1.1.8

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 128 to 131072
Period size range from 64 to 65536
Using max buffer size 131072
Periods = 4
was set period_size = 32768
was set buffer_size = 131072
  0 - Front Left

============================================
WARNING: possible recursive locking detected
5.16.0-rc1-00270-gb2ae80663008 #11109 Not tainted
--------------------------------------------
speaker-test/1312 is trying to acquire lock:
c1d78ca4 (&group->lock){....}-{2:2}, at: dpcm_be_dai_trigger+0x80/0x300

but task is already holding lock:
c1d788a4 (&group->lock){....}-{2:2}, at: snd_pcm_action_lock_irq+0x68/0x7c

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&group->lock);
   lock(&group->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

1 lock held by speaker-test/1312:
  #0: c1d788a4 (&group->lock){....}-{2:2}, at: 
snd_pcm_action_lock_irq+0x68/0x7c

stack backtrace:
CPU: 0 PID: 1312 Comm: speaker-test Not tainted 
5.16.0-rc1-00270-gb2ae80663008 #11109
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0110b30>] (unwind_backtrace) from [<c010c618>] (show_stack+0x10/0x14)
[<c010c618>] (show_stack) from [<c0b65d24>] (dump_stack_lvl+0x58/0x70)
[<c0b65d24>] (dump_stack_lvl) from [<c0193740>] 
(__lock_acquire+0x15ac/0x319c)
[<c0193740>] (__lock_acquire) from [<c0195dd8>] (lock_acquire+0x14c/0x424)
[<c0195dd8>] (lock_acquire) from [<c0b745b8>] 
(_raw_spin_lock_irqsave+0x44/0x60)
[<c0b745b8>] (_raw_spin_lock_irqsave) from [<c0926b6c>] 
(dpcm_be_dai_trigger+0x80/0x300)
[<c0926b6c>] (dpcm_be_dai_trigger) from [<c0927004>] 
(dpcm_fe_dai_do_trigger+0x124/0x1e4)
[<c0927004>] (dpcm_fe_dai_do_trigger) from [<c090728c>] 
(snd_pcm_action+0x74/0xb0)
[<c090728c>] (snd_pcm_action) from [<c0907eac>] 
(snd_pcm_action_lock_irq+0x3c/0x7c)
[<c0907eac>] (snd_pcm_action_lock_irq) from [<c02f13a0>] 
(sys_ioctl+0x568/0xd44)
[<c02f13a0>] (sys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x1c)
Exception stack(0xc4777fa8 to 0xc4777ff0)
7fa0:                   004f5210 b6e27394 00000004 00004142 004f5398 
004f5398
7fc0: 004f5210 b6e27394 00020000 00000036 00000000 00000000 bee588e8 
00008000
7fe0: b6e277c4 bee58874 b6d8e888 b6c751dc
Time per period = 0.253397
max98090 1-0010: PLL unlocked
BUG: sleeping function called from invalid context at 
kernel/locking/rwsem.c:1526
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1312, name: 
speaker-test
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
irq event stamp: 8158
hardirqs last  enabled at (8157): [<c0b747d0>] 
_raw_spin_unlock_irqrestore+0x5c/0x60
hardirqs last disabled at (8158): [<c0b74570>] _raw_spin_lock_irq+0x58/0x5c
softirqs last  enabled at (7854): [<c0101578>] __do_softirq+0x348/0x610
softirqs last disabled at (7849): [<c012e7a4>] __irq_exit_rcu+0x144/0x1ec
Preemption disabled at:
[<00000000>] 0x0
CPU: 0 PID: 1312 Comm: speaker-test Not tainted 
5.16.0-rc1-00270-gb2ae80663008 #11109
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0110b30>] (unwind_backtrace) from [<c010c618>] (show_stack+0x10/0x14)
[<c010c618>] (show_stack) from [<c0b65d24>] (dump_stack_lvl+0x58/0x70)
[<c0b65d24>] (dump_stack_lvl) from [<c0158b04>] 
(__might_resched+0x1c0/0x288)
[<c0158b04>] (__might_resched) from [<c0b71898>] (down_write+0x24/0x8c)
[<c0b71898>] (down_write) from [<c030ed64>] 
(simple_recursive_removal+0x6c/0x370)
[<c030ed64>] (simple_recursive_removal) from [<c04d07a4>] 
(debugfs_remove+0x38/0x4c)
[<c04d07a4>] (debugfs_remove) from [<c0928784>] 
(dpcm_be_disconnect+0x160/0x2c4)
[<c0928784>] (dpcm_be_disconnect) from [<c092895c>] 
(dpcm_fe_dai_cleanup+0x74/0xb0)
[<c092895c>] (dpcm_fe_dai_cleanup) from [<c0928d90>] 
(dpcm_fe_dai_close+0xe8/0x14c)
[<c0928d90>] (dpcm_fe_dai_close) from [<c090977c>] 
(snd_pcm_release_substream.part.0+0x3c/0xcc)
[<c090977c>] (snd_pcm_release_substream.part.0) from [<c0909878>] 
(snd_pcm_release+0x54/0xa4)
[<c0909878>] (snd_pcm_release) from [<c02dc400>] (__fput+0x88/0x258)
[<c02dc400>] (__fput) from [<c014cd44>] (task_work_run+0x8c/0xc8)
[<c014cd44>] (task_work_run) from [<c010c08c>] (do_work_pending+0x4a4/0x598)
[<c010c08c>] (do_work_pending) from [<c0100088>] 
(slow_work_pending+0xc/0x20)
Exception stack(0xc4777fb0 to 0xc4777ff8)
7fa0:                                     00000000 004f5260 004eaa9c 
00000000
7fc0: 004f5260 004f536c 004f5210 00000006 004fb700 004e6e8c 004d6120 
bee58cc4
7fe0: b6e27e64 bee58928 b6d8eda4 b6d09ac0 60000050 00000004

Let me know how I can help debugging this issue.

> ---
>   sound/soc/soc-pcm.c | 46 ++++++++++++++++++++++++++++-----------------
>   1 file changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 2e282c42bac2..7043857e30b1 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -46,12 +46,18 @@ static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runtime *rtd,
>   	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
>   }
>   
> +#define snd_soc_dpcm_stream_lock_irqsave(rtd, stream, flags) \
> +	snd_pcm_stream_lock_irqsave(snd_soc_dpcm_get_substream(rtd, stream), flags)
> +
>   static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
>   						  int stream)
>   {
>   	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream));
>   }
>   
> +#define snd_soc_dpcm_stream_unlock_irqrestore(rtd, stream, flags) \
> +	snd_pcm_stream_unlock_irqrestore(snd_soc_dpcm_get_substream(rtd, stream), flags)
> +
>   #define DPCM_MAX_BE_USERS	8
>   
>   static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
> @@ -2079,6 +2085,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
>   {
>   	struct snd_soc_pcm_runtime *be;
>   	struct snd_soc_dpcm *dpcm;
> +	unsigned long flags;
>   	int ret = 0;
>   
>   	for_each_dpcm_be(fe, stream, dpcm) {
> @@ -2087,9 +2094,11 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
>   		be = dpcm->be;
>   		be_substream = snd_soc_dpcm_get_substream(be, stream);
>   
> +		snd_soc_dpcm_stream_lock_irqsave(be, stream, flags);
> +
>   		/* is this op for this BE ? */
>   		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
> -			continue;
> +			goto next;
>   
>   		dev_dbg(be->dev, "ASoC: trigger BE %s cmd %d\n",
>   			be->dai_link->name, cmd);
> @@ -2099,77 +2108,80 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
>   			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
>   			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
>   			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
> -				continue;
> +				goto next;
>   
>   			ret = soc_pcm_trigger(be_substream, cmd);
>   			if (ret)
> -				goto end;
> +				goto next;
>   
>   			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
>   			break;
>   		case SNDRV_PCM_TRIGGER_RESUME:
>   			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
> -				continue;
> +				goto next;
>   
>   			ret = soc_pcm_trigger(be_substream, cmd);
>   			if (ret)
> -				goto end;
> +				goto next;
>   
>   			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
>   			break;
>   		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>   			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
> -				continue;
> +				goto next;
>   
>   			ret = soc_pcm_trigger(be_substream, cmd);
>   			if (ret)
> -				goto end;
> +				goto next;
>   
>   			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
>   			break;
>   		case SNDRV_PCM_TRIGGER_STOP:
>   			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
>   			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
> -				continue;
> +				goto next;
>   
>   			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
> -				continue;
> +				goto next;
>   
>   			ret = soc_pcm_trigger(be_substream, cmd);
>   			if (ret)
> -				goto end;
> +				goto next;
>   
>   			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
>   			break;
>   		case SNDRV_PCM_TRIGGER_SUSPEND:
>   			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
> -				continue;
> +				goto next;
>   
>   			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
> -				continue;
> +				goto next;
>   
>   			ret = soc_pcm_trigger(be_substream, cmd);
>   			if (ret)
> -				goto end;
> +				goto next;
>   
>   			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
>   			break;
>   		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>   			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
> -				continue;
> +				goto next;
>   
>   			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
> -				continue;
> +				goto next;
>   
>   			ret = soc_pcm_trigger(be_substream, cmd);
>   			if (ret)
> -				goto end;
> +				goto next;
>   
>   			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
>   			break;
>   		}
> +next:
> +		snd_soc_dpcm_stream_unlock_irqrestore(be, stream, flags);
> +		if (ret)
> +			break;
>   	}
> -end:
>   	if (ret < 0)
>   		dev_err(fe->dev, "ASoC: %s() failed at %s (%d)\n",
>   			__func__, be->dai_link->name, ret);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

