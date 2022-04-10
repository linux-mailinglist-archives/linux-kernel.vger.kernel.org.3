Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695624FAB80
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiDJCUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbiDJCUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:20:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E2535A93;
        Sat,  9 Apr 2022 19:18:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h14so15909769lfl.2;
        Sat, 09 Apr 2022 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxkQOoBxmTaqX6uOiM19N01jRo3rB1KH1QVVjrJxWNQ=;
        b=le230epEV3t7+P1K27GY6GroXeHRiUyNniGaHNyBd+16rgLIErnfyd3Dxxfcm3+ufV
         3ZHqgQnTvHd155lA4ffiSnjnnm6L8HicWlZC/0yCaFZY3+71ejIbPSR+AQAMu1UtkjHm
         oJIxi+pOBZc0t/kPA6RfR9lD2ZNw6rLoDHGkIxMTyZJoL7dk9U6QRxn1Tl19Xn7R1F6A
         biym1N22KqR3QoEvxOlg1azcR23nR/n/9oSj+/Eym1m0dBkmNgz/q081jWUPk81cRodt
         Vd7UKXk8s5ZFTaFGuUL/GPpWfL74dnTUqKe0dnHSqDUWsWKb/hNi1YeXSLcIvmb3Kj8W
         nRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxkQOoBxmTaqX6uOiM19N01jRo3rB1KH1QVVjrJxWNQ=;
        b=Cx4uCpxoRCv5iCnICtzHPaaWUDcNQ5HQ8JL4IBksjr/1JclPvu2whbpMS7dmtFM0Js
         s9d5rzp3CZ8moYs7ixcxkfT/ZI+UVPkcepzWCLHyYMyZGUzCrE82kvPyoqGY9LfhmHgf
         EgNivht2KZ839ePA6uNbfj+KUXm5W64D4uWGywHXKnQUa39mDehavTvfpbEc3y+Z29BL
         7Xr0KemkCRVcSG5SplIlemvgK60vPmre7fbYyCXV6iMQBLBOr6cq+1DDOr1aKZ+S6ZiH
         UzQK9Mnyxwe3B5JMwFvIH8MTWt+xTtW3YFkPgoE6kckVFXghsiYGw9oJxcxtVF0gRXXj
         7d8A==
X-Gm-Message-State: AOAM531WPB2xdARoGnnQNLpAYgAkr9wxcq+tJKL3SgOBHfkuQQfGynEB
        XJ4LdEjT2KKVksxQ1WJ1Po+Il4HBQg7IS3JqjjA=
X-Google-Smtp-Source: ABdhPJzdbPCBP2y+tXQja5vNnBTpx5DHHaGhmO5wtgWrkJ5LJmIjWUwdDezqRE3yMo/4a+xZ2GLV4Q==
X-Received: by 2002:a05:6512:3193:b0:44a:b555:b724 with SMTP id i19-20020a056512319300b0044ab555b724mr17019997lfe.459.1649557107604;
        Sat, 09 Apr 2022 19:18:27 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id e29-20020a19691d000000b0045d5fdab903sm1743094lfc.126.2022.04.09.19.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 19:18:13 -0700 (PDT)
Date:   Sun, 10 Apr 2022 05:18:04 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <20220410051804.315fb0d9@reki>
In-Reply-To: <YlI5b1SNdsVnuo/v@rowland.harvard.edu>
References: <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
        <20220406213634.104cae45@reki>
        <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
        <20220407204553.35cead72@reki>
        <YlBN4Zcn9NYw0PLA@rowland.harvard.edu>
        <20220409115756.4f9b015d@reki>
        <YlGOOJ9SwkD7WVmX@rowland.harvard.edu>
        <20220409170837.02f0853f@reki>
        <YlHrBdYkBSR0L6FL@rowland.harvard.edu>
        <20220410014228.117d9f66@reki>
        <YlI5b1SNdsVnuo/v@rowland.harvard.edu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Sat, 9 Apr 2022 21:57:03 -0400
Alan Stern <stern@rowland.harvard.edu> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On Sun, Apr 10, 2022 at 01:42:28AM +0300, Maxim Devaev wrote:
> > =D0=92 Sat, 9 Apr 2022 16:22:29 -0400
> > Alan Stern <stern@rowland.harvard.edu> wrote: =20
> > > > I'm using Raspberry Pi with DWC2. So:
> > > > - Connect RPi-based gadget to the Linux host.
> > > > - Set image in the "file" attribute.   =20
> > >=20
> > > Exactly what is the full pathname you're using for the "file" attribu=
te? =20
> >=20
> > /sys/kernel/config/usb_gadget/kvmd/functions/mass_storage.usb0/lun.0/fi=
le =20
>=20
> Yeah, that doesn't seem right at all.
>=20
> You're doing this under KVM, right?  Is the gadget driver running in the=
=20
> host OS or the guest OS?  And the sysfs file accesses -- are they in the=
=20
> host's filesystem or in the guest's?
>=20
> What happens if you don't use KVM and just load the gadget driver on the=
=20
> physical machine?

We really have a miscommunication :) Speaking of KVM, I mean KVM-over-IP,
a physical device that emulates Keyboard-Video-Mouse. It is made on the
Raspberry Pi and is physically connected via USB to another host machine
to emulate mass storage, among other things. So, we have two physical devic=
es:
with USB host and USB gadget.

