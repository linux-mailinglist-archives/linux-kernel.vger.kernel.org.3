Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE2255A9F4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiFYMXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiFYMXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:23:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD31116D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:23:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n185so2661325wmn.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6h1lNryS/PdYHAGF2+cQQNJ1h/8DZV/mIxN1ynumxA=;
        b=pxequgWiSrF9utkbcYStNV/psctItI/TT2ldOQLHCimWwQ2vjFLyU7CWAWBWPoZ/X8
         AixoHhTwZz3K2xJwXtmhgzIfx54BYtOGzz0T9KkGR7UGPE7yhSTnuvtTDKsFUQYUS3oG
         2wBH2XfqLBeCRsc54EX0HS7pBfwFJv6VROO8xguckeAOA5r+ZSbmlPb6RA6TsgHplY+K
         rWZuFSpPe2uUUe7v+mV2MDOHkeMMVQ+/HQvNnurE+uqdQ7bq1J+wezGE4utoRxVMh8SV
         aJfW30abWARmVdqTmN6/7pFwZAWikO/X9HtSeTr04F7Yk7Jw1nM1vMQHGKKsblnZKiZf
         t4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6h1lNryS/PdYHAGF2+cQQNJ1h/8DZV/mIxN1ynumxA=;
        b=7qCoQxHibtCwZ8/mMpHOnOD0XjjIjq0baB4FCOmRQzpRVG8LkeXzgwDzhzSbIR6aIg
         Dpc9HQZOSGJYnSab9UDFfIo3TEB40NrZaAcj2k/mCMrsCjZS9SRPvw0vZYJuumY0opoV
         F3Yp7WW5jmAxC4VensbhGxAXvsHUr4IrEdRz/3OVYevz8/KyWqb79aRkFhohH5BSDTqM
         ya5XNiBqhCvJFzcURNeTg1CDAqNAKLS4EOp6ueGj5GH2P7sQ5aBSdK5UJvvdO883jEle
         9dQjJKGjr+Kwp16fqQjZ/oNEsYfZjaP4vxoUOvdLCSvseZOo7G2grEtkrqUi4IG+6iBh
         osoQ==
X-Gm-Message-State: AJIora9GvUDaiv1M/gDL/wPMsN1vNGuGUaY6a2nXuGucM2P0uSPmw3Ow
        r8M8g+yHDplECSpSz+8IRZQ1IXrtXp14wEnSSFw=
X-Google-Smtp-Source: AGRyM1tBBfAFrm6m8IU/5Hvop5IdUpK37mp1BonaXfw2JXtLzqcNALdWAZzSeM514PSRI9BTFCzSdMnuwG7HZlPs+T4=
X-Received: by 2002:a7b:c188:0:b0:3a0:391d:45f4 with SMTP id
 y8-20020a7bc188000000b003a0391d45f4mr8836258wmi.11.1656159794971; Sat, 25 Jun
 2022 05:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220623182932.58589-1-schspa@gmail.com> <xhsmhv8sq5nyx.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhv8sq5nyx.mognet@vschneid.remote.csb>
From:   Schspa Shi <schspa@gmail.com>
Date:   Sat, 25 Jun 2022 20:23:03 +0800
Message-ID: <CAMA88TpRbXAEWdJVgG8Bpd3Mn4PEigDJV+hOR19FR+Rh1YevaA@mail.gmail.com>
Subject: Re: [PATCH] sched: fix bad task migration for rt tasks
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

It seems it is for the following scenarios:
It allows the higher priority non migratable task to be sched quickly
by migrating the current task to
another CPU with lower priority.

Considering this, we should retry for this. rather than return with no
lower priority rq.

I can upload a new patchset for this handing.

Please refers to the fellowing code:
        if (is_migration_disabled(next_task)) {
                struct task_struct *push_task = NULL;
                int cpu;

                if (!pull || rq->push_busy)
                        return 0;

                /*
                 * Invoking find_lowest_rq() on anything but an RT task doesn't
                 * make sense. Per the above priority check, curr has to
                 * be of higher priority than next_task, so no need to
                 * reschedule when bailing out.
                 *
                 * Note that the stoppers are masqueraded as SCHED_FIFO
                 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
                 */
                if (rq->curr->sched_class != &rt_sched_class)
                        return 0;

                cpu = find_lowest_rq(rq->curr);
                if (cpu == -1 || cpu == rq->cpu)
                        return 0;

                /*
                 * Given we found a CPU with lower priority than @next_task,
                 * therefore it should be running. However we cannot migrate it
                 * to this other CPU, instead attempt to push the current
                 * running task on this CPU away.
                 */
                push_task = get_push_task(rq);
                if (push_task) {
                        raw_spin_rq_unlock(rq);
                        stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
                                            push_task, &rq->push_work);
                        raw_spin_rq_lock(rq);
                }

                return 0;

        }

> I'm going to revisit that commit, I evicted too much of it.
>
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

BRs
Schspa Shi
