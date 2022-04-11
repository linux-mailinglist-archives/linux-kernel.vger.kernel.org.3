Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA04FB533
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245642AbiDKHtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243358AbiDKHta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:49:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC8023140
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:47:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649663234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uK7/dZRTApAGFgqX1YHKs8HnTEUKBlTqZabjdZ+TFs0=;
        b=fK89maEfT47Wb8IySkCCcsB6rrxNE16tLQzgsQ2NcFmFPRYFnSr1dOuLlj7rAaT2RNPG89
        oeVvB+xJV+1sTJwQOFxrxjNzPrC5p7Of6tG+GBvxRI3fYa1jjk9xy011SFu1YTdroaq47O
        T+znjnzrgUwv0AGgf8DleNwTLatO8qCKOgxJgj5w5TTPB3k5jD/8E2b/GbJt5nF6HH3U16
        KNkTy14c6BhRtQRDIVqSqQ4tx2W1n80JxKcr5t5BtODrZXwati/IUuUF4Ujt6eZLVS+mrY
        64yHeoTK80OFOr6GQA+i0KirTPMu0TjeN5UHSccb0LdvSPZQ68GFFxQXgE4YkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649663234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uK7/dZRTApAGFgqX1YHKs8HnTEUKBlTqZabjdZ+TFs0=;
        b=uPGtRp03EBVhBkL8NVE8CyJo28YTIY4xyDxaE7uo8X7Agw/iQhxLwpKfN98iGWyBf60EGh
        +ymdKccM+W1h8cDA==
To:     Michal Hocko <mhocko@suse.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
In-Reply-To: <YlPPRrGrX2ECe8QY@dhcp22.suse.cz>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com> <87k0bzk7e5.ffs@tglx>
 <CAL1p7m4ukBQdQihkeSTjGHTM+HAF-GVf=QSnNPhRmetC213ANg@mail.gmail.com>
 <87sfqni77s.ffs@tglx> <YlPPRrGrX2ECe8QY@dhcp22.suse.cz>
Date:   Mon, 11 Apr 2022 09:47:14 +0200
Message-ID: <87wnfwf4e5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal,

On Mon, Apr 11 2022 at 08:48, Michal Hocko wrote:
> On Fri 08-04-22 23:41:11, Thomas Gleixner wrote:
>> So why would a process private robust mutex be any different from a
>> process shared one?
>
> Purely from the OOM POV they are slightly different because the OOM
> killer always kills all threads which share the mm with the selected
> victim (with an exception of the global init - see __oom_kill_process).
> Note that this is including those threads which are not sharing signals
> handling.
> So clobbering private locks shouldn't be observable to an alive thread
> unless I am missing something.

Yes, it kills everything, but the reaper also reaps non-shared VMAs. So
if the process private futex sits in a reaped VMA the shared one becomes
unreachable.

> On the other hand I do agree that delayed oom_reaper execution is a
> reasonable workaround and the most simplistic one.

I think it's more than a workaround. It's a reasonable expectation that
the kernel side of the user space threads can mop up the mess the user
space part created. So even if one of of N threads is stuck in a place
where it can't, then N-1 can still reach do_exit() and mop their mess
up.

The oom reaper is the last resort to resolve the situation in case of a
stuck task. No?

> If I understand your example code then we would need to evaluate the
> whole robust list and that is simply not feasible because that would
> require a #PF in general case.

Right. The robust list exit code does the user access with pagefaults
disabled and if it fails, it terminates the list walk. Bad luck :)

Thanks,

        tglx
