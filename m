Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C734FAED4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbiDJQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbiDJQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:16:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2175A590;
        Sun, 10 Apr 2022 09:14:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d40so15204316lfv.11;
        Sun, 10 Apr 2022 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVVugiGwANrqlBaA6ivaUKrahdkCr36k7VgezQFTpZQ=;
        b=Es05VMwJuRhMYE20IqAA6CNRWB4re6xBykYAUBkSOJI4w+p8ypF/VxdxdOdnRJ3PZi
         xHzA5z6xYN58e/conynDYlugekkQF0EuQ4asRV4OCeaYtyqVbGck3EUhBkokL8rg+DiV
         O1BqsmyZ4KVS4sp14/XYiWyi1emVMSCMf1zsx7Qsp2QMRKb9MgkQmOhQlWbUJtk/G1Iy
         RM8IN+FwfAEq4EYwhbkpYQ6xY9SfW0ks55uJ7xOCEjRXjybyH/Vv6GUHlRUAHpWtNZ5s
         1SKxbHGvZfXAEDWTMDQkmqnseHbDuduCglNRUb2iXLjtRrOMFRv8eBsVxcEKFVlXWeh8
         kOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVVugiGwANrqlBaA6ivaUKrahdkCr36k7VgezQFTpZQ=;
        b=dkI5fnZB39V3vTFw+ckFSBFyoDiojP5Q1PcQrSIeR/5IhnnVtupfZ9r97JoaoJuOTl
         WZz8Z41XiMwZH3UyEYALAyxlCWTdQMUowRuum6Ds67F7Z8DsdxK8sbn2qZlhcburLr6B
         oGFFmkiTTcICpdcVvzq+huLzVkBEFtPqat+cFp53VzPDTsXUV6twHR0rxiXmuLOxbuiT
         YLYzgBxKN/25TQrIuAIGoQAnPcdxIKsuzdPGYEn3GY9CEaGpp0nZIPFcByjiIPpbg0CL
         UgjY7uer9gwFuEM3HCjDRnFqhcZRx9HImi48I9QZW8Bz/9poELEnC+gC0zSYNOaFJi2q
         5RCg==
X-Gm-Message-State: AOAM530jPr3QKkntsccTJkOaUNMPB21nNtkv49NToiB27UiO0dQu5eHZ
        IIQLz4+7XdzDUquFyWhg2FizY+VRYBeJsPE/iFI=
X-Google-Smtp-Source: ABdhPJyC6yA8kikoJFVLWbNfMexlcvKzVcU77BHAKHGRcPFllP1Ersm3tWNe6KFw0HzKbD5zbedIMg==
X-Received: by 2002:ac2:4899:0:b0:464:f80b:a86d with SMTP id x25-20020ac24899000000b00464f80ba86dmr10762023lfc.65.1649607280241;
        Sun, 10 Apr 2022 09:14:40 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id q2-20020a196e42000000b0046b95d33a57sm429896lfk.153.2022.04.10.09.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:14:39 -0700 (PDT)
Date:   Sun, 10 Apr 2022 19:14:38 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <20220410191438.6dc1abf8@reki>
In-Reply-To: <YlL164UHvCV0ti4U@rowland.harvard.edu>
References: <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
        <20220407204553.35cead72@reki>
        <YlBN4Zcn9NYw0PLA@rowland.harvard.edu>
        <20220409115756.4f9b015d@reki>
        <YlGOOJ9SwkD7WVmX@rowland.harvard.edu>
        <20220409170837.02f0853f@reki>
        <YlHrBdYkBSR0L6FL@rowland.harvard.edu>
        <20220410014228.117d9f66@reki>
        <YlI5b1SNdsVnuo/v@rowland.harvard.edu>
        <20220410051804.315fb0d9@reki>
        <YlL164UHvCV0ti4U@rowland.harvard.edu>
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

