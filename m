Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAF5549951
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbiFMQyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243147AbiFMQxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:53:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607491F5899
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wypwNo31pEoKbTgQWNWX70zzoyNQ9oMUPSN5tbzhBBg=; b=QOaOTcl7RlOJ50kzhpL16tQ+O/
        AUGcSiZNJDKL/1WyLtbcDrKtQMC2cyooJMJuZxTrE1Xl/cdIKus7LrijAyhz6AUPw04LvqqM9NWkt
        oYO7Qz6zBrX7qU+V7BVnfke89MVmym3N+9IKpWN1nKkRAyjINSISNTciDPkgnF5mU+PCm1KwTUu3D
        f+rj2u+rdOcElXQclEB67mG8hF/YLMZYrCAH76Ca1Ct9lcpatDkLDwuYMz4brQooSGZXNTsuECMjj
        oXT92E73xUbgX4TeOGQsYzmRqntv6I4nbTq4iIQvIdboy8wIyz4D4vy38mHuVE9Ghouu0s17rP9TR
        AL6C7Rxg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0lDE-00Gv6S-NB; Mon, 13 Jun 2022 14:38:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 558FB30023F;
        Mon, 13 Jun 2022 16:38:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E12E2029F884; Mon, 13 Jun 2022 16:38:40 +0200 (CEST)
Date:   Mon, 13 Jun 2022 16:38:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:

Another one of those lockdep splats:

> @@ -12147,42 +12256,37 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (pmu->task_ctx_nr == perf_sw_context)
>  		event->event_caps |= PERF_EV_CAP_SOFTWARE;
>  
> -	if (group_leader) {
> -		if (is_software_event(event) &&
> -		    !in_software_context(group_leader)) {
> -			/*
> -			 * If the event is a sw event, but the group_leader
> -			 * is on hw context.
> -			 *
> -			 * Allow the addition of software events to hw
> -			 * groups, this is safe because software events
> -			 * never fail to schedule.
> -			 */
> -			pmu = group_leader->ctx->pmu;
> -		} else if (!is_software_event(event) &&
> -			   is_software_event(group_leader) &&
> -			   (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
> -			/*
> -			 * In case the group is a pure software group, and we
> -			 * try to add a hardware event, move the whole group to
> -			 * the hardware context.
> -			 */
> -			move_group = 1;
> -		}
> -	}
> -
>  	/*
>  	 * Get the target context (task or percpu):
>  	 */
> -	ctx = find_get_context(pmu, task, event);
> +	ctx = find_get_context(task, event);
>  	if (IS_ERR(ctx)) {
>  		err = PTR_ERR(ctx);
>  		goto err_alloc;
>  	}
>  
> -	/*
> -	 * Look up the group leader (we will attach this event to it):
> -	 */
> +	mutex_lock(&ctx->mutex);
> +
> +	if (ctx->task == TASK_TOMBSTONE) {
> +		err = -ESRCH;
> +		goto err_locked;
> +	}
> +
> +	if (!task) {
> +		/*
> +		 * Check if the @cpu we're creating an event for is online.
> +		 *
> +		 * We use the perf_cpu_context::ctx::mutex to serialize against
> +		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
> +		 */
> +		struct perf_cpu_context *cpuctx = per_cpu_ptr(&cpu_context, event->cpu);
> +
> +		if (!cpuctx->online) {
> +			err = -ENODEV;
> +			goto err_locked;
> +		}
> +	}
> +
>  	if (group_leader) {
>  		err = -EINVAL;
>  


pulling up the ctx->mutex makes things simpler, but also violates the
locking order vs exec_update_lock.

Pull that lock up as well...

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12254,13 +12254,29 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (pmu->task_ctx_nr == perf_sw_context)
 		event->event_caps |= PERF_EV_CAP_SOFTWARE;
 
+	if (task) {
+		err = down_read_interruptible(&task->signal->exec_update_lock);
+		if (err)
+			goto err_alloc;
+
+		/*
+		 * We must hold exec_update_lock across this and any potential
+		 * perf_install_in_context() call for this new event to
+		 * serialize against exec() altering our credentials (and the
+		 * perf_event_exit_task() that could imply).
+		 */
+		err = -EACCES;
+		if (!perf_check_permission(&attr, task))
+			goto err_cred;
+	}
+
 	/*
 	 * Get the target context (task or percpu):
 	 */
 	ctx = find_get_context(task, event);
 	if (IS_ERR(ctx)) {
 		err = PTR_ERR(ctx);
-		goto err_alloc;
+		goto err_cred;
 	}
 
 	mutex_lock(&ctx->mutex);
@@ -12358,58 +12374,14 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_context;
 	}
 
-	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event, f_flags);
-	if (IS_ERR(event_file)) {
-		err = PTR_ERR(event_file);
-		event_file = NULL;
-		goto err_context;
-	}
-
-	if (task) {
-		err = down_read_interruptible(&task->signal->exec_update_lock);
-		if (err)
-			goto err_file;
-
-		/*
-		 * We must hold exec_update_lock across this and any potential
-		 * perf_install_in_context() call for this new event to
-		 * serialize against exec() altering our credentials (and the
-		 * perf_event_exit_task() that could imply).
-		 */
-		err = -EACCES;
-		if (!perf_check_permission(&attr, task))
-			goto err_cred;
-	}
-
-	if (ctx->task == TASK_TOMBSTONE) {
-		err = -ESRCH;
-		goto err_locked;
-	}
-
 	if (!perf_event_validate_size(event)) {
 		err = -E2BIG;
-		goto err_locked;
-	}
-
-	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx =
-			container_of(ctx, struct perf_cpu_context, ctx);
-
-		if (!cpuctx->online) {
-			err = -ENODEV;
-			goto err_locked;
-		}
+		goto err_context;
 	}
 
 	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader)) {
 		err = -EINVAL;
-		goto err_locked;
+		goto err_context;
 	}
 
 	/*
@@ -12418,11 +12390,18 @@ SYSCALL_DEFINE5(perf_event_open,
 	 */
 	if (!exclusive_event_installable(event, ctx)) {
 		err = -EBUSY;
-		goto err_cred;
+		goto err_context;
 	}
 
 	WARN_ON_ONCE(ctx->parent_ctx);
 
+	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event, f_flags);
+	if (IS_ERR(event_file)) {
+		err = PTR_ERR(event_file);
+		event_file = NULL;
+		goto err_context;
+	}
+
 	/*
 	 * This is the point on no return; we cannot fail hereafter. This is
 	 * where we start modifying current state.
@@ -12500,17 +12479,15 @@ SYSCALL_DEFINE5(perf_event_open,
 	fd_install(event_fd, event_file);
 	return event_fd;
 
-err_cred:
-	if (task)
-		up_read(&task->signal->exec_update_lock);
-err_file:
-	fput(event_file);
 err_context:
 	/* event->pmu_ctx freed by free_event() */
 err_locked:
 	mutex_unlock(&ctx->mutex);
 	perf_unpin_context(ctx);
 	put_ctx(ctx);
+err_cred:
+	if (task)
+		up_read(&task->signal->exec_update_lock);
 err_alloc:
 	/*
 	 * If event_file is set, the fput() above will have called ->release()
