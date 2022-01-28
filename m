Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9049FFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbiA1R6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiA1R6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:58:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E9DC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:58:34 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z19so13234334lfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=px8ft9YcMDwC+zrkkIg3YB+CkDqamT9CA53FOEGzs94=;
        b=d7tZJxXjctGyAuZSFp2b6SG2kFuufrhf/7h1QBSIAzMsH/vREuVGebHctZMIANoEDK
         ykGwTYPpdtWL+ImcPxZ0cv3paVshrH+r7ZaSXDXwFCjMsU70U6bYOuJEILUHbhtawprj
         +5k0a9zppdjiO7oHTZ0yYZaIIGZZsbhrsGnOmsh4dPHtw0bXDwwlAzFPT0he6r7eH/hW
         SOSUD86EKdzrSIJNIWH8IsltU29IRuLHeuHXrGDMC8xAFtDEg/WWwi4BuLmghTxSAXlo
         cIC64eR9ERnKNnwr4MVnLX3l3GyTVYxPmKS2VFj2Dz9EKMxWRcblwlaGzYosMWznKpH4
         R0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=px8ft9YcMDwC+zrkkIg3YB+CkDqamT9CA53FOEGzs94=;
        b=jyoC3FLV/2cCBFdnVfMMEZ4nGihgLSidHSeZKo2h0KVX/S3FMgiBxfCeGFW0xDH7US
         pi+wjmzD9qQia2U9nCluewwQrc2yurEgJqBHahA60xq/WK32zj1uglff7QBiliYdWvrJ
         DWaTcUklol93D2B36Lzjv1O8CJ3ZRgk4l9gf3ksyAlx/czBbzea/0niLh1zYqC6ETfsz
         V0iT4yBkv5agi+tiaCMDzxQxNu/FxSqEjZxDWUhAzm+XL0VxG307sGYnAlJaegkAQWLa
         fQV/V2oyj72UhSfp0Z7jmDblT+tQ9hLvAmX3gw1dR4BX9DDw7mlpkt7slvUeWb1toSu+
         zJSw==
X-Gm-Message-State: AOAM530tJUZrRJR1KQXJbpLD3hn295pDtgWJfTUOXp+iwzRM/QNNOgdN
        fz4Tbh8ydbFdStmPFeTKwpN0nawjXggqWBTmvYlX+w==
X-Google-Smtp-Source: ABdhPJyiegThx73CDTsWpTnQpLzaXaci4VbX29zh1HwZCHHQkFlE45EjCNs/o4A50hztD6CHRKhOYE6X9JKSuHf4dF4=
X-Received: by 2002:a19:ee04:: with SMTP id g4mr6803130lfb.157.1643392712450;
 Fri, 28 Jan 2022 09:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20220128014303.2334568-1-jannh@google.com> <CANn89iKWaERfs1iW8jVyRZT8K1LwWM9efiRsx8E1U3CDT39dyw@mail.gmail.com>
 <CAG48ez0sXEjePefCthFdhDskCFhgcnrecEn2jFfteaqa2qwDnQ@mail.gmail.com> <CANn89iKmCYq+WBu_S4OvKOXqRSagTg=t8xKq0WC_Rrw+TpKsbw@mail.gmail.com>
In-Reply-To: <CANn89iKmCYq+WBu_S4OvKOXqRSagTg=t8xKq0WC_Rrw+TpKsbw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Jan 2022 18:58:05 +0100
Message-ID: <CAG48ez1-OyZETvrYAfaHicYW1LbrQUVp=C0EukSWqZrYMej73w@mail.gmail.com>
Subject: Re: [PATCH net] net: dev: Detect dev_hold() after netdev_wait_allrefs()
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:25 AM Eric Dumazet <edumazet@google.com> wrote:
> On Thu, Jan 27, 2022 at 6:14 PM Jann Horn <jannh@google.com> wrote:
> > On Fri, Jan 28, 2022 at 3:09 AM Eric Dumazet <edumazet@google.com> wrote:
> > > On Thu, Jan 27, 2022 at 5:43 PM Jann Horn <jannh@google.com> wrote:
> > > > I've run into a bug where dev_hold() was being called after
> > > > netdev_wait_allrefs(). But at that point, the device is already going
> > > > away, and dev_hold() can't stop that anymore.
> > > >
> > > > To make such problems easier to diagnose in the future:
> > > >
> > > >  - For CONFIG_PCPU_DEV_REFCNT builds: Recheck in free_netdev() whether
> > > >    the net refcount has been elevated. If this is detected, WARN() and
> > > >    leak the object (to prevent worse consequences from a
> > > >    use-after-free).
> > > >  - For builds without CONFIG_PCPU_DEV_REFCNT: Set the refcount to zero.
> > > >    This signals to the generic refcount infrastructure that any attempt
> > > >    to increment the refcount later is a bug.
[...]
> >         if (dev->reg_state == NETREG_UNREGISTERING) {
> >                 ASSERT_RTNL();
> >                 dev->needs_free_netdev = true;
> >                 return;
> >         }
> >
> >         /* Recheck in case someone called dev_hold() between
> >          * netdev_wait_allrefs() and here.
> >          */
> >         if (WARN_ON(netdev_refcnt_read(dev) != 0))
> >                 return; /* leak memory, otherwise we might get UAF */
> >
> >         netif_free_tx_queues(dev);
> >         netif_free_rx_queues(dev);
>
> Maybe another solution would be to leverage the recent dev_hold_track().
>
> We could add a  dead boolean to 'struct  ref_tracker_dir ' (dev->refcnt_tracker)

Hmm... actually, what even are the semantics of dev_hold()?

Normal refcounts have the property that if you hold one reference,
you're always allowed to add another reference. But from what I can
tell, something like this:

struct net_device *dev = dev_get_by_name(net, name);
dev_hold(dev);
dev_put(dev);
dev_put(dev);

would be buggy using the current CONFIG_PCPU_DEV_REFCNT implementation.
Basically, if dev_hold() runs at the same time as
netdev_refcnt_read(), it's a bug because netdev_refcnt_read() is
non-atomic, and we could get the following race:

task B: starts netdev_refcnt_read()
task B: reads *per_cpu_ptr(dev->pcpu_refcnt, 0)
task A, on CPU 0: dev_hold(dev) increments *per_cpu_ptr(dev->pcpu_refcnt, 0)
task A: migrates from CPU 0 to CPU 1
task A, on CPU 1: dev_put(dev) decrements *per_cpu_ptr(dev->pcpu_refcnt, 1)
task B: reads *per_cpu_ptr(dev->pcpu_refcnt, 1)

which would make task B miss one outstanding reference.

(This is why the generic percpu refcounting code in
lib/percpu-refcount.c has logic for switching the refcount to atomic
mode with an RCU grace period.)


If these are the intended semantics for dev_hold(), then I guess your
approach of adding a new boolean flag somewhere is the right one - but
we should be setting that flag *before* waiting for the refcount to
drop to 1. Though maybe it shouldn't be in ref-tracker, since this is
a peculiarity of the hand-rolled netdev refcount...

Are these the intended semantics (and I should rewrite the patch to
also catch dev_hold() racing with netdev_wait_allrefs()), or is this
unintended (and the netdev refcount should be replaced)?

This should probably be documented...
