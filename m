Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CA559D970
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 12:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350594AbiHWJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350539AbiHWJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:33:34 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D079EDC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:38:54 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3378303138bso320365847b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=cgc+e/QzNdyD2sfucJY+c/VRbtSyirfoyG9awCiqMa4=;
        b=kUrFjIHECTaBr9+CKEUTz4OLFtxjYaXXGh+DIth9fw223PK1yidFfqVYBKotKgREon
         rn0SdwopAWDltNNwEtcw8x2F4jYDo+6O72ACtJg7eBBRL/AtQFzIr6nPHvoVFHuF6wWG
         46gE7n2khQGERr18D6bX/yfDzzeEfTcEyt3a4PX0Lpn8i8eI2QGzBb1k1k5n+VLPfqmT
         gSrfA521jCdxvgWL9H8ZopNm35pxb0KtwT0tRmg2ex7JMIFXZiYCZUrsbBv3K3M4IqNV
         wgimq51IM18LsFVOViGgvdqQzAZsqDCvnWjnghr+KMQxIUS2HTY1R+lgifuQMzMiyfA2
         UU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=cgc+e/QzNdyD2sfucJY+c/VRbtSyirfoyG9awCiqMa4=;
        b=LnVmYt3qhp49kJkBBH7L0jGnLPgHe/lKkk+DrYS6lAw4jKoSQhmM7wazZs6pK3Foq1
         0rlp8Z4HfSl5YX8FkvvMj9iaUDhEAEUf7KQHQ0aVjo9hNJwDfhNB6VIdA1JJgFLYTuSJ
         h4Dc8lt9m9TNLDra2DnLvtJjuLTr1z2qrSXE8ZDHLde91IbDkqZOxMTgr64fznEoyD8I
         MgUxMUdj+trg1JqJPNj64r+CVhDNfewGVvoY8W7OuPAGeD3hU2j5ynTslata1nIJa5ba
         N/OZvIFipt0ipXxVqg9ZidlWfEFHEb2LV7O2gLhMvpmQCavwgeL2e/2trlPGRYOk4A1d
         0HRA==
X-Gm-Message-State: ACgBeo1b9/Y7HoT70McsRk44Nvl0AasoOTo16ukYtsJLqCY3qS+R5/+e
        XjyQ0XE86ka1siH1ZxmNc/3y/4Yco+X6Hv/37KKMQg==
X-Google-Smtp-Source: AA6agR5Cgtu718MiKMVY1/XiyInsuBVJHNdFRsvSqTrNoHkmhAshU/tLTB8cZgDu+q0Z/EZnw0wrJC4b3x0GnuHi6qs=
X-Received: by 2002:a05:6902:387:b0:694:159f:ad3c with SMTP id
 f7-20020a056902038700b00694159fad3cmr20730903ybs.223.1661243870140; Tue, 23
 Aug 2022 01:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200917022547.198090-1-linux@roeck-us.net> <20220311202426.GE23776@pengutronix.de>
 <YizpxhxPBxJ0EHQR@pendragon.ideasonboard.com>
