Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9249464A51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbhLAJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348141AbhLAJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:06:00 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD50BC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 01:02:39 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id n12so61124833lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 01:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jACqrPTumoSrl7UmMFduvRPnH4pdYXpSwGf6s0Y1BB4=;
        b=aM5gYYKlf84bP5PvUDWQc+ULsDEBlej1ZzPUcZETF8uqphinPCtk0LQgCfFqseRPHO
         gLpYdh6GumEm36jzhwjt/m/ismJ63bfgXznCGDFuOyeQOCPX7Z5S5d2xXeE6P+dIvwe7
         G9rmggJ9GgFgr8OlixHb30lZVyDSD4VIsh+Bx4r5T9eVPebVX17lZH4ovzt0u0GHPWhU
         5H40p7AQ0yn65S0o2B5lNPyVxUW5W+X3zyHHlZPisajTi9aQ2dCMDvLTITs/mGQHUTA4
         bC1kIxqZB9rH7O+9sLpLXEl8Lti9/mPVTnj4+LdZN1PMqOYcF+cgNmk4dcWHaIPi+pWB
         Se4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jACqrPTumoSrl7UmMFduvRPnH4pdYXpSwGf6s0Y1BB4=;
        b=C1/xRAcO8/AAVBCv4hjmOH/oy61abT3OVdIOaZBKaNGmJJ3WU9dyxclxCqyaym/gOl
         wvpgwDBWjkst2CNLCXDASIVFmksi7OA1UfL/nmFOqg9idRF3SX7qvYozocTRXMpTR30O
         aT9f0HRT4nHClchVAE4hwZeVllWmkjLY4aGWG86UmMyA+2X/32XZdalc4OqPxixhoiyp
         3m2uwhNXfaZj/0A6ugWPOOH+CAbEaxgc//vktx3I4AYFbiP0mvUfcjKmQAN7itCUITm1
         yZZEzsXWLc1suh+Uo249oAuz3fzTUO17KSt7g+sKD6DPqZZPakvmU0FbCIin3W3h1W+q
         tfnw==
X-Gm-Message-State: AOAM5333DNtKxjKPE9K2KYwjamMptswObzQFGXjuqZaXfqRu0P+8to8C
        7at1bGEVd8OIwiw3y95DrAKxXjVbIu8dkIH+ihfJpQ==
X-Google-Smtp-Source: ABdhPJwBcYFUaWZnY4WNpHkRN+LA3X+jqs1s3NGo+O0YHCIXQEqmEynqXChHNb/3N9iSQX0Xcdc5IL68IZP2WNniiK4=
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr4669329lfg.184.1638349357768;
 Wed, 01 Dec 2021 01:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <CAJZ5v0hrTDsCUn4vgmFrTTgd6H=orh-Kb5b3+_H9St4n8fTxBw@mail.gmail.com>
 <CAPDyKFre=tp4919FLoeU-wjLDJ02zmHaXY4wgTUmfmFbeaCadQ@mail.gmail.com>
 <4380690.LvFx2qVVIh@kreacher> <CAPDyKFpyPov-faJ9dUszi38Q7-4OsowX=i8w=NCnTQ66_zooHg@mail.gmail.com>
 <CAJZ5v0iEfE35Aig8XADKbQEJqb8PNmcghLnrVXHkemDjTOLr5g@mail.gmail.com>
 <CAPDyKFqVrYKyUjxoErPBuahcgDNX7esspWG4Vqi0q-8_u7MoFQ@mail.gmail.com> <CAJZ5v0jV5QS6yxBgK0OHJ_7ivDPs7tL7Ms19dNBTUAYSfKDkCg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jV5QS6yxBgK0OHJ_7ivDPs7tL7Ms19dNBTUAYSfKDkCg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Dec 2021 10:02:01 +0100
