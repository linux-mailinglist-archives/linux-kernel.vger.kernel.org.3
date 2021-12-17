Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2093E478D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhLQOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:15:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:25297 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbhLQOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:15:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211217141542euoutp0101965d6561e9f24ff69af30e54a9037c~BkG5Akw100188801888euoutp01R
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 14:15:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211217141542euoutp0101965d6561e9f24ff69af30e54a9037c~BkG5Akw100188801888euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639750542;
        bh=i0R7EOiVa1R0JQDjR1c+AV8ztmrgfroQ3QBMQnQOcFk=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=fNzAW7CqKg5vVz100382iPWIKPDELmLtUe+7nN40N5Nh9OGXO5oQ7wylRThlFPuwp
         WyEY/7QFPfhD5YFdsXyOzh5MVsYZ+S1WodcOBeFVAz6fMUfAD3HrftX7QJ63swWkwK
         UsB/ywd6G+CHwih4Y89p9Vd2pt1puEawqY7nlW08=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211217141541eucas1p1bdb10c70d5dfad985c6ffd991ad82004~BkG4dH4KP1529315293eucas1p1c;
        Fri, 17 Dec 2021 14:15:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FC.5C.09887.D8B9CB16; Fri, 17
        Dec 2021 14:15:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211217141541eucas1p1bdcb8b91e8a772229391b525d6adbf3b~BkG3_TBGK1529215292eucas1p11;
        Fri, 17 Dec 2021 14:15:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211217141541eusmtrp2667b8f65338f411ea48a313228b2fa8a~BkG39WeTH1291812918eusmtrp2D;
        Fri, 17 Dec 2021 14:15:41 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-93-61bc9b8da267
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.03.09404.D8B9CB16; Fri, 17
        Dec 2021 14:15:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211217141540eusmtip171141eec9c2b7e1206242a97f062e843~BkG2uejax2740527405eusmtip1H;
        Fri, 17 Dec 2021 14:15:40 +0000 (GMT)
