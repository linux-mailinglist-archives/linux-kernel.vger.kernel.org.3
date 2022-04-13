Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7694FFBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbiDMRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiDMRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:00:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C97F6A03F;
        Wed, 13 Apr 2022 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fxcWXxliDVwtHEu/Qyoy3uW0J2eshHKocZ5Ssyd/xp4=; b=NGOURvw/Qob+Io9Ag0qQDxY8sT
        7whgw2h8Vwk1YG4wiBtwcZX0WaK+Afn2KxNXYN7FUT2+1RH+6it8748YYTEDquppLMXvaxuA3ICVq
        0Q8I+T1iXCvjsV0gi8U1NyPi6+wJxnVMlL5vKLXKGQorpnDeFTcX0F7mCPUy3mo63EGE0zAzwA3bW
        5SfDwCtqfa4KAONzS0ZJVLxSRBmjg5z3/U7ecOZINY+NefSgpAMyrYIYd5vXcE5n68iQ+goimEzNm
        4soyWMmaqaDg6RgsKQLwbwDYwYDo6lozyADBjNis0l77DiLdRoClh5NXueyQAFLTN7KnLE0RwGYx6
        hVPe+PfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1negJu-00EPsM-0N; Wed, 13 Apr 2022 16:58:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8821830031E;
        Wed, 13 Apr 2022 18:58:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43A0629DC9F64; Wed, 13 Apr 2022 18:58:17 +0200 (CEST)
Date:   Wed, 13 Apr 2022 18:58:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <YlcBKQvp524p0KRY@hirez.programming.kicks-ass.net>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413132451.GA27281@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:24:52PM +0200, Oleg Nesterov wrote:
> Hi Peter,
> 
> I like 1-2 but I need to read them (and other patches) again, a
> couple of nits right now.
> 
> On 04/12, Peter Zijlstra wrote:
> >
> > +static int __ptrace_freeze_cond(struct task_struct *p)
> > +{
> > +	if (!task_is_traced(p))
> > +		return -ESRCH;
> 
> 	if (!task_is_traced(p) || p->parent != current)
> 		return -ESRCH;
> 
> we should not spin/sleep if it is traced by another task

Yes, fair enough. And I suppose doing this test without holding siglock
is safe enough.

> > +static int __ptrace_freeze(struct task_struct *p, void *arg)
> > +{
> > +	int ret;
> > +
> > +	ret = __ptrace_freeze_cond(p);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Task scheduled between __ptrace_pre_freeze() and here, not our task
> > +	 * anymore.
> > +	 */
> > +	if (*(unsigned long *)arg != p->nvcsw)
> > +		return -ESRCH;
> > +
> > +	if (looks_like_a_spurious_pid(p))
> > +		return -ESRCH;
> 
> Oh, I do not think __ptrace_freeze() should check for spurious pid...
> looks_like_a_spurious_pid() should be called once in ptrace_check_attach()
> before task_call_func(__ptrace_freeze).

I can certainly do that, but since that needs be done with siglock held,
and the __ptrace_freeze call is a one-time affair, I didn't really see
the point in making the code more complicated.

Something like so then?

--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -222,7 +222,7 @@ static void ptrace_unfreeze_traced(struc
  */
 static int __ptrace_freeze_cond(struct task_struct *p)
 {
-	if (!task_is_traced(p))
+	if (!task_is_traced(p) || p->parent != current)
 		return -ESRCH;
 
 	if (task_curr(p))
@@ -283,9 +283,6 @@ static int __ptrace_freeze(struct task_s
 	if (*(unsigned long *)arg != p->nvcsw)
 		return -ESRCH;
 
-	if (looks_like_a_spurious_pid(p))
-		return -ESRCH;
-
 	if (__fatal_signal_pending(p))
 		return -ESRCH;
 
@@ -378,6 +375,9 @@ static int ptrace_check_attach(struct ta
 		 * does ptrace_unlink() before __exit_signal().
 		 */
 		spin_lock_irq(&child->sighand->siglock);
+		if (looks_like_a_spurious_pid(child))
+			goto unlock_sig;
+
 		ret = task_call_func(child, __ptrace_freeze, &nvcsw);
 		if (ret) {
 			/*
@@ -386,6 +386,7 @@ static int ptrace_check_attach(struct ta
 			 */
 			ret = -ESRCH;
 		}
+unlock_sig:
 		spin_unlock_irq(&child->sighand->siglock);
 	}
 unlock:
