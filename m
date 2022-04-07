Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED934F8691
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbiDGRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbiDGRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:50:45 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D16522E971;
        Thu,  7 Apr 2022 10:48:38 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x17so1824392lfa.10;
        Thu, 07 Apr 2022 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agXpjK6hwkbSHuLW+3nuC38eZfuydg6+MYj5IHJD/dA=;
        b=ZOjnsxH+JEgTYbpr31a1JoSYzqtTAU/6kTS7HVjLVAYj9b9k1O9DhWFIv3U2FKniuM
         K4/ocnRp/+rIIRQepEd+hN7AX2pER6QVZOvVGDwAEFA8um7HK0BmLB1ctyLqx4cGqYoF
         DOiJwtWEZJRdSh5BPmDrVd2ob/VwMX6ZSSvxDZGZWcpBL0Ny7dyTquYsywZ6g6f1wqRC
         54gn4BfsP9394K4y/taLcjwgmauqVbgoSsMD2Thbgpf2i01/eebDAJdUZ7AckLXXwhQP
         nFfbZ8oYY6xkJH5coYzXBD1aAUWliLIpXoOk1JFsnthP3CsdqqM3iwNtdSb7IsC7/gOE
         XICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agXpjK6hwkbSHuLW+3nuC38eZfuydg6+MYj5IHJD/dA=;
        b=Ic4ft/imLXTXNRjYHrlkfLCqqVrO0ecqq2ApVIEvI+FataC92ei1OhsD/SYsR0M9Dp
         L4lFp7T+xV5/pr7DKCfnxuBQElYCOPnxbD/p5GjOTvNa2YLg7LXGYtiuqkwrLmPQfKI6
         7s4KAC1oIzL2bmWdOo9g2mtFVnFug1WMWVwnY5zAK7fR3/f1Z9hP5EyZmlOgf1ZUawoT
         jwLbqfBYOuIXVc9ydU8rDhdzagIYXzoBwyRXxOhNYTJgAqHWKmF74BcWhRQ0b6jzmp7w
         zhpqfYo7dUOw2qYY3X9P1RN7gsuLWvoGOxFCF3Q/szIi9GD+y2f3QmwjzeMBd46NEUEp
         rvzA==
X-Gm-Message-State: AOAM530fKbh7RRAfNH9zNMQg4NcARezu88zpZsRtD5twtOpms1vRoSrb
        etOBAAmTa3j2ZjL8Q/J29rE=
X-Google-Smtp-Source: ABdhPJzhrJ8o1BKfLE8sMalPqJQ+0csad/JLloRu3BOeKzazeUbAZCwFTQlZwdwZQw3DkPXhJC0Eow==
X-Received: by 2002:a19:8c4b:0:b0:44a:b6a4:4873 with SMTP id i11-20020a198c4b000000b0044ab6a44873mr9896391lfj.549.1649353656669;
        Thu, 07 Apr 2022 10:47:36 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id bu20-20020a056512169400b0043eaf37af75sm2226966lfb.199.2022.04.07.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:47:25 -0700 (PDT)
Date:   Thu, 7 Apr 2022 20:47:13 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <20220407204553.35cead72@reki>
In-Reply-To: <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
References: <20220406092445.215288-1-mdevaev@gmail.com>
        <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
        <20220406195234.4f63cb4a@reki>
        <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
        <20220406213634.104cae45@reki>
        <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Thu, 7 Apr 2022 12:06:01 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, Apr 06, 2022 at 09:36:34PM +0300, Maxim Devaev wrote:
> > =D0=92 Wed, 6 Apr 2022 13:51:40 -0400
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> >  =20
> > > On Wed, Apr 06, 2022 at 07:52:34PM +0300, Maxim Devaev wrote: =20
> > > > > It's not clear to me how breaking I/O operations allows you to do=
 a=20
> > > > > "force eject".  It seems that what you would need is something li=
ke=20
> > > > > fsg_store_file() that omits the curlun->prevent_medium_removal ch=
eck.
> > > > > Interrupting a lengthy I/O operation doesn't really have anything=
 to do=20
> > > > > with this.   =20
> > > >=20
> > > > Perhaps I chose the wrong path, it's just how my userspace code wor=
ks now.
> > > > If the drive is connected to a Linux host, then in order to clear
> > > > the "file" and extract the image, I sent a SIGUSR1 signal to the "f=
ile-storage"
> > > > thread. This interrupted long IO operations, reset curlun->prevent_=
medium_removal
> > > > and I got the ability to extract.   =20
> > >=20
> > > Oh, I see.  That's kind of an unintended side effect of not calling=20
> > > raise_exception().
> > >=20
> > > And while it does interrupt long I/O operations, it does so in=20
> > > non-sanctioned way.  To the host it will appear as though the gadget'=
s=20
> > > firmware has crashed, since the gadget will stop sending or receiving=
=20
> > > data.  Eventually the host will time out and reset the gadget.
> > >=20
> > > Maybe that's the sort of thing you want, but I rather doubt it. =20
> >=20
> > It's hard to say how it actually should work in case of force removing.
> > At least the currect approach with SIGUSR1 is really working on thousan=
ds
> > systems and with Linux, Mac and Windows. I believe that the criterion
> > of the experiment is quite important here. I know of several other util=
ities
> > that use SIGUSR1 for similar purposes. =20
>=20
> This merely means that the current unintended behavior of userspace USR1=
=20
> signals must not be changed.  But it doesn't mean you have to continue=20
> to rely on that behavior; you can implement something better.

So I suggest break_io :) I haven't come up with anything better.

