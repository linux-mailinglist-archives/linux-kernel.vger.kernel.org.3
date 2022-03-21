Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3B4E2B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349857AbiCUPOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243001AbiCUPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:14:06 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945BBD896;
        Mon, 21 Mar 2022 08:12:41 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id l2so28604369ybe.8;
        Mon, 21 Mar 2022 08:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yDyHZ+ujg3ULO9u9rEQgFO83DhT0hcdWvnHIR2XnaA=;
        b=k8bhEa3BKuGsoJMNnmS3rrI79NouFysHkIf4EXhTH8SVFGiAK/Duv3w6eEjI4ObWqE
         58wzJLsObZmYFxFLMFQwCnpAyDPsYHdxbgZePkSPtgLrXAwM7TAgOo4x/IBdpEw1uhUp
         Sb7Csf8wdLCEP1ALFIwSX9sdwysg3T+6SQoX05Di2nL3QhaR76VlJ8Fg1bqFWTdxPYwn
         WXBdMoSR6BQoT+8ZfJA7/yCoXy0kT8YyivYS1I1LOG/esAw6Ro7UNlb9sdvqMgJbZxOf
         8hg7b3GhsUZMRZMn5EZTsu/GovVi7RzdQGcHwmNq39kkK0PnRSgwpLsVd2uwhAji//qb
         vBog==
X-Gm-Message-State: AOAM530qeX3qXhhH+tn3w/B84x1cPQPTHu3y6y7hQSMiWL3QDZhL4DGP
        mnQW0PElJmz9nZq8myQrPnyWsmL5Drj2sbE4voE=
X-Google-Smtp-Source: ABdhPJzQCk+1yJCld2HUCFH6sosD0GwyothmA9+gi654fArooXDpnj2M3QMY35WlAD3jMritZ/WLvXa/EVjFsxFLO4s=
X-Received: by 2002:a25:508:0:b0:633:bcf2:d29a with SMTP id
 8-20020a250508000000b00633bcf2d29amr14582547ybf.81.1647875560259; Mon, 21 Mar
 2022 08:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220312043624.40732-1-dacohen@pm.me> <CAJZ5v0gqpQTuNN0WpnEd4dAQmnR=BXSoH_w7kkAxOG7xkftW6Q@mail.gmail.com>
 <YjU3sfYLcEqK1Usd@jiban.lan> <CAJZ5v0j61EMFXpONqPBpQjzm3T3nFeHjfp2YdV3oXW8KnQJ2tw@mail.gmail.com>
 <YjiQ8EbhBQzDOHjV@jiban>
In-Reply-To: <YjiQ8EbhBQzDOHjV@jiban>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Mar 2022 16:12:24 +0100
Message-ID: <CAJZ5v0h2ppT4jXpnMWCqhBjwHHmkGQfXZ5BBid3VND+_tGv7wg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: fix dynamic debug within pm_pr_debug()
To:     David Cohen <dacohen@pm.me>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 3:51 PM David Cohen <dacohen@pm.me> wrote:
>
> On Mon, Mar 21, 2022 at 03:20:20PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Mar 19, 2022 at 2:54 AM David Cohen <dacohen@pm.me> wrote:
> > >
> > > On Thu, Mar 17, 2022 at 02:45:11PM +0100, Rafael J. Wysocki wrote:
> > > > On Sat, Mar 12, 2022 at 5:37 AM David Cohen <dacohen@pm.me> wrote:
> > > > >
> > > > > Currently, pm_pr_debug() and pm_deferred_pr_debug() use __pm_pr_debug()
> > > > > to filter pm debug messages based on pm_debug_messages_on flag.
> > > > > According to __pm_pr_debug() implementation, pm_deferred_pr_debug()
> > > > > indirectly calls printk_deferred() within __pm_pr_debug() which doesn't
> > > > > support dynamic debug, but pm_pr_debug() indirectly calls pr_debug()
> > > >
> > > > I'm not sure what you mean by pm_pr_debug().  There's no such thing in
> > > > the kernel tree.
> > > >
> > > > Assuming that it means pm_pr_dbg(), it doesn't call pr_debug():
> > >
> > > Yeah, I apologize for the typo. I meant pm_pr_dbg(). I can fix that if
> > > you're ok with the patch as per comments below.
> > >
> > > >
> > > > #define pm_pr_dbg(fmt, ...) __pm_pr_dbg(false, fmt, ##__VA_ARGS__)
> > > >
> > > > and
> > > >
> > > > void __pm_pr_dbg(bool defer, const char *fmt, ...)
> > > > {
> > > > ...
> > > >         if (defer)
> > > >                printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
> > > >         else
> > > >                printk(KERN_DEBUG "PM: %pV", &vaf);
> > > >
> > > > And as I said printk(KERN_DEBUG ...) is not equivalent to
> > > > pr_debug(...), because it is not dynamic printk().
> > >
> > > The problem is not about __pm_pr_dbg() calling printk(). The problem is
> > > the pm files that used to call pr_debug() were modified to call
> > > pm_pr_dbg() in order to be behing the pm_debug_messages_on flag, as per
> > > this commit:
> > > 8d8b2441db96 PM / sleep: Do not print debug messages by default
> >
> > So what's the problem with setting pm_debug_messages_on in addition to
> > enabling dynamic debug for a given file?
>
> Let me be a bit more detailed:
>
> Before "8d8b2441db96 PM / sleep: Do not print debug messages by default":
> - pr_debug() was used
> - The kernel pm files had dynamic debug support
> - All the instances using pr_debug() are visible on
>   /sys/kernel/debug/dynamic_debug/control
> - pm_debug_messages_on flag was not supported
>
> After "8d8b2441db96 PM / sleep: Do not print debug messages by default":
> - pr_debug() was replaced with pm_pr_dbg()

Just for some PM-related messages, not in general.

> - The kernel pm files where pm_pr_dbg() replaced pr_debug() *lost* dynamic
>   debug support and they are no longer visible on
>   /sys/kernel/debug/dynamic_debug/control

Again, some of them.

> - pm_debug_messages_on flag was introduced

So what exactly is the problem you are trying to address?

> What my patch is doing:
> - Reintroducing dynamic debug support to the same files who lost it
>   after the patch mentioned above

Why is this necessary?

> - The instances using pr_pm_dbg() (which originally came from pr_debug())
>   are reintroduced to /sys/kernel/debug/dynamic_debug/control
> - pm_debug_messages_on flag is unaltered

I think that you really want to turn off some PM messages by default
when pm_debug_messages_on is set.

OTOH I want to be able to see pr_pm_dbg() messages in the log when
pm_debug_messages_on is set without having to turn on dynamic debug
for every file in which pr_pm_dbg() is used.  Your patch breaks this.
