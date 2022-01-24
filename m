Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF28D49846D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbiAXQMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:12:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43980 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbiAXQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:12:45 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643040763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PeaWocVe+zAkIL1SsVk87o1AdXbDA9YfLASIl5X0r4=;
        b=XYqDAdpr1CEck0L19jB9n0JlvFW0e+ol2ELD5OFtCJDLzCQaxUZAwaws+v+nx9O3v4l01W
        Q+6MYcMKLzUDGdfyQ0S+SdKFaI4aQzSsZNnQ6VBUf7lRuJsKOClgEValpd7x145R6gRCgJ
        +r7n9uCTiQHYi8ws31LB4txTN9qasgXJCkd0p2Lm57ZUPqH6KQhzbBuFJ+RUEd3MtSRW6C
        Q9x9C2sQfXLAz5aXvfMF1m2f4UAzfeM9egYZTD9bdlvjC558NGOk7ZzKmb0uB8LRA8CO5A
        kG2j+F9ub5++TMAbCniMnN/NjhqXTV0bIVyNgYcB7llDhyyieRg9ruCkNo6BOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643040763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PeaWocVe+zAkIL1SsVk87o1AdXbDA9YfLASIl5X0r4=;
        b=l6Bi8186Y1Aten8NfPIKdPGOZXyrec0przkfM28k6xCZQT2f/dZV+sQd3sji02FSCvWpGO
        lRh4znBGtAWhepBw==
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] printk: Drop console_sem during panic
In-Reply-To: <20220121190222.572694-5-stephen.s.brennan@oracle.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-5-stephen.s.brennan@oracle.com>
Date:   Mon, 24 Jan 2022 17:18:42 +0106
Message-ID: <87pmoh3yf9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-21, Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> If another CPU is in panic, we are about to be halted. Try to gracefully
> drop console_sem and allow the panic CPU to grab it easily.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  kernel/printk/printk.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ca253ac07615..c2dc8ebd9509 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2668,7 +2668,7 @@ void console_unlock(void)
>  
>  	for (;;) {
>  		size_t ext_len = 0;
> -		int handover;
> +		int handover, pcpu;
>  		size_t len;
>  
>  skip:
> @@ -2739,6 +2739,12 @@ void console_unlock(void)
>  		if (handover)
>  			return;
>  
> +		/* Allow panic_cpu to take over the consoles safely */
> +		pcpu = atomic_read(&panic_cpu);
> +		if (unlikely(pcpu != PANIC_CPU_INVALID &&
> +		    pcpu != raw_smp_processor_id()))
> +			break;
> +

Keep in mind that after the "break", this context will try to re-acquire
the console lock and continue printing. That is a pretty small window
for the panic CPU to attempt a trylock.

Perhaps the retry after the loop should also be avoided for non-panic
CPUs. This would rely on the panic CPU taking over (as your comment
suggests will happen). Since the panic-CPU calls pr_emerg() as the final
record before drifting off to neverland, that is probably OK.

Something like:

@@ -2731,7 +2731,8 @@ void console_unlock(void)
 	 * there's a new owner and the console_unlock() from them will do the
 	 * flush, no worries.
 	 */
-	retry = prb_read_valid(prb, next_seq, NULL);
+	retry = (pcpu != raw_smp_processor_id()) &&
+		prb_read_valid(prb, next_seq, NULL);
 	if (retry && console_trylock())
 		goto again;
 }

I would also like to see a comment about why it is acceptable to use
raw_smp_processor_id() in a context that has migration
enabled. Something like: raw_smp_processor_id() can be used because this
context cannot be migrated to the panic CPU.

John Ogness
