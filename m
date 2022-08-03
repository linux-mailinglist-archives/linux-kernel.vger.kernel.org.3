Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EC0589335
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiHCU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiHCU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17795A3F4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD3C61512
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1CCC433D7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659558556;
        bh=M4RXF3NWAp8nnU1Fudf651MANFL1NemSc2kweEG+F/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AZU3589pF4ViNrIaFmARLOKp75vnpKT7VwzrFfq788WTRuyfAvKBhVT7Z7BB77lC7
         k7lpwIreRNmPLrlijIkLD2K5Z7azJUl/Q+3JhagNi9exbYTLRu1rOLir3po4lTIzyj
         3jIjwlBKnMaUw/AUfnZ+18N7PHYbMN3COaCrhjBXCNjOyKSDGGnJFzdDM9lsv8WJDY
         ZatxF7xRGs0Y4ZzI7uro0eUBAdh7h9CfMWM9PLuDcLeBZTpANzJOoUGg7gCWWKKg0S
         lC2px0x2FSygXA8B2D7duDwR48QI8np6jzlX/MycJU7+lvoBETFsUwNtFtu+S/89yV
         w6X7C/+hvbcaA==
Received: by mail-oi1-f171.google.com with SMTP id i4so21129969oif.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:29:16 -0700 (PDT)
X-Gm-Message-State: ACgBeo1WiXrPBqtmjL8s81C5qJjhV2jDkJMuuttzJuQsn1AlQqvd/Ef6
        s/CNNCEt4w2b0rj+j0QwTUTWK6fpxyT70hbRptk=
X-Google-Smtp-Source: AA6agR4W+/Lq0LXeQPFjWfACJeth9zE0FFJ+cKYGI5VQycXhAkBPgprobN6TltZS+4b4pVCsCSkDF2fEHCD4dnXmf4A=
X-Received: by 2002:a05:6808:1888:b0:342:a0c3:f7d4 with SMTP id
 bi8-20020a056808188800b00342a0c3f7d4mr55057oib.286.1659558555749; Wed, 03 Aug
 2022 13:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <YuahxB6geST6ZtGN@kroah.com> <TYAPR01MB62013A228CD094847524F8D8929A9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <CAFCwf139nRjebnMfHPuhHWBh_6pWuRm=9sBjgAFL9u9GsOqEzw@mail.gmail.com> <TYAPR01MB620151C7322BCC174266FA2C929C9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB620151C7322BCC174266FA2C929C9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 3 Aug 2022 23:28:48 +0300
X-Gmail-Original-Message-ID: <CAFCwf13n+VZL6tUgKm3pcFmk9FCTGrE4LmdQEgo5+jUyi3Kguw@mail.gmail.com>
Message-ID: <CAFCwf13n+VZL6tUgKm3pcFmk9FCTGrE4LmdQEgo5+jUyi3Kguw@mail.gmail.com>
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

On Wed, Aug 3, 2022 at 7:44 AM <yuji2.ishikawa@toshiba.co.jp> wrote:
>
> > -----Original Message-----
> > From: Oded Gabbay <ogabbay@kernel.org>
> > Sent: Monday, August 1, 2022 5:21 PM
> > To: ishikawa yuji(=E7=9F=B3=E5=B7=9D =E6=82=A0=E5=8F=B8 =E2=97=8B=EF=BC=
=B2=EF=BC=A4=EF=BC=A3=E2=96=A1=EF=BC=A1=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=
=EF=BC=A5=EF=BC=A1=E9=96=8B)
> > <yuji2.ishikawa@toshiba.co.jp>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiho Chu
> > <jiho.chu@samsung.com>; Arnd Bergmann <arnd@arndb.de>;
> > Linux-Kernel@Vger. Kernel. Org <linux-kernel@vger.kernel.org>
> > Subject: Re: New subsystem for acceleration devices
> >
> > On Mon, Aug 1, 2022 at 5:35 AM <yuji2.ishikawa@toshiba.co.jp> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Sent: Monday, August 1, 2022 12:38 AM
> > > > To: Oded Gabbay <oded.gabbay@gmail.com>
> > > > Cc: ishikawa yuji(=E7=9F=B3=E5=B7=9D =E6=82=A0=E5=8F=B8 =E2=97=8B=
=EF=BC=B2=EF=BC=A4=EF=BC=A3=E2=96=A1=EF=BC=A1=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=
=97=8B=EF=BC=A5=EF=BC=A1=E9=96=8B)
> > > > <yuji2.ishikawa@toshiba.co.jp>; Jiho Chu <jiho.chu@samsung.com>;
> > > > Arnd Bergmann <arnd@arndb.de>; Linux-Kernel@Vger. Kernel. Org
> > > > <linux-kernel@vger.kernel.org>
> > > > Subject: Re: New subsystem for acceleration devices
> > > >
> > > > On Sun, Jul 31, 2022 at 02:45:34PM +0300, Oded Gabbay wrote:
> > > > > Hi,
> > > > > Greg and I talked a couple of months ago about preparing a new
> > > > > accel subsystem for compute/acceleration devices that are not GPU=
s
> > > > > and I think your drivers that you are now trying to upstream fit =
it as well.
> > > > >
> > > > > Would you be open/interested in migrating your drivers to this ne=
w
> > > > subsystem ?
> > > > >
> > > > > Because there were no outstanding candidates, I have done so far
> > > > > only a basic and partial implementation of the infrastructure for
> > > > > this subsystem, but if you are willing to join I believe I can
> > > > > finish it rather quickly.
> > > > >
> > > > > At start, the new subsystem will provide only a common device
> > > > > character (e.g. /dev/acX) so everyone will do open/close/ioctl on
> > > > > the same device character. Also sysfs/debugfs entries will be
> > > > > under that device and maybe an IOCTL to retrieve information.
> > > > >
> > > > > In the future I plan to move some of habanalabs driver's code int=
o
> > > > > the subsystem itself, for common tasks such as memory management,
> > > > > dma memory allocation, etc.
> > > > >
> > > > > Of course, you will be able to add your own IOCTLs as you see fit=
.
> > > > > There will be a range of IOCTLs which are device-specific (simila=
r
> > > > > to drm).
> > > > >
> > > > > wdyt ?
> > > >
> > > > That sounds reasonable to me as a sane plan forward, thanks for
> > > > working on this.
> > > >
> > > > greg k-h
> > >
> > > Hi,
> > > Thank you for your suggestion.
> > > I'm really interested in the idea to have a dedicated subsystem for
> > accelerators.
> > > Let me challenge if the Visconti DNN driver can be re-written to the
> > framework.
> > > As Visconti SoC has several accelerators as well as DNN, having a
> > > general/common interface will be a big benefit for us to maintain dri=
vers for a
> > long time.
> > >
> > > I've heard that the framework has some basic implementation.
> > > Do you have some sample code or enumeration of idea to describe the
> > framework?
> > > Would you share them with me? if that does not bother you.
> > >
> > Great to hear that!
> >
> > I will need a couple of days to complete the code and clean it up becau=
se I
> > stopped working on it a couple of months ago as there were no other can=
didates
> > at the time.
> > Once I have it ready I will put it in my linux repo and send you a bran=
ch name.
> >
> > In the meantime, I'd like to describe at a high level how this framewor=
k is going
> > to work.
> >
> > I'll start with the main theme of this framework which is allowing maxi=
mum
> > flexibility to the different device drivers. This is because in my opin=
ion there is
> > and always will be a large variance between different compute accelerat=
ors,
> > which stems from the fact their h/w is designed for different purposes.=
 I believe
