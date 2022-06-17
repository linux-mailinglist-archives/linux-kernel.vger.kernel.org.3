Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D732554F9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382684AbiFQPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382201AbiFQPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:05:10 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8C333205C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:05:08 -0700 (PDT)
Received: (qmail 768756 invoked by uid 1000); 17 Jun 2022 11:05:06 -0400
Date:   Fri, 17 Jun 2022 11:05:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:USB HID/HIDBP DRIVERS \[USB KEYBOARDS, MICE, REM..." 
        <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@amd.com>
Subject: Re: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Message-ID: <YqyYIt2MLmoCRSA9@rowland.harvard.edu>
References: <20220616183142.14472-1-mario.limonciello@amd.com>
 <YqugZQiDu35Y8lTu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqugZQiDu35Y8lTu@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:28:05PM +0200, Greg KH wrote:
> On Thu, Jun 16, 2022 at 01:31:42PM -0500, Mario Limonciello wrote:
> > The USB HID transport layer doesn't set mice for wakeup by default so users
> > can not wake system from s2idle using wired USB mouse. However, users can
> > wake the same system from Modern Standby on Windows with the same wired
> > USB mouse.
> > 
> > Microsoft documentation indicates that all USB mice and touchpads should
> > be waking the system from Modern Standby. To align expectations from users
> > make this behavior the same when the system is configured by the OEM and
> > the user to use s2idle in Linux.
> > 
> > Link: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#input-devices-1
> > Link: https://lore.kernel.org/linux-usb/20220404214557.3329796-1-richard.gong@amd.com/
> > Suggested-by: Richard Gong <richard.gong@amd.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > More people keep coming to us confused that they couldn't wake a Linux system
> > up from sleep using a mouse, so this patch is being revived.
> 
> How many different devices did you test this on?

Another issue is whether wakeup for a mouse means pressing a button or 
just moving the mouse.  For a mouse that uses LEDs to sense motion, 
moving it won't generate a wakeup request -- USB suspend does not allow 
the mouse to use enough current to keep the LEDs illuminated.  On the 
other hand, there's no reason why wakeup by pressing a button shouldn't 
always work.

Also, the patch description doesn't seem to appreciate the difference 
between the default value for the wakeup setting and actually supporting 
wakeup.  As long as the hardware supports it, the default wakeup setting 
doesn't matter all that much, because the user can change the setting 
during system startup or whenever he wants.  But if the hardware doesn't 
support wakeup then the default setting makes no difference at all.

Alan Stern
