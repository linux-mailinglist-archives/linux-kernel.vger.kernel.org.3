Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EEF595E78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiHPOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHPOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:42:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06269B8A51
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:42:56 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u10so7974900qvp.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=xiNzdjXaNP/rfFBy+aC0sAbvzY4W1AvNeTyfE61T9IM=;
        b=Ue1e8CjD7uCQXDi0+DYAfAARDvmv9vkeQtONo0/OS4zI/Kf05PccDnbYFkeli3wZ8s
         1Fv6tnzdid50fyfPeYg13u+1bYzuUuQ4s6CvWQCN9X7UOUqb+J/PiSmgkUdTdn2APlTl
         uJ7V4sSO6r2EUC1mnGa4GsjOD0p/t3yUVmt0TP+ghD9n0U0BQfSB6bYaiqh6yQKwahtQ
         xM1Cu61h2GZOnQ73+tBpediN257oXyqpmEnqbdBAXc8cjvsjBq7U3xiuGfnL2Sz4UKxS
         /V4b7pRVWdQvwil7p4HqlsxJ+zTOkiC5eQEc5huFLETxK218GpaAxN6b/2mGQabDsuFA
         Rfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=xiNzdjXaNP/rfFBy+aC0sAbvzY4W1AvNeTyfE61T9IM=;
        b=N12Tsha7lDKd7+CNlh9c0AbluvpzRorGl9IScyUpS9pidG0y8DhND0LKmD2IQtCnmY
         1L8qvbLl/KcWYVGvKShv5B2FhpjB0dQyQX6OZaVE8fX2O59V/Xp0Vo+ssTN+fe8l4eDY
         iShECHnfRDeRYztqkMErxah8tiy4KW2IE8zmNYWrRjLWJVmWF4PJ1oats+gb+FTV/3E6
         CD8HE13p7WKEH4pLQC9B22y8ugOPH5IwipvFkKAf58cdlxdKKMk1v3Y9QQJEJn1hu4X2
         TYMwKyV20HuJGLmr2ieSkIpi3h61SGt8ciItrYm31PyU126RbR7jwaD8DaDoBXqLKqIX
         fsDA==
X-Gm-Message-State: ACgBeo0LL271kev6pF3CSEzX50NyXiBnPRv08UfSxZPt5DcfqKqqiLUT
        QAjgX2yB6Uh1UKDIuImPfhA/GQ==
X-Google-Smtp-Source: AA6agR58neuAi5qQc1HZTWOyyQYGBejH8SdVMOyoXTUT7lBF+okxobWrR7WCsm7kKh4CwNl0KlyP+g==
X-Received: by 2002:a05:6214:19e5:b0:476:e58a:da88 with SMTP id q5-20020a05621419e500b00476e58ada88mr17719338qvc.81.1660660975038;
        Tue, 16 Aug 2022 07:42:55 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a0c5300b006b5f8f32a8fsm11830619qki.114.2022.08.16.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 07:42:54 -0700 (PDT)
Message-ID: <46e128a7767c1c4db226b8a4cef0701a336a3766.camel@ndufresne.ca>
Subject: Re: [PATCH v4 1/4] media: add nv12_8l128 and nv12_10be_8l128 video
 format.
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, shawnguo@kernel.org,
        robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 16 Aug 2022 10:42:53 -0400
In-Reply-To: <20220811151853.GB6390@tom-ThinkPad-T14s-Gen-2i>
References: <cover.1660027440.git.ming.qian@nxp.com>
         <84842bffb432884a0fd84de96c6e64ee2273e511.1660027440.git.ming.qian@nxp.com>
         <20220811151853.GB6390@tom-ThinkPad-T14s-Gen-2i>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 11 ao=C3=BBt 2022 =C3=A0 17:18 +0200, Tommaso Merciai a =C3=A9crit=
