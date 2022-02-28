Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4924C71C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbiB1Qc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiB1Qc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:32:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE151E74;
        Mon, 28 Feb 2022 08:32:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p4so6022115wmg.1;
        Mon, 28 Feb 2022 08:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nspjxBI9tYzhw/PzFHLylmjKidTTydsrD7JFMGTC0VQ=;
        b=FPcvzvX3MDs+LdnqfpdttONymmd5Rh4uve9/n2nXP25NoIaAzzIdxwwWDw74Eu2KAI
         s7CcDs1KSGhtfBpOFKS9DacY1Xo9WueMmBUvHWJ3xmIJP7JG2mKiuTOJkrLHQvGUsCoX
         3MGqYVcHH8JyXnG9VDBJa2G3WdzVY2i8A6bUaV2YeoVt43Y7Gk0EGEkO8giTcRgXZEa1
         d2sIdsyHQvoAkmkkfV/trDwqaYFMLsGxnRmU6/rgU/hUm/p4fIAuhDbtVGD4HTE9KA/T
         jV9dQimHsukOP9QwzcTcDUq5vajfFEy6WqvtxDGfLVRtKL6+dKj0XvnqoXXF/qh+qYUL
         DsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nspjxBI9tYzhw/PzFHLylmjKidTTydsrD7JFMGTC0VQ=;
        b=KxqMUylY2eBOMPIWsDk/u1gLHCQySToDG3eHyWOG8WIspISukvkjZbqi+X6sF87MVo
         Bz9SwJXRmnJgxn19V3L42KpteZmtizJrBKNHhZianhlfEHypSbrG7AsBDuaKRIptu8Km
         tvR2tHFsvAwRUW1oouK1t6sTvlvuR24sEk2hPQ8fFoo2Ba+FiM1Ux4UDI26UdO4XGkAr
         2qmU3bpkNh6v91QqWIBJW5Fpq01iYlu5uuqD9MjDUWGzgSpiHKJ4I6DeSz9mX2Le3eAV
         PtNBiExv9QE1cWyyL/YLUhT7P+6Xoy8xMGRAanaJtI+HAaF4Y3cP8XBCYZzh5pb8A9Nj
         WDag==
X-Gm-Message-State: AOAM531UVyYhMB3YQ0NKcNzssqU3P5tSyKGjb+cLVIqx7JFw9tzvhphM
        VLwYI5dOkaB38ZOiL1O+V6M=
X-Google-Smtp-Source: ABdhPJy/RE308BOWztEfvBeC+M/1tepbLiYUtCH/0hJf9ShvYGyv+1u2o9DxOIVpfyR+PA44lN0jhw==
X-Received: by 2002:a05:600c:418b:b0:380:e493:660a with SMTP id p11-20020a05600c418b00b00380e493660amr13779838wmh.189.1646065935336;
        Mon, 28 Feb 2022 08:32:15 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdb84000000b001e8d8ac5394sm11503518wri.110.2022.02.28.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:32:14 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [RFC PATCH 2/8] media: Add P010 format
Date:   Mon, 28 Feb 2022 17:32:13 +0100
Message-ID: <5696849.MhkbZ0Pkbq@kista>
In-Reply-To: <1b2ce01fb04f29cca58d40bd81d9f4cc46dcebf8.camel@ndufresne.ca>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com> <20220227144926.3006585-3-jernej.skrabec@gmail.com> <1b2ce01fb04f29cca58d40bd81d9f4cc46dcebf8.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 28. februar 2022 ob 13:48:53 CET je Nicolas Dufresne=20
napisal(a):
> Le dimanche 27 f=E9vrier 2022 =E0 15:49 +0100, Jernej Skrabec a =E9crit :
> > Add P010 format, which is commonly used for 10-bit videos.
>=20
> There is a much more complete patch that was sent previously (with=20
documentation
> and all):
>=20
> https://patchwork.kernel.org/project/linux-rockchip/patch/
20210618131526.566762-5-benjamin.gaignard@collabora.com/

Great, I'll take it for next revision. Although I'm not sure what "much mor=
e=20
complete" means. Only additional thing is documentation.

Best regards,
Jernej

>=20
> regards,
> Nicolas
>=20
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-common.c | 2 ++
> >  drivers/media/v4l2-core/v4l2-ioctl.c  | 1 +
> >  include/uapi/linux/videodev2.h        | 1 +
> >  3 files changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-
core/v4l2-common.c
> > index 1db0020e08c0..4ede36546e9c 100644
> > --- a/drivers/media/v4l2-core/v4l2-common.c
> > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > @@ -275,6 +275,8 @@ const struct v4l2_format_info *v4l2_format_info(u32=
=20
format)
> >  		{ .format =3D V4L2_PIX_FMT_YUV422P, .pixel_enc =3D=20
V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 3, .bpp =3D { 1, 1,=
 1, 0 },=20
=2Ehdiv =3D 2, .vdiv =3D 1 },
> >  		{ .format =3D V4L2_PIX_FMT_GREY,    .pixel_enc =3D=20
V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 1, 0,=
 0, 0 },=20
=2Ehdiv =3D 1, .vdiv =3D 1 },
> > =20
> > +		{ .format =3D V4L2_PIX_FMT_P010,    .pixel_enc =3D=20
V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 2, 4,=
 0, 0 },=20
=2Ehdiv =3D 2, .vdiv =3D 2 },
> > +
> >  		/* Tiled YUV formats */
> >  		{ .format =3D V4L2_PIX_FMT_NV12_4L4, .pixel_enc =3D=20
V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2,=
 0, 0 },=20
=2Ehdiv =3D 2, .vdiv =3D 2 },
> >  		{ .format =3D V4L2_PIX_FMT_P010_4L4, .pixel_enc =3D=20
V4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 2, 4,=
 0, 0 },=20
=2Ehdiv =3D 2, .vdiv =3D 2 },
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-
core/v4l2-ioctl.c
> > index 048f326c57b9..a8d999e23e5b 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1295,6 +1295,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc=
=20
*fmt)
> >  	case V4L2_PIX_FMT_M420:		descr =3D "YUV 4:2:0=20
(M420)"; break;
> >  	case V4L2_PIX_FMT_NV12:		descr =3D "Y/CbCr 4:2:0"; break;
> >  	case V4L2_PIX_FMT_NV21:		descr =3D "Y/CrCb 4:2:0"; break;
> > +	case V4L2_PIX_FMT_P010:		descr =3D "10-bit Y/CbCr 4:2:0";=20
break;
> >  	case V4L2_PIX_FMT_NV16:		descr =3D "Y/CbCr 4:2:2"; break;
> >  	case V4L2_PIX_FMT_NV61:		descr =3D "Y/CrCb 4:2:2"; break;
> >  	case V4L2_PIX_FMT_NV24:		descr =3D "Y/CbCr 4:4:4"; break;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/
videodev2.h
> > index 772dbadd1a24..211bc11a48cb 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -597,6 +597,7 @@ struct v4l2_pix_format {
> >  /* two planes -- one Y, one Cr + Cb interleaved  */
> >  #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/=
CbCr=20
4:2:0  */
> >  #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/=
CrCb=20
4:2:0  */
> > +#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/=
CbCr=20
4:2:0 10-bit */
> >  #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/=
CbCr=20
4:2:2  */
> >  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/=
CrCb=20
4:2:2  */
> >  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/=
CbCr=20
4:4:4  */
>=20
>=20


