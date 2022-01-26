Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E549CBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiAZOMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiAZOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:12:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:12:39 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id b22so4519569qkk.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lxu46fUJphMRNCSfh1Qqsq++04SotYZqK+vowd5Awcg=;
        b=K9IyeVxrsUlG2X0EaqgV1ug24dDJJX3qt85LjlPi0F9+bklBdHXGzRsmclJ5rP8HoI
         7wNda+3KgsQ6SmT29Qk3IGiV05ErUCavbNMKQeVB7iiDoN8pKsKa5eS/N2/u2P4ZEq3x
         klt1iE+qt98igMCFiL0QJbIlObhnZhygyksZV+tCNl6vcxTw/f1H1mNwgoZTsTEk73JQ
         t6ntMpiq2EAwoQKEb9oAd44w7eswJMMPwG1BRIQSzALN4xRB/66ShbArsLCetAfJxXNX
         CLAIkSu5HPFLEakCxX5hEKelFtFE9Xr76ddv4d3Zstz9JYhXuI4E+HQOQW3NRQbwFIU3
         pNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=lxu46fUJphMRNCSfh1Qqsq++04SotYZqK+vowd5Awcg=;
        b=604KnT6VeTnU36ObLl7EQ7b1DmtGg9gwcR0W1oPXyZJnclHywSehC3E7614Bx6wQPO
         a8q2W6FhJocDyxMkx4NiHrBHx+XpuMII8CgYGbON5yVCPhFeFe27QOeUhJO9MqU1eY6Z
         ti2sCV4wANW59+XHEjqJYpZzqOYFGzrJgjgjK1dSullRwEK/6hGdRcDbV7nDACZRixgC
         VzWax3qelJnabiZSnheMQUU/OuKx9fFdI/muJH+EXcRgEJE71hhtKiPUJsyg8ohL5M87
         yyVt8h9LaW/kWke/IGOJhBttgritLVtH1NFqY2ygtCY//iHv/TVfdv690lAy5Ft2FLgP
         chxQ==
X-Gm-Message-State: AOAM53323hnu71HyWEpAp1KX4JWJqUW+NwYz9emTEGVZn9jqc8uq6Edy
        6tjk9VsOE9uakrVmi0XwBA==
X-Google-Smtp-Source: ABdhPJw9iTinf1Bd7Q3d6FBdpCbvGKwMcZF7Qpg7dUE6VpxHEdDFxPJdrvp1fyO8holkcHVxWndwQg==
X-Received: by 2002:a05:620a:2914:: with SMTP id m20mr1799690qkp.690.1643206357857;
        Wed, 26 Jan 2022 06:12:37 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id br11sm10887638qkb.118.2022.01.26.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:12:37 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:4de2:5f2e:d934:1026])
        by serve.minyard.net (Postfix) with ESMTPSA id 777D41800B9;
        Wed, 26 Jan 2022 14:12:36 +0000 (UTC)
Date:   Wed, 26 Jan 2022 08:12:35 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible reproduction of CSD locking issue
Message-ID: <20220126141235.GT34919@minyard.net>
Reply-To: minyard@acm.org
References: <20220125182737.GO34919@minyard.net>
 <4609fe56-7d88-8176-a378-0f465670b37d@suse.com>
 <20220126135639.GS34919@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135639.GS34919@minyard.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 07:56:43AM -0600, Corey Minyard wrote:
> On Wed, Jan 26, 2022 at 07:08:22AM +0100, Juergen Gross wrote:
> > On 25.01.22 19:27, Corey Minyard wrote:
> > > We have a customer that had been seeing CSD lock issues on a Centos 7
> > > kernel (unfortunately).  I couldn't find anything or any kernel changes
> > > that might fix it, so I was consdering it was the CSD locking issue you
> > > have been chasing for a while.
> > 
> > Is this on bare metal or in a virtualized environment?
> 
> This is bare metal.
> 
> I do think I know what happened.  Here's my analysis...

Well, never mind, I missed that preemption is disabled in this code.
The lack of pinged entries is still a little confusing.

