Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB3493AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354077AbiASM60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:58:26 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:51782 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243984AbiASM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=joA+/jqK1Zc6P9gnym35J+djlIAdV9SD9sbXsn03rFA=; b=oSOoXJOJ7e70yc9drKakfsrXBe
        O9UDzQzu5+j/8KSV3bitKxrjSjWdZn0ImOaLgJj6SPpzViot0fVX8Ve9Gjk/NKTQ5SN2r8Qk74K3L
        WCNSy62vFdAPqCF5BHuTkOC/TqTT9uFdXbXNI/mXmUMh/FoPWOA5yiO2tfkoaVM0op0TpSLwTaJma
        /PfHzQYRnQ5Ek6VBxqVefOZ+12+vPvZN42zvhRR3LB/vu8I2jUViPV5LEi/Fxcr2CJVakYqyaiHwx
        ihKBuTOLsT3GmtbD6NUwAIVcSVlqNJGosdSlVgjU6iZYvdGEJd5WQnhWfz2mt2DtbpPQOHpKcTKWT
        Rw3jStJA==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nAAXW-0002qw-Fn; Wed, 19 Jan 2022 13:58:14 +0100
Message-ID: <0c91edc7-dcae-56e9-9f63-707127187295@igalia.com>
Date:   Wed, 19 Jan 2022 09:57:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220119071318.GA4977@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2022 04:13, Baoquan He wrote:
> [...]
> Thanks for the effort.                                                                                                                  
> 
> I have some concerns about this patch, and it's still not clear to me
> why the thing done in this patch is needed. Hope you don't mind if I ask
> stupid question or things have been discussed in the earlier post.
> 
> Firstly, let me add some background information and details about the
> problem with my understanding, please correct me if anthing is wrong.
> 

Hi Baoquan - first of all, thanks a lot for your review and detailed
analysis, this is pretty good and much appreciated!


> Background:
> ===========
> Currently, in panic(), there are 5 different ways to try best to
> collect information:
> 1) Vmcore dumping
>    done via kdump, high weight, almost get all information we want;
>    need switch to kdump kernel immediately.
> 2) Panic notifier
>    iterating those registered handlers, light weight, information got
>    depends on those panic handlers. Try its best after panic, do not reboot.
> 3) kmsg_dump
>    iterating registered dumpers to collect as much kernel log as possible
>    to store. E.g on pstore, light weight, only kernel log, do not reboot,
>    log can be checked after system reboot.
> 4)console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>    Flush to get the pending logbuf printed out to console.
> 5)panic_print
>    Print out more system info, including all dmesg, task states, mem
>    info, etc.
> ===========
> 
> 
> The problem encoutered:
> =======
> Currently panic_print is done after kmsg_dump. This caused an issue that
> system info poked by panic_print to expose to logbuf have no chance to
> be collected by kmsg_dump. E.g pstore_dumper registered and handled in
> kmsg_dump(), is a light weight and helpful panic info collecting
> mechanism, will miss those lots of and helful message poked by
> panic_print.
> ======
> 

OK, I agree with you analysis, it's quite precise - our main problem
resolved in this patch is that some users may want to save the
panic_print information on pstore collected logs, and currently this
isn't possible.


> [...] 
> About the change, my question is why not packing
> console_flush_on_panic(CONSOLE_FLUSH_PENDING) into panic_print(), and
> move panic_print() up to be above kmsg_dump(). The pending console
> flusing and replaying all flush are all only called inside panic(), and
> aim to print out more information.
> 

About this point, the idea of not messing with the console flush comes
from a discussion in the V1 of this patch, see here:
https://lore.kernel.org/lkml/YdQzU0KkAVq2BWpk@alley/

Basically, there are much more risks than benefits in moving the console
flush earlier. Hence, we kept the console flushing intact and even the
replay flag in panic_print - that's the reason we need the new flag in
panic_print_sys_info().


> And adding panic_print_sys_info(false) before kdump might not be a good
> idea. Firstly, panicked system is very unstable, kdump need switch to
> 2nd kernel asap w/o any extra action so that it can survive and collect
> tons of information. Added panic_print_sys_info(false) is obviously
> unnecessary to kdump, and increase risk to kernel switching.
> 
> If I missing anything, please help point out so that I can have a
> complete view on this isuse and its fix.
> 

And this is another point, and for that I must apologize since I sent
this change in another patch[0] but forgot to CC the kexec list; so
details are in this thread:
https://lore.kernel.org/lkml/20211109202848.610874-4-gpiccoli@igalia.com/

There was a discussion with Dave there, thankfully he was able to see
the patch using some lore/lei search in lkml, but let me give you the
summary here.

So, I agree with you that calling the panic_print handler before kdump
_increases the risk_ of a kdump failure - this is more or less like a
the "crash_kexec_post_notifiers", right? It's a decision from the user,
with its natural trade-offs and considerations to be made.
But in the panic_print case, users weren't allowed to decide, before my
patch - it was just impossible to ever get the panic_print output before
the kdump.

My patch just enabled the users to have this decision. It's not like if
we are now dumping the panic_print always, it's still a parameter that
users must add consciously there, but now they are entitled to have this
choice! And the bonus is that we can have kdump collecting only the
dmesg, which is fast and storage-friendly (since the vmcore, even
compressed, is quite big) but still, with lots of information from the
panic_print output. Of course, there's the trade-off here, the risk of
printing all that information before the kdump, that might make kdump
more unstable, though this is a decision that the users/sysadmin must
take into account.

Finally, Dave suggested that we could make panic_print a panic notifier,
and this idea is pretty good! But then, the trade-off is more complex:
in order to have panic_print output, users also must have all the panic
notifiers, by using the "crash_kexec_post_notifiers" option. It's too
much, in my opinion.

I hope this was a good summary, please let me know if you still have any
questions Baoquan - thanks again for the great review!
Cheers,


Guilherme


[0]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ab693ae2140
