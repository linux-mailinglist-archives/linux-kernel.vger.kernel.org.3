Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F779513CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351838AbiD1Ucv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351793AbiD1Ucu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:32:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23D7C0D2C;
        Thu, 28 Apr 2022 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8UxpUSIPFug1Y4nwjJyq8teHc+MOpvF2UGEYKEOV43Y=; b=TzP45iG3tZMjjelPcKDQ2a8+uf
        OqoazTEfDEiG+dijLrUG9d85XImXNf8KX0/v/ygkBqAfZavGHhptl1uvOKRBjLoIzUcXPzsFg1lDR
        8thWV0xvmSqlBGakqtRpU11LQprwQb91hxGQUTDoioYL2vDVWcVO6g/GTfQWL2GndVhe8KlERl6wL
        Hs0snVz32/ORHthHjF9o8bWIi/Ykb6PzEDV6tWpK3nKeCQblw4TcOSWCWh3JNSYSHZ181Un5hdNpG
        a72m6Cx/dvo08RDeB23r4SaIHPU+byd4VnMS/if0Q+4TOWeqxVoPjMyKJdOmvStPM7rcbJ8+LTAq3
        M6w9O7Hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkAlI-009QA7-FQ; Thu, 28 Apr 2022 20:29:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D80C3001F7;
        Thu, 28 Apr 2022 22:29:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FBBD2029F4C3; Thu, 28 Apr 2022 22:29:13 +0200 (CEST)
Date:   Thu, 28 Apr 2022 22:29:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
Message-ID: <Ymr5Ga3gcqG4ZAMt@hirez.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <20220425174719.GB12412@redhat.com>
 <8735hzcr18.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735hzcr18.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:24:03PM -0500, Eric W. Biederman wrote:
> But doing:
> 
> 	/* Don't stop if the task is dying */
> 	if (unlikely(__fatal_signal_pending(current)))
> 		return exit_code;
> 
> Should work.

Something like so then...

---
Subject: signal,ptrace: Don't stop dying tasks
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Apr 28 22:17:56 CEST 2022

Oleg pointed out that the tracee can already be killed such that
fatal_signal_pending() is true. In that case signal_wake_up_state()
cannot be relied upon to be responsible for the wakeup -- something
we're going to want to rely on.

As such, explicitly handle this case.

Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/signal.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2226,6 +2226,10 @@ static int ptrace_stop(int exit_code, in
 		spin_lock_irq(&current->sighand->siglock);
 	}
 
+	/* Don't stop if the task is dying. */
+	if (unlikely(__fatal_signal_pending(current)))
+		return exit_code;
+
 	/*
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
