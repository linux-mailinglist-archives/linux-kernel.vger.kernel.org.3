Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F459599E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349566AbiHSP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349751AbiHSP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:28:09 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB33B101C50
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:28:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a4so3567807qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=iA9FPyd1nVi+5ANzlnbkk2becmIxzDV5Vq9MszOeMik=;
        b=BR81CJRUyoDiW6jn9a7JfCde43ZAfHclIbU+KinvYPofdBD0gEF2AhhMPdqGT1Vj5X
         5nErMs6lUjEStZhPblbRZ7VqtQp2SetHyO8Ys9EB756PmvtIEIUuKhvQ11FX1dRvsY8V
         iEVMl64per07X5+eNjU20MCm0AFjphbawvNxTpvkpvgVuqpNdimPa28fQORsIAP3T9xL
         f+dj9/KhvHPICwjMCTr+RfTxkKLQuNOaXOMwWiInOMNYSbo5W1VAAFbKTzzpRVxaYHwH
         WnQZCAAQMzrScA9hVdQNFgRG8NtfQgfdCr2XYtbjwxia+iTONOWMq/znu5v2C+ii8FTU
         kHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=iA9FPyd1nVi+5ANzlnbkk2becmIxzDV5Vq9MszOeMik=;
        b=pebPW9HTPxlm+B00DQzr5eSzCpSXZkIRldlskAdcw6cdos0PNehVkKsJH8zxdZbuTz
         UkFDJn4cWkMT2TwjMY4gQaONGksOJUO1u02sSsR8uFQGRg6VHJz7P2l+OSkWlO7Qtx/g
         ir9W1ZhiST1B3yKv7n8rq0vKzaSjjwvGSUVA1kEJnAgXQtvTdOsozvdb7kC9YFHPe9ax
         HdezCEp54kkSlp+WYjQVBWihZOvNp7O5WhO9bmaP+Hs30nX3ub0TV3c+fXRo3yC6kjyL
         rvOB8buAOrySKWMOGJrpBT6jaZUYkbEvCG+KHTNPfavgV32Fgo4cw0uJOK37a/39+4ou
         yubw==
X-Gm-Message-State: ACgBeo1QO1GAQMMaS/gESR8y44ZS+8IcJ0t0JCasj9tQvED/PZvywUaM
        cPl3TF6zb/ds6CKVbmtIPfXSNA==
X-Google-Smtp-Source: AA6agR78yg020o3BQrSjbyOHf2K23nLFedXybdJ5R96QMH31H/Um1bHSOfOeF4uB98Jhlhnwd5sW7w==
X-Received: by 2002:ac8:59c6:0:b0:344:6f73:da07 with SMTP id f6-20020ac859c6000000b003446f73da07mr6813160qtf.199.1660922886865;
        Fri, 19 Aug 2022 08:28:06 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a424400b006b6757a11fcsm3976599qko.36.2022.08.19.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:28:06 -0700 (PDT)
Message-ID: <6da7faf329128312f0862f555d1a855437ae99f3.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] [WIP]: media: Add Synaptics compressed tiled format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, dri-devel@lists.freedesktop.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, sakari.ailus@linux.intel.com,
        ribalda@chromium.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.hesselbarth@gmail.com,
        jszhang@kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 19 Aug 2022 11:28:04 -0400
In-Reply-To: <Yv7HnHE7bLmgq5D0@pendragon.ideasonboard.com>
References: <20220808162750.828001-1-randy.li@synaptics.com>
         <20220808162750.828001-3-randy.li@synaptics.com>
         <CAAFQd5AKjpJ+fPAeCqdNnJbS4R7SdaHkfyW4qG1xXr-sE801pQ@mail.gmail.com>
         <13d37c15-79f3-4e16-8cf4-fc37846f4a04@synaptics.com>
         <Yv7HnHE7bLmgq5D0@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 19 ao=C3=BBt 2022 =C3=A0 02:13 +0300, Laurent Pinchart a =C3=A9=
crit=C2=A0:
> On Thu, Aug 18, 2022 at 02:33:42PM +0800, Hsia-Jun Li wrote:
> > On 8/18/22 14:06, Tomasz Figa wrote:
> > > On Tue, Aug 9, 2022 at 1:28 AM Hsia-Jun Li <randy.li@synaptics.com> w=
rote:
> > > >=20
> > > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > > >=20
> > > > The most of detail has been written in the drm.
>=20
> This patch still needs a description of the format, which should go to
> Documentation/userspace-api/media/v4l/.
>=20
> > > > Please notice that the tiled formats here request
> > > > one more plane for storing the motion vector metadata.
> > > > This buffer won't be compressed, so you can't append
> > > > it to luma or chroma plane.
> > >=20
> > > Does the motion vector buffer need to be exposed to userspace? Is the
> > > decoder stateless (requires userspace to specify the reference frames=
)
> > > or stateful (manages the entire decoding process internally)?
> >=20
> > No, users don't need to access them at all. Just they need a different=
=20
> > dma-heap.
> >=20
> > You would only get the stateful version of both encoder and decoder.
>=20
> Shouldn't the motion vectors be stored in a separate V4L2 buffer,
> submitted through a different queue then ?

