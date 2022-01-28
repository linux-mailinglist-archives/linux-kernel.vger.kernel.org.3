Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4852D49FAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349019AbiA1Nib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:38:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41518 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349026AbiA1Ni1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:38:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DF166210FE;
        Fri, 28 Jan 2022 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643377106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EmJPFIB+FsC4z+ugXI4cPVnGkYC2PBBR99Rss9L6Q+4=;
        b=bBUB0y/R6rNG+iKcq19eYcVtwpNXFY82mKIIuqiAS6RZdfbTdhIcwbV03YomD1RuQH4JkJ
        kUobTfJYpqotxGSvklXnc3KizmVMHbsGVoelRkRS+bK2vKzpy9OAUAgSZxeljj8anO4NvO
        A5CVTdJ0yFXg9OJ+cjg34iCx3F52ub8=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8282EA3B88;
        Fri, 28 Jan 2022 13:38:26 +0000 (UTC)
Date:   Fri, 28 Jan 2022 14:38:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <YfPxvzSzDLjO5ldp@alley>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-27 14:16:20, Guilherme G. Piccoli wrote:
> On 25/01/2022 10:06, d.hatayama@fujitsu.com wrote:
> > 
> > But the pre_dump cannot avoid calling multiple unnecessary handlers, right?
> > It's more risky than the previous idea...
> > 
> 
> I think we could have 2 kernel parameters then:
> 
> crash_kernel_disable_pre_notitifers (of course we can think in some
> better name here heh)
> 
> crash_kernel_enable_post_notifiers (which is the same as the current
> "crash_kernel_post_notifiers", we can keep it)
> 
> The point being (if I understand correctly): some callbacks are really
> simple and don't introduce risks for kdump, like the RCU; a bunch of
> them just set one variable. Those could be enable by default, before the
> kdump.
> 
> The majority would fit in the 2nd group, meaning they are not enabled by
> default, requiring some parameter for that.
> 
> Petr, let me know if that makes sense and is aligned with your suggestion.

First, I am sorry for the very long mail. But the problem is really
complicated. I did my best to describe it a clean way.

I have discussed these problems with a colleague and he had some good
points. And my view evolved even further.

There are two groups of people interested in panic() behavior:

1. Users wants to get as reliable as possible: kdump, kmsg_dump,
   console log, useful last message on screen, reboot, hypervisor
   notification.

   Different users have different priorities according to the use case.


2. Subsystem maintainers and developers that need to do something
   special in panic(). They have to deal with the user requirements
   and bug reports.

   Most operations in panic() have unclear results because the system
   is in unclear state. Maintainers and developers wants to make their
   life easier. They do not want to deal with problems caused by
   others. So that they want to disable others or run as early as
   possible.

   It is nicely visible. kdump maintainer is afraid of calling
   anything before kdump. Many people support the idea of filtering
   because it moves problems to the user side.


I see two basic problems here: ordering and reliability:

1. Ordering problems are partly solved by configuration and partly by
   definition. I mean that:

      + kdump, kmsg_dump, panic_print_sys_info() are optional
      + console output is the best effort; more risky in final flush
      + reboot, infinite loop are the very last step

   IMHO, the ordering should be pretty clear:

      + panic_print_sys_info(), kmsg_dump(), kdump(), console flush, reboot

   Why?

      + panic_print_sys_info(), kmsg_dump(), kdump() are all optional
	   and disabled by default
      + Users might want panic_print_sys_info() in kmsg_dump() and kdump()
      + Users might prefer kmsg_dump() over kdump()
      + kdump() is the last operation when enabled

   Where are panic notifiers in this picture?
   Where are CPUs stopped?


2. Reliability is the best effort and any subsystem should do its
   best.

   Users need to be aware (documentation, warning) that:

      + kmsg_dump() is less reliable when panic_print_sys_info() is enabled
      + kdump() is less reliable when panic_print_sys_info() and/or
	kmsg_dump() is enabled.

   Where are panic notifiers in this picture?
   How stopped CPUs affect reliability?


Regarding panic notifiers. They look like a problematic black box:

    + ordering against other operations is not clear
    + are not safe enough
    + various users require some and do not need others
    + some are too complex so that only few people know what
      they do


