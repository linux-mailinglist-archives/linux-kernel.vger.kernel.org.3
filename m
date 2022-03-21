Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631254E2ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351698AbiCURKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349549AbiCURKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:10:50 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0DD12AA6;
        Mon, 21 Mar 2022 10:09:24 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2e5e31c34bfso83921137b3.10;
        Mon, 21 Mar 2022 10:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBQoTQvqn5xOqDlxxU4vpllFKwBu83a7Z6W8Hi/OBDM=;
        b=5ouBvyLbCjgkuHPsCCJYf9BXQ4C/rEdVfLBOqReGcF3mJepNBieoxcAQetIGHRS7ev
         UYLHIe9O2OKd18XHjZ+ogIpvtKrSH3BluXV+mnTff62ypycgkTpseNO7CNSP8Zb0HyhA
         hxZH95zf/AXZgy3eIMBuEYXj/tjrk5kTcGSXoPj6tHbJWVHqqHrTXLz8tBOEZuedJ1Q8
         xIW9gv+kqgNj2anGF52rkBBcuVeEaS3P/9paz7ZdnGWPvn1/OyoXoxrDjOHWEUQP+4lj
         QYmv4dVkypMYteK3PZqtTKxtbRI1HStlpWBiXN66XkiqxiKrCpZAQBTxkHrn3Rdi79Qv
         Cclw==
X-Gm-Message-State: AOAM530GTP3ROPV9r0WJyMdjGBoYKKYE6LhDIRk8Gwaz5mmLno6U7FXM
        ptSqZXMCjewWYXmTpgs678jMtaStb3dgo0lICHE=
X-Google-Smtp-Source: ABdhPJyZvI4TLJ/e19RIjSlhFtOcd4k382oImd8SwwdZNmJ5dJJd1/jiwYGLcuUqC0HlLUZqdSFUnVMy4Q+TaZ4e2vY=
X-Received: by 2002:a81:5cf:0:b0:2e5:7477:168e with SMTP id
 198-20020a8105cf000000b002e57477168emr24781963ywf.149.1647882563352; Mon, 21
 Mar 2022 10:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220312043624.40732-1-dacohen@pm.me> <CAJZ5v0gqpQTuNN0WpnEd4dAQmnR=BXSoH_w7kkAxOG7xkftW6Q@mail.gmail.com>
 <YjU3sfYLcEqK1Usd@jiban.lan> <CAJZ5v0j61EMFXpONqPBpQjzm3T3nFeHjfp2YdV3oXW8KnQJ2tw@mail.gmail.com>
 <YjiQ8EbhBQzDOHjV@jiban> <CAJZ5v0h2ppT4jXpnMWCqhBjwHHmkGQfXZ5BBid3VND+_tGv7wg@mail.gmail.com>
 <YjigXzUovGDhx06p@jiban>
In-Reply-To: <YjigXzUovGDhx06p@jiban>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Mar 2022 18:09:12 +0100
Message-ID: <CAJZ5v0j3Yk3mMkyxub7Jm4S4G9cxMej7sMngoLSUM5ZbjAqPTw@mail.gmail.com>
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

