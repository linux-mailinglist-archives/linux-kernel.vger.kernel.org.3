Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065344B5231
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiBNNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:54:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiBNNyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:54:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE0565A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:54:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 25ABD1F38C;
        Mon, 14 Feb 2022 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644846854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2o7MEUIkoygVgLeQ0bNCev85H24dkeL8bX3B9U4B08=;
        b=QwGWEUa0R6RurWrTbcNK5iokHhXau98F8dWQ9GNJyaRX73zMj8cyxDLXIl3DVjNRhU1t4T
        Djk2L+ARgHyPXFDgdkBo2o8+cwhbEuZ6Sg2wqCO38zy8QacQIJdEqWv20ZtSXYgbEqRywl
        Jcy16q1OsOxHdBj2op6KJITVd+nCjjo=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD972A3B83;
        Mon, 14 Feb 2022 13:54:13 +0000 (UTC)
Date:   Mon, 14 Feb 2022 14:54:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 0/4] printk: reduce deadlocks during panic
Message-ID: <YgpfAsC1EZSbpDOv@alley>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
 <YgTZPQEay6T/nhu6@alley>
 <8f08bb64-ee8a-9555-f4a1-6d55d3c77531@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f08bb64-ee8a-9555-f4a1-6d55d3c77531@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-10 12:06:44, Stephen Brennan wrote:
> On 2/10/22 01:22, Petr Mladek wrote:
> > On Wed 2022-02-02 09:18:17, Stephen Brennan wrote:
> > > When a caller writes heavily to the kernel log (e.g. writing to
> > > /dev/kmsg in a loop) while another panics, there's currently a high
> > > likelihood of a deadlock (see patch 2 for the full description of this
> > > deadlock).
> > > 
> > > The principle fix is to disable the optimistic spin once panic_cpu is
> > > set, so the panic CPU doesn't spin waiting for a halted CPU to hand over
> > > the console_sem.
> > > 
> > > However, this exposed us to a livelock situation, where the panic CPU
> > > holds the console_sem, and another CPU could fill up the log buffer
> > > faster than the consoles could drain it, preventing the panic from
> > > progressing and halting the other CPUs. To avoid this, patch 3 adds a
> > > mechanism to suppress printk (from non-panic-CPU) during panic, if we
> > > reach a threshold of dropped messages.
> > > 
> > > A major goal with all of these patches is to try to decrease the
> > > likelihood that another CPU is holding the console_sem when we halt it
> > > in panic(). This reduces the odds of needing to break locks and
> > > potentially encountering further deadlocks with the console drivers.
> > > 
> > > To test, I use the following script, kmsg_panic.sh:
> > > 
> > >      #!/bin/bash
> > >      date
> > >      # 991 chars (based on log buffer size):
> > >      chars="$(printf 'a%.0s' {1..991})"
> > >      while :; do
> > >          echo $chars > /dev/kmsg
> > >      done &
> > >      echo c > /proc/sysrq-trigger &
> > >      date
> > >      exit
> > > 
> > > I defined a hang as any time the system did not reboot to a login prompt
> > > on the serial console within 60 seconds. Here are the statistics on
> > > hangs using this script, before and after the patch.
> > > 
> > > before:  776 hangs / 1484 trials - 52.3%
> > > after :    0 hangs /  15k trials -  0.0%
> > > 
> > > Stephen Brennan (4):
> > >    printk: Add panic_in_progress helper
> > >    printk: disable optimistic spin during panic
> > >    printk: Avoid livelock with heavy printk during panic
> > >    printk: Drop console_sem during panic
> > > 
> > >   kernel/printk/printk.c | 55 +++++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 54 insertions(+), 1 deletion(-)
> > 
> > For the entire patchset:
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > 
> > It looks ready for linux-next from my POV. I am going to push it early
> > next week unless anyone complains in the meantime.

The patchset is committed in printk/linux.git, branch for-5.18-panic-deadlocks.

> Thank you Petr! It occurs to me that some of this could be stable-worthy,
> depending on your feelings on it. Patches 1-3 resolve real bugs on customer
> systems, and they'd apply back a decent way. 1-2 apply all the way back to
> 4.14, and 3 would apply with some minor changes. I suppose the question is
> whether they are simple enough. Patch 4 is useful but I don't have a real
> reproducer for a bug it fixes, so I wouldn't say it's stable worthy.

Good question. If you saw these deadlocks on customer systems in
the real life then it might be worth it.

I newer saw them. But they hard to debug and report. Also they are
visible only when CPUs are stopped by NMI. And the default
smp_send_stop() tries to stop CPUs using normal IRQ first.

Anyway, the patches 1,2,4 are pretty straightforward and should be
safe. Feel free to send them to stable.

3rd patch is a heuristic. It tries to prevent livelock and the cost
is a possible loss of information. I am not 100% sure that it will
do the right thing in all situations. I would wait one or two release
cycles before we backport it to older stable releases.


> Of course we have the logbuf_lock in 5.10 and previous, and if a CPU is
> halted holding that lock, then printk hangs even before the optimistic
> spinning. I have patches which reinitialize those locks after the CPUs are
> halted if necessary. I think they are reasonable for stable - printk is
> guaranteed to hang without doing this, so in the worst case you trade a hang
> during a panic, with some other sort of printk log buffer bug during a
> panic. But in the common case, you eliminate the hang. I can send that patch
> to linux-stable as well.

The main problem is that the locks can be safely re-initialized only
when the other CPUs were stopped using NMI. Otherwise, there is
a risk of double unlock. Such a patch would need to be arch-dependent.

Also stable people do not like much solutions that were not used
in the mainline. So, it might be a waste of time.

Best Regards,
Petr