In-Reply-To: <YizpxhxPBxJ0EHQR@pendragon.ideasonboard.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Tue, 23 Aug 2022 10:37:39 +0200
Message-ID: <CAFJ_xbr+b26DdNomysXKJZ57SaRAJi3nSJd8VK90y=hicEWZ=A@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/5] media: uvcvideo: Fix race conditions
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Michael Grzeschik <mgr@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-uvc-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 12 mar 2022 o 19:43 Laurent Pinchart
<laurent.pinchart@ideasonboard.com> napisa=C5=82(a):
>
> Hi Michael,
>
> On Fri, Mar 11, 2022 at 09:24:26PM +0100, Michael Grzeschik wrote:
> > Ping!
> >
> > This series seems to be hanging around. It would be nice to get these
> > patches upstream, as they help my uvc-gadget workflow. Without them it
> > is likely that in the development cases my gadget won't start and then
> > leave the whole xhci controller broken.
> >
> > @Laurent, what do you think?
>
> I think I've explained before how this should be fixed at the V4L2
> level. The problem actually affects character devices globally, and Greg
> KH said he would have a go at fixing it there, but I don't think much
> happened. Starting with a V4L2-level fix is fine with me.
>
> There are a few patches in the series that are specific to uvcvideo,
> I'll have another look and merge those.
>
> > On Wed, Sep 16, 2020 at 07:25:42PM -0700, Guenter Roeck wrote:
> > > Something seems to have gone wrong with v3 of this patch series.
> > > I am sure I sent it out, but I don't find it anywhere.
> > > Resending. Sorry for any duplicates.
> > >
> > > The uvcvideo code has no lock protection against USB disconnects
> > > while video operations are ongoing. This has resulted in random
> > > error reports, typically pointing to a crash in usb_ifnum_to_if(),
> > > called from usb_hcd_alloc_bandwidth(). A typical traceback is as
> > > follows.
> > >
> > > usb 1-4: USB disconnect, device number 3
> > > BUG: unable to handle kernel NULL pointer dereference at 000000000000=
0000
> > > PGD 0 P4D 0
> > > Oops: 0000 [#1] PREEMPT SMP PTI
> > > CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d=
29ca36db06 #1
> > > Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/201=
9
> > > RIP: 0010:usb_ifnum_to_if+0x29/0x40
> > > Code: <...>
> > > RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
> > > RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
> > > RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
> > > R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
> > > R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
> > > FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000=
000000
> > > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
> > > Call Trace:
> > >  usb_hcd_alloc_bandwidth+0x1ee/0x30f
> > >  usb_set_interface+0x1a3/0x2b7
> > >  uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
> > >  uvc_video_start_streaming+0x91/0xdd [uvcvideo]
> > >  uvc_start_streaming+0x28/0x5d [uvcvideo]
> > >  vb2_start_streaming+0x61/0x143 [videobuf2_common]
> > >  vb2_core_streamon+0xf7/0x10f [videobuf2_common]
> > >  uvc_queue_streamon+0x2e/0x41 [uvcvideo]
> > >  uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
> > >  __video_do_ioctl+0x33d/0x42a
> > >  video_usercopy+0x34e/0x5ff
> > >  ? video_ioctl2+0x16/0x16
> > >  v4l2_ioctl+0x46/0x53
> > >  do_vfs_ioctl+0x50a/0x76f
> > >  ksys_ioctl+0x58/0x83
> > >  __x64_sys_ioctl+0x1a/0x1e
> > >  do_syscall_64+0x54/0xde
> > >
> > > While there are not many references to this problem on mailing lists,=
 it is
> > > reported on a regular basis on various Chromebooks (roughly 300 repor=
ts
> > > per month). The problem is relatively easy to reproduce by adding msl=
eep()
> > > calls into the code.
> > >
> > > I tried to reproduce the problem with non-uvcvideo webcams, but was
> > > unsuccessful. I was unable to get Philips (pwc) webcams to work. gspc=
a
> > > based webcams don't experience the problem, or at least I was unable =
to
> > > reproduce it (The gspa driver does not trigger sending USB messages i=
n the
> > > open function, and otherwise uses the locking mechanism provided by t=
he
> > > v4l2/vb2 core).
> > >
> > > I don't presume to claim that I found every issue, but this patch ser=
ies
> > > should fix at least the major problems.
> > >
> > > The patch series was tested exensively on a Chromebook running chrome=
os-4.19
> > > and on a Linux system running a v5.8.y based kernel.
> > >
> > > v3:
> > > - In patch 5/5, add missing calls to usb_autopm_put_interface() and k=
free()
> > >   to failure code path
> > >
> > > v2:
> > > - Added details about problem frequency and testing with non-uvc webc=
ams
> > >   to summary
> > > - In patch 4/5, return EPOLLERR instead of -ENODEV on poll errors
> > > - Fix description in patch 5/5
> > >
> > > ----------------------------------------------------------------
> > > Guenter Roeck (5):
> > >       media: uvcvideo: Cancel async worker earlier
> > >       media: uvcvideo: Lock video streams and queues while unregister=
ing
> > >       media: uvcvideo: Release stream queue when unregistering video =
device
> > >       media: uvcvideo: Protect uvc queue file operations against disc=
onnect
> > >       media: uvcvideo: Abort uvc_v4l2_open if video device is unregis=
tered
> > >
> > >  drivers/media/usb/uvc/uvc_ctrl.c   | 11 ++++++----
> > >  drivers/media/usb/uvc/uvc_driver.c | 12 ++++++++++
> > >  drivers/media/usb/uvc/uvc_queue.c  | 32 +++++++++++++++++++++++++--
> > >  drivers/media/usb/uvc/uvc_v4l2.c   | 45 ++++++++++++++++++++++++++++=
++++++++--
> > >  drivers/media/usb/uvc/uvcvideo.h   |  1 +
> > >  5 files changed, 93 insertions(+), 8 deletions(-)
>
> --
> Regards,
>
> Laurent Pinchart

Hi Laurent,

Have you had time to take another look at those patches? Can we
somehow move at least with the uvcvideo patches?

Best regards,
Lukasz
