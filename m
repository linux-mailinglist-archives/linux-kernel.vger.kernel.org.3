Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA94D1303
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiCHJFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiCHJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:05:19 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE673CA4F;
        Tue,  8 Mar 2022 01:04:23 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id o6so24100116ljp.3;
        Tue, 08 Mar 2022 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=jZ+MIPcrQgiBvV9esILrCWNT+QHgAhnZB9Zx1WBFYKc=;
        b=pui7J67Xw0oUhnvd1RD87Sklk4hyTKg8ESiVGpiLW24baD11IcU6C72omNUGBUj205
         x9r3fmMbZEiBrJmqcc+fgRHdt7xJopBaXDrnBKx3h0bMIP4KZglWcNopNsB9lrc/WlZC
         HYtptWeqibQRoeQR0RYMm6Y/M9UhtqSMINpSoZM3blx1AJcqy8eRlSkPtcP/mJ8s60Yn
         91YOiy+wbd5ZkAoyxgCAVOlwt11F85Es5rYj07iyUGPLsgK6Kbe6x7AK7OxxaxOmynhv
         bSOfPQ0Yn9ng5C7QssOpL6rb0ydubd9YTqemDg3D3b39XpS0y1AcOMLuH2I1gABcamm5
         Gw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=jZ+MIPcrQgiBvV9esILrCWNT+QHgAhnZB9Zx1WBFYKc=;
        b=kRkj6mGNXUolpzK0gpZ3q3h0Jrg40sWEPqR32ntnSqGGk2z3uWEKA+JTKqVZiikHUG
         fbMY08Ti0gU9kHlud/U2xiuDHfaJblhaTP1dd755Qe/25Lju5Bsfv/dBM3YBthyg4hBp
         rslkbpfJn93ZtCZIGNCqSnCinbHrjebfHRKu8cQlP6O6YvuLc7/KkzYPNs0TToT1wAgJ
         IihHroOJqbW5hiwbzToq81+YFfib63+VZfrP4CuGZGzTrvR1nOFLIFHmjRQfI0JrDon5
         +wdHIbmYi6HqqrM6yNvMlp9E2WhYhQaQZpht/Dr1iBqH1gnMfKr7B/C+9ie0OpMdqaZ/
         jLTw==
X-Gm-Message-State: AOAM5323+VqFBI9E11sM/BsNJ5Ycfb6yPR6En2j3J5pjyqh5AxGbss4M
        KIxoray5TBFgvYGiS8SmPio=
X-Google-Smtp-Source: ABdhPJxxTef3eaNlDryAFPPL5nF0q4IhFtlUhPg8XzybHkrwi6IlWSoA/8AUiwzzDQGcesZTH9iplg==
X-Received: by 2002:a2e:aaa3:0:b0:230:21db:210b with SMTP id bj35-20020a2eaaa3000000b0023021db210bmr10411422ljb.394.1646730261407;
        Tue, 08 Mar 2022 01:04:21 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id w10-20020ac2442a000000b0044835a52a08sm802928lfl.163.2022.03.08.01.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:04:21 -0800 (PST)
