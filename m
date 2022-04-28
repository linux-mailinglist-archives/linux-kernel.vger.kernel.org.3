Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26C1513E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiD1WZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiD1WZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:25:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C397E586;
        Thu, 28 Apr 2022 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+G7Hie6oNGeDpB2KJb8maGKxz+Iq00+I/qZ1qzvpZWM=; b=iGjf+zCilEf0KrKaMPlr6RTk4h
        ARG+nvzH92DI5nzGFENrjO/ShsEy8TsYYhRK5m7Z0unN67DIXeQD5uJkAY1mw2dDR0QAEBkUuloiN
        YTps4a0MMnSaaXfvokz5UUUqirdY2qg3/OKJ3LnXHxRm24q4T4BNtQxoX0dvJkOhv2Vb/tmrcUNrF
        dR0R96+BbZ19BM6HHsAbnPGsdCwdXGFt4jQ9KxJpCbln/AULhRvlfIr7B/S5gzd4GDZrOSJf6DhbX
        XGX6k63cc1r3DuDgOT6uqbzB+UTift48Ewd8Dc0lT3ZMEEDggB2v6dv5vjkJcJzuhpP4/jtwb46vQ
        CIwGd3cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkCW7-009RZ2-L6; Thu, 28 Apr 2022 22:21:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46FCF30027B;
        Fri, 29 Apr 2022 00:21:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 318BA202961EB; Fri, 29 Apr 2022 00:21:43 +0200 (CEST)
Date:   Fri, 29 Apr 2022 00:21:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <YmsTd4FiAXjsFegE@hirez.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <20220425174719.GB12412@redhat.com>
 <8735hzcr18.fsf@email.froward.int.ebiederm.org>
 <Ymr5Ga3gcqG4ZAMt@hirez.programming.kicks-ass.net>
 <20220428205956.GG15485@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428205956.GG15485@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:59:57PM +0200, Oleg Nesterov wrote:
> On 04/28, Peter Zijlstra wrote:
> >
> > Oleg pointed out that the tracee can already be killed such that
> > fatal_signal_pending() is true. In that case signal_wake_up_state()
> > cannot be relied upon to be responsible for the wakeup -- something
> > we're going to want to rely on.
> 
> Peter, I am all confused...
> 
> If this patch is against the current tree, we don't need it.
> 
> If it is on top of JOBCTL_TRACED/DELAY_WAKEKILL changes (yours or Eric's),
> then it can't help - SIGKILL can come right after the tracee drops siglock
> and calls schedule().

But by that time it will already have set TRACED and signal_wake_up()
wil clear it, no?

> Perhaps I missed something, but let me repeat the 3rd time: I'd suggest
> to simply clear JOBCTL_TRACED along with LISTENING/DELAY_WAKEKILL before
> return to close this race.

I think Eric convinced me there was a problem with that, but I'll go
over it all again in the morning, perhaps I'll reach a different
conclusion :-)
