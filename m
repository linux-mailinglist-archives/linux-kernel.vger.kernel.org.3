Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080225456C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiFIVwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFIVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:52:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD18A062
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:52:40 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 319886601748;
        Thu,  9 Jun 2022 22:52:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654811559;
        bh=hzcu5sdIJJWCnpavzec0mqFyz1peWQ1HO+++C+r2JAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVFed3fjsrqiQpdxWiXCb6xLSiNMyaxNjZyINX5YzOeAHSlUUihbzujUN8Cl+WF0U
         lDRzDh0fjAs8Rgvm4mznMVgryLF/uM+kLdIFyaLf8+EV1rk5bWgMED8I2Cv6Doms7M
         l1m/LlVRP63HrGg0MztCxxVbBRoFbnv4E5bf3cKk1/ATXwRv8Cyc5rDGcPyfS/Z5fT
         wWxqsw0K8LLwhtFhf5jRvYYS5a+QGKo5lplFeHxy3PBtNGdA573gcDrOTKLU5lH0N8
         0xXoyuE88Ge+NAc+DJHu5wuiI3c9D6T3h+iC1PdQxDZY3gDS/UKAG2Kjz+kHG13Jk3
         TBknZ9OKd5w8Q==
Received: by mercury (Postfix, from userid 1000)
        id F3CAD10605B9; Thu,  9 Jun 2022 23:52:36 +0200 (CEST)
Date:   Thu, 9 Jun 2022 23:52:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/panel: panel-dsi-cm: Use backlight helpers
Message-ID: <20220609215236.ojxw6l2vkf652hgu@mercury.elektranox.org>
References: <20220607182026.1121992-1-steve@sk2.org>
 <20220607182026.1121992-3-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uo2obknpz3hrt7sr"
Content-Disposition: inline
In-Reply-To: <20220607182026.1121992-3-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uo2obknpz3hrt7sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 07, 2022 at 08:20:25PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>=20
> Instead of setting the power state by manually updating fields in
> struct backlight_properties, use backlight_enable() and
> backlight_disable(). These also call backlight_update_status() so the
> separate call is no longer needed.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> ---
>
>  drivers/gpu/drm/panel/panel-dsi-cm.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel=
/panel-dsi-cm.c
> index b58cb064975f..aa36dc6cedd3 100644
> --- a/drivers/gpu/drm/panel/panel-dsi-cm.c
> +++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
> @@ -86,16 +86,10 @@ static void dsicm_bl_power(struct panel_drv_data *dda=
ta, bool enable)
>  		return;
> =20
>  	if (enable) {
> -		backlight->props.fb_blank =3D FB_BLANK_UNBLANK;
> -		backlight->props.state =3D ~(BL_CORE_FBBLANK | BL_CORE_SUSPENDED);
> -		backlight->props.power =3D FB_BLANK_UNBLANK;
> +		backlight_enable(backlight);
>  	} else {
> -		backlight->props.fb_blank =3D FB_BLANK_NORMAL;
> -		backlight->props.power =3D FB_BLANK_POWERDOWN;
> -		backlight->props.state |=3D BL_CORE_FBBLANK | BL_CORE_SUSPENDED;
> +		backlight_disable(backlight);
>  	}

The brackets can be removed now. Otherwise:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> -
> -	backlight_update_status(backlight);
>  }
> =20
>  static void hw_guard_start(struct panel_drv_data *ddata, int guard_msec)
> @@ -196,13 +190,7 @@ static int dsicm_bl_update_status(struct backlight_d=
evice *dev)
>  {
>  	struct panel_drv_data *ddata =3D dev_get_drvdata(&dev->dev);
>  	int r =3D 0;
> -	int level;
> -
> -	if (dev->props.fb_blank =3D=3D FB_BLANK_UNBLANK &&
> -			dev->props.power =3D=3D FB_BLANK_UNBLANK)
> -		level =3D dev->props.brightness;
> -	else
> -		level =3D 0;
> +	int level =3D backlight_get_brightness(dev);
> =20
>  	dev_dbg(&ddata->dsi->dev, "update brightness to %d\n", level);
> =20
> @@ -219,11 +207,7 @@ static int dsicm_bl_update_status(struct backlight_d=
evice *dev)
> =20
>  static int dsicm_bl_get_intensity(struct backlight_device *dev)
>  {
> -	if (dev->props.fb_blank =3D=3D FB_BLANK_UNBLANK &&
> -			dev->props.power =3D=3D FB_BLANK_UNBLANK)
> -		return dev->props.brightness;
> -
> -	return 0;
> +	return backlight_get_brightness(dev);
>  }
> =20
>  static const struct backlight_ops dsicm_bl_ops =3D {
> --=20
> 2.30.2
>=20

--uo2obknpz3hrt7sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKia6EACgkQ2O7X88g7
+pqSsA//QktD/WmlqL+qcD6FFq2qNMPgubTfREKR6uh6HfXyJLAvv6K3Qhht/wTW
xWvLwhARTKO9OwFHXY+qImmvsOSjLGV/lPaoaRP4/w5N7JATjTk2G5bucG//L6zu
agCIuQI/3PddHhToi+3zH+B+A9Iggy0AkfyHvhvYXxVuOJJ+fzKvPPTyvILWFZ/8
mGWZS0vHxEXWI9NUdAYjyuvcfavXFTYrSgIGqd6lPYUNEor37UkbfFeHG62lDB66
Cun0Dy0djURBet71rjQ2+wSc7w8s3ofNXw5ow33RXnmQHCYTqvI4rC3us5C3z4ZC
WO16JLeEfGVVg+kQhZ85GQvmSh2KK+hBfpb9WwxMyM5WjM+LFGq/MrF0wUSMcmY/
SU3f5Df1XOGp2yiajZrcoSuKsILvbF2BADsyZxDGaffB71rAUFzpnHfpJlPFPQMI
S+rhVSRW6Iybi0Wsfd2mDMdJkTUsM/sKaIP9Q5Mi3sRyp2GzLdcoKRwfSjkW8F7t
RtCvmD3sjO8ZEOR+I7UshqcMIKGm7DGpxdz3bAUcCQF4cAT9AF4zhSGPNTECeymM
tsibg0WrOE7/jzFmIV0qmUaL0mEvmxomVK5f/upnGVLUwgOsD3LOxONn/jGmjz6e
w33u0FvLLrZNmCQ6prDhQlu2rAcoNbIDLUIvbuyhHAbzYuRbl+k=
=akAV
-----END PGP SIGNATURE-----

--uo2obknpz3hrt7sr--
