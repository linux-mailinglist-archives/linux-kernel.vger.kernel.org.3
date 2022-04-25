Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2C50E433
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiDYPWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiDYPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:21:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01241B8223
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:18:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ACC051F38C;
        Mon, 25 Apr 2022 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650899930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EkBnaufcLFfEkTT9s0vwpbCPqXIXbPR63rO+8FOit3c=;
        b=UPlcn0yOlHK4dfvdW+G0xAtQ6roAOYSlEChpI8+lw8iUuDpnhMiAArDE1epOe+pKrXCQxS
        0e2O+ZM+jamG2B6GNvaHMgf/aZvw7J/Tzjs7VHB+eQ+jOLIJRIUNparywrz7Gypk4ZRZtQ
        eB3NT6CkUdSJ4cZlzcnCj44pxZB/kaA=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5BAEF2C14B;
        Mon, 25 Apr 2022 15:18:50 +0000 (UTC)
Date:   Mon, 25 Apr 2022 17:18:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
Message-ID: <Yma71x2p10d6yOLU@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-15-john.ogness@linutronix.de>
 <20220421124119.GB11747@pathway.suse.cz>
 <875yn2h5ku.fsf@jogness.linutronix.de>
 <YmKnp3Ccu7laW3E4@alley>
 <87o80tp5lv.fsf@jogness.linutronix.de>
 <YmLGfuSV5u7xp5BZ@alley>
 <877d7gu7yg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d7gu7yg.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-04-22 23:31:11, John Ogness wrote:
> On 2022-04-22, Petr Mladek <pmladek@suse.com> wrote:
> > Another problem is that the ordering is not stable. The console
> > might come and go.
> 
> The console list is protected by @console_sem, so it wouldn't be an
> actual problem. The real issue is that lockdep would not like it. A new
> lockdep class would need to be setup for each register_console().

Yeah. I did not mention it explicitely but I meant it as a problem
with lockdep.

> >> Anyway, I will first look into the nested locking solution. That
> >> seems more promising to me and it would go a long way to simplify the
> >> locking hierarchy.
> >
> > Please, do not spend too much time on this. The solution must be
> > simple in principle. If it gets complicated than it will likely
> > be worse than the current code.
> 
> Sure. The goal is to simplify. The only complexity will be doing in a
> way that allow lockdep to understand it.

I am not sure how to distinguish intentional and non-intentional
ordering change.


> > Alternative solution would be to reduce the number of variables
> > affected by the race. I mean:
> >
> >    + replace CON_THB_BLOCKED flag with con->blocked to avoid
> >      the needed of READ_ONCE()/WRITE_ONCE().
> >
> >    + check con->blocked right after taking con->lock in
> >      printk_kthread_func() so that all the other accesses are
> >      safe.
> 
> Honestly, I would prefer this to what v4 is doing. The only reason
> CON_THD_BLOCKED is a flag is to save space. But we are only talking
> about a few bytes being saved. There aren't that many consoles.
> 
> It would be a very simple change. Literally just replacing the 3 lines
> that set/clear CON_THD_BLOCKED and replacing/reordering the 2 lines that
> check the flag. Then all the READ_ONCE/WRITE_ONCE to @flags could be
> removed.

I agree that it sounds like the easiest solution for now. If you
prepare v5 with this change then I push it into linux-next instead
of v4.

Well, I think that we need to make con->lock safe to use in the long
term. The above workaround in printk_kthread_func() is good enough
for now because this is the only location where con->lock is taken without
console_sem. But I am sure that we/people will want to do more
console-specific operations without console_sem in the future.

IMHO, the only sane approach is to follow the proposed rules:

    + console_lock() will synchronize both global and per-console
      stuff.

    + con->lock will synchronize per-console stuff.

    + con->lock could not be taken alone when the big console_lock()
      is taken.


I currently know only about two solutions:

    1. The nested locking. console_lock() will take console_sem
       and all con->lock's and will keep them locked.

       It is rather trivial in principle. The problem is lockdep
       and possible ABBA deadlocks caused by unstable ordering.


    2. Create the wrappers around con->lock that will check
       whether console_sem is taken (con->locked flag).

       It will require additional per-console waitqueue. But all
       the magic will be hidden in the wrappers.


I personally prefer 2nd approach for the long term solution. It might
look more complicated but it will not break lockdep.

Best Regards,
Petr