So far, we have two proposals how to handle panic notifiers:

1. Allow to filter them with parameter:

     + pros:
	+ it allows users to customize and work around problems

     + cons:
	+ ordering is still not clear

	+ user has to know what he does; note that sometimes only
	  few people know what their notifier does

	+ hard to use in the long term; callbacks names are
	  implementation detail; new notifiers are added

	+ lower motivation to solve problems; easy to wave them with
	  "just disable it when it does not work for you..."


2. Split notifiers into more lists:

    + pros:
	+ might solve ordering problems

	+ subsystem maintainers could find the proper and more safe
	  location


    + cons:
	+ subsystem maintainers tend to think that their problem is
	  the most important one; they will tend to do the operation
	  as early as possible; so that even dangerous operations
	  might be done early  => the original problem is still there

	+ it might not motivate developers enough to make the notifiers as
	  safe as possible

	+ some might still need to be optional; for example, it should
	  be possible to disable hypervisor notifier when it breaks
	  kdump


Regarding stopped CPUs, it looks like a good idea most of the time:

    + They should stop all tasks and reduce further damage of the
      system.

    + It should also reduce noise (messages) produced by other CPUs.

    + But a special handling is needed when it is done before crash
      dump.


Sigh, it looks really really complicated. We should be careful.

OK, the original problems are:

   + allow to call this order: panic_print_sys_info(), kmsg_dump(), kdump()
   + make it more safe with problematic notifiers


My opinion:

   + allow the desired ordering makes sense

   + something should be done with notifiers:

       + adding filer looks like a workaround that is not much
	 usable; it is not easy to use; it does not motivate people
	 fix problems so that is might make things worse in
	 the long term

       + splitting might make sense but it is not clear how

       + some notifiers make always sense before kmsg_dump;
	 some should be optional

   + we need a compromise to keep the panic() code sane and can't
     support all combinations


I think about the following solution:

    + split the notifiers into three lists:

	+ info: stop watchdogs, provide extra info
	+ hypervisor: poke hypervisor
	+ reboot: actions needed only when crash dump did not happen

    + allow to call hypervisor notifiers before or after kdump

    + stop CPUs before kdump when either hypervisor notifiers or
      kmsg_dump is enabled

Note that it still allows to call kdump as the first action when
hypervisor notifiers are called after kdump and no kmsg dumper
is registered.


void panic(void)
{
	[...]

	if (crash_kexec_post_hypervisor || panic_print || enabled_kmsg_dump()) {
		/*
		 * Stop CPUs when some extra action is required before
		 * crash dump. We will need architecture dependent extra
		 * works in addition to stopping other CPUs.
		 */
		 crash_smp_send_stop();
		 cpus_stopped = true;
	}

	if (crash_kexec_post_hypervisor) {
		  /* Tell hypervisor about the panic */
		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
	}

	if (enabled_kmsg_dump) {
		  /*
		   * Print extra info by notifiers.
		   * Prevent rumors, for example, by stopping watchdogs.
		   */
		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
	}

	/* Optional extra info */
	panic_printk_sys_info();

	/* No dumper by default */
	kmsg_dump();

	/* Used only when crash kernel loaded */
	__crash_kexec(NULL);

	if (!cpus_stopped) {
		/*
		 * Note smp_send_stop is the usual smp shutdown function, which
		 * unfortunately means it may not be hardened to work in a
		 * panic situation.
		 */
		smp_send_stop();
	}

	if (!crash_kexec_post_hypervisor) {
		  /* Tell hypervisor about the panic */
		  atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
	}

	if (!enabled_kmsg_dump) {
		  /*
		   * Print extra info by notifiers.
		   * Prevent rumors, for example, by stopping watchdogs.
		   */
		  atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
	}

	/*
	 * Help to reboot a safe way.
	 */
	atomic_notifier_call_chain(&panic_reboot_notifier_list, 0, buf);

	[...]
}

Any opinion?
Do the notifier list names make sense?

Best Regards,
Petr

PS: I have vacation the following week. I'll continue in the
    discussion when I am back.