> > > > Will masking the curlun->prevent_medium_removal flag be enough?   =
=20
> > >=20
> > > I think so.  But it will be blocked to some extent by long-running I/=
O=20
> > > operations, because those operations acquire the filesem rw-semaphore=
=20
> > > for reading.
> > >=20
> > > More precisely, each individual command holds the rw-semaphore.  But =
the=20
> > > semaphore is dropped between commands, and a long-running I/O operati=
on=20
> > > typically consists of many separate commands.  So the blocking may be=
=20
> > > acceptable. =20
> >=20
> > It is very important for KVM-over-IP to be able to command "turn it off=
 immediately". =20
>=20
> Why is this?  A lot of actual devices (DVD drives, for instance) don't=20
> give you the ability to eject the media when the host has prevented it. =
=20
> Why should f-mass-storage be different?

The DVD drive has the ability to physically eject the disc. It's not too go=
od
for the drive itself, but it's just there. We can also urgently remove
the USB flash drive.

At least there is one situation where the behavior of f_mass_storage differs
from the behavior of a real drive. What happens when you click on the physi=
cal
"eject" button? Yes, the OS can block this, but the problem is that we don'=
t have
an "eject" here. If I connect the gadget to the Linux host and don't even m=
ount
the image, Linux won't let me change the image in the "file", since the gad=
get
will be constantly busy with some IO.

But I believe creating a virtual "eject" button is a separate task that
does not depend on "break_io".

> > In this context, I would prefer "break_io" rather than "allow_force_rem=
ove". =20
>=20
> Okay.  But what about the 30-second host timeout I mentioned above? =20
> Does this actually happen with your approach?  It seems like the kind of=
=20
> thing you don't want in a "turn it off immediately" situation.  (I=20
> haven't tried doing this myself -- maybe I should.)

Neither I nor my users noticed any problems related to this. After extracti=
ng
the image using SIGUSR1/"file", I can just assign a new "file"image
and everything will work.

> > > > > You should not call send_sig_info() directly; instead call=20
> > > > > raise_exception().  It already does the work you need (including =
some=20
> > > > > things you left out).   =20
> > > >=20
> > > > raise_exception() assumes the setting of a new state, and I did not=
 want to do this,
> > > > since the same does not happen when throwing a signal from userspac=
e.   =20
> > >=20
> > > Userspace isn't supposed to send the USR1 signal, only the INT, TERM,=
 or=20
> > > KILL signals.  USR1 is supposed to be reserved for the driver's inter=
nal=20
> > > use.  Unfortunately, AFAIK there's no way to allow the driver to send=
 a=20
> > > signal to itself without also allowing the signal to be sent by=20
> > > userspace.  :-( =20
> >=20
> > It's funny that you actually helped me solve my problem thanks to this =
undocumented
> > behavior. If it were not for the ability to send a signal, I would not =
be able to make
> > the necessary code, and my software would always be waiting for the com=
pletion of IO.
> >=20
> > So here I am grateful to you - I didn't have to patch the kernel a few =
years ago,
> > and now I just want to turn it into a clear feature :)
> >=20
> > Given the needs of the userspace code, maybe the suggested "break_io"
> > would be the best choice? =20
>=20
> It sounds like what you really want is a combination of both "interrupt=20
> I/O" and "forced eject".

Indeed. But I didn't want to introduce some complex entities into the "file=
" attribute
or make magic prefixes for the image name or something. So I suggested
"echo > break_io && echo > file". This will not break the current behavior =
of the drive.

> > > And sending the signal _does_ set a new state, whether you intended t=
o=20
> > > or not.  Although in this case, the new state is always the same as t=
he=20
> > > old state, i.e., FSG_STATE_NORMAL. =20
> >=20
> > So I could call raise_exception(fsg->common, FSG_STATE_NORMAL) instead =
of sending
> > the signal from break_io handler. There will be a slight difference
> > in exception_req_tag and exception_arg, but it does not seem to cause a=
ny side effects.
> > Please correct me if I'm wrong. =20
>=20
> In fact, the best approach would be to introduce a new state (let's call=
=20
> it FSG_STATE_FORCED_EJECT) with priority just above
> FSG_STATE_ABORT_BULK_OUT.  You would call raise_exception with=20
> FSG_STATE_FORCED_EJECT, not FSG_STATE_NORMAL.  handle_exceptions() would=
=20
> treat this state partially like ABORT_BULK_OUT in that it would avoid=20
> resetting all the LUN data values and would call send_status_common() if=
=20
> a command had been underway.  But in addition it would do the forced=20
> eject.

Do you mean something like this?

    if (old_state !=3D FSG_STATE_ABORT_BULK_OUT) {
        for (i =3D 0; i < ARRAY_SIZE(common->luns); ++i) {
            curlun =3D common->luns[i];
            if (!curlun)
                continue;
            curlun->prevent_medium_removal =3D 0;
            if (old_state !=3D FSG_STATE_FORCED_EJECT) {
                curlun->sense_data =3D SS_NO_SENSE;
                curlun->unit_attention_data =3D SS_NO_SENSE;
                curlun->sense_data_info =3D 0;
                curlun->info_valid =3D 0;
            }
        }
    }

> Also, the sysfs routine should be careful to see whether the command=20
> currently being executed is for the LUN being ejected.  I guess you=20
> have never tried issuing your USR1 signal to a mass-storage gadget=20
> running more than one LUN.  If you did, you would find that it clears=20
> the prevent_medium_removal flag for all of them, not just the one that=20
> you wanted.

I haven't tried it, but I figured it out along the way when I discovered
the SIGUSR1 feature. I perceive it as something that should work that way.
Like, we hit the whole device.
