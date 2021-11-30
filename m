Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB14633B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhK3MBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhK3MBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:01:53 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA588C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:58:33 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b1so52945698lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUI7lM6j0yVUXU/VQOfLGrMpPkFmHjF6wGiG0cDhsTs=;
        b=x9ezhQOPHYQdWlV4CTr+LvYyiXx2M7u/DkIro3z9WfP3lNpoIcySTTh8sc5GjHqfSM
         EuQRSHBP8C14wqbXUJke0Nk/o7OvRr99fGATa6lZj7DevsDPiVEVveEYoX3jzr/WE3RR
         pZ82w7p8JuFg/i2VwBFlkY+Qm26c42Zh3uY54F2ttS+OoSdSiV28Xqi5L96BgKOhRvRI
         vYz2pPwgj1SIn7dhJbv3jMHoqSz0tFJyYFE0Y8LlOamAWqBdCNpq4ROS7pOJ6ctmtQy1
         wJUNRS1YOiiAIC9cP/Y61yDhwpgcJKxj7CU9rQPrbW8eowdx7fIon2IDRrl6VhgKvUsz
         Un1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUI7lM6j0yVUXU/VQOfLGrMpPkFmHjF6wGiG0cDhsTs=;
        b=bIoADOzB3A/+2vb+UrBhPZP2lPN8nmJ9bMgVuTAGXXLChWkcVhaUlAPdKIa2Z2wEFG
         XTHYTG1eV9mIs9g7wicKkUV0ClqKuX6sK0+g4MCx4g1AZ6fBP5uzhKrkn1IdndSW1rNb
         casjHor+P4ELUtFaaSdpdnYtOfTF5fNrra6O9PLISoRubLOeSSoxv2zxRUoWaw1wlVIl
         vG1jVCQMWuylFbU9e/LvE+WNh2m5gvZmFS3KAkqx+i3WLsyfz1y9FLZlaBf2qBLUO68D
         cRfM4O+pBhnZrtAkbJKl3t3oHRx5+gVlAIt4jNeS0ScYXNK+CbSUoPvA1ApJTUl53UOB
         I62w==
X-Gm-Message-State: AOAM531MV6zKaATYWResr43JcMDLykPfw1Nw6R1PUSt9Jamg5TONQZQB
        itHxifnSYXdLiygaxtSvQ/A22eiaLL1lEwu6u+hxGw==
X-Google-Smtp-Source: ABdhPJy6Zdo52M/SOZZJ/k4UuqwWnemrqF06kHPE0HL8jOXAAeEcgsHsoa4EepIkyV2I+HXG3ABLmjBXjW0gDbC4lIo=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr54730420lfv.233.1638273511788;
 Tue, 30 Nov 2021 03:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <CAJZ5v0hrTDsCUn4vgmFrTTgd6H=orh-Kb5b3+_H9St4n8fTxBw@mail.gmail.com>
 <CAPDyKFre=tp4919FLoeU-wjLDJ02zmHaXY4wgTUmfmFbeaCadQ@mail.gmail.com> <4380690.LvFx2qVVIh@kreacher>
In-Reply-To: <4380690.LvFx2qVVIh@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Nov 2021 12:57:55 +0100
Message-ID: <CAPDyKFpyPov-faJ9dUszi38Q7-4OsowX=i8w=NCnTQ66_zooHg@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

[...]

