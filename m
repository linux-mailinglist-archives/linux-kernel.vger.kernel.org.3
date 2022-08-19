Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8459A673
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351439AbiHSTSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349802AbiHSTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:17:39 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C214113685
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:17:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s11so4059990qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=zqcKGStGt8TrlCs7z+qRpJaLaLQjLjsVPHQFcBxcy4M=;
        b=fZB96lwB0/tBwEkW6AWKJTMQ/274sjZH1uCbcSw84gIXuw70urCc/dUb9l6xSG4R3s
         DlPgLDLtL5tu53xvqOkDjmp3xwr++fGNsNEwm9OB0jvrJUPHQcoQmO04HXk9sq/0OYp1
         MnQE1JatmYVhQqxLEQTsjtYULoX10qX1wHlvSMMI+ww3f3QNuespqBYqzfQgCLdgZtCA
         XAJ1IzZcrFqwbCA4r8S22MfA3Rk8As+DAQbqhmzW0gAqSxhyXjXocigQng8G1qdQioZA
         /216u75NQlP/Ew2ItdY/SEQJe4VmHD6oAXDOExOd4pVVUJAoXBDnjKZUThgm+LeGBShk
         b0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=zqcKGStGt8TrlCs7z+qRpJaLaLQjLjsVPHQFcBxcy4M=;
        b=crRxJyfDTga2ftNtJQMguzX+7SjJJD3PnLeR0q4xzbNe3T39m1Ugw8kJBVbOM6qyz4
         DU+Lx2ZaWFNBnPhM5Y2XagQW5rCrOvGZOQpIjHDXX5kdHdQYYcxdFIh/nDVTI0rm/RzS
         npFNm5n/ctiHHyVSaisV+XT/+RFOaD3Wk8Aw5USdxMES5nRu+M+GuLZlfYST/ELnE1QG
         KAzIqL6DzulnyxZtVu1G1b9CIKu668BApO+sLSrE7X3bacoiPLWOHeJtILNDyu/5R0Bx
         a9pF6hBN5EFMOM8DWeEAcyGxqkMasf/YfCeNHWMQexN2TKu8Xust7SI9CE9nly4aRY3w
         fe8w==
X-Gm-Message-State: ACgBeo2yPXmyEiEmZNOAhw8LTT2QSPbkZYrAV1Gsc1MwMwIcT3ZUlTox
        FbKwDNS4nY9gZcycHFEWqEr6Zw==
X-Google-Smtp-Source: AA6agR7sVbRypxSr6VTDp/J2LvhPe/AzN7HranjcJnZDhrZiPEuj518XZCYS//0FtWfnTEYLmiIqhg==
X-Received: by 2002:ac8:5b05:0:b0:343:3ce4:c34c with SMTP id m5-20020ac85b05000000b003433ce4c34cmr7834774qtw.233.1660936651219;
        Fri, 19 Aug 2022 12:17:31 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id p123-20020a37bf81000000b006a6d7c3a82esm4178022qkf.15.2022.08.19.12.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:17:29 -0700 (PDT)
Message-ID: <2662ac698898f71f60b9b7e0ad4703854de1d012.camel@ndufresne.ca>
Subject: Re: [PATCH 2/2] [WIP]: media: Add Synaptics compressed tiled format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, dri-devel@lists.freedesktop.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, sakari.ailus@linux.intel.com,
        ribalda@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.hesselbarth@gmail.com, jszhang@kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 19 Aug 2022 15:17:27 -0400
In-Reply-To: <50dd9b7a-8f48-0799-57f6-048d20de8dcc@synaptics.com>
References: <20220808162750.828001-1-randy.li@synaptics.com>
         <20220808162750.828001-3-randy.li@synaptics.com>
         <CAAFQd5AKjpJ+fPAeCqdNnJbS4R7SdaHkfyW4qG1xXr-sE801pQ@mail.gmail.com>
         <13d37c15-79f3-4e16-8cf4-fc37846f4a04@synaptics.com>
         <Yv7HnHE7bLmgq5D0@pendragon.ideasonboard.com>
         <6da7faf329128312f0862f555d1a855437ae99f3.camel@ndufresne.ca>
         <50dd9b7a-8f48-0799-57f6-048d20de8dcc@synaptics.com>
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

