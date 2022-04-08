Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD94F9F47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbiDHVnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiDHVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:43:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614DC1C6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:41:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649454072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8G2U5MD5zaVGJHAphYPYznWmTkNAetSatOvZPIWwsmk=;
        b=qqFtrIdtLcCCKJtlfzudtgKgR+pfzVMpkpTurjlEyc1YQCNCfVNHVVAzC7kTpQPZGwQabD
        Ep4X5jxbAE9qJpHGEdqEVPu5Duu2aCwEudL9asmKAwAkE/olNZCAnpHBf2kCQxY8pf6jfc
        K8rbibNG7d9jRH47J3OU7E8qylNaXvMjjZ9HPyJAxBeIf2c2m3BShg4a8xVFgNN9gAYMhv
        55ZvOFwL1YnOd0KQw/rBb1wpMHdxc/BUANQR7R9tv1aE1v5f8Jw9Dc0FdDTh4h/6dHarVK
        JgAZaLctapB0bDfHCfgmyKj3Ty4xbO0ihwE6g2prEwJmMo2ZPNBwL/9TTjxJXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649454072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8G2U5MD5zaVGJHAphYPYznWmTkNAetSatOvZPIWwsmk=;
        b=fhrwe8lvhSItZ56SlDvIBRQRSSQ5R+c6bw3pCFjDvoEeWBxWpSfQK0x3Hox7Ay8N7SP6kZ
        EFfkRiAlRBIDQjAg==
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
In-Reply-To: <CAL1p7m4ukBQdQihkeSTjGHTM+HAF-GVf=QSnNPhRmetC213ANg@mail.gmail.com>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com> <87k0bzk7e5.ffs@tglx>
 <CAL1p7m4ukBQdQihkeSTjGHTM+HAF-GVf=QSnNPhRmetC213ANg@mail.gmail.com>
Date:   Fri, 08 Apr 2022 23:41:11 +0200
Message-ID: <87sfqni77s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08 2022 at 12:13, Joel Savitz wrote:
>>         if (!fork()) {
>>                 pri = mmap(NULL, 1<<20, PROT_READ | PROT_WRITE,
>>                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>                 pthread_mutexattr_init(&mat_p);
>>                 pthread_mutexattr_setpshared(&mat_p, PTHREAD_PROCESS_PRIVATE);
>>                 pthread_mutexattr_setrobust(&mat_p, PTHREAD_MUTEX_ROBUST);
> One thing I don't understand is what kind of sane use case relies on
> robust futex for a process-private lock?
> Is there a purpose to a lock being on the robust list if there are no
> other processes that must be woken in case the holder process is
> killed?

Ever heard about the concept of multi threading?

> If this usage serves no purpose besides causing races during oom, we
> should discourage this use, perhaps by adding a note on the manpage.

This usage does not cause races during oom. It does not even cause races
if it would be silly, which it is not except for the demonstrator
above. The keyword here is *demonstrator*.

The oom killer itself causes the race because it starts reaping the VMAs
without granting the target time to terminate. This needs to be fixed in
the first place, period.

If the target can't terminate because it is stuck then yes, there will
be fallout where a robust futex cannot be released, but that's something
which cannot be solved at all.

I'm really tired of this by now. Several people explained in great
length the shortcomings of your 'cure the symptom' approach, showed you
that the "impossible to reproduce" problem is real and told you very
explicitely what the proper solution is.

So instead of sitting down and really tackling the root cause, all you
can come up with is to post the same 'cure the symptom' muck over and
over and then if debunked grasp for straws.

Coming back to your original question.

What's the difference between a process shared and a process private
futex in the context of a multi threaded process?

  - The process shared must obviously have a shared mapping

  - The process private has no need for a shared mapping because
    all threads share the same address space.

What do they have in common?

  - All of them are threads in the kernel POV

  - All of them care about the unexpected exit/death of some other
    thread vs. locking

So why would a process private robust mutex be any different from a
process shared one?

I'm sure you can answer that question yourself by now.

Thanks,

        tglx