> > > > > >
> > > > > > Am I thinking correctly that this is mostly about working around the
> > > > > > limitations of pm_runtime_force_suspend()?
> > > > >
> > > > > No, this isn't related at all.
> > > > >
> > > > > The cpuidle-psci driver doesn't have PM callbacks, thus using
> > > > > pm_runtime_force_suspend() would not work here.
> > > >
> > > > Just wanted to send a ping on this to see if we can come to a
> > > > conclusion. Or maybe we did? :-)
> > > >
> > > > I think in the end, what slightly bothers me, is that the behavior is
> > > > a bit inconsistent. Although, maybe it's the best we can do.
> > >
> > > I've been thinking about this and it looks like we can do better, but
> > > instead of talking about this I'd rather send a patch.
> >
> > Alright.
> >
> > I was thinking along the lines of make similar changes for
> > rpm_idle|suspend(). That would make the behaviour even more
> > consistent, I think.
> >
> > Perhaps that's what you have in mind? :-)
>
> Well, not exactly.
>
> The idea is to add another counter (called restrain_depth in the patch)
> to prevent rpm_resume() from running the callback when that is potentially
> problematic.  With that, it is possible to actually distinguish devices
> with PM-runtime enabled and it allows the PM-runtime status to be checked
> when it is still known to be meaningful.

Hmm, I don't quite understand the benefit of introducing a new flag
for this. rpm_resume() already checks the disable_depth to understand
when it's safe to invoke the callback. Maybe there is a reason why
that isn't sufficient?

