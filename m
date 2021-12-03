Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5064679C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352705AbhLCOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbhLCOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:55:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B4EC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:52:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so2449449wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/Dd9jYgQdNkm5xfLBwk/Cccr4BdTbvqV9pKu72sKaY=;
        b=VnpwqW9ofHaaMpo8isVUdsSk9mzOXrSOUBF+FstrLTMiMwGhojbTJt1mxrImWchdrY
         OzTy80nRVDSILow9W7NS40Pz7cjyS24AeH32TbnuFJvC74acGrlt6LojwzS0HcZsYTtI
         EYJo4xc2pTiCx19SnISWlEw+ZQsAn1NrEsq1Czfc29Bts1ELlUMXuT5jOXtP+3TtZU6s
         w2gU2IZw8BhulwSl9fW1+9rroq393g9Dyj5+RY7ldHTW/rN45aoGisuiI8GNuwEnDMPV
         KO3T8Uu2Iew08ktc8KMAJ+MtiICQeG0vZR/y8uKXK2kCQHZ0/zwPMuokIy3DdTN4JeUC
         lzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/Dd9jYgQdNkm5xfLBwk/Cccr4BdTbvqV9pKu72sKaY=;
        b=aZSxqYKGPp2wzpBn2s6t7J8zjEuoDJ1JSycXW1pOBaPYS/yVsvpQEnT7Jo7fm/V2R3
         EGBj1JR7Lh5xYgsVltR8n5eeENB63tdlKY5WJMLuNAXh84Dwo1UTY1hRqbkA+a6VCTqg
         n8IMXz8nFouOQmJr7m4UQyks0brzAKlGcJkVyI1XtbIlPqk9f86krjL4M9ottqXEm+t6
         gWAJfsmH/9k49qaV+UGZCJWwPk8zpD5yF+WwYryHESWPzqyt1ODhTDqg6IQs/1JvwNVB
         dBst2xouob9Dtca51GOoU8DoYz8mG4ngL9UgEYwMTGZPEbyGzjd1loxLe+PXnwZ4ksp6
         s5EA==
X-Gm-Message-State: AOAM531FT30NlOKe/xdN2sGNnLNWqg8wiuLeRnIFhmM5cMFHg3n+QWV8
        /QyKTS+PAKSEXZjOBTiHm3o=
X-Google-Smtp-Source: ABdhPJzsEP6Z4J9y7l56mpNaxiUcFtmyMAEYDdOoFOEtsUt6ttIhw4MXN+a+OQfLOxhJjhRKC59h4Q==
X-Received: by 2002:a05:600c:213:: with SMTP id 19mr14996279wmi.16.1638543134090;
        Fri, 03 Dec 2021 06:52:14 -0800 (PST)
Received: from localhost.localdomain (host-95-239-199-20.retail.telecomitalia.it. [95.239.199.20])
        by smtp.gmail.com with ESMTPSA id b188sm2831646wmd.45.2021.12.03.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 06:52:13 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
Date:   Fri, 03 Dec 2021 15:51:58 +0100
Message-ID: <2064700.cDd5PexU1D@localhost.localdomain>
In-Reply-To: <5d055fbd-e94a-fe54-d3e0-982dc455ed1a@i-love.sakura.ne.jp>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <3017492.JFOoIcAZ2s@localhost.localdomain> <5d055fbd-e94a-fe54-d3e0-982dc455ed1a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 3, 2021 1:32:21 PM CET Tetsuo Handa wrote:
> On 2021/12/03 20:00, Fabio M. De Francesco wrote:
> > On Thursday, December 2, 2021 7:35:16 PM CET Linus Torvalds wrote:
> >> [...]
> >> Example: net/nfc/nci/uart.c. It does that
> >>
> >>         schedule_work(&nu->write_work);
> >>
> >> instead of actually trying to do a write from a wakeup routine
> >> (similar examples in ppp - "tasklet_schedule(&ap->tsk)" etc).
> >>
> >> I mean, it's called "wakeup", not "write". So I think the fundamental
> >> confusion here is in hdlc, not the tty layer.
> >>
> >>               Linus
> >>
> 
> OK.
> 
> > This is what I understand from the above argument: do a schedule_work() to get 
> > that n_hdlc_send_frames() started; in this way, n_hdlc_tty_wakeup() can
> > return to the caller and n_hdlc_send_frames() is executed asynchronously 
> > (i.e., no longer in an atomic context). 
> 
> Yes. 

Thanks for confirming :)

> [...]
>
> > [...]
> > 
> > Commit f9e053dcfc02 ("tty: Serialize tty flow control changes with flow_lock") 
> > has introduced spinlocks to serialize flow control changes and avoid the 
> > concurrent executions of __start_tty() and __stop_tty().
> > 
> > [...]
> >
> > This is the reason why we are dealing with this bug. Currently we have __start_tty() 
> > called with an acquired spinlock and IRQs disabled and the calls chain leads to 
> > console_lock() while in atomic context.
> 
> If we hit a race window described in that commit
> 
>     CPU 0                          | CPU 1
>     stop_tty()                     |
>       lock ctrl_lock               |
>       tty->stopped = 1             |
>       unlock ctrl_lock             |
>                                    | start_tty()
>                                    |   lock ctrl_lock
>                                    |   tty->stopped = 0
>                                    |   unlock ctrl_lock
>                                    |   driver->start()
>       driver->stop()               |
> 
>     In this case, the flow control state now indicates the tty has
>     been started, but the actual hardware state has actually been stopped.
> 
> , the tty->stopped flag remains 0 despite driver->stop() is called after
> driver->start() finished. tty->stopped (the flow control state) says "not stopped"
> but the actual hardware state is "stopped".

This is clear and it is the reason why I cited that commit. I understand that
__stop_tty() and __start_tty() cannot run concurrently.

I'm sorry if my poor abilities to express complex thoughts in English may 
have made you to think that I'm not aware of the real race condition issue 
that commit f9e053dcfc02 is trying to address :( 

Unfortunately, by fixing the SAC bug with a mere asynchronous execution of
n_hdlc_send_frames() in a work queue, we may still have different sources of 
race conditions. 

The point is that, when n_hdlc_tty_wakeup() returns to the IOCTL helper (the caller)
that acquired the spinlock, that same spinlock is immediately released without 
even knowing whether or not n_hdlc_send_frames() has had the chance to run 
and complete. Further __start_tty() or __stop_tty() calls are allowed to acquire that
spinlock again and we lose serialization because they still run concurrently. 

Actually, in the final part of your email you say that more than one instance of 
__start_tty() cannot run because of a variable that checks that another thread is 
still running the same code. I haven't yet checked, however you showed other
steps that can lead to races and I agree that the problem is not yet fixed.

This is why I think that n_hdlc_send_frames(), when runs asynchronously with
the change that Linus suggested, should also signal completions or change a 
a condition variable. 

Still using locks locks where it is needed, we should somehow use completions 
or condition variables to enforce an execution alternation between __stop_tty 
and __start_tty.

Either:

1) wait_for_completion() and complete();

Or:

2) wait_event(tty_event, tty->flow.tco_stopped == true) and 
wait_event(tty_event, tty->flow.tco_stopped == false) before entering respectively
__start_tty() and __stop_tty().

Regards,

Fabio M. De Francesco




