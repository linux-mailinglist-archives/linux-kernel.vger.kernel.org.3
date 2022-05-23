Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6D531001
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiEWKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiEWKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:48:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 831044BFC5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:48:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D0AA11FB;
        Mon, 23 May 2022 03:48:48 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.9.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C88A3F73D;
        Mon, 23 May 2022 03:48:47 -0700 (PDT)
Date:   Mon, 23 May 2022 11:48:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, nslusarek@gmx.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] perf: Fix sys_perf_event_open() race against self
Message-ID: <Yotmi2kM3mm+iPPU@FVFF77S0Q05N>
References: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520183806.GV2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, May 20, 2022 at 08:38:06PM +0200, Peter Zijlstra wrote:
> 
> Norbert reported that it's possible to race sys_perf_event_open() such
> that the looser ends up in another context from the group leader,
> triggering many WARNs.

I'm hitting the same with my local arm64 Syzkaller instance, atop v5.18-rc6.

> The move_group case checks for races against itself, but the
> !move_group case doesn't, seemingly relying on the previous
> group_leader->ctx == ctx check. However, that check is racy due to not
> holding any locks at that time.
> 
> Therefore, re-check the result after acquiring locks and bailing
> if they no longer match.
> 
> Additionally, clarify the not_move_group case from the
> move_group-vs-move_group race.
> 
> Fixes: f63a8daa5812 ("perf: Fix event->ctx locking")
> Reported-by: Norbert Slusarek <nslusarek@gmx.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12217,6 +12217,9 @@ SYSCALL_DEFINE5(perf_event_open,
>  		 * Do not allow to attach to a group in a different task
>  		 * or CPU context. If we're moving SW events, we'll fix
>  		 * this up later, so allow that.
> +		 *
> +		 * Racy, not holding group_leader->ctx->mutex, see comment with
> +		 * perf_event_ctx_lock().
>  		 */
>  		if (!move_group && group_leader->ctx != ctx)
>  			goto err_context;

I assume that given we say we're not holding the mutex that this is truly racy,
and a concurrent write can happen at any time. If that's the case, shouldn't we
be using *_ONCE() to manipulate perf_event::ctx?

... or could we remove the racy read entirely, and just rely on the later
check with ctx->mutex held? We can always reach that by chance anyway, so
there's not a functional need to bail out early, and consistently using the
later test removes some potential for introducing similar races in future.

FWIW, with this patch as-is applied atop v5.18-rc6, I no longer see the issue
in testing with the reproducer Syzkaller came up with. That would normally take
a few seconds, but it now survives several minutes.

For posterity, that reproducer was:

----8<----
r0 = perf_event_open$cgroup(&(0x7f0000000100)={0x1, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_config_ext}, 0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x0)
r1 = dup(r0)
perf_event_open(&(0x7f00000001c0)={0x0, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp={0x0}}, 0xffffffffffffffff, 0x0, r1, 0x0) (async)
perf_event_open$cgroup(&(0x7f0000000100)={0x1, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x10, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp={0x0, 0x5}, 0x0, 0x0, 0x0, 0x0, 0xfffffffffffffffe, 0x0, 0x0, 0x0, 0x0, 0x0, 0x200000000000000}, 0xffffffffffffffff, 0x0, r1, 0x0)
---->8----

Thanks,
Mark.

> @@ -12282,6 +12285,7 @@ SYSCALL_DEFINE5(perf_event_open,
>  			} else {
>  				perf_event_ctx_unlock(group_leader, gctx);
>  				move_group = 0;
> +				goto not_move_group;
>  			}
>  		}
>  
> @@ -12298,7 +12302,17 @@ SYSCALL_DEFINE5(perf_event_open,
>  		}
>  	} else {
>  		mutex_lock(&ctx->mutex);
> +
> +		/*
> +		 * Now that we hold ctx->lock, (re)validate group_leader->ctx == ctx,
> +		 * see the group_leader && !move_group test earlier.
> +		 */
> +		if (group_leader && group_leader->ctx != ctx) {
> +			err = -EINVAL;
> +			goto err_locked;
> +		}
>  	}
> +not_move_group:
>  
>  	if (ctx->task == TASK_TOMBSTONE) {
>  		err = -ESRCH;
> 
