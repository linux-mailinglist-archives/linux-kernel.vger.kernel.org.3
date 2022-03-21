Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C74E2A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349604AbiCUO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349216AbiCUO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:26 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C91B11A01;
        Mon, 21 Mar 2022 07:20:36 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2e5e31c34bfso77775827b3.10;
        Mon, 21 Mar 2022 07:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5H7qegm7zHouDAmzqApTcENSnAkHtRaj15CsQ0Zxro0=;
        b=KA+ZaBdJpzKhoRIq+G+mvR6WiCdShXhPmHpTcx+NtZChcrffTAK/xHViqL2GI21Xbu
         bMbrK/+GYik5txaJE6s3fD9ra/rG70JNH9IUgv7+hZLRcd5BHjaKy+aBXQUi9jtdnF9N
         FXhxG/pIhl95h9oAUFMp4Dt0Bo9kGMJ3c9T0Tm8ReUgBniirbJoVurzrxGhz7dQfQSvc
         4Vuig5ArmKrdEmn8BqMhpRiyQHnYPbOL7rkF5exbIJg0Kv8lRbMf/zAXFrpHqn6sbmSC
         1OPI3AjyFRuxldzSZDC9T7hl9jm+zOMTEly8Tw/fmU98N7lyR+G2ho+jiUkGDsYj0cqQ
         A7eQ==
X-Gm-Message-State: AOAM5322eXvmVquXecIb/ZD1PSQ4JX1H5qw1LAaftCGP4pHmJEisy2fO
        uXJC8KttpBwWTRN/OP88vtsTWN/G56803Ye8Hcthp/6vLqg=
X-Google-Smtp-Source: ABdhPJwc25Stha1LMgXQd7Ju8xaSaIPrtfGJt4nJg2z9i3q3d0vdQVio83XMhRRK2JZyO/WbcNiiQOihrsDXWiiIVhQ=
X-Received: by 2002:a81:36cf:0:b0:2e5:2597:a026 with SMTP id
 d198-20020a8136cf000000b002e52597a026mr24085340ywa.301.1647872435430; Mon, 21
 Mar 2022 07:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220312043624.40732-1-dacohen@pm.me> <CAJZ5v0gqpQTuNN0WpnEd4dAQmnR=BXSoH_w7kkAxOG7xkftW6Q@mail.gmail.com>
 <YjU3sfYLcEqK1Usd@jiban.lan>
In-Reply-To: <YjU3sfYLcEqK1Usd@jiban.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Mar 2022 15:20:20 +0100
Message-ID: <CAJZ5v0j61EMFXpONqPBpQjzm3T3nFeHjfp2YdV3oXW8KnQJ2tw@mail.gmail.com>
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

On Sat, Mar 19, 2022 at 2:54 AM David Cohen <dacohen@pm.me> wrote:
>
> On Thu, Mar 17, 2022 at 02:45:11PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Mar 12, 2022 at 5:37 AM David Cohen <dacohen@pm.me> wrote:
> > >
> > > Currently, pm_pr_debug() and pm_deferred_pr_debug() use __pm_pr_debug()
> > > to filter pm debug messages based on pm_debug_messages_on flag.
> > > According to __pm_pr_debug() implementation, pm_deferred_pr_debug()
> > > indirectly calls printk_deferred() within __pm_pr_debug() which doesn't
> > > support dynamic debug, but pm_pr_debug() indirectly calls pr_debug()
> >
> > I'm not sure what you mean by pm_pr_debug().  There's no such thing in
> > the kernel tree.
> >
> > Assuming that it means pm_pr_dbg(), it doesn't call pr_debug():
>
> Yeah, I apologize for the typo. I meant pm_pr_dbg(). I can fix that if
> you're ok with the patch as per comments below.
>
> >
> > #define pm_pr_dbg(fmt, ...) __pm_pr_dbg(false, fmt, ##__VA_ARGS__)
> >
> > and
> >
> > void __pm_pr_dbg(bool defer, const char *fmt, ...)
> > {
> > ...
> >         if (defer)
> >                printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
> >         else
> >                printk(KERN_DEBUG "PM: %pV", &vaf);
> >
> > And as I said printk(KERN_DEBUG ...) is not equivalent to
> > pr_debug(...), because it is not dynamic printk().
>
> The problem is not about __pm_pr_dbg() calling printk(). The problem is
> the pm files that used to call pr_debug() were modified to call
> pm_pr_dbg() in order to be behing the pm_debug_messages_on flag, as per
> this commit:
> 8d8b2441db96 PM / sleep: Do not print debug messages by default

So what's the problem with setting pm_debug_messages_on in addition to
enabling dynamic debug for a given file?

> That's the moment dynamic debug was no longer available for kernel pm files.
>
> >
> > pm_pr_dbg() is not dynamic printk() on purpose, so they both can be
> > controlled independently.
>
> The current solution is all or nothing (using pm_debug_messages_on). The
> patch I'm sending is making dynamic debug available on the kernel pm
> files, while still allowing the pm_debug_messages_on flag to work
> independently.

If you need a combination of pm_debug_messages_on and the pr_debug()
type of dynamic debug, I would suggest adding a new macro, say
pm_pr_dbg_dyn() or similar, for this purpose and use it as needed
instead of attempting to modify the existing behavior everywhere.