>
> It requires quite a few changes, but is rather straightforward, unless I'm
> missing something.
>
> Please see the patch below.  I've only checked that it builds on x86-64.
>
> ---
>  drivers/base/power/main.c    |   18 +++----
>  drivers/base/power/runtime.c |  105 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/pm.h           |    2
>  include/linux/pm_runtime.h   |    2
>  4 files changed, 101 insertions(+), 26 deletions(-)
>
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -598,6 +598,7 @@ struct dev_pm_info {
>         atomic_t                usage_count;
>         atomic_t                child_count;
>         unsigned int            disable_depth:3;
> +       unsigned int            restrain_depth:3;       /* PM core private */
>         unsigned int            idle_notification:1;
>         unsigned int            request_pending:1;
>         unsigned int            deferred_resume:1;
> @@ -609,6 +610,7 @@ struct dev_pm_info {
>         unsigned int            use_autosuspend:1;
>         unsigned int            timer_autosuspends:1;
>         unsigned int            memalloc_noio:1;
> +       unsigned int            already_suspended:1;    /* PM core private */
>         unsigned int            links_count;
>         enum rpm_request        request;
>         enum rpm_status         runtime_status;
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -46,6 +46,8 @@ extern void pm_runtime_enable(struct dev
>  extern void __pm_runtime_disable(struct device *dev, bool check_resume);
>  extern void pm_runtime_allow(struct device *dev);
>  extern void pm_runtime_forbid(struct device *dev);
> +extern void pm_runtime_restrain(struct device *dev);
> +extern void pm_runtime_relinquish(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
>  extern void pm_runtime_irq_safe(struct device *dev);
>  extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -744,11 +744,11 @@ static int rpm_resume(struct device *dev
>   repeat:
>         if (dev->power.runtime_error)
>                 retval = -EINVAL;
> -       else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> -           && dev->power.runtime_status == RPM_ACTIVE)
> -               retval = 1;
>         else if (dev->power.disable_depth > 0)
>                 retval = -EACCES;
> +       else if (dev->power.restrain_depth > 0)
> +               retval = dev->power.runtime_status == RPM_ACTIVE ? 1 : -EAGAIN;
> +
>         if (retval)
>                 goto out;
>
> @@ -1164,9 +1164,9 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_acti
>   * @dev: Device to handle.
>   * @status: New runtime PM status of the device.
>   *
> - * If runtime PM of the device is disabled or its power.runtime_error field is
> - * different from zero, the status may be changed either to RPM_ACTIVE, or to
> - * RPM_SUSPENDED, as long as that reflects the actual state of the device.
> + * If runtime PM of the device is disabled or restrained, or its
> + * power.runtime_error field is nonzero, the status may be changed either to
> + * RPM_ACTIVE, or to RPM_SUSPENDED, as long as that reflects its actual state.
>   * However, if the device has a parent and the parent is not active, and the
>   * parent's power.ignore_children flag is unset, the device's status cannot be
>   * set to RPM_ACTIVE, so -EBUSY is returned in that case.
> @@ -1195,13 +1195,16 @@ int __pm_runtime_set_status(struct devic
>         spin_lock_irq(&dev->power.lock);
>
>         /*
> -        * Prevent PM-runtime from being enabled for the device or return an
> -        * error if it is enabled already and working.
> +        * Prevent PM-runtime from being used for the device or return an
> +        * error if it is in use already.
>          */
> -       if (dev->power.runtime_error || dev->power.disable_depth)
> -               dev->power.disable_depth++;
> -       else
> +       if (dev->power.runtime_error || dev->power.disable_depth ||
> +           dev->power.restrain_depth) {
> +               pm_runtime_get_noresume(dev);

Why do we need to bump the usage count here? Except for balancing with
pm_runtime_relinquish() a few lines below, of course?

> +               dev->power.restrain_depth++;
> +       } else {
>                 error = -EAGAIN;
> +       }
>
>         spin_unlock_irq(&dev->power.lock);
>
> @@ -1278,7 +1281,7 @@ int __pm_runtime_set_status(struct devic
>                 device_links_read_unlock(idx);
>         }
>
> -       pm_runtime_enable(dev);
> +       pm_runtime_relinquish(dev);
>
>         return error;
>  }
> @@ -1513,6 +1516,72 @@ void pm_runtime_allow(struct device *dev
>  EXPORT_SYMBOL_GPL(pm_runtime_allow);
>
>  /**
> + * pm_runtime_restrain - Temporarily block runtime PM of a device.
> + * @dev: Device to handle.
> + *
> + * Increase the device's usage count and its restrain_dpeth count.  If the
> + * latter was 0 initially, cancel the runtime PM work for @dev if pending and
> + * wait for all of the runtime PM operations on it in progress to complete.
> + *
> + * After this function has been called, attempts to runtime-suspend @dev will
> + * fail with -EAGAIN and attempts to runtime-resume it will succeed if its
> + * runtime PM status is RPM_ACTIVE and will fail with -EAGAIN otherwise.
> + *
> + * This function can only be called by the PM core.
> + */
> +void pm_runtime_restrain(struct device *dev)
> +{
> +       pm_runtime_get_noresume(dev);
> +
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.restrain_depth++ > 0)
> +               goto out;
> +
> +       if (dev->power.disable_depth > 0) {
> +               dev->power.already_suspended = false;
> +               goto out;
> +       }
> +
> +       /* Update time accounting before blocking PM-runtime. */
> +       update_pm_runtime_accounting(dev);
> +
> +       __pm_runtime_barrier(dev);
> +
> +       dev->power.already_suspended = pm_runtime_status_suspended(dev);
> +
> +out:
> +       spin_unlock_irq(&dev->power.lock);
> +}

What if someone calls pm_runtime_disable() after the PM core has
called pm_runtime_restrain() for a device? It looks like we may run
another round of __pm_runtime_barrier() and
update_pm_runtime_accounting(), does that really make sense?

> +
> +/**
> + * pm_runtime_relinquish - Unblock runtime PM of a device.
> + * @dev: Device to handle.
> + *
> + * Decrease the device's usage count and its restrain_dpeth count.
> + *
> + * This function can only be called by the PM core.
> + */
> +void pm_runtime_relinquish(struct device *dev)
> +{
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.restrain_depth > 0) {
> +               dev->power.restrain_depth--;
> +
> +               /* About to unbolck runtime PM, set accounting_timestamp to now */
> +               if (!dev->power.restrain_depth && !dev->power.disable_depth)
> +                       dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
> +       } else {
> +               dev_warn(dev, "Unbalanced %s!\n", __func__);
> +       }
> +
> +       spin_unlock_irq(&dev->power.lock);
> +
> +       pm_runtime_put_noidle(dev);
> +}
> +
> +/**
>   * pm_runtime_no_callbacks - Ignore runtime PM callbacks for a device.
>   * @dev: Device to handle.
>   *
> @@ -1806,8 +1875,10 @@ int pm_runtime_force_suspend(struct devi
>         int (*callback)(struct device *);
>         int ret;
>
> -       pm_runtime_disable(dev);
> -       if (pm_runtime_status_suspended(dev))
> +       pm_runtime_restrain(dev);
> +
> +       /* No suspend if the device has already been suspended by PM-runtime. */
> +       if (!dev->power.already_suspended)

I assume you are looking at using pm_runtime_force_suspend|resume() to
support my use case for the cpuidle-psci driver? In other words,
replace pm_runtime_get_sync() and pm_runtime_put_sync_suspend() in
__psci_enter_domain_idle_state(), right?

If so, that doesn't really fit well, I think. Not only because we
don't have system suspend/resume callbacks available, which is really
the proper place to call the pm_runtime_force_*() functions from, but
also because we don't want to call __pm_runtime_barrier(), etc, every
time in the idle path of a CPU. If anything, we should instead strive
towards a more lightweight path than what we currently have.

>                 return 0;
>
>         callback = RPM_GET_CALLBACK(dev, runtime_suspend);
> @@ -1832,7 +1903,7 @@ int pm_runtime_force_suspend(struct devi
>         return 0;
>
>  err:
> -       pm_runtime_enable(dev);
> +       pm_runtime_relinquish(dev);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
> @@ -1854,7 +1925,7 @@ int pm_runtime_force_resume(struct devic
>         int (*callback)(struct device *);
>         int ret = 0;
>
> -       if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
> +       if (!dev->power.already_suspended || !dev->power.needs_force_resume)
>                 goto out;
>
>         /*
> @@ -1874,7 +1945,7 @@ int pm_runtime_force_resume(struct devic
>         pm_runtime_mark_last_busy(dev);
>  out:
>         dev->power.needs_force_resume = 0;
> -       pm_runtime_enable(dev);
> +       pm_runtime_relinquish(dev);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_force_resume);
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -809,7 +809,7 @@ Skip:
>  Out:
>         TRACE_RESUME(error);
>
> -       pm_runtime_enable(dev);
> +       pm_runtime_relinquish(dev);
>         complete_all(&dev->power.completion);
>         return error;
>  }
> @@ -907,8 +907,8 @@ static int device_resume(struct device *
>                 goto Complete;
>
>         if (dev->power.direct_complete) {
> -               /* Match the pm_runtime_disable() in __device_suspend(). */
> -               pm_runtime_enable(dev);
> +               /* Match the pm_runtime_restrict() in __device_suspend(). */
> +               pm_runtime_relinquish(dev);
>                 goto Complete;
>         }
>
> @@ -1392,7 +1392,7 @@ static int __device_suspend_late(struct
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> -       __pm_runtime_disable(dev, false);
> +       pm_runtime_restrain(dev);
>
>         dpm_wait_for_subordinate(dev, async);
>
> @@ -1627,9 +1627,9 @@ static int __device_suspend(struct devic
>          * callbacks for it.
>          *
>          * If the system-wide suspend callbacks below change the configuration
> -        * of the device, they must disable runtime PM for it or otherwise
> -        * ensure that its runtime-resume callbacks will not be confused by that
> -        * change in case they are invoked going forward.
> +        * of the device, they must ensure that its runtime-resume callbacks
> +        * will not be confused by that change in case they are invoked going
> +        * forward.
>          */
>         pm_runtime_barrier(dev);
>
> @@ -1648,13 +1648,13 @@ static int __device_suspend(struct devic
>
>         if (dev->power.direct_complete) {
>                 if (pm_runtime_status_suspended(dev)) {
> -                       pm_runtime_disable(dev);
> +                       pm_runtime_restrain(dev);
>                         if (pm_runtime_status_suspended(dev)) {
>                                 pm_dev_dbg(dev, state, "direct-complete ");
>                                 goto Complete;
>                         }
>
> -                       pm_runtime_enable(dev);
> +                       pm_runtime_relinquish(dev);
>                 }
>                 dev->power.direct_complete = false;
>         }
>
>
>

Kind regards
Uffe