Message-ID: <9a0abddd-49e9-872d-2f00-a1697340f786@samsung.com>
Date:   Fri, 17 Dec 2021 15:15:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 3/6] ASoC: soc-pcm: Fix and cleanup DPCM locking
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
In-Reply-To: <20211207173745.15850-4-pierre-louis.bossart@linux.intel.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTZxjH895dr0dd9Sgy3jBWw2VjcRuIVs2bsZERCLm5ZYOYLItzcze4
        lTKoridTN5YRoFqqOBUX8CD82BKKTCpBRFuhaEuGFbSAuLgJOCNIvFBJbcc2wubWnm789/m+
        7/O8z/f75KVwTVARTxmMu3mTkStiSBXR8+OfvuTq+l4u1XxVh8ZH3Rj69s40iRpDejQ+4Vci
        n69TiSSPE6CFcQuGrjsbSFTnc2GoyvmNAg3MMmjx0T0MTdr/IpBn7oACWSaSUOfvHQDdPzOH
        IcfEZRx1L5a+HsN2BstJ1iFOKtmu9iqSbfTmstUVD0jW5W8l2YXhowR7uLsdsKe7bxDsmaEv
        2WCXNmfFNtWr+XyR4XPetC79I1XBWI+o2GWpxPaO9k+DMmAfB1YQRUF6IzzrP6q0AhWlodsA
        nLl8F5NFCMA/AudIWQQBPD4pKp60SD+UP66yAfjr0AAuiwCAfb0SHq5S0+nQ6a8lrICiCPp5
        6GhbKx9HQ++JaSLMsfTH0GxZwsIcQ2dBp3l/hHE6Dv4y3RTh1fSH0BbyRfzhdL0CNvw0GjFO
        0uuh1W8lwxxFb4HSTK9Sbl4DK87W47LTqSh4c+w9mbNg8PhVUuYYKA12K2VOgI8cTZE0kK4A
        8M61DqUsDgF4vbzu8ZrS4MS1RTKcBqfXwtPOdWGEdAasWNoq40p40x8tW1gJj/XU4vKxGlr2
        a+Q3kqA4aP9v6qWRMfwIYMRlWxGXpReXhRH/H9sMiHYQx5cIxXpe2GDk96QIXLFQYtSn5O0s
        7gL//suhvwdD54FNCqS4AUYBN4AUzqxWJ9oucBp1PrfvC960c4eppIgX3OAZimDi1HmGTk5D
        67nd/Kc8v4s3PbnFqKj4MuyDe9+33vh6e2Z+ZeBKwuYTZu9XC4VNb8Q733ylJXFh43xpohhq
        m9/kVTd7RguEPam5J+fuG+PB2znv/0xtG5Ae6mfnl97quxRb2zGlu1W5uEIz1Lx5zcFT2/s2
        3JofPhDK6vce8dYYPsk+h96hczMDts8w/2u65IuFz1V6tMlXbrNYbs537KTQlFYz3JJ9qlFq
        +S0pddWm6pfabU+5jCfPG5ysJdBlZLZgjgEvmfeu1tyaNvPsTAz20MPsOBhXNpU297Sqyl7i
        LUx0aetSVr1wMSPD/WD4cDrbm9CQaWdeDmD7dHd1rr392YfaYj3R9XZUO6LbOnshmh3R3i6V
        CmoYQijg1r+ImwTuHwMRLMsGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42I5/e/4Xd3e2XsSDRp3iVhcuXiIyWLqwyds
        FvO+pFtcufOW3eL8+Q3sFq8O72K0+Halg8ni8q45bBYzzu9jsujc1c9qceS5ksWv/8+YLO6u
        +8ticfhNO6tFxx01iw3f1zJavNz8hsli550TzBZbftU4CHts+NzE5rFz1l12j02rOtk85p0M
        9Ohtfsfmse/tMjaPb2cmsnj0bVnF6LF+y1UWj82nqz0+b5IL4I7SsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7i0bRZrQUcLU8XF/U8YGxjXXWHs
        YuTkkBAwkXi1uompi5GLQ0hgKaPExFuz2CASMhInpzWwQtjCEn+udbFBFL1nlNjYf4AFJMEr
        YCex6+10IJuDg0VAVWLnCk2IsKDEyZlPwEpEBZIkdq/bCjZTWMBFYldrGxOIzSwgLnHryXww
        W0QgTmL3wkMsIPOZBeaySvQ9vM0MsayTUWLhjkfMIFVsAoYSXW+7wCZxCnhJvHq6hx1ikplE
        19YuRghbXqJ562zmCYxCs5AcMgvJwllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/
        dxMjMEVsO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMKruHx3ohBvSmJlVWpRfnxRaU5q8SFGU2Bg
        TGSWEk3OByapvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJoar
        pt+rWk/1aKz3Yb/4sHLBzfvf7r81dWZ1+Cm88JqshmjH1RNbuVVyXj42lpD64hfAdCXv7cwj
        tW9+eTqXH50WNvdK+Nvts6zFbnusnnmovU4p9BhDzeub7+tbutZmnorrmNW52vz+3VPJHmbz
        11z9fPdi15lV2X2L3J0M9s/c5sV1fPmphLIXn5PLovtr1TJ8etP7XSc5tmwO3f3m5Nd2HTHj
        kFXScmsFjHcXuXB4lnUkn+9ovC0SpNfD3XLJpfWZ/afj9k7vnv+yD+/RtD7Tn/vDpLxnruUx
        IZMKJa2DV/669eiUXhSTlJG2YY4/zL71mePy+3O29G7ik/i71+HdXf/6Z28enF98fdXL/Uos
        xRmJhlrMRcWJAGcoch2aAwAA
X-CMS-MailID: 20211217141541eucas1p1bdcb8b91e8a772229391b525d6adbf3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211217141541eucas1p1bdcb8b91e8a772229391b525d6adbf3b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211217141541eucas1p1bdcb8b91e8a772229391b525d6adbf3b
References: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
        <20211207173745.15850-4-pierre-louis.bossart@linux.intel.com>
        <CGME20211217141541eucas1p1bdcb8b91e8a772229391b525d6adbf3b@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

