Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6580D4981D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiAXOP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232281AbiAXOPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643033754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RciwqzeDbH0CGDVReWAFXEpNAbekgSr4/yuLqwM5lq0=;
        b=aKrGyd4ZM0Stn1bFmaT2Y9ckUzsj4oldeDYqi/292jLjjO/Cj9Mit9w+2wvYSvwFqiX3mZ
        PDZm9LJzOugRRDF9QUHRlFGCKNNtcZNBBMLchhElSTWe8BbsOICASKTPAmetc6uBoIGYRo
        UYYthj8A/jTpqGmRHzVd50Oxj5rBo1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-Lme9-j8yOG-N8Ayxbv9tLw-1; Mon, 24 Jan 2022 09:15:49 -0500
X-MC-Unique: Lme9-j8yOG-N8Ayxbv9tLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B524809CD9;
        Mon, 24 Jan 2022 14:15:46 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 444BE7E23D;
        Mon, 24 Jan 2022 14:15:42 +0000 (UTC)
Date:   Mon, 24 Jan 2022 22:15:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <20220124141539.GC8305@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley>
 <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
 <TYAPR01MB650732FAB4E24D839DFF9EFD955E9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB650732FAB4E24D839DFF9EFD955E9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/22 at 11:43am, d.hatayama@fujitsu.com wrote:
> 
> > On 01/21/22 at 05:31pm, Guilherme G. Piccoli wrote:
> > ......
> > > > IMHO, the right solution is to split the callbacks into 2 or more
> > > > notifier list. Then we might rework panic() to do:
> > > >
> > > > void panic(void)
> > > > {
> > > >     [...]
> > > >
> > > >     /* stop watchdogs + extra info */
> > > >     atomic_notifier_call_chain(&panic_disable_watchdogs_notifier_list, 0, buf);
> > > >     atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> > > >     panic_print_sys_info();
> > > >
> > > >     /* crash_kexec + kmsg_dump in configurable order */
> > > >     if (!_crash_kexec_post_kmsg_dump) {
> > > >             __crash_kexec(NULL);
> > > >             smp_send_stop();
> > > >     } else {
> > > >             crash_smp_send_stop();
> > > >     }
> > > >
> > > >     kmsg_dump();
> > > >     if (_crash_kexec_post_kmsg_dump)
> > > >             __crash_kexec(NULL);
> > > >
> > > >     /* infinite loop or reboot */
> > > >     atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> > > >     atomic_notifier_call_chain(&panic_rest_notifier_list, 0, buf);
> > > >
> > > >     console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > > > [...]
> > > > Two notifier lists might be enough in the above scenario. I would call
> > > > them:
> > > >
> > > >     panic_pre_dump_notifier_list
> > > >     panic_post_dump_notifier_list
> > > >
> > > >
> > > > It is a real solution that will help everyone. It is more complicated now
> > > > but it will makes things much easier in the long term. And it might be done
> > > > step by step:
> > > >
> > > >      1. introduce the two notifier lists
> > > >      2. convert all users: one by one
> > > >      3. remove the original notifier list when there is no user
> > >
> > > That's a great idea! I'm into it, if we have a consensus. The thing that
> > > scares me most here is that this is a big change and consumes time to
> > > implement - I'd not risk such time if somebody is really against that.
> > > So, let's see more opinions, maybe the kdump maintainers have good input.
> > 
> > I am fine with it. As long as thing is made clear, glad to see code is
> > refactored to be more understandable and improved. Earlier, during several
> > rounds of discussion between you and Petr, seveal pitfalls have been
> > pointed out and avoided.
> > 
> > Meanwhile, I would suggest Masa and HATAYAMA to help give input about
> > panic_notifier usage and refactory. AFAIK, they contributed code and use
> > panic_notifier in their product or environment a lot, that will be very
> > helpful to get the first hand information from them.
> > 
> > Hi Masa, HATAYANA,
> > 
> > Any comment on this? (Please ignore this if it's not in your care.)
> > 
> 
> Thanks for CCing to me. I like this patch set. I have same motivation.
> 
> For example, when I used crash_kexec_post_notifiers, I sometimes ran into
> deadlock in printk's exclusion logic during the call of panic notifiers since
> kaslr outputs kernel offset at panic by dump_kernel_offset() via panic notifers
> (although this might never happen now thanks to lockless implementation).
> 
> The problem is that in the current design, we have to run all the
> tasks registered, although most of them are actually unnecessary for
> other users' requirements. Each user wants to call only their own handlers
> in order to keep kdump as reliable as possible.

If I unerstand you correclty, you are expressing your favour to the
panic_notifier filter this patch adds. I personally like it very much
either because I know users only expect to run those one or several
handlers they added or cared about, from discussing reported cases
realted to them, just as you said.

Now comments to patch lean to split and classify the current panic
notifiers list into two or several sub-lists and execute them in
different order. I think this improvement will benefit people who
defaults to execute all panic notifiers, while the panic notifier
fileter is also very helpful if can be added.

Hope I got you right, HATAYAMA. And thanks a lot for your quick
response.

