Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA39513491
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346532AbiD1NM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344796AbiD1NMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:12:52 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E6B0A67
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:09:37 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y3so3350463qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=s18GDO57PNAgRtMK8C6iNS6vfqL/ISq2KJZGUSJ2Tyo=;
        b=ughLqVdfWYzKzui0OFORJzcx5HA4uYZ7/2xgFrSgtMBgsEMXpOMvBDMBVqiHzZzOqo
         z4qXmMMNFU0iE3E9X/hmtTtLoTpl7XJxck+ZognpaBrA9pgHE0XrrF9BQGAp1eZvA8X9
         4yw01krYIybyHtlnTajc+FUoT/IMaBX3NJIw6XbP1X2mxanRnEqRv6yeMx6fh83fnGcL
         kTdzVjWFoVnZJhGUwk3+BhxdUGqcuU4xEQGy5o/Dhjzm029DPywE8G/3sWuQPRHNdYo/
         fgh6z+HgiqtGweMTMQ4K+0UHQHHGhsdf6tvZDB0MablUirVqQpKKwVtEd1BtC82F15Rz
         dACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=s18GDO57PNAgRtMK8C6iNS6vfqL/ISq2KJZGUSJ2Tyo=;
        b=diGyAhS/9xtjG2ohi/aBf5AtYAEtR7/YGTS7cd9lLxTxpSwsqRQDSJv5BhPxnZySDd
         l82gzrdeiZaU6nIt6OooO46SuskMvEnwjdqi/otjGJtbmDgmI5ZtvbEeXFL6c0uQzqI5
         xZWI9rKqsC6GHlW837jE7Q1aXqwXBlIc889FYdL5mP8SBDO+XMjYM4CSoyEnhUWHFVt8
         KqFQjsqp/kBDlf4VvvlLfZO4EIAYFeISnT4tZSYI304UvRhdf7E3jmMLSpxXD0wuxvuH
         AU8bB/Dp7L+yc6Vmi1deKrbMHYaTW6cDIu6LNOJl9JObx6mhGWUtVJG/UGanfB/E6vTX
         eZmQ==
X-Gm-Message-State: AOAM5325T8YcaNeFEDgxtIpICUeg6zqdX2w6BLWzVe6cgGeIBS8SQLgs
        k2HkZ3MKSbE2UZNS8YmoS52zag==
X-Google-Smtp-Source: ABdhPJy3PL9wj4LxTpDUJPtDjChVZiZoa0P6DuFBNAcegYF/81rEJYf19o3Rdp6oi/IqiOtldPzvew==
X-Received: by 2002:ac8:5a0a:0:b0:2f3:64a5:5ee3 with SMTP id n10-20020ac85a0a000000b002f364a55ee3mr15283649qta.505.1651151377040;
        Thu, 28 Apr 2022 06:09:37 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id b11-20020a05622a020b00b002f38fe59f03sm347538qtx.18.2022.04.28.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:09:36 -0700 (PDT)
Message-ID: <d8de72b8c9c6252e2ea66d790e4a5c938050fb0a.camel@ndufresne.ca>
Subject: Re: [PATCH v4 03/24] media: videobuf2-v4l2: Warn on holding buffers
 without support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Apr 2022 09:09:35 -0400
In-Reply-To: <4b7a3d71-629b-56d6-fdc7-d07682390fd2@xs4all.nl>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
         <20220426125751.108293-4-nicolas.dufresne@collabora.com>
         <CAAFQd5C6qmxmn4y=cx5Mtb3p8vcTAFm6Jfc1vMAE8+x9iwhDZg@mail.gmail.com>
         <a78920881b2ffaf1fba04bc9ebeda591ec0dfd87.camel@ndufresne.ca>
         <4b7a3d71-629b-56d6-fdc7-d07682390fd2@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 28 avril 2022 =C3=A0 08:12 +0200, Hans Verkuil a =C3=A9crit=C2=A0:
> On 27/04/2022 17:08, Nicolas Dufresne wrote:
> > Le mercredi 27 avril 2022 =C3=A0 13:31 +0900, Tomasz Figa a =C3=A9crit=
=C2=A0:
> > > Hi Nicolas, Sebastian,
> > >=20
> > > On Tue, Apr 26, 2022 at 9:58 PM Nicolas Dufresne
> > > <nicolas.dufresne@collabora.com> wrote:
> > > >=20
> > > > From: Sebastian Fricke <sebastian.fricke@collabora.com>
> > > >=20
> > > > Using V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF flag without specifying th=
e
> > > > subsystem flag VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF, results i=
n
> > > > silently ignoring it.
> > > > Warn the user via a debug print when the flag is requested but igno=
red
> > > > by the videobuf2 framework.
> > > >=20
> > > > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > > > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > > > Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > > ---
> > > >  drivers/media/common/videobuf2/videobuf2-v4l2.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >=20
> > >=20
> > > Thanks for the patch. Please see my comments inline.
> > >=20
> > > > diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/driv=
ers/media/common/videobuf2/videobuf2-v4l2.c
> > > > index 6edf4508c636..812c8d1962e0 100644
> > > > --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > > > +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > > > @@ -329,8 +329,13 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2=
_buffer *vb, struct v4l2_buffer *b
> > > >                  */
> > > >                 vbuf->flags &=3D ~V4L2_BUF_FLAG_TIMECODE;
> > > >                 vbuf->field =3D b->field;
> > > > -               if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M=
_HOLD_CAPTURE_BUF))
> > > > +               if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M=
_HOLD_CAPTURE_BUF)) {
> > > > +                       if (vbuf->flags & V4L2_BUF_FLAG_M2M_HOLD_CA=
PTURE_BUF)
> > > > +                               dprintk(q, 1,
> > > > +                                       "Request holding buffer (%d=
), unsupported on output queue\n",
> > > > +                                       b->index);
> > >=20
> > > I wonder if we shouldn't just fail such a QBUF operation. Otherwise
> > > the application would get unexpected behavior from the kernel.
> > > Although it might be too late to do it now if there are applications
> > > that rely on this implicit ignore...
> >=20
> > In the context of this patchset, the statu quo seems to be the logical =
thing to
> > do. We can raise this up in a separate thread. The side effect is of co=
urse
> > confusing for developers, but it is hard for me to tell if a hard failu=
re may
> > break an existing software.
>=20
> I am leaning towards returning an error as well. It makes no sense to try
> to hold on to a buffer when this is not supported.
>=20
> I also thought that it should be enough to rely on the core to clear the
> flag upon return if it isn't supported, but looking through the vb2 core =
code
> it looks like we're not clearing unknown flags at all, so running this fo=
r
> older kernels that do not support holding at all will not clear the flag
> either.
>=20
> The handling for flags in vb2 can be improved, I think I'll take a look a=
t
> that myself.
>=20
> I plan to merge this series soon, but will skip this patch for now.

Ok, no problem. For me, as long as we do something about it, since it was n=
ot
obvious and time consuming to debug.

regards,
Nicolas

>=20
> Regards,
>=20
> 	Hans
>=20
> >=20
> > regards,
> > Nicolas
> >=20
> > >=20
> > > Best regards,
> > > Tomasz
> >=20
>=20

