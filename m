Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A020497195
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 14:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbiAWNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 08:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiAWNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 08:07:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DCDC06173B;
        Sun, 23 Jan 2022 05:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 626C060C3E;
        Sun, 23 Jan 2022 13:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E0EC340E2;
        Sun, 23 Jan 2022 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642943239;
        bh=BxRaDiPr6cRH66AV0Yija/RCD3QlZ9vVEudJ4scQQsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hwgKvPwuYEaOu2BKbuEUJ7Kp32LDYAg8qNugAprE0WJ0/8mYe6+K5qR7pBs62wekG
         HtDv8yrJuf4JYknNquvuFYt9dZysD7QlxpPy5OzipBYcXuOiNGtzMuRh0+dFy0vmla
         E/Ody41EjcVaCjtkhtnx1aLos+tftHIBAsAKUkYsejbilA2B3bF/UDovsj71oSbw1E
         eucnld3DDKIDsLRjTUB6Xg+vinQ8hZKdJjqtBtLJf54obVQBGUPVd/+ZvgT1qfFQnL
         v/+9nyfG33d7MU5XqUSUxGyT6lYJzfmoctDjd2znIrPLdMv6eD4WaOm+3PnspeWHsA
         c1cmlGcQOTG3A==
Date:   Sun, 23 Jan 2022 22:07:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Baoquan He <bhe@redhat.com>
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
Message-Id: <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
In-Reply-To: <20220122105514.GA18258@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
        <Yel8WQiBn/HNQN83@alley>
        <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
        <20220122105514.GA18258@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2022 18:55:14 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 01/21/22 at 05:31pm, Guilherme G. Piccoli wrote:
> ......
> > > IMHO, the right solution is to split the callbacks into 2 or more
> > > notifier list. Then we might rework panic() to do:
> > > 
> > > void panic(void)
> > > {
> > > 	[...]
> > > 
> > > 	/* stop watchdogs + extra info */
> > > 	atomic_notifier_call_chain(&panic_disable_watchdogs_notifier_list, 0, buf);
> > > 	atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> > > 	panic_print_sys_info();
> > > 
> > > 	/* crash_kexec + kmsg_dump in configurable order */
> > > 	if (!_crash_kexec_post_kmsg_dump) {
> > > 		__crash_kexec(NULL);
> > > 		smp_send_stop();
> > > 	} else {
> > > 		crash_smp_send_stop();
> > > 	}
> > > 
> > > 	kmsg_dump();
> > > 	if (_crash_kexec_post_kmsg_dump)
> > > 		__crash_kexec(NULL);
> > > 
> > > 	/* infinite loop or reboot */
> > > 	atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> > > 	atomic_notifier_call_chain(&panic_rest_notifier_list, 0, buf);
> > > 
> > > 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > > [...] 
> > > Two notifier lists might be enough in the above scenario. I would call
> > > them:
> > > 
> > > 	panic_pre_dump_notifier_list
> > > 	panic_post_dump_notifier_list
> > > 
> > > 
> > > It is a real solution that will help everyone. It is more complicated now
> > > but it will makes things much easier in the long term. And it might be done
> > > step by step:
> > > 
> > >      1. introduce the two notifier lists
> > >      2. convert all users: one by one
> > >      3. remove the original notifier list when there is no user
> > 
> > That's a great idea! I'm into it, if we have a consensus. The thing that
> > scares me most here is that this is a big change and consumes time to
> > implement - I'd not risk such time if somebody is really against that.
> > So, let's see more opinions, maybe the kdump maintainers have good input.
> 
> I am fine with it. As long as thing is made clear, glad to see code is
> refactored to be more understandable and improved. Earlier, during several
> rounds of discussion between you and Petr, seveal pitfalls have been
> pointed out and avoided.
> 
> Meanwhile, I would suggest Masa and HATAYAMA to help give input about
> panic_notifier usage and refactory. AFAIK, they contributed code and use
> panic_notifier in their product or environment a lot, that will be very
> helpful to get the first hand information from them.
> 
> Hi Masa, HATAYANA,
> 
> Any comment on this? (Please ignore this if it's not in your care.)

No, that looks good idea to me. BTW, the 'dump' in the new notifieers
means both kmsg_dump and crash dump, right?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