-corey

> 
> csd: Detected non-responsive CSD lock (#1) on CPU#3, waiting 5000000042 ns for CPU#55 flush_tlb_func+0x0/0xb0(0xffff8e0b3e2afbe8).
>  csd: CSD lock (#1) unresponsive.
>  csd: cnt(0000000): 0000->0000 queue
>  csd: cnt(0000001): ffff->0037 idle
> 
> The above means that these events weren't seen, I think.  We can
> ignore them in any case.
> 
>  csd: cnt(63d8dd8): 0003->0037 ipi
>  csd: cnt(63d8dd9): 0003->0037 ping
>  csd: cnt(63d8dda): 0003->ffff pinged
> 
> This is a little confusing.  The first two lines have to be from
> __smp_call_single_queue_debug.  The last line has to be from
> smp_call_function_many.  But you never see the pinged from
> __smp_call_single_queue_debug.
> 
>  csd: cnt(63d8dea): 0035->0037 pinged
> 
> The tail of CPU 53 sending an IPI to CPU 55 in
> __smp_call_single_queue_debug.
> 
>  csd: cnt(63d8deb): ffff->0037 gotipi
>  csd: cnt(63d8dec): ffff->0037 handle
>  csd: cnt(63d8ded): ffff->0037 dequeue (src CPU 0 == empty)
>  csd: cnt(63d8dee): ffff->0037 hdlend (src CPU 0 == early)
> 
> CPU 55 is handling the IPI(s) it was sent earlier.
> 
>  csd: cnt(63d8e1f): 0003->0037 queue
>  csd: cnt(63d8e20): 0003->0037 ipi
>  csd: cnt(63d8e21): 0003->0037 ping
> 
> In __smp_call_single_queue_debug CPU 3 sends another message to
> CPU 55 and sends an IPI.  But there should be a pinged entry
> after this.
> 
>  csd: cnt(63d8e22): 0003->0037 queue
>  csd: cnt(63d8e23): 0003->0037 noipi
> 
> In __smp_call_single_queue_debug CPU 3 sends another message to
> CPU 55, but no IPI is required because one is already pending.
> 
> I deleted the timestamps and the rest of the log, but a second
> IPI is sent and CPU 55 wakes up immediately.  That tells me that
> CPU 55 wasn't stuck for some reason (interrupt storm, long time
> with interrupts disabled).  Though maybe not, with your insight
> below?
> 
> Looking at the code, it appears this code runs with interrupts and
> preemption enabled, so they can be switched out at any time here.  I can
> only see one possibility from the above sequence:
> 
> * CPU 3 queues the list item but is switched out before sending
>   the IPI (no pinged in the sequence).
> 
> * Another thread on CPU 3 is switched in and finishes a send
>   many.
> 
> * CPU 53 sends an IPI to CPU 55 and wakes it up.
> 
> * CPU 55 handles the IPI.
> 
> * Another thread on CPU 3 then sends another message to CPU 55,
>   enqueues the link, but is switched out before actually sending
>   the IPI (again, no pinged in the sequence).
> 
> * Yet another thread on CPU 3 sends a message, but the item
>   is already queued and thus it does not send an IPI.
> 
> * Something on CPU 3 prevents the first two threads from sending
>   the IPI.
> 
> So assuming it's not a hardware bug, it appears the problem is
> process starvation on CPU 3.  Knowing our customer's
> architecture, this is actually a possibility.  This could be
> pretty easily solved by turning off interrupts (or preemption?) around
> the code that enqueues the link and sends the IPI.
> 
> > 
> > The bug I was hunting occurred when running under Xen, and in the end I
> > found a scheduling problem in the Xen hypervisor.
> > 
> > > 
> > > So I backported the debug patches.  And of course, they stopped seeing
> > > the issue, at least as much, and they had trouble with the extra CPU
> > > time the debug code took.  But they just reproduced it.  Here are the
> > > logs:
> > > 
> > > Jan 23 23:39:43 worker0 kernel: [285737.522743] csd: Detected non-responsive CSD lock (#1) on CPU#3, waiting 5000000042 ns for CPU#55 flush_tlb_func+0x0/0xb0(0xffff8e0b3e2afbe8).
> > > Jan 23 23:39:43 worker0 kernel: [285737.522744]  csd: CSD lock (#1) unresponsive.
> > > Jan 23 23:39:43 worker0 kernel: [285737.522747]  csd: cnt(0000000): 0000->0000 queue
> > > Jan 23 23:39:43 worker0 kernel: [285737.522748]  csd: cnt(0000001): ffff->0037 idle
> > > Jan 23 23:39:43 worker0 kernel: [285737.522749]  csd: cnt(63d8dd8): 0003->0037 ipi
> > > Jan 23 23:39:43 worker0 kernel: [285737.522750]  csd: cnt(63d8dd9): 0003->0037 ping
> > > Jan 23 23:39:43 worker0 kernel: [285737.522750]  csd: cnt(63d8dda): 0003->ffff pinged
> > > Jan 23 23:39:43 worker0 kernel: [285737.522751]  csd: cnt(63d8dea): 0035->0037 pinged
> > > Jan 23 23:39:43 worker0 kernel: [285737.522752]  csd: cnt(63d8deb): ffff->0037 gotipi
> > > Jan 23 23:39:43 worker0 kernel: [285737.522752]  csd: cnt(63d8dec): ffff->0037 handle
> > > Jan 23 23:39:43 worker0 kernel: [285737.522753]  csd: cnt(63d8ded): ffff->0037 dequeue (src CPU 0 == empty)
> > > Jan 23 23:39:43 worker0 kernel: [285737.522754]  csd: cnt(63d8dee): ffff->0037 hdlend (src CPU 0 == early)
> > > Jan 23 23:39:43 worker0 kernel: [285737.522754]  csd: cnt(63d8e1f): 0003->0037 queue
> > > Jan 23 23:39:43 worker0 kernel: [285737.522755]  csd: cnt(63d8e20): 0003->0037 ipi
> > > Jan 23 23:39:43 worker0 kernel: [285737.522756]  csd: cnt(63d8e21): 0003->0037 ping
> > > Jan 23 23:39:43 worker0 kernel: [285737.522756]  csd: cnt(63d8e22): 0003->0037 queue
> > > Jan 23 23:39:43 worker0 kernel: [285737.522757]  csd: cnt(63d8e23): 0003->0037 noipi
> > > Jan 23 23:39:43 worker0 kernel: [285737.522757]  csd: cnt now: 63fe4cd
> > > Jan 23 23:39:43 worker0 kernel: [285737.522758] Task dump for CPU 55:
> > > Jan 23 23:39:43 worker0 kernel: [285737.522761] kubelet         R  running task        0 277695      1 0x00080000
> > > Jan 23 23:39:43 worker0 kernel: [285737.522761] Call Trace:
> > > Jan 23 23:39:43 worker0 kernel: [285737.522769]  [<ffffffff84376b6a>] ? __schedule+0x46a/0x990
> > > Jan 23 23:39:43 worker0 kernel: [285737.522774]  [<ffffffff83db6353>] ? context_tracking_user_enter+0x13/0x20
> > > Jan 23 23:39:43 worker0 kernel: [285737.522776]  [<ffffffff843775b5>] ? schedule_user+0x45/0x50
> > > Jan 23 23:39:43 worker0 kernel: [285737.522779]  [<ffffffff8437b518>] ? retint_careful+0x16/0x34
> > > Jan 23 23:39:43 worker0 kernel: [285737.522780] csd: Re-sending CSD lock (#1) IPI from CPU#03 to CPU#55
> > > Jan 23 23:39:43 worker0 kernel: [285737.522788] CPU: 3 PID: 54671 Comm: runc:[2:INIT] Kdump: loaded Tainted: G           OE  ------------ T 3.10.0-1062.12.1.rt56.1042.mvista.test.14.el7.x86_64 #1
> > > Jan 23 23:39:43 worker0 kernel: [285737.522789] Hardware name: Dell Inc. PowerEdge R740/0YWR7D, BIOS 2.9.4 11/06/2020
> > > Jan 23 23:39:43 worker0 kernel: [285737.522789] Call Trace:
> > > Jan 23 23:39:43 worker0 kernel: [285737.522793]  [<ffffffff843718ba>] dump_stack+0x19/0x1b
> > > Jan 23 23:39:43 worker0 kernel: [285737.522798]  [<ffffffff83d0bcd8>] __csd_lock_wait+0x1a8/0x2a0
> > > Jan 23 23:39:43 worker0 kernel: [285737.522800]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
> > > Jan 23 23:39:43 worker0 kernel: [285737.522802]  [<ffffffff83d0bfa4>] smp_call_function_single+0xc4/0x1b0
> > > Jan 23 23:39:43 worker0 kernel: [285737.522804]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
> > > Jan 23 23:39:43 worker0 kernel: [285737.522809]  [<ffffffff83e2684b>] ? page_counter_uncharge+0x3b/0x70
> > > Jan 23 23:39:43 worker0 kernel: [285737.522811]  [<ffffffff83d0c614>] smp_call_function_many+0x344/0x380
> > > Jan 23 23:39:43 worker0 kernel: [285737.522813]  [<ffffffff83c6d870>] ? leave_mm+0x120/0x120
> > > Jan 23 23:39:43 worker0 kernel: [285737.522816]  [<ffffffff83c6da38>] native_flush_tlb_others+0xb8/0xc0
> > > Jan 23 23:39:43 worker0 kernel: [285737.522818]  [<ffffffff83c6dc25>] flush_tlb_page+0x65/0xf0
> > > Jan 23 23:39:43 worker0 kernel: [285737.522821]  [<ffffffff83dfdf98>] ptep_clear_flush+0x68/0xa0
> > > Jan 23 23:39:43 worker0 kernel: [285737.522825]  [<ffffffff83de6806>] wp_page_copy.isra.83+0x3d6/0x650
> > > Jan 23 23:39:43 worker0 kernel: [285737.522828]  [<ffffffff83de8cb4>] do_wp_page+0xb4/0x710
> > > Jan 23 23:39:43 worker0 kernel: [285737.522832]  [<ffffffff83decbb4>] handle_mm_fault+0x884/0x1340
> > > Jan 23 23:39:43 worker0 kernel: [285737.522835]  [<ffffffff83cd7799>] ? update_cfs_shares+0xa9/0xf0
> > > Jan 23 23:39:43 worker0 kernel: [285737.522839]  [<ffffffff8437efc3>] __do_page_fault+0x213/0x5a0
> > > Jan 23 23:39:43 worker0 kernel: [285737.522841]  [<ffffffff8437f385>] do_page_fault+0x35/0x90
> > > Jan 23 23:39:43 worker0 kernel: [285737.522842]  [<ffffffff8437b728>] page_fault+0x28/0x30
> > > Jan 23 23:39:43 worker0 kernel: [285737.522845] csd: CSD lock (#1) got unstuck on CPU#03, CPU#55 released the lock.
> > > 
> > > Hopefully this is the issue you are chasing and not something else.
> > > I've been studying them to see what they mean, but I thought you might
> > > be interested to get them asap.
> > 
> > As said before: I've solved my problem.
> > 
> > But I can share some more insight from my experience:
> > 
> > Don't be so sure that resending the IPI woke up the cpu again. It might
> > have been the NMI for getting the target cpu's stacktrace which resulted
> > in letting it run again. I missed this possibility in the beginning and
> > this was the reason I dismissed the Xen scheduling issue too early.
> 
> Hmm.  That's non-obvious, obviously.  I'm not sure how sending an NMI
> would unstick something like this, but I'll take your word for it.
> I think my above analysis is correct based on the sequence, but this
> gives me something else to consider.
> 
> Thanks for the input.
> 
> -corey
> 
> > 
> > 
> > Juergen
> 
> 
> 
> 
> 
