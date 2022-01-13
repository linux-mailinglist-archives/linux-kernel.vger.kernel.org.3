Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0348D9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiAMOWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:22:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37540 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiAMOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:22:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E4D21F3BC;
        Thu, 13 Jan 2022 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642083750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iyvqg/dBXTkYBEXdGm9XZJEu9w+DMloEYh8FExa/h6k=;
        b=IXBVlqj6nBc2M94zAKEdE7uSiJV4VfLqm6EJDEKI+9RgOhbCjzbdJoP71t4eK6l9OpwRDw
        Mh2ZQ5RJYNADEHO0XoHcDCwckv3dstu+TUTwgj6mND/yoF5oobAP3JXEzSsBGL2TrEH6v6
        JS5c9U0ZI9NdU7l/QX0te9RZ5IlsF4w=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D152A3B84;
        Thu, 13 Jan 2022 14:22:29 +0000 (UTC)
Date:   Thu, 13 Jan 2022 15:22:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH V2] panic: Move panic_print before kmsg dumpers
Message-ID: <YeA1pXz7f0wqSnah@alley>
References: <20220106212835.119409-1-gpiccoli@igalia.com>
 <Yd/0K1x7ILw3Qa46@alley>
 <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-13 09:34:01, Guilherme G. Piccoli wrote:
> On 13/01/2022 08:50, Petr Mladek wrote:
> >> @@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
> >>  	 * show some extra information on kernel log if it was set...
> >>  	 */
> >>  	if (kexec_crash_loaded())
> >> -		panic_print_sys_info();
> >> +		panic_print_sys_info(false);
> > 
> > panic_print_sys_info(false) will be called twice when both
> > kexec_crash_loaded() and _crash_kexec_post_notifiers are true.
> > 
> > Do we really need to call panic_print_sys_info() here? All information
> > provided by panic_print_sys_info(false) can be found also in
> > the crash dump.
> > 
> >>  	/*
> >>  	 * If we have crashed and we have a crash kernel loaded let it handle
> >> @@ -283,6 +286,8 @@ void panic(const char *fmt, ...)
> >>  	 */
> >>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >>  
> >> +	panic_print_sys_info(false);
> > 
> > This is where the info might be printed 2nd time.
> > 
> >> +
> >>  	kmsg_dump(KMSG_DUMP_PANIC);

> Thanks for catching this issue - indeed, if
> "_crash_kexec_post_notifiers" is true, with this patch we print stuff
> twice. I will submit a V3 that guards against that, using a bool, makes
> sense to you?

It might be possible to check kexec_crash_loaded() on the two
locations. But I think about even easier solution, see below.


> The interesting question here is:
> > Do we really need to call panic_print_sys_info() here? All information
> > provided by panic_print_sys_info(false) can be found also in
> > the crash dump.
> 
> So, we indeed need that in our use case. Crash is meant to be used
> post-mortem, i.e., you made a full vmcore collection and then, of
> course, you have basically all the data you need accessible though the
> crash tool.
> 
> Problem is: in our use case, we want more data than a regular dmesg in a
> panic event (hence we use panic_print), but we don't collect a full
> crash dump, due to its big size. Also, as you can imagine, we do favor
> pstore over kdump, but it might fail due to a variety of reasons (like
> not having a free RAM buffer for ramoops), so kdump is our fallback.
> Hence, we'd like to be able to use panic_print with both kdump and
> pstore, and for that, both patches are needed.

Fair enough.

OK, do we have any specific reason why panic_print_sys_info()
should get called right before kmsg_dump() when this code patch
is used?

Alternative solution would be to remove the check of
kexec_crash_loaded() and always call panic_print_sys_info(false)
at the beginning (after kgdb_panic(buf)).

The advantage is that panic_print_sys_info(false) will be always
called on the same location. It will give the same results
in all code paths so that it will be easier to interpret them.
And it will have the same problems so it should be easier
to debug and maintain.

It is possible that it will not work for some users. Also it is
possible that it might cause some problems. But it is hard to
guess at least for me.

I think that we might try it and see if anyone complains.
Honestly, I think that only few people use panic_printk_sys_info().
And your use-case makes sense.

Best Regards,
Petr
