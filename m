Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B74496A05
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiAVEeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232303AbiAVEeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642826048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jKIa7CImFTTM4VBT4MgLvf3rD55GTUYAJRDTIjiPvwI=;
        b=Ndw9myMViB/oN4VZbqgmfFMSPJJHjE8eOKAvFW17sWuPs4YVdBYqTEYeqrXlK6EqaEAOkk
        NuSaFsazOE1sIpgVXCgWHrS4wJZAAk+IR1Tyehv87os+AgStDHidXTw077Hxg5FuDAbGVl
        vBawuKrzUttdJxSJnUNg8V0dIiCVZWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-EpHi4ZZWNeyCL9GgSFRtwA-1; Fri, 21 Jan 2022 23:34:02 -0500
X-MC-Unique: EpHi4ZZWNeyCL9GgSFRtwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59F171853022;
        Sat, 22 Jan 2022 04:34:00 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95B394697D;
        Sat, 22 Jan 2022 04:33:53 +0000 (UTC)
Date:   Sat, 22 Jan 2022 12:33:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Petr Mladek <pmladek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Message-ID: <20220122043351.GA2596@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv>
 <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/22 at 03:00pm, Michael Kelley (LINUX) wrote:
> From: Baoquan He <bhe@redhat.com> Sent: Thursday, January 20, 2022 6:31 PM
> > 
> > On 01/20/22 at 06:36pm, Guilherme G. Piccoli wrote:
> > > Hi Baoquan, some comments inline below:
> > >
> > >
> > > On 20/01/2022 05:51, Baoquan He wrote:
> > > > [...]
> > > >> From my POV, the function of panic notifiers is not well defined. They
> > > >> do various things, for example:
> > > >> [...]
> > > >> The do more that just providing information. Some are risky. It is not
> > > >> easy to disable a particular one.
> > > >
> > > > Yes, agree. Not all of them just provide information.
> > > >
> > > > Now panic_notifier_filter Guilherme added can help to disable some of
> > > > them.
> > >
> > > So, just for completeness, worth to mention Petr had some interesting
> > > suggestions in the other thread (about the filter) and we may end-up not
> > > having this implemented - in other words, maybe a refactor of that
> > > mechanism is going to be proposed.
> > 
> > OK, saw that. We can continue discuss that there.
> > 
> > >
> > >
> > > > [...]
> > > >>
> > > >>   + Guilherme uses crash dump only to dump the kernel log. It might
> > > >>     be more reliable than kmsg_dump. In this case, panic_print_sys_info()
> > > >>     is the only way to get the extra information.
> > > >
> > > > Hmm, I haven't made clear what Guilherme really wants in his recent
> > > > post. In this patch he wants to get panic print info into pstore. He
> > > > also want to dump the kernel log poked by panic_print in kdump kernel.
> > > > And it's very weird people try to collect kernel log via crash dump
> > > > mechnism, that is obviously using a sledgehammer to crack a nut.
> > > > Sometime, we should not add or change code to a too specific corner
> > > > case.
> > >
> > > OK, I'll try to be really clear, hopefully I can explain the use case in
> > > better and simpler words. First of all, I wouldn't call it a corner case
> > > - it's just a valid use case that, in my opinion, should be allowed. Why
> > > not, right? Kernel shouldn't push policy on users, we should instead let
> > > the users decide how to use the tools/options.
> > 
> > Agree, sorry about my wrong expression.
> > 
> > >
> > > So imagine you cannot collect a vmcore, due to the lack of storage
> > > space. Yet, you want the most information as possible to investigate the
> > > cause of a panic. The kernel flag "panic_print" is the perfect fit, we
> > > can dump backtraces, task list, memory info...right on a panic event.
> > >
> > > But then, how to save this panic log with lots of information after a
> > > reboot? There are 2 ways in my understanding:
> > >
> > > (a) pstore/kmsg_dump()
> > > (b) kdump
> > >
> > > The option (a) is easily the best - we don't need to reserve lots of
> > > memory, then boot another kernel, etc. This patch (being hereby
> > > discussed) aims to enable the "panic_print" output for this case!
> > > But...there are cases in which option (a) cannot work. We need a backend
> > > of persistent storage, either a block device or, more common, RAM memory
> > > that is persistent across a reboot. What if it's not available?
> > >
> > > Then, we fallback to option (b) - kind of a sledgehammer, in your words heh
> > > It's not ideal, but might be a last resort for users wanting to collect
> > > the most information they can without saving a full vmcore. And for
> > > that, we need to be able to invoke "panic_print" function before the
> > > __crash_kexec() call. Continue below...
> > 
> > OK, pstore via kmsg_dump is first option, then fallback to kdump.
> > This is what I suggested at below. This is what panic notifier has done
> > at below. I think both of them are similar, thus should take the same
> > way to handle.
> > 
> >  void panic()
> >  {
> >          if (!_crash_kexec_post_notifiers && !panic_print) {
> >                  __crash_kexec(NULL);
> >                  smp_send_stop();
> >          } else {
> >                  crash_smp_send_stop();
> >          }
> > 
> >  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >  	panic_print_sys_info(false);
> >  	kmsg_dump(KMSG_DUMP_PANIC);
> >  	if (_crash_kexec_post_notifiers || panic_print)
> >                  __crash_kexec(NULL);
> >  	...
> >  	debug_locks_off();
> >          console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > 
> >          panic_print_sys_info(true);
> >  	......
> >  }
> > > >
> > >
> > > So, your idea is good and it mostly works, except it *requires* users to
> > > make use of "crash_kexec_post_notifiers" in order to use "panic_print"
> > > in the case (b) above discussed.
> > 
> > I don't get. Why it has to *require* users to make use of
> > "crash_kexec_post_notifiers" in order to use "panic_print"?
> > To enable panic notifiers and panic_print, we need add below parameter
> > to kernel cmdline separately.
> > 
> > 	crash_kexec_post_notifiers=1
> >         panic_print=0x7f
> > 
> > With above code, we have:
> > 1) None specified in cmdline, only kdump enabled.
> >    Crash dump will work to get vmcore.
> > 2) crash_kexec_post_notifiers=1 , kdump enabled
> >    panic_notifers are executed, then crash dump
> > 3) panic_print=0x7f, kdump enabled,
> >    Panic_print get system info printed, then crash dump
> > 4) crash_kexec_post_notifiers=1 panic_print=0x7f, kdump enabled
> >    panic_notifers are executed firstly, then panic_print, at last crash dump
> > 
> > Here I don't list the no kdump enabled case. Please help point out if I
> > misunderstood anything.
> > >
> > > Do you think it should be necessary?
> > > How about if we allow users to just "panic_print" with or without the
> > > "crash_kexec_post_notifiers", then we pursue Petr suggestion of
> > > refactoring the panic notifiers? So, after this future refactor, we
> > > might have a much clear code.
> > 
> > I haven't read Petr's reply in another panic notifier filter thread. For
> > panic notifier, it's only enforced to use on HyperV platform, excepto of
> > that, users need to explicitly add "crash_kexec_post_notifiers=1" to enable
> > it. And we got bug report on the HyperV issue. In our internal discussion,
> > we strongly suggest HyperV dev to change the default enablement, instead
> > leave it to user to decide.
> >
> 
> Regarding Hyper-V:   Invoking the Hyper-V notifier prior to running the
> kdump kernel is necessary for correctness.  During initial boot of the
> main kernel, the Hyper-V and VMbus code in Linux sets up several guest
> physical memory pages that are shared with Hyper-V, and that Hyper-V
> may write to.   A VMbus connection is also established. Before kexec'ing
> into the kdump kernel, the sharing of these pages must be rescinded
> and the VMbus connection must be terminated.   If this isn't done, the
> kdump kernel will see strange memory overwrites if these shared guest
> physical memory pages get used for something else.
> 
> I hope we've found and fixed all the problems where the Hyper-V
> notifier could get hung.  Unfortunately, the Hyper-V interfaces were
> designed long ago without the Linux kexec scenario in mind, and they
> don't provide a simple way to reset everything except by doing a
> reboot that goes back through the virtual BIOS/UEFI.  So the Hyper-V
> notifier code is more complicated than would be desirable, and in
> particular, terminating the VMbus connection is tricky.
> 
> This has been an evolving area of understanding.  It's only been the last
> couple of years that we've fully understood the implications of these
> shared memory pages on the kexec/kdump scenario and what it takes
> to reset everything so the kexec'ed kernel will work.

Glad to know these background details, thx, Michael. While from the
commit which introduced it and the code comment above code, I thought
Hyper-V wants to collect data before crash dump. If this is the true,
it might be helpful to add these in commit log or add as code comment,
and also help to defend you when people question it.

int __init hv_common_init(void)
{
        int i;

        /*
         * Hyper-V expects to get crash register data or kmsg when
         * crash enlightment is available and system crashes. Set
         * crash_kexec_post_notifiers to be true to make sure that
         * calling crash enlightment interface before running kdump
         * kernel.
         */
        if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
                crash_kexec_post_notifiers = true;

	......
}

