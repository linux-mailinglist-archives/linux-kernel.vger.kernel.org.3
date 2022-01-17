Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669E64900B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiAQEJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiAQEJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:09:09 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B75CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:09:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j7so11704687edr.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WB+LgnJSS3hnM17Xj+1ne0yeZq89g0wCwK7AtuIg40=;
        b=V22sKlKs4nxuYvo8EFX2si4W+sV8vMlB9WO7CrX/ZSxO9ZYXOMbjYwgkBxukaadWQB
         kOeMifpfd9dSnAwlULPWuCzNnobPdeXjLIydPcX1o4VoqY27zYB6EkCeA8sOXXJuJmdY
         I/HMjFqM2ZyfIYQrlo1GtOH5hYse0GsQhYFTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WB+LgnJSS3hnM17Xj+1ne0yeZq89g0wCwK7AtuIg40=;
        b=lPZtYjjZTbSAna16oGZVF+EDjXvcbVb8llmfMLaeV3fBPnc00fDR6+t1PgJJv93DA/
         QFgnseD9NiYN7Q9VdTNIc6edtLaoikLBaEZVcoyfS02VOQhWAu0MJu5EN25FShPyOlxQ
         F1LiOTFbJJhjqOVNeV/HR8u1RgYdsbzWHZ60y0M6uBBI689guUMUeTNuovK+eaqWyQ01
         8L1T32iBuxvgf/aQBXuj+mSLRPX4mYkSOxH+FHaYjbgcgPhRXJ0fbkP+Dw1/w5+g4IH3
         bodwUwumFtfs9U16fLN9eHK5up6ZNAybPx25JHKD9kmNjnXb2XD7PluMebb2iNom8QDq
         jqBg==
X-Gm-Message-State: AOAM532TDFfZJuE3vdISIaJA7zUhn0TtizKQpeNR1WbGoMGv5+ceYxIO
        Iql5Iannuz40bipRLw3Xn/LQR1mhR1Vw2S6g
X-Google-Smtp-Source: ABdhPJxHBGt0lW/7W29eYXgSiSYWKETfSYC2zhPh16JMw7KNLpDnz+nY+rV1PrfssUriC/qAoVH4Og==
X-Received: by 2002:a17:907:a414:: with SMTP id sg20mr15122623ejc.42.1642392547721;
        Sun, 16 Jan 2022 20:09:07 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id ju16sm6974ejc.197.2022.01.16.20.09.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 20:09:06 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso20665116wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:09:06 -0800 (PST)
X-Received: by 2002:a5d:6951:: with SMTP id r17mr17035192wrw.274.1642392545859;
 Sun, 16 Jan 2022 20:09:05 -0800 (PST)
MIME-Version: 1.0
References: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 06:08:49 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com>
Message-ID: <CAHk-=wgS865kHU=4NO=AvK07fcK7M6C6EYGdk80R1tkPKTLyhQ@mail.gmail.com>
Subject: Re: [GIT PULL] signal/exit/ptrace changes for v5.17
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 2:00 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I am currently investigating to figure out if wake_up_interruptible
> (instead of simply wake_up) ever makes sense outside of the signal code.

It may not be a huge deal, but it *absolutely* makes sense.

Any subsystem that uses "wait_event_interruptible()" (or variations of
that) should by default only use "wake_up_interruptible()" to wake the
wait queue.

The reason? Being (interruptibly) on one wait-queue does *NOT* make it
impossible that the very same process isn't waiting non-interruptibly
on another one.

It's not hugely common, but the Linux kernel wait-queues have very
much been designed for the whole "one process can be on multiple wait
queues for different reasons at the same time" model. That is *very*
core.

People sometimes think that is just a "poll/select()" thing, but
that's not at all true. It's quite valid to do things like

        add_wait_queue(..)
        for (.. some loop ..) {
                set_current_state(TASK_INTERRUPTIBLE);
                ... do various things, checking state etc ..
               schedule();
        }
        set_current_state(TASK_RUNNABLE);
        remove_wait_queue();

and part of that "do various things" is obviously checking for signals
and other "exit this wait loop", but other things can be things like
taking a page fault because you copied data from user space etc.

And that in turn may end up having a nested wait on another waitqueue
(for the IO), and the outer wait queue should basically strive to not
wake up unrelated "deeper" sleeps, because that is pointless and just
causes extra wakeups.

So the page fault event will cause a nested TASK_UNINTERRUPTIBLE
sleep, and when that IO has completed, it goes into TASK_RUNNABLE, so
the outer (interruptible) loop above will have a "dummy schedule()"
and loop around again to be put back into TASK_INTERRUPTIBLE sleep
next time around.

But note how it would be pointless to use a "wake_up()" on this outer
wait queue - it would wake up the deeper IO sleep too, and that would
just see "oh, the IO I'm waiting for hasn't completed, so I'll just
have to go to sleep again".

Would it still _work_? Yes. Is the above _common_? No. But it's a
really fundamnetal pattern in the kernel, and it's fundamentally how
wait queues work, and how they should work, and an interruptible sleep
should generally be seen as pairing with an interruptible wake,
because that's just how things are.

Why would you want to change something basic like that? Yes, using
"wake_up()" instead of "wake_up_interruptible()" would still result in
a working kernel, but it's just _pointless_.

             Linus