On Mon, Mar 21, 2022 at 4:57 PM David Cohen <dacohen@pm.me> wrote:
>
> On Mon, Mar 21, 2022 at 04:12:24PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Mar 21, 2022 at 3:51 PM David Cohen <dacohen@pm.me> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 03:20:20PM +0100, Rafael J. Wysocki wrote:
> > > > On Sat, Mar 19, 2022 at 2:54 AM David Cohen <dacohen@pm.me> wrote:
> > > > >
> > > > > On Thu, Mar 17, 2022 at 02:45:11PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Sat, Mar 12, 2022 at 5:37 AM David Cohen <dacohen@pm.me> wrote:
> > > > > > >
> > > > > > > Currently, pm_pr_debug() and pm_deferred_pr_debug() use __pm_pr_debug()
> > > > > > > to filter pm debug messages based on pm_debug_messages_on flag.
> > > > > > > According to __pm_pr_debug() implementation, pm_deferred_pr_debug()
> > > > > > > indirectly calls printk_deferred() within __pm_pr_debug() which doesn't
> > > > > > > support dynamic debug, but pm_pr_debug() indirectly calls pr_debug()
> > > > > >
> > > > > > I'm not sure what you mean by pm_pr_debug().  There's no such thing in
> > > > > > the kernel tree.
> > > > > >
> > > > > > Assuming that it means pm_pr_dbg(), it doesn't call pr_debug():
> > > > >
> > > > > Yeah, I apologize for the typo. I meant pm_pr_dbg(). I can fix that if
> > > > > you're ok with the patch as per comments below.
> > > > >
> > > > > >
> > > > > > #define pm_pr_dbg(fmt, ...) __pm_pr_dbg(false, fmt, ##__VA_ARGS__)
> > > > > >
> > > > > > and
> > > > > >
> > > > > > void __pm_pr_dbg(bool defer, const char *fmt, ...)
> > > > > > {
> > > > > > ...
> > > > > >         if (defer)
> > > > > >                printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
> > > > > >         else
> > > > > >                printk(KERN_DEBUG "PM: %pV", &vaf);
> > > > > >
> > > > > > And as I said printk(KERN_DEBUG ...) is not equivalent to
> > > > > > pr_debug(...), because it is not dynamic printk().
> > > > >
> > > > > The problem is not about __pm_pr_dbg() calling printk(). The problem is
> > > > > the pm files that used to call pr_debug() were modified to call
> > > > > pm_pr_dbg() in order to be behing the pm_debug_messages_on flag, as per
> > > > > this commit:
> > > > > 8d8b2441db96 PM / sleep: Do not print debug messages by default
> > > >
> > > > So what's the problem with setting pm_debug_messages_on in addition to
> > > > enabling dynamic debug for a given file?
> > >
> > > Let me be a bit more detailed:
> > >
> > > Before "8d8b2441db96 PM / sleep: Do not print debug messages by default":
> > > - pr_debug() was used
> > > - The kernel pm files had dynamic debug support
> > > - All the instances using pr_debug() are visible on
> > >   /sys/kernel/debug/dynamic_debug/control
> > > - pm_debug_messages_on flag was not supported
> > >
> > > After "8d8b2441db96 PM / sleep: Do not print debug messages by default":
> > > - pr_debug() was replaced with pm_pr_dbg()
> >
> > Just for some PM-related messages, not in general.
>
> Yes, I'm only addressing the kernel PM cases.
>
> >
> > > - The kernel pm files where pm_pr_dbg() replaced pr_debug() *lost* dynamic
> > >   debug support and they are no longer visible on
> > >   /sys/kernel/debug/dynamic_debug/control
> >
> > Again, some of them.
> >
> > > - pm_debug_messages_on flag was introduced
> >
> > So what exactly is the problem you are trying to address?
> >
> > > What my patch is doing:
> > > - Reintroducing dynamic debug support to the same files who lost it
> > >   after the patch mentioned above
> >
> > Why is this necessary?
>
> I'm trying to have more granularity when enabling the debug messages.
> See below for more context.
>
> >
> > > - The instances using pr_pm_dbg() (which originally came from pr_debug())
> > >   are reintroduced to /sys/kernel/debug/dynamic_debug/control
> > > - pm_debug_messages_on flag is unaltered
> >
> > I think that you really want to turn off some PM messages by default
> > when pm_debug_messages_on is set.
> >
> > OTOH I want to be able to see pr_pm_dbg() messages in the log when
> > pm_debug_messages_on is set without having to turn on dynamic debug
> > for every file in which pr_pm_dbg() is used.  Your patch breaks this.
>
> When debugging an issue with s2idle on my laptop where it enters an
> infinite loop instead of suspending, the excess of PM messages were
> changing the behavior and making it more a lot difficult to reproduce
> the issue (and a less severe side effect, printing many debug info I
> didn't need).

I see.

> But as you pointed out, my patch is indeed changing the behavior for
> when the pm_debug_messages_on is enabled. Would you be open for this
> behavior instead:
>  - If dynamic debug support is disabled, pm_pr_dbg() is printed if
>    pm_debug_messages_on == 1
>  - If dynamic debug support is enabled, pm_pr_dbg() is printed if
>    pm_debug_messages_on == 1 or if pm_pr_dbg() was explicitly enabled on
>    /sys/kernel/debug/dynamic_debug/control

Yes, that would work.
