Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786324FAB12
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 00:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiDIWoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 18:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiDIWol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 18:44:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E49321263;
        Sat,  9 Apr 2022 15:42:32 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bn33so15781078ljb.6;
        Sat, 09 Apr 2022 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3DpwAUsQgb6G8qmUX1oHaQUdshucAf20LGidketc2c=;
        b=LPqt/5Mn9KEvxn7UooOfzqJnrt9u+2iTR+Ccamvz6czLvrSRW7AsJbVnfxALmYhK4B
         kWLgnNusvWqFDY/Knvw821FaxAF+1o5cKo54TtC2G9jOGOW0Jajzu9ojIkB99DnlMK2n
         rQ+0Mzb5Vcp9HuPl0eF8pgXLUDcqoWrPNUSGMqJX4uqd+MULBQFyERfjyjtrk83g/2jL
         bZZPzvfed5bRi2SNrxkipbMh+NXpyWBxwWxxPLMUQtZET5i9Dz2tTUvesxuMfYqxRUzW
         4HVbVekyor3tjUbkrXCkY3OF1PmLJ0s6SJPEQWqHzxK5LntWqnOIiWeVasfiNzbRnAWn
         yvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3DpwAUsQgb6G8qmUX1oHaQUdshucAf20LGidketc2c=;
        b=YILQjF3uZimqGRSw+LxVSFpTLtUonxE0WFSL1FJNAK8EcAFndCFUYrBgSh7/ucQUrd
         b8679dhTXkxJ6DDfeNMgG5IH5sH1ukLhE04hmW1IFGVFu3XJE8etKg4C4SyVwEaU0c6C
         R3Ax17HTanr4mqASwNRl7nfhlKqCvSLMi//NVcsgIrkJtrMRUKrkuQBC4kWQr9uj9WdD
         Jws2p+BBigwPNDL//SrNA99zv9R4chNFCwMkgSSmxD+y0cTMIvp/xPzsuITxgZTVodjN
         2y2KfmQFYStG7jMkAttOrlap7B7Wq+TJDPx+VaBLNG7qKUDHT9yqtptZwmTiK3PN/Y2g
         7WFg==
X-Gm-Message-State: AOAM530iKpqDIwCjhmwWd/atbjTZd9KP8jqE7yW1k93fHfJHUH6RwtYO
        X5NAd1+26boN1Np8z+Cal0ibG3+QNCH90Rc3lbU=
X-Google-Smtp-Source: ABdhPJzpMPCKhxa2Us+9jzHCbAfVmz6k/bdiJ1tn2LgLlC5mgwJ7jBsnzfJx0NLGLEnDbkIER4iQMg==
X-Received: by 2002:a05:651c:2313:b0:24b:6019:6e8c with SMTP id bi19-20020a05651c231300b0024b60196e8cmr71193ljb.296.1649544150703;
        Sat, 09 Apr 2022 15:42:30 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id f23-20020a2e9e97000000b0024921bcf06bsm2667120ljk.57.2022.04.09.15.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 15:42:29 -0700 (PDT)
Date:   Sun, 10 Apr 2022 01:42:28 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <20220410014228.117d9f66@reki>
In-Reply-To: <YlHrBdYkBSR0L6FL@rowland.harvard.edu>
References: <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
        <20220406195234.4f63cb4a@reki>
        <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
        <20220406213634.104cae45@reki>
        <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
        <20220407204553.35cead72@reki>
        <YlBN4Zcn9NYw0PLA@rowland.harvard.edu>
        <20220409115756.4f9b015d@reki>
        <YlGOOJ9SwkD7WVmX@rowland.harvard.edu>
        <20220409170837.02f0853f@reki>
        <YlHrBdYkBSR0L6FL@rowland.harvard.edu>
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

=D0=92 Sat, 9 Apr 2022 16:22:29 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Sat, Apr 09, 2022 at 05:08:37PM +0300, Maxim Devaev wrote:
> > =D0=92 Sat, 9 Apr 2022 09:46:32 -0400
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> >  =20
> > > On Sat, Apr 09, 2022 at 11:57:56AM +0300, Maxim Devaev wrote: =20
> > > > =D0=92 Fri, 8 Apr 2022 10:59:45 -0400
> > > > Alan Stern <stern@rowland.harvard.edu> wrote:   =20
> > > > > > At least there is one situation where the behavior of f_mass_st=
orage differs
> > > > > > from the behavior of a real drive. What happens when you click =
on the physical
> > > > > > "eject" button?     =20
> > > > >=20
> > > > > If the host has prevented ejection, nothing happens.  Otherwise t=
he disc=20
> > > > > gets ejected.
> > > > >    =20
> > > > > > Yes, the OS can block this, but the problem is that we don't ha=
ve
> > > > > > an "eject" here.     =20
> > > > >=20
> > > > > What do you mean?  Writing an empty string to the sysfs "file" at=
tribute=20
> > > > > is the virtual analog of pressing the eject button.   =20
> > > >=20
> > > > But I can't eject the disc event it's not mounted on Linux host. It=
 seems to me
