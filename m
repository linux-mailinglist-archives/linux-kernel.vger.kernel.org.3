Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF08586646
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiHAIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiHAIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:21:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36E532445
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27520CE1161
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49927C433D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659342110;
        bh=eUr/ZH45qggIMaFLX3LJkoO2C78pcKF2mxz/f/h/tRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TBuVvcDeJ0LmTIi3MPah56qvrK2ZDDLFG6iG1u98Np1/iLhmxXVO7H/qmcbLVfa/e
         rciDqH3/KCO24UAdwzt9bOjySVYUq0tkynyc84hxNRPEc5itLyOSi0dRuKiWSpGD6/
         5KqkG51REnO7gjiGOd19hqp+dUAWQT6W09QT9FFpz25unCKcfXT0iXYnJul+qEe8vt
         bqD2vNhqk0wlTe3Q1gTf6GOtQrJ/I7U1qfMrNSKmc+jFusDMjbjAELwcqy92bdlo0j
         VAUEuTfnMMAlDiS/cxYDT/8SJHyvfnVkC4O53f/dwz/MC0biv2V44wkMVLBTj7QV4w
         S7NckUTfE4+WQ==
Received: by mail-ot1-f47.google.com with SMTP id g8-20020a9d6b08000000b0061d0ac9ebb2so7733749otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:21:50 -0700 (PDT)
X-Gm-Message-State: AJIora/wjTjRtv4FYbmyzSJmezez9U10GXIu6kXDEdtRiyH0AcUXAOOb
        HENVzazeP6drQPMvkrTrR19Izic4AQ16hdLgG6g=
X-Google-Smtp-Source: AGRyM1svlL9dEheAPe6zNYjS6XldUOCMkMNJjj8CQnE1F6BYQ+HvQRDwyksNDWfc0HgRxfX/t/LpdCVjn7Ei7nmhWXg=
X-Received: by 2002:a9d:6e84:0:b0:61c:8fdc:de7c with SMTP id
 a4-20020a9d6e84000000b0061c8fdcde7cmr5507976otr.334.1659342109445; Mon, 01
 Aug 2022 01:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <YuahxB6geST6ZtGN@kroah.com> <TYAPR01MB62013A228CD094847524F8D8929A9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB62013A228CD094847524F8D8929A9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 1 Aug 2022 11:21:22 +0300
X-Gmail-Original-Message-ID: <CAFCwf139nRjebnMfHPuhHWBh_6pWuRm=9sBjgAFL9u9GsOqEzw@mail.gmail.com>
Message-ID: <CAFCwf139nRjebnMfHPuhHWBh_6pWuRm=9sBjgAFL9u9GsOqEzw@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 5:35 AM <yuji2.ishikawa@toshiba.co.jp> wrote:
>
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, August 1, 2022 12:38 AM
> > To: Oded Gabbay <oded.gabbay@gmail.com>
> > Cc: ishikawa yuji(=E7=9F=B3=E5=B7=9D =E6=82=A0=E5=8F=B8 =E2=97=8B=EF=BC=
=B2=EF=BC=A4=EF=BC=A3=E2=96=A1=EF=BC=A1=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=
=EF=BC=A5=EF=BC=A1=E9=96=8B)
> > <yuji2.ishikawa@toshiba.co.jp>; Jiho Chu <jiho.chu@samsung.com>; Arnd
> > Bergmann <arnd@arndb.de>; Linux-Kernel@Vger. Kernel. Org
> > <linux-kernel@vger.kernel.org>
> > Subject: Re: New subsystem for acceleration devices
> >
> > On Sun, Jul 31, 2022 at 02:45:34PM +0300, Oded Gabbay wrote:
> > > Hi,
> > > Greg and I talked a couple of months ago about preparing a new accel
> > > subsystem for compute/acceleration devices that are not GPUs and I
> > > think your drivers that you are now trying to upstream fit it as well=
.
> > >
> > > Would you be open/interested in migrating your drivers to this new
> > subsystem ?
> > >
> > > Because there were no outstanding candidates, I have done so far only
> > > a basic and partial implementation of the infrastructure for this
> > > subsystem, but if you are willing to join I believe I can finish it
> > > rather quickly.
> > >
> > > At start, the new subsystem will provide only a common device
> > > character (e.g. /dev/acX) so everyone will do open/close/ioctl on the
> > > same device character. Also sysfs/debugfs entries will be under that
> > > device and maybe an IOCTL to retrieve information.
> > >
> > > In the future I plan to move some of habanalabs driver's code into th=
e
> > > subsystem itself, for common tasks such as memory management, dma
> > > memory allocation, etc.
> > >
> > > Of course, you will be able to add your own IOCTLs as you see fit.
> > > There will be a range of IOCTLs which are device-specific (similar to
> > > drm).
> > >
> > > wdyt ?
> >
> > That sounds reasonable to me as a sane plan forward, thanks for working=
 on
