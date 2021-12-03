Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024AC467E65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353441AbhLCTog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:44:36 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41596 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhLCTof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:44:35 -0500
Received: by mail-oi1-f179.google.com with SMTP id u74so7741116oie.8;
        Fri, 03 Dec 2021 11:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fi1SwxzuTgL59jg4Gl6iQzW0x5W/v99CAEFF9LeLp2A=;
        b=yd2uQ5MzJ9w1xGO7+Oi39vaypEBpiv32Yg8/e21g+chcYFBKtIPfC3tCiEbKz9dQsH
         efQFgueQPZ81mSf/HHZ58kBeO36Gu1mzJsKi8aqyr59TCCRZkA7irkMMt0QR/qh5nHMy
         j0Lr50YcdRzvsYMTYXpHiw3r2h4ABXm06nVkelvt/qis1SBt8fkAkyzZakIvVr6a2l98
         RRYq1XtoFqBTYyq7PxGUYOIeZdrPUKLJZ03tjsTmZ8vbI2xQkSVwQq9W4IN8znJi8ssz
         JQKTZbE2KBvP+vIg1wEwhoZLfbwtGvHwf2KXAVmMOQo2GWUyk/oJdJuYJiIjBHTRrgHy
         +M3g==
X-Gm-Message-State: AOAM532yZregq74vJ4+Sp4bP6izZ25412yBOQkXMx/k3rU2cRlwwo+2M
        uqq9YQAvsA+y60ki3EwBMO3uIYm024+ujc+uHx0=
X-Google-Smtp-Source: ABdhPJzRtBi9felzp/AVY1094RBE/o5xMhc27u59ErS0+CIaFPH/qITmD7q8Iu5Nege4TRWTKbpbK8BFpNZPW8lZKO8=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr11383435oiw.154.1638560470481;
 Fri, 03 Dec 2021 11:41:10 -0800 (PST)
MIME-Version: 1.0
References: <4723000.31r3eYUQgx@kreacher> <Yaphb0hcqTQ3S78n@rowland.harvard.edu>
In-Reply-To: <Yaphb0hcqTQ3S78n@rowland.harvard.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Dec 2021 20:40:59 +0100
Message-ID: <CAJZ5v0gfvrki8CjB=Fytqqnk_8T9kJofjTETAYn_9X+0rWNN3w@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Capture device status before disabling
 runtime PM
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 7:27 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Dec 03, 2021 at 05:24:45PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In some cases (for example, during system-wide suspend and resume of
> > devices) it is useful to know whether or not runtime PM has ever been
> > enabled for a given device and, if so, what the runtime PM status of
> > it had been right before runtime PM was disabled for it last time.
> >
> > For this reason, introduce a new struct dev_pm_info field called
> > last_status that will be used for capturing the runtime PM status of
> > the device when its power.disable_depth counter changes from 0 to 1.
> >
> > The new field will be set to RPM_INVALID to start with and whenever
> > power.disable_depth changes from 1 to 0, so it will be valid only
> > when runtime PM of the device is currently disabled, but it has been
> > enabled at least once.
> >
> > Immediately use power.last_status in rpm_resume() to make it handle
> > the case when PM runtime is disabled for the device, but its runtime
> > PM status is RPM_ACTIVE more consistently.  Namely, make it return 1
> > if power.last_status is also equal to RPM_ACTIVE in that case (the
> > idea being that if the status was RPM_ACTIVE last time when
> > power.disable_depth was changing from 0 to 1 and it is still
> > RPM_ACTIVE, it can be assumed to reflect what happened to the device
> > last time when it was using runtime PM) and -EACCES otherwise.
> >
> > Update the documentation to provide a description of last_status and
> > change the description of pm_runtime_resume() in it to reflect the
> > new behavior of rpm_active().
> >
> > While at it, rearrange the code in pm_runtime_enable() to be more
> > straightforward and replace the WARN() macro in it with a pr_warn()
> > invocation which is less disruptive.
> >
> > Link: https://lore.kernel.org/linux-pm/20211026222626.39222-1-ulf.hansson@linaro.org/t/#u
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/power/runtime_pm.rst |   14 +++++++++----
> >  drivers/base/power/runtime.c       |   38 +++++++++++++++++++------------------
> >  include/linux/pm.h                 |    2 +
> >  3 files changed, 32 insertions(+), 22 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -744,11 +744,10 @@ static int rpm_resume(struct device *dev
> >   repeat:
> >       if (dev->power.runtime_error)
> >               retval = -EINVAL;
> > -     else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > -         && dev->power.runtime_status == RPM_ACTIVE)
> > -             retval = 1;
> >       else if (dev->power.disable_depth > 0)
> > -             retval = -EACCES;
> > +             retval = dev->power.runtime_status == RPM_ACTIVE &&
> > +                      dev->power.last_status == RPM_ACTIVE ? 1 : -EACCES;
>
> Suggestion for a small improvement in readability: The way this
> statement is broken between two lines, it looks as if the ?: operator
> has higher precedence than the && operator, which is very confusing.
> Adding parentheses would help.  Even better would be to rewrite this as
> an "if" statement:
>
>                 if (dev->power.runtime_status == RPM_ACTIVE &&
>                     dev->power.last_status == RPM_ACTIVE)
>                         retval = 1;
>                 else
>                         retval = -EACCES;

I would need to add braces around this then as per the coding style,
which I wanted to avoid, but of course that can be done.