Le vendredi 19 ao=C3=BBt 2022 =C3=A0 23:44 +0800, Hsia-Jun Li a =C3=A9crit=
=C2=A0:
>=20
> On 8/19/22 23:28, Nicolas Dufresne wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > Le vendredi 19 ao=C3=BBt 2022 =C3=A0 02:13 +0300, Laurent Pinchart a =
=C3=A9crit :
> > > On Thu, Aug 18, 2022 at 02:33:42PM +0800, Hsia-Jun Li wrote:
> > > > On 8/18/22 14:06, Tomasz Figa wrote:
> > > > > On Tue, Aug 9, 2022 at 1:28 AM Hsia-Jun Li <randy.li@synaptics.co=
m> wrote:
> > > > > >=20
> > > > > > From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
> > > > > >=20
> > > > > > The most of detail has been written in the drm.
> > >=20
> > > This patch still needs a description of the format, which should go t=
o
> > > Documentation/userspace-api/media/v4l/.
> > >=20
> > > > > > Please notice that the tiled formats here request
> > > > > > one more plane for storing the motion vector metadata.
> > > > > > This buffer won't be compressed, so you can't append
> > > > > > it to luma or chroma plane.
> > > > >=20
> > > > > Does the motion vector buffer need to be exposed to userspace? Is=
 the
> > > > > decoder stateless (requires userspace to specify the reference fr=
ames)
> > > > > or stateful (manages the entire decoding process internally)?
> > > >=20
> > > > No, users don't need to access them at all. Just they need a differ=
ent
> > > > dma-heap.
> > > >=20
> > > > You would only get the stateful version of both encoder and decoder=
.
> > >=20
> > > Shouldn't the motion vectors be stored in a separate V4L2 buffer,
> > > submitted through a different queue then ?
> >=20
> > Imho, I believe these should be invisible to users and pooled separatel=
y to
> > reduce the overhead. The number of reference is usually lower then the =
number of
> > allocated display buffers.
> >=20
> You can't. The motion vector buffer can't share with the luma and chroma=
=20
> data planes, nor the data plane for the compression meta data.
>=20
> You could consider this as a security requirement(the memory region for=
=20
> the MV could only be accessed by the decoder) or hardware limitation.
>=20
> It is also not very easy to manage such a large buffer that would change=
=20
> when the resolution changed.

Your argument are just aiming toward the fact that you should not let the u=
ser
allocate these in the first place. They should not be bound to the v4l2 buf=
fer.
Allocate these in your driver, and leave to your user the pixel buffer (and
compress meta) allocation work.

Other driver handle this just fine, if your v4l2 driver implement the v4l2
resolution change mechanism, is should be very simple to manage.