> > this.
> >
> > greg k-h
>
> Hi,
> Thank you for your suggestion.
> I'm really interested in the idea to have a dedicated subsystem for accel=
erators.
> Let me challenge if the Visconti DNN driver can be re-written to the fram=
ework.
> As Visconti SoC has several accelerators as well as DNN,
> having a general/common interface will be a big benefit for us to maintai=
n drivers for a long time.
>
> I've heard that the framework has some basic implementation.
> Do you have some sample code or enumeration of idea to describe the frame=
work?
> Would you share them with me? if that does not bother you.
>
Great to hear that!

I will need a couple of days to complete the code and clean it up
because I stopped working on it a couple of months ago as there were
no other candidates at the time.
Once I have it ready I will put it in my linux repo and send you a branch n=
ame.

In the meantime, I'd like to describe at a high level how this
framework is going to work.

I'll start with the main theme of this framework which is allowing
maximum flexibility to the different device drivers. This is because
in my opinion there is and always will be a large variance between
different compute accelerators, which stems from the fact their h/w is
designed for different purposes. I believe that it would be nearly
impossible to create a standard acceleration API that will be
applicable to all compute accelerators.

Having said that, there are many things that can be common. I'll just
name here a few things:

- Exposing devices in a uniform way (same device character files) and
managing the major/minor/open/close (with callbacks to the open/close
of the device driver)

- Defining a standard user API for monitoring applications that
usually run in a data-center. There is a big difference
between the acceleration uAPI and a monitoring uAPI and while the
former is highly specialized, the latter can be standardized.

- Common implementation of a memory manager that will give services of
allocating kernel memory that can be
  mmap'ed by the user.

- For devices with on-chip MMU, common memory manager for allocating
device memory and managing it.

- Integration with dma-buf for interoperability with other drivers.

The initial implementation of the framework will expose two device
character files per device. One will be used for the main/compute
operations and the other one will be used for monitoring applications.
This is done in case there are some limitations on the main device
file (e.g. allowing only a single compute application to be connected
to the device).

Each driver will call a register function during its probe function
(very similar to what is done in the drm subsystem). This will
register the device in the accel framework and expose the device
character files. Every call on those files
(e.g. open, ioctl) will then go through the accel subsystem first and
then will go to the callbacks of the specific device drivers. The
framework will take care of allocating major and minor numbers and
handle these issues in a uniform way.

For now, I plan to define a single ioctl in the common part, which is
an information ioctl, allowing the user to retrieve various
information on the device (fixed or dynamic). I don't want to jump
ahead of myself and define other common ioctls before gaining some
traction. As I wrote above, each driver will be allowed to define its
own custom ioctls.

There will be an infrastructure to add custom sysfs and debugfs
entries. Once we start working, I'm sure we will find some properties
that we can move to the infrastructure itself (e.g. asking to reset
the device, operational status)

I don't know if I want to add the memory manager we prepared in
habanalabs driver at day one, because I would like to minimize the
effort we have to convert our drivers to using this framework. From
the above, I believe you can see the current effort is not large.

That's it from high-level pov. As I wrote at the beginning, I'll get
back to you in a few days with a link to a git repo containing the
initial implementation.

> If you need further information on the current DNN driver, please let me =
know.
> Also, I can provide some for other accelerator drivers which are currentl=
y under cleaning up for contribution.
I looked at the patches you sent and I believe it will be a good match
for this framework.
If you have additional drivers that you think can be a goot match, by
all means, please send links to me.

Thanks,
Oded
