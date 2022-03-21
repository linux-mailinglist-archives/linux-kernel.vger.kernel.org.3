Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3E74E2B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiCUOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349838AbiCUOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:53:12 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8244C42A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:51:46 -0700 (PDT)
Date:   Mon, 21 Mar 2022 14:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1647874301;
        bh=4AMGpvyEAhT/UTvfbGh3uP++8M9RSSyLpSP97ed6Q34=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=idI/a3F/4O++98+kp/E8xzgEXG4i+BYjqjnbMTphalAEKbOHbnNX8z8h8V9PG1Vmk
         meUSrIZkMsUyVsY0v1tD8IYorPG51vshwugLF0zscmKyq71rRgp0mKrqGcFl6CaIjf
         JtzqrCvmkS3dXssyURusAU6wWG9ej/ma1LcpEg9PhZyQLt2FHtA98UZ14TXSYgowWa
         UiYno94wBqc90ityarI+M7NpuMtEW1SNup7O3ozd8JSISFx2TXRY/mVakxa1LlHsc5
         VPPI7zhu2rsJrbJXhO5H/HH6KKGc3IzTdaRYcsViKpqic6RNcxSeioJzJarjZeaEyl
         O95kNW8j5nd2A==
To:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   David Cohen <dacohen@pm.me>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: David Cohen <dacohen@pm.me>
Subject: Re: [PATCH v2] PM: fix dynamic debug within pm_pr_debug()
Message-ID: <YjiQ8EbhBQzDOHjV@jiban>
In-Reply-To: <CAJZ5v0j61EMFXpONqPBpQjzm3T3nFeHjfp2YdV3oXW8KnQJ2tw@mail.gmail.com>
References: <20220312043624.40732-1-dacohen@pm.me> <CAJZ5v0gqpQTuNN0WpnEd4dAQmnR=BXSoH_w7kkAxOG7xkftW6Q@mail.gmail.com> <YjU3sfYLcEqK1Usd@jiban.lan> <CAJZ5v0j61EMFXpONqPBpQjzm3T3nFeHjfp2YdV3oXW8KnQJ2tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:20:20PM +0100, Rafael J. Wysocki wrote:
> On Sat, Mar 19, 2022 at 2:54 AM David Cohen <dacohen@pm.me> wrote:
> >
> > On Thu, Mar 17, 2022 at 02:45:11PM +0100, Rafael J. Wysocki wrote:
> > > On Sat, Mar 12, 2022 at 5:37 AM David Cohen <dacohen@pm.me> wrote:
> > > >
> > > > Currently, pm_pr_debug() and pm_deferred_pr_debug() use __pm_pr_deb=
ug()
> > > > to filter pm debug messages based on pm_debug_messages_on flag.
> > > > According to __pm_pr_debug() implementation, pm_deferred_pr_debug()
> > > > indirectly calls printk_deferred() within __pm_pr_debug() which doe=
sn't
> > > > support dynamic debug, but pm_pr_debug() indirectly calls pr_debug(=
)
> > >
> > > I'm not sure what you mean by pm_pr_debug().  There's no such thing i=
n
> > > the kernel tree.
> > >
> > > Assuming that it means pm_pr_dbg(), it doesn't call pr_debug():
> >
> > Yeah, I apologize for the typo. I meant pm_pr_dbg(). I can fix that if
> > you're ok with the patch as per comments below.
> >
> > >
> > > #define pm_pr_dbg(fmt, ...) __pm_pr_dbg(false, fmt, ##__VA_ARGS__)
> > >
> > > and
> > >
> > > void __pm_pr_dbg(bool defer, const char *fmt, ...)
> > > {
> > > ...
> > >         if (defer)
> > >                printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
> > >         else
> > >                printk(KERN_DEBUG "PM: %pV", &vaf);
> > >
> > > And as I said printk(KERN_DEBUG ...) is not equivalent to
> > > pr_debug(...), because it is not dynamic printk().
> >
> > The problem is not about __pm_pr_dbg() calling printk(). The problem is
> > the pm files that used to call pr_debug() were modified to call
> > pm_pr_dbg() in order to be behing the pm_debug_messages_on flag, as per
> > this commit:
> > 8d8b2441db96 PM / sleep: Do not print debug messages by default
>
> So what's the problem with setting pm_debug_messages_on in addition to
> enabling dynamic debug for a given file?

Let me be a bit more detailed:

Before "8d8b2441db96 PM / sleep: Do not print debug messages by default":
- pr_debug() was used
- The kernel pm files had dynamic debug support
- All the instances using pr_debug() are visible on
  /sys/kernel/debug/dynamic_debug/control
- pm_debug_messages_on flag was not supported

After "8d8b2441db96 PM / sleep: Do not print debug messages by default":
- pr_debug() was replaced with pm_pr_dbg()
- The kernel pm files where pm_pr_dbg() replaced pr_debug() *lost* dynamic
  debug support and they are no longer visible on
  /sys/kernel/debug/dynamic_debug/control
- pm_debug_messages_on flag was introduced

What my patch is doing:
- Reintroducing dynamic debug support to the same files who lost it
  after the patch mentioned above
- The instances using pr_pm_dbg() (which originally came from pr_debug())
  are reintroduced to /sys/kernel/debug/dynamic_debug/control
- pm_debug_messages_on flag is unaltered

Regards, David

