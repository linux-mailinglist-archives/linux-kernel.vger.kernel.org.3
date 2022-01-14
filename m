Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC45648E9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiANM0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:26:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46006 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbiANM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:26:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CC7AD21995;
        Fri, 14 Jan 2022 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642163212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FKY5OS8cYg5DAHvwLUhsHaD7LBWzxeEJ9udOdcFioc=;
        b=A+18NqmM1Geo8fvTEgMWOq0H9obdjOZmE7JiZJQJWVs6EdBI+OFfj6bCpzRNP7RWit3prU
        h/GBRcbWLVpyRrbyqBbAm+wpmeb4z3Lkrv2jO7YW5r/Nzt7SNBMnRPoxyFZJzMRK2HmYx8
        FgCQq5PeLyWVugVTewKNRkumTCd2O+Q=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64599A3B85;
        Fri, 14 Jan 2022 12:26:51 +0000 (UTC)
Date:   Fri, 14 Jan 2022 13:26:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH V2] panic: Move panic_print before kmsg dumpers
Message-ID: <20220114122651.GB17817@pathway.suse.cz>
References: <20220106212835.119409-1-gpiccoli@igalia.com>
 <Yd/0K1x7ILw3Qa46@alley>
 <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
 <YeA1pXz7f0wqSnah@alley>
 <f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-13 12:15:08, Guilherme G. Piccoli wrote:
> On 13/01/2022 11:22, Petr Mladek wrote:
> > [...]
> > OK, do we have any specific reason why panic_print_sys_info()
> > should get called right before kmsg_dump() when this code patch
> > is used?
> > 
> > Alternative solution would be to remove the check of
> > kexec_crash_loaded() and always call panic_print_sys_info(false)
> > at the beginning (after kgdb_panic(buf)).
> > 
> > The advantage is that panic_print_sys_info(false) will be always
> > called on the same location. It will give the same results
> > in all code paths so that it will be easier to interpret them.
> > And it will have the same problems so it should be easier
> > to debug and maintain.
> > 
> > It is possible that it will not work for some users. Also it is
> > possible that it might cause some problems. But it is hard to
> > guess at least for me.
> > 
> > I think that we might try it and see if anyone complains.
> > Honestly, I think that only few people use panic_printk_sys_info().
> > And your use-case makes sense.
> > 
> > Best Regards,
> > Petr
> 
> Hi Petr, thanks for your idea - it's simple and effective, would resolve
> the problems in a straightforward way. But there are some cons, let me
> detail more.
> 
> Currently (in linux-next), if users set panic_print but not kdump, the
> panic_print_sys_info() is called *after* the panic notifiers. If user
> has kdump configured and still sets panic_print (which is our use case),
> then panic_print_sys_info() is called _before_ the panic notifiers. In
> other words, the behavior for non-kdump users is the same as before,
> since the merge of panic_print functionality.
> 
> Your idea brings the printing earlier, always before the panic
> notifiers. This isn't terrible, but might lead to unfortunate and
> hard-to-debug problems; for example, some panic notifiers are
> rcu_panic() and hung_task_panic(), both are simple functions to disable
> RCU warnings and hung task detector in panic scenarios. If we go with
> your idea, these won't get called before panic_print_sys_info(), even if
> kdump is not set. So, since the panic_print triggers a lot of printing
> in the console, we could face a stall and trigger RCU messages, maybe
> intermixed with the panic_print information.

I see. OK, it makes sense to call it after the panic notifiers when
they are used. It would be nice to mention the above in the commit
message and explain why the 2nd call is there.

Just an idea. It might be better to move the 1st call below
if (!_crash_kexec_post_notifiers). It would make it more
clear that it is intended for this code path. I mean:

	if (!_crash_kexec_post_notifiers) {
		/* ... */
		if (kexec_crash_loaded())
			panic_print_sys_info(false);

		__crash_kexec(NULL);
	...

Best Regards,
Petr
