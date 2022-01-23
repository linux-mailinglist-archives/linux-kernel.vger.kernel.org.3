Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845F34975A9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 22:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbiAWVFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 16:05:23 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:43316 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231262AbiAWVFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 16:05:22 -0500
Received: from g550jk.localnet (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 79ED8CE792;
        Sun, 23 Jan 2022 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642971921; bh=IepC/lcWLa4xj3rFu2AkdVzFzFWRURTPQvg3KPrFWsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aW4eF76oHrvPRmzXRUKTyVUWIYBsZvhdMKp8LETBwcPilSAQ4/4ZS4TzpfJkNkdfT
         7ok2QGSiAlqy3bEEpsqpUeFK6fqAEWx1YH/LQ41r98kNx2/3ZVG4HhrRTZ3WWsMynt
         CzhwNUGes4abuBlEIH/kYV9lQuZv7WM+SRNUJIjY=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: add missing dependency to DRM_PANEL_EDP
Date:   Sun, 23 Jan 2022 22:05:21 +0100
Message-ID: <5630750.DvuYhMxLoT@g550jk>
In-Reply-To: <20220123204322.345725-1-luca@z3ntu.xyz>
References: <20220123204322.345725-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 23. J=E4nner 2022 21:43:23 CET Luca Weiss wrote:
> With CONFIG_DRM_PANEL_EDP=3Dy and CONFIG_DRM_KMS_HELPER=3Dm the compilati=
on
> fails:
>=20
>   drivers/gpu/drm/panel/panel-edp.c:843: undefined reference to
> `drm_panel_dp_aux_backlight'
>=20
> Add a dependency on DRM_KMS_HELPER to fix this.
>=20

=46orgot to add, this is the closest "Fixes" I can find, before that commit=
 with=20
arm32 qcom_defconfig both beforementioned options were builtin

=46ixes: 9d6366e743f3 ("drm: fb_helper: improve CONFIG_FB dependency")

> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> I briefly tried "select DRM_KMS_HELPER" but that causes a circular
> dependency.
> If someone has a better idea how to solve this, feel free correct me.
>=20
>  drivers/gpu/drm/panel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 434c2861bb40..fda97837ecb3 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -102,6 +102,7 @@ config DRM_PANEL_SIMPLE
>  config DRM_PANEL_EDP
>  	tristate "support for simple Embedded DisplayPort panels"
>  	depends on OF
> +	depends on DRM_KMS_HELPER
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on PM
>  	select VIDEOMODE_HELPERS




