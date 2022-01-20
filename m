Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7C1495605
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377962AbiATVhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:37:01 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:42920 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiATVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=14SKn09awFKZD+Pnr8N1I8AVOJEcjviniUjAj4Clm8A=; b=Zrx7CNirRVTIHmjr+pqRKm2PsG
        +ATcQRGBs7W/QBF3aDf4ZxboOxkMgiCHd97a6GkpNLt6MM5u3Pu1MK7zdk3dmiTm0/GG+DaBJfIvP
        XRdjn/TAMOjadP66H3eZag7qeHSyHIYDajEelKM+uFs8IEPQL4rcjuDg8+Ijuc04JHJjMPvZBvLku
        s+UT2B2PzCLVopc9mrfo39WMlPARu3pjjvto7Kh/Re+dmCrHKEy2ABqNWJ/sDtxPUdf6rzLinM0Vw
        qT3DtdPCmsWvXn/g/7x2XgFWf4dkkttiKiYSMZh+r3YsWj3uGgc31qKPNePebhte2krBAUMLfajxt
        htYqqbHQ==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nAf6v-0001R8-KY; Thu, 20 Jan 2022 22:36:50 +0100
Message-ID: <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
Date:   Thu, 20 Jan 2022 18:36:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220120085115.GB18398@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan, some comments inline below:


On 20/01/2022 05:51, Baoquan He wrote:
> [...]
>> From my POV, the function of panic notifiers is not well defined. They
>> do various things, for example:
>> [...]
>> The do more that just providing information. Some are risky. It is not
>> easy to disable a particular one.
> 
> Yes, agree. Not all of them just provide information. 
> 
> Now panic_notifier_filter Guilherme added can help to disable some of
> them.

So, just for completeness, worth to mention Petr had some interesting
suggestions in the other thread (about the filter) and we may end-up not
having this implemented - in other words, maybe a refactor of that
mechanism is going to be proposed.


> [...] 
>>
>>   + Guilherme uses crash dump only to dump the kernel log. It might
>>     be more reliable than kmsg_dump. In this case, panic_print_sys_info()
>>     is the only way to get the extra information.
> 
> Hmm, I haven't made clear what Guilherme really wants in his recent
> post. In this patch he wants to get panic print info into pstore. He
> also want to dump the kernel log poked by panic_print in kdump kernel. 
> And it's very weird people try to collect kernel log via crash dump
> mechnism, that is obviously using a sledgehammer to crack a nut.
> Sometime, we should not add or change code to a too specific corner
> case.

OK, I'll try to be really clear, hopefully I can explain the use case in
better and simpler words. First of all, I wouldn't call it a corner case
- it's just a valid use case that, in my opinion, should be allowed. Why
not, right? Kernel shouldn't push policy on users, we should instead let
the users decide how to use the tools/options.

So imagine you cannot collect a vmcore, due to the lack of storage
space. Yet, you want the most information as possible to investigate the
cause of a panic. The kernel flag "panic_print" is the perfect fit, we
can dump backtraces, task list, memory info...right on a panic event.

But then, how to save this panic log with lots of information after a
reboot? There are 2 ways in my understanding:

(a) pstore/kmsg_dump()
(b) kdump

The option (a) is easily the best - we don't need to reserve lots of
memory, then boot another kernel, etc. This patch (being hereby
discussed) aims to enable the "panic_print" output for this case!
But...there are cases in which option (a) cannot work. We need a backend
of persistent storage, either a block device or, more common, RAM memory
that is persistent across a reboot. What if it's not available?

Then, we fallback to option (b) - kind of a sledgehammer, in your words heh
It's not ideal, but might be a last resort for users wanting to collect
the most information they can without saving a full vmcore. And for
that, we need to be able to invoke "panic_print" function before the
__crash_kexec() call. Continue below...


> [...] I noticed
> below patch from Guilherme has been queued in linux-next. At least, from
> the commit log, I don't understand why a kernel log need be collected
> via crash dump. Now, this patch is posted, kernel log need be collected
> via kmsg_dump. Really hope we can make all things clear, then a final
> agreement is made.
> 
> commit ab693ae2140afdf797cc376b3569ca9850a7681d
> Author: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Date:   Thu Dec 30 20:29:14 2021 +1100
> 
>     panic: allow printing extra panic information on kdump
> 
> 
> In fact, my suggestion is as below. I would like to see kmsg_dump()
> being moved above panic_notifer after Guilherme's careful evaluation.
> 
> void panic()
> {
>         if (!_crash_kexec_post_notifiers && !panic_print) {
>                 __crash_kexec(NULL);
>                 smp_send_stop();
>         } else {
>                 crash_smp_send_stop();
>         }
> 
> 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> 	panic_print_sys_info(false);
> 	kmsg_dump(KMSG_DUMP_PANIC);
> 	if (_crash_kexec_post_notifiers || panic_print)
>                 __crash_kexec(NULL);
> 	...
> 	debug_locks_off();
>         console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> 
>         panic_print_sys_info(true);
> 	......
> }
>

So, your idea is good and it mostly works, except it *requires* users to
make use of "crash_kexec_post_notifiers" in order to use "panic_print"
in the case (b) above discussed.

Do you think it should be necessary?
How about if we allow users to just "panic_print" with or without the
"crash_kexec_post_notifiers", then we pursue Petr suggestion of
refactoring the panic notifiers? So, after this future refactor, we
might have a much clear code.


> Please, don't name 'after_kmsg_dumpers', that's too nerd, bro :-)
> static void panic_print_sys_info(bool console_flush)

Sure, I'll rename "after_kmsg_dumpers" to "console_flush" in next
iteration, although my nerd side won't be so happy ;-)

Thanks for your review/comments once more.
Cheers,


Guilherme
