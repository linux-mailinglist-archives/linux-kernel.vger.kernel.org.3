Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C135E495FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380660AbiAUNR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:17:57 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:34826 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346124AbiAUNR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V8g+N1QlmZO+t5VjSGk2d8QPBvpzJqfgIHBB+UgsILI=; b=B219rzr657asIAdb545MWg8kUF
        e4KdSndguxI8j9J1i4QMEN/kXuhdWr20qzVp2xGt/wBLJdA1TQqnYtYRuTq90XYn0SllZknNtK5+R
        2kV37w/CBm9dKkTDQaJMcuc35um99fDqv6d/5IwLLgvzOKB2x2lXfQYfQpEJUF8hDvJInqWqtmERW
        D68oRS14fYOuu4kb/fDipuzBeF4axOuRGasNWPDT4d5q7jgM5BZ0p9n57JnAdQgmBDhIZqoijelON
        3bUkl1E+U+roYKDAWBGQYGw3FyghxPg83fVTzWwBIPoEjGlUPuAqUs1HUGQNBnNV9ldKwVmvMkvnu
        psyQT97Q==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nAtnU-0002AV-At; Fri, 21 Jan 2022 14:17:44 +0100
Message-ID: <c7796467-ee32-942f-6011-860a3600f4ef@igalia.com>
Date:   Fri, 21 Jan 2022 10:17:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kernel@gpiccoli.net,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220121023119.GB4579@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan , thanks again for your prompt reply!
Comments inline below:


On 20/01/2022 23:31, Baoquan He wrote:
> [...]
>> OK, I'll try to be really clear, hopefully I can explain the use case in
>> better and simpler words. First of all, I wouldn't call it a corner case
>> - it's just a valid use case that, in my opinion, should be allowed. Why
>> not, right? Kernel shouldn't push policy on users, we should instead let
>> the users decide how to use the tools/options.
> 
> Agree, sorry about my wrong expression.

No need to be sorry at all! And if you indeed consider that a corner
case, feel free to express that and we should take it into account =)
Your opinion is much appreciated!


> 
> OK, pstore via kmsg_dump is first option, then fallback to kdump.
> This is what I suggested at below. This is what panic notifier has done
> at below. I think both of them are similar, thus should take the same
> way to handle.
> 
>  void panic()
>  {
>1         if (!_crash_kexec_post_notifiers && !panic_print) {
>2                 __crash_kexec(NULL);
>3                 smp_send_stop();
>4         } else {
>5                 crash_smp_send_stop();
>6         }
>  
>8  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>9  	panic_print_sys_info(false);
>10  	kmsg_dump(KMSG_DUMP_PANIC);
>11  	if (_crash_kexec_post_notifiers || panic_print)
>12                 __crash_kexec(NULL);
>  	...
>  	debug_locks_off();
>          console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>  
>          panic_print_sys_info(true);
>  	......
>  }
>[...] 
> I don't get. Why it has to *require* users to make use of
> "crash_kexec_post_notifiers" in order to use "panic_print"? 
> To enable panic notifiers and panic_print, we need add below parameter
> to kernel cmdline separately.
> 
> 	crash_kexec_post_notifiers=1
>         panic_print=0x7f
> 
> With above code, we have:
> 1) None specified in cmdline, only kdump enabled.
>    Crash dump will work to get vmcore.
> 2) crash_kexec_post_notifiers=1 , kdump enabled
>    panic_notifers are executed, then crash dump
> 3) panic_print=0x7f, kdump enabled,
>    Panic_print get system info printed, then crash dump
> 4) crash_kexec_post_notifiers=1 panic_print=0x7f, kdump enabled
>    panic_notifers are executed firstly, then panic_print, at last crash dump
> 
> Here I don't list the no kdump enabled case. Please help point out if I
> misunderstood anything.

OK, this is a really great summary list of the possible cases, thanks
for that. I might be wrong here, this code is a bit confusing for
me...so I put line numbers in your code and we can discuss based on that.

Case (1) - Line L2 is reached, we jump to the kdump kernel, right?
Case (2) - Line L5 and lines L8->L12 executed, correct?

Case (3) - I don't understand this case! If kdump is enabled and
panic_print as well, we execute Line L2 right? If that's not the case,
then we jump to kdump kernel at line L12, but that means L8 was
executed, the notifiers list. Right?

So, how is it possible in your code to execute
"panic_print_sys_info(false);" and then jump to kdump *without* reaching L8?

I apologize in advance if I'm silly and it's obvious - I guess I won't
get the C-programmer-prize of the year anyway heheh


>> Sure, I'll rename "after_kmsg_dumpers" to "console_flush" in next
>> iteration, although my nerd side won't be so happy ;-)
> 
> No offence at all. My wife always call me nerd. Sorry about that.

No offense taken, and no need to be sorry - we're cool!
I got the joke =D

And the variable name suggestion was indeed good.
