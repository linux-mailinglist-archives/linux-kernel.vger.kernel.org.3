Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592124D7072
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiCLSos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiCLSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:44:44 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95575C0B;
        Sat, 12 Mar 2022 10:43:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7AD3A8C4;
        Sat, 12 Mar 2022 19:43:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647110615;
        bh=C8/4uNqE9SOK8e3iKf9Yp+FDIyoC3+n8dlsKXnWNR7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBaxek1GWMxa3WFPIj/VTxbAFToVKcnICSsq495bmSe5gBllVgnqe/EvM/UiYPr9J
         JAkfWfJIdPqfiFLTy/kU32FfEX4F77swV78JvGmgVfixLvp9sITEd/LfuvfzGdZxia
         VAQVqX9s0zmK0nuZrjuo38zfSeScftEkfUkKQ3no=
Date:   Sat, 12 Mar 2022 20:43:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-uvc-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/5] media: uvcvideo: Fix race conditions
Message-ID: <YizpxhxPBxJ0EHQR@pendragon.ideasonboard.com>
References: <20200917022547.198090-1-linux@roeck-us.net>
 <20220311202426.GE23776@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311202426.GE23776@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Mar 11, 2022 at 09:24:26PM +0100, Michael Grzeschik wrote:
> Ping!
> 
> This series seems to be hanging around. It would be nice to get these
> patches upstream, as they help my uvc-gadget workflow. Without them it
> is likely that in the development cases my gadget won't start and then
> leave the whole xhci controller broken.
> 
> @Laurent, what do you think?

I think I've explained before how this should be fixed at the V4L2
level. The problem actually affects character devices globally, and Greg
KH said he would have a go at fixing it there, but I don't think much
happened. Starting with a V4L2-level fix is fine with me.

There are a few patches in the series that are specific to uvcvideo,
I'll have another look and merge those.

> On Wed, Sep 16, 2020 at 07:25:42PM -0700, Guenter Roeck wrote:
> > Something seems to have gone wrong with v3 of this patch series.
> > I am sure I sent it out, but I don't find it anywhere.
> > Resending. Sorry for any duplicates.
> > 
> > The uvcvideo code has no lock protection against USB disconnects
> > while video operations are ongoing. This has resulted in random
> > error reports, typically pointing to a crash in usb_ifnum_to_if(),
> > called from usb_hcd_alloc_bandwidth(). A typical traceback is as
> > follows.
> > 
> > usb 1-4: USB disconnect, device number 3
> > BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d29ca36db06 #1
> > Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/2019
> > RIP: 0010:usb_ifnum_to_if+0x29/0x40
> > Code: <...>
> > RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
> > RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
> > RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
> > R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
> > R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
> > FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000000000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
> > Call Trace:
> >  usb_hcd_alloc_bandwidth+0x1ee/0x30f
> >  usb_set_interface+0x1a3/0x2b7
> >  uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
> >  uvc_video_start_streaming+0x91/0xdd [uvcvideo]
> >  uvc_start_streaming+0x28/0x5d [uvcvideo]
> >  vb2_start_streaming+0x61/0x143 [videobuf2_common]
> >  vb2_core_streamon+0xf7/0x10f [videobuf2_common]
> >  uvc_queue_streamon+0x2e/0x41 [uvcvideo]
> >  uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
> >  __video_do_ioctl+0x33d/0x42a
> >  video_usercopy+0x34e/0x5ff
> >  ? video_ioctl2+0x16/0x16
> >  v4l2_ioctl+0x46/0x53
> >  do_vfs_ioctl+0x50a/0x76f
> >  ksys_ioctl+0x58/0x83
> >  __x64_sys_ioctl+0x1a/0x1e
> >  do_syscall_64+0x54/0xde
> > 
> > While there are not many references to this problem on mailing lists, it is
> > reported on a regular basis on various Chromebooks (roughly 300 reports
> > per month). The problem is relatively easy to reproduce by adding msleep()
> > calls into the code.
> > 
> > I tried to reproduce the problem with non-uvcvideo webcams, but was
> > unsuccessful. I was unable to get Philips (pwc) webcams to work. gspca
> > based webcams don't experience the problem, or at least I was unable to
> > reproduce it (The gspa driver does not trigger sending USB messages in the
> > open function, and otherwise uses the locking mechanism provided by the
> > v4l2/vb2 core).
> > 
> > I don't presume to claim that I found every issue, but this patch series
> > should fix at least the major problems.
> > 
> > The patch series was tested exensively on a Chromebook running chromeos-4.19
> > and on a Linux system running a v5.8.y based kernel.
> > 
> > v3:
> > - In patch 5/5, add missing calls to usb_autopm_put_interface() and kfree()
> >   to failure code path
> > 
> > v2:
> > - Added details about problem frequency and testing with non-uvc webcams
> >   to summary
> > - In patch 4/5, return EPOLLERR instead of -ENODEV on poll errors
> > - Fix description in patch 5/5
> > 
> > ----------------------------------------------------------------
> > Guenter Roeck (5):
> >       media: uvcvideo: Cancel async worker earlier
> >       media: uvcvideo: Lock video streams and queues while unregistering
> >       media: uvcvideo: Release stream queue when unregistering video device
> >       media: uvcvideo: Protect uvc queue file operations against disconnect
> >       media: uvcvideo: Abort uvc_v4l2_open if video device is unregistered
> > 
> >  drivers/media/usb/uvc/uvc_ctrl.c   | 11 ++++++----
> >  drivers/media/usb/uvc/uvc_driver.c | 12 ++++++++++
> >  drivers/media/usb/uvc/uvc_queue.c  | 32 +++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c   | 45 ++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvcvideo.h   |  1 +
> >  5 files changed, 93 insertions(+), 8 deletions(-)

-- 
Regards,

Laurent Pinchart
