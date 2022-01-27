Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9548849EC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbiA0UKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:10:47 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:33643 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbiA0UKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:10:45 -0500
Received: by mail-yb1-f174.google.com with SMTP id l68so12295050ybl.0;
        Thu, 27 Jan 2022 12:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh+UlDf/TEfrWF/4dLOcpRWKXy/rGv4qkE/LWOydCEU=;
        b=VzKMX/umQH3GLHH8plYvpHJysEDD0dZL+41KvnSMfQ9D27OQOmWeSYgqx1/Qiq2vVO
         0KIPlihYXZPdP4XNdr0VQmc1apdpTTtaISIBPakvfIIeC8+sI6dyvCBmau99JkCYzfAq
         Z2JVXKZbZeHRSjlxdbbJhL3A1cmM3zAdp8r3BC9aAfvDK4WIgq2r63APluHLC73Qvep8
         vVapGUyhQK0ZXzQcfaU9tTiPyMUjRqqnYGUx3qKwDEnuh6BgU7ZZ7zHRSslUINUPOtrQ
         BDcZDPDCcHkj2XzOH5kcNUTYKnpbqma/CjZXv/Pt1OTVopWSBHo5ZxbcxOaB+M4CzMgt
         xhlQ==
X-Gm-Message-State: AOAM533Ia/3Ig1kDRy6vr06pqeEBzcferopnP8zTFkfQ803Q7auVSygh
        krots3ar4ZOKh2apYqaqQsBqESUqvzl9NtQtByM=
X-Google-Smtp-Source: ABdhPJxONF5czKwKSr4XjHPsxyOZpvAMwe77IoMGqGHLhMjlI7aWj9Ry3JZes3jus7I/ZL+eEQZOs4ed0Zan2Vgsxg0=
X-Received: by 2002:a25:180a:: with SMTP id 10mr8572542yby.552.1643314236571;
 Thu, 27 Jan 2022 12:10:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
 <CAJZ5v0jrU4Xw2wzdUL9Vd2C6u8NVx5J79DeiRY6KU1xT6ZSuqw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jrU4Xw2wzdUL9Vd2C6u8NVx5J79DeiRY6KU1xT6ZSuqw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jan 2022 21:10:25 +0100
Message-ID: <CAJZ5v0gLMSPsaS7Jnsr8DhevaQamsVk=pu=BfXZxrT+SBAM=fQ@mail.gmail.com>
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

On Thu, Jan 27, 2022 at 8:54 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jan 10, 2022 at 7:49 PM Kelly Rossmoyer <krossmo@google.com> wrote:
> >
> > # Introduction
> >
> > To aid optimization, troubleshooting, and attribution of battery life, the
> > Android kernel currently includes a set of patches which provide enhanced
> > visibility into kernel suspend/resume/abort behaviors.  The capabilities
> > and implementation of this feature have evolved significantly since an
> > unsuccessful attempt to upstream the original code
> > (https://lkml.org/lkml/2014/3/10/716), and we would like to (re)start a
> > conversation about upstreaming, starting with the central question: is
> > there support for upstreaming this set of features?
> >
> > # Motivation
> >
> > Of the many factors influencing battery life on Linux-powered mobile
> > devices, kernel suspend tends to be amongst the most impactful.  Maximizing
> > time spent in suspend and minimizing the frequency of net-negative suspend
> > cycles are both important contributors to battery life optimization.  But
> > enabling that optimization - and troubleshooting when things go wrong -
> > requires more observability of suspend/resume/abort behavior than Linux
> > currently provides.  While mechanisms like `/sys/power/pm_wakeup_irq` and
> > wakeup_source stats are useful, they are incomplete and scattered.  The
> > Android kernel wakeup reason patches implement significant improvements in
> > that area.
> >
> > # Features
> >
> > As of today, the active set of patches surface the following
> > suspend-related data:
> >
> > * wakeup IRQs, including:
> >    * multiple IRQs if more than one is pending during resume flow
> >    * unmapped HW IRQs (wakeup-capable in HW) that should not be
> >      occurring
> >    * misconfigured IRQs (e.g. both enable_irq_wake() and
> >      IRQF_NO_SUSPEND)
> >    * threaded IRQs (not just the parent chip's IRQ)
> >
> > * non-IRQ wakeups, including:
> >    * wakeups caused by an IRQ that was consumed by lower-level SW
> >    * wakeups from SOC architecture that don't manifest as IRQs
> >
> > * abort reasons, including:
> >    * wakeup_source activity
> >    * failure to freeze userspace
> >    * failure to suspend devices
> >    * failed syscore_suspend callback
> >
> > * durations from the most recent cycle, including:
> >    * time spent doing suspend/resume work
> >    * time spent in suspend
> >
> > In addition to battery life optimization and troubleshooting, some of these
> > capabilities also lay the groundwork for efforts around improving
> > attribution of wakeups/aborts (e.g. to specific processes, device features,
> > external devices, etc).
> >
> > # Shortcomings
> >
> > While the core implementation (see below) is relatively straightforward and
> > localized, calls into that core are somewhat widely spread in order to
> > capture the breadth of events of interest.  The pervasiveness of those
> > hooks is clearly an area where improvement would be beneficial, especially
> > if a cleaner solution preserved equivalent capabilities.
> >
> > # Existing Code
> >
> > As a reference for how Android currently implements the core code for these
> > features (which would need a bit of work before submission even if all
> > features were included), see the following link:
> >
> > https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/kernel/power/wakeup_reason.c
>
> So as Zichar said, this is quite heavy-weight.
>
> I'm not fundamentally against adding more infrastructure to help
> identify issues related to system suspend, but there needs to be a
> clear benefit associated with any change in this direction.

That said, the general idea behind wakeup_source objects is that every
system wakeup event should be recorded in one of them which then can
be used for later analysis.

If there are reasons why this cannot work in general, what are they?
