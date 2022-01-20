Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF0494A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359489AbiATIwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359483AbiATIwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642668729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bp+2xwB14y9NKkez5nmjKChMnUwOJL1Ym07wFyFjjGU=;
        b=SMGsc1YYv5dD60/wUkv7+T54JZM4eLklTX/IRvft2CL7cKMjtbiHOd4bDPI5VmDP3ScRLx
        nyT+Q/jluxwSRcM82NylYdJvZfDGxhtlgPfZ9orfrNp5aNAMQbVTQRvz9bkwqRQZ/V6xzt
        isN26eeW2frgG+mYvhf87LpvEWQktQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-vJbO-RqPPS2kNur4NCLDSA-1; Thu, 20 Jan 2022 03:52:05 -0500
X-MC-Unique: vJbO-RqPPS2kNur4NCLDSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B907F8145E1;
        Thu, 20 Jan 2022 08:52:02 +0000 (UTC)
Received: from localhost (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF6F770D3B;
        Thu, 20 Jan 2022 08:51:17 +0000 (UTC)
Date:   Thu, 20 Jan 2022 16:51:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Message-ID: <20220120085115.GB18398@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv>
 <YegytkfED+QI56Y8@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YegytkfED+QI56Y8@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/22 at 04:48pm, Petr Mladek wrote:
> On Wed 2022-01-19 15:13:18, Baoquan He wrote:
> > On 01/14/22 at 03:30pm, Guilherme G. Piccoli wrote:
> > > The panic_print setting allows users to collect more information in a
> > > panic event, like memory stats, tasks, CPUs backtraces, etc.
> > > This is a pretty interesting debug mechanism, but currently the print
> > > event happens *after* kmsg_dump(), meaning that pstore, for example,
> > > cannot collect a dmesg with the panic_print information.
> > ...... 
> > 
> > Thanks for the effort.                                                                                                                  
> > 
> > I have some concerns about this patch, and it's still not clear to me
> > why the thing done in this patch is needed. Hope you don't mind if I ask
> > stupid question or things have been discussed in the earlier post.
> > 
> > Firstly, let me add some background information and details about the
> > problem with my understanding, please correct me if anthing is wrong.
> > 
> > Background:
> > ===========
> > Currently, in panic(), there are 5 different ways to try best to
> > collect information:
> > 1) Vmcore dumping
> >    done via kdump, high weight, almost get all information we want;
> >    need switch to kdump kernel immediately.
> 
Thanks for the input, Petr.

> My experience is that it basically always works when it is correctly
> configured. It might be tested before the crash.

I guess you mean on a certain machine, admin usually triggers a crash
manually to test the vmcore dumping. If it works with the test, it
always works later. However, the success of switching sometime may
depend on what is crashed.

We got report of on guest of hyperV, they enable panic_notifier by
default, w/o the need of adding in cmdline. When crash triggered, it
will enter into the panic_notifier and execute the HyperV's specific
task, then it failed and never reach to kdump jumping.
> 
> 
> 
> > 2) Panic notifier
> >    iterating those registered handlers, light weight, information got
> >    depends on those panic handlers. Try its best after panic, do not reboot.
> 
> 
> From my POV, the function of panic notifiers is not well defined. They
> do various things, for example:
> 
>   + on_panic_nb() flushes s390 console buffers. It looks like a
>     complex and risky code. For example, __sclp_vt220_flush_buffer()
>     takes spin locks and calls timer code.
> 
>   + dump_gisb_error() prints some info but it also communicates with
>     the device, see gisb_read() and gisb_write() in
>     brcmstb_gisb_arb_decode_addr(). I am not sure how reliable this is.
> 
>   + parisc_panic_event() re-enables the soft-power switch. I am not
>     sure how safe this is.
> 
>   + pvpanic_panic_notify() takes spin lock and does in iowrite().
> 
> 
> The do more that just providing information. Some are risky. It is not
> easy to disable a particular one.

Yes, agree. Not all of them just provide information. 

Now panic_notifier_filter Guilherme added can help to disable some of
them.

> 
> 
> > 3) kmsg_dump
> >    iterating registered dumpers to collect as much kernel log as possible
> >    to store. E.g on pstore, light weight, only kernel log, do not reboot,
> >    log can be checked after system reboot.
> 
> From my POV, it is similar functionality like the crash dump.
> 
> It might make sense to allow to call kmsg_dump before panic notifiers
> to reduce the risk of a breakage. But I do not have enough experience
> with them to judge this.

