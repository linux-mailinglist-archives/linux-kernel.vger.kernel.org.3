Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B649B742
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390729AbiAYPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:07:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44040 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581305AbiAYPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:05:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 34C591F380;
        Tue, 25 Jan 2022 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643123103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xumwwOa5ECEt7uJfX+ahH0fKv36XmsrcJ45EDKOzk2Y=;
        b=BDYbbDvDaid88aRNMa4xIrza9kxLUE2bA4n4F77BPq2fo9S8/MCbACHv42ce8ZTCC8G1bq
        204BHbwcaivKah+f1KSCsLsI6E1h6kbo2KtOpPADzIpFpujfM5LPDtsJWbbYXe+4aejASd
        I0D36cexJPxGsdxp1bY8lwU5bVGZEFs=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A299A3B87;
        Tue, 25 Jan 2022 15:05:03 +0000 (UTC)
Date:   Tue, 25 Jan 2022 16:04:59 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] printk: Drop console_sem during panic
Message-ID: <YfARmwyLyl8gj6Zy@alley>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-5-stephen.s.brennan@oracle.com>
 <87pmoh3yf9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmoh3yf9.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-01-24 17:18:42, John Ogness wrote:
> On 2022-01-21, Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> > If another CPU is in panic, we are about to be halted. Try to gracefully
> > drop console_sem and allow the panic CPU to grab it easily.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > ---
> >  kernel/printk/printk.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index ca253ac07615..c2dc8ebd9509 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2668,7 +2668,7 @@ void console_unlock(void)
> >  
> >  	for (;;) {
> >  		size_t ext_len = 0;
> > -		int handover;
> > +		int handover, pcpu;
> >  		size_t len;
> >  
> >  skip:
> > @@ -2739,6 +2739,12 @@ void console_unlock(void)
> >  		if (handover)
> >  			return;
> >  
> > +		/* Allow panic_cpu to take over the consoles safely */
> > +		pcpu = atomic_read(&panic_cpu);
> > +		if (unlikely(pcpu != PANIC_CPU_INVALID &&
> > +		    pcpu != raw_smp_processor_id()))
> > +			break;
> > +
> 
> Keep in mind that after the "break", this context will try to re-acquire
> the console lock and continue printing. That is a pretty small window
> for the panic CPU to attempt a trylock.
>
> Perhaps the retry after the loop should also be avoided for non-panic
> CPUs. This would rely on the panic CPU taking over (as your comment
> suggests will happen). Since the panic-CPU calls pr_emerg() as the final
> record before drifting off to neverland, that is probably OK.

Great catch!

> Something like:
> 
> @@ -2731,7 +2731,8 @@ void console_unlock(void)
>  	 * there's a new owner and the console_unlock() from them will do the
>  	 * flush, no worries.
>  	 */
> -	retry = prb_read_valid(prb, next_seq, NULL);
> +	retry = (pcpu != raw_smp_processor_id()) &&
> +		prb_read_valid(prb, next_seq, NULL);
>  	if (retry && console_trylock())
>  		goto again;
>  }
> 
> I would also like to see a comment about why it is acceptable to use
> raw_smp_processor_id() in a context that has migration
> enabled. Something like: raw_smp_processor_id() can be used because this
> context cannot be migrated to the panic CPU.

Yup. It would be nice to mention this.

We actually need the same check in both locations. I would either put
it into a helper or I would pass the result via a variable:

The helper might look like:

/*
 * Return true when this CPU should unlock console_sem without pushing
 * all messages to the console. It would allow to call console in
 * panic CPU a safe way even after other CPUs are stopped.
 *
 * It can be called safely even in preemptive context because panic
 * CPU does not longer schedule.
 */
static bool abandon_console_lock_in_panic()
{
	if (!panic_in_progress())
		return false;

	return atomic_read(&panic_cpu) != raw_smp_processor_id();
}

Note that I used panic_in_progress() because it makes the code more
readable. Using pcpu variable is small optimization. But it has effect
only during panic() where it is not important. It is slow path anyway.

Best Regards,
Petr
