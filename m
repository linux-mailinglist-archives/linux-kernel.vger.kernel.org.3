Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F2C508C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380239AbiDTPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380153AbiDTPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:35:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B63EAB6;
        Wed, 20 Apr 2022 08:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D06C4B81EB2;
        Wed, 20 Apr 2022 15:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4C9C385AB;
        Wed, 20 Apr 2022 15:32:33 +0000 (UTC)
Date:   Wed, 20 Apr 2022 11:32:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU
 flavors
Message-ID: <20220420113231.6d3202e4@gandalf.local.home>
In-Reply-To: <20220418225033.3944860-1-paulmck@kernel.org>
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
        <20220418225033.3944860-1-paulmck@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022 15:50:32 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> This commit belatedly adds documentation of Tasks Rude RCU and Tasks
> Trace RCU to RCU's requirements document.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  .../RCU/Design/Requirements/Requirements.rst  | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 45278e2974c0..ff2be1ac54c4 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2654,6 +2654,38 @@ synchronize_rcu(), and rcu_barrier(), respectively. In
>  three APIs are therefore implemented by separate functions that check
>  for voluntary context switches.
>  
> +Tasks Rude RCU
> +~~~~~~~~~~~~~~
> +
> +Some forms of tracing need to wait for all preemption-disabled regions
> +of code running on any online CPU, including those executed when RCU is
> +not watching.  This means that synchronize_rcu() is insufficient, and
> +Tasks Rude RCU must be used instead.  This flavor of RCU does its work by
> +forcing a workqueue to be scheduled on each online CPU, hence the "Rude"
> +moniker.  And this operation is considered to be quite rude by real-time
> +workloads that don't want their ``nohz_full`` CPUs receiving IPIs and
> +by battery-powered systems that don't want their idle CPUs to be awakened.
> +
> +The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
> +consisting of call_rcu_tasks_rude(), synchronize_rcu_tasks_rude(),
> +and rcu_barrier_tasks_rude().

Are we going to be able to get rid of the "rude" version once we have all
tracing in a RCU visible section?

> +
> +Tasks Trace RCU
> +~~~~~~~~~~~~~~~
> +
> +Some forms of tracing need to sleep in readers, but cannot tolerate
> +SRCU's read-side overhead, which includes a full memory barrier in both
> +srcu_read_lock() and srcu_read_unlock().  This need is handled by a
> +Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
> +readers.  Real-time systems that cannot tolerate IPIs may build their
> +kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=y``, which avoids the IPIs at
> +the expense of adding full memory barriers to the read-side primitives.

If NOHZ_FULL is enabled, is there a way to also be able to have this full
mb on RT removed as well?

> +
> +The tasks-trace-RCU API is also reasonably compact,
> +consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
> +rcu_read_lock_trace_held(), call_rcu_tasks_trace(),
> +synchronize_rcu_tasks_trace(), and rcu_barrier_tasks_trace().
> +
>  Possible Future Changes
>  -----------------------
>  

For the documentation:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