=D0=92 Sun, 10 Apr 2022 11:21:15 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Sun, Apr 10, 2022 at 05:18:04AM +0300, Maxim Devaev wrote:
> > =D0=92 Sat, 9 Apr 2022 21:57:03 -0400
> > Alan Stern <stern@rowland.harvard.edu> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >  =20
> > > On Sun, Apr 10, 2022 at 01:42:28AM +0300, Maxim Devaev wrote: =20
> > > > =D0=92 Sat, 9 Apr 2022 16:22:29 -0400
> > > > Alan Stern <stern@rowland.harvard.edu> wrote:   =20
> > > > > > I'm using Raspberry Pi with DWC2. So:
> > > > > > - Connect RPi-based gadget to the Linux host.
> > > > > > - Set image in the "file" attribute.     =20
> > > > >=20
> > > > > Exactly what is the full pathname you're using for the "file" att=
ribute?   =20
> > > >=20
> > > > /sys/kernel/config/usb_gadget/kvmd/functions/mass_storage.usb0/lun.=
0/file   =20
> > >=20
> > > Yeah, that doesn't seem right at all.
> > >=20
> > > You're doing this under KVM, right?  Is the gadget driver running in =
the=20
> > > host OS or the guest OS?  And the sysfs file accesses -- are they in =
the=20
> > > host's filesystem or in the guest's?
> > >=20
> > > What happens if you don't use KVM and just load the gadget driver on =
the=20
> > > physical machine? =20
> >=20
> > We really have a miscommunication :) Speaking of KVM, I mean KVM-over-I=
P,
> > a physical device that emulates Keyboard-Video-Mouse. It is made on the
> > Raspberry Pi and is physically connected via USB to another host machine
> > to emulate mass storage, among other things. So, we have two physical d=
evices:
> > with USB host and USB gadget. =20
>=20
> Okay, I see where I misunderstood.  Oops.  :-)
>=20
> > > > > I also tried sending a USR1 signal to the driver's kernel thread =
while=20
> > > > > an image was mounted and being accessed.  It did clear the preven=
t_allow=20
> > > > > flag, so I could eject the image.  But it also caused a 30-second=
 delay=20
> > > > > on the host, as predicted.  Now, maybe you don't care about such =
delays=20
> > > > > when you're going to eject the media anyway, but it still seems l=
ike a=20
> > > > > bad thing to do.   =20
> > > >=20
> > > > It looks like the prevent_medium_removal flag switching really work=
s better in this case.   =20
> > >=20
> > > I don't understand that comment.  In what case?  Works better than wh=
at? =20
> >=20
> > Sorry, better than SIGUSR1. The patch that only sets the prevent_medium=
_removal=3D0
> > and makes the "file" empty. =20
>=20
> Ah, yes, I agree.
>=20
> > > > > > > > I have reflected on the rest of your arguments and changed =
my mind.
> > > > > > > > I think that "forced_eject" for a specific lun without inte=
rrupting operations would
> > > > > > > > really be the best solution. I wrote a simple patch and tes=
ted it, everything seems
> > > > > > > > to work. What do you think about something like this?
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > static ssize_t fsg_lun_opts_forced_eject_store(struct confi=
g_item *item,
> > > > > > > >                                                const char *=
page, size_t len)
> > > > > > > > {
> > > > > > > >         struct fsg_lun_opts *opts =3D to_fsg_lun_opts(item);
> > > > > > > >         struct fsg_opts *fsg_opts =3D to_fsg_opts(opts->gro=
up.cg_item.ci_parent);
> > > > > > > >         int ret;
> > > > > > > >=20
> > > > > > > >         opts->lun->prevent_medium_removal =3D 0;
> > > > > > > >         ret =3D fsg_store_file(opts->lun, &fsg_opts->common=
->filesem, "", 0);
> > > > > > > >         return ret < 0 ? ret : len;
> > > > > > > > }
> > > > > > > >=20
> > > > > > > > CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject);       =20
> > > > > > >=20
> > > > > > > The basic idea is right.  But this should not be a CONFIGFS o=
ption; it=20
> > > > > > > should be an ordinary LUN attribute.  For an example, see the=
 definition of=20
