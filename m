Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5854FC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382587AbiFQRjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiFQRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:39:30 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0EC4E3EF3B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:39:28 -0700 (PDT)
Received: (qmail 772991 invoked by uid 1000); 17 Jun 2022 13:39:28 -0400
Date:   Fri, 17 Jun 2022 13:39:28 -0400
From:   'Alan Stern' <stern@rowland.harvard.edu>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:USB HID/HIDBP DRIVERS \[USB KEYBOARDS, MICE, REM..." 
        <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@amd.com>
Subject: Re: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Message-ID: <Yqy8UJ1U06jMUJiA@rowland.harvard.edu>
References: <20220616183142.14472-1-mario.limonciello@amd.com>
 <YqugZQiDu35Y8lTu@kroah.com>
 <YqyYIt2MLmoCRSA9@rowland.harvard.edu>
 <419f8edc2a7744ecbfaa0728227db180@AcuMS.aculab.com>
 <ed0379a0-1360-4271-16bd-cde2e4b3372b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0379a0-1360-4271-16bd-cde2e4b3372b@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:06:05AM -0500, Limonciello, Mario wrote:
> On 6/17/2022 10:39, David Laight wrote:
> > From: Alan Stern
> > > Sent: 17 June 2022 16:05
> > ...
> > > Another issue is whether wakeup for a mouse means pressing a button or
> > > just moving the mouse.  For a mouse that uses LEDs to sense motion,
> > > moving it won't generate a wakeup request -- USB suspend does not allow
> > > the mouse to use enough current to keep the LEDs illuminated.  On the
> > > other hand, there's no reason why wakeup by pressing a button shouldn't
> > > always work.
> > 
> 
> At least one of the Logitech wireless mice I have here works to wake either
> by clicking the buttons or moving the mouse, presumably because the mouse is
> battery powered.  One of my wired ones works only by clicking (which is as
> you describe).
> 
> I don't believe there is going to be a way to have granularity of which type
> of event will wake the system; it will be hardware dependent.

Precisely.  So if the point of the patch is to match users' 
expectations, and some users expect to be able to wake up their systems 
by moving the mouse but their mouse is like yours, then the situation is 
hopeless and the patch won't help.

> > I'm not even sure I want a system to wake up because it's mouse
> > gets knocked.
> > I guess a mouse could include accelerometers so that you can shake it!
> > 
> 
> I'm completely opposite.  As soon as I sit down at my desk which has a a
> closed docked laptop, the first thing I do is use the mouse which will wake
> the system.
> 
> And if you take a step further and consider desktops if you *don't* do this
> you'll have to find your power button or use the keyboard.

The usual counterexample is laptop-in-a-knapsack.  You don't want the 
laptop to wake up just because the knapsack was picked up and that 
jostled the mouse.

Overall, it seems like this patch needs a better justification.

Alan Stern

> > I've an idea that one of my systems manages to boot if the mouse
> > is knocked (and it was last shutdown from windows).
> > At least, that it why I think it is sometimes booting up.
> > 
> 
> It was probably hibernated from Windows rather than shutdown.  Windows tends
> to make this "invisible" to the user.  Some systems can wake from S4 on
> certain devices, and I would expect some registers on your system have been
> programmed to work that way.
