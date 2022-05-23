Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47F53075B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiEWB6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiEWB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:58:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2BA35878;
        Sun, 22 May 2022 18:57:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ck4so21463907ejb.8;
        Sun, 22 May 2022 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7JqWllCs3vhH9VsQsjnqrm5TtmnBoPN+MvjRnZp0YAA=;
        b=G6Ubz6L6v5jT0AkYXXJDrCZICkRZdfUi8eKRmLQXCihmG9XmT2X1gTnhT8jpxSVRbE
         1/8Idzb5woiYV9wxX3njifVD1zGpQcXtpsjAPuN9gB8PMqw/1dYt0zwtKH1Gqe3fb98I
         IhVMRSSpbthGHq0kZ/5FQxIzS78/nykd7/XTfJylj2eCwcrj9J2O0+mMYcCZUJhHGfUJ
         8pqC+Zvwl0TZL1OjteG3j/n1lpI2BqHuoNVGP9tB7oGqOZuokKLcC5MVzqNJnloToJd8
         SPObcaySQ++vrO+kemGbMXG7y3G71/sEP9ocAh1QeqcNk8Qurs+U91F8kcFDqE9PwLW4
         Uyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7JqWllCs3vhH9VsQsjnqrm5TtmnBoPN+MvjRnZp0YAA=;
        b=Do9jvxNlkj6esRGYP1lG+GVfMzNNAMcRC8QBpt4AsTVeNrj4xie2NlkuizKYpxV3wj
         zrzvD/jkBJDVXWcFPoMqFejW5o0bUN2BjcdMeS30iPZkhcM5gPDJtmkity8urJBztPGq
         YNKrO4DzkeOGWeYD+lqcG/baxFMSvY0jpbZCQ5dFyjeU1f0c3k34kFFAZ63nbzir2iNm
         M17WpicfzGh2SYRT+bwsFSRjUB7uIQoSVejSg/S9xQ1n7KnO040xPtdAQSjmZqpZryPy
         tKsMhGpcL00Lpc+vyTvlMSVht6GmUljCXUDo6vWEuwFbdm6HGxrko41C4kRaN+Fet5J+
         G0yQ==
X-Gm-Message-State: AOAM531ouchmeT2lPu1VN5hVdzDsT5W0c1XI5zdaQ9w1A4FzuACBJ5P3
        st31Y7bQSbmRUKOaMSeoI1x1BpIb/wFeKLQXoNo4vSXBQaNciA==
X-Google-Smtp-Source: ABdhPJzsG+59xP0nKvzn2eD5Z561HBO/XiDJuv0h3y3pEWJ0QJ4ih/LW4gseHs5gqkcoQpRuXs2YaAWVFhcZtLGBCKM=
X-Received: by 2002:a17:907:c290:b0:6fe:c2b8:bb6b with SMTP id
 tk16-20020a170907c29000b006fec2b8bb6bmr6489890ejc.222.1653271077701; Sun, 22
 May 2022 18:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220520024744.25655-1-milkfafa@gmail.com> <20220520024744.25655-5-milkfafa@gmail.com>
 <5056559927df64d8cac8831a13db0c266e5fff65.camel@ndufresne.ca>
In-Reply-To: <5056559927df64d8cac8831a13db0c266e5fff65.camel@ndufresne.ca>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 23 May 2022 09:57:50 +0800
Message-ID: <CADnNmFoAurSSqCMvQPnzr3HwtkdMsjyj_ZDDwJGxYFfnk7LwXw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] media: Add HEXTILE compressed format
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        CS20 KWLiu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Nicolas,

Thanks for your review!

Regards,
Marvin

Nicolas Dufresne <nicolas@ndufresne.ca> =E6=96=BC 2022=E5=B9=B45=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Le vendredi 20 mai 2022 =C3=A0 10:47 +0800, Marvin Lin a =C3=A9crit :
> > Add HEXTILE compressed format. This format is defined in Remote Framebu=
ffer
> > Protocol (RFC 6143) and is used by Encoding Compression Engine present =
on
> > Nuvoton NPCM SoCs.
>
> Ah, ancient RFB compression. I also found that there is encoder/decoders =
part of
> FFMPEG and GStreamer VMNC (VMWare CODECs) and also a decoder in GStreamer=
 RFB
> plugin. It is though an obsolete format for all of these technology, than=
ks for
> identifying clearly.
>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>
> >
> > Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> > ---
> >  Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
> >  drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
> >  include/uapi/linux/videodev2.h                            | 1 +
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> > index cabfa34b7db5..bad2b9a2f16e 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> > @@ -239,6 +239,13 @@ please make a proposal on the linux-media mailing =
list.
> >       It remains an opaque intermediate format and the MDP hardware mus=
t be
> >       used to convert ``V4L2_PIX_FMT_MT21C`` to ``V4L2_PIX_FMT_NV12M``,
> >       ``V4L2_PIX_FMT_YUV420M`` or ``V4L2_PIX_FMT_YVU420``.
> > +    * .. _V4L2-PIX-FMT-HEXTILE:
> > +
> > +      - ``V4L2_PIX_FMT_HEXTILE``
> > +      - 'HXTL'
> > +      - Compressed format used by Nuvoton NPCM video driver. This form=
at is
> > +        defined in Remote Framebuffer Protocol (RFC 6143, chapter 7.7.=
4 Hextile
> > +        Encoding).
> >  .. raw:: latex
> >
> >      \normalsize
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index 96e307fe3aab..9365519d65bb 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1441,6 +1441,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc =
*fmt)
> >               case V4L2_PIX_FMT_SE401:        descr =3D "GSPCA SE401"; =
break;
> >               case V4L2_PIX_FMT_S5C_UYVY_JPG: descr =3D "S5C73MX interl=
eaved UYVY/JPEG"; break;
> >               case V4L2_PIX_FMT_MT21C:        descr =3D "Mediatek Compr=
essed Format"; break;
> > +             case V4L2_PIX_FMT_HEXTILE:      descr =3D "Hextile Compre=
ssed Format"; break;
> >               default:
> >                       if (fmt->description[0])
> >                               return;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 3768a0a80830..1c7af015b43b 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -746,6 +746,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel=
 Planar Greyscale 10-bit and Depth 16-bit */
> >  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel=
 4-bit packed depth confidence information */
> >  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV =
8-bit dithered RGB */
> > +#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hexti=
le compression */
> >
> >  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bi=
ts unused */
> >  #define V4L2_PIX_FMT_IPU3_SBGGR10    v4l2_fourcc('i', 'p', '3', 'b') /=
* IPU3 packed 10-bit BGGR bayer */
>
