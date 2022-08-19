Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7A8599E42
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349720AbiHSP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbiHSP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:26:51 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139359412D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:26:50 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id b2so3597067qvp.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=R+dNyyhZWqiKyDnj3wr9Zou8hF3lxJeexkrsHsTQHCs=;
        b=gIDMRZx+giubIoQBdvXlT0umgT/qdGwDGI05hYyh2Vvu0kpK5kdNyw1KGVPnTyVcS4
         PSPoWV70wIKHa4mFlRK/CiXR892ZCQmDp9V0E2iIYQnrn6PlCj2jk64SBmmKC6K20De9
         PG5VnUWE6kIHmWUPCbBn9B79Q5f0hRBiDP3mcL4Eafkyr1HTjJiEHKcteD9UWxFQb3i5
         OQJNEairgzp2nTftuwMeHSkXzzviY++/vPgW5it1RfWCMh9b350LmCkohPl8n6NFyhLq
         /9JennJOD4aTdblZCluX4cAijvnPMuW2VHNg8bz+WkObDLFYgqSH96PU3TaY5asFjKeF
         LV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=R+dNyyhZWqiKyDnj3wr9Zou8hF3lxJeexkrsHsTQHCs=;
        b=qGBKPC49a/AVOpJCf3ozfDrusg0gJlXXWaMrkdx0fEnIz7uuFfE3IKK/JhT7bQL+Qa
         LYULnE33Um84dMsruFyrjTO8TmmIfbiOQTtkyF0JR6vh9QiRui2OH+uFw735gPgxObI2
         UwCi1jLifrLN/4Yssovlalmwhim9er2HLZi8P2IubzcABxpy3nMrynyD/+C64aAE1Ioz
         3bD8VEfFLzxbuHkualUPdcZLtdP3IPM7Lwq2VWEFVinGiLiJSux2xl7RlSbcpS65sDQp
         mcb3u7XrMyfe4bkXdSZSB38Iz/xh0vtr0Oet+MVRWuJta9ofWMvjhAt035ks75E26CIr
         HK7Q==
X-Gm-Message-State: ACgBeo2jEFbN4skZg0xha9hPK/cI+aaX3mAFfP5QDqR/ewpy6rUqUacK
        tjWUa/kH0PRIxcEjWj9fI6b62w==
X-Google-Smtp-Source: AA6agR7U56cQNY2xUyo+d5l6PVKsi2MOXOr/PEkSHhmZKzpQfdPj2IQ/vETNRnqdrxY7d2iUdYlsbA==
X-Received: by 2002:a05:6214:e68:b0:474:89bf:ca1b with SMTP id jz8-20020a0562140e6800b0047489bfca1bmr6975461qvb.107.1660922809183;
        Fri, 19 Aug 2022 08:26:49 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id ee7-20020a05620a800700b006bb82221013sm4292050qkb.0.2022.08.19.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:26:48 -0700 (PDT)
Message-ID: <64fbaceed1cc140e54aec54747e56b40b68378ca.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] [WIP]: media: Add Synaptics compressed tiled format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.hesselbarth@gmail.com, jszhang@kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 19 Aug 2022 11:26:45 -0400
In-Reply-To: <13d37c15-79f3-4e16-8cf4-fc37846f4a04@synaptics.com>
References: <20220808162750.828001-1-randy.li@synaptics.com>
         <20220808162750.828001-3-randy.li@synaptics.com>
         <CAAFQd5AKjpJ+fPAeCqdNnJbS4R7SdaHkfyW4qG1xXr-sE801pQ@mail.gmail.com>
         <13d37c15-79f3-4e16-8cf4-fc37846f4a04@synaptics.com>
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

Le jeudi 18 ao=C3=BBt 2022 =C3=A0 14:33 +0800, Hsia-Jun Li a =C3=A9crit=C2=
=A0:
>=20
> On 8/18/22 14:06, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > Hi Randy,
> >=20
> > On Tue, Aug 9, 2022 at 1:28 AM Hsia-Jun Li <randy.li@synaptics.com> wro=
te:
> > >=20
> > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > >=20
> > > The most of detail has been written in the drm.
> > > Please notice that the tiled formats here request
> > > one more plane for storing the motion vector metadata.
> > > This buffer won't be compressed, so you can't append
> > > it to luma or chroma plane.
> >=20
> > Does the motion vector buffer need to be exposed to userspace? Is the
> > decoder stateless (requires userspace to specify the reference frames)
> > or stateful (manages the entire decoding process internally)?
> >=20
> No, users don't need to access them at all. Just they need a different=
=20
> dma-heap.
>=20
> You would only get the stateful version of both encoder and decoder.

