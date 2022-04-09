Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674AE4FA8EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbiDIOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiDIOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:10:49 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B0825AEF0;
        Sat,  9 Apr 2022 07:08:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b43so14751025ljr.10;
        Sat, 09 Apr 2022 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJ0KyXmA01kKc8AtcTWvVYnzo+r3NxhgxlnzewuuMNU=;
        b=JbKxqHPbdOsL/gzGQ+eKNZ0Wq+MEZtbZbyOgNjTn+3ZfnnAxuk5JL9RDYEbigIvpLv
         GpUNmgiBN0kPAELMLKIvO6FqjUjNOqxnOw1u4SUHT9+QY3YGzaQy/Wv6jSgHHirA9hJ6
         MFwHLIvTrVBgdP2CXwXqXKiezFTQadUjEgCSG4bcfXVv26K8qn6wuU0stlKA79IPKIqf
         R864Q17crO8LeK1npaA+pFJ47Jwjvj41anoGzZND54bCyOjU+Zk/81oinXmvG59vBOPm
         XvkJSk97EqV8Jm3/Ht7FPHsATdHwJ3/o735D3WkJlJXI4XPjbi4EjzJpc5Xb/uYWUOpq
         uIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJ0KyXmA01kKc8AtcTWvVYnzo+r3NxhgxlnzewuuMNU=;
        b=dZT10kAXflARYQHX6TCSmwc+UqRX503MewK+gQlnIZxCb/KwqFj5Q6Wuy57FHTA/pE
         JQgy8+yYHmw4UZVickr2C+dRgaG6JutUtXyoJ4TJlUxX82EAOQSktwDMsUkBpW/hdCH8
         s6YMLLPrChHrmCVzUnGWbNZ4M5PVQxhU4D3ufuVVvxvL368d8Th7DE1D8/R7mocpQupC
         K87/rh0IijzQERlvNdhxIEWZ8DKkoBIBHpJMSM/b5pWbBDZhYWTlRjv1ilkepQTDw4iW
         uluVLbROELOPQUm8iUwt0Kc+st7izQbcs8kcsKu+7B3DoWlwj1/RwzLOQZfMD2eBgZdv
         z+pA==
X-Gm-Message-State: AOAM533uu7yeZakQ5wiG4H1+nOvbPI6XBFykEcKW7WnGrhI2hd9ldWz3
        IDQajvwefZiEMkZOZu4+EDc=
X-Google-Smtp-Source: ABdhPJwqr8fSqgC89RfKRYUdwf5SuszG6I2un1kYTlvpGmr6UOzv6USnHMIQphcpAAyuok34pQHFog==
X-Received: by 2002:a2e:9c03:0:b0:24a:fe64:2c12 with SMTP id s3-20020a2e9c03000000b0024afe642c12mr14460185lji.101.1649513319898;
        Sat, 09 Apr 2022 07:08:39 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id br12-20020a056512400c00b0044a2c454ebcsm2745487lfb.27.2022.04.09.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 07:08:38 -0700 (PDT)
Date:   Sat, 9 Apr 2022 17:08:37 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: break IO operations via
 configfs
Message-ID: <20220409170837.02f0853f@reki>
In-Reply-To: <YlGOOJ9SwkD7WVmX@rowland.harvard.edu>
References: <20220406092445.215288-1-mdevaev@gmail.com>
        <Yk2wvhSTMKTLFK6c@rowland.harvard.edu>
        <20220406195234.4f63cb4a@reki>
        <Yk3TLPKyaQDsnuD4@rowland.harvard.edu>
        <20220406213634.104cae45@reki>
        <Yk8L6b9wEWTjWOg4@rowland.harvard.edu>
        <20220407204553.35cead72@reki>
        <YlBN4Zcn9NYw0PLA@rowland.harvard.edu>
        <20220409115756.4f9b015d@reki>
        <YlGOOJ9SwkD7WVmX@rowland.harvard.edu>
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

=D0=92 Sat, 9 Apr 2022 09:46:32 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Sat, Apr 09, 2022 at 11:57:56AM +0300, Maxim Devaev wrote:
> > =D0=92 Fri, 8 Apr 2022 10:59:45 -0400
> > Alan Stern <stern@rowland.harvard.edu> wrote: =20
> > > > At least there is one situation where the behavior of f_mass_storag=
e differs
> > > > from the behavior of a real drive. What happens when you click on t=
he physical
> > > > "eject" button?   =20
> > >=20
> > > If the host has prevented ejection, nothing happens.  Otherwise the d=
isc=20
> > > gets ejected.
> > >  =20
> > > > Yes, the OS can block this, but the problem is that we don't have
> > > > an "eject" here.   =20
> > >=20
> > > What do you mean?  Writing an empty string to the sysfs "file" attrib=
ute=20
> > > is the virtual analog of pressing the eject button. =20
> >=20
> > But I can't eject the disc event it's not mounted on Linux host. It see=
ms to me
> > it differs from the real drive behavior. =20
>=20
> It sounds like either there's a bug or else you're not doing the right=20
> thing.  Tell me exactly what you do when this fails.

I'm using Raspberry Pi with DWC2. So:
- Connect RPi-based gadget to the Linux host.
- Set image in the "file" attribute.
- Mount gadget's drive on the Linux host.
- Umount it.
- Try to eject using emptying the "file" attribute.
- Get EBUSY error.

>=20
> > > ... =20
> >=20
> > I have reflected on the rest of your arguments and changed my mind.
> > I think that "forced_eject" for a specific lun without interrupting ope=
rations would
> > really be the best solution. I wrote a simple patch and tested it, ever=
ything seems
> > to work. What do you think about something like this?
> >=20
> >=20
> > static ssize_t fsg_lun_opts_forced_eject_store(struct config_item *item,
> >                                                const char *page, size_t=
 len)
> > {
> >         struct fsg_lun_opts *opts =3D to_fsg_lun_opts(item);
> >         struct fsg_opts *fsg_opts =3D to_fsg_opts(opts->group.cg_item.c=
i_parent);
> >         int ret;
> >=20
> >         opts->lun->prevent_medium_removal =3D 0;
> >         ret =3D fsg_store_file(opts->lun, &fsg_opts->common->filesem, "=
", 0);
> >         return ret < 0 ? ret : len;
> > }
> >=20
> > CONFIGFS_ATTR_WO(fsg_lun_opts_, forced_eject); =20
>=20
> The basic idea is right.  But this should not be a CONFIGFS option; it=20
> should be an ordinary LUN attribute.  For an example, see the definition =
of=20
> file_store() in f_mass_storage.c; your routine should look very similar.

Okay, but where this attribute is located in sysfs? How can I use it?
Sorry for the stupid question.