> > > > > > > file_store() in f_mass_storage.c; your routine should look ve=
ry similar.     =20
> > > > > >=20
> > > > > > Okay, but where this attribute is located in sysfs? How can I u=
se it?     =20
> > > > >=20
> > > > > Well, it's going to be in different places depending on what UDC =
driver=20
> > > > > your gadget uses.  On my system I'm using the dummy_udc driver, s=
o the=20
> > > > > sysfs "file" attribute is located at:
> > > > >=20
> > > > > 	/sys/devices/platform/dummy_ucd.0/gadget/lun0/file
> > > > >=20
> > > > > If instead you're looking at
> > > > >=20
> > > > > 	/sys/module/g_mass_storage/parameters/file
> > > > >=20
> > > > > or in some configfs directory, that's the wrong place.  You can e=
ject=20
> > > > > the media simply by doing (as root):
> > > > >=20
> > > > > 	echo >/sys/devices/.../gadget/lun0/file
> > > > >=20
> > > > > (fill in the "..." appropriately for your system).
> > > > >    =20
> > > > > > Sorry for the stupid question.     =20
> > > > >=20
> > > > > Not at all.   =20
> > > >=20
> > > > Thanks! Unfortunately I'm using dwc2 driver and it doesn't have any=
 gadget parameters
> > > > outside of the configfs:
> > > >=20
> > > > [root@pikvm ~]# find /sys -iname lun0
> > > > [root@pikvm ~]# find /sys -iname lun.0
> > > > /sys/kernel/config/usb_gadget/kvmd/functions/mass_storage.usb0/lun.0
> > > > [root@pikvm ~]#
> > > >=20
> > > > So in my local case configfs is only way to place forced_eject :(  =
 =20
> > >=20
> > > That can't possibly be right.  Again, we may be miscommunicating beca=
use=20
> > > of the way you're using KVM.
> > >=20
> > > What happens if you set up the gadget using g-mass-storage instead of=
=20
> > > configfs?  For example:
> > >=20
> > > 	modprobe g-mass-storage cdrom=3Dy removable=3Dy ro=3Dy file=3D...
> > > =20
> > > > Could we add both device attrs and configfs file?   =20
> > >=20
> > > No.  Configfs files are for setting up the gadget in the first place,=
 or=20
> > > changing its configuration while it isn't attached to a host.  Device=
=20
> > > attribute files are for modifying the gadget while it is running.
> > >  =20
> > I've tried and got this:
> >=20
> > [root@pikvm ~]# modprobe g-mass-storage cdrom=3Dy removable=3Dy ro=3Dy =
file=3D/var/lib/kvmd/msd/images/dsl-4.11.rc1.iso
> > [root@pikvm ~]# find /sys -iname lun.0
> > [root@pikvm ~]# find /sys -iname lun0
> > /sys/devices/platform/soc/fe980000.usb/gadget/lun0
> > [root@pikvm ~]# ls /sys/devices/platform/soc/fe980000.usb/gadget/lun0
> > power  file  nofua  ro  uevent
> >=20
> > But with libcomposite and configfs I don't have "/sys/devices/platform/=
soc/fe980000.usb/gadget/lun0" at all:
> >=20
> > [root@pikvm ~]# ls /sys/devices/platform/soc/fe980000.usb/gadget/
> > power  suspended  uevent
> >=20
> > So all this timed I used configfs to change parameters.
> > I thought this was the way it was intended because the code for changin=
g configfs
> > and device attributes is almost identical and everything worked.
> > If I don't have device attributes when using libcomposite, then how am =
I supposed
> > to change its settings in runtime, if not through configfs? =20
>=20
> All right.  I've never used configfs before, so my understanding of it=20
> was out of date.  After reading through the documentation and the code,=20
> it's clear now that you're right and there should be both a device=20
> attribute and a configfs file.
>=20
> Unlike the fsg_lun_opts_forced_eject_store() example you wrote above,=20
> but like the existing fsg_lun_opts_file_store() and file_store()=20
> routines, both of your new routines should call a single=20
> fsg_store_forced_eject() function in storage_common.c to do the real=20
> work.  Namely, something like:
>=20
> 	lun->prevent_medium_removal =3D 0;
> 	return fsg_store_file(lun, filesem, "", 0);
>=20
> That should accomplish what you're looking for, in all possible=20
> configurations.

Great! So, next I will test this patch locally and with my users and submit=
 the v2 version
a little later. Thank you for your help!