Can't you just allocate and manage these internally in the kernel driver wi=
thout
adding kernel APIs ? This is notably what Mediatek and (downstream) RPi HEV=
C
driver do, as it allow reducing quite a lot the memory usage. In Hantro, we=
 bind
them due to HW limitation.

Nicolas

> > Best regards,
> > Tomasz
> >=20
> > >=20
> > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > ---
> > >   drivers/media/v4l2-core/v4l2-common.c | 1 +
> > >   drivers/media/v4l2-core/v4l2-ioctl.c  | 2 ++
> > >   include/uapi/linux/videodev2.h        | 2 ++
> > >   3 files changed, 5 insertions(+)
> > >=20
> > > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4=
l2-core/v4l2-common.c
> > > index e0fbe6ba4b6c..f645278b3055 100644
> > > --- a/drivers/media/v4l2-core/v4l2-common.c
> > > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > > @@ -314,6 +314,7 @@ const struct v4l2_format_info *v4l2_format_info(u=
32 format)
> > >                  { .format =3D V4L2_PIX_FMT_SGBRG12,       .pixel_enc=
 =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D =
{ 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > >                  { .format =3D V4L2_PIX_FMT_SGRBG12,       .pixel_enc=
 =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D =
{ 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > >                  { .format =3D V4L2_PIX_FMT_SRGGB12,       .pixel_enc=
 =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D =
{ 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > > +               { .format =3D V4L2_PIX_FMT_NV12M_V4H1C, .pixel_enc =
=3D V4L2_PIXEL_ENC_YUV, .mem_planes =3D 5, .comp_planes =3D 2, .bpp =3D { 1=
, 2, 0, 0 }, .hdiv =3D 2, .vdiv =3D 2, .block_w =3D { 128, 128 }, .block_h =
=3D { 128, 128 } },
> > >          };
> > >          unsigned int i;
> > >=20
> > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l=
2-core/v4l2-ioctl.c
> > > index e6fd355a2e92..8f65964aff08 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > @@ -1497,6 +1497,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdes=
c *fmt)
> > >                  case V4L2_PIX_FMT_MT21C:        descr =3D "Mediatek =
Compressed Format"; break;
> > >                  case V4L2_PIX_FMT_QC08C:        descr =3D "QCOM Comp=
ressed 8-bit Format"; break;
> > >                  case V4L2_PIX_FMT_QC10C:        descr =3D "QCOM Comp=
ressed 10-bit Format"; break;
> > > +               case V4L2_PIX_FMT_NV12M_V4H1C:  descr =3D "Synaptics =
Compressed 8-bit tiled Format";break;
> > > +               case V4L2_PIX_FMT_NV12M_10_V4H3P8C:     descr =3D "Sy=
naptics Compressed 10-bit tiled Format";break;
> > >                  default:
> > >                          if (fmt->description[0])
> > >                                  return;
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/vide=
odev2.h
> > > index 01e630f2ec78..7e928cb69e7c 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -661,6 +661,8 @@ struct v4l2_pix_format {
> > >   #define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1', '2') /=
* 12  Y/CbCr 4:2:0 16x16 tiles */
> > >   #define V4L2_PIX_FMT_NV12M_8L128      v4l2_fourcc('N', 'A', '1', '2=
') /* Y/CbCr 4:2:0 8x128 tiles */
> > >   #define V4L2_PIX_FMT_NV12M_10BE_8L128 v4l2_fourcc_be('N', 'T', '1',=
 '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> > > +#define V4L2_PIX_FMT_NV12M_V4H1C v4l2_fourcc('S', 'Y', '1', '2')   /=
* 12  Y/CbCr 4:2:0 tiles */
> > > +#define V4L2_PIX_FMT_NV12M_10_V4H3P8C v4l2_fourcc('S', 'Y', '1', '0'=
)   /* 12  Y/CbCr 4:2:0 10-bits tiles */
> > >=20
> > >   /* Bayer formats - see https://urldefense.proofpoint.com/v2/url?u=
=3Dhttp-3A__www.siliconimaging.com_RGB-2520Bayer.htm&d=3DDwIBaQ&c=3D7dfBJ8c=
XbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=3DP4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7P=
XU-mLTeZE&m=3DvmpysqneiHK3UXcq6UOewdMwobFa70zKB3RuOgYT02aFw9fCs6qd7j-U1sYSe=
y79&s=3DyblzF1GwanMEJFC3yt9nBAQjaaAEJKKlNgj4k64v5eE&e=3D   */
> > >   #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1') /*  8 =
 BGBG.. GRGR.. */
> > > --
> > > 2.17.1
> > >=20
>=20

