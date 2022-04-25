Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA650E935
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbiDYTNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbiDYTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:13:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E95D2B25A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:10:40 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650913838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L41gHX7giqEbMRqNNdCOl45oCLF5ROcbT3S6w2zPHn4=;
        b=CehTB31JXRj3zUOI56Kvn9FM2uNoerg49reH2BZObASzxzM1xQlf9BWx4muOIMLci+/Z0Q
        gO753uYKAoDoxRZ239e0DxYosmjVNsY4clx5qe5tv6InaWHsKmoeJ8wi5z/NCvZ3sKm9+0
        ZXUkSlsTvh29/bQXa+K9ZTbUwaiQ9sT8Wy3CnuuSVlB5QfeM+s2pt76mQVeOuYHjNRJ15J
        Lf3VwPentc7sKw/J+vWrH4o9EglxuFlkgFI4LGHW0/LKB/xP/1I91NvN8id7mZF9gCeb1J
        x+YK9SpQS8DpRrP6Oo0L95tz1Yp4iFNtPKHuNEmwywk8x1Ih3mPVl79vcj+qqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650913838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L41gHX7giqEbMRqNNdCOl45oCLF5ROcbT3S6w2zPHn4=;
        b=XvPD+mfiufvtlHMquHmmD/qAOoQxNxenT1YjjhrczR1qNj8MCmgn+eZLjz1cIJXf1KSYGT
        Jq+Y6sVaNinGRICg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
In-Reply-To: <Yma71x2p10d6yOLU@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-15-john.ogness@linutronix.de>
 <20220421124119.GB11747@pathway.suse.cz>
 <875yn2h5ku.fsf@jogness.linutronix.de> <YmKnp3Ccu7laW3E4@alley>
 <87o80tp5lv.fsf@jogness.linutronix.de> <YmLGfuSV5u7xp5BZ@alley>
 <877d7gu7yg.fsf@jogness.linutronix.de> <Yma71x2p10d6yOLU@alley>
Date:   Mon, 25 Apr 2022 21:16:37 +0206
Message-ID: <87czh5568i.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-25, Petr Mladek <pmladek@suse.com> wrote:
>> Honestly, I would prefer this to what v4 is doing. The only reason
>> CON_THD_BLOCKED is a flag is to save space. But we are only talking
>> about a few bytes being saved. There aren't that many consoles.
>> 
>> It would be a very simple change. Literally just replacing the 3 lines
>> that set/clear CON_THD_BLOCKED and replacing/reordering the 2 lines that
>> check the flag. Then all the READ_ONCE/WRITE_ONCE to @flags could be
>> removed.
>
> I agree that it sounds like the easiest solution for now. If you
> prepare v5 with this change then I push it into linux-next instead
> of v4.

I will send a v5 only for that patch. I will make it a reply to the same
v4 patch.

> Well, I think that we need to make con->lock safe to use in the long
> term. The above workaround in printk_kthread_func() is good enough
> for now because this is the only location where con->lock is taken without
> console_sem. But I am sure that we/people will want to do more
> console-specific operations without console_sem in the future.
>
> IMHO, the only sane approach is to follow the proposed rules:
>
>     + console_lock() will synchronize both global and per-console
>       stuff.
>
>     + con->lock will synchronize per-console stuff.
>
>     + con->lock could not be taken alone when the big console_lock()
>       is taken.
>
>
> I currently know only about two solutions:
>
>     1. The nested locking. console_lock() will take console_sem
>        and all con->lock's and will keep them locked.
>
>        It is rather trivial in principle. The problem is lockdep
>        and possible ABBA deadlocks caused by unstable ordering.
>
>
>     2. Create the wrappers around con->lock that will check
>        whether console_sem is taken (con->locked flag).
>
>        It will require additional per-console waitqueue. But all
>        the magic will be hidden in the wrappers.
>
>
> I personally prefer 2nd approach for the long term solution. It might
> look more complicated but it will not break lockdep.

The 2nd approach doesn't break lockdep because it is hiding from it. We
are basically open coding our own blocking lock mechanism that avoids
looking like nested locking.

If using nested locking is the best technical solution, then we should
not let lockdep prevent us from using that solution.

You talk about ABBA deadlocks due to unstable ordering, but I still do
not see how that is possible with the @console_sem protection. Unless
you are talking about some code that is trying to lock multiple consoles
at once without taking the console_lock. That would need to be forbidden
by the API.

My main concern with nested locking (aside from lockdep complexities) is
the console suspension. That is a bizarre state where @console_sem is
released even though the console is in a type of frozen state. It is
tricky/messy, especially since the kthreads need to remain silent in
this state. I suppose the kthreads would also need to be unlocked in
suspend_console() and the kthreads would respect @console_suspended and
go back to sleep (similar to how CON_THD_BLOCKED is now).

John
