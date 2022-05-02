Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28C5173B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386101AbiEBQHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiEBQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:07:48 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754D6BCBA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:04:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id d3so8156698ilr.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhtJjcFX73T8HNJL0XQjxx2fiQSSILldTMScYY+C7rc=;
        b=T+B4QyyoUFy2VP2uR6EVNY1cexoUeX5cOoEjF3jKSZShorerUtzhhUEJrpRmQr4hzc
         tGu351lbNA+WxrMqx1dhE622fLz0hQCceAVM1CbBWcFl7gAnM/hAWUFyu2GhY4gYyaGE
         OfZN16GSETeMjeOQSASBGYosyRsnmZqFjFITk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhtJjcFX73T8HNJL0XQjxx2fiQSSILldTMScYY+C7rc=;
        b=shVc80qvaJPWY6FpD42jp0AB1YBIJvkcHWWtuBk8dQdFIEi0B44IVk9klBHVN0WDFy
         w7Kwi2srNve4Dx4lVp4K7O4/zL71SRMcMUyYDXX7uazJc+d57SpOYwjTEDjBs6GeH2Ya
         cCXA25jHjVUCDxOsclA5lh5FYcwBG0FMBhRstRwJFAgmIFP1cVBOVpmG3pUDQlvDRTFx
         MUU/MwUvwBWXDTFbpZt/A8BQLZF+qwkrQ82yNweVRE6gamrW9zJ6JQZa1kxml0TLsgDM
         TriR85wX3RS0mkao2h87kzW3mbvBDRSam+GJIl1/1qNM0Mv44vwMcNqCC3+p2whQwE29
         INpA==
X-Gm-Message-State: AOAM531dJFPwwqvVzljQiYsxJ3z4foPgkq9z02nddNvNIfC+/8VOn48W
        k6A4mO5XoEpvcb+UiS0Pgm5FiA==
X-Google-Smtp-Source: ABdhPJxQ7Bcyy9XQ8aOzag3rEkJHvzBMPC1lY/I+JQyx3jnLaMS0Oi46jFKz+wh4x596CSUzBdNdRw==
X-Received: by 2002:a92:dd86:0:b0:2bc:805c:23c7 with SMTP id g6-20020a92dd86000000b002bc805c23c7mr4548716iln.279.1651507457511;
        Mon, 02 May 2022 09:04:17 -0700 (PDT)
Received: from ircssh-3.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id v11-20020a02cbab000000b0032b3a781769sm3178928jap.45.2022.05.02.09.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:04:16 -0700 (PDT)
Date:   Mon, 2 May 2022 16:04:15 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Rodrigo Campos <rodrigo@kinvolk.io>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH v3 1/2] seccomp: Add wait_killable semantic to seccomp
 user notifier
Message-ID: <20220502160415.GA1289934@ircssh-3.c.rugged-nimbus-611.internal>
References: <20220429023113.74993-1-sargun@sargun.me>
 <20220429023113.74993-2-sargun@sargun.me>
 <CACaBj2Z0OO7quYDF6LBaNsh14xTm6cN+rcMJMYtTioXNQNd34g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACaBj2Z0OO7quYDF6LBaNsh14xTm6cN+rcMJMYtTioXNQNd34g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 04:15:07PM +0200, Rodrigo Campos wrote:
> On Fri, Apr 29, 2022 at 4:32 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> > index 539e9d4a4860..204cf5ba511a 100644
> > --- a/Documentation/userspace-api/seccomp_filter.rst
> > +++ b/Documentation/userspace-api/seccomp_filter.rst
> > @@ -271,6 +271,14 @@ notifying process it will be replaced. The supervisor can also add an FD, and
> >  respond atomically by using the ``SECCOMP_ADDFD_FLAG_SEND`` flag and the return
> >  value will be the injected file descriptor number.
> >
> > +The notifying process can be preempted, resulting in the notification being
> > +aborted. This can be problematic when trying to take actions on behalf of the
> > +notifying process that are long-running and typically retryable (mounting a
> > +filesytem). Alternatively, the at filter installation time, the
> > +``SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV`` flag can be set. This flag makes it
> > +such that when a user notification is received by the supervisor, the notifying
> > +process will ignore non-fatal signals until the response is sent.
> 
> Maybe:
> 
> This flags ignores non-fatal signals that arrive after the supervisor
> received the notification
> 
> I mean, I want to make it clear that if a signal arrives before the
> notification was received by the supervisor, then it will be
> interrupted anyways.
> 
> 
Added: Signals that are sent prior to the notification being received by 
userspace are handled normally.

> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index db10e73d06e0..9291b0843cb2 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1485,6 +1512,9 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
> >                 mutex_lock(&filter->notify_lock);
> >                 knotif = find_notification(filter, unotif.id);
> >                 if (knotif) {
> > +                       /* Reset the process to make sure it's not stuck */
> > +                       if (should_sleep_killable(filter, knotif))
> > +                               complete(&knotif->ready);
> >                         knotif->state = SECCOMP_NOTIFY_INIT;
> >                         up(&filter->notif->request);
> 
> (I couldn't git-am this locally, so maybe I'm injecting this at the
> wrong parts mentally when looking at the other code for more context.
> Sorry if that is the case :))
> 
> Why do we need to complete() only in this error path? As far as I can
> see this is on the error path where the copy to userspace failed and
> we want to reset this notification.
This error path acts as follows
(Say, S: Supervisor, P: Notifying Process, U: User)

P: 2 <-- Pid
P: getppid() // Generated notification
P: Waiting in wait_interruptible state
S: Calls receive notification, and the codepath gets up to the poin
   where it's copying the notification to userspace
U: kill -SIGURG 2 // Send a kill signal to the notifying process
P: Waiting in the wait_killable state
S: Kernel fails to copy notification into user memory, and resets
   the notification and returns an error

If we do not have the reset, the P will never return to wait interruptible.
This is the only code path that a notification can go init -> sent -> init.

> 
> I think that is wrong, we want to wake up the other side not just on
> the error path, but on the non-error path (in fact, do we want to do
> this on the error path? It seems like a no-op, but don't see any
> reason to do it).
>

It's unneccessary. Why do it? It just means we wake up a process without reason.
Wakeups are expensive.
 
> We _need_ to call complete() in the non error path here so the other
> side wakes up and switches to a killable wait. As we are not doing
> this (for the non error path), this will basically not achieve a
> wait_killable() at all.
> 
No, because here, we check if we were waiting interruptible, and
then we switch to wait_killable:
/*
 * Check to see if the notifcation got picked up and
 * whether we should switch to wait killable.
 */
if (!wait_killable && should_sleep_killable(match, &n))
	continue;

This could probably be:
if (fatal_signal_pending(current))
	break;
if (!wait_killable && should_sleep_killable(match, &n))
	continue;

But, that check for fatal_signal_pending seems to be unneccessary (or something we'll get
for free in the next iteration).

> I think this was probably an oversight adapting the patch from last
> year. Is it possble? Because it seems that in the previous version we
> sent last year[1] (if you can link them next time it will be way
> simpler :)) you had a new ioctl() and the call to complete() was
> handled there, in seccomp_notify_set_wait_killable(). Now, as this is
> part of the filter (and as I said last year, I think this way looks
> better) that call to complete() was completely forgotten.
> 
> Is it possible that this is not really working as intended, then? Am I
> missing something?
> 
> 
> Best,
> Rodrigo
> 
> 
> [1]: https://lore.kernel.org/all/20210430204939.5152-3-sargun@sargun.me/
