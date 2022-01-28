Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2DA49F612
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbiA1JNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:13:46 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:37174 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347538AbiA1JNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:13:40 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4B7F2471;
        Fri, 28 Jan 2022 10:13:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643361218;
        bh=Lcc61J4YEll7UWZ9xSZRtQhWVWEkxpFSqmltcNTTKE4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=P4FdkpYlI6AHYNEVttCP1sF22oFO+Yy5CMhyHu4Rwl2X8itwuCXKgPY0ToNrxhuYJ
         RnYraHUWTleE6RlUTHovFNzzay4PZUGueYR2nKYiZR7piCUM+qt+M5cwPZUPZzfK5H
         Dklp2p/8RoF+CkANpYOsiad0tOD1bOabFysXYxX8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211217003752.3946210-32-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com> <20211217003752.3946210-32-javierm@redhat.com>
Subject: Re: [PATCH v2 31/37] drm: rcar-du: Add support for the nomodeset kernel parameter
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 09:13:36 +0000
Message-ID: <164336121612.533872.1685181669511488706@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

Quoting Javier Martinez Canillas (2021-12-17 00:37:46)
> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> parameter can be used to disable kernel modesetting.
>=20
> DRM drivers will not perform display-mode changes or accelerated rendering
> and only the system framebuffer will be available if it was set-up.

What is the 'system framebuffer' in this instance? Reading
https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt
it sounds like that means anything already set up by the bootloader.

> But only a few DRM drivers currently check for nomodeset, make this driver
> to also support the command line parameter.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> (no changes since v1)
>=20
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar=
-du/rcar_du_drv.c
> index 5a8131ef81d5..982e450233ed 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -701,6 +701,9 @@ static struct platform_driver rcar_du_platform_driver=
 =3D {
> =20
>  static int __init rcar_du_init(void)
>  {
> +       if (drm_firmware_drivers_only())
> +               return -ENODEV;
> +

This will completely disable all control of the display device when
nomodeset is enabled.

Is there any requirement for us to support outputting to the display if
it was previously set up? presumably without setting or changing any
modes, but simply allowing the existing frame to be updated?

I think the implication is that 'firmware drivers' would mean a display
could be updated through some firmware interface, which we won't have
... so it seems reasonable to accept that this whole driver can be
disabled in that instance.

Reading your mail that brought this thread up in my inbox, I think
you've already hit merge on this, so don't worry about adding a tag in
that instance, but I think this is ok.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>         rcar_du_of_init(rcar_du_of_table);
> =20
>         return platform_driver_register(&rcar_du_platform_driver);
> --=20
> 2.33.1
>
