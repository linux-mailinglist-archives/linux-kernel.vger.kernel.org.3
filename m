Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F3567EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGFGew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGFGet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7FAE7F;
        Tue,  5 Jul 2022 23:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939F561D7E;
        Wed,  6 Jul 2022 06:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F955C3411C;
        Wed,  6 Jul 2022 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657089288;
        bh=soWSvNA9Dp3GJYUfQD8ILvkJm+sr1NemDRSI9xBjKqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pO9gpcJUAo7tqcRnirjoQgTgE6jaTjMaRym+qgFDPmZALGvGIvRzPOarSXX7OeYO7
         gU9x1jd0tNGsZdFWjkAoLHLIo+/s9r0Wiz6Vx+e0iR7a3KhaPIDw0F0flNXGAdn8Wj
         A+S7nFsvhHIxDTdDkPU78hPAJ1KkqRL9OuOYURFo=
Date:   Wed, 6 Jul 2022 08:34:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsUtBERm94k/iZTy@kroah.com>
References: <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
 <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
 <YsRHwy6+5gask+KT@kroah.com>
 <064bbe2a-c18e-203e-9e01-b32fe9baa390@I-love.SAKURA.ne.jp>
 <7ddb25ff-60e5-75be-8080-2a7465cca68c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ddb25ff-60e5-75be-8080-2a7465cca68c@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:21:15PM +0900, Tetsuo Handa wrote:
> On 2022/07/05 23:35, Tetsuo Handa wrote:
> > On 2022/07/05 23:16, Greg KH wrote:
> >> Some device is being probed at the moment, maybe we have a deadlock
> >> somewhere here...
> > 
> > Lockdep says __device_attach() from hub_event() was in progress.
> > 
> > ----------------------------------------
> > [  237.376478][   T28] 5 locks held by kworker/1:1/26:
> > [  237.381526][   T28]  #0: ffff888016b92538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610
> > [  237.392798][   T28]  #1: ffffc90000c2fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610
> > [  237.406354][   T28]  #2: ffff88801f7ee220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4680
> > [  237.415920][   T28]  #3: ffff88801b6c6220 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0
> > [  237.426682][   T28]  #4: ffff8880216bc1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x4a0
> > ----------------------------------------
> > 
> 
> The number returned by atomic_read(&probe_count) matched the number of works for hub_event()
> in usb_hub_wq workqueue. The probe function is called from hub_event(), and
> usb_stor_msg_common() calls wait_for_completion_interruptible_timeout(MAX_SCHEDULE_TIMEOUT)
> via driver's init function.
> 
> But if the usb device is unresponsive, wait_for_completion_interruptible_timeout() sleeps
> forever. And in this testcase (which emulates usb devices using /dev/raw-gadget interface),
> the usb device became unresponsive because the process who is responsible with reading/writing
> /dev/raw-gadget interface is blocked at mutex_lock(&misc_mtx) at misc_open(), and results in
> an AB-BA deadlock condition. Making misc_open() killable solved this problem, by allowing
> the opener of /dev/raw-gadget interface to call fput() upon "send SIGKILL after 5 seconds from
> fork()" behavior.
> 
> Anyway,
> 
>         /*
>          * Resuming.  We may need to wait for the image device to
>          * appear.
>          */
>         wait_for_device_probe();
> 
> in snapshot_open() will sleep forever if some device became unresponsive.
> 
> How should we fix this problem?

We can decrease the timeout in usb_stor_msg_common().  I imagine that if
that timeout is ever hit in this sequence, then all will recover, right?
Try decreasing it to a sane number and see what happens.

thanks,

greg k-h