> > >=20
> > > > > > Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> > > > > > ---
> > > > > >    drivers/media/v4l2-core/v4l2-common.c | 1 +
> > > > > >    drivers/media/v4l2-core/v4l2-ioctl.c  | 2 ++
> > > > > >    include/uapi/linux/videodev2.h        | 2 ++
> > > > > >    3 files changed, 5 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/me=
dia/v4l2-core/v4l2-common.c
> > > > > > index e0fbe6ba4b6c..f645278b3055 100644
> > > > > > --- a/drivers/media/v4l2-core/v4l2-common.c
> > > > > > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > > > > > @@ -314,6 +314,7 @@ const struct v4l2_format_info *v4l2_format_=
info(u32 format)
> > > > > >                   { .format =3D V4L2_PIX_FMT_SGBRG12,       .pi=
xel_enc =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .b=
pp =3D { 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > > > > >                   { .format =3D V4L2_PIX_FMT_SGRBG12,       .pi=
xel_enc =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .b=
pp =3D { 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > > > > >                   { .format =3D V4L2_PIX_FMT_SRGGB12,       .pi=
xel_enc =3D V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .b=
pp =3D { 2, 0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > > > > > +               { .format =3D V4L2_PIX_FMT_NV12M_V4H1C, .pixel_=
enc =3D V4L2_PIXEL_ENC_YUV, .mem_planes =3D 5, .comp_planes =3D 2, .bpp =3D=
 { 1, 2, 0, 0 }, .hdiv =3D 2, .vdiv =3D 2, .block_w =3D { 128, 128 }, .bloc=
k_h =3D { 128, 128 } },
> > > > > >           };
> > > > > >           unsigned int i;
> > > > > >=20
> > > > > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/med=
ia/v4l2-core/v4l2-ioctl.c
> > > > > > index e6fd355a2e92..8f65964aff08 100644
> > > > > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > > > > @@ -1497,6 +1497,8 @@ static void v4l_fill_fmtdesc(struct v4l2_=
fmtdesc *fmt)
> > > > > >                   case V4L2_PIX_FMT_MT21C:        descr =3D "Me=
diatek Compressed Format"; break;
> > > > > >                   case V4L2_PIX_FMT_QC08C:        descr =3D "QC=
OM Compressed 8-bit Format"; break;
> > > > > >                   case V4L2_PIX_FMT_QC10C:        descr =3D "QC=
OM Compressed 10-bit Format"; break;
> > > > > > +               case V4L2_PIX_FMT_NV12M_V4H1C:  descr =3D "Syna=
ptics Compressed 8-bit tiled Format";break;
> > > > > > +               case V4L2_PIX_FMT_NV12M_10_V4H3P8C:     descr =
=3D "Synaptics Compressed 10-bit tiled Format";break;
> > > > > >                   default:
> > > > > >                           if (fmt->description[0])
> > > > > >                                   return;
> > > > > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linu=
x/videodev2.h
> > > > > > index 01e630f2ec78..7e928cb69e7c 100644
> > > > > > --- a/include/uapi/linux/videodev2.h
> > > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > > @@ -661,6 +661,8 @@ struct v4l2_pix_format {
> > > > > >    #define V4L2_PIX_FMT_NV12MT_16X16 v4l2_fourcc('V', 'M', '1',=
 '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
> > > > > >    #define V4L2_PIX_FMT_NV12M_8L128      v4l2_fourcc('N', 'A', =
'1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
> > > > > >    #define V4L2_PIX_FMT_NV12M_10BE_8L128 v4l2_fourcc_be('N', 'T=
', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
> > > > > > +#define V4L2_PIX_FMT_NV12M_V4H1C v4l2_fourcc('S', 'Y', '1', '2=
')   /* 12  Y/CbCr 4:2:0 tiles */
> > > > > > +#define V4L2_PIX_FMT_NV12M_10_V4H3P8C v4l2_fourcc('S', 'Y', '1=
', '0')   /* 12  Y/CbCr 4:2:0 10-bits tiles */
> > > > > >=20
> > > > > >    /* Bayer formats - see https://urldefense.proofpoint.com/v2/=
url?u=3Dhttp-3A__www.siliconimaging.com_RGB-2520Bayer.htm&d=3DDwIFaQ&c=3D7d=
fBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=3DP4xb2_7biqBxD4LGGPrSV6j-jf3C3=
xlR7PXU-mLTeZE&m=3DlkQiuhx0yMAYHGcW-0WaHlF3e2etMHsu-FoNIBdZILGH6FPigwSAmel2=
vAdcVLkp&s=3DJKsBzpb_3u9xv52MaMuT4U3T1pPqcObYkpHDBxvcx_4&e=3D   */
> > > > > >    #define V4L2_PIX_FMT_SBGGR8  v4l2_fourcc('B', 'A', '8', '1')=
 /*  8  BGBG.. GRGR.. */
> > >=20
> >=20
>=20