On 07.12.2021 18:37, Pierre-Louis Bossart wrote:
> From: Takashi Iwai <tiwai@suse.de>
>
> The existing locking for DPCM has several issues
> a) a confusing mix of card->mutex and card->pcm_mutex.
> b) a dpcm_lock spinlock added inconsistently and on paths that could
> be recursively taken. The use of irqsave/irqrestore was also overkill.
>
> The suggested model is:
>
> 1) The pcm_mutex is the top-most protection of BE links in the FE. The
> pcm_mutex is applied always on either the top PCM callbacks or the
> external call from DAPM, not taken in the internal functions.
>
> 2) the FE stream lock is taken in higher levels before invoking
> dpcm_be_dai_trigger()
>
> 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> lock are taken.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [clarification of commit message by plbossart]
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

This patch recently landed in linux-next (next-20211215) as commit 
b7898396f4bb ("ASoC: soc-pcm: Fix and cleanup DPCM locking"). I found 
that after applying it, a warning is triggered on my test boards. This 
is the one from Exynos4412-based Odroid U3 board:

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
[<c014cd44>] (task_work_run) from [<c010c08c>] 
(do_work_pending+0x4a4/0x598)
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
>   include/sound/soc.h  |   2 -
>   sound/soc/soc-core.c |   1 -
>   sound/soc/soc-pcm.c  | 229 ++++++++++++++++++++++++++++---------------
>   3 files changed, 152 insertions(+), 80 deletions(-)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 8e6dd8a257c5..5872a8864f3b 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -893,8 +893,6 @@ struct snd_soc_card {
>   	struct mutex pcm_mutex;
>   	enum snd_soc_pcm_subclass pcm_subclass;
>   
> -	spinlock_t dpcm_lock;
> -
>   	int (*probe)(struct snd_soc_card *card);
>   	int (*late_probe)(struct snd_soc_card *card);
>   	int (*remove)(struct snd_soc_card *card);
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index dcf6be4c4aaa..1d62160f96b1 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2315,7 +2315,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
>   	mutex_init(&card->mutex);
>   	mutex_init(&card->dapm_mutex);
>   	mutex_init(&card->pcm_mutex);
> -	spin_lock_init(&card->dpcm_lock);
>   
>   	return snd_soc_bind_card(card);
>   }
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 3a34b71fd3c1..2e282c42bac2 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -27,6 +27,31 @@
>   #include <sound/soc-link.h>
>   #include <sound/initval.h>
>   
> +static inline void snd_soc_dpcm_mutex_lock(struct snd_soc_pcm_runtime *rtd)
> +{
> +	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
> +}
> +
> +static inline void snd_soc_dpcm_mutex_unlock(struct snd_soc_pcm_runtime *rtd)
> +{
> +	mutex_unlock(&rtd->card->pcm_mutex);
> +}
> +
> +#define snd_soc_dpcm_mutex_assert_held(rtd) \
> +	lockdep_assert_held(&(rtd)->card->pcm_mutex)
> +
> +static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runtime *rtd,
> +						int stream)
> +{
> +	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
> +}
> +
> +static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
> +						  int stream)
> +{
> +	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream));
> +}
> +
>   #define DPCM_MAX_BE_USERS	8
>   
>   static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
> @@ -73,7 +98,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
>   	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
>   	struct snd_soc_dpcm *dpcm;
>   	ssize_t offset = 0;
> -	unsigned long flags;
>   
>   	/* FE state */
>   	offset += scnprintf(buf + offset, size - offset,
> @@ -101,7 +125,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
>   		goto out;
>   	}
>   
> -	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>   	for_each_dpcm_be(fe, stream, dpcm) {
>   		struct snd_soc_pcm_runtime *be = dpcm->be;
>   		params = &dpcm->hw_params;
> @@ -122,7 +145,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
>   					   params_channels(params),
>   					   params_rate(params));
>   	}
> -	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>   out:
>   	return offset;
>   }
> @@ -145,11 +167,13 @@ static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
>   	if (!buf)
>   		return -ENOMEM;
>   
> +	snd_soc_dpcm_mutex_lock(fe);
>   	for_each_pcm_streams(stream)
>   		if (snd_soc_dai_stream_valid(asoc_rtd_to_cpu(fe, 0), stream))
>   			offset += dpcm_show_state(fe, stream,
>   						  buf + offset,
>   						  out_count - offset);
> +	snd_soc_dpcm_mutex_unlock(fe);
>   
>   	ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
>   
> @@ -221,14 +245,14 @@ static void dpcm_set_fe_update_state(struct snd_soc_pcm_runtime *fe,
>   	struct snd_pcm_substream *substream =
>   		snd_soc_dpcm_get_substream(fe, stream);
>   
> -	snd_pcm_stream_lock_irq(substream);
> +	snd_soc_dpcm_stream_lock_irq(fe, stream);
>   	if (state == SND_SOC_DPCM_UPDATE_NO && fe->dpcm[stream].trigger_pending) {
>   		dpcm_fe_dai_do_trigger(substream,
>   				       fe->dpcm[stream].trigger_pending - 1);
>   		fe->dpcm[stream].trigger_pending = 0;
>   	}
>   	fe->dpcm[stream].runtime_update = state;
> -	snd_pcm_stream_unlock_irq(substream);
> +	snd_soc_dpcm_stream_unlock_irq(fe, stream);
>   }
>   
>   static void dpcm_set_be_update_state(struct snd_soc_pcm_runtime *be,
> @@ -256,7 +280,7 @@ void snd_soc_runtime_action(struct snd_soc_pcm_runtime *rtd,
>   	struct snd_soc_dai *dai;
>   	int i;
>   
> -	lockdep_assert_held(&rtd->card->pcm_mutex);
> +	snd_soc_dpcm_mutex_assert_held(rtd);
>   
>   	for_each_rtd_dais(rtd, i, dai)
>   		snd_soc_dai_action(dai, stream, action);
> @@ -309,6 +333,8 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
>   {
>   	struct snd_soc_dpcm *dpcm;
>   
> +	snd_soc_dpcm_mutex_assert_held(fe);
> +
>   	for_each_dpcm_be(fe, dir, dpcm) {
>   
>   		struct snd_soc_pcm_runtime *be = dpcm->be;
> @@ -646,14 +672,14 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream,
>   	return ret;
>   }
>   
> -static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
> +static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
> +			 struct snd_pcm_substream *substream, int rollback)
>   {
> -	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>   	struct snd_soc_component *component;
>   	struct snd_soc_dai *dai;
>   	int i;
>   
> -	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
> +	snd_soc_dpcm_mutex_assert_held(rtd);
>   
>   	if (!rollback)
>   		snd_soc_runtime_deactivate(rtd, substream->stream);
> @@ -665,9 +691,6 @@ static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
>   
>   	soc_pcm_components_close(substream, rollback);
>   
> -
> -	mutex_unlock(&rtd->card->pcm_mutex);
> -
>   	snd_soc_pcm_component_pm_runtime_put(rtd, substream, rollback);
>   
>   	for_each_rtd_components(rtd, i, component)
> @@ -682,9 +705,21 @@ static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollback)
>    * freed here. The cpu DAI, codec DAI, machine and components are also
>    * shutdown.
>    */
> +static int __soc_pcm_close(struct snd_soc_pcm_runtime *rtd,
> +			   struct snd_pcm_substream *substream)
> +{
> +	return soc_pcm_clean(rtd, substream, 0);
> +}
> +
> +/* PCM close ops for non-DPCM streams */
>   static int soc_pcm_close(struct snd_pcm_substream *substream)
>   {
> -	return soc_pcm_clean(substream, 0);
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +
> +	snd_soc_dpcm_mutex_lock(rtd);
> +	soc_pcm_clean(rtd, substream, 0);
> +	snd_soc_dpcm_mutex_unlock(rtd);
> +	return 0;
>   }
>   
>   static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
> @@ -730,21 +765,21 @@ static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
>    * then initialized and any private data can be allocated. This also calls
>    * startup for the cpu DAI, component, machine and codec DAI.
>    */
> -static int soc_pcm_open(struct snd_pcm_substream *substream)
> +static int __soc_pcm_open(struct snd_soc_pcm_runtime *rtd,
> +			  struct snd_pcm_substream *substream)
>   {
> -	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>   	struct snd_soc_component *component;
>   	struct snd_soc_dai *dai;
>   	int i, ret = 0;
>   
> +	snd_soc_dpcm_mutex_assert_held(rtd);
> +
>   	for_each_rtd_components(rtd, i, component)
>   		pinctrl_pm_select_default_state(component->dev);
>   
>   	ret = snd_soc_pcm_component_pm_runtime_get(rtd, substream);
>   	if (ret < 0)
> -		goto pm_err;
> -
> -	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
> +		goto err;
>   
>   	ret = soc_pcm_components_open(substream);
>   	if (ret < 0)
> @@ -791,16 +826,26 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
>   	snd_soc_runtime_activate(rtd, substream->stream);
>   	ret = 0;
>   err:
> -	mutex_unlock(&rtd->card->pcm_mutex);
> -pm_err:
>   	if (ret < 0) {
> -		soc_pcm_clean(substream, 1);
> +		soc_pcm_clean(rtd, substream, 1);
>   		dev_err(rtd->dev, "%s() failed (%d)", __func__, ret);
>   	}
>   
>   	return ret;
>   }
>   
> +/* PCM open ops for non-DPCM streams */
> +static int soc_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	int ret;
> +
> +	snd_soc_dpcm_mutex_lock(rtd);
> +	ret = __soc_pcm_open(rtd, substream);
> +	snd_soc_dpcm_mutex_unlock(rtd);
> +	return ret;
> +}
> +
>   static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
>   {
>   	/*
> @@ -816,13 +861,13 @@ static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
>    * rate, etc.  This function is non atomic and can be called multiple times,
>    * it can refer to the runtime info.
>    */
> -static int soc_pcm_prepare(struct snd_pcm_substream *substream)
> +static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
> +			     struct snd_pcm_substream *substream)
>   {
> -	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>   	struct snd_soc_dai *dai;
>   	int i, ret = 0;
>   
> -	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
> +	snd_soc_dpcm_mutex_assert_held(rtd);
>   
>   	ret = snd_soc_link_prepare(substream);
>   	if (ret < 0)
> @@ -850,14 +895,24 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
>   		snd_soc_dai_digital_mute(dai, 0, substream->stream);
>   
>   out:
> -	mutex_unlock(&rtd->card->pcm_mutex);
> -
>   	if (ret < 0)
>   		dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
>   
>   	return ret;
>   }
>   
> +/* PCM prepare ops for non-DPCM streams */
> +static int soc_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	int ret;
> +
> +	snd_soc_dpcm_mutex_lock(rtd);
> +	ret = __soc_pcm_prepare(rtd, substream);
> +	snd_soc_dpcm_mutex_unlock(rtd);
> +	return ret;
> +}
> +
>   static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
>   				       unsigned int mask)
>   {
> @@ -869,13 +924,13 @@ static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
>   	interval->max = channels;
>   }
>   
> -static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rollback)
> +static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
> +			    struct snd_pcm_substream *substream, int rollback)
>   {
> -	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>   	struct snd_soc_dai *dai;
>   	int i;
>   
> -	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
> +	snd_soc_dpcm_mutex_assert_held(rtd);
>   
>   	/* clear the corresponding DAIs parameters when going to be inactive */
>   	for_each_rtd_dais(rtd, i, dai) {
> @@ -900,16 +955,28 @@ static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rollback)
>   		if (snd_soc_dai_stream_valid(dai, substream->stream))
>   			snd_soc_dai_hw_free(dai, substream, rollback);
>   
> -	mutex_unlock(&rtd->card->pcm_mutex);
>   	return 0;
>   }
>   
>   /*
>    * Frees resources allocated by hw_params, can be called multiple times
>    */
> +static int __soc_pcm_hw_free(struct snd_soc_pcm_runtime *rtd,
> +			     struct snd_pcm_substream *substream)
> +{
> +	return soc_pcm_hw_clean(rtd, substream, 0);
> +}
> +
> +/* hw_free PCM ops for non-DPCM streams */
>   static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
>   {
> -	return soc_pcm_hw_clean(substream, 0);
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	int ret;
> +
> +	snd_soc_dpcm_mutex_lock(rtd);
> +	ret = __soc_pcm_hw_free(rtd, substream);
> +	snd_soc_dpcm_mutex_unlock(rtd);
> +	return ret;
>   }
>   
>   /*
> @@ -917,15 +984,15 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
>    * function can also be called multiple times and can allocate buffers
>    * (using snd_pcm_lib_* ). It's non-atomic.
>    */
> -static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
> -				struct snd_pcm_hw_params *params)
> +static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
> +			       struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params)
>   {
> -	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>   	struct snd_soc_dai *cpu_dai;
>   	struct snd_soc_dai *codec_dai;
>   	int i, ret = 0;
>   
> -	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
> +	snd_soc_dpcm_mutex_assert_held(rtd);
>   
>   	ret = soc_pcm_params_symmetry(substream, params);
>   	if (ret)
> @@ -997,16 +1064,27 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
>   
>   	ret = snd_soc_pcm_component_hw_params(substream, params);
>   out:
> -	mutex_unlock(&rtd->card->pcm_mutex);
> -
>   	if (ret < 0) {
> -		soc_pcm_hw_clean(substream, 1);
> +		soc_pcm_hw_clean(rtd, substream, 1);
>   		dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
>   	}
>   
>   	return ret;
>   }
>   
> +/* hw_params PCM ops for non-DPCM streams */
> +static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	int ret;
> +
> +	snd_soc_dpcm_mutex_lock(rtd);
> +	ret = __soc_pcm_hw_params(rtd, substream, params);
> +	snd_soc_dpcm_mutex_unlock(rtd);
> +	return ret;
> +}
> +
>   static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>   {
>   	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> @@ -1107,7 +1185,8 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
>   	struct snd_pcm_substream *fe_substream;
>   	struct snd_pcm_substream *be_substream;
>   	struct snd_soc_dpcm *dpcm;
> -	unsigned long flags;
> +
> +	snd_soc_dpcm_mutex_assert_held(fe);
>   
>   	/* only add new dpcms */
>   	for_each_dpcm_be(fe, stream, dpcm) {
> @@ -1137,10 +1216,10 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
>   	dpcm->fe = fe;
>   	be->dpcm[stream].runtime = fe->dpcm[stream].runtime;
>   	dpcm->state = SND_SOC_DPCM_LINK_STATE_NEW;
> -	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
> +	snd_soc_dpcm_stream_lock_irq(fe, stream);
>   	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
>   	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
> -	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
> +	snd_soc_dpcm_stream_unlock_irq(fe, stream);
>   
>   	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
>   			stream ? "capture" : "playback",  fe->dai_link->name,
> @@ -1183,8 +1262,10 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
>   void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
>   {
>   	struct snd_soc_dpcm *dpcm, *d;
> -	unsigned long flags;
>   
> +	snd_soc_dpcm_mutex_assert_held(fe);
> +
> +	snd_soc_dpcm_stream_lock_irq(fe, stream);
>   	for_each_dpcm_be_safe(fe, stream, dpcm, d) {
>   		dev_dbg(fe->dev, "ASoC: BE %s disconnect check for %s\n",
>   				stream ? "capture" : "playback",
> @@ -1202,12 +1283,11 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
>   
>   		dpcm_remove_debugfs_state(dpcm);
>   
> -		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>   		list_del(&dpcm->list_be);
>   		list_del(&dpcm->list_fe);
> -		spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>   		kfree(dpcm);
>   	}
> +	snd_soc_dpcm_stream_unlock_irq(fe, stream);
>   }
>   
>   /* get BE for DAI widget and stream */
> @@ -1431,12 +1511,9 @@ int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
>   void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
>   {
>   	struct snd_soc_dpcm *dpcm;
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>   	for_each_dpcm_be(fe, stream, dpcm)
>   		dpcm_set_be_update_state(dpcm->be, stream, SND_SOC_DPCM_UPDATE_NO);
> -	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>   }
>   
>   void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
> @@ -1472,12 +1549,12 @@ void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
>   				continue;
>   
>   			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) {
> -				soc_pcm_hw_free(be_substream);
> +				__soc_pcm_hw_free(be, be_substream);
>   				be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
>   			}
>   		}
>   
> -		soc_pcm_close(be_substream);
> +		__soc_pcm_close(be, be_substream);
>   		be_substream->runtime = NULL;
>   		be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
>   	}
> @@ -1525,7 +1602,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
>   			stream ? "capture" : "playback", be->dai_link->name);
>   
>   		be_substream->runtime = be->dpcm[stream].runtime;
> -		err = soc_pcm_open(be_substream);
> +		err = __soc_pcm_open(be, be_substream);
>   		if (err < 0) {
>   			be->dpcm[stream].users--;
>   			if (be->dpcm[stream].users < 0)
> @@ -1769,7 +1846,7 @@ static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
>   	dev_dbg(fe->dev, "ASoC: open FE %s\n", fe->dai_link->name);
>   
>   	/* start the DAI frontend */
> -	ret = soc_pcm_open(fe_substream);
> +	ret = __soc_pcm_open(fe, fe_substream);
>   	if (ret < 0)
>   		goto unwind;
>   
> @@ -1800,6 +1877,8 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
>   	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
>   	int stream = substream->stream;
>   
> +	snd_soc_dpcm_mutex_assert_held(fe);
> +
>   	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
>   
>   	/* shutdown the BEs */
> @@ -1808,7 +1887,7 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
>   	dev_dbg(fe->dev, "ASoC: close FE %s\n", fe->dai_link->name);
>   
>   	/* now shutdown the frontend */
> -	soc_pcm_close(substream);
> +	__soc_pcm_close(fe, substream);
>   
>   	/* run the stream stop event */
>   	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
> @@ -1853,7 +1932,7 @@ void dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
>   		dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
>   			be->dai_link->name);
>   
> -		soc_pcm_hw_free(be_substream);
> +		__soc_pcm_hw_free(be, be_substream);
>   
>   		be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
>   	}
> @@ -1864,13 +1943,13 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
>   	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
>   	int stream = substream->stream;
>   
> -	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +	snd_soc_dpcm_mutex_lock(fe);
>   	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
>   
>   	dev_dbg(fe->dev, "ASoC: hw_free FE %s\n", fe->dai_link->name);
>   
>   	/* call hw_free on the frontend */
> -	soc_pcm_hw_free(substream);
> +	soc_pcm_hw_clean(fe, substream, 0);
>   
>   	/* only hw_params backends that are either sinks or sources
>   	 * to this frontend DAI */
> @@ -1879,7 +1958,7 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
>   	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
>   	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
>   
> -	mutex_unlock(&fe->card->mutex);
> +	snd_soc_dpcm_mutex_unlock(fe);
>   	return 0;
>   }
>   
> @@ -1923,7 +2002,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
>   		dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
>   			be->dai_link->name);
>   
> -		ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
> +		ret = __soc_pcm_hw_params(be, be_substream, &dpcm->hw_params);
>   		if (ret < 0)
>   			goto unwind;
>   
> @@ -1953,7 +2032,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
>   		   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
>   			continue;
>   
> -		soc_pcm_hw_free(be_substream);
> +		__soc_pcm_hw_free(be, be_substream);
>   	}
>   
>   	return ret;
> @@ -1965,7 +2044,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
>   	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
>   	int ret, stream = substream->stream;
>   
> -	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +	snd_soc_dpcm_mutex_lock(fe);
>   	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
>   
>   	memcpy(&fe->dpcm[stream].hw_params, params,
> @@ -1979,7 +2058,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
>   			params_channels(params), params_format(params));
>   
>   	/* call hw_params on the frontend */
> -	ret = soc_pcm_hw_params(substream, params);
> +	ret = __soc_pcm_hw_params(fe, substream, params);
>   	if (ret < 0)
>   		dpcm_be_dai_hw_free(fe, stream);
>   	else
> @@ -1987,7 +2066,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
>   
>   out:
>   	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
> -	mutex_unlock(&fe->card->mutex);
> +	snd_soc_dpcm_mutex_unlock(fe);
>   
>   	if (ret < 0)
>   		dev_err(fe->dev, "ASoC: %s failed (%d)\n", __func__, ret);
> @@ -2258,7 +2337,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
>   		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
>   			be->dai_link->name);
>   
> -		ret = soc_pcm_prepare(be_substream);
> +		ret = __soc_pcm_prepare(be, be_substream);
>   		if (ret < 0)
>   			break;
>   
> @@ -2276,7 +2355,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
>   	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(substream);
>   	int stream = substream->stream, ret = 0;
>   
> -	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +	snd_soc_dpcm_mutex_lock(fe);
>   
>   	dev_dbg(fe->dev, "ASoC: prepare FE %s\n", fe->dai_link->name);
>   
> @@ -2295,7 +2374,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
>   		goto out;
>   
>   	/* call prepare on the frontend */
> -	ret = soc_pcm_prepare(substream);
> +	ret = __soc_pcm_prepare(fe, substream);
>   	if (ret < 0)
>   		goto out;
>   
> @@ -2303,7 +2382,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
>   
>   out:
>   	dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
> -	mutex_unlock(&fe->card->mutex);
> +	snd_soc_dpcm_mutex_unlock(fe);
>   
>   	if (ret < 0)
>   		dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
> @@ -2354,7 +2433,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
>   	struct snd_soc_dpcm *dpcm;
>   	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
>   	int ret = 0;
> -	unsigned long flags;
>   
>   	dev_dbg(fe->dev, "ASoC: runtime %s open on FE %s\n",
>   			stream ? "capture" : "playback", fe->dai_link->name);
> @@ -2423,7 +2501,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
>   	dpcm_be_dai_shutdown(fe, stream);
>   disconnect:
>   	/* disconnect any pending BEs */
> -	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>   	for_each_dpcm_be(fe, stream, dpcm) {
>   		struct snd_soc_pcm_runtime *be = dpcm->be;
>   
> @@ -2435,7 +2512,6 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
>   			be->dpcm[stream].state == SND_SOC_DPCM_STATE_NEW)
>   				dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
>   	}
> -	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>   
>   	if (ret < 0)
>   		dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, ret);
> @@ -2510,7 +2586,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card *card)
>   	struct snd_soc_pcm_runtime *fe;
>   	int ret = 0;
>   
> -	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +	mutex_lock_nested(&card->pcm_mutex, card->pcm_subclass);
>   	/* shutdown all old paths first */
>   	for_each_card_rtds(card, fe) {
>   		ret = soc_dpcm_fe_runtime_update(fe, 0);
> @@ -2526,7 +2602,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card *card)
>   	}
>   
>   out:
> -	mutex_unlock(&card->mutex);
> +	mutex_unlock(&card->pcm_mutex);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(snd_soc_dpcm_runtime_update);
> @@ -2537,6 +2613,8 @@ static void dpcm_fe_dai_cleanup(struct snd_pcm_substream *fe_substream)
>   	struct snd_soc_dpcm *dpcm;
>   	int stream = fe_substream->stream;
>   
> +	snd_soc_dpcm_mutex_assert_held(fe);
> +
>   	/* mark FE's links ready to prune */
>   	for_each_dpcm_be(fe, stream, dpcm)
>   		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
> @@ -2551,12 +2629,12 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
>   	struct snd_soc_pcm_runtime *fe = asoc_substream_to_rtd(fe_substream);
>   	int ret;
>   
> -	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +	snd_soc_dpcm_mutex_lock(fe);
>   	ret = dpcm_fe_dai_shutdown(fe_substream);
>   
>   	dpcm_fe_dai_cleanup(fe_substream);
>   
> -	mutex_unlock(&fe->card->mutex);
> +	snd_soc_dpcm_mutex_unlock(fe);
>   	return ret;
>   }
>   
> @@ -2567,7 +2645,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
>   	int ret;
>   	int stream = fe_substream->stream;
>   
> -	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +	snd_soc_dpcm_mutex_lock(fe);
>   	fe->dpcm[stream].runtime = fe_substream->runtime;
>   
>   	ret = dpcm_path_get(fe, stream, &list);
> @@ -2584,7 +2662,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
>   	dpcm_clear_pending_state(fe, stream);
>   	dpcm_path_put(&list);
>   open_end:
> -	mutex_unlock(&fe->card->mutex);
> +	snd_soc_dpcm_mutex_unlock(fe);
>   	return ret;
>   }
>   
> @@ -2845,10 +2923,8 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
>   	struct snd_soc_dpcm *dpcm;
>   	int state;
>   	int ret = 1;
> -	unsigned long flags;
>   	int i;
>   
> -	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>   	for_each_dpcm_fe(be, stream, dpcm) {
>   
>   		if (dpcm->fe == fe)
> @@ -2862,7 +2938,6 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
>   			}
>   		}
>   	}
> -	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>   
>   	/* it's safe to do this BE DAI */
>   	return ret;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

