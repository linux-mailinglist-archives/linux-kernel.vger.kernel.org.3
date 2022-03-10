Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116D34D4E33
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbiCJQJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiCJQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:09:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138413859A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:08:20 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646928498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hr+m6fRu/g1wdrMoiOwPUFJNQ6DkCbll2sk1K5dMoDc=;
        b=0uoKfsCfbpL9j+kiWHu/ot32XJZkds2YHbxwl2MhqJ4RKM+028bnTqGQvv0+Fz91W5BooI
        BSKE4NdBYLQBjpKR9ADXVpJLUaiOvdoZWkEv883wHl3DJz5uR0aamIdT84y0F+pPacpjXE
        kMhqtnqGxiVQWGNVNekfP4D/kAODq2wHi1Gk8yiwsW8aEpV8HCP9fueHwKSPtC16Pc6iuM
        sOzXrL2gSBLkdf50GDF57nJ80rwHHUq9HALZVRNatZ8eptaeuGT9WLJMneMkf1JUGrbA8R
        R66SIEuGf8fBfH//5FnSNsoXqeY4oHO4cjhDq2nhm/ZVba+tzGvBJPVwb59y1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646928498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hr+m6fRu/g1wdrMoiOwPUFJNQ6DkCbll2sk1K5dMoDc=;
        b=yAg9m2XaiUqFUGiHKUnkWIBFeqDWjmZu6dlfcIy5zuiB3HBLB1ahfrxmwNuhLeon893fwL
        2xwk660N5UQbQTAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
In-Reply-To: <YioMcSe0P0Z7ksiW@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley> <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley>
Date:   Thu, 10 Mar 2022 17:14:18 +0106
Message-ID: <87wnh14wp9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-10, Petr Mladek <pmladek@suse.com> wrote:
>    console_unlock()
>    {
> 	  [...]
> 	  if (may_schedule)
> 	      retry = console_trylock_sched();
> 	  else
> 	      retry = console_trylock();
>    }

I believe the main confusion comes from the function name I chose and
the poor function description. Using your above code idea and changing
to a more fitting name, I would suggest:

    console_unlock()
    {
 	  [...]
 	  if (may_schedule)
 	      retry = console_lock_reacquire();
 	  else
 	      retry = console_trylock();
    }

This console_lock_reacquire() acquires the console lock the same way
that console_lock() does it. The only reason we don't just use
console_lock() is because we want to perform a try on @console_sem. But
if we are successful, in the end, we have re-taken the console lock
exactly as console_lock() did before: @console_sem locked, kthreads
blocked by mutex.

You say this creates deadlock potential, but I do not see how that could
be. We are in the same context and locking the same way we did before.

But my primary concern is not the naming or workarounds or confusing
APIs. So we should not let ourselves be diverted by that aspect.

My primary concern is the technical difference when a schedulable
context reacquires via atomic counter (which fails if any kthread is
active) vs. reacquiring via mutex (which never fails).

The reason for the reacquire is because (during direct printing) we see
that a new record appeared and we need to make sure it gets printed
(because other direct printers may have aborted, expecting us to print
it).

This scenario is only interesting if kthread printers exist because
otherwise @console_sem is enough to handle the direct printing.

So the questions are:

1. Is it OK to assume the new record will be printed if any kthread is
active? If yes, then it is enough to use the atomic counter.

2. Or, since we are responsible for direct printing, do we want to be
certain that the record is printed by printing it ourselves? If yes,
then we must block all the kthreads and perform the printing directly to
all the consoles. This requires the mutex approach.

IMHO #1 will relies heavily on kthreads waking up and printing (even
though the printk caller requested direct printing), whereas #2 will
cause direct printers to more actively print (possibly printing more
than was requested).

I prefer to go the route of #2 because it is more conservative. IMHO,
when direct printing becomes active, we really should make a strong
effort to direct print.

Having now stated the issues (hopefully clearly), I will not fight for
#2. If you say it is enough to rely on the kthreads in this scenario,
then I will implement the atomic counter solution for my v2.

John
