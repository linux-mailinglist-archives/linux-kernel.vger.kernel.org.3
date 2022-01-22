Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7561496BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 11:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiAVKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 05:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232784AbiAVKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 05:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642847503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rHqPza9jpSJGDWcEQuAh3fqaKtz6YahZdxy1LkLcnS8=;
        b=DJQXXay3SeQrmKzX68PjEzBkFZ8ZtrqHhjoZPfGeIsMBOiyfCcTIemthV9kYZ5l6AZZ+Rm
        18B3jMt4MlwH6bh1cYx69rsHjSs+2dGVNE2t3lobkFRc/kHnEKlQIzs8UAwgh+bR74gXEY
        sN8U/Qm/DJMs1HyKaEHzbV8RDa58Kis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-UrfWE9gqMvGfvmu8K7HAKg-1; Sat, 22 Jan 2022 05:31:42 -0500
X-MC-Unique: UrfWE9gqMvGfvmu8K7HAKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2F28809CD9;
        Sat, 22 Jan 2022 10:31:39 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07DF173167;
        Sat, 22 Jan 2022 10:31:23 +0000 (UTC)
Date:   Sat, 22 Jan 2022 18:31:21 +0800
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
Message-ID: <20220122103121.GB2596@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv>
 <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <c7796467-ee32-942f-6011-860a3600f4ef@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7796467-ee32-942f-6011-860a3600f4ef@igalia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/22 at 10:17am, Guilherme G. Piccoli wrote:
> Hi Baoquan , thanks again for your prompt reply!
> Comments inline below:
> 
> 
> On 20/01/2022 23:31, Baoquan He wrote:
> > [...]
> >> OK, I'll try to be really clear, hopefully I can explain the use case in
> >> better and simpler words. First of all, I wouldn't call it a corner case
> >> - it's just a valid use case that, in my opinion, should be allowed. Why
> >> not, right? Kernel shouldn't push policy on users, we should instead let
> >> the users decide how to use the tools/options.
> > 
> > Agree, sorry about my wrong expression.
> 
> No need to be sorry at all! And if you indeed consider that a corner
> case, feel free to express that and we should take it into account =)
> Your opinion is much appreciated!

From my old POV, I took pstore as a necessity on handheld devices or
embeded system, e.g on Andriod. In that case, reserving crashkernel
memory to enable kdump to save kernel log, it sounds not so
cost-effective, since memory on those systems is usually not big.
I am also interested in any new use case where people deploy these
and why it's needed, to widen my view.
> 
> > 
> > OK, pstore via kmsg_dump is first option, then fallback to kdump.
> > This is what I suggested at below. This is what panic notifier has done
> > at below. I think both of them are similar, thus should take the same
> > way to handle.
> > 
> >  void panic()
> >  {
> >1         if (!_crash_kexec_post_notifiers && !panic_print) {
> >2                 __crash_kexec(NULL);
> >3                 smp_send_stop();
> >4         } else {
> >5                 crash_smp_send_stop();
> >6         }
> >  
> >8  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> >9  	panic_print_sys_info(false);
> >10  	kmsg_dump(KMSG_DUMP_PANIC);
> >11  	if (_crash_kexec_post_notifiers || panic_print)
> >12                 __crash_kexec(NULL);
> >  	...
> >  	debug_locks_off();
> >          console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> >  
> >          panic_print_sys_info(true);
> >  	......
> >  }
> >[...] 
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
> 
> OK, this is a really great summary list of the possible cases, thanks
> for that. I might be wrong here, this code is a bit confusing for
> me...so I put line numbers in your code and we can discuss based on that.
> 
> Case (1) - Line L2 is reached, we jump to the kdump kernel, right?
> Case (2) - Line L5 and lines L8->L12 executed, correct?
> 
> Case (3) - I don't understand this case! If kdump is enabled and
> panic_print as well, we execute Line L2 right? If that's not the case,
> then we jump to kdump kernel at line L12, but that means L8 was
> executed, the notifiers list. Right?
> 
> So, how is it possible in your code to execute
> "panic_print_sys_info(false);" and then jump to kdump *without* reaching L8?
> 
> I apologize in advance if I'm silly and it's obvious - I guess I won't
> get the C-programmer-prize of the year anyway heheh

It's my bad. My thought is panic_print and kmsg_dump can be coupled, but
they should decouple with panic_notifier. When panic_print is enabled,
we do not expect to execute panic_notifier? My personal opinion.

I missed the change at line 8, sorry for the caused misunderstanding. 
Now the chance of holding C-programmer-prize of the year comes back
again.

  void panic()
  {
1         if (!_crash_kexec_post_notifiers && !panic_print) {
2                 __crash_kexec(NULL);
3                 smp_send_stop();
4         } else {
5                 crash_smp_send_stop();
6         }
  
  	if (_crash_kexec_post_notifiers)
8  		atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
9  	panic_print_sys_info(false);
10  	kmsg_dump(KMSG_DUMP_PANIC);
11  	if (_crash_kexec_post_notifiers || panic_print)
12                 __crash_kexec(NULL);
  	...
  	debug_locks_off();
          console_flush_on_panic(CONSOLE_FLUSH_PENDING);
  
          panic_print_sys_info(true);
  	......
  }

> 
> 
> >> Sure, I'll rename "after_kmsg_dumpers" to "console_flush" in next
> >> iteration, although my nerd side won't be so happy ;-)
> > 
> > No offence at all. My wife always call me nerd. Sorry about that.
> 
> No offense taken, and no need to be sorry - we're cool!
> I got the joke =D
> 
> And the variable name suggestion was indeed good.
> 

