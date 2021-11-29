Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A8461B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhK2Pvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:51:37 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:37716 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344446AbhK2Ptd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:49:33 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 323622A5;
        Mon, 29 Nov 2021 16:46:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638200774;
        bh=OCciDv5FkJoDANYroVNfeLNyaZxemuwDU6qmphvOn2s=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=atSdqR3kwo0G4uioRmygZIsVGTXFaFcOUrvp5YLv1Q/2qWlUVfI5kG9hnXeQRVkjp
         A5j0+HQcaxVCo3BejWDbIHhdO1R6VH+Fiwk5FunMvI+w6wOzqPBWPa06BL/S+t2hMH
         kIZ87Brr/SpWRw/gEPW3nhD3JKsDmuN6BIDlDym8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211019114718.827400-1-dorota.czaplejewicz@puri.sm>
References: <20211019114718.827400-1-dorota.czaplejewicz@puri.sm>
Subject: Re: [PATCH] media: Add 16-bit Bayer formats
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     Andrey Konovalov <andrey.konovalov@linaro.org>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:46:11 +0000
Message-ID: <163820077159.3059017.10242072140890692995@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dorota,

Quoting Dorota Czaplejewicz (2021-10-19 12:59:29)
> 16-bit bayer formats are used by the i.MX driver.

Can we expand upon this at all?

The Subject says "Add 16-bit Bayer formats" but this isn't adding the
format, it's purely extending the v4l2_format_info table with the
information for that format which is otherwise missing.

I wonder what other formats are missing from that table too?


> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> ---
> Hello,
>=20
> While working on the i.MX8 video driver, I discovered that `v4l2_fill_pix=
fmt` will fail when using 10-bit sensor formats. (For background, see the c=
onversation at https://lkml.org/lkml/2021/10/17/93 .)
>=20
> It appears that the video hardware will fill a 16-bit-per-pixel buffer wh=
en fed 10-bit-per-pixel Bayer data, making `v4l2_fill_pixfmt` effectively b=
roken for this case.

This statement is confusing to me. Are you saying you're programming the
hardware with 10 bit, and it's using 16 bits per pixel to store that
data? (Which is simply 'unpacked' I think ?)


>=20
> This change adds the relevant entries to the format info structure.
>=20
> Difference in behaviour observed using the i846 driver on the Librem 5.
>=20
> Regards,
> Dorota Czaplejewicz
>=20
>  drivers/media/v4l2-core/v4l2-common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 04af03285a20..d2e61538e979 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -309,6 +309,10 @@ const struct v4l2_format_info *v4l2_format_info(u32 =
format)
>                 { .format =3D V4L2_PIX_FMT_SGBRG12,       .pixel_enc =3D =
V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, =
0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
>                 { .format =3D V4L2_PIX_FMT_SGRBG12,       .pixel_enc =3D =
V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, =
0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
>                 { .format =3D V4L2_PIX_FMT_SRGGB12,       .pixel_enc =3D =
V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, =
0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> +               { .format =3D V4L2_PIX_FMT_SBGGR16,       .pixel_enc =3D =
V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, =
0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> +               { .format =3D V4L2_PIX_FMT_SGBRG16,       .pixel_enc =3D =
V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, =
0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> +               { .format =3D V4L2_PIX_FMT_SGRBG16,       .pixel_enc =3D =
V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, =
0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> +               { .format =3D V4L2_PIX_FMT_SRGGB16,       .pixel_enc =3D =
V4L2_PIXEL_ENC_BAYER, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, =
0, 0, 0 }, .hdiv =3D 1, .vdiv =3D 1 },

This looks right as far as I can see though, so for the change, and
ideally with the commit message improved to be clearer about the
content and reasoning for the change:

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>         };
>         unsigned int i;
> =20
> --=20
> 2.31.1
>
