Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AEF495ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbiAUMGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbiAUMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:06:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6D9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:06:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A7F61A9D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 12:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3442BC340E1;
        Fri, 21 Jan 2022 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642766773;
        bh=OiNcQsiL4RkD84Zk69xbi1yGoWq5fR6O7P/s3BBkk2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDv00yPNi15fkbO0geVOZLZd+qg7ri8sfXXxjOA83Y+pHZ0bJ1ZxE4REhzaZtfms0
         LJO2XO4h0CMBhNsQOvAhxseLO3by8F8HV8WlFtJEwQTRGuw+IFgqiiFQXMfDoEknkU
         JuiqbaWfDuhiTJ4z+Z0+XMXwxM0/GPzAnTVdAST78PhuwiU5yMUkSeby83xEzpQJH6
         7yR68rTueitFaSNZj8b/4GfvgVK3VsoLSMJzj6k0YB/MUCItryjsyEsBycgLcxfpeB
         fdfspah6Ws3M1f3SZIzIvmoub+36BVW8z+WhjiFrDPFfXAGym9lFSHxwmRaCQSXw75
         H4NbXvHfOV0Ow==
Date:   Fri, 21 Jan 2022 13:06:10 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 03/10] task isolation: sync vmstats on return to
 userspace
Message-ID: <20220121120610.GA231488@lothringen>
References: <20211208161000.714824954@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208161000.714824954@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 01:09:09PM -0300, Marcelo Tosatti wrote:
> Index: linux-2.6/include/linux/task_isolation.h
> ===================================================================
> --- linux-2.6.orig/include/linux/task_isolation.h
> +++ linux-2.6/include/linux/task_isolation.h
> @@ -40,8 +40,19 @@ int prctl_task_isolation_activate_set(un
>  
>  int __copy_task_isolation(struct task_struct *tsk);
>  
> +void isolation_exit_to_user_mode(void);
> +
> +static inline int task_isol_has_work(void)
> +{
> +	return 0;
> +}
> +
>  #else
>  
> +static void isolation_exit_to_user_mode(void)
> +{
> +}
> +
>  static inline void tsk_isol_free(struct task_struct *tsk)
>  {
>  }
> @@ -86,6 +97,11 @@ static inline int prctl_task_isolation_a
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int task_isol_has_work(void)
> +{
> +	return 0;
> +}
> +

It would be nice to have a coherent greppable task_isol_*() namespace instead
of random scattered tsk_*(), isolation_*() stuff...

task_isol_exit_to_user_mode()
task_isol_free()
task_isol_copy_process()
task_isol_had_work()
...

> @@ -149,13 +150,14 @@ static void handle_signal_work(struct pt
>  }
>  
>  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> -					    unsigned long ti_work)
> +					    unsigned long ti_work,
> +					    unsigned long tsk_isol_work)
>  {
>  	/*
>  	 * Before returning to user space ensure that all pending work
>  	 * items have been completed.
>  	 */
> -	while (ti_work & EXIT_TO_USER_MODE_WORK) {
> +	while ((ti_work & EXIT_TO_USER_MODE_WORK) || tsk_isol_work) {

So there is a dependency on CONFIG_GENERIC_ENTRY. Then you need to split that
from CONFIG_CPU_ISOLATION:

config TASK_ISOLATION
       bool "Task isolation prctl()"
       depends on GENERIC_ENTRY
       help "...."

>  
>  		local_irq_enable_exit_to_user(ti_work);
>  
> @@ -177,6 +179,9 @@ static unsigned long exit_to_user_mode_l
>  		/* Architecture specific TIF work */
>  		arch_exit_to_user_mode_work(regs, ti_work);
>  
> +		if (tsk_isol_work)
> +			isolation_exit_to_user_mode();
> +
>  		/*
>  		 * Disable interrupts and reevaluate the work flags as they
>  		 * might have changed while interrupts and preemption was
> @@ -188,6 +193,7 @@ static unsigned long exit_to_user_mode_l
>  		tick_nohz_user_enter_prepare();
>  
>  		ti_work = READ_ONCE(current_thread_info()->flags);
> +		tsk_isol_work = task_isol_has_work();

Shouldn't it be a TIF_FLAG part of EXIT_TO_USER_MODE_WORK instead?

Thanks.
