Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08874F66C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbiDFRTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbiDFRTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:19:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00048639D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:17:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36B49210FC;
        Wed,  6 Apr 2022 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649258225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akDi/qaCymthwYFvGT5lESltVEwfj2NlTSGzwyM8fXo=;
        b=ILbcp6ku2D0+FWQlK4fSevU83hN+uoBoS57Y6sZuQlN0EsjdDi82lCXp+wiK5Q66Xt0F48
        YFDQVAbgzAKOjg2fO6IapyTgA4jk2Lg/UbcDCblZOe8+/p3Hd1bsSMw998Qjop2pPIfm5l
        2FxE7kNDhuI9WDvL/BD1lWwBPdgJbkg=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C44CBA3B83;
        Wed,  6 Apr 2022 15:17:04 +0000 (UTC)
Date:   Wed, 6 Apr 2022 17:17:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 08/12] printk: add pr_flush()
Message-ID: <Yk2u7dgm2VQk1DGn@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:31, John Ogness wrote:
> Provide a might-sleep function to allow waiting for console printers
> to catch up to the latest logged message.
> 
> Use pr_flush() whenever it is desirable to get buffered messages
> printed before continuing: suspend_console(), resume_console(),
> console_stop(), console_start(), console_unblank().
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 06f0b29d909d..d0369afaf365 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3321,6 +3331,79 @@ static int __init printk_late_init(void)
>  late_initcall(printk_late_init);
>  
>  #if defined CONFIG_PRINTK
> +/* If @con is specified, only wait for that console. Otherwise wait for all. */
> +static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
> +{
> +	int remaining = timeout_ms;
> +	struct console *c;
> +	u64 last_diff = 0;
> +	u64 printk_seq;
> +	u64 diff;
> +	u64 seq;
> +
> +	might_sleep();
> +
> +	seq = prb_next_seq(prb);

I auggest to add here:

	/*
	 * Try to flush the messages when kthreads are not available
	 * and there is not other console lock owner.
	 */
	if (console_trylock())
		console_unlock()

> +
> +	for (;;) {
> +		diff = 0;
> +
> +		console_lock();
> +		for_each_console(c) {
> +			if (con && con != c)
> +				continue;
> +			if (!console_is_usable(c))
> +				continue;
> +			printk_seq = c->seq;
> +			if (printk_seq < seq)
> +				diff += seq - printk_seq;
> +		}
> +		console_unlock();

This is a bit sub-optimal when the kthreads are not available or
are disabled. In this case, the messages are flushed [*] by
the console_unlock() and the diff is outdated.

As a result, the code would non-necessarily sleep 100ms before
it realizes that the job is done.

One might argue that the problem will be only when there are
non-handled messages and in situations when the delay probably
is not critical.

Well, it is ugly to keep it this way. I suggest to add the extra
console_trylock()/unlock() at the beginning.

> +
> +		if (diff != last_diff && reset_on_progress)
> +			remaining = timeout_ms;
> +
> +		if (diff == 0 || remaining == 0)
> +			break;
> +
> +		if (remaining < 0) {
> +			/* no timeout limit */
> +			msleep(100);
> +		} else if (remaining < 100) {
> +			msleep(remaining);
> +			remaining = 0;
> +		} else {
> +			msleep(100);
> +			remaining -= 100;
> +		}
> +
> +		last_diff = diff;
> +	}
> +
> +	return (diff == 0);
> +}

Otherwise, it looks good to me. It is an interesting function.
I wonder if it gets popular also outside printk code. ;-)

Best Regards,
Petr
