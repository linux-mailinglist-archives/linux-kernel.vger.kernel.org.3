Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF21C566EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiGENIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGENHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:07:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362BB2ED67
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:34:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e40so15101809eda.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wqq6YhYJdrCEUWBrIxoQDPJ/29L5AB67g46BfHWDGLQ=;
        b=UGR09iyBQZgZlBk0pRuwl8nQ+/a5/gkiyJlWtxsDctw3xJC8t92dSzDjQb2vZ0+PZ7
         TLzQRXqFNxNIyx66oNgkIlNMU2LZn4ASJk3hl9R1347oYtrLGQ3dH0GeTYN19jZn7uYc
         wb3ltnk+oFEtOBHNFvJdW+9RbPizi4pNJlqERJDc7Rzgn7F9WYWx509GFKwa6esOxBtG
         RsJr/T/DdjejIFoE1v5W0JOW3FzrDVuzSJAXUX0LJyRJHP85OE/vGRp2df9GuwNLGntO
         4UK5XsQMHy2c89i3AKj74Fga4SQUyIgVfxDVSNdqpPZOEIem7gYVNBlLtmkumwUdpjng
         difg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wqq6YhYJdrCEUWBrIxoQDPJ/29L5AB67g46BfHWDGLQ=;
        b=pvbunsnoc9cjrmZVYBGk6rdZc1nEm2XlIIhIQZqieudXDoKVOMRytvNIJBck62Zrvg
         a2OlOvC3oOPsmDPUIJdh9XrKswJr3DF1EOosrQgxbsF1riH7KbadsmCbEdwQVhL+0Oo1
         5i+wQ2DbKXd/K4GTQK0xjwj9pILigrbTrcX2K+ecwuTVCVtok1ZpqmWRZk7sr+No3VAw
         cHXBLZnJFeCZpW3ioiJljFDBhrL6Y+l8cXFB5yyaC1c5jkYont/mCGS7IjpkkXpJRiQb
         9la0XyI6vg+M6uqvAqfSpZHUaFnYmiErjLB1xUVybNb9apivmc/2Y/Nj1j+8eTbOhtpc
         wKRQ==
X-Gm-Message-State: AJIora+FfiNQ5+eJwG0Kl3Drs8fXpt/6HBSfPns0vC0hy8fxkaYHbuH4
        f1hBlWbtzllxeZzFilTeF75tphsWun0spruSBtzjow==
X-Google-Smtp-Source: AGRyM1sXYzZzKcvIuVIjzy8GYuHnTha12H6MJ2hH92DZDU+YBnfl1rkWGMyQXfrpOjEHHdtAlREo8dFTxkMpQRPJKMU=
X-Received: by 2002:a05:6402:4021:b0:439:7588:cebf with SMTP id
 d33-20020a056402402100b004397588cebfmr32370605eda.136.1657024472814; Tue, 05
 Jul 2022 05:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220628021909.14620-1-ming.qian@nxp.com> <a834a00ba3c4fa8a08290c55d264307fdcf6fabd.camel@ndufresne.ca>
In-Reply-To: <a834a00ba3c4fa8a08290c55d264307fdcf6fabd.camel@ndufresne.ca>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 5 Jul 2022 13:34:16 +0100
Message-ID: <CAPY8ntC8-d7zupr=mNHdc053RV1Z1yjnmqbV=13AaT2gmMSrKw@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_CODECCONFIG flag
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming and Nicolas

On Mon, 4 Jul 2022 at 16:53, Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>
> Le mardi 28 juin 2022 =C3=A0 10:19 +0800, Ming Qian a =C3=A9crit :
> > By setting the V4L2_BUF_FLAG_CODECCONFIG flag,
> > user-space should be able to hint decoder
> > the vb2 only contains codec config header,
> > but does not contain any frame data.
> > It's only used for parsing header, and can't be decoded.
>
> This is copied from OMX specification. I think we we import this, we shou=
ld at
> least refer to the original.
>
> >
> > Current, it's usually used by android.
> >
> > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > ---
> >  Documentation/userspace-api/media/v4l/buffer.rst | 9 +++++++++
> >  include/uapi/linux/videodev2.h                   | 2 ++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documen=
tation/userspace-api/media/v4l/buffer.rst
> > index 4638ec64db00..acdc4556f4f4 100644
> > --- a/Documentation/userspace-api/media/v4l/buffer.rst
> > +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> > @@ -607,6 +607,15 @@ Buffer Flags
> >       the format. Any subsequent call to the
> >       :ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
> >       but return an ``EPIPE`` error code.
> > +    * .. _`V4L2-BUF-FLAG-CODECCONFIG`:
> > +
> > +      - ``V4L2_BUF_FLAG_CODECCONFIG``
> > +      - 0x00200000
> > +      - This flag may be set when the buffer only contains codec confi=
g
> > +    header, but does not contain any frame data. Usually the codec con=
fig
> > +    header is merged to the next idr frame, with the flag
> > +    ``V4L2_BUF_FLAG_KEYFRAME``, but there is still some scenes that wi=
ll
> > +    split the header and queue it separately.
>
> I think the documentation is clear. Now, if a driver uses this, will exis=
ting
> userland (perhaps good to check GStreamer, FFMPEG and Chromium ?) will br=
eak ?
> So we need existing driver to do this when flagged to, and just copy/appe=
nd when
> the userland didn't opt-in that feature ?

The commit text says it is for userspace feeding data into a video
decoder, so it's a userspace choice instead of driver.

For encoders there is already V4L2_CID_MPEG_VIDEO_HEADER_MODE [1]
which allows for V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE or
V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME. FFmpeg selects
_SEPARATE by default [2], whilst the default is normally
_JOINED_WITH_1ST_FRAME.

It does raise the question as to whether all decoders will support
header byte only buffers, and does there need to be a capabilities
flag to denote that it is supported.
And should encoders in V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE mode set
it on the headers only buffers?

A number of undefined elements of how this should be implemented/used :-(

  Dave

[1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrl=
s-codec.html
[2] https://github.com/FFmpeg/FFmpeg/blob/master/libavcodec/v4l2_m2m_enc.c#=
L196

> >      * .. _`V4L2-BUF-FLAG-REQUEST-FD`:
> >
> >        - ``V4L2_BUF_FLAG_REQUEST_FD``
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 5311ac4fde35..8708ef257710 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -1131,6 +1131,8 @@ static inline __u64 v4l2_timeval_to_ns(const stru=
ct timeval *tv)
> >  #define V4L2_BUF_FLAG_TSTAMP_SRC_SOE         0x00010000
> >  /* mem2mem encoder/decoder */
> >  #define V4L2_BUF_FLAG_LAST                   0x00100000
> > +/* Buffer only contains codec header */
> > +#define V4L2_BUF_FLAG_CODECCONFIG            0x00200000
> >  /* request_fd is valid */
> >  #define V4L2_BUF_FLAG_REQUEST_FD             0x00800000
> >
>
