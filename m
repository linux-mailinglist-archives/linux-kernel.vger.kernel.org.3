Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F29A4FB5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbiDKINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbiDKINo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:13:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907C3E0CB;
        Mon, 11 Apr 2022 01:11:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F06F596;
        Mon, 11 Apr 2022 10:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649664688;
        bh=MLYkgbpD54iW6+0JAiuvwZl8Q20HOOXZR9m9Prv7njw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ce7Bg1cdNzrLNOY6mAtdqI87+BAgT7n8mBUFY0XyebE2eW45SUhW8XDpVvj4tN3a4
         3ef+02Z4PslMY6wGlvA2hVC7ePDBbiC7o1d2cw2EGLIwSuowcvwKxFd7AomrjMMdU3
         9yK4dmUoLp+IQ9WJUdmdLA2kUQFb4GTuYAEyqgc0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411080120.26008-2-Ping-lei.Lin@mediatek.com>
References: <20220411080120.26008-1-Ping-lei.Lin@mediatek.com> <20220411080120.26008-2-Ping-lei.Lin@mediatek.com>
Subject: Re: [PATCH v2 1/2] media: usb: uvc: Add H265 pixel format
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Ming Qian <ming.qian@nxp.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ping-lei.lin@mediatek.com,
        lecopzer.chen@mediatek.com, max.yan@mediatek.com,
        sherlock.chang@mediatek.com, tm.wu@mediatek.com,
        James_Lin <Ping-lei.Lin@mediatek.com>
To:     James_Lin <Ping-lei.Lin@mediatek.com>, linux-kernel@vger.kernel.org
Date:   Mon, 11 Apr 2022 09:11:25 +0100
Message-ID: <164966468564.22830.10326597921182135832@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James_Lin (2022-04-11 09:01:19)
> Add H265 pixel format.
> So driver can recognize external camera devices=20
> whom use h265 to describe High Efficiency Video Coding method.
>=20
> Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 5 +++++
>  drivers/media/usb/uvc/uvcvideo.h   | 3 +++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index dda0f0aa78b8..ebb807c33e57 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] =3D {
>                 .guid           =3D UVC_GUID_FORMAT_H264,
>                 .fcc            =3D V4L2_PIX_FMT_H264,
>         },
> +       {
> +               .name           =3D "H.265",
> +               .guid           =3D UVC_GUID_FORMAT_H265,
> +               .fcc            =3D V4L2_PIX_FMT_H265,

This is not yet defined I believe, so this patch needs to be 2/2 in this
series - with your following patch first so that they can both compile
independently.

> +       },
>         {
>                 .name           =3D "Greyscale 8 L/R (Y8I)",
>                 .guid           =3D UVC_GUID_FORMAT_Y8I,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvc=
video.h
> index 143230b3275b..41f4d8c33f2a 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -139,6 +139,9 @@
>  #define UVC_GUID_FORMAT_H264 \
>         { 'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00, \
>          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> +#define UVC_GUID_FORMAT_H265 \
> +       { 'H',  '2',  '6',  '5', 0x00, 0x00, 0x10, 0x00, \
> +        0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
>  #define UVC_GUID_FORMAT_Y8I \
>         { 'Y',  '8',  'I',  ' ', 0x00, 0x00, 0x10, 0x00, \
>          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> --=20
> 2.18.0
>
