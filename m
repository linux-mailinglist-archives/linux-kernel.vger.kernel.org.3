Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544115085B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377584AbiDTKXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377530AbiDTKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:23:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63D91D0F3;
        Wed, 20 Apr 2022 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BwqMSjcged9Et6HKR9YVRBXhbJxx6UdXObdCdZiFoRo=; b=C0p4jlnGWYx/e27oLwxPPQFEMm
        e7rWh6ntsVOMdBtax8OA5valvqJ5lTOfqQRY4PVkTCkNE1FEMQQN97yo5AFtoSgahTMjSxzHLRZTJ
        PN/GqxXAt6NZCVVrdiNjSc3qVlTE+Y2kQvVIuaLtNxewRjg7Rm8n1X7ZJkdz1ffT60HBdFKL2xg3i
        kaP2D6xkcaizTyvSPabAw9D8RHEd0dVwAC/0pQpbI1Tg+tZx8p0I0MMKgb7md3Fqv0BPdPHqnY002
        oHZLtn3pHeoE0j9JqyZ/6eMH5rebf80mKS6Hh2FJgn+GLVC5NcB9V0e3/l5nVExCm5iRx747CjzDc
        tHCjUpGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh7RQ-003zLF-C8; Wed, 20 Apr 2022 10:20:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21AA79861A4; Wed, 20 Apr 2022 12:20:06 +0200 (CEST)
Date:   Wed, 20 Apr 2022 12:20:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220420102006.GD2731@worktop.programming.kicks-ass.net>
References: <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415105755.GA15217@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:57:56PM +0200, Oleg Nesterov wrote:
> On 04/15, Oleg Nesterov wrote:
> >
> > OK, so far it seems that this patch needs a couple of simple fixes you
> > pointed out, but before I send V2:
> >
> > 	- do you agree we can avoid JOBCTL_TRACED_FROZEN in 1-2 ?
> >
> > 	- will you agree if I change ptrace_freeze_traced() to rely
> > 	  on __state == TASK_TRACED rather than task_is_traced() ?
> >
> 
> Forgot to say, I think 1/5 needs some changes in any case...
> 
> ptrace_resume() does  wake_up_state(child, __TASK_TRACED) but doesn't
> clear JOBCTL_TRACED. The "else" branch in ptrace_stop() leaks this flag
> too. Perhaps I missed something, I'll reread 1/5 again, but the main
> question to me is whether 1-2 actually need the JOBCTL_TRACED_FROZEN flag.

Ok, getting back to this. So I did the change to ptrace_resume(), but
I'm not entirely sure I understand the issue with the else branch of
ptrace_stop().

My understanding is that if we hit that else branch, we've raced wth
__ptrace_unlink(), and that will have done:

  if (... || task_is_traced(child))
	ptrace_signal_wake_up(child, true);

Which will have done that wakeup and cleared both __state and jobctl.