> > that it would be nearly impossible to create a standard acceleration AP=
I that will
> > be applicable to all compute accelerators.
> >
> > Having said that, there are many things that can be common. I'll just n=
ame here
> > a few things:
> >
> > - Exposing devices in a uniform way (same device character files) and
> > managing the major/minor/open/close (with callbacks to the open/close o=
f the
> > device driver)
> >
> > - Defining a standard user API for monitoring applications that usually=
 run in a
> > data-center. There is a big difference between the acceleration uAPI an=
d a
> > monitoring uAPI and while the former is highly specialized, the latter =
can be
> > standardized.
> >
> > - Common implementation of a memory manager that will give services of
> > allocating kernel memory that can be
> >   mmap'ed by the user.
> >
> > - For devices with on-chip MMU, common memory manager for allocating
> > device memory and managing it.
> >
> > - Integration with dma-buf for interoperability with other drivers.
> >
> > The initial implementation of the framework will expose two device char=
acter
> > files per device. One will be used for the main/compute operations and =
the
> > other one will be used for monitoring applications.
> > This is done in case there are some limitations on the main device file=
 (e.g.
> > allowing only a single compute application to be connected to the devic=
e).
> >
> > Each driver will call a register function during its probe function (ve=
ry similar to
> > what is done in the drm subsystem). This will register the device in th=
e accel
> > framework and expose the device character files. Every call on those fi=
les (e.g.
> > open, ioctl) will then go through the accel subsystem first and then wi=
ll go to
> > the callbacks of the specific device drivers. The framework will take c=
are of
> > allocating major and minor numbers and handle these issues in a uniform=
 way.
> >
> > For now, I plan to define a single ioctl in the common part, which is a=
n
> > information ioctl, allowing the user to retrieve various information on=
 the device
> > (fixed or dynamic). I don't want to jump ahead of myself and define oth=
er
> > common ioctls before gaining some traction. As I wrote above, each driv=
er will
> > be allowed to define its own custom ioctls.
> >
> > There will be an infrastructure to add custom sysfs and debugfs entries=
. Once
> > we start working, I'm sure we will find some properties that we can mov=
e to the
> > infrastructure itself (e.g. asking to reset the device, operational sta=
tus)
> >
> > I don't know if I want to add the memory manager we prepared in habanal=
abs
> > driver at day one, because I would like to minimize the effort we have =
to convert
> > our drivers to using this framework. From the above, I believe you can =
see the
> > current effort is not large.
> >
> > That's it from high-level pov. As I wrote at the beginning, I'll get ba=
ck to you in a
> > few days with a link to a git repo containing the initial implementatio=
n.
> >
>
> Hi Oded,
>
> Thank you for sharing high level idea with me.
> I'm grad to hear that the DNN driver can be ported to the accelerator fra=
mework without too-much effort. I think we can start with minimum implement=
ation and find better way.
> Currently the driver does not have API for monitoring. I'll prepare some =
logic to match the framework.
>
> Some of my interests are handling IOMMU and DMA-BUF.
> Currently the DNN driver has its own minimum implementation of those two.
> Will DMA-BUF feature of accelerator framework be provided soon?
I didn't plan it to be on the initial release, but I'm sure we can
make it a priority to be added soon after we do the initial
integration and everything is accepted to the kernel.
Oded
>
> > > If you need further information on the current DNN driver, please let=
 me know.
> > > Also, I can provide some for other accelerator drivers which are curr=
ently
> > under cleaning up for contribution.
> > I looked at the patches you sent and I believe it will be a good match =
for this
> > framework.
> > If you have additional drivers that you think can be a goot match, by a=
ll means,
> > please send links to me.
> >
> > Thanks,
> > Oded
>
> Visconti DSP driver might be interesting for you as it provides multiple =
functions and requires external firmware.
> The problem is that I don't have official public repository.
> I wonder if it's possible to post some pieces of code to this ML.
>
> Regards,
>         Yuji
