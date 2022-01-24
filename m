Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5D498192
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiAXN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:59:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237643AbiAXN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643032786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qwdt38c71LuRfMSTFCZBXvK1kWOIFl6aKokcJctMaAY=;
        b=dIF2a93L0JPg9ph4sRJHbss+sAEthpqAEfzAw8WYG91cS3zIZ7qGJZO2m3gGXxCHxXIUPt
        Ctt8jbPWRerptp9I3qaqRt+IMM/b17kree3xBWCcEwJY6IcWxy01bV2+AqZ3iI5JOF+L5K
        +vJzMjru/8Pun7/DC2TLDJ9JVTN+RCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-wEa5CxBANt2ra5d-YXmIXA-1; Mon, 24 Jan 2022 08:59:43 -0500
X-MC-Unique: wEa5CxBANt2ra5d-YXmIXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 698F8100C664;
        Mon, 24 Jan 2022 13:59:40 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 572E3798B5;
        Mon, 24 Jan 2022 13:59:10 +0000 (UTC)
Date:   Mon, 24 Jan 2022 21:59:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, dyoung@redhat.com,
        linux-doc@vger.kernel.org, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, mikelley@microsoft.com
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <20220124135902.GB8305@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley>
 <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
 <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/23/22 at 10:07pm, Masami Hiramatsu wrote:
> On Sat, 22 Jan 2022 18:55:14 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > On 01/21/22 at 05:31pm, Guilherme G. Piccoli wrote:
> > ......
> > > > IMHO, the right solution is to split the callbacks into 2 or more
> > > > notifier list. Then we might rework panic() to do:
> > > > 
> > > > void panic(void)
> > > > {
> > > > 	[...]
> > > > 
> > > > 	/* stop watchdogs + extra info */
> > > > 	atomic_notifier_call_chain(&panic_disable_watchdogs_notifier_list, 0, buf);
> > > > 	atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> > > > 	panic_print_sys_info();
> > > > 
> > > > 	/* crash_kexec + kmsg_dump in configurable order */
> > > > 	if (!_crash_kexec_post_kmsg_dump) {
> > > > 		__crash_kexec(NULL);
> > > > 		smp_send_stop();
> > > > 	} else {
> > > > 		crash_smp_send_stop();
> > > > 	}
> > > > 
> > > > 	kmsg_dump();
> > > > 	if (_crash_kexec_post_kmsg_dump)
> > > > 		__crash_kexec(NULL);
> > > > 
> > > > 	/* infinite loop or reboot */
> > > > 	atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> > > > 	atomic_notifier_call_chain(&panic_rest_notifier_list, 0, buf);
> > > > 
> > > > 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > > > [...] 
> > > > Two notifier lists might be enough in the above scenario. I would call
> > > > them:
> > > > 
> > > > 	panic_pre_dump_notifier_list
> > > > 	panic_post_dump_notifier_list
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
> 
> No, that looks good idea to me. BTW, the 'dump' in the new notifieers
> means both kmsg_dump and crash dump, right?

Thanks for quick response, Masa.

I guess it's crash dump, namely kdump.

About pre_dump, if the dump is crash dump, hope those pre_dump notifiers
will be executed under conditional check, e.g only if 'crash_kexec_post_notifiers'
is specified in kernel cmdline. 

