Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9296D562C64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiGAHPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGAHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:15:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E466B276
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:15:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so990460wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lw8ZlwadLY0wkiHoA0z4GBncJvnPkTnilxujckAMYIE=;
        b=moQgk9C2Fb3qL9azQrATSZ7jlyc6Dn83wNYY/G8lRBO4VB4C7ab04tYwC4pYTCepE3
         p/FJBgf76lVvoy+W1koFX/Xcu28c/JeQ97N30NjYYDBdve6+2oPqNMB/PESC7ad1Eyft
         J9V3SbSMtSfMUBrnIJkMQQs09JfjSSgUdNWVAd2HT74Tp0eavY3D1FARD1KaSs+Xk5Nt
         P2Y/qXVQvkdPbmCM5LwSEux/bIOjJhy6BYI4x/Tq4tfmX3WyPfo9+Ssz9S/xzfNu5aHt
         7CjkCdTjOMKjU23VPwoWyO1u9Uctdn8ivYgTQRMryHnyVncEgVkhp+2NPqK/3ncXeMLg
         DjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lw8ZlwadLY0wkiHoA0z4GBncJvnPkTnilxujckAMYIE=;
        b=IWwiKxk4sXgKs21eqrf+0uefwr9oQa7tInp7ZpHpwyIkOCY8Umcr9EtKdfE4AfISuT
         G/HWbYL/pdGvua9Zfvnas6Ro/xWWCtXU/mB/hlNUxk3MQFMQ/aug9wHODg+OR8LmVdYw
         4/l2AnqbFHg/lYkY1dLxvvhSIgIkV2VL09AWZfsWWWBEDUHjyfAwvnQazNV45LqwcKnn
         Ak0yFE81mW0Rldjhj1ZRwHvBLrZQoCa4NShlWHZPZP4Y9wWX2ln5ytS9gJF7bYRgCN6t
         yYSCwKvmu7sblqzb/bIfUvi7L5K1lVYP5Vf3KVm40DTscSR6YyMV+fr9/r7EqqJgt0Lw
         l7Yw==
X-Gm-Message-State: AJIora+In32BoTdC396OvE6kNIXUH8b+pt1tG8aCKcLBfa3W3l7YnQ0t
        0SJHlcqd2wLDEZMLOgo8yzA4QUCD4WRXnkAgTPA=
X-Google-Smtp-Source: AGRyM1vE9teVMSzqKqoi2fq3/fvWxqiunTP5ildmoq5uF6ajQ5Qe+ALZNj5LeAj1WfIF+kJAWZriPvrzx0wmWMHqs/U=
X-Received: by 2002:a05:600c:501f:b0:39d:a3d:e919 with SMTP id
 n31-20020a05600c501f00b0039d0a3de919mr14502078wmr.132.1656659730450; Fri, 01
 Jul 2022 00:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220623182932.58589-1-schspa@gmail.com> <xhsmhv8sq5nyx.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhv8sq5nyx.mognet@vschneid.remote.csb>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 1 Jul 2022 15:15:18 +0800
Message-ID: <CAMA88Tp0x6Mrs9gaKeRJ5L7B1VVjgDB4oYBPx9+bpF=NFdX-9g@mail.gmail.com>
Subject: Re: [PATCH] sched: fix bad task migration for rt tasks
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <vschneid@redhat.com> writes:

> On 24/06/22 02:29, Schspa Shi wrote:
>> @@ -1998,12 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>>                       * the mean time, task could have
>>                       * migrated already or had its affinity changed.
>>                       * Also make sure that it wasn't scheduled on its rq.
>> +                     * It is possible the task has running for a while,
>> +                     * And we check task migration disable flag again.
>>                       */
>>                      if (unlikely(task_rq(task) != rq ||
>>                                   !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
>
> cf. 95158a89dd50 ("sched,rt: Use the full cpumask for balancing"), this
> made sense to me back then but not so much anymore... Shouldn't this have
> remained a ->cpus_ptr check?
>

This cpus_ptr check seems to be somehow same with is_migration_disabled(task).

> I'm going to revisit that commit, I evicted too much of it.
>

Any further progress on this?

We have tested this patch for a weak, It seems the problems have gone
(It will reproduce 2-3 times per week usually).

I have send a V2 patch too, it task the other case into consideration
(Going to retry to push the current running task on this CPU away,
instead doing nothing for this migrate disabled task.).

Link: https://lore.kernel.org/all/20220627154051.92599-1-schspa@gmail.com/


>>                                   task_running(rq, task) ||
>>                                   !rt_task(task) ||
>> -                                 !task_on_rq_queued(task))) {
>> +                                 !task_on_rq_queued(task) ||
>> +                                 is_migration_disabled(task))) {
>>
>>                              double_unlock_balance(rq, lowest_rq);
>>                              lowest_rq = NULL;
>> --
>> 2.24.3 (Apple Git-128)

-- 
Schspa Shi
BRs