Imho, I believe these should be invisible to users and pooled separately to
reduce the overhead. The number of reference is usually lower then the numb=
er of
allocated display buffers.

>=20
> > > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > > ---
> > > >   drivers/media/v4l2-core/v4l2-common.c | 1 +
> > > >   drivers/media/v4l2-core/v4l2-ioctl.c  | 2 ++
> > > >   include/uapi/linux/videodev2.h        | 2 ++
> > > >   3 files changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/=
v4l2-core/v4l2-common.c
> > > > index e0fbe6ba4b6c..f645278b3055 100644
> > > > --- a/drivers/media/v4l2-core/v4l2-common.c
> > > > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > > > @@ -314,6 +314,7 @@ const struct v4l2_format_info *v4l2_format_info=
(u32 format)
> > > >                  { .format =3D V4L2_PIX_FMT_SGBRG12,       .pixel_e=
nc =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =
=3D { 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > > >                  { .format =3D V4L2_PIX_FMT_SGRBG12,       .pixel_e=
nc =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =
=3D { 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > > >                  { .format =3D V4L2_PIX_FMT_SRGGB12,       .pixel_e=
nc =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =
=3D { 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > > > +               { .format =3D V4L2_PIX_FMT_NV12M_V4H1C, .pixel_enc =
=3D V4L2_PIXEL_ENC_YUV, .mem_planes =3D 5, .comp_planes =3D 2, .bpp =3D { 1=
, 2, 0, 0 }, .hdiv =3D 2, .vdiv =3D 2, .block_w =3D { 128, 128 }, .block_h =
=3D { 128, 128 } },
> > > >          };
> > > >          unsigned int i;
> > > >=20
> > > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v=
4l2-core/v4l2-ioctl.c
> > > > index e6fd355a2e92..8f65964aff08 100644
> > > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > @@ -1497,6 +1497,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtd=
esc *fmt)
> > > >                  case V4L2_PIX_FMT_MT21C:        descr =3D "Mediate=
k Compressed Format"; break;
> > > >                  case V4L2_PIX_FMT_QC08C:        descr =3D "QCOM Co=
mpressed 8-bit Format"; break;
> > > >                  case V4L2_PIX_FMT_QC10C:        descr =3D "QCOM Co=
mpressed 10-bit Format"; break;
> > > > +               case V4L2_PIX_FMT_NV12M_V4H1C:  descr =3D "Synaptic=
s Compressed 8-bit tiled Format";break;
> > > > +               case V4L2_PIX_FMT_NV12M_10_V4H3P8C:     descr =3D "=
Synaptics Compressed 10-bit tiled Format";break;
> > > >                  default:
> > > >                          if (fmt->description[0])
> > > >                                  return;
> > > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/vi=
deodev2.h
> > > > index 01e630f2ec78..7e928cb69e7c 100644
> > > > --- a/include/uapi/linux/videodev2.h
> > > > +++ b/include/uapi/linux/videodev2.h
> > > > @@ -661,6 +661,8 @@ struct v4l2_pix_format {
> > > >   #define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1', '2')=
 /* 12  Y/CbCr 4:2:0 16x16 tiles */
> > > >   #define V4L2_PIX_FMT_NV12M_8L128      v4l2_fourcc('N', 'A', '1', =
'2') /* Y/CbCr 4:2:0 8x128 tiles */
> > > >   #define V4L2_PIX_FMT_NV12M_10BE_8L128 v4l2_fourcc_be('N', 'T', '1=
', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> > > > +#define V4L2_PIX_FMT_NV12M_V4H1C v4l2_fourcc('S', 'Y', '1', '2')  =
 /* 12  Y/CbCr 4:2:0 tiles */
> > > > +#define V4L2_PIX_FMT_NV12M_10_V4H3P8C v4l2_fourcc('S', 'Y', '1', '=
0')   /* 12  Y/CbCr 4:2:0 10-bits tiles */
> > > >=20
> > > >   /* Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.=
htm */
> > > >   #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1') /*  =
8  BGBG.. GRGR.. */
>=20

