Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778804EDB95
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiCaOVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiCaOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:21:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762BA1BE4D3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:19:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g8so19818608qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y09hsrj+XWG1vnJX8tf5LeeL8uaCh9B8kep8EHmhUd8=;
        b=BWLtijSNu65PNLqlioEnCmNxQcWiZ+AOwMffqtr+XTZSFY9+1z11eTmDFbis0jPdIx
         RTFrcnHEquHsjNzNYaKVLt1LgPMlpwPdEYgJ4XiMzfUyElnSgLQAw3qogW1gQq3SXGO5
         JgFKbyiQzu0dg0cZ7LRLskutPrczRoQ5BqepxN6C0L9u/1bazaGFaeDQBJYCEEoC6Hhs
         3WO7PXvwy+CHMvRELXu1tlPqFrBUyBmgxcA486AMAfS7iATXUU/TA8ulg2WCmzFQ/5qE
         nvoZACE3iaHT9na1K9LlKxkTDP3K8AwOuIlE6FnDsZQVwKplsrGF16OdJSnXqnzw25VW
         7iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y09hsrj+XWG1vnJX8tf5LeeL8uaCh9B8kep8EHmhUd8=;
        b=0WLVZypz+fHGeSYmixz3L2MLVZpDnogSd4rcOW/p7NBLrGyp0BG0SjcgTejg9eTrgI
         yhWsCf2YSPyZUCy3YMVyTO3xtcitnuPuM6EX0VvndAlHFgXSte21YrIuiX20hPUGBGKx
         xFC343aD+f3EEMGQ/Rh4b4ogj8lCJV2TaxGT8x7MmO/4XQ0pEZJDT9hYbVQ6NOeYMbds
         wrzwaEzatJFM3Ry2C5jnRefVpfo3yuumuY9StVO90LTWzgmqrTFfrW/Q3lVJzBs7/FMh
         6/ObWdjOyKAm8xAH7Zp+nFFBDI3WkwaStai6225tzDGJaN0F/VCzWjoygvbfhZZYj0fc
         kYdA==
X-Gm-Message-State: AOAM533ORKqptZdIfEenlqmWpLjN+Y07kAn6XEzCr6m5/V8DtiPn8lxH
        ZxjcQWTadU3/CHjpMcXEa4mCHnX3vT7B8swqza/STwJwUoY=
X-Google-Smtp-Source: ABdhPJzZipMh/FIUersdmCXxpGczmdPOYkXV7ainJhN/B02N/xXy1LC6aAxJIWP+61wPofK890y+NNjFg0M1NbUP8u8=
X-Received: by 2002:a37:6408:0:b0:67b:119c:9ee6 with SMTP id
 y8-20020a376408000000b0067b119c9ee6mr3391022qkb.155.1648736381533; Thu, 31
 Mar 2022 07:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220204141941.GE4077@xsang-OptiPlex-9020>
In-Reply-To: <20220204141941.GE4077@xsang-OptiPlex-9020>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Thu, 31 Mar 2022 22:19:30 +0800
Message-ID: <CADjb_WT0fcP2QBjYpsCAJEcVYWKNw1rQ6XZNz33i+KCbD8jB-A@mail.gmail.com>
Subject: Re: [sched/pelt] 2d02fa8cc2: stress-ng.pipeherd.ops_per_sec -9.7% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Huang Ying <ying.huang@intel.com>,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wed, Feb 9, 2022 at 1:17 PM kernel test robot <oliver.sang@intel.com> wr=
ote:
>
>
>
> Greeting,
>
> FYI, we noticed a -9.7% regression of stress-ng.pipeherd.ops_per_sec due =
to commit:
>
>
> commit: 2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the =
sync of load_sum with load_avg")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: stress-ng
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU=
 @ 2.60GHz with 128G memory
> with following parameters:
>
>         nr_threads: 100%
>         testtime: 60s
>         class: memory
>         test: pipeherd
>         cpufreq_governor: performance
>         ucode: 0xd000280
>
This week we have re-run the test result and it seems that this
regression is still there.
As we are evaluating whether this report is valid or if the
downgrading is expected, appreciated
if you could give suggestion on further steps:

1.  If I understand correctly,
2d02fa8cc21a93da35cfba462bf8ab87bf2db651 ("sched/pelt: Relax the sync
of load_sum with load_avg")
     fixed the calculating of  load_sum.  Before this patch  the
contribution part would be 'skipped' and caused the load_sum
     to be lower than expected.
2. If above is true, after this patch, the load_sum becomes higher. Is
there a scenario that higher load_sum added to 1 cfs_rq brings
    more imbalance between this group and other sched_group, thus
brings more task migration/wake up? (because in below perf result,
    it seems that, with this patch applied, there are slightly more
take wake up)
3.  Consider the 9.7% downgrading is not that high,  do you think if
lkp team should continue track this issue or just close it
    as documented?

Best,
Yu
>
> commit:
>   95246d1ec8 ("sched/pelt: Relax the sync of runnable_sum with runnable_a=
vg")
>   2d02fa8cc2 ("sched/pelt: Relax the sync of load_sum with load_avg")
>
> 95246d1ec80b8d19 2d02fa8cc21a93da35cfba462bf
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>       0.21           +11.0%       0.24 =C4=85  2%  stress-ng.pipeherd.con=
text_switches_per_bogo_op
>  3.869e+09            -9.7%  3.494e+09        stress-ng.pipeherd.ops
>   64412021            -9.7%   58171101        stress-ng.pipeherd.ops_per_=
sec
>     442.37            -7.2%     410.54        stress-ng.time.user_time
>       5.49 =C4=85  2%      -0.5        4.94 =C4=85  4%  mpstat.cpu.all.us=
r%
>      80705 =C4=85  7%     +26.7%     102266 =C4=85 17%  numa-meminfo.node=
1.Active
>      80705 =C4=85  7%     +26.7%     102266 =C4=85 17%  numa-meminfo.node=
1.Active(anon)
>      12324 =C4=85  3%     -22.1%       9603 =C4=85 25%  softirqs.CPU106.R=
CU
>      12703 =C4=85  4%     -23.1%       9769 =C4=85 24%  softirqs.CPU27.RC=
U
>      15.96            +1.0       16.95        perf-profile.calltrace.cycl=
es-pp.prepare_to_wait_event.pipe_read.new_sync_read.vfs_read.ksys_read
>       6.67            +1.0        7.68 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wak=
e_function.__wake_up_common
>       6.77            +1.0        7.79 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_=
up_common.__wake_up_common_lock
>      14.46            +1.0       15.48 =C4=85  2%  perf-profile.calltrace=
.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.new_sync_=
read.vfs_read
>      13.73            +1.1       14.79 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_=
to_wait_event.pipe_read.new_sync_read
>      26.95            +1.4       28.34        perf-profile.calltrace.cycl=
es-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
>      25.85            +1.5       27.32        perf-profile.calltrace.cycl=
es-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_=
write
>      25.18            +1.5       26.69        perf-profile.calltrace.cycl=
es-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_=
write.new_sync_write
>      24.61            +1.5       26.14        perf-profile.calltrace.cycl=
es-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_co=
mmon_lock.pipe_write
