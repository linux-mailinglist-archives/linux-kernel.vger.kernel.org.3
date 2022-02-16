Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD40F4B90CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbiBPS6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:58:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiBPS6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:58:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC39E2AD677;
        Wed, 16 Feb 2022 10:58:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 810E361715;
        Wed, 16 Feb 2022 18:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F18C340ED;
        Wed, 16 Feb 2022 18:58:22 +0000 (UTC)
Date:   Wed, 16 Feb 2022 13:58:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: ftrace startup tests crashing due to missing rcu_synchronize()
Message-ID: <20220216135821.67a22c52@gandalf.local.home>
In-Reply-To: <20220216135419.01d96fe1@gandalf.local.home>
References: <yt9dilte4px4.fsf@linux.ibm.com>
        <20220216135419.01d96fe1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 13:54:19 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> That is, shutdown is called, the item is removed from the list and freed,
> but something got preempted while on the ftrace trampoline, with a
> reference to the item, and then woke up and executed the item that was
> freed.
> 
> I'll look into it. Thanks for the report.

OK, I wonder if something changed with "is_kernel_core_date()"?

Because on registering, we have:

	if (!is_kernel_core_data((unsigned long)ops))
		ops->flags |= FTRACE_OPS_FL_DYNAMIC;


and in the shutdown, we have:

	/*
	 * Dynamic ops may be freed, we must make sure that all
	 * callers are done before leaving this function.
	 * The same goes for freeing the per_cpu data of the per_cpu
	 * ops.
	 */
	if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
		/*
		 * We need to do a hard force of sched synchronization.
		 * This is because we use preempt_disable() to do RCU, but
		 * the function tracers can be called where RCU is not watching
		 * (like before user_exit()). We can not rely on the RCU
		 * infrastructure to do the synchronization, thus we must do it
		 * ourselves.
		 */
		synchronize_rcu_tasks_rude();

		/*
		 * When the kernel is preemptive, tasks can be preempted
		 * while on a ftrace trampoline. Just scheduling a task on
		 * a CPU is not good enough to flush them. Calling
		 * synchronize_rcu_tasks() will wait for those tasks to
		 * execute and either schedule voluntarily or enter user space.
		 */
		if (IS_ENABLED(CONFIG_PREEMPTION))
			synchronize_rcu_tasks();

 free_ops:
		ftrace_trampoline_free(ops);
	}


If the ops is not flagged as being allocated, or if one of the rcu
synchronizations has changed and allowed for us to continue, then this
would cause what you see.

-- Steve
