Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEAE5B005B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiIGJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiIGJYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:24:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE5BBE0E;
        Wed,  7 Sep 2022 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eQFzOcIipszp6ahwerqT8sz1zN5hUznjOEivN80I+bY=; b=fbjeND41SAnIjlLicpqS6g5Q2X
        K/ZupRP33uxNUdO81A+aiwjXadXtaAEfnXBE1UA1COGYkPIa+5RvwWjjPAe+RQpayLiTXpDk//X73
        vp6vP9Pvh5GLoEAqSRoBdoCc4JWG2Bio0rfhSReNhHGhXBw9lO2t/dlGtFeyOS9of0TbVfJR+KBpE
        YrGuJQ6HopNqi5hRDRVjpSrCyc8wqKlBCnZr3M9xnUOoGuOADDl1fSp3ebWZFec2WgnajWC9qBNFm
        EbKMTcUbHgbi1iEVzgu2ZxlpbYLsbKvGthGrEv/oa1WQd8HkaGSPmSxHNFq/6tWOdynT+aBhNO9ig
        lhdUeCYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVrHz-00APT1-RK; Wed, 07 Sep 2022 09:24:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B5E0300244;
        Wed,  7 Sep 2022 11:24:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3DDC2B99BB11; Wed,  7 Sep 2022 11:24:05 +0200 (CEST)
Date:   Wed, 7 Sep 2022 11:24:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] sched/completion: Add wait_for_completion_state()
Message-ID: <YxhjNSnFHcexbM+0@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.922711674@infradead.org>
 <YxSB85+BamWFj5xw@gmail.com>
 <Yxcfx/NvzMm3wRTU@hirez.programming.kicks-ass.net>
 <YxhJuHMvTgv4s1pV@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhJuHMvTgv4s1pV@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:35:20AM +0200, Ingo Molnar wrote:
> That's not actually true: there's ~7 functions in kernel/sched/completion.c 
> with local variables, and only ~2 have this minor stylistic inconsistency 
> right now AFAICS. Scheduler-wide the ratio is even lower.
> 
> So even if a patch doesn't entirely remove the residual noise, let's not 
> add to it, please?


--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -204,6 +204,7 @@ EXPORT_SYMBOL(wait_for_completion_io_tim
 int __sched wait_for_completion_interruptible(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
+
 	if (t == -ERESTARTSYS)
 		return t;
 	return 0;
@@ -241,6 +242,7 @@ EXPORT_SYMBOL(wait_for_completion_interr
 int __sched wait_for_completion_killable(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
+
 	if (t == -ERESTARTSYS)
 		return t;
 	return 0;
@@ -250,6 +252,7 @@ EXPORT_SYMBOL(wait_for_completion_killab
 int __sched wait_for_completion_state(struct completion *x, unsigned int state)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
+
 	if (t == -ERESTARTSYS)
 		return t;
 	return 0;
