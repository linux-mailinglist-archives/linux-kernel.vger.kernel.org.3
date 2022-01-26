Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24349C221
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiAZD3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237206AbiAZD3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643167776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cgymQfGSuilmwHq8hbN9u09QSfRSsdRkrdxNQudh6GM=;
        b=jBKA6KJ0KSt3SiN0qlCsqLVq2jRBcFJkTUBfmarUNm/2lWgkPemJAtVbKIuY9f3Jcr+Rx5
        obt2HKxcJSGbsuGYA/pfizM7HplA4pokpuz7ynh10q+ZeLHcI1+ZxseZpNRk3Sri5bawb6
        d+TZahDgwJ7oV23jxIyxS+kE+eO4fsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-XpXrAHkVMhOIpAcPZt8Wig-1; Tue, 25 Jan 2022 22:29:32 -0500
X-MC-Unique: XpXrAHkVMhOIpAcPZt8Wig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2DA91DDE9;
        Wed, 26 Jan 2022 03:29:30 +0000 (UTC)
Received: from localhost (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46BD54E2B7;
        Wed, 26 Jan 2022 03:29:21 +0000 (UTC)
Date:   Wed, 26 Jan 2022 11:29:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kernel@gpiccoli.net,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Message-ID: <20220126032919.GB2086@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv>
 <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <c7796467-ee32-942f-6011-860a3600f4ef@igalia.com>
 <20220122103121.GB2596@MiWiFi-R3L-srv>
 <ed18ba1e-4792-22c5-3ece-4d518a8a4a2d@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed18ba1e-4792-22c5-3ece-4d518a8a4a2d@igalia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/22/22 at 10:49am, Guilherme G. Piccoli wrote:
> On 22/01/2022 07:31, Baoquan He wrote:
> > [...]
> > From my old POV, I took pstore as a necessity on handheld devices or
> > embeded system, e.g on Andriod. In that case, reserving crashkernel
> > memory to enable kdump to save kernel log, it sounds not so
> > cost-effective, since memory on those systems is usually not big.
> > I am also interested in any new use case where people deploy these
> > and why it's needed, to widen my view.
> 
> Hi Baoquan, that's great to hear. Indeed, I feel pstore is unfortunately
> not very used in non-embedded devices - if you see kdump/error-report
> userspace tooling, like on Red Hat/Fedora, Debian/Ubuntu and so on, they
> never rely on pstore. And the configuration is not straightforward for
> the users...I think that's a good thing to change, since pstore is much
> less resource consuming than kdump.
> But of course, not a discussion related to this patch specifically, just
> me thinking out loud heh
> 
> 
> > [...] 
> > It's my bad. My thought is panic_print and kmsg_dump can be coupled, but
> > they should decouple with panic_notifier. When panic_print is enabled,
> > we do not expect to execute panic_notifier? My personal opinion.
> > 
> > I missed the change at line 8, sorry for the caused misunderstanding. 
> > Now the chance of holding C-programmer-prize of the year comes back
> > again.
> > 
> >   void panic()
> >   {
> > 1         if (!_crash_kexec_post_notifiers && !panic_print) {
> > 2                 __crash_kexec(NULL);
> > 3                 smp_send_stop();
> > 4         } else {
> > 5                 crash_smp_send_stop();
> > 6         }
> >   
> >   	if (_crash_kexec_post_notifiers)
> > 8  		atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> > 9  	panic_print_sys_info(false);
> > 10  	kmsg_dump(KMSG_DUMP_PANIC);
> > 11  	if (_crash_kexec_post_notifiers || panic_print)
> > 12                 __crash_kexec(NULL);
> >   	...
> >   	debug_locks_off();
> >           console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> >           panic_print_sys_info(true);
> 
> Hmm, yeah, I still don't think I'm a brilliant C programmer heh
> Again, in the code above, I can't see how we would reach
> "__crash_kexec(NULL)" after printing the extra info of panic_print, if
> we don't have panic notifiers enabled.

Missed this one.

Above code will allow any of _crash_kexec_post_notifiers and panic_print
to execute, then crash dump in L11.
   L5 -> L11

Since you have posted v4, let's ignore it anyway.

> 
> So, indeed the code currently don't really tightly couple "panic_print"
> with the panic notifiers. We could change that in another patch series,
> based on what Petr suggested in the filter thread (I know you're
> following there as well, thanks bu the way!), but for now, they are
> completely independent. My plan, following Petr suggestions here and if
> you agree, is to re-submit this patch with some changes, but in the end
> the code will allow users that have kdump enabled + panic_print
> -"crash_kexec_post_notifiers" to have "panic_print_sys_info(false)"
> executing before the "__crash_kexec(NULL)".
> 
> But also, we can add "crash_kexec_post_notifiers" and it will still
> work; finally, pstore is gonna be able to collect the logs from
> "panic_print" as well (the main purpose of this patch).
> 
> Once that's all resolved, my goal is to jump into the panic notifiers
> refactor suggested in the other thread. Let me know if you agree with
> these steps/plans, and I'll work them.

I am glad to see any improvement from refactory. As for panic_notifier,
I have expressed my concern and worry about the plan. So, if no any
new action added before kdump switching, it's welcomed.

