Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7464F9D63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiDHS7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiDHS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:59:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E6E1275F9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:57:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649444224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UZTCsxkfN4cLQjQQMipDMUKyv6xpjcMGR/3KuPvhgrU=;
        b=2Vlvi1ZhI26g7aWcvLJCwkbRMzU3WP8N9ESn5VeMTJIXAfgAquANSg6WR7wpcNiSKb1wZ3
        Nt/hDwSYPGANd0iIPWmrIcJAJYXER/nQBR8jka9W2kh7DDIVxqreOHnRRwKyhhVzZnT9cU
        X+M238SdKKqq7Iu7kN8RI6ZHnb8DMxXzaXRwcnxB7DmgYG1F/QsCg4xKTBojE2Mhisqt84
        joww3vP3kTkkaKEfs7howKQAPaa20SH/MnqH+8mzaeGtwffEtdnJQvqA/9VB3gXgFCs0LP
        gFX86HvNGNMUgW9eh8cszdWGcohMB+3soP4QtVz0L2NaRLo6ZAAQTP30j7sOTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649444224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UZTCsxkfN4cLQjQQMipDMUKyv6xpjcMGR/3KuPvhgrU=;
        b=LROaOpBXzIrGCYNWrl8RGMl+H9gJQ2jQNt34x4R6dZYAJ0LqovRkZ7PZc76OkQFaM/Hbtc
        keWAPh0Zxxx3j3Cg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 08/12] printk: add pr_flush()
In-Reply-To: <Yk2u7dgm2VQk1DGn@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-9-john.ogness@linutronix.de>
 <Yk2u7dgm2VQk1DGn@alley>
Date:   Fri, 08 Apr 2022 21:03:03 +0206
Message-ID: <87y20fo134.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-06, Petr Mladek <pmladek@suse.com> wrote:
>> @@ -3321,6 +3331,79 @@ static int __init printk_late_init(void)
>>  late_initcall(printk_late_init);
>>  
>>  #if defined CONFIG_PRINTK
>> +/* If @con is specified, only wait for that console. Otherwise wait for all. */
>> +static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
>> +{
>> +	int remaining = timeout_ms;
>> +	struct console *c;
>> +	u64 last_diff = 0;
>> +	u64 printk_seq;
>> +	u64 diff;
>> +	u64 seq;
>> +
>> +	might_sleep();
>> +
>> +	seq = prb_next_seq(prb);
>
> I suggest to add here:
>
> 	/*
> 	 * Try to flush the messages when kthreads are not available
> 	 * and there is not other console lock owner.
> 	 */
> 	if (console_trylock())
> 		console_unlock()

At this point in the series, we do not have kthreads yet. ;-)

And besides, you are implying that there are messages in the ringbuffer,
but _nobody_ is printing them. That would be a bug in our
implementation.

>> +
>> +	for (;;) {
>> +		diff = 0;
>> +
>> +		console_lock();
>> +		for_each_console(c) {
>> +			if (con && con != c)
>> +				continue;
>> +			if (!console_is_usable(c))
>> +				continue;
>> +			printk_seq = c->seq;
>> +			if (printk_seq < seq)
>> +				diff += seq - printk_seq;
>> +		}
>> +		console_unlock();
>
> This is a bit sub-optimal when the kthreads are not available or
> are disabled. In this case, the messages are flushed [*] by
> the console_unlock() and the diff is outdated.

The messages must be flushed by another context. It is wrong to rely on
this context to do the flushing. In direct mode, those messages should
have been flushed before the above console_lock() succeeded. Otherwise
it is a bug. (For threaded mode, console_unlock() does not flush
anyway.)

> Well, it is ugly to keep it this way.

If you don't mind, I will not change this function for v3. I do not want
to start sprinkling console_trylock()/console_unlock() calls all over
the code to cover up possible bugs and races in the implementation.

John
