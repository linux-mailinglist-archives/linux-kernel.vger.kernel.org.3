Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3E4A2CA4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbiA2Hxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbiA2Hxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:53:32 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD9EC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 23:53:31 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id c7so11671633ljr.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 23:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjffD8C6hWszKe+q+e4gp+s/8emWlsNf02+aVWLSx1o=;
        b=XtVYbiuKY9YiMw7e4qqMCW0JoeMk0DpTYwCwXZJrNVziB0gmDaUmkyglq9LmvvTJMW
         zVozIdHYPSnjxLH1Ov0a235DAG9mULlYwksbOkmv4YQoOj9cMIzAlh9OjvoSsSHW0w+P
         lbupVGzXMFz8yplhEiPpLVYiiJE2bkE0WCGzHKPRDvIw6RgSFdeqQZSdNgwAXWiRIpOJ
         uRRa5UY2j/OtaEWGNnZv7pRHj+eKlj3iqzJvaGfhFxBZZ2PvRDmExevajdp20nzgFgou
         bdBr8696+nNQ/Z6DYSFinK823o7c4wt8EiinzJ6nMzCGCGOpAgBcEsuZJEqDTIpjn7PJ
         2qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjffD8C6hWszKe+q+e4gp+s/8emWlsNf02+aVWLSx1o=;
        b=JzhqqV8zqgOOYVagfk6BjW2e9T2fRnfuU+aq6tly7T68++vwJsICD41bcpK4WfXThH
         TENLMsrj1bLDz57AtaxjUIcHT247fFhR2ISh4hjAtwoFWybBi1Hv4oVV8iJ3yp6CuHtX
         uOJryj1rX8eRMDJY8+9Ig6/dJeGZbjGJabqj4bnon1OSJFvwPEAMpk5L24IQ3sOQ7PAT
         nNXiae8EmhjLhyum0evPIQcPl4Dmy03nZqx/QreXJbyLN0jMEnyGA1tKAY48HDJs6GRZ
         hSz+ruRwH6phR0/bWvLoirCbDJ60Eu3snrF2w+Ypvad0CRg3zNF5NkslLpo+fXvF6zgV
         fjBA==
X-Gm-Message-State: AOAM532lHpfPyxq1l/D5r7pMRbXqfYRKSaX1Dk+6Rm8b8tfWv2XQ4yIn
        WrGx5sHwQ3yD5vXBXEEnAfXHxAKHNkITgRUweOGYHA==
X-Google-Smtp-Source: ABdhPJxXjmeIrPS5esBmIZy29jk4awgm1RZq5Zk2vMrOjU/zU+/NmzMmcb4LYpJstc59tkQ37omBeDPXUe/O8Woi8/g=
X-Received: by 2002:a2e:bf01:: with SMTP id c1mr7963677ljr.406.1643442809222;
 Fri, 28 Jan 2022 23:53:29 -0800 (PST)
MIME-Version: 1.0
References: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
 <CANcMJZA16b5gT++73a8hjA=6OeLsPLQM-X+ps3kEsYHVyariGg@mail.gmail.com> <CAE9iGoiCZZBkyX9ZWnhSDMjWmucOmybCOp=XTr6Hz5rN9GNyrw@mail.gmail.com>
In-Reply-To: <CAE9iGoiCZZBkyX9ZWnhSDMjWmucOmybCOp=XTr6Hz5rN9GNyrw@mail.gmail.com>
From:   Kelly Rossmoyer <krossmo@google.com>
Date:   Fri, 28 Jan 2022 23:52:52 -0800
Message-ID: <CAHTsKTcHd1Uo2QVr=ux1hFfA+x00k3i3Jya5n5XqZFfg9B68bw@mail.gmail.com>
Subject: Re: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     Zichar Zhang <zichar.zhang@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vijay Nayak <nayakvij@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:09 PM Zichar Zhang <zichar.zhang@linaro.org> wrote:
>
> hello John,  Kelly!

Hello!  Happy to see what the future may bring in this space, and looking
forward to what we can all do to move this area forward.

>     -- If these IRQs do hanpen, the code in this commit will catch
>     them as "unknown wakeup reason" and suggest user to check the
>     kernel log for more information.

I would argue that - at least in Android context, as that's what I know -
the kernel log is not a substitute for wakeup reason capture.
1) It is common to find yourself troubleshooting battery life issues for
   which kernel log data is not unavailable.
2) Troubleshooting is not the only consideration.  Since "why aren't we in
   suspend right now?" is such a key question for mobile device battery
   life, this is also about power attribution.  And I think trying to build
   that upon live kernel log parsing would be both inefficient and brittle.
   (But my lack of knowledge is vast, so maybe that's a solvable problem?)

> >> * abort reasons, including:
> >>    * wakeup_source activity
> >>    * failure to freeze userspace
> >>    * failure to suspend devices
> >>    * failed syscore_suspend callback
>
>     -- As mentioned before, if these "abort action" happened, you
>     can catch string "unknown wakeup reason", and check the kernel
>     log then.

I don't think the kernel log is a solution here.  Suspend aborts can be a
significant fraction of how suspend attempts end, making them a key
contributor to battery drain.  If the eventual set of patches doesn't solve
for at least the most common kinds of suspend aborts, that leaves a lot of
power observability off the table.  And again, at least on Android, kernel
log content is often not available for the interval when a series of
suspend aborts contributed to power drain.

> The patch is not complete, these is the next steps:
> 1. add interface to show time spend in suspend/resume work.
> (after this, I think it could be works and replace the android patch)

I believe Android would experience a significant regression in capability
with only those two patches implemented, so that would require a lot of
careful consideration.

> 2. we need solve the "unmapped HW IRQs", "misconfigured IRQs" and
> "threaded IRQs" problem.
> (this is the hardest one)

FWIW, I'm already expecting unmapped HW IRQs and misconfigured IRQs not to
make the cut.  Those have helped solve real and recurring issues, but
they're admittedly niche solutions to infrequent problems at the expense of
messy code coupling, so... maybe not broadly beneficial for Linux.

Threaded wakeup IRQs are a different matter.  As one example, there are
architectures in which the RTC wakeup IRQ is threaded and knowing "this
string of wakeups was due to the RTC" is a lot more useful than "this
string of wakeups was due to an irqchip with tens of child IRQs".

> ... So it just report a "wakeup reason" from
> interrupt subsystem. It just a coincidence that most hardware "wakeup
> reason" is also the interupt signal.  Even the "interrupt" and "wake up"
> signal are separated from each other in GIC700.
> So give them a chance to report the their "wakeup reason".)

Agreed.  But I do hope we can find a way to bring them together so a single
story is presented to userspace.  Or, barring that, at least make it easy
for userspace to figure that out after the fact.

Thanks so much for the work you are doing on this and taking the time to
walk me through your thoughts.  I'm happy to contribute in whatever manner
adds value.

--

Kelly Rossmoyer | Software Engineer | krossmo@google.com | 858-239-4111
