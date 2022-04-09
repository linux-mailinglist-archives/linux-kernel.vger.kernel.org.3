Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CED4FA619
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiDIJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiDIJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:00:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5320923BDE;
        Sat,  9 Apr 2022 01:58:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u7so1553115lfs.8;
        Sat, 09 Apr 2022 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ugBxmjpEkz6OGkNDpns8lmpiOPbxLWOThWTF0EVsTM=;
        b=nKn0DMkbrRNBmOACOREi7d4S5gRfOWPHyFx2eNGSZyH6I6zPLqVCcoxECKsjyJcTPw
         FziZxDquVtKijnqLT9QjmBYJXvAi4O+evgoSnSdy2FaUp9XSBudQ4sOiToIaLHOP2AO4
         3SXCYsROURNJ9Veoch/DVLDZ3NKvgW1w6PHkuuxwfjQNkIWlK8ot0UPpLqv+1MzDZB/7
         XIOwKhp3fOvttDz6q3QidRgn7pwfxPxQ3ErxThp5k+MNyHdmV/7qmjEGHFITmF30I8Ou
         7ffLdLG3BGyYCryu/O6/kjndYcSnRTye4GVVWRi/s18nI8KFQVFovlCz5+LRS03otizz
         blBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ugBxmjpEkz6OGkNDpns8lmpiOPbxLWOThWTF0EVsTM=;
        b=Y9LrCEHVeilOlUnTyDQ6gV3MoBbAvOD9I8DmMM1vUteeCKsNDcDeVEg/qyldOAYV7L
         3ZeNOaDx7SBa1McPdtFFy8wudLfF6xQboP7VgTNw+zv7n94uxXIMMtkjhqXHtgD4IRV9
         ibIBShw4NX3rLN4t0HK84dUIzfRhjC51LD3UB+yEzbMVenvA6KN9Qsn6rCJwTEa5eo0h
         7dvezxB4GxXn/trWmHzqCgtFW+fU+gq1hN/Nu21gENDbn2NOgejTp626oefRKYvVkeOU
         m/BXOACT8wkPD3GVyDXf7pyqkUQv7jaR+emLN27wuifAAouSsuZXp9emW/8z7iZ8Htje
         P8KA==
X-Gm-Message-State: AOAM533JSeAyHhrLHx9VRckz+43oxcqchHKDxyAGKGCjFPXBx0DtjYyX
        4gctOBt/hkV+pUErSkGcxJA=
X-Google-Smtp-Source: ABdhPJyXpLKAgLvipO9J90s11C24nH2BsseSQQCAD0zbOuq9TF2KNYx/GEefQm8+U6v1oskP3l70ew==
X-Received: by 2002:a05:6512:b90:b0:46b:81d5:4eef with SMTP id b16-20020a0565120b9000b0046b81d54eefmr5626170lfv.683.1649494681278;
        Sat, 09 Apr 2022 01:58:01 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id b26-20020a056512061a00b0044a57b38530sm2680793lfe.164.2022.04.09.01.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 01:58:00 -0700 (PDT)
Date:   Sat, 9 Apr 2022 11:57:56 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <20220409115756.4f9b015d@reki>
In-Reply-To: <YlBN4Zcn9NYw0PLA@rowland.harvard.edu>
References: <20220406092445.215288-1-mdevaev@gmail.com>
        <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
        <20220406195234.4f63cb4a@reki>
        <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
        <20220406213634.104cae45@reki>
        <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
        <20220407204553.35cead72@reki>
        <YlBN4Zcn9NYw0PLA@rowland.harvard.edu>
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

=D0=92 Fri, 8 Apr 2022 10:59:45 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, Apr 07, 2022 at 08:47:13PM +0300, Maxim Devaev wrote:
> > =D0=92 Thu, 7 Apr 2022 12:06:01 -0400
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> >  =20
> > > On Wed, Apr 06, 2022 at 09:36:34PM +0300, Maxim Devaev wrote: =20
> > > > =D0=92 Wed, 6 Apr 2022 13:51:40 -0400
> > > > Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >    =20
> > > > > On Wed, Apr 06, 2022 at 07:52:34PM +0300, Maxim Devaev wrote:   =
=20
> > > > > > > It's not clear to me how breaking I/O operations allows you t=
o do a=20
> > > > > > > "force eject".  It seems that what you would need is somethin=
g like=20
> > > > > > > fsg_store_file() that omits the curlun->prevent_medium_remova=
l check.
> > > > > > > Interrupting a lengthy I/O operation doesn't really have anyt=
hing to do=20
> > > > > > > with this.     =20
> > > > > >=20
> > > > > > Perhaps I chose the wrong path, it's just how my userspace code=
 works now.
