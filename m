Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF4249665B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiAUUcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:32:22 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:40226 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiAUUcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1bzeF3KIoKGN4fwPwrCG9OVXlPov8YBkb3E75uxLZ1s=; b=eW/b65Z5H/FHeiqajUPCNHnk8/
        JFzjICpIkLjql7+g8JYckWW8wbFeM2Z4sRNGN9+7B4Jr6Mdb7i7SSTUiv5oLmdqZSEEyWw4Sh9Irw
        r0FUL11Co+IN5gJb+5TovBnO5j92pdP2W53Y22IyNPlTV6UC2q/Pv+xTp1blqoNAbV35gFzmRJ4Kn
        VWZHKZk2Y3NILikvZwRykBXq5PeDJ6m4T1PLP6CRxHiASHZ7Zk3t1is0faShlQUG2TRSiWVHkio5Z
        LuuCdO/NwLAc++W5HAynJ/rRt6hw5B/Xj8l5rQzzya4bUcwuOpJTSuUy0C6UlfBVnfQrq45tshJd4
        deDAKoOA==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nB0Zu-00036g-Rr; Fri, 21 Jan 2022 21:32:11 +0100
Message-ID: <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
Date:   Fri, 21 Jan 2022 17:31:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, bhe@redhat.com,
        vgoyal@redhat.com, stern@rowland.harvard.edu,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, halves@canonical.com, kernel@gpiccoli.net,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, mikelley@microsoft.com
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Yel8WQiBn/HNQN83@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr, thanks for the great response, and for CCing more (potentially)
interested parties! Some comments inline below; also, I'm CCing Michael
Kelley as well.


On 20/01/2022 12:14, Petr Mladek wrote:
> Adding some more people into Cc. Some modified the logic in the past.
> Some are familiar with some interesting areas where the panic
> notfiers are used.
> 
> On Sat 2022-01-08 12:34:51, Guilherme G. Piccoli wrote:
>> [...]
>> There are some cases though in which kdump users might want to
>> allow panic notifier callbacks to execute _before_ the kexec to
>> the crash kernel, for a variety of reasons - for example, users
>> may think kexec is very prone to fail and want to give a chance
>> to kmsg dumpers to run (and save logs using pstore),
> 
> Yes, this seems to be original intention for the
> "crash_kexec_post_notifiers" option, see the commit
> f06e5153f4ae2e2f3b0300f ("kernel/panic.c: add
> "crash_kexec_post_notifiers" option for kdump after panic_notifiers")
> 
>> some panic notifier is required to properly quiesce some hardware
>> that must be used to the crash kernel.
> 
> Do you have any example, please? The above mentioned commit
> says "crash_kexec_post_notifiers" actually increases risk
> of kdump failure.
> 
> Note that kmsg_dump() is called after the notifiers only because
> some are printing more information, see the commit
> 6723734cdff15211bb78a ("panic: call panic handlers before kmsg_dump").
> They might still increase the change that kmsg_dump() will never
> be called.
> 

Sure! I guess Michael Kelley's response here is the perfect example:
https://lore.kernel.org/lkml/MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com/

In my understanding, he is referring the function hyperv_panic_event().
But I also found another 2 examples in a quick look: bcm_vk_on_panic()
and brcmstb_pm_panic_notify().


>> [...]
>> So, this patch aims to ease this decision: we hereby introduce a filter
>> for the panic notifier list, in which users may select specifically
>> which callbacks they wish to run, allowing a safer kdump. The allowlist
>> should be provided using the parameter "panic_notifier_filter=a,b,..."
>> where a, b are valid callback names. Invalid symbols are discarded.
> 
> I am afraid that this is almost unusable solution:
> 
>    + requires deep knowledge of what each notifier does
>    + might need debugging what notifier causes problems
>    + the list might need to be updated when new notifiers are added
>    + function names are implementation detail and might change
>    + requires kallsyms
> 
> 
> It is only workaround for a real problem. The problem is that
> "panic_notifier_list" is used for many purposes that break
> each other.
> 
> I checked some notifiers and found few groups:
> 
>    + disable watchdogs:
>       + hung_task_panic()
>       + rcu_panic()
> 
>    + dump information:
>       + kernel_offset_notifier()
>       + trace_panic_handler()     (duplicate of panic_print=0x10)
> 
>    + inform hypervisor
>       + xen_panic_event()
>       + pvpanic_panic_notify()
>       + hyperv_panic_event()
> 
>    + misc cleanup / flush / blinking
>       + panic_event()   in ipmi_msghandler.c
>       + panic_happened()   in heartbeat.c
>       + led_trigger_panic_notifier()
> 
> 
> IMHO, the right solution is to split the callbacks into 2 or more
> notifier list. Then we might rework panic() to do:
> 
> void panic(void)
> {
> 	[...]
> 
> 	/* stop watchdogs + extra info */
> 	atomic_notifier_call_chain(&panic_disable_watchdogs_notifier_list, 0, buf);
> 	atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> 	panic_print_sys_info();
> 
> 	/* crash_kexec + kmsg_dump in configurable order */
> 	if (!_crash_kexec_post_kmsg_dump) {
> 		__crash_kexec(NULL);
> 		smp_send_stop();
> 	} else {
> 		crash_smp_send_stop();
> 	}
> 
> 	kmsg_dump();
> 	if (_crash_kexec_post_kmsg_dump)
> 		__crash_kexec(NULL);
> 
> 	/* infinite loop or reboot */
> 	atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> 	atomic_notifier_call_chain(&panic_rest_notifier_list, 0, buf);
> 
> 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> [...] 
> Two notifier lists might be enough in the above scenario. I would call
> them:
> 
> 	panic_pre_dump_notifier_list
> 	panic_post_dump_notifier_list
> 
> 
> It is a real solution that will help everyone. It is more complicated now
> but it will makes things much easier in the long term. And it might be done
> step by step:
> 
>      1. introduce the two notifier lists
>      2. convert all users: one by one
>      3. remove the original notifier list when there is no user

That's a great idea! I'm into it, if we have a consensus. The thing that
scares me most here is that this is a big change and consumes time to
implement - I'd not risk such time if somebody is really against that.
So, let's see more opinions, maybe the kdump maintainers have good input.

Also, I'd be interested in still keeping a filter for the pre_dump list,
could be a blacklist by function name for example; since the post_dump
is conditioned to "crash_kexec_post_notifiers" and most of information
output will be in the first notifier, I don't see a strong reason
anymore for filtering the second notifier.

Cheers,


Guilherme
