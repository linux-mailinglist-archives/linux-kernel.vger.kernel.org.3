Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C335E49DB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiA0HLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiA0HLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:11:14 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF58CC061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:11:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso2010013pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=noaURUrWbPwzNRZlyxodQ8+33Irhpfo3p/xSxNFsPFU=;
        b=Dr7fPgtlngB2582f8olZutBv0UnekVmOMR4fU86q0a8Vl887x8vxCV8ILVqyGyIV7H
         74LjppVVHiQdi7hnV4mZQAqj8qiUjJ/T+XrC/09ARNyIBBO6yvnYK25SU4Ko7x16gOM0
         f0SzViAs/Fh/vuXWO6vx1iNT36l8T0pdA03Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=noaURUrWbPwzNRZlyxodQ8+33Irhpfo3p/xSxNFsPFU=;
        b=m6DIsbniZl3OaqRmZCOKj6IEfq6jDu/hZ10tClUE7B44SJOoJZv1KEVmlXaheEgDJZ
         32a2ueqqbxag3jTn10YaxdlJ82TagXP2fc3xTyv8bppqLjb+lCG+oRIqOybbIqjYcVRm
         cI60ABSTgnAOtwqmCqFREkm3yxcUHhNzdAmNyFtqCRs9doFkIAfOVZCcLLIDmeuGEKfa
         7aosOLXhrUUUn3b6jKqzlTMavBY3k49vIfFVRcExdh8aPlnaL8JXTMtayP8vSVcbiE1W
         3PkoeezWw6XZ9PSFaZtW19YHIg/fZoJeJbfYtJtRXRRBK8+WVrcIY2bB/E4GJ8v2Bu1t
         LuDg==
X-Gm-Message-State: AOAM532mfD2jBoCvA/s4zLlX508KhKttyCpAG0UI4UubNI6hWTUgnrdQ
        d7jYtulzs2Yk6vwWWPdDbccJgA==
X-Google-Smtp-Source: ABdhPJz/vKmToykJxK7R8jfZqcOZJcXR6Wrou59KMXcVzctzEpVHT7mDZKoTXMIf6o77/DZX2GIl1w==
X-Received: by 2002:a17:902:6848:: with SMTP id f8mr2072800pln.54.1643267473146;
        Wed, 26 Jan 2022 23:11:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7955:6326:bdc1:2adf])
        by smtp.gmail.com with ESMTPSA id qe12sm5241477pjb.14.2022.01.26.23.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 23:11:12 -0800 (PST)
Date:   Thu, 27 Jan 2022 16:11:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
Message-ID: <YfJFjHdg/khNXiRd@google.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
 <YfER7tlXZZpX94c9@google.com>
 <87r18un83x.fsf@jogness.linutronix.de>
 <YfEdNKWI7GqKr9P/@google.com>
 <87tudqwegy.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tudqwegy.fsf@stepbren-lnx.us.oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/01/26 10:15), Stephen Brennan wrote:
[..]
> > On (22/01/26 10:51), John Ogness wrote:
> >> > Is there something that prevents panic CPU from NMI hlt CPU which is
> >> > in console_trylock() under raw_spin_lock_irqsave()?
> >> >
> >> >  CPU0				CPU1
> >> > 				console_trylock_spinnning()
> >> > 				 console_trylock()
> >> > 				  down_trylock()
> >> > 				   raw_spin_lock_irqsave(&sem->lock)
> >> >
> >> >  panic()
> >> >   crash_smp_send_stop()
> >> >    NMI 			-> 		HALT
> >> 
> >> This is a good point. I wonder if console_flush_on_panic() should
> >> perform a sema_init() before it does console_trylock().
> >
> > A long time ago there was zap_locks() function in printk, that used
> > to re-init console semaphore and logbuf spin_lock, but _only_ in case
> > of printk recursion (which was never reliable)
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/printk/printk.c?h=v4.9.297#n1557
> >
> > This has been superseded by printk_safe per-CPU buffers so we removed
> > that function.
> >
> > So it could be that may be we want to introduce something similar to
> > zap_locks() again.
> >
> > All reasonable serial consoles drivers should take oops_in_progress into
> > consideration in ->write(), so we probably don't care for console_drivers
> > spinlocks, etc. but potentially can do a bit better on the printk side.
> 
> I see the concern here. If a CPU is halted while holding
> console_sem.lock spinlock, then the very next printk would hang, since
> each vprintk_emit() does a trylock.

Right. So I also thought about placing panic_in_progress() somewhere in
console_trylock() and make it fail for anything that is not a panic CPU.

> Now in my thousands of iterations of tests, I haven't been lucky enough
> to interrupt a CPU in the middle of this critical section. The critical
> section itself is incredibly short and so it's hard to do it. Not
> impossible, I'd imagine.

I can imagine that the race window is really small, and I'm not insisting
on fixing it right now (or ever for that matter).

Basically, we now have two different "something bad is in progress"
that affect two different ends of the calls stack. bust_spinlocks()
sets oops_in_progress and affects console drivers' spinlocks, but has
no meaning to any other printk locks. And then we have panic_in_progress()
which is meaningful to some printk locks, but not to all of them, and is
meaningless to console drivers, because those look at oops_in_progress.

If printk folks are fine with that then I'm also fine.

> We can't fix it in console_flush_on_panic(), because that is called much
> later, after we've called the panic notifiers, which definitely
> printk(). If we wanted to re-initialize the console_sem, we'd want it
> done earlier in panic(), directly after the NMI was sent.

Right.

> My understanding was that we can't be too cautious regarding the console
> drivers. Sure, they _shouldn't_ have any race conditions, but once we're
> in panic we're better off avoiding the console drivers unless it's our
> last choice. So, is it worth re-initializing the console_sem early in
> panic, which forces all the subsequent printk to go out to the consoles?
> I don't know.
>
> One alternative is to do __printk_safe_enter() at the beginning of
> panic. This effectively guarantees that no printk will hit the console
> drivers or even attempt to grab the console_sem. Then, we can do the
> kmsg_dump, do a crash_kexec if configured, and only when all options
> have been exhausted would we reinitialize the console_sem and flush to
> the console. Maybe this is too cautious, but it is an alternative.

Back in the days we also had this idea of "detaching" non-panic CPUs from
printk() by overwriting their printk function pointers.
