Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65F50A224
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389193AbiDUO15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388932AbiDUO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:27:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96A6417
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:25:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D162D219C0;
        Thu, 21 Apr 2022 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650551103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/eDd2H2eMfs8iv2QJAcrWjYCvi80KMXhSt779nfBRI=;
        b=MtXep0i/lMVQAg9XE9xdwqvQOPPJ+CkoX4zn4z7Cs7YH94yIRXxWdp1KS1pb0kcbW9MvRZ
        W/yoFMnNWAPoMOC6StCCvuLcajD4sKl44zxZztjc7+AzsCClOmkBPAyy0B13FWt6aiWSQk
        JsXNgXFBpAHg7BLJuUPFDg8baxoJqRY=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A8D502C146;
        Thu, 21 Apr 2022 14:25:03 +0000 (UTC)
Date:   Thu, 21 Apr 2022 16:25:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH printk v3 13/15] printk: add kthread console printers
Message-ID: <20220421141921.GD11747@pathway.suse.cz>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-14-john.ogness@linutronix.de>
 <YmBIr1mkmIN1Zkb+@alley>
 <87h76nwmjk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h76nwmjk.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 22:08:39, John Ogness wrote:
> On 2022-04-20, Petr Mladek <pmladek@suse.com> wrote:
> > On Wed 2022-04-20 01:52:35, John Ogness wrote:
> >> @@ -2280,10 +2295,10 @@ asmlinkage int vprintk_emit(int facility, int level,
> >>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
> >>  
> >>  	/* If called from the scheduler, we can not call up(). */
> >> -	if (!in_sched) {
> >> +	if (!in_sched && allow_direct_printing()) {
> >
> > allow_direct_printing() is racy here. But I think that we could live
> > with it, see below.
> 
> Well, it is not racy for its intended purpose, which is a context that
> does:
> 
> printk_prefer_direct_enter();
> printk();
> printk_prefer_direct_exit();
> 
> It is only racy for _other_ contexts that might end up direct
> printing. But since those other contexts don't have a preference, I see
> no problem with it.

Make sense.

Let me think more about it. To be sure that we see all aspects:

There are also other system wide variables checked by
allow_direct_printing() and can be modified asynchronously:

	+ printk_kthreads_available
	+ system_state
	+ oops_in_progress

"oops_in_progress" and "system_state" are similar to
"printk_prefer_direct". The context that modifies this
variable will see the right value. The other contexts
do not care that much and do not need to be strictly
synchronized. Also the value means that the direct
mode is preferred but it is never guaranteed and
never was.

"printk_kthreads_available" is more tricky.
__printk_fallback_preferred_direct() causes that printk kthreads
will not be used any longer. It should make sure that the pending
messages will be printed directly. And it works because
it is called under console_lock and the pending messages
will be printed by the console_unlock().

Everything looks fine after all. I wonder if we could somehow
document it somewhere. I think about adding a comment
above allow_direct_printing() definition:

/*
 * printk() always wakes printk kthreads so that they could
 * flush the new message to the consoles. Also it tries
 * the flush the messages directly when it is allowed.
 *
 * The direct priting is allowed in situations when the kthreads
 * are not available or the system is in a problematic state.
 *
 * See the implementation about possible races.
 */
static inline bool allow_direct_printing(void)
{
	/*
	 * The kthreads are disabled under console_lock.
	 * Any pending messages will be handled by
	 * console_unlock().
	 */
	if (!printk_kthreads_available)
		return false;

	/*
	 * Prefer direct printing when the system is in a problematic
	 * state. The context that sets this state will always see
	 * the updated value. The other contexts do not care that
	 * much. Anyway, it is just a best effort. The direct output
	 * is possible only when console_lock is not already taken.
	 */
	return (system_state > SYSTEM_RUNNING ||
		oops_in_progress ||
		atomic_read(&printk_prefer_direct));
}

Best Regards,
Petr
