Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203E74CD8C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiCDQOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiCDQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:14:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76B406E4C8;
        Fri,  4 Mar 2022 08:13:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42659143D;
        Fri,  4 Mar 2022 08:13:13 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40CDC3F73D;
        Fri,  4 Mar 2022 08:13:12 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     tip-bot2 for Valentin Schneider <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
Cc:     Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        "Steven Rostedt \(Google\)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: sched/core] sched/tracing: Don't re-read p->state when emitting sched_switch event
In-Reply-To: <164614827941.16921.4995078681021904041.tip-bot2@tip-bot2>
References: <20220120162520.570782-2-valentin.schneider@arm.com> <164614827941.16921.4995078681021904041.tip-bot2@tip-bot2>
Date:   Fri, 04 Mar 2022 16:13:04 +0000
Message-ID: <87fsnx4rxr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/22 15:24, tip-bot2 for Valentin Schneider wrote:
> The following commit has been merged into the sched/core branch of tip:
>
> Commit-ID:     fa2c3254d7cfff5f7a916ab928a562d1165f17bb
> Gitweb:        https://git.kernel.org/tip/fa2c3254d7cfff5f7a916ab928a562d1165f17bb
> Author:        Valentin Schneider <valentin.schneider@arm.com>
> AuthorDate:    Thu, 20 Jan 2022 16:25:19
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 01 Mar 2022 16:18:39 +01:00
>
> sched/tracing: Don't re-read p->state when emitting sched_switch event
>
> As of commit
>
>   c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
>
> the following sequence becomes possible:
>
>                     p->__state = TASK_INTERRUPTIBLE;
>                     __schedule()
>                       deactivate_task(p);
>   ttwu()
>     READ !p->on_rq
>     p->__state=TASK_WAKING
>                       trace_sched_switch()
>                         __trace_sched_switch_state()
>                           task_state_index()
>                             return 0;
>
> TASK_WAKING isn't in TASK_REPORT, so the task appears as TASK_RUNNING in
> the trace event.
>
> Prevent this by pushing the value read from __schedule() down the trace
> event.
>
> Reported-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Link: https://lore.kernel.org/r/20220120162520.570782-2-valentin.schneider@arm.com

So I wasn't sure if that would be considered a "bug", but folks are asking
for this to be backported; do we want to slap

Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")

to it?
