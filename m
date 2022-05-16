Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F3528BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbiEPRXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiEPRXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:23:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E5B369CA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:23:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so21418734wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=iWVGJvbXTQviSVV/WecI92gq1SolbxE/JB6eptTqhB4=;
        b=KLGfWLLdefYI/c/2I/0BXVxCLS0XdXGcnSRQ50BO01GSFrH8jOXJCYIGkJRojxOYfr
         vL3uLvv9sHQkfM9qL/O2SAyVI/4Ei06hko3G47Oyf3oXKJxqU5xitRanleOjESzo0QHR
         9/L9FFooeLwk56MyQdPu3Z0sQ5THVozTkCwvhFY0cLsHtZRSQLkkYBkTRkiH8ASsp68Y
         rEKZWOejM0Mbt6WYhO43HrPFu3omN+FJRogE2ki583naZXs/vbmnyd6n01Y9Qdg9ENcI
         d8tNWGW47/1e+BjWAJjeAGfg3pdcACHoYNhreWUJ22L+VjRf29Xyuc7ivX6AHnPyQiYW
         8EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=iWVGJvbXTQviSVV/WecI92gq1SolbxE/JB6eptTqhB4=;
        b=t/dFDAJgkw6C4pD6Co6QspN+5M7Sw8MmyhMEPNT2XEC5AK67j8f9AtuiX1Jdho1qLI
         6mSRTY9qsx1DKgeuayg/YZPy6esqMDy3e0dnrprkX4rKqurBU7T+HJo6CBsF1BuDsusg
         apCny3XHKv+19kvg99GedI+IAyl52Yc82b9pt7PP8jyqUvqKpuoqtJbjTZ9sA9GrBEG3
         9P4Ce/MuHn4WX+nFgYoTWZub2JpX0cH4Hs+070NGr3IrJQ36wUBEf/514DxmDsJ4O9dU
         TDFqPZtKiYGZhwIT37t68hjiIHZWa9ShzuOMSuhWLz2M3Kj1Uybu0VbmnMsIEgk6mSPV
         jfQA==
X-Gm-Message-State: AOAM530u3ZelDABRQfoIWlpVZ7Rpmj8fE7gGo3t78u4RL3eLZ5TTPKVP
        3znPfrX6U1cJDRJ8KqU9i1o=
X-Google-Smtp-Source: ABdhPJx1fOPMSHY9qfSl5JhzQGkIfyH5Tj+3hvYraG4h/Qp0/wK4zGWt8EsnzkDaJybzzqb10g3UbQ==
X-Received: by 2002:a5d:4c4e:0:b0:20a:d006:79f8 with SMTP id n14-20020a5d4c4e000000b0020ad00679f8mr14510248wrt.600.1652721816613;
        Mon, 16 May 2022 10:23:36 -0700 (PDT)
Received: from [192.168.1.51] ([78.187.39.231])
        by smtp.gmail.com with ESMTPSA id n5-20020adfc605000000b0020c6a524fe0sm10081158wrg.98.2022.05.16.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:23:36 -0700 (PDT)
Message-ID: <a04dce894f7ebee18807467c4f914d88069ab86c.camel@gmail.com>
Subject: Re: [PATCH] Staging: pi433: Don't use ioctl for per-client
 configuration
From:   =?UTF-8?Q?Ya=C5=9Far_Arabac=C4=B1?= <yasar11732@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        alexandre.belloni@bootlin.com, realwakka@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 May 2022 20:23:34 +0300
In-Reply-To: <20220516073329.GJ4009@kadam>
References: <20220515104711.94567-1-yasar11732@gmail.com>
         <20220516073329.GJ4009@kadam>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pzt, 2022-05-16 tarihinde 10:33 +0300 saatinde, Dan Carpenter yazd=C4=B1:
> On Sun, May 15, 2022 at 01:47:11PM +0300, Ya=C5=9Far Arabac=C4=B1 wrote:
> > Currently this driver uses ioctl for reading/writing per-device and
> > per-client configuration. Per-client configuration can be handled
> > by
> > usespace and sent to driver with each write() call. Doing so does
> > not
> > introduce extra overhead because we copy tx config to fifo for each
> > transmit anyway. This way, we don't have to introduce new ioctl's.
> >=20
> > This has not been tested as I don't have access to hardware.
> >=20
> > Signed-off-by: Ya=C5=9Far Arabac=C4=B1 <yasar11732@gmail.com>
>=20
> This commit is confusing and does a number of unrelated things.  It's
> not explained well what the motivation is for the patch.
>=20
> If I remember this correctly, the current API is broken.  It used a
> too small type or something?  People wanted fix it by making
> incompatible changes which would have broken user space.  I had said
> that the right thing would be to not using ioctls at all but instead
> use
> sysfs.
>=20
> So I kind of remember that there was a motivation to get rid of the
> ioctl, but I don't remember what it was and it's not explained here.
>=20

Motivation for this patch is also to get rid of ioctl in favor of more
suitable interfaces.

Currently, driver manages two different kinds of configurations. Per
device configuration is kept inside rx_cfg member of struct
pi433_device. These are parameters for recieving data. They are shared
by all clients using the device. Per-client configuration is kept under
private_data member of struct file. These parameters control
transmitting side of things. They are created for each call to open().

For reading and writing both kinds of configurations, ioctl commands
are used. It would be more fitting to use sysfs for per-device
configuration. On the other hand, using sysfs for per-client
congiguration feels wrong, as it is commonly used for global settings.
Therefore, user space is correct place to handle these in my opinion.
By using sysfs for per-device configuration, and letting user space
handle per-client configuration, we don't have to introduce new ioctl.
This patch does not touch per-device configuration case. It only
attempts to remove ioctl for per-client case.

Currently, when user calls write(), we write 3 things to tx queue.

- Per-client configuration (which is kept in kernel space)
- size of the payload (we get this from size of write call)
- payload itself (we get this from user space buffer)

My proposed solution is for user space to send all of these together
for each call to write() function. It should be trivial to implement
this behaviour as user space library function. This way, we don't have
to manage these on kernel, so it is one less thing to worry about.
Moreover, reading/writing configuration this way does not involve
seperate syscalls.

> I had imagined adding the sysfs configuration along side the ioctl to
> start with and then deleting the ioctl when userspace was updated.=20
> If
> you're saying that we don't need any configuration at all then that's
> great but that has to come from someone who has tested the code.
>=20

Configuration is still needed, just handled differently. I agree that
these should be tested. This patch could possibly be used as starting
point for anyone who has means/desire to test and experiment.

> What is this part of the commit for?
>=20
> > --- a/drivers/staging/pi433/pi433_if.h
> > +++ b/drivers/staging/pi433/pi433_if.h
> > @@ -75,6 +75,8 @@ struct pi433_tx_cfg {
> > =20
> >         __u8                    sync_pattern[8];
> >         __u8                    address_byte;
> > +       __u32                   payload_size;
> > +       __u8                    payload[];
> >  };
>=20

Since my proposed implementation expects (config,payload_size,payload)
to be sent together with each write(), I added these here.

As a final note, replacing ioctl with something else would require
breaking changes at some point. If you think it is too much suffering
for too little to gain, I don't think it is absolutely necessary to do
so. But if people are interested I can make a better patch with less
unrelated changes and more explanations.

Best Regards,
Ya=C5=9Far Arabac=C4=B1
