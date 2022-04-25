Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3550E3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbiDYO7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242618AbiDYO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C2B27;
        Mon, 25 Apr 2022 07:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E4D61696;
        Mon, 25 Apr 2022 14:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A39C385A7;
        Mon, 25 Apr 2022 14:56:01 +0000 (UTC)
Date:   Mon, 25 Apr 2022 10:56:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: ftrace: avoid tracing a few functions executed
 in stop machine
Message-ID: <20220425105600.722b1345@gandalf.local.home>
In-Reply-To: <20220423102844.1371595-1-patrick.wang.shcn@gmail.com>
References: <20220423102844.1371595-1-patrick.wang.shcn@gmail.com>
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

On Sat, 23 Apr 2022 18:28:44 +0800
Patrick Wang <patrick.wang.shcn@gmail.com> wrote:

> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> ---
> v1->v2:
>  - Modify log message.
> 
>  kernel/rcu/tree_plugin.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c8ba0fe17267..971bb6a00ede 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -460,7 +460,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
>   * be quite short, for example, in the case of the call from
>   * rcu_read_unlock_special().
>   */
> -static void
> +notrace static void

I'm fine with the change, but to be consistent with the rest of the kernel,
static needs to come before notrace.

Either:

 static notrace void

or even (some places have):

  static void notrace

but "static" should always be first.

-- Steve


>  rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  {
>  	bool empty_exp;
> @@ -581,7 +581,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>   * is disabled.  This function cannot be expected to understand these
>   * nuances, so the caller must handle them.
>   */
> -static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> +notrace static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  {
>  	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
>  		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> @@ -595,7 +595,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>   * evaluate safety in terms of interrupt, softirq, and preemption
>   * disabling.
>   */
> -static void rcu_preempt_deferred_qs(struct task_struct *t)
> +notrace static void rcu_preempt_deferred_qs(struct task_struct *t)
>  {
>  	unsigned long flags;
>  