> > > > it differs from the real drive behavior.   =20
> > >=20
> > > It sounds like either there's a bug or else you're not doing the righ=
t=20
> > > thing.  Tell me exactly what you do when this fails. =20
> >=20
> > I'm using Raspberry Pi with DWC2. So:
> > - Connect RPi-based gadget to the Linux host.
> > - Set image in the "file" attribute. =20
>=20
> Exactly what is the full pathname you're using for the "file" attribute?

/sys/kernel/config/usb_gadget/kvmd/functions/mass_storage.usb0/lun.0/file

> > - Mount gadget's drive on the Linux host.
> > - Umount it.
> > - Try to eject using emptying the "file" attribute.
> > - Get EBUSY error. =20
>=20
> This must mean that some program on the host is keeping the device file=20
> open, even though it isn't mounted.  (I tried running a similar test on=20
> my system and it worked perfectly, with no other programs accessing the=20
> device).  You might be able to identify which program is accessing the=20
> device by running lsof on the host and searching the output for the=20
> device name.

I've been thinking about it too. I tried lsof but it didn't display anything
related with sr0 device. But after execution the "eject" command on the hos=
t,
I was able to emptify the "file" attribute of the gadget.

> I also tried sending a USR1 signal to the driver's kernel thread while=20
> an image was mounted and being accessed.  It did clear the prevent_allow=
=20
> flag, so I could eject the image.  But it also caused a 30-second delay=20
> on the host, as predicted.  Now, maybe you don't care about such delays=20
> when you're going to eject the media anyway, but it still seems like a=20
> bad thing to do.

It looks like the prevent_medium_removal flag switching really works better=
 in this case.
>=20
> > > > I have reflected on the rest of your arguments and changed my mind.
> > > > I think that "forced_eject" for a specific lun without interrupting=
 operations would
> > > > really be the best solution. I wrote a simple patch and tested it, =
everything seems
> > > > to work. What do you think about something like this?
> > > >=20
> > > >=20
> > > > static ssize_t fsg_lun_opts_forced_eject_store(struct config_item *=
item,
> > > >                                                const char *page, si=
ze_t len)
> > > > {
> > > >         struct fsg_lun_opts *opts =3D to_fsg_lun_opts(item);
> > > >         struct fsg_opts *fsg_opts =3D to_fsg_opts(opts->group.cg_it=
em.ci_parent);
> > > >         int ret;
> > > >=20
> > > >         opts->lun->prevent_medium_removal =3D 0;
> > > >         ret =3D fsg_store_file(opts->lun, &fsg_opts->common->filese=
m, "", 0);
> > > >         return ret < 0 ? ret : len;
> > > > }
> > > >=20
> > > > CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject);   =20
> > >=20
> > > The basic idea is right.  But this should not be a CONFIGFS option; i=
t=20
> > > should be an ordinary LUN attribute.  For an example, see the definit=
ion of=20
> > > file_store() in f_mass_storage.c; your routine should look very simil=
ar. =20
> >=20
> > Okay, but where this attribute is located in sysfs? How can I use it? =
=20
>=20
> Well, it's going to be in different places depending on what UDC driver=20
> your gadget uses.  On my system I'm using the dummy_udc driver, so the=20
> sysfs "file" attribute is located at:
>=20
> 	/sys/devices/platform/dummy_ucd.0/gadget/lun0/file
>=20
> If instead you're looking at
>=20
> 	/sys/module/g_mass_storage/parameters/file
>=20
> or in some configfs directory, that's the wrong place.  You can eject=20
> the media simply by doing (as root):
>=20
> 	echo >/sys/devices/.../gadget/lun0/file
>=20
> (fill in the "..." appropriately for your system).
>=20
> > Sorry for the stupid question. =20
>=20
> Not at all.

Thanks! Unfortunately I'm using dwc2 driver and it doesn't have any gadget =
parameters
outside of the configfs:

[root@pikvm ~]# find /sys -iname lun0
[root@pikvm ~]# find /sys -iname lun.0
/sys/kernel/config/usb_gadget/kvmd/functions/mass_storage.usb0/lun.0
[root@pikvm ~]#

So in my local case configfs is only way to place forced_eject :(
Could we add both device attrs and configfs file?
