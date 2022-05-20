Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3874952F35E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352268AbiETSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353168AbiETSn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:43:27 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FCF5E769
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:43:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a22so7713697qkl.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=TTPdN7iV1g2+qrFg1rp0eZkNNp0LmZaEHviGZ0GRfMA=;
        b=bD4NJK4/USmoyRzS1BTjWO3mZPFXPtD3q2w+NVUuHLb619v4bGi+kVJHaHYdR2RqgJ
         ytLc8+AKjnW21VKWjdxZo1NSstNd1a3qj2USgsOq1VuyEgHF7qz6T5VfGHLBls6boLH6
         Qa1pk1s6Ren8DUMjehUA2quoqAubLg2IcLRokqSvALoBnr9tW98dXfIovmfc+KOcfwiU
         zqKzcTfQ+plsxoYuj5wtEnS735AlmuPLmY4ezaBCtg09ZX+r3cQ2kKXjTHiIEAaX05B+
         u0ab/ZMujqECPEs8OWRgb0ndbawVWPIJhRDAyJVUalHDzhHEmL1tQ7Fh5+vmoejpI/vF
         0Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=TTPdN7iV1g2+qrFg1rp0eZkNNp0LmZaEHviGZ0GRfMA=;
        b=COFfcO220p19zosStFV6OPOfWSj40ZXrglm/rOZcxEeVWQJXjZOYFU1bDOzu/kYyiw
         7j9tktczeadTAvfMNHnX8MO+mcDyfBQl+DZboH9Adv4XyAweARoydm/RTA2PPXBiX4kI
         BypZKxM+I3OZvkYJ6mLXv+ds+42YC+xnXwqBVIsWRPsfjTStHgJHqbLLvhR+T9gL+fSO
         m+sfLlH+eZlDAdmH7BG/+vs48yf/lFt4ZhYAsxN1u8AMHybIb5+QHwdyD9K+3z1vFScW
         AKxEWwXCWDBvuGzZnaYvNsXPp4HfWls35OLuXnRmLzUUDyWjcXQlrWjvLKLsv9x5ShO8
         74nw==
X-Gm-Message-State: AOAM5318C1izd6r/8Mf3b6Xu1VUNWtRj4nmKukmSXtLI5DeDxOlJmsmL
        HTr3r58QKv9zGTO9QeGLo2OaiLes/aNMbJLH
X-Google-Smtp-Source: ABdhPJw/HiPUL5BMlrX2E+aFG0czQf/p6GA0oJOEjs0f/SYmPAOZugdgTzG2J+epz6v3PmuIpk4e1Q==
X-Received: by 2002:a05:620a:4308:b0:67b:487e:e02a with SMTP id u8-20020a05620a430800b0067b487ee02amr7191021qko.696.1653072205118;
        Fri, 20 May 2022 11:43:25 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id w15-20020ac84d0f000000b002f90517bc25sm128616qtv.41.2022.05.20.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:43:24 -0700 (PDT)
Message-ID: <5056559927df64d8cac8831a13db0c266e5fff65.camel@ndufresne.ca>
Subject: Re: [PATCH v3 4/5] media: Add HEXTILE compressed format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Date:   Fri, 20 May 2022 14:43:22 -0400
In-Reply-To: <20220520024744.25655-5-milkfafa@gmail.com>
References: <20220520024744.25655-1-milkfafa@gmail.com>
         <20220520024744.25655-5-milkfafa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 20 mai 2022 =C3=A0 10:47 +0800, Marvin Lin a =C3=A9crit=C2=A0:
> Add HEXTILE compressed format. This format is defined in Remote Framebuff=
er
> Protocol (RFC 6143) and is used by Encoding Compression Engine present on
> Nuvoton NPCM SoCs.

Ah, ancient RFB compression. I also found that there is encoder/decoders pa=
rt of
FFMPEG and GStreamer VMNC (VMWare CODECs) and also a decoder in GStreamer R=
FB
plugin. It is though an obsolete format for all of these technology, thanks=
 for
identifying clearly.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
>  include/uapi/linux/videodev2.h                            | 1 +
>  3 files changed, 9 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/=
Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index cabfa34b7db5..bad2b9a2f16e 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -239,6 +239,13 @@ please make a proposal on the linux-media mailing li=
st.
>  	It remains an opaque intermediate format and the MDP hardware must be
>  	used to convert ``V4L2_PIX_FMT_MT21C`` to ``V4L2_PIX_FMT_NV12M``,
>  	``V4L2_PIX_FMT_YUV420M`` or ``V4L2_PIX_FMT_YVU420``.
> +    * .. _V4L2-PIX-FMT-HEXTILE:
> +
> +      - ``V4L2_PIX_FMT_HEXTILE``
> +      - 'HXTL'
> +      - Compressed format used by Nuvoton NPCM video driver. This format=
 is
> +        defined in Remote Framebuffer Protocol (RFC 6143, chapter 7.7.4 =
Hextile
> +        Encoding).
>  .. raw:: latex
> =20
>      \normalsize
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 96e307fe3aab..9365519d65bb 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1441,6 +1441,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_SE401:	descr =3D "GSPCA SE401"; break;
>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr =3D "S5C73MX interleaved UYVY/JP=
EG"; break;
>  		case V4L2_PIX_FMT_MT21C:	descr =3D "Mediatek Compressed Format"; break=
;
> +		case V4L2_PIX_FMT_HEXTILE:	descr =3D "Hextile Compressed Format"; brea=
k;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3768a0a80830..1c7af015b43b 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -746,6 +746,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel P=
lanar Greyscale 10-bit and Depth 16-bit */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4=
-bit packed depth confidence information */
>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-=
bit dithered RGB */
> +#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile=
 compression */
> =20
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits=
 unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU=
3 packed 10-bit BGGR bayer */

