Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89C74858E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbiAETHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbiAETHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:07:35 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15749C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 11:07:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z29so332582edl.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyMNvvq0PEPzslt4MSGCkpasRaRMjefk5SUq0r41MJo=;
        b=HCszAIvsRbzHlCtHIRPeDuKPDcR1lrL6BkCRu+HjowLsRZyE6WlMB5UCoxalh9VvvT
         kNldojtQrvE7JFw+ZnKXRQn72R/lUyGgBVxRVVw5o7OJlhyAP9cJ50FBeLDiJcWfJb0N
         YXqwklj0PcrrhPDeOOqJIDM2iPvpqRymF2iBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyMNvvq0PEPzslt4MSGCkpasRaRMjefk5SUq0r41MJo=;
        b=k207KUzQt50hebVJpLcpZlqvvOm2m+0oeZNcgd0t/QFHQU1z4p2EuEPNKx/9w5rgsL
         Gsx8zRIySuaAZV/nX2yirRfBv3jtHnzpLloeqwqefr7BlhBbxh2ZUjiYMhLQV5Z3HbPN
         SLiG6hS13KmaiHwaqyhnFWTB4XXYJUPuFUqDEoDOYNPFaZrtBYKKMdgmflAiDLt9JsWR
         dS76Kca/Kd3RCiByFLZPCBaM+g33j2SH/PE/E5vua/ftFlu/W78tdGK1+4nHsXyVxAju
         XrnIqs3bSUwb8zy9b+xXsRXvZ6iICxItwWq9MGlB+n2FB4Z1cp6X1VXmUoYJg2l2HoLa
         RnUA==
X-Gm-Message-State: AOAM530yTaUqiXiIGHR2nHef4ULE9/OyJ7YI1WxO0v0DImqaJjLdTsqb
        qvkJ7iz4pmBLGhhCg20Asllz4E/HHMFp2CbtoME=
X-Google-Smtp-Source: ABdhPJyXOx35AwjuSXoWaFSXYSHyKbjcR4GXpKqJ3597HRDn4A7GcFC94ynO1bUIFG8r5iL0ZcNM6w==
X-Received: by 2002:a05:6402:350:: with SMTP id r16mr805333edw.375.1641409653517;
        Wed, 05 Jan 2022 11:07:33 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id w18sm16051360edr.67.2022.01.05.11.07.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 11:07:30 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id k18so150201wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:07:29 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr47391843wrx.193.1641409649356;
 Wed, 05 Jan 2022 11:07:29 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain> <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
In-Reply-To: <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jan 2022 11:07:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
Message-ID: <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 10:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That would require that 'psi_trigger_replace()' serialize with the
> waitqueue lock (easy)

I take the "easy" back. The other side of that serialization would
require that the poll() side also re-lookup the trigger pointer under
that same lock.

And you can't do that with the waitqueue lock, because 'poll_wait()'
does the add_wait_queue() internally, and that will take the waitqueue
lock. So you can't take and hold the waitqueue lock in the caller in
poll, it would just deadlock.

And not holding the lock over the call would mean that you'd have a
small race between adding a new poll waiter, and checking that the
trigger is still the same one.

We could use another lock - the code in kernel/sched/psi.c already does

        mutex_lock(&seq->lock);
        psi_trigger_replace(&seq->private, new);
        mutex_unlock(&seq->lock);

and could use that same lock around the poll sequence too.

But the cgroup_pressure_write() code doesn't even do that, and
concurrent writes aren't serialized at all (much less concurrent
poll() calls).

Side note: it looks like concurrent writes in the
cgroup_pressure_write() is literally broken. Because
psi_trigger_replace() is *not* handling concurrency, and does that

        struct psi_trigger *old = *trigger_ptr;
        ....
        if (old)
                kref_put(&old->refcount, psi_trigger_destroy);

assuming that the caller holds some lock that makes '*trigger_ptr' a
stable thing.

Again, kernel/sched/psi.c itself does that already, but the cgroup
code doesn't seem to.

So the bugs in this area go deeper than "just" poll(). The whole
psi_trigger_replace() thing is literally broken even ignoring the
poll() interactions.

Whoever came up with that stupid "replace existing trigger with a
write()" model should feel bad. It's garbage, and it's actively buggy
in multiple ways.

                  Linus
