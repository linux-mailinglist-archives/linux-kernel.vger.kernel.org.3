Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF93566FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiGENvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGENvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:51:17 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BDC242
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:25:47 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g1so8631460qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=HguDNM2ryvAwNvVw3X1nI4XYjogH/9AJf4v+v8SPiNI=;
        b=x5yYdvsCXmmpnDNQl6naFlMQS/XRzVGIgeWc3mM+T8ojt0HUsx3I/0C3QQOgxcxjuu
         eWmplPF2CphWovJNTR+eM3fzJw4LWakoEBBftPkKE16eO/3hIMGeA5KSzD4WzDI6CkLq
         qmj/lTzWFtbfjk0cRznfTV29uqA/FGSCN7xoJ9CNoYG+Zx6C03bc8ogsKCk3/fr+ncpz
         dwPmPs/aYBdU3juKCgoH+c8Macu89wunr9nPQdb500ER4801Nb3lWsojMbpNv4HVXNZ+
         WY1khmc6o99lem14pH93q/kJ2LGDvcqERTysOIvnDdLQUDIaMPOh/3a2kWiEYNBJt72P
         HqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=HguDNM2ryvAwNvVw3X1nI4XYjogH/9AJf4v+v8SPiNI=;
        b=RBU/XP1G/qrAvVI8ohX1bWEYZGQyC8HjelDu6A2yGKA7MpZZNaBhFZt0qEnULrA3xF
         hyWKAPTFPJIa3rUZWkKkrebVF0twGEKVgYkXsMCRxXs9LlYTJ7v2d+6ScQ7RTGGkdd3Q
         Zbwcwp8gfU4osFfbxTBwNxzMNfPNcJhgzcy+M/eaU0Ya4nQNKBBWb7aMqBSyKfXH/9fo
         DkIff8dpdXbNDV7MHCS5loqQr3cjkYNVaphWXgdbMXTVNvVe7waFJk266R1RXX5+bFg5
         7ZyuALU211FIQo8TRgRNWN2Ll3jt5lcDbXaa+n7Y+oGZSO9Bq5Kf0sOXjYM0uDlzx8wc
         UJ6w==
X-Gm-Message-State: AJIora9p9h27xdOEoKQ6U/GkCDliTBNE9X29INCo1nNAj4an0pptAPjj
        W8BP9KXFDE9nJL1EeHPjyucl9w==
X-Google-Smtp-Source: AGRyM1unglZsJhJldcMdtSkf5ZhX/veAVjhQpvw4NWTnuEx/5DV1Gt52xS0AcdDfqVPRxC8uD780IQ==
X-Received: by 2002:a37:db11:0:b0:6ae:f350:cbe0 with SMTP id e17-20020a37db11000000b006aef350cbe0mr23298323qki.196.1657027546710;
        Tue, 05 Jul 2022 06:25:46 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id de16-20020a05620a371000b006b46997c0a9sm4244131qkb.72.2022.07.05.06.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:25:45 -0700 (PDT)
Message-ID: <61e26a184b87dea6b17d3ba7c4437da29486e167.camel@ndufresne.ca>
Subject: Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_CODECCONFIG flag
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Ming Qian <ming.qian@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 05 Jul 2022 09:25:43 -0400
In-Reply-To: <CAPY8ntC8-d7zupr=mNHdc053RV1Z1yjnmqbV=13AaT2gmMSrKw@mail.gmail.com>
References: <20220628021909.14620-1-ming.qian@nxp.com>
         <a834a00ba3c4fa8a08290c55d264307fdcf6fabd.camel@ndufresne.ca>
         <CAPY8ntC8-d7zupr=mNHdc053RV1Z1yjnmqbV=13AaT2gmMSrKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 juillet 2022 =C3=A0 13:34 +0100, Dave Stevenson a =C3=A9crit=C2=
