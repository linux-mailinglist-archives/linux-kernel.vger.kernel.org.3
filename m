Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85B46734E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379233AbhLCIhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379190AbhLCIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:37:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C51C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:34:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b1so4675939lfs.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSsWAic1UX7djA//WKZasRn0ryPGcG2K/mnPAhkcyxs=;
        b=E9X7LgipKk+y21qeodzzCY3Dwa9XyGbPg3+NfvYvSeALpHnamTpMUYaSNt5n6bsLL8
         utgG8F7BcjrnzNFFNjVNAf569RFLT7KixV2lc54QJJS6A64FLMo7cDX5wir3wKhrKJWI
         xKvCITS7VZFyfvMnvjYEcmeukzNe3L+34616EabJND/jcCi+R9TCDmi399j7gY1+oPab
         QpthdKJHeSmb+uPHMj2BLX5z+7WYLj1S8abrM9d+t9co+weg9BXMyoKpHPrZ3+u9sqR2
         eCe4HUVwAj+OkYOJ2BY4ljT2EqKEutW/EVeX801Bys7H0k3QLg9gSeFabwaaWIQJ0x1r
         sAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSsWAic1UX7djA//WKZasRn0ryPGcG2K/mnPAhkcyxs=;
        b=h2ptodhc15V0oaQAO0YrCOjWw2mrmMLu3H/d2CCiiCZQfQHn6M9rPr/L1hl0jQJ+Ay
         I2N6qZvwFyW+PRZbjJJ6uT2ioahpX1i+tAkuUS4zPL5+dDVsimK/jmuHa+b1hUbFwgOQ
         w+/xjl8FGgCFdhotSz3pfEkrsp2hkEUt5fdsKicg4caVvBOV7ZhY0JmcMpLpDXLEonQw
         lBvTJ7mobnRPRxdK15y/dndlJqsaSGWm2YUELmywzOeLi9qGlB/bli+zu2BZ2f05ATBo
         7355Wi6XFWCZ9+JyP+oHaXRLNDEgxNyXA127HYxmciNU+mz4EbVgDlUkW/U4i7rJFANF
         I24w==
X-Gm-Message-State: AOAM531oQ/LPXWAYjLx4/ytRhv6x4Pbsaf84AOjGB4fKdzwNTus9X26P
        eTNl+U3IXVHeKeY5bKy6qN+AfPZmsanzenTmws4IKw==
X-Google-Smtp-Source: ABdhPJwAkc6QvO86U3JYrHagstwfPXW0hlVn0b//aL2NTQ2xcnzuovyUlh6cLCHblssxAIPehPZ8LnAUe0uImRFyVaA=
X-Received: by 2002:a05:6512:230e:: with SMTP id o14mr17363516lfu.490.1638520459858;
 Fri, 03 Dec 2021 00:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20211201143450.479472-1-vincent.donnefort@arm.com>
In-Reply-To: <20211201143450.479472-1-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 3 Dec 2021 09:34:08 +0100
Message-ID: <CAKfTPtBM0U05E=-Q5mVnLb6gJCxXt_fHD-UsBANqR1C=bq_mPQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix detection of per-CPU kthreads waking a task
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com, Valentin.Schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 at 15:35, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> select_idle_sibling() has a special case for tasks woken up by a per-CPU
> kthread, where the selected CPU is the previous one. However, the current
> condition for this exit path is incomplete. A task can wake up from an
> interrupt context (e.g. hrtimer), while a per-CPU kthread is running. A
> such scenario would spuriously trigger the special case described above.
> Also, a recent change made the idle task like a regular per-CPU kthread,
> hence making that situation more likely to happen
> (is_per_cpu_kthread(swapper) being true now).
>
> Checking for task context makes sure select_idle_sibling() will not
> interpret a wake up from any other context as a wake up by a per-CPU
> kthread.
>
> Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> ---
> v1 -> v2:
>   * is_idle_thread() -> in_task() to also include spurious detection when
>     current != swapper. (Vincent Guittot)
> ---
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 945d987246c5..56db4ae85995 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          * pattern is IO completions.
>          */
>         if (is_per_cpu_kthread(current) &&
> +           in_task() &&
>             prev == smp_processor_id() &&
>             this_rq()->nr_running <= 1) {
>                 return prev;
> --
> 2.25.1
>
