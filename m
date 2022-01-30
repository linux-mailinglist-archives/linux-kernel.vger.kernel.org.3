Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B445E4A36E2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbiA3OrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:47:18 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:34747 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355157AbiA3Oqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:46:51 -0500
Received: by mail-yb1-f181.google.com with SMTP id v186so33008863ybg.1;
        Sun, 30 Jan 2022 06:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZK6e+csaVH9icFtoUOacf2hoBkOPZ29IojIms3ljwc=;
        b=XfCON8P0AK9KA/258MsIX0xcyNHDtZXbVxHxhYce0bYfW8F6kxjgSL4EBwT01OTTNB
         gXMO7FQPb6Ra4hhwWh5qvCth06VencB/IqlaVMc20/hcfmFwtLrkZLDXTD8y+goYNxNY
         cywFVXvh+SHD5cwO7l7zRMYyTpoO686RqVdfAntvCE1RLkC46vsak1L3PWXstYsw8sMy
         TJOiH4lF8MuYcOSUUH7bw7X7Pycu8Dyl28t0v8qj6+GJBxhT+ztP1Lc0mepeunK7NHyp
         If9NI62wrrk/lNrbS/BTmQwryZVelQy4ZmB8WfmJTemT1jiJRz9BODY7r9+bwnKi3EIz
         Gxzw==
X-Gm-Message-State: AOAM530cdbmcoMWIxs3ybxFuWH1XN1INS2b6L79wuZq7yRyu7Yd/G7ej
        eRz0Frv/kwWVw81RTx2P1UbIOZmXP0JaN6sOfOI=
X-Google-Smtp-Source: ABdhPJyUPgNcBZcI40nHmVNqw1FMD5hD38KN6oLdktmTdeeTqia2vXYOF0wM0aEospf6kaGjM8CcF/dqZsm9zSFZsTM=
X-Received: by 2002:a05:6902:54c:: with SMTP id z12mr23811288ybs.624.1643554010981;
 Sun, 30 Jan 2022 06:46:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
 <CAJZ5v0jrU4Xw2wzdUL9Vd2C6u8NVx5J79DeiRY6KU1xT6ZSuqw@mail.gmail.com>
 <CAJZ5v0gLMSPsaS7Jnsr8DhevaQamsVk=pu=BfXZxrT+SBAM=fQ@mail.gmail.com> <CAHTsKTc0M0wDLVJovzO01z1B9iOSc4cHcS4tNffykna3c=9eJQ@mail.gmail.com>
In-Reply-To: <CAHTsKTc0M0wDLVJovzO01z1B9iOSc4cHcS4tNffykna3c=9eJQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 30 Jan 2022 15:46:39 +0100
Message-ID: <CAJZ5v0i9GFvWTpyREjA+Czs_1xvVzFo8XGY=dKeor6Dgy5EOcg@mail.gmail.com>
Subject: Re: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     Kelly Rossmoyer <krossmo@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vijay Nayak <nayakvij@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 9:27 AM Kelly Rossmoyer <krossmo@google.com> wrote:
>
> On Thu, Jan 27, 2022 at 12:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jan 27, 2022 at 8:54 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Jan 10, 2022 at 7:49 PM Kelly Rossmoyer <krossmo@google.com> wrote:
> > > >
> > > So as Zichar said, this is quite heavy-weight.
> > >
> > > I'm not fundamentally against adding more infrastructure to help
> > > identify issues related to system suspend, but there needs to be a
> > > clear benefit associated with any change in this direction.
> >
> > That said, the general idea behind wakeup_source objects is that every
> > system wakeup event should be recorded in one of them which then can
> > be used for later analysis.
> >
> > If there are reasons why this cannot work in general, what are they?
>
> I won't presume to say that it "cannot work in general."  Nearly everyone on
> this thread has more expertise here than I do, and I'm keenly aware of how
> much I don't know.  :-)
>
> What I will say is that - across the chips and architectures I've worked upon
> over the last few years - that concept has not appeared to match observed
> reality.  From what I've seen (which is a very narrow slice of the Linux
> universe, but I suspect is at least pretty representative of Android):
> * resumes from successful suspends are typically accompanied by a flurry of
>   wakesource activity from which it is not possible to determine what actually
>   caused the resume (despite last changed timestamps)

So I wonder how you are going to determine what actually caused the
resume reliably.

> * resumes that aren't accompanied by wakeup-armed IRQs can be even
>   less well-reflected by wakesource activity

Do you have examples of these other than the aborts mentioned below?

> * I believe inferring wakeup reasons from wakesource stats would require
>   having a snapshot from the last moment prior to suspend, which seems
>   unsolvable from userspace

That can be addressed by extending the wakeup sources in principle.

> * suspend aborts (which can be even more harmful for battery life than
>   "true" wakeups) are often caused by things that aren't reflected by specific
>   wakesources (e.g. a driver failing to suspend)

Which again can be addressed by using special wakeup sources for
registering these "wakeups"  or similar.

> And as I mentioned in my reply to Zichar, this isn't solely about
> troubleshooting.  There's a lot of room to improve on user-focused power
> attribution, and I'm hoping to build change in that direction upon the same
> foundation.  Having the best possible data about "why we're awake" serves both
> goals.

Generally speaking, there is one wakeup-related framework in the
kernel (wakeup sources) and you want to add another one sort of on top
of it and it is still quite unclear to me what can be done with the
new framework that cannot be achieved with the old one (possibly with
some extensions),

Let's first talk about the specific problems to address and then we'll
decide whether or not we need yet another piece of infrastructure to
address them.
