Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF41B566778
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiGEKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiGEKKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:10:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FAE13FA3;
        Tue,  5 Jul 2022 03:10:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FF1CB81749;
        Tue,  5 Jul 2022 10:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86019C341C7;
        Tue,  5 Jul 2022 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657015838;
        bh=y6Te2cFW+XsXb2b3QQuZDAoP5VdINB/0zwJY3tl+cus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaqCR/E/hdLtp+kmqNc7LL7seFp0BWKDAVEtdtpwgzhEEkFOSyikEJ6UFOWre++mZ
         UayLYAIJ1wcau0Blz8XaJVAnpionhb3aPjiw9Mt6DHCBDOFXPYTy84JaHEiYPifzLI
         CFCGnRD+JFKepYljUHGC0iSsAtvMjtj++8KTVVmg=
Date:   Tue, 5 Jul 2022 12:10:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsQOG3+ItWmrpaFt@kroah.com>
References: <YsPOEYU7ZqmpD8dw@kroah.com>
 <a1fcc07e-51ef-eaad-f14b-33f1263e45ac@I-love.SAKURA.ne.jp>
 <CACT4Y+bUw8LebceH0fDZriqAivuwNSNntTTS1647CQF-j2C4RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bUw8LebceH0fDZriqAivuwNSNntTTS1647CQF-j2C4RQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 09:20:24AM +0200, Dmitry Vyukov wrote:
> On Tue, 5 Jul 2022 at 07:54, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On Tue, Jul 05, 2022 at 02:21:17PM +0900, Tetsuo Handa wrote:
> > > On 2022/07/04 23:31, Greg KH wrote:
> > > > I don't understand what you are trying to "fix" here.  What is userspace
> > > > doing (as a normal user) that is causing a problem, and what problem is
> > > > it causing and for what device/hardware/driver is this a problem?
> > >
> > > Currently the root cause is unknown.
> > > This might be another example of deadlock hidden by device_initialize().
> > >
> > > We can see from https://syzkaller.appspot.com/text?tag=CrashReport&x=11feb7e0080000 that
> > > when khungtaskd reports that a process is blocked waiting for misc_mtx at misc_open(),
> > > there is a process which is holding system_transition_mutex from snapshot_open().
> >
> > /dev/snapshot is not read/writable by anyone but root for obvious
> > reasons.
> >
> > And perhaps it's something that syzbot shouldn't be fuzzing unless it
> > wants to take the system down easily :)
> 
> We could turn CONFIG_HIBERNATION_SNAPSHOT_DEV off for syzbot, but it
> will also mean this part of the kernel won't be tested at all.
> I see it has 14 ioclt's (below) and not all of them look problematic
> (like POWER_OFF).
> Perhaps the kernel could restrict access only to reboot/restore
> functionality? This way we could at least test everything related to
> snapshot creation.

This is already restricted to root, why would you want to restrict it
anymore?

> #define SNAPSHOT_FREEZE _IO(SNAPSHOT_IOC_MAGIC, 1)
> #define SNAPSHOT_UNFREEZE _IO(SNAPSHOT_IOC_MAGIC, 2)
> #define SNAPSHOT_ATOMIC_RESTORE _IO(SNAPSHOT_IOC_MAGIC, 4)
> #define SNAPSHOT_FREE _IO(SNAPSHOT_IOC_MAGIC, 5)
> #define SNAPSHOT_FREE_SWAP_PAGES _IO(SNAPSHOT_IOC_MAGIC, 9)
> #define SNAPSHOT_S2RAM _IO(SNAPSHOT_IOC_MAGIC, 11)
> #define SNAPSHOT_SET_SWAP_AREA _IOW(SNAPSHOT_IOC_MAGIC, 13, struct
> resume_swap_area)
> #define SNAPSHOT_GET_IMAGE_SIZE _IOR(SNAPSHOT_IOC_MAGIC, 14, __kernel_loff_t)
> #define SNAPSHOT_PLATFORM_SUPPORT _IO(SNAPSHOT_IOC_MAGIC, 15)
> #define SNAPSHOT_POWER_OFF _IO(SNAPSHOT_IOC_MAGIC, 16)
> #define SNAPSHOT_CREATE_IMAGE _IOW(SNAPSHOT_IOC_MAGIC, 17, int)
> #define SNAPSHOT_PREF_IMAGE_SIZE _IO(SNAPSHOT_IOC_MAGIC, 18)
> #define SNAPSHOT_AVAIL_SWAP_SIZE _IOR(SNAPSHOT_IOC_MAGIC, 19, __kernel_loff_t)
> #define SNAPSHOT_ALLOC_SWAP_PAGE _IOR(SNAPSHOT_IOC_MAGIC, 20, __kernel_loff_t)

Fuzzing this is always nice, but be very aware of the system state
changes that you are creating.  Also know when you make these state
changes, the rest of the system's functionality also changes.

thanks,

greg k-h
