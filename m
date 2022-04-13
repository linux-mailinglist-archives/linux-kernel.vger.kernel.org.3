Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC04FFF10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiDMTXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiDMTXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:23:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0271483BD;
        Wed, 13 Apr 2022 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5200STCdSkk0cXg3Unfn6dqxNXzM2r04BJOn85iTJrM=; b=K6NCmdSuMj5cYgpO14HzXFxN1a
        qbuS/mZIi32FSsurz4EouHfUQoTJKLyI21byCBW6q+5UQBRlXvWApYkd713NTs1ZYw3NkeorFadXp
        nBttLHpjF1rHJ9G0PfurfmLfBkU+mfHwixrFuk64BDs0+bz5y7HOqoK8OPZgqYL6ujGWNSsIJI2v2
        VBE6aP07fPcD1mp+JUh2Z6MTd/5vi14MUcPnPdwjhBMFXPArdtvAuWt8HpTbLNc7i53BAGN5M9rjd
        0ml5bdRzBFk28+VV7FA5Lt3JZkPZzDtdxTz88tco+7AHYx9m/WcSC5aH7UilkzoFrBZB+kF02bwlo
        Klfs/Esg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neiXv-00EViw-64; Wed, 13 Apr 2022 19:20:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6C0598623C; Wed, 13 Apr 2022 21:20:53 +0200 (CEST)
Date:   Wed, 13 Apr 2022 21:20:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220413192053.GY2731@worktop.programming.kicks-ass.net>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413185909.GB30360@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:59:10PM +0200, Oleg Nesterov wrote:


> +		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> +		// wrong, needs siglock
> +		current->jobctl &= ~JOBCTL_TRACED_XXX;
> +		wake_up_bit(&current->jobctl, ~JOBCTL_TRACED_XXX_BIT);
		  __wake_up_common_lock()
		    spin_lock_irqsave()
		      current_save_and_set_rtlock_wait_state();

			> +	if (wait_on_bit(&task->jobctl, JOBCTL_TRACED_XXX_BIT, TASK_KILLABLE))
			> +		return -EINTR;
			> +	// now that the tracee cleared JOBCTL_TRACED_XXX_BIT
			> +	// wait_task_inactive() should succeed or fail "really soon".
			> +	if (!wait_task_inactive(child, __TASK_TRACED))
			> +		return ret;


	*whoopsie* ?

>  		preempt_enable_no_resched();
>  		freezable_schedule();
>  		cgroup_leave_frozen(true);