> > > > > > If the drive is connected to a Linux host, then in order to cle=
ar
> > > > > > the "file" and extract the image, I sent a SIGUSR1 signal to th=
e "file-storage"
> > > > > > thread. This interrupted long IO operations, reset curlun->prev=
ent_medium_removal
> > > > > > and I got the ability to extract.     =20
> > > > >=20
> > > > > Oh, I see.  That's kind of an unintended side effect of not calli=
ng=20
> > > > > raise_exception().
> > > > >=20
> > > > > And while it does interrupt long I/O operations, it does so in=20
> > > > > non-sanctioned way.  To the host it will appear as though the gad=
get's=20
> > > > > firmware has crashed, since the gadget will stop sending or recei=
ving=20
> > > > > data.  Eventually the host will time out and reset the gadget.
> > > > >=20
> > > > > Maybe that's the sort of thing you want, but I rather doubt it.  =
 =20
> > > >=20
> > > > It's hard to say how it actually should work in case of force remov=
ing.
> > > > At least the currect approach with SIGUSR1 is really working on tho=
usands
> > > > systems and with Linux, Mac and Windows. I believe that the criteri=
on
> > > > of the experiment is quite important here. I know of several other =
utilities
> > > > that use SIGUSR1 for similar purposes.   =20
> > >=20
> > > This merely means that the current unintended behavior of userspace U=
SR1=20
> > > signals must not be changed.  But it doesn't mean you have to continu=
e=20
> > > to rely on that behavior; you can implement something better. =20
> >=20
> > So I suggest break_io :) I haven't come up with anything better. =20
>=20
> But breaking an I/O doesn't do all that you want.  That is, interrupting =
an=20
> I/O request (causing an executing command to terminate early) doesn't in=
=20
> itself change the prevent/allow status.  Those are two separate operation=
s. =20
> The fact that sending a USR1 signal does both is merely a coincidence.
>=20
> Furthermore, it's not clear just what you mean when you say KVM needs to=
=20
> "turn it off immediately".  How soon is "immediately"?  Even a USR1 signa=
l=20
> doesn't work instantaneously.  You may find that a forced eject without a=
n=20
> I/O interruption works quickly enough.

Yes, you're right. I need to focus on forced eject operation.

> > > > > > Will masking the curlun->prevent_medium_removal flag be enough?=
     =20
> > > > >=20
> > > > > I think so.  But it will be blocked to some extent by long-runnin=
g I/O=20
> > > > > operations, because those operations acquire the filesem rw-semap=
hore=20
> > > > > for reading.
> > > > >=20
> > > > > More precisely, each individual command holds the rw-semaphore.  =
But the=20
> > > > > semaphore is dropped between commands, and a long-running I/O ope=
ration=20
> > > > > typically consists of many separate commands.  So the blocking ma=
y be=20
> > > > > acceptable.   =20
> > > >=20
> > > > It is very important for KVM-over-IP to be able to command "turn it=
 off immediately".   =20
> > >=20
> > > Why is this?  A lot of actual devices (DVD drives, for instance) don'=
t=20
> > > give you the ability to eject the media when the host has prevented i=
t. =20
> > > Why should f-mass-storage be different? =20
> >=20
> > The DVD drive has the ability to physically eject the disc. =20
>=20
> You mean by sticking an unfolded paperclip into the manual-eject hole?

Yes.

> >  It's not too good
> > for the drive itself, but it's just there. We can also urgently remove
> > the USB flash drive. =20
>=20
> Removing a USB flash drive is not a media-eject operation; it's a=20
> disconnect operation.  (That is, it removes the entire device, not just t=
he=20
> media.)  By contrast, taking an SD card out from a USB card reader _is_ a=
n=20
> example of a media ejection.  But card readers do not claim to support th=
e=20
> prevent/allow mechanism.
>=20
> > At least there is one situation where the behavior of f_mass_storage di=
ffers
> > from the behavior of a real drive. What happens when you click on the p=
hysical
> > "eject" button? =20
>=20
> If the host has prevented ejection, nothing happens.  Otherwise the disc=
=20
> gets ejected.
>=20
> > Yes, the OS can block this, but the problem is that we don't have
> > an "eject" here. =20
>=20
> What do you mean?  Writing an empty string to the sysfs "file" attribute=
=20
> is the virtual analog of pressing the eject button.

But I can't eject the disc event it's not mounted on Linux host. It seems t=
o me
it differs from the real drive behavior.

> ...

I have reflected on the rest of your arguments and changed my mind.
I think that "forced_eject" for a specific lun without interrupting operati=
ons would
really be the best solution. I wrote a simple patch and tested it, everythi=
ng seems
to work. What do you think about something like this?


static ssize_t fsg_lun_opts_forced_eject_store(struct config_item *item,
                                               const char *page, size_t len)
{
        struct fsg_lun_opts *opts =3D to_fsg_lun_opts(item);
        struct fsg_opts *fsg_opts =3D to_fsg_opts(opts->group.cg_item.ci_pa=
rent);
        int ret;

        opts->lun->prevent_medium_removal =3D 0;
        ret =3D fsg_store_file(opts->lun, &fsg_opts->common->filesem, "", 0=
);
        return ret < 0 ? ret : len;
}

CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject);


If you find this acceptable, I will test this patch on my users to make sure
that its behavior meets our expectations.