Message-ID: <CAPDyKFp+eWx3BHuPw1-GRp0uUAusNBLkhKpRkY3G+8zjXn5FZw@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 18:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 30, 2021 at 5:41 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 30 Nov 2021 at 14:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Nov 30, 2021 at 12:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > [...]
> > > >
> > > > > > > > > >
> > > > > > > > > > Am I thinking correctly that this is mostly about working around the
> > > > > > > > > > limitations of pm_runtime_force_suspend()?
> > > > > > > > >
> > > > > > > > > No, this isn't related at all.
> > > > > > > > >
> > > > > > > > > The cpuidle-psci driver doesn't have PM callbacks, thus using
> > > > > > > > > pm_runtime_force_suspend() would not work here.
> > > > > > > >
> > > > > > > > Just wanted to send a ping on this to see if we can come to a
> > > > > > > > conclusion. Or maybe we did? :-)
> > > > > > > >
> > > > > > > > I think in the end, what slightly bothers me, is that the behavior is
> > > > > > > > a bit inconsistent. Although, maybe it's the best we can do.
> > > > > > >
> > > > > > > I've been thinking about this and it looks like we can do better, but
> > > > > > > instead of talking about this I'd rather send a patch.
> > > > > >
> > > > > > Alright.
> > > > > >
> > > > > > I was thinking along the lines of make similar changes for
> > > > > > rpm_idle|suspend(). That would make the behaviour even more
> > > > > > consistent, I think.
> > > > > >
> > > > > > Perhaps that's what you have in mind? :-)
> > > > >
> > > > > Well, not exactly.
> > > > >
> > > > > The idea is to add another counter (called restrain_depth in the patch)
> > > > > to prevent rpm_resume() from running the callback when that is potentially
> > > > > problematic.  With that, it is possible to actually distinguish devices
> > > > > with PM-runtime enabled and it allows the PM-runtime status to be checked
> > > > > when it is still known to be meaningful.
> > > >
> > > > Hmm, I don't quite understand the benefit of introducing a new flag
> > > > for this. rpm_resume() already checks the disable_depth to understand
> > > > when it's safe to invoke the callback. Maybe there is a reason why
> > > > that isn't sufficient?
> > >
> > > The problem is that disable_depth > 0 may very well mean that runtime
> > > PM has not been enabled at all for the given device which IMO is a
> > > problem.
> > >
> > > As it stands, it is necessary to make assumptions, like disable_depth
> > > == 1 meaning that runtime PM is really enabled, but the PM core has
> > > disabled it temporarily, which is somewhat questionable.
> > >
> > > Another problem with disabling is that it causes rpm_resume() to fail
> > > even if the status is RPM_ACTIVE and it has to do that exactly because
> > > it cannot know why runtime PM has been disabled.  If it has never been
> > > enabled, rpm_resume() must fail, but if it has been disabled
> > > temporarily, rpm_resume() may return 1 when the status is RPM_ACTIVE.
> > >
> > > The new count allows the "enabled in general, but temporarily disabled
> > > at the moment" to be handled cleanly.
> >
> > My overall comment is that I fail to understand why we need to
> > distinguish between these two cases. To me, it shouldn't really
> > matter, *why* runtime PM is (or have been) disabled for the device.
>
> It matters if you want to trust the status, because "disabled" means
> "the status doesn't matter".

Well, that doesn't really match how the runtime PM interface is being
used today.

For example, we have a whole bunch of helper functions, allowing us to
update and check the runtime PM state of the device, even when the
disable_depth > 0. Some functions, like pm_runtime_set_active() for
example, even take parents and device-links into account.

>
> If you want the status to stay meaningful, but prevent callbacks from
> running, you need something else.
>
> > The important point is that the default state for a device is
> > RPM_SUSPENDED and someone has moved into RPM_ACTIVE, for whatever
> > reason. That should be sufficient to allow rpm_resume() to return '1'
> > when disable_depth > 0, shouldn't it?
>
> No, because there is no rule by which the status of devices with
> PM-runtime disabled must be RPM_SUSPENDED.

That's not what I was trying to say.

The initial/default runtime PM state for a device is RPM_SUSPENDED,
which is being set in pm_runtime_init(). Although, I agree that it
can't be trusted that this state actually reflects the state of the
HW, it's still a valid state for the device from a runtime PM point of
view.

However, and more importantly, if the state has moved to RPM_ACTIVE,
someone must have deliberately moved the device into that state. For
this reason, I believe it seems reasonable to trust it, both from HW
point of view, but definitely also from a runtime PM point of view. If
not, then what should we do?

[...]

Kind regards
Uffe
