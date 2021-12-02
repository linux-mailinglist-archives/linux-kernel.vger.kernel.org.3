Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF084667BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359392AbhLBQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:22:02 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36487 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359376AbhLBQWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:22:00 -0500
Received: by mail-ot1-f53.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so328674otl.3;
        Thu, 02 Dec 2021 08:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGr6jOv41SrTwtlqda0X2UyFg0226rw2ZkBazfb+o5k=;
        b=gBwyYvNphxIuXkfh8JioOYQUXLmSrGfR5EPZSuWWfxbVZzRcOde8AOucdEXFJxL2nh
         +vJRRk/N/nX6t6BcFf39SNG28hl0oEDs1XrYn842SM30ALh2LdMWIfzdRdKZuaReD8vo
         pKHGoYFClXoTiZu7/C8wUQgJyja409d9WKqkfTIsL3dKAPEIZS8QyR0uYXNl3GhynnhX
         Eck3KUT+Hx5DZQzlxzz48+d382R1E5oY9GMh2tFxNMockxJ0HawwVE2OnZ37XGqpGb0k
         UFIFhHBQ5//qV/+YPYoWuvUI7vxaZvzgZGqBPLhrytpgQbzGJ8KiN9LL+Uu0apTqQPoe
         Ojaw==
X-Gm-Message-State: AOAM531bwG8xw2oWX2m/kPzKFHzeQf+fLZlagJB2JWr3gH5jEnN14wpa
        L/n8LXPbe5D/NnIbs8sEzEcUmf3/OLh0K0fgwv4=
X-Google-Smtp-Source: ABdhPJzHtVZSjjV45oLOos1CN7dzyFhbiQ1Y0F1gcAsRPvCm96dSQKmyAPmC6g2VeVAP6kg8JB2XLavoRt1oU+ES53E=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr12078971otf.198.1638461917691;
 Thu, 02 Dec 2021 08:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <CAPDyKFrFdt_U7By_bqk4DBHxCBLpDe00aRb6P6BmwR4MYM2OmQ@mail.gmail.com>
 <CAJZ5v0i6WPVCf4pf9uTx5vjutw0cbD+omL_FNtw6DrxYDhyYEA@mail.gmail.com>
 <5794197.lOV4Wx5bFT@kreacher> <CAPDyKFrPC=8cAKGWQ4cDEcD934gi-012CWXu+uh-B_pqX+0RYQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrPC=8cAKGWQ4cDEcD934gi-012CWXu+uh-B_pqX+0RYQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Dec 2021 17:18:26 +0100