Date:   Tue, 8 Mar 2022 11:04:17 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] drm/fourcc: Add DRM_FORMAT_C[124]
Message-ID: <20220308110417.37290c65@eldfell>
In-Reply-To: <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
References: <cover.1646683502.git.geert@linux-m68k.org>
        <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VBZDq9jhkM14hkgWzHPGink";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VBZDq9jhkM14hkgWzHPGink
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Mar 2022 21:52:40 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Introduce fourcc codes for color-indexed frame buffer formats with two,
> four, and sixteen colors, and provide a mapping from bit per pixel and
> depth to fourcc codes.
>=20
> As the number of bits per pixel is less than eight, these rely on proper
> block handling for the calculation of bits per pixel and pitch.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Improve pixel descriptions,
>   - Require depth to match bpp in drm_mode_legacy_fb_format(),
>   - Set .is_color_indexed flag.
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 21 +++++++++++++++++++++
>  include/uapi/drm/drm_fourcc.h |  5 ++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 6c76bd821d17e7c7..29f4fe199c4ddcf0 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -43,6 +43,21 @@ uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint3=
2_t depth)
>  	uint32_t fmt =3D DRM_FORMAT_INVALID;
> =20
>  	switch (bpp) {
> +	case 1:
> +		if (depth =3D=3D 1)
> +			fmt =3D DRM_FORMAT_C1;
> +		break;
> +
> +	case 2:
> +		if (depth =3D=3D 2)
> +			fmt =3D DRM_FORMAT_C2;
> +		break;
> +
> +	case 4:
> +		if (depth =3D=3D 4)
> +			fmt =3D DRM_FORMAT_C4;
> +		break;
> +
>  	case 8:
>  		if (depth =3D=3D 8)
>  			fmt =3D DRM_FORMAT_C8;
> @@ -132,6 +147,12 @@ EXPORT_SYMBOL(drm_driver_legacy_fb_format);
>  const struct drm_format_info *__drm_format_info(u32 format)
>  {
>  	static const struct drm_format_info formats[] =3D {
> +		{ .format =3D DRM_FORMAT_C1,		.depth =3D 1,  .num_planes =3D 1,
> +		  .char_per_block =3D { 1, }, .block_w =3D { 8, }, .block_h =3D { 1, }=
, .hsub =3D 1, .vsub =3D 1, .is_color_indexed =3D true },
> +		{ .format =3D DRM_FORMAT_C2,		.depth =3D 2,  .num_planes =3D 1,
> +		  .char_per_block =3D { 1, }, .block_w =3D { 4, }, .block_h =3D { 1, }=
, .hsub =3D 1, .vsub =3D 1, .is_color_indexed =3D true },
> +		{ .format =3D DRM_FORMAT_C4,		.depth =3D 4,  .num_planes =3D 1,
> +		  .char_per_block =3D { 1, }, .block_w =3D { 2, }, .block_h =3D { 1, }=
, .hsub =3D 1, .vsub =3D 1, .is_color_indexed =3D true },
>  		{ .format =3D DRM_FORMAT_C8,		.depth =3D 8,  .num_planes =3D 1, .cpp =
=3D { 1, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_color_indexed =3D true },
>  		{ .format =3D DRM_FORMAT_R8,		.depth =3D 8,  .num_planes =3D 1, .cpp =
=3D { 1, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
>  		{ .format =3D DRM_FORMAT_R10,		.depth =3D 10, .num_planes =3D 1, .cpp =
=3D { 2, 0, 0 }, .hsub =3D 1, .vsub =3D 1 },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index fc0c1454d2757d5d..457ed39cc48f08e1 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -99,7 +99,10 @@ extern "C" {
>  #define DRM_FORMAT_INVALID	0
> =20
>  /* color index */
> -#define DRM_FORMAT_C8		fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
> +#define DRM_FORMAT_C1		fourcc_code('C', '1', ' ', ' ') /* [7:0] C0:C1:C2=
:C3:C4:C5:C6:C7 1:1:1:1:1:1:1:1 eight pixels/byte */
> +#define DRM_FORMAT_C2		fourcc_code('C', '2', ' ', ' ') /* [7:0] C0:C1:C2=
:C3 2:2:2:2 four pixels/byte */
> +#define DRM_FORMAT_C4		fourcc_code('C', '4', ' ', ' ') /* [7:0] C0:C1 4:=
4 two pixels/byte */
> +#define DRM_FORMAT_C8		fourcc_code('C', '8', ' ', ' ') /* [7:0] C 8 one =
pixel/byte */
> =20
>  /* 8 bpp Red */
>  #define DRM_FORMAT_R8		fourcc_code('R', '8', ' ', ' ') /* [7:0] R */

Hi Geert,

this patch looks good to me, so

Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

--Sig_/VBZDq9jhkM14hkgWzHPGink
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmInHBIACgkQI1/ltBGq
qqcvIQ/+Iq3B29/S8YElzMbwhbRbCnHjVokyhitB/SEdNY4JMNb4FMtMUhAMRxSF
Uo31tlj5O5NB91q20uMJCBduXO/YSRaLmoLs15/KmRjgtQ0gPE8XuZlfOc5y7cRR
XSpGqgcmzjjAC8lUEknvkg1petE8GGa3gbuQzVB22gvkNNGaUFrrsdHsmOm7d1bz
M8MbwGpI2xZZp1I6c4LqSCLNlLZaSi5N31EtZp5zgJfGVCavF1WyooHB1DNe/U3K
OLYMPaTtVYomsMH9qYx2VWPWTJ/oVWN1lNe88BltTNNdXd+8GJo32KObx0JC34CB
WgmJLrirf9LdhoaAjyEWSwUg5tlyU8I6NQQWL+rP7ITsU/Sdgmno1Ccl48dwltyt
zoJHLym33F6jZGY3cLAi3aNvs3MRNr81if410QQZjeutX0+VEFeilbnypTWaRUiu
iDY3sLIJyvnrfAnZQmfpz1xHmyVxriRxatYA2Uco6v+yw4Qn78Bwnxkgp6nMDNy7
dom+5l2xjgf3BNyjdBj70UJ1+T+Ctpc5sytm8eXfiMMazeudXybSYGuBrep2r0oz
R3QcikKUeJkZevDcxsptDXNx7ocHEzU4v406hvnTv6k5dQnJqH6hC6Tala/JbCxz
A2D+Y+Oz/EfOS1i7u27CEhHU2ou666eHzdpTFh2aiNdSnJSAJ3s=
=UfSs
-----END PGP SIGNATURE-----

--Sig_/VBZDq9jhkM14hkgWzHPGink--