=A0:
> Hi Ming and Nicolas
>=20
> On Mon, 4 Jul 2022 at 16:53, Nicolas Dufresne <nicolas@ndufresne.ca> wrot=
e:
> >=20
> > Le mardi 28 juin 2022 =C3=A0 10:19 +0800, Ming Qian a =C3=A9crit :
> > > By setting the V4L2_BUF_FLAG_CODECCONFIG flag,
> > > user-space should be able to hint decoder
> > > the vb2 only contains codec config header,
> > > but does not contain any frame data.
> > > It's only used for parsing header, and can't be decoded.
> >=20
> > This is copied from OMX specification. I think we we import this, we sh=
ould at
> > least refer to the original.
> >=20
> > >=20
> > > Current, it's usually used by android.
> > >=20
> > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > ---
> > >  Documentation/userspace-api/media/v4l/buffer.rst | 9 +++++++++
> > >  include/uapi/linux/videodev2.h                   | 2 ++
> > >  2 files changed, 11 insertions(+)
> > >=20
> > > diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Docum=
entation/userspace-api/media/v4l/buffer.rst
> > > index 4638ec64db00..acdc4556f4f4 100644
> > > --- a/Documentation/userspace-api/media/v4l/buffer.rst
> > > +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> > > @@ -607,6 +607,15 @@ Buffer Flags
> > >       the format. Any subsequent call to the
> > >       :ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
> > >       but return an ``EPIPE`` error code.
> > > +    * .. _`V4L2-BUF-FLAG-CODECCONFIG`:
> > > +
> > > +      - ``V4L2_BUF_FLAG_CODECCONFIG``
> > > +      - 0x00200000
> > > +      - This flag may be set when the buffer only contains codec con=
fig
> > > +    header, but does not contain any frame data. Usually the codec c=
onfig
> > > +    header is merged to the next idr frame, with the flag
> > > +    ``V4L2_BUF_FLAG_KEYFRAME``, but there is still some scenes that =
will
> > > +    split the header and queue it separately.
> >=20
> > I think the documentation is clear. Now, if a driver uses this, will ex=
isting
> > userland (perhaps good to check GStreamer, FFMPEG and Chromium ?) will =
break ?
> > So we need existing driver to do this when flagged to, and just copy/ap=
pend when
> > the userland didn't opt-in that feature ?
>=20
> The commit text says it is for userspace feeding data into a video
> decoder, so it's a userspace choice instead of driver.

I see, the spec needs to be more clear then.

>=20
> For encoders there is already V4L2_CID_MPEG_VIDEO_HEADER_MODE [1]
> which allows for V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE or
> V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME. FFmpeg selects
> _SEPARATE by default [2], whilst the default is normally
> _JOINED_WITH_1ST_FRAME.

I did miss the addition of this API, thanks for the reminder. The problem r=
ight
now is that things are being added with the needed cross-reference.

>=20
> It does raise the question as to whether all decoders will support
> header byte only buffers, and does there need to be a capabilities
> flag to denote that it is supported.
> And should encoders in V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE mode set
> it on the headers only buffers?

What about:
- Document better that in absence of V4L2_CID_MPEG_VIDEO_HEADER_MODE in a
driver, V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME is to be assumed
- Document that in V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE, driver should sign=
al
the header buffer with the newly added buffer flag (I would suggest
V4L2_BUF_FLAG_HEADERS_ONLY)
- Document for each support CODECs if V4L2_CID_MPEG_VIDEO_HEADER_MODE can b=
e
supported, and the expected headers and the packing of these=20
- Document that decoders that didn't implement V4L2_CID_MPEG_VIDEO_HEADER_M=
ODE
should be assumed to only support=20
V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME decoding (even though it
allowed to support any alignment, even random).
- Cross-reference V4L2_CID_MPEG_VIDEO_HEADER_MODE into the new flag
documentation (whatever this new flag will be called).

>=20
> A number of undefined elements of how this should be implemented/used :-(
>=20
>   Dave
>=20
> [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ct=
rls-codec.html
> [2] https://github.com/FFmpeg/FFmpeg/blob/master/libavcodec/v4l2_m2m_enc.=
c#L196

>=20
> > >      * .. _`V4L2-BUF-FLAG-REQUEST-FD`:
> > >=20
> > >        - ``V4L2_BUF_FLAG_REQUEST_FD``
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/vide=
odev2.h
> > > index 5311ac4fde35..8708ef257710 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -1131,6 +1131,8 @@ static inline __u64 v4l2_timeval_to_ns(const st=
ruct timeval *tv)
> > >  #define V4L2_BUF_FLAG_TSTAMP_SRC_SOE         0x00010000
> > >  /* mem2mem encoder/decoder */
> > >  #define V4L2_BUF_FLAG_LAST                   0x00100000
> > > +/* Buffer only contains codec header */
> > > +#define V4L2_BUF_FLAG_CODECCONFIG            0x00200000
> > >  /* request_fd is valid */
> > >  #define V4L2_BUF_FLAG_REQUEST_FD             0x00800000
> > >=20
> >=20