Hmm, from the content it saved, it's more like the vmcore-dmesg
we call in kdump kernel. From behaviour, it's a little similar with
crash dump, dumped file are saved and can be checked after system
reboot. While it can't be compared to crash dump. With my understanding,
kmsg_dump is mostly used on embeded systems or mobile devices.

I tend to agree with you to move kmsg_dump before panic notifiers since
kmsg_dump looks lighter weight than panic notifier. Let's see how the
users of them say.
> 
> I can't remember any bug report in this code. I guess that only
> few people use kmsg_dump.
> 
> 
> > 4)console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> >    Flush to get the pending logbuf printed out to console.
> 
> My experience is that there are many problems with consoles.
> There might be deadlocks because of internal locks. Some
> serial consoles are incredibly slow. Messages in the console
> drivers might cause infinite output. Some drivers are pretty
> complex, especially tty that is often enabled.
> 
> console_flush_on_panic() makes it even worse. It resets console_sem.
> It means that it tries to use the consoles even when they are
> already in use.
> 
> Note that printk() tries to show the messages on the console
> immediately. console_flush_on_panic() is just the last
> instance when all safe ways failed.

OK, then putting them at last stage to execute sounds reasonable. 

> 
> 
> > 5)panic_print
> >    Print out more system info, including all dmesg, task states, mem
> >    info, etc.
> 
> This adds more information to the kernel log. They can be requested
> by kernel commandline parameter. They can be seen only on the console
> at the moment.
> 
> It makes sense to allow to see them also in crash dump or kmsg_dump.

I haven't heard complaint about insufficient message in crash dump. Do
you have any pointer or case about this?

> 
> > About the change, my question is why not packing
> > console_flush_on_panic(CONSOLE_FLUSH_PENDING) into panic_print(), and
> > move panic_print() up to be above kmsg_dump().
> 
> As explained above. console_flush_on_panic() is a dirty hack.
> It really has to be called at the end as the last resort.
> 
> 
> > And adding panic_print_sys_info(false) before kdump might not be a good
> > idea. Firstly, panicked system is very unstable, kdump need switch to
> > 2nd kernel asap w/o any extra action so that it can survive and collect
> > tons of information. Added panic_print_sys_info(false) is obviously
> > unnecessary to kdump, and increase risk to kernel switching.
> 
> Yes, panic_print_sys_info() increases the risk that the crash dump
> will not succeed. But the change makes sense because:
> 
>   + panic_print_sys_info() does nothing by default. Most users will
>     not enable it together with crash dump.

Even so, we may need to keep code easier to maintain. We can make it
just as panic notifier does.

> 
>   + Guilherme uses crash dump only to dump the kernel log. It might
>     be more reliable than kmsg_dump. In this case, panic_print_sys_info()
>     is the only way to get the extra information.

Hmm, I haven't made clear what Guilherme really wants in his recent
post. In this patch he wants to get panic print info into pstore. He
also want to dump the kernel log poked by panic_print in kdump kernel. 
And it's very weird people try to collect kernel log via crash dump
mechnism, that is obviously using a sledgehammer to crack a nut.
Sometime, we should not add or change code to a too specific corner
case.

> 
>   + panic_print_sys_info() might be useful even with full crash dump.
>     For example, ftrace messages are not easy to read from the memory
>     dump.

As said before, do you have a case report about ftrace debugging
requring more message in kdump kernel? If true, I would like to see a
patch posted for that, and patch log stating it clearly. I noticed
below patch from Guilherme has been queued in linux-next. At least, from
the commit log, I don't understand why a kernel log need be collected
via crash dump. Now, this patch is posted, kernel log need be collected
via kmsg_dump. Really hope we can make all things clear, then a final
agreement is made.

commit ab693ae2140afdf797cc376b3569ca9850a7681d
Author: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date:   Thu Dec 30 20:29:14 2021 +1100

    panic: allow printing extra panic information on kdump


In fact, my suggestion is as below. I would like to see kmsg_dump()
being moved above panic_notifer after Guilherme's careful evaluation.

void panic()
{
        if (!_crash_kexec_post_notifiers && !panic_print) {
                __crash_kexec(NULL);
                smp_send_stop();
        } else {
                crash_smp_send_stop();
        }

	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
	panic_print_sys_info(false);
	kmsg_dump(KMSG_DUMP_PANIC);
	if (_crash_kexec_post_notifiers || panic_print)
                __crash_kexec(NULL);
	...
	debug_locks_off();
        console_flush_on_panic(CONSOLE_FLUSH_PENDING);

        panic_print_sys_info(true);
	......
}

Please, don't name 'after_kmsg_dumpers', that's too nerd, bro :-)
static void panic_print_sys_info(bool console_flush)
{
	.....
}

