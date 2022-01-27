Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC75249E254
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiA0M0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiA0M0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:26:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41AC061714;
        Thu, 27 Jan 2022 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ahwv7/f/d1wI1UunAeceetp1H08EJfVU7XPnkABFG5E=; b=QkAOsFVIQVeugYoeLMuS21eVwD
        BPmC8JFQCcJ4j9NVkMK1OFcsyWA3Tkm7FFOi7HuM1PBggbDhWMqIKRzHGyjCY1XeIJ5Iy5RrzrI1W
        nDbb/gk7KRI4ZfAgC7LSPOJHCcuYP/4JXeOwWFiQRi2/JadQN+LF3j7bKnm03Y5i2ZaV9zUcRsPk5
        VtmR2g5tvIR7Tbzm68LEAo6JfUfrL1uLEHuooRYgj8TfV+iqaJwFmHurvZhTvPwDLOPhURFH4K6ut
        x5MDR++uZsIdyI3fliKhXwUvc3cFDlYxI6JBO/MuLkXcAxUQKuQERqQDfdIqpSgAnvGrOsQOMHJpq
        GL0giNMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD3qN-005D5r-8h; Thu, 27 Jan 2022 12:25:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14290300268;
        Thu, 27 Jan 2022 13:25:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBFA12B52092A; Thu, 27 Jan 2022 13:25:36 +0100 (CET)
Date:   Thu, 27 Jan 2022 13:25:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <YfKPQJ+Nr4Qokgim@hirez.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
 <Ye67uQa4CwUuQJVY@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye67uQa4CwUuQJVY@geo.homenetwork>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:46:17PM +0800, Tao Zhou wrote:

> > +/* Called from syscall exit path and exceptions that can schedule */
> > +void umcg_sys_exit(struct pt_regs *regs)
> > +{
> > +	struct task_struct *tsk = current;
> > +	long syscall = syscall_get_nr(tsk, regs);
> > +
> > +	if (syscall == __NR_umcg_wait ||
> > +	    syscall == __NR_umcg_ctl)
> > +		return;
> > +
> > +	if (tsk->umcg_server) {
> > +		/*
> > +		 * Didn't block, we done.
> > +		 */
> > +		umcg_unpin_pages();
> > +		return;
> > +	}
> > +
> > +	umcg_unblock_and_wait();
> 
> umcg_unblock_and_wait() -> umcg_enqueue_and_wake() ->
> umcg_wake_server() -> umcg_wake_task(tsk->umcg_server, ...)
> 
> tsk->umcg_server is NULL here and umcg_wake_task() use it to update
> state in umcg_update_state(NULL, ...), that means tsk->umcg_clock
> will happen something i do not know.

I think umcg_unblock_and_wait() will repin, at which point we should
have tsk->umcg_server again.

> There are two places to call umcg_unblock_and_wait(). One is in 
> umcg_register() where the server is set. Another one is in
> umcg_sys_exit() where the server is not set. May use a bool to
> indicate if the server is set.

I'm not sure what you're on about, but I absolutely hate redundant
state, that only leads to problems.

