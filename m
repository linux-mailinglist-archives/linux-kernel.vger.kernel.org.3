Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477D85813EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiGZNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiGZNLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:11:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCD6DFE6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:11:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B6EE737B5B;
        Tue, 26 Jul 2022 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658841081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N0Mf3w6yvzM2MyutV14ToAE1WBe4fAbVJxUolfAEBcI=;
        b=WXOpgB+9SBbSRZ0AxRZbKT5tcXqes56BWtDjdda8s/wHC7uJqDqIVIstF2yj4/kyafF1nz
        lpr+hu0seFBot1Q872Z6aXlcKmJeh4/pWCiCJfG6q5bJN4n3KlkcaW2GOGOe3X4aocvAMP
        zOAaEYtvbJGvUogwk4dhgH+FQVw+XAM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A55A2C141;
        Tue, 26 Jul 2022 13:11:21 +0000 (UTC)
Date:   Tue, 26 Jul 2022 15:11:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <Yt/n9yahzBkgvqhv@alley>
References: <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
 <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley>
 <YtrYdXWGb0NQLKNA@linutronix.de>
 <Yt6MzEEFfpyTBIIj@alley>
 <Yt6gxxRxDZ/wFHrA@linutronix.de>
 <Yt6nlaSrfZ+fn80x@alley>
 <Yt6zwP9xSdUhsoQ9@linutronix.de>
 <871qu8i9vw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qu8i9vw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-07-26 10:03:39, John Ogness wrote:
> On 2022-07-25, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > printk might be invoked in a context with disabled interrupts and or
> > preemption and additionally disables interrupts before it invokes the
> > console drivers. This behaviour is not desired on PREEMPT_RT:
> > - The console driver are using spinlock_t based locking which become sleeping
> >   locks on PREEMPT_RT and must not be acquired with disabled interrupts (or
> >   preemption).
> >
> > - The locks within the console drivers must remain sleeping locks and they must
> >   not disable interrupts. Printing (and polling for its completion) at 115200
> >   baud on an UART takes too long for PREEMPT_RT in general and so raises the
> >   latency of the IRQ-off time of the system beyond acceptable levels.
> >
> > Skip printing to the console as temporary workaround until the printing threads
> > and atomic consoles have been introduced or another solution which is
> > compatible with the PREEMPT_RT approach.
> > With this change, the user will not see any kernel message printed to the
> > console but can retrieve the printk buffer from userland (via the dmesg
> > command). This allows enable PREEMPT_RT as a whole without disabling printk and
> > loosing all kernel output.
> 
> Note that "the dmesg command" is not the only userspace tool to access
> the kernel logs. Logging daemons (using /proc/kmsg or /dev/kmsg) also
> have full access.

I have updated the message when comitting, see
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=rework/kthreads&id=c01c1c784a02aaa216524977b294b8834d0ee907


> > Disable console printing on PREEMPT_RT.
> >
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

JFYI, the patch has been committed into printk/linux.git, branch
rework/kthreads. I am going to add it into the pull request for 5.20.

Best Regards,
Petr
