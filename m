Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5723596FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiHQNVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbiHQNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:20:47 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03989646F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:20:46 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-332fc508d88so160781637b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1v5neMWckuuShK6mxvtzPriWYlr3sXVhkVDSWSsmeJw=;
        b=LDBMjmyDy8+FDV3nm9ieFIcEOzftkGrbLw3qls7qDOg57uj5JOl8BBzSFCjY8jOKOS
         2PE+eweJ3KSdpM4J1jB90d65QSuMaBKUMizxx8nk4jvDILIROvgNKriJVB3YeaFlMbqG
         F3C4vnGDHVPdALDJBwXoKoGuotIJqPNzFEhcJFY2JS5GWbMPLpDDvjB66Lcij2GU5sc1
         SV3COkXpVGgaae1stBGSPY0Com8ch3WfcBdkqfJU0bnN+xsEqXzRZ/IwQ4SJMoi2KtEp
         ODa0Z4O6ARQhdVNbtQ3a6JgZD+hRIpaAwAvAlKwph8YGc3t3zKqkmE8l9IpaTzWyTWyT
         xROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1v5neMWckuuShK6mxvtzPriWYlr3sXVhkVDSWSsmeJw=;
        b=p5mrGZx2WVow8tlbQcXHX/wCvLSs3fPXI0Kyu+IEPYx+RE4iOiJwFHBSuz3rLkePv3
         x1M2lN1jhieRT9iCVE2N6FXSWr/DTZLJuz8zyE4YIxmFx/7NY0QZgs6q8yaqvelPdur0
         pZRVfwI+5g6EyDcXGWGvZPSmWZKrRqeziYe+QUjrPyLUSq/GL0mClWYQp4a99QOOkGGJ
         eSo3njkYodlog5WvlYNSpdyzJzizWiUydbDJrlpkDWnmTqR9ttT1j/ag06FxT+wKGyTl
         DBxwVxH9275y6jHD+Fmqix0/8O4UujypEFjFvtTXLunGuKJzuI0irv40j8Uu6VpvouTV
         UKVQ==
X-Gm-Message-State: ACgBeo1Umbc/LhGRtT5pxqkjAIIQf75ob3GEJBLMSyTRfmlBiLnLjSOD
        pIWagiG9z7QcYNLkY7nSoDQiZjH6anTSGlhfF+6QPQ==
X-Google-Smtp-Source: AA6agR41027N8+w0s3t18+phUECcORfggPJy1vgEmFCd4QZxvaD9usy4ZgRDHS6MOKVmOMHBmjGVzRmwLyC59ZbNSBA=
X-Received: by 2002:a25:2fca:0:b0:68f:aa4f:4a41 with SMTP id
 v193-20020a252fca000000b0068faa4f4a41mr4182720ybv.403.1660742445179; Wed, 17
 Aug 2022 06:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220810223313.386614-1-libo.chen@oracle.com> <YvonlUOgMbla6dSh@worktop.programming.kicks-ass.net>
 <aac4a43d-4999-1da5-a617-b512ae0b3982@oracle.com>
In-Reply-To: <aac4a43d-4999-1da5-a617-b512ae0b3982@oracle.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 17 Aug 2022 15:20:33 +0200
Message-ID: <CAKfTPtA3UTrsc3qZf_GB-QA7O7DJvoFqEk-VuWeFVRp8G_iUkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
To:     Libo Chen <libo.chen@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 at 21:19, Libo Chen <libo.chen@oracle.com> wrote:
>
>
>
> On 8/15/22 04:01, Peter Zijlstra wrote:
> > On Wed, Aug 10, 2022 at 03:33:13PM -0700, Libo Chen wrote:
> >> There are scenarios where non-affine wakeups are incorrectly counted as
> >> affine wakeups by schedstats.
> >>
> >> When wake_affine_idle() returns prev_cpu which doesn't equal to
> >> nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
> >> in wake_affine() and be counted as if target == this_cpu in schedstats.
> >>
> >> Replace target == nr_cpumask_bits with target != this_cpu to make sure
> >> affine wakeups are accurately tallied.
> >>
> >> Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
> >> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> >> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> >> ---
> >>   kernel/sched/fair.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index da388657d5ac..b179da4f8105 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> >>              target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
> >>
> >>      schedstat_inc(p->stats.nr_wakeups_affine_attempts);
> >> -    if (target == nr_cpumask_bits)
> >> +    if (target != this_cpu)
> >>              return prev_cpu;
> >>
> >>      schedstat_inc(sd->ttwu_move_affine);
> > This not only changes the accounting but also the placement, no?
> No, it should only change the accounting. wake_affine() still returns
> prev_cpu if target equals to prev_cpu or nr_cpumask_bits, the same
> behavior as before.

Looks good to me

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
>
> Libo