=C2=A0:
> Hi Ming,
>=20
> On Tue, Aug 09, 2022 at 02:50:38PM +0800, Ming Qian wrote:
> > add contiguous nv12 tiled format nv12_8l128 and nv12_10be_8l128
> >=20
> > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >  .../userspace-api/media/v4l/pixfmt-yuv-planar.rst         | 8 ++++++++
> >  drivers/media/v4l2-core/v4l2-ioctl.c                      | 2 ++
> >  include/uapi/linux/videodev2.h                            | 2 ++
> >  3 files changed, 12 insertions(+)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rs=
t b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > index 10b1feeb0b57..f1d5bb7b806d 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > @@ -273,7 +273,9 @@ of the luma plane.
> >  .. _V4L2-PIX-FMT-NV12-16L16:
> >  .. _V4L2-PIX-FMT-NV12-32L32:
> >  .. _V4L2-PIX-FMT-NV12M-8L128:
> > +.. _V4L2-PIX-FMT-NV12-8L128:
> >  .. _V4L2-PIX-FMT-NV12M-10BE-8L128:
> > +.. _V4L2-PIX-FMT-NV12-10BE-8L128:
> >  .. _V4L2-PIX-FMT-MM21:
> > =20
> >  Tiled NV12
> > @@ -319,6 +321,9 @@ pixels in 2D 8x128 tiles, and stores tiles linearly=
 in memory.
> >  The image height must be aligned to a multiple of 128.
> >  The layouts of the luma and chroma planes are identical.
> > =20
> > +``V4L2_PIX_FMT_NV12_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_8L128``=
 but stores
> > +two planes in one memory.
> > +
>=20
> Don't know, maybe we need more details here?
>=20
> >  ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M``=
 but stores
> >  10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
> >  the data is arranged in big endian order.
> > @@ -334,6 +339,9 @@ byte 2: Y1(bits 3-0) Y2(bits 9-6)
> >  byte 3: Y2(bits 5-0) Y3(bits 9-8)
> >  byte 4: Y3(bits 7-0)
> > =20
> > +``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10=
BE_8L128`` but stores
> > +two planes in one memory.
> > +
>=20
> here also?

Perhaps I'm too much into it, but it felt clear to me. Note that the duplic=
ation
of pixel formats based on the number of allocation is pretty unique to V4L2=
, but
its also generalized to all planar formats. So adding a lot of documentatio=
n for
each specific format will be heavy. Note that one improvement I see, would =
be
s/memory/allocation/ , or memory allocation.

>=20
> >  ``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixe=
ls
> >  in 16x16 tiles. The line stride must be aligned to a multiple of 16 an=
d the
> >  image height must be aligned to a multiple of 32. The number of luma a=
nd chroma
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index c314025d977e..d973bd2ff750 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1444,7 +1444,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc =
*fmt)
> >  	case V4L2_META_FMT_VIVID:       descr =3D "Vivid Metadata"; break;
> >  	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr =3D "Rockchip ISP1 3A Parame=
ters"; break;
> >  	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr =3D "Rockchip ISP1 3A Stati=
stics"; break;
> > +	case V4L2_PIX_FMT_NV12_8L128:	descr =3D "NV12 (8x128 Linear)"; break;
> >  	case V4L2_PIX_FMT_NV12M_8L128:	descr =3D "NV12M (8x128 Linear)"; brea=
k;
> > +	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr =3D "10-bit NV12 (8x128 Line=
ar, BE)"; break;
> >  	case V4L2_PIX_FMT_NV12M_10BE_8L128:	descr =3D "10-bit NV12M (8x128 Li=
near, BE)"; break;
> > =20
> >  	default:
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index cd66e01ed3c3..64f16490dd2b 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -655,6 +655,8 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12 =
 Y/CbCr 4:2:0 16x16 tiles */
> >  #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12 =
 Y/CbCr 4:2:0 32x32 tiles */
> >  #define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y=
/CbCr 4:2:0 10-bit 4x4 macroblocks */
> > +#define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') =
/* Y/CbCr 4:2:0 8x128 tiles */
> > +#define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1', '2=
') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> > =20
> >  /* Tiled YUV formats, non contiguous planes */
> >  #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/=
CbCr 4:2:0 64x32 tiles */
> > --=20
> > 2.37.1
> >=20
>=20
> For the other parts look's good to me.
> Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
>=20
> Regards,
> Tommaso
>=20

