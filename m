Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7FE59C470
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiHVQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiHVQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6B17A9B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oj6e2wXAAKIK+F/g8o6y0in3B5Ye0wan8VUmiE2JLTM=; b=twXcSabF15bo+lVzE+cC/bKD/R
        xOuHAgT9aFjglVD5Y+lHD9eqOrxkLSNWRrZ5dnI2Nh2sxKXCuGB/Kge7G/5i+Y636PJO8hulvcOLO
        a+2dYb9v+FflOoGFnZVOzatAuMVa10yfIy++PJNQ4nW9IJ7MKx8U6x7JGgOlU6S7kIevIxmKgFXv0
        0Ra+76NcN219HxlKORtUIx516HreZ7EeUHjaMuOQ9UY72AYi83sv78EjUJnf/48TmGJg9OEvRKFIG
        3u6nuOtALiEKuxQb+itnYaaK7lj9u0nOuGsyOMzoXj3fNkjwF3Yxuav2ozajzl1R19N/DImpnoJrL
        WhZy5xkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQAel-00ETVJ-Q2; Mon, 22 Aug 2022 16:52:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2D049804A3; Mon, 22 Aug 2022 18:52:06 +0200 (CEST)
Date:   Mon, 22 Aug 2022 18:52:06 +0200
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
Message-ID: <YwO0Nh5LHZ7uzWvm@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
 <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:41:42AM +0530, Ravi Bangoria wrote:

> > @@ -12358,58 +12374,14 @@ SYSCALL_DEFINE5(perf_event_open,
> >  			goto err_context;
> >  	}
> >  
> > -	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event, f_flags);
> > -	if (IS_ERR(event_file)) {
> > -		err = PTR_ERR(event_file);
> > -		event_file = NULL;
> > -		goto err_context;
> > -	}
> > -
> > -	if (task) {
> > -		err = down_read_interruptible(&task->signal->exec_update_lock);
> > -		if (err)
> > -			goto err_file;
> > -
> > -		/*
> > -		 * We must hold exec_update_lock across this and any potential
> > -		 * perf_install_in_context() call for this new event to
> > -		 * serialize against exec() altering our credentials (and the
> > -		 * perf_event_exit_task() that could imply).
> > -		 */
> > -		err = -EACCES;
> > -		if (!perf_check_permission(&attr, task))
> > -			goto err_cred;
> > -	}
> > -
> > -	if (ctx->task == TASK_TOMBSTONE) {
> > -		err = -ESRCH;
> > -		goto err_locked;
> > -	}
> 
> I think we need to keep (ctx->task == TASK_TOMBSTONE) check?

I think so too; in fact the code I have still has it, perhaps it was
there write before this patch?

> > -
> >  	if (!perf_event_validate_size(event)) {
> >  		err = -E2BIG;
> > -		goto err_locked;
> > -	}
> > -
> > -	if (!task) {
> > -		/*
> > -		 * Check if the @cpu we're creating an event for is online.
> > -		 *
> > -		 * We use the perf_cpu_context::ctx::mutex to serialize against
> > -		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
> > -		 */
> > -		struct perf_cpu_context *cpuctx =
> > -			container_of(ctx, struct perf_cpu_context, ctx);
> > -
> > -		if (!cpuctx->online) {
> > -			err = -ENODEV;
> > -			goto err_locked;
> > -		}
> > +		goto err_context;
> 
> Why did you remove this hunk? We should confirm whether cpu is online or not
> before creating event. No?

Idem.

Perhaps it is best if we look at the end result of all these patches
combined and then I'll fold the lot if we're in agreement and then we
can forget about these intermediate steps.
