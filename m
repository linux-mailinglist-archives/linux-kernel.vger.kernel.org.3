Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52B4B8526
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiBPKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:06:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiBPKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:06:12 -0500
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 02:05:50 PST
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854CD760F;
        Wed, 16 Feb 2022 02:05:49 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B0E521C0B78; Wed, 16 Feb 2022 10:58:15 +0100 (CET)
Date:   Wed, 16 Feb 2022 10:58:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Abhijeet V <abhijeetviswa@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] asus-wmi: Use led multicolor class for keyboard
 backlight
Message-ID: <20220216095814.GA30022@amd>
References: <20220211200122.9821-1-abhijeetviswa@gmail.com>
 <20220211200122.9821-2-abhijeetviswa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20220211200122.9821-2-abhijeetviswa@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NEUTRAL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Use the led multicolor class for keyboard backlight so that support for
> rgb keyboard leds can be added for supported Asus laptops.
>=20
> Also refactored the keyboard led functions. The function names are now
> indicative of what the function does.
>=20
> Signed-off-by: Abhijeet V <abhijeetviswa@gmail.com>

Please Cc LED mailing list/maintainers with LED patches.

Best regards,
								Pavel
							=09
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -25,6 +25,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
> +#include <linux/led-class-multicolor.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
> @@ -88,6 +89,8 @@ module_param(fnlock_default, bool, 0444);
>  #define ASUS_FAN_BOOST_MODE_SILENT_MASK		0x02
>  #define ASUS_FAN_BOOST_MODES_MASK		0x03
> =20
> +#define ASUS_KBD_SUBLED_COUNT			3
> +
>  #define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT	0
>  #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
>  #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
> @@ -204,8 +207,6 @@ struct asus_wmi {
>  	int wlan_led_wk;
>  	struct led_classdev tpd_led;
>  	int tpd_led_wk;
> -	struct led_classdev kbd_led;
> -	int kbd_led_wk;
>  	struct led_classdev lightbar_led;
>  	int lightbar_led_wk;
>  	struct workqueue_struct *led_workqueue;
> @@ -213,6 +214,10 @@ struct asus_wmi {
>  	struct work_struct wlan_led_work;
>  	struct work_struct lightbar_led_work;
> =20
> +	struct led_classdev_mc kbd_led_mc;
> +	int kbd_led_wk;
> +	struct mc_subled subled_info[ASUS_KBD_SUBLED_COUNT];
> +
>  	struct asus_rfkill wlan;
>  	struct asus_rfkill bluetooth;
>  	struct asus_rfkill wimax;
> @@ -870,15 +875,7 @@ static enum led_brightness tpd_led_get(struct led_cl=
assdev *led_cdev)
>  	return read_tpd_led_state(asus);
>  }
> =20
> -static void kbd_led_update(struct asus_wmi *asus)
> -{
> -	int ctrl_param =3D 0;
> -
> -	ctrl_param =3D 0x80 | (asus->kbd_led_wk & 0x7F);
> -	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
> -}
> -
> -static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
> +static int kbd_led_brightness_wmi_read(struct asus_wmi *asus, int *level=
, int *env)
>  {
>  	int retval;
> =20
> @@ -905,50 +902,77 @@ static int kbd_led_read(struct asus_wmi *asus, int =
*level, int *env)
>  	return 0;
>  }
> =20
> -static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
> +static void kbd_led_brightness_wmi_write(struct asus_wmi *asus, int valu=
e)
>  {
> -	struct asus_wmi *asus;
>  	int max_level;
> +	int ctrl_param =3D 0;
> =20
> -	asus =3D container_of(led_cdev, struct asus_wmi, kbd_led);
> -	max_level =3D asus->kbd_led.max_brightness;
> -
> +	max_level =3D asus->kbd_led_mc.led_cdev.max_brightness;
>  	asus->kbd_led_wk =3D clamp_val(value, 0, max_level);
> -	kbd_led_update(asus);
> +
> +	ctrl_param =3D 0x80 | (asus->kbd_led_wk & 0x7F);
> +	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
>  }
> =20
> -static void kbd_led_set(struct led_classdev *led_cdev,
> -			enum led_brightness value)
> +static void kbd_led_brightness_set(struct led_classdev *led_cdev,
> +		enum led_brightness value)
>  {
> +	struct asus_wmi *asus;
> +	struct led_classdev_mc *led_cdev_mc;
> +
>  	/* Prevent disabling keyboard backlight on module unregister */
>  	if (led_cdev->flags & LED_UNREGISTERING)
>  		return;
> =20
> -	do_kbd_led_set(led_cdev, value);
> +	led_cdev_mc =3D container_of(led_cdev, struct led_classdev_mc, led_cdev=
);
> +	asus =3D container_of(led_cdev_mc, struct asus_wmi, kbd_led_mc);
> +
> +	kbd_led_brightness_wmi_write(asus, value);
>  }
> =20
> -static void kbd_led_set_by_kbd(struct asus_wmi *asus, enum led_brightnes=
s value)
> +static void kbd_led_set_brightness_by_hw(struct asus_wmi *asus,
> +		enum led_brightness value)
>  {
> -	struct led_classdev *led_cdev =3D &asus->kbd_led;
> +	struct led_classdev *led_cdev =3D &asus->kbd_led_mc.led_cdev;
> =20
> -	do_kbd_led_set(led_cdev, value);
> +	kbd_led_brightness_wmi_write(asus, value);
>  	led_classdev_notify_brightness_hw_changed(led_cdev, asus->kbd_led_wk);
>  }
> =20
> -static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
> +static enum led_brightness kbd_led_brightness_get(struct led_classdev *l=
ed_cdev)
>  {
>  	struct asus_wmi *asus;
> +	struct led_classdev_mc *led_cdev_mc;
>  	int retval, value;
> =20
> -	asus =3D container_of(led_cdev, struct asus_wmi, kbd_led);
> +	led_cdev_mc =3D container_of(led_cdev, struct led_classdev_mc, led_cdev=
);
> +	asus =3D container_of(led_cdev_mc, struct asus_wmi, kbd_led_mc);
> =20
> -	retval =3D kbd_led_read(asus, &value, NULL);
> +	retval =3D kbd_led_brightness_wmi_read(asus, &value, NULL);
>  	if (retval < 0)
>  		return retval;
> =20
>  	return value;
>  }
> =20
> +int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
> +{
> +	int rv;
> +
> +	asus->kbd_led_wk =3D brightness;
> +	asus->kbd_led_mc.led_cdev.name =3D "asus::kbd_backlight";
> +	asus->kbd_led_mc.led_cdev.flags =3D LED_BRIGHT_HW_CHANGED;
> +	asus->kbd_led_mc.led_cdev.brightness_set =3D kbd_led_brightness_set;
> +	asus->kbd_led_mc.led_cdev.brightness_get =3D kbd_led_brightness_get;
> +	asus->kbd_led_mc.led_cdev.max_brightness =3D 3;
> +
> +	asus->kbd_led_mc.num_colors =3D ASUS_KBD_SUBLED_COUNT;
> +
> +	rv =3D led_classdev_multicolor_register(&asus->platform_device->dev,
> +					&asus->kbd_led_mc);
> +	return rv;
> +}
> +
>  static int wlan_led_unknown_state(struct asus_wmi *asus)
>  {
>  	u32 result;
> @@ -1026,7 +1050,7 @@ static enum led_brightness lightbar_led_get(struct =
led_classdev *led_cdev)
> =20
>  static void asus_wmi_led_exit(struct asus_wmi *asus)
>  {
> -	led_classdev_unregister(&asus->kbd_led);
> +	led_classdev_multicolor_unregister(&asus->kbd_led_mc);
>  	led_classdev_unregister(&asus->tpd_led);
>  	led_classdev_unregister(&asus->wlan_led);
>  	led_classdev_unregister(&asus->lightbar_led);
> @@ -1057,16 +1081,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>  			goto error;
>  	}
> =20
> -	if (!kbd_led_read(asus, &led_val, NULL)) {
> -		asus->kbd_led_wk =3D led_val;
> -		asus->kbd_led.name =3D "asus::kbd_backlight";
> -		asus->kbd_led.flags =3D LED_BRIGHT_HW_CHANGED;
> -		asus->kbd_led.brightness_set =3D kbd_led_set;
> -		asus->kbd_led.brightness_get =3D kbd_led_get;
> -		asus->kbd_led.max_brightness =3D 3;
> -
> -		rv =3D led_classdev_register(&asus->platform_device->dev,
> -					   &asus->kbd_led);
> +	if (!kbd_led_brightness_wmi_read(asus, &led_val, NULL)) {
> +		rv =3D kbd_led_classdev_init(asus, led_val);
>  		if (rv)
>  			goto error;
>  	}
> @@ -3057,18 +3073,19 @@ static void asus_wmi_handle_event_code(int code, =
struct asus_wmi *asus)
>  	}
> =20
>  	if (code =3D=3D NOTIFY_KBD_BRTUP) {
> -		kbd_led_set_by_kbd(asus, asus->kbd_led_wk + 1);
> +		kbd_led_set_brightness_by_hw(asus, asus->kbd_led_wk + 1);
>  		return;
>  	}
>  	if (code =3D=3D NOTIFY_KBD_BRTDWN) {
> -		kbd_led_set_by_kbd(asus, asus->kbd_led_wk - 1);
> +		kbd_led_set_brightness_by_hw(asus, asus->kbd_led_wk - 1);
>  		return;
>  	}
>  	if (code =3D=3D NOTIFY_KBD_BRTTOGGLE) {
> -		if (asus->kbd_led_wk =3D=3D asus->kbd_led.max_brightness)
> -			kbd_led_set_by_kbd(asus, 0);
> +		if (asus->kbd_led_wk =3D=3D asus->kbd_led_mc.led_cdev.max_brightness)
> +			kbd_led_set_brightness_by_hw(asus, 0);
>  		else
> -			kbd_led_set_by_kbd(asus, asus->kbd_led_wk + 1);
> +			kbd_led_set_brightness_by_hw(asus,
> +					asus->kbd_led_wk + 1);
>  		return;
>  	}
> =20
> @@ -3720,8 +3737,8 @@ static int asus_hotk_resume(struct device *device)
>  {
>  	struct asus_wmi *asus =3D dev_get_drvdata(device);
> =20
> -	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
> -		kbd_led_update(asus);
> +	if (!IS_ERR_OR_NULL(asus->kbd_led_mc.led_cdev.dev))
> +		kbd_led_brightness_wmi_write(asus, asus->kbd_led_wk);
> =20
>  	if (asus_wmi_has_fnlock_key(asus))
>  		asus_wmi_fnlock_update(asus);
> @@ -3762,8 +3779,8 @@ static int asus_hotk_restore(struct device *device)
>  		bl =3D !asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_UWB);
>  		rfkill_set_sw_state(asus->uwb.rfkill, bl);
>  	}
> -	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
> -		kbd_led_update(asus);
> +	if (!IS_ERR_OR_NULL(asus->kbd_led_mc.led_cdev.dev))
> +		kbd_led_brightness_wmi_write(asus, asus->kbd_led_wk);
> =20
>  	if (asus_wmi_has_fnlock_key(asus))
>  		asus_wmi_fnlock_update(asus);

--=20
http://www.livejournal.com/~pavelmachek

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmIMyrYACgkQMOfwapXb+vK5JwCgpwMBCM5T6lac6qSnAs3sJPRQ
x9UAoIGt3+PqKniImfyGu4/LbDymCGQP
=YuXA
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
