Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04304FFBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiDMQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiDMQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:50:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6664692A9;
        Wed, 13 Apr 2022 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+waI7v+dCVZ0vufSFv8wG18VEgKuZfF8rc6E2PHXDds=; b=NRP5c3rg1/dIRn19tmuiu6tNPb
        IYkF5PrnTXyG6aDtCnfNMaEY0PpgYrzziNNS372OQYIXLE9paPNR3R2aVNz2xZAV8yBPvP6mB3aL0
        eSM1306WwBXXAdU0PtpkVXyWgekkGURowKf5fejrY9k5Nx+wEU8jtGjmHBObdsvzA6QQZ6ASwSCHJ
        iuSEOK/NOKrinsjwBdZBn3ZyURFEGKoOx5P3Y1pOii1jrNNOmqE0OIrXkOLUsvTKf4oPlfwGvPfjM
        bLD+KRDcphuZcEVWuPUG+qpCR4DrD/oP6OG7n3QY/MLA83Ri78FWr+tV1wJ8Ogv81I38ud1aIkQ2a
        hK1GlbkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neg9d-00EPWT-TN; Wed, 13 Apr 2022 16:47:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9442B30027B;
        Wed, 13 Apr 2022 18:47:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E8592659F051; Wed, 13 Apr 2022 18:47:40 +0200 (CEST)
Date:   Wed, 13 Apr 2022 18:47:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <Ylb+rNNUmZdamb/U@hirez.programming.kicks-ass.net>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.782838521@infradead.org>
 <20220413132922.GB27281@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413132922.GB27281@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:29:22PM +0200, Oleg Nesterov wrote:
> On 04/12, Peter Zijlstra wrote:
> >
> > @@ -475,8 +483,10 @@ static int ptrace_attach(struct task_str
> >  	 * in and out of STOPPED are protected by siglock.
> >  	 */
> >  	if (task_is_stopped(task) &&
> > -	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING))
> > +	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
> > +		task->jobctl &= ~JOBCTL_STOPPED;
> >  		signal_wake_up_state(task, __TASK_STOPPED);
> 
> OK, but just for record before I forget...
> 
> It seems that we can s/JOBCTL_STOPPED/JOBCTL_TRACED/ instead, and kill the
> nasty wait_on_bit(JOBCTL_TRAPPING_BIT) along with JOBCTL_TRAPPING_BIT. Sure,
> this doesn't belong to this series.

I'm afraid I didn't look hard enough at that part to really understand
it, but some cleanup around there sounds lovely.
