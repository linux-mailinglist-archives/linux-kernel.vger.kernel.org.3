Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F25A7F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiHaNqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiHaNqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:46:13 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CD2B193;
        Wed, 31 Aug 2022 06:45:09 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id n125so14647001vsc.5;
        Wed, 31 Aug 2022 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ACBufhRCmNobOBx3xuNTiZdfWSZDve3HUA73HlNYNKk=;
        b=Iz++nKzwy0wNqjxVcgAKJtVF4fJfLqOLDKwBI4WKoAd1dfqgnkH1Ck64ytng/gV+92
         TkZfPuuTUqSN+aFyxDbWDAM2LHD2tt3dDproFKAQFy4eG0EhhfilC6Vk1Sr7RDTIAyVE
         aVpTpvljBLcDGsvYx6eqICLk7Xatq2/pzDkXz78D8R8VajQ/0GCws71OPRgWf/aQqojH
         lcTTbuQ73sPKvpUAFiwQteu92j3kfjIWM9Spd0nMWVO3tQQBnpU1B73og3zNv3L6Fwh4
         YKz4rdmsOYRGQBDeT9+EdDdaZ7E8pRwt569mxl4L0+KkLeAQoVoi/TrwXR3EISeH5uZu
         1ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ACBufhRCmNobOBx3xuNTiZdfWSZDve3HUA73HlNYNKk=;
        b=0Px77TraLuiOKmFpFipzxCKF+J5ScebZFUh5+knkgyPxNELipEF/uW5RhDR/VRiosH
         mcAqY8jpd0cP3/EBOFc29KXW26EvkxbrOpxFiZz2S05qOhj6T0L+ttrqHWRhcKwVK5uK
         xcv6VTTgYgJjP8ld+HbZ3b+UWD+Pz2Bl+WpmKavWca03EPwHF/SPnzTSs4PFBaadRvI0
         rb6J9jNBMfEf7aBLj9cX6ROV2o4xOA3SHScWqnPzb87BBxZJwVojVKvNhdJt4Y+pBnzo
         iQFzzLBcz6Cl5ZPBUzXdiZK8TF/VkpLIaLEXtjSGL5T+Jfl3zXpbwMFTSN4mazQ8GxAi
         SA2A==
X-Gm-Message-State: ACgBeo2LqdVEiTNZzjA179SyLlaAlq0PFf4MXn5Eym8TyXIhxqvUd7qa
        3dcsvkNvGmvkn8mONqtqckv6UXrIyYxreYaWgko=
X-Google-Smtp-Source: AA6agR6ld9ZeBHZhGptKsrN5h/DLHxjEk2MDen4BYT2z+GSMHz8FjBFdFbKi7NT6or80uuh8YIVx6T9GUWQ6DggJBpk=
X-Received: by 2002:a67:dd04:0:b0:392:96d5:37e with SMTP id
 y4-20020a67dd04000000b0039296d5037emr2339035vsj.44.1661953508602; Wed, 31 Aug
 2022 06:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
 <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
 <165590120140.1149771.2257818527859865760@Monstersaurus> <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
 <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com>
 <CANXPkT4qYOYPL+F=-Pi_NbQErq9WwrR-M-BHe=gP9Ay4bSs+=w@mail.gmail.com> <CANXPkT5=ryAFvb1cO+Wb0CQYmytwedS2dqVTYqt2Km1fkK4w9Q@mail.gmail.com>
In-Reply-To: <CANXPkT5=ryAFvb1cO+Wb0CQYmytwedS2dqVTYqt2Km1fkK4w9Q@mail.gmail.com>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Wed, 31 Aug 2022 22:45:00 +0900
Message-ID: <CANXPkT7vt8gq5UO4OXK2pTUyyB102ANJ5i9s92AW+a3rAioMog@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     Hans Petter Selasky <hps@selasky.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Cc:     0215yys@hanmail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Can you share how this patch is going ?

2022=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:55, =
=EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> Dear All,
>
> Can you pay your attention to this patch ?
> This is a very simple modification.
> But, too much time has already passed since I sent the first E-mail.
>
> 2022=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:04, =
=EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
> >
> > Dear All.
> > Too much time has already passed since I first sent this Email.
> > Can you share how this patch is going ?
> >
> > 2022=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:1=
1, =EC=9C=A0=EC=9A=A9=EC=88=98 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> > >
> > > Dear Kieran Bingham
> > >
> > > I sent E-mail again by Linux terminal by using the command " ... git
> > > send-email .."
> > > I believe that you will surely get the diff file.
> > >
> > > Thank you
> > >
> > > 2022=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 1=
0:12, Hans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> > > >
> > > > Hi Kieran,
> > > >
> > > > The consumed variable should not be negative. This bug has been the=
re
> > > > since the beginning of the GIT at Linux from what I can see.
> > > >
> > > > +1
> > > >
> > > > --HPS
> > > >
> > > >  From 108c6acb2cc4bc4314b96f6f254a04b2873a096c Mon Sep 17 00:00:00 =
2001
> > > > From: YongSu Yoo <yongsuyoo0215@gmail.com>
> > > > Date: Sun, 22 May 2022 04:53:12 +0000
> > > > Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffe=
r.c
> > > >
> > > > Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
> > > >
> > > > The function dvb_ringbuffer_pkt_next in
> > > > /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c,
> > > > which searches the idx of the next valid packet in the ring
> > > > buffer of the ca->slot_info[slot].rx_buffer at
> > > > /linux-next/drivers/media/dvb-core/dvb_ca_en50221.c,
> > > > has the following problem.
> > > > In calculating the amounts of the consumed address of the ring
> > > > buffer, if the read address(rbuf->pread) of the ring buffer is
> > > > smaller than the idx, the amounts of the searched address
> > > > should be (idx - rbuf->pread),
> > > > whereas if the read address(rbuf->pread) of the ring buffer is
> > > > larger than the idx, the amounts of the consumed address should
> > > > be (idx - rbuf->pread + rbug->size). But there exists an
> > > > incorrect logic that the rbug-size was not properly added on
> > > > (idx - rbug->pread) in the later case. With this commit, we
> > > > fixed this bug.
> > > > ---
> > > >   drivers/media/dvb-core/dvb_ringbuffer.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c
> > > > b/drivers/media/dvb-core/dvb_ringbuffer.c
> > > > index d1d471af0636..7d4558de8e83 100644
> > > > --- a/drivers/media/dvb-core/dvb_ringbuffer.c
> > > > +++ b/drivers/media/dvb-core/dvb_ringbuffer.c
> > > > @@ -335,7 +335,9 @@ ssize_t dvb_ringbuffer_pkt_next(struct
> > > > dvb_ringbuffer *rbuf, size_t idx, size_t*
> > > >                 idx =3D (idx + curpktlen + DVB_RINGBUFFER_PKTHDRSIZ=
E) % rbuf->size;
> > > >         }
> > > >
> > > > -       consumed =3D (idx - rbuf->pread) % rbuf->size;
> > > > +       consumed =3D (idx - rbuf->pread);
> > > > +       if (consumed < 0)
> > > > +               consumed +=3D rbuf->size;
> > > >
> > > >         while((dvb_ringbuffer_avail(rbuf) - consumed) >
> > > > DVB_RINGBUFFER_PKTHDRSIZE) {
> > > >
> > > > --
> > > > 2.17.1
