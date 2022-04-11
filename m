Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC14FB9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbiDKKrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345702AbiDKKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:47:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FAE12AFC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:45:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F24411F7AC;
        Mon, 11 Apr 2022 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649673924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVUYTB3WUBI3nipWSQVbDluR/gCziMt65ki2FyAL220=;
        b=EvQfgf2H+f8wmc3qTwFQQ/mf95NCQovHsr09zTZw65SjomlzxNHdni9o8lyDTitv+dzXK9
        hGiKYejR/ya+WRC9qsG2oaiyWcPTRKyIaC2eTVX7fEz8TKAnFt7A8XqeZBi0iTXPkyRTi/
        Q/2OEJd3eQJfIcPYsmNBPOw8grSPRRs=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A9BC2A3B92;
        Mon, 11 Apr 2022 10:45:23 +0000 (UTC)
Date:   Mon, 11 Apr 2022 12:45:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: guarantee forward progress: was: Re: [PATCH printk v2 11/12]
 printk: extend console_lock for proper kthread support
Message-ID: <YlQGwNi2yB8WFaVM@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-12-john.ogness@linutronix.de>
 <YlA8jpuziDrD27A2@alley>
 <87v8vjnxdg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8vjnxdg.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-04-08 22:23:15, John Ogness wrote:
> On 2022-04-08, Petr Mladek <pmladek@suse.com> wrote:
> > I played a lot with it and it is really hard because:
> >
> >    + new messages can appear anytime
> >    + direct mode might get requested anytime
> >    + only the direct mode knows whether all messages were flushed
> >      on all consoles
> 
> Yes, and this is why v1 dramatically simplified the picture by making
> kthreads not care about direct mode. In v1 the kthread logic is very
> simple: If there are messages to print, try to print them no matter
> what. We didn't need to worry if someone was printing, because we knew
> that at least the kthread was always printing.
> 
> This meant that there would be times when direct mode is active but the
> kthreads are doing the printing. But in my experimenting, that tends to
> be the case anyway, even with this more complex v2 approach. The reason
> is that if some code does:
> 
> printk_prefer_direct_enter();
> (100 lines of printk calls)
> printk_prefer_direct_exit();
> 
> And directly before that printk_prefer_direct_enter() _any_ kthread was
> already inside call_console_driver(), then _all_ the console_trylock()
> calls of the above 100 printk's will fail. Inserting messages into the
> ringbuffer is fast and any active printer will not have finished
> printing its message before the above code snippet is done.

Good to know.

> In fact, the above snippet will only do direct printing if there were
> previously no unflushed messages. That is true for v1 (by design) and v2
> (by misfortune, because ringbuffer insertion is much faster than a
> single call_console_driver() call).

Yup.

> This new idea (v2) of trying to stop kthreads in order to "step aside"
> for direct printing is really just adding a lot of complexity, a lot of
> irqwork calls, and a lot of races. And with my experimenting I am not
> seeing any gain, except for new risks of nobody printing.
> 
> I understand that when we say printk_prefer_direct_enter() that we
> _really_ want to do direct printing. But we cannot force it if any
> printer is already inside call_console_driver(). In that case, direct
> printing simply will not and cannot happen.

I think that we should split it into situations when we need the
direct printk and where we prefer the direct printing.

1. The direct printing is needed in situations when the kthreads can't
   work by design, e.g. early boot, panic, suspend, reboot.

   This was the reason why I wanted to increase the chance that
   kthreads would not block it. But as you write above, it does
   not help much. The consoles are so slow that the direct mode
   is not used.

   It is clear that my proposal does not work. And it is not
   reliable anyway. This patchset actually takes care of some
   situations much better way, by calling pr_flush() in console_stop()
   or suspend_console().


2. The direct printing is only preferred in some situations where
   the system is in troubles, for example, stall reports.

   The direct mode is preferred because we think that it will be
   more reliable. It is a conservative thinking. But in fact,
   the kthreads might provide better results in many situations.

   These stall reports often print a lot of debugging information.
   The direct mode might cause soft-lockups and stalls on its own.
   The kthreads allow showing the messages faster on fast consoles.

   I could imagine that we actually remove the direct mode for
   these stall reports in the future.

   Anyway, it is perfectly fine to print them using kthreads
   when the kthreads are working.


> For v3 I recommend going back to the v1 model, where kthreads do not
> care if direct mode is preferred. I claim that v2 does yield any more
> actual direct printing than v1 did.

I agree.

> However, I would keep the v2 change that kthreads go into their
> wait_event check after every message. That at least provides earlier
> responses for kthreads to stop themselves if they are disabled.

I am not sure what you mean. They seems to be completely disabled
only when newly registered console is not able to create the kthread
or when the kthread is not able to allocate buffers.

I think that there is no hurry to stop the other kthreads in this
case.

Or do you mean panic?

> Once we have atomic consoles, things will look different. Then we
> perform true synchronous direct printing. But without them, the "prefer"
> in printk_prefer_direct_enter() is only a preference that can only be
> satisfied under ideal situations (i.e. no kthread is inside
> call_console_driver()).

OK.

Best Regards,
Petr
