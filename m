Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2864BB972
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiBRMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:52:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiBRMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:52:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9631129C119;
        Fri, 18 Feb 2022 04:52:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA9FE1F37E;
        Fri, 18 Feb 2022 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645188748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S4IZUhjyn1DHXSRgbOfbbnOadkzvb3ybW3FaLTMPVUc=;
        b=DJo7j+eYEv6tDBrb+EJzaquW1aG6cQiFQXpw2eWsXi+7nkwUyADoCIi63VeIKPocuNHeHz
        7uOoFs+vzzzRJhEvVQruWz6C8JNytup98z76EcPo/ugXo0g37RI7NjBz3fakVv4tTf2/wX
        rV5gImHMPmSCAaGf3LeBKCZqaQ3PExY=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B43CFA3B85;
        Fri, 18 Feb 2022 12:52:26 +0000 (UTC)
Date:   Fri, 18 Feb 2022 13:52:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Corey Minyard <cminyard@mvista.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>, Tejun Heo <tj@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH printk v1 09/13] printk: add functions to allow direct
 printing
Message-ID: <Yg+Wh45hckprBxdp@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-10-john.ogness@linutronix.de>
 <Yg5FCVF5c1jDo116@alley>
 <ca5b7ec96aa444c292b3413a6374028b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5b7ec96aa444c292b3413a6374028b@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-18 09:00:46, David Laight wrote:
> > On Mon 2022-02-07 20:49:19, John Ogness wrote:
> > > Once kthread printing is introduced, console printing will no longer
> > > occur in the context of the printk caller. However, there are some
> > > special contexts where it is desirable for the printk caller to
> > > directly print out kernel messages.
> 
> Yes - most of them.
> 
> It is going to be pretty impossible to do 'hard' kernel debugging
> if printk get deferred.

What do you exactly mean by 'hard' kernel debugging, please?
What exactly won't be possible, please?

It is really important to talk about real scenarios because we
do our best to address them. This patchset disables the deferred
console handling in several situations, especially during panic,
reboot, kexec. The consoles are flushed during suspend, etc.

The patchset solves real problems, soft and live-lockups and even
deadlocks.

It will actually allow debugging when too many messages caused
softlockups and the system died. I saw it many times during boot
of systems with many network interfaces or disks. Backtraces
from all CPUs and processes, detailed Oops reports, and similar
extensive output was able to kill the system.

In each case, the legacy "direct" mode will still be around.


> Typically there already is a deferral method.
> The prints aren't done by the kernel, but by syslogd.

syslogd helps only when userspace works and the messages
can be stored on a filesystems.

And it is perfectly fine and much more safe to defer consoles
most of the time. I have seen many reports where consoles put
the system into knees. And sometime printk() was the root of all
problems.

Best Regards,
Petr
