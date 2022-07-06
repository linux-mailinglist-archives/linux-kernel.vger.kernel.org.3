Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C651356867F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiGFLOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiGFLOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:14:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB4027CFA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fztPrfHXm7UR9PifETIZb3gX7gg3+lc6nr3BVtjGe6w=; b=Wv6eN4GBkESm3pqWaxQbSSV5OP
        Bd6MKMO338Jv6zkquc+4paSRj+DhTsT4Q6NZeciH0jKnQAZjHe3c0eQTrj0BJyJprWGg3kv40jroc
        lIMddxsQb4YSe3ILrLs0ftgvLEtLTlzyK//RWH+UCsVdsu3S+7Kubhiww3GEWZnlt4v926vocTQLN
        3k/qiX4dtqH8c02lUT4/X8D+mBdD0rHShLcqqxam0el4Dub2rbTyTlwv5LZuayAz2Vf2uFPxahk5g
        Kyt+C1db4+gmeT7V4cDzPq79jvWG3mkWap3BfOplEJEy31rHcrSMw0YfS+H2XWsjPiNhwY+e0t5J5
        5eSfwNLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o92yb-000X59-CB; Wed, 06 Jul 2022 11:13:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 24BAF980050; Wed,  6 Jul 2022 13:13:47 +0200 (CEST)
Date:   Wed, 6 Jul 2022 13:13:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix clearing of JOBCTL_TRACED in
 ptrace_unfreeze_traced()
Message-ID: <YsVuak0/upU2Rvm6@worktop.programming.kicks-ass.net>
References: <20220706101625.2100298-1-svens@linux.ibm.com>
 <20220706110438.GB9868@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706110438.GB9868@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 01:04:38PM +0200, Oleg Nesterov wrote:
> On 07/06, Sven Schnelle wrote:
> >
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -222,7 +222,7 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
> >  	if (lock_task_sighand(task, &flags)) {
> >  		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
> >  		if (__fatal_signal_pending(task)) {
> > -			task->jobctl &= ~TASK_TRACED;
> > +			task->jobctl &= ~JOBCTL_TRACED;
> 
> Heh. I have read this code many times, but I'm afraid I could read it
> 1000 times more and didn't notice the problem ;)

Heh, same here, I've read it today and didn't spot the problem. Brains
are weird.