Message-ID: <CAJZ5v0ijRK0sYoJ6_WyqrhQfYKxEf4jCSjK4T5CbQsYPXaB=Nw@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Dec 2, 2021 at 12:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 1 Dec 2021 at 21:11, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, December 1, 2021 6:44:08 PM CET Rafael J. Wysocki wrote:
> > > On Wed, Dec 1, 2021 at 4:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Wed, 1 Dec 2021 at 14:49, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Wed, Dec 1, 2021 at 10:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 30 Nov 2021 at 18:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 30, 2021 at 5:41 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, 30 Nov 2021 at 14:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Nov 30, 2021 at 12:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > [...]
> > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Am I thinking correctly that this is mostly about working around the
> > > > > > > > > > > > > > > > limitations of pm_runtime_force_suspend()?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > No, this isn't related at all.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The cpuidle-psci driver doesn't have PM callbacks, thus using
> > > > > > > > > > > > > > > pm_runtime_force_suspend() would not work here.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Just wanted to send a ping on this to see if we can come to a
> > > > > > > > > > > > > > conclusion. Or maybe we did? :-)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think in the end, what slightly bothers me, is that the behavior is
> > > > > > > > > > > > > > a bit inconsistent. Although, maybe it's the best we can do.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I've been thinking about this and it looks like we can do better, but
> > > > > > > > > > > > > instead of talking about this I'd rather send a patch.
> > > > > > > > > > > >
> > > > > > > > > > > > Alright.
> > > > > > > > > > > >
> > > > > > > > > > > > I was thinking along the lines of make similar changes for
> > > > > > > > > > > > rpm_idle|suspend(). That would make the behaviour even more
> > > > > > > > > > > > consistent, I think.
> > > > > > > > > > > >
> > > > > > > > > > > > Perhaps that's what you have in mind? :-)
> > > > > > > > > > >
> > > > > > > > > > > Well, not exactly.
> > > > > > > > > > >
> > > > > > > > > > > The idea is to add another counter (called restrain_depth in the patch)
> > > > > > > > > > > to prevent rpm_resume() from running the callback when that is potentially
> > > > > > > > > > > problematic.  With that, it is possible to actually distinguish devices
> > > > > > > > > > > with PM-runtime enabled and it allows the PM-runtime status to be checked
> > > > > > > > > > > when it is still known to be meaningful.
> > > > > > > > > >
> > > > > > > > > > Hmm, I don't quite understand the benefit of introducing a new flag
> > > > > > > > > > for this. rpm_resume() already checks the disable_depth to understand
> > > > > > > > > > when it's safe to invoke the callback. Maybe there is a reason why
> > > > > > > > > > that isn't sufficient?
> > > > > > > > >
> > > > > > > > > The problem is that disable_depth > 0 may very well mean that runtime
> > > > > > > > > PM has not been enabled at all for the given device which IMO is a
> > > > > > > > > problem.
> > > > > > > > >
> > > > > > > > > As it stands, it is necessary to make assumptions, like disable_depth
> > > > > > > > > == 1 meaning that runtime PM is really enabled, but the PM core has
> > > > > > > > > disabled it temporarily, which is somewhat questionable.
> > > > > > > > >
> > > > > > > > > Another problem with disabling is that it causes rpm_resume() to fail
> > > > > > > > > even if the status is RPM_ACTIVE and it has to do that exactly because
> > > > > > > > > it cannot know why runtime PM has been disabled.  If it has never been
> > > > > > > > > enabled, rpm_resume() must fail, but if it has been disabled
> > > > > > > > > temporarily, rpm_resume() may return 1 when the status is RPM_ACTIVE.
> > > > > > > > >
> > > > > > > > > The new count allows the "enabled in general, but temporarily disabled
> > > > > > > > > at the moment" to be handled cleanly.
> > > > > > > >
> > > > > > > > My overall comment is that I fail to understand why we need to
> > > > > > > > distinguish between these two cases. To me, it shouldn't really
> > > > > > > > matter, *why* runtime PM is (or have been) disabled for the device.
> > > > > > >
> > > > > > > It matters if you want to trust the status, because "disabled" means
> > > > > > > "the status doesn't matter".
> > > > > >
> > > > > > Well, that doesn't really match how the runtime PM interface is being
> > > > > > used today.
> > > > >
> > > > > Well, I clearly disagree.
> > > >
> > > > Alright, then we can agree to disagree. :-)
> > > >
> > > > >
> > > > > > For example, we have a whole bunch of helper functions, allowing us to
> > > > > > update and check the runtime PM state of the device, even when the
> > > > > > disable_depth > 0. Some functions, like pm_runtime_set_active() for
> > > > > > example, even take parents and device-links into account.
> > > > >
> > > > > That's true, but that's for a purpose.
> > > > >
> > > > > If runtime PM becomes enabled after using pm_runtime_set_active(), the
> > > > > status should better be consistent with the settings of the parent
> > > > > etc.
> > > > >
> > > > > > >
> > > > > > > If you want the status to stay meaningful, but prevent callbacks from
> > > > > > > running, you need something else.
> > > > > > >
> > > > > > > > The important point is that the default state for a device is
> > > > > > > > RPM_SUSPENDED and someone has moved into RPM_ACTIVE, for whatever
> > > > > > > > reason. That should be sufficient to allow rpm_resume() to return '1'
> > > > > > > > when disable_depth > 0, shouldn't it?
> > > > > > >
> > > > > > > No, because there is no rule by which the status of devices with
> > > > > > > PM-runtime disabled must be RPM_SUSPENDED.
> > > > > >
> > > > > > That's not what I was trying to say.
> > > > > >
> > > > > > The initial/default runtime PM state for a device is RPM_SUSPENDED,
> > > > > > which is being set in pm_runtime_init(). Although, I agree that it
> > > > > > can't be trusted that this state actually reflects the state of the
> > > > > > HW, it's still a valid state for the device from a runtime PM point of
> > > > > > view.
> > > > >
> > > > > No, it is not.  It's just the default.
> > > > >
> > > > > > However, and more importantly, if the state has moved to RPM_ACTIVE,
> > > > > > someone must have deliberately moved the device into that state.
> > > > >
> > > > > Sure, but it cannot be regarded as an indication on whether or not
> > > > > runtime PM is supported and has ever been enabled for the given
> > > > > device.
> > > > >
> > > > > Again, there is no rule regarding the status value for devices with
> > > > > runtime PM disabled, either way.
> > > >
> > > > If I understand correctly, that means you think the
> > > > pm_runtime_status_suspended() should really be converted to an
> > > > internal runtime PM interface, not being exported to users outside.
> > > > Right?
> > >
> > > Not really.
> > >
> > > I'm just saying that its usefulness is limited.
> > >
> > > My basic concern is that system-wide PM transitions must always invoke
> > > callbacks for devices with PM-runtime disabled, because they may (or
> > > may not) be functional regardless of the PM-runtime status and if they
> > > are functional, they must be suspended.  And note that supporting
> > > system-wide PM is not optional and the only way to kind of disable it
> > > is to return an error from a device suspend callback (but that's nasty
> > > for some use cases).
> > >
> > > So the "Has PM-runtime been enabled?" question is really fundamental
> > > for system-wide PM and it is not sufficient to look at the PM-runtime
> > > status to find out, but if the PM-core itself disables PM-runtime
> > > (which is has to do at one point to prevent PM-runtime from racing
> > > with system-wide PM), it is hard to answer definitely in general.
> > >
> > > IMO the only way to make it possible to find that out in all cases is
> > > to make the PM core retain the power.disable_depth value and that can
> > > be done by making it use a different mechanism to prevent PM-runtime
> > > callbacks from being run.
> > >
> > > Alternatively, the current PM-runtime status could be "latched" during
> > > the PM-runtime disable operation if power.disable_depth is 0 (and that
> > > "latched" value would be initialized to "invalid" in case PM-runtime
> > > is never enabled).
> >
> > Which would be something like the patch below (which additionally cleans up
> > pm_runtime_enable() while at it).
> >
> > The idea being that if the status was RPM_ACTIVE last time when
> > power.disable_depth was changing from 0 to 1 and it is still RPM_ACTIVE, it
> > can be assumed to reflect what happened to the device last time when it was
> > using PM-runtime.
>
> Alright, this sounds reasonable to me. I have also looked at the code
> below and it looks good to me.
>
> Do you intend to post a formal patch? In any case, feel free to add my
> reviewed-by tag.

I will, thank you!