> > > I also tried sending a USR1 signal to the driver's kernel thread whil=
e=20
> > > an image was mounted and being accessed.  It did clear the prevent_al=
low=20
> > > flag, so I could eject the image.  But it also caused a 30-second del=
ay=20
> > > on the host, as predicted.  Now, maybe you don't care about such dela=
ys=20
> > > when you're going to eject the media anyway, but it still seems like =
a=20
> > > bad thing to do. =20
> >=20
> > It looks like the prevent_medium_removal flag switching really works be=
tter in this case. =20
>=20
> I don't understand that comment.  In what case?  Works better than what?

Sorry, better than SIGUSR1. The patch that only sets the prevent_medium_rem=
oval=3D0
and makes the "file" empty.

>=20
> > > > > > I have reflected on the rest of your arguments and changed my m=
ind.
> > > > > > I think that "forced_eject" for a specific lun without interrup=
ting operations would
> > > > > > really be the best solution. I wrote a simple patch and tested =
it, everything seems
> > > > > > to work. What do you think about something like this?
> > > > > >=20
> > > > > >=20
> > > > > > static ssize_t fsg_lun_opts_forced_eject_store(struct config_it=
em *item,
> > > > > >                                                const char *page=
, size_t len)
> > > > > > {
> > > > > >         struct fsg_lun_opts *opts =3D to_fsg_lun_opts(item);
> > > > > >         struct fsg_opts *fsg_opts =3D to_fsg_opts(opts->group.c=
g_item.ci_parent);
> > > > > >         int ret;
> > > > > >=20
> > > > > >         opts->lun->prevent_medium_removal =3D 0;
> > > > > >         ret =3D fsg_store_file(opts->lun, &fsg_opts->common->fi=
lesem, "", 0);
> > > > > >         return ret < 0 ? ret : len;
> > > > > > }
> > > > > >=20
> > > > > > CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject);     =20
> > > > >=20
> > > > > The basic idea is right.  But this should not be a CONFIGFS optio=
n; it=20
> > > > > should be an ordinary LUN attribute.  For an example, see the def=
inition of=20
> > > > > file_store() in f_mass_storage.c; your routine should look very s=
imilar.   =20
> > > >=20
> > > > Okay, but where this attribute is located in sysfs? How can I use i=
t?   =20
> > >=20
> > > Well, it's going to be in different places depending on what UDC driv=
er=20
> > > your gadget uses.  On my system I'm using the dummy_udc driver, so th=
e=20
> > > sysfs "file" attribute is located at:
> > >=20
> > > 	/sys/devices/platform/dummy_ucd.0/gadget/lun0/file
> > >=20
> > > If instead you're looking at
> > >=20
> > > 	/sys/module/g_mass_storage/parameters/file
> > >=20
> > > or in some configfs directory, that's the wrong place.  You can eject=
=20
> > > the media simply by doing (as root):
> > >=20
> > > 	echo >/sys/devices/.../gadget/lun0/file
> > >=20
> > > (fill in the "..." appropriately for your system).
> > >  =20
> > > > Sorry for the stupid question.   =20
> > >=20
> > > Not at all. =20
> >=20
> > Thanks! Unfortunately I'm using dwc2 driver and it doesn't have any gad=
get parameters
> > outside of the configfs:
> >=20
> > [root@pikvm ~]# find /sys -iname lun0
> > [root@pikvm ~]# find /sys -iname lun.0
> > /sys/kernel/config/usb_gadget/kvmd/functions/mass_storage.usb0/lun.0
> > [root@pikvm ~]#
> >=20
> > So in my local case configfs is only way to place forced_eject :( =20
>=20
> That can't possibly be right.  Again, we may be miscommunicating because=
=20
> of the way you're using KVM.
>=20
> What happens if you set up the gadget using g-mass-storage instead of=20
> configfs?  For example:
>=20
> 	modprobe g-mass-storage cdrom=3Dy removable=3Dy ro=3Dy file=3D...
>
> > Could we add both device attrs and configfs file? =20
>=20
> No.  Configfs files are for setting up the gadget in the first place, or=
=20
> changing its configuration while it isn't attached to a host.  Device=20
> attribute files are for modifying the gadget while it is running.
>=20
I've tried and got this:

[root@pikvm ~]# modprobe g-mass-storage cdrom=3Dy removable=3Dy ro=3Dy file=
=3D/var/lib/kvmd/msd/images/dsl-4.11.rc1.iso
[root@pikvm ~]# find /sys -iname lun.0
[root@pikvm ~]# find /sys -iname lun0
/sys/devices/platform/soc/fe980000.usb/gadget/lun0
[root@pikvm ~]# ls /sys/devices/platform/soc/fe980000.usb/gadget/lun0
power  file  nofua  ro  uevent

But with libcomposite and configfs I don't have "/sys/devices/platform/soc/=
fe980000.usb/gadget/lun0" at all:

[root@pikvm ~]# ls /sys/devices/platform/soc/fe980000.usb/gadget/
power  suspended  uevent

So all this timed I used configfs to change parameters.
I thought this was the way it was intended because the code for changing co=
nfigfs
and device attributes is almost identical and everything worked.
If I don't have device attributes when using libcomposite, then how am I su=
pposed
to change its settings in runtime, if not through configfs?
