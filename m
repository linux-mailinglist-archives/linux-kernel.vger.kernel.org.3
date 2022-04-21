Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD650A2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389529AbiDUOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389095AbiDUOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:42:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7423DA5F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:40:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650552007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAO55pYABee/TxUYtxpv4J57hWPpV3OsKogaKGHUQvk=;
        b=Ia7H/FRQaz3jsRLyf7HhoMbf60W57A9vxjB3+R883fiv6ayKf1x8R8IUrvrHshU8+Qc8A+
        EBKGLgoxSauIV5rUuEetjS5gozS2++9WzsGMrm7Ztob8OxAtXNL8oD/AeFslT232RIAP/s
        G0w+IFDnVw0SAJ8JY2LuCh42Nlzf9GznOwU9PeesLIxI/GSKcbO+IIxw9akDppS7xcAe0i
        EhwIcpoktsOh7aXsxI52sizO14YaAYKUT0yo7i0QfE/RkuVeVB97kpFv0FG/K7Yh1TV7QF
        Q1nkiR8YOsDJNkDbYnlMCyBP7+8tE6iCyEnHRMZskyczueFc/gOYwJu6GFmNPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650552007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAO55pYABee/TxUYtxpv4J57hWPpV3OsKogaKGHUQvk=;
        b=wHfBjKfKS+/a0EV3Q/YQ+0z9Jt/DhcCvjjsJ5ikuLKtHRCZxCYN8NMfsQGEG0zagqkehxD
        9haw2grX+YVepbCQ==
To:     Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v9] oom_kill.c: futex: Delay the OOM reaper to allow
 time for proper futex cleanup
In-Reply-To: <20220414144042.677008-1-npache@redhat.com>
References: <20220414144042.677008-1-npache@redhat.com>
Date:   Thu, 21 Apr 2022 16:40:06 +0200
Message-ID: <874k2mts8p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14 2022 at 10:40, Nico Pache wrote:
> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
> be targeted by the oom reaper. This mapping is used to store the futex
> robust list head; the kernel does not keep a copy of the robust list and
> instead references a userspace address to maintain the robustness during
> a process death. A race can occur between exit_mm and the oom reaper that
> allows the oom reaper to free the memory of the futex robust list before
> the exit path has handled the futex death:
>
>     CPU1                               CPU2
> ------------------------------------------------------------------------
>     page_fault
>     do_exit "signal"
>     wake_oom_reaper
>                                         oom_reaper
>                                         oom_reap_task_mm (invalidates mm)
>     exit_mm
>     exit_mm_release
>     futex_exit_release
>     futex_cleanup
>     exit_robust_list
>     get_user (EFAULT- can't access memory)
>
> If the get_user EFAULT's, the kernel will be unable to recover the
> waiters on the robust_list, leaving userspace mutexes hung indefinitely.
>
> Delay the OOM reaper, allowing more time for the exit path to perform
> the futex cleanup.
>
> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
>
> [1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370

A link to the original discussion about this would be more useful than a
code reference which is stale tomorrow. The above explanation is good
enough to describe the problem.

>  
> +/*
> + * Give the OOM victim time to exit naturally before invoking the oom_reaping.
> + * The timers timeout is arbitrary... the longer it is, the longer the worst
> + * case scenario for the OOM can take. If it is too small, the oom_reaper can
> + * get in the way and release resources needed by the process exit path.
> + * e.g. The futex robust list can sit in Anon|Private memory that gets reaped
> + * before the exit path is able to wake the futex waiters.
> + */
> +#define OOM_REAPER_DELAY (2*HZ)
> +static void queue_oom_reaper(struct task_struct *tsk)

Bah. Did you run out of newlines? Glueing that define between the
comment and the function is unreadable.

Other than that.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
