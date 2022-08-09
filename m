Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC158D79E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242710AbiHIKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiHIKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:50:37 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48F555A7;
        Tue,  9 Aug 2022 03:50:33 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1171E1C0003; Tue,  9 Aug 2022 12:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1660042232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l+Hf7cwYZmOHCWYW6DFUKgfT6ABZ0nMhFyBlOZTV3ak=;
        b=eBBbAb588ByY6uJI+nodeBT2GzrlesNObPpp0S/AIkfvEVO0WlKz63YEma66+Nb5XP8D9Q
        l1RAIlcrlqjPJiNUgSeVyFCuCgLeloPmEXX6xKU9fQd/Xzu1wRcjHG3dqoLcrSE1nYQEoL
        3Wb9TPgV6l+xR+tBKnK3hVG8Z27H1vA=
Date:   Tue, 9 Aug 2022 12:50:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     hdegoede@redhat.com, andy.shevchenko@gmail.com,
        pobrn@protonmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB
 control
Message-ID: <20220809105031.GA4971@duo.ucw.cz>
References: <20220809025054.1626339-1-luke@ljones.dev>
 <20220809025054.1626339-2-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20220809025054.1626339-2-luke@ljones.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Adds support for TUF laptop RGB control via the multicolor LED API.
>=20
> As this is the bas for adjusting only the RGB values, it sets the
> default mode of the keyboard to static since there is no way to read
> any existing settings from the device. These defaults overwrite the
> booted state of the keyboard when the module is loaded.

> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
> +		struct mc_subled *mc_led_info =3D asus->keyboard_rgb_mode.subled_info;
> +		struct led_classdev_mc *mc_cdev =3D &asus->keyboard_rgb_mode.dev;
> +		struct device *dev =3D &asus->platform_device->dev;
> +		u8 led_brightness =3D 255;
> +
> +		/*
> +		 * asus::kbd_backlight still controls a base 3-level backlight and when
> +		 * it is on 0, the RGB is not visible at all. RGB should be treated as
> +		 * an additional step.
> +		 */

Ouch. Lets not do that? If rgb interface is available, hide the 3
level one, or something.

> +		mc_cdev->led_cdev.name =3D   "asus::multicolour::kbd_backlight";

Make this "rgb:kbd_backlight" or "inputX:rgb:kbd_backligh" and
document it in Documentation/leds/well-known-leds.txt.

Thanks and best regards,
										Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYvI79wAKCRAw5/Bqldv6
8sdWAJ4rC+HTcJctMx3yKybeVCUyLk+l9gCfdFRsmnQksDv9b7aEeWafABCmqts=
=/0qH
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
