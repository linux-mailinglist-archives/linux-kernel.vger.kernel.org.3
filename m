Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40BC483664
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiACRqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiACRqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:46:06 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA4C061761;
        Mon,  3 Jan 2022 09:46:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 382341F42482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641231964;
        bh=GG76Jt2ncS2UKOQTTxNWe5QqglsiMKfF83wpiZ8iT9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNEtAgPFR1RkZiT/Y8bhmKMkyoICnEqHNMD5OeQG02B2aTU79kq++DvCh81ceEfrr
         PWmk6M3iauCs+UMOi7Io+5MCIidCPNxUY9GGR1DZPFKDwBQNgTjCnsxBMuuivYpVss
         XopPLbp5gP34pChmrJEJbqszrlquwY8jaIw/X480UfEj4sYQ+n8W7psO/FEXNRQTKY
         y9e4IGvFOsnle2JFHzLjjNBdgnuXinecdwxRUz/isuP9vUHLenIl/lsHtpGv0bkgOr
         r85KZ8mLC/uVdMTi2vzpMiu2uRkhhgaI3MrH/auyT6Uk7cWr+Q0Ec/AQnmv+8DlfSF
         9JSrfaKRs5yig==
Received: by earth.universe (Postfix, from userid 1000)
        id 5A59C3C0CB7; Mon,  3 Jan 2022 18:46:02 +0100 (CET)
Date:   Mon, 3 Jan 2022 18:46:02 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20220103174602.qrx5rs3owtiewyui@earth.universe>
References: <4855a130-b16b-d8d6-ec9b-ab1ac024e4a7@redhat.com>
 <20211217062846.GA26548@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qivim53f627jbwv3"
Content-Disposition: inline
In-Reply-To: <20211217062846.GA26548@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qivim53f627jbwv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 17, 2021 at 09:28:46AM +0300, Dan Carpenter wrote:
> The extcon_get_extcon_dev() function returns error pointers on error,
> NULL when it's a -EPROBE_DEFER defer situation, and ERR_PTR(-ENODEV)
> when the CONFIG_EXTCON option is disabled.  This is very complicated for
> the callers to handle and a number of them had bugs that would lead to
> an Oops.
>=20
> In real life, there are two things which prevented crashes.  First,
> error pointers would only be returned if there was bug in the caller
> where they passed a NULL "extcon_name" and none of them do that.
> Second, only two out of the eight drivers will build when CONFIG_EXTCON
> is disabled.
>=20
> The normal way to write this would be to return -EPROBE_DEFER directly
> when appropriate and return NULL when CONFIG_EXTCON is disabled.  Then
> the error handling is simple and just looks like:
>=20
> 	dev->edev =3D extcon_get_extcon_dev(acpi_dev_name(adev));
> 	if (IS_ERR(dev->edev))
> 		return PTR_ERR(dev->edev);
>=20
> For the two drivers which can build with CONFIG_EXTCON disabled, then
> extcon_get_extcon_dev() will now return NULL which is not treated as an
> error and the probe will continue successfully.  Those two drivers are
> "typec_fusb302" and "max8997-battery".  In the original code, the
> typec_fusb302 driver had an 800ms hang in tcpm_get_current_limit() but
> now that function is a no-op.  For the max8997-battery driver everything
> should continue working as is.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> v2: return NULL when CONFIG_EXTCON is disabled
> v3: Add a note to extcon_get_extcon_dev() to say that it may only be
>     called from probe().
>=20
>  drivers/extcon/extcon.c                |  4 +++-
>  include/linux/extcon.h                 |  2 +-
>  drivers/extcon/extcon-axp288.c         |  4 ++--
>  drivers/power/supply/axp288_charger.c  | 17 ++++++++++-------
>  drivers/power/supply/charger-manager.c |  7 ++-----
>  drivers/power/supply/max8997_charger.c | 10 +++++-----
>  drivers/usb/dwc3/drd.c                 |  9 ++-------
>  drivers/usb/phy/phy-omap-otg.c         |  4 ++--
>  drivers/usb/typec/tcpm/fusb302.c       |  4 ++--
>  9 files changed, 29 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e7a9561a826d..9eb92997f3ae 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -863,6 +863,8 @@ EXPORT_SYMBOL_GPL(extcon_set_property_capability);
>   * @extcon_name:	the extcon name provided with extcon_dev_register()
>   *
>   * Return the pointer of extcon device if success or ERR_PTR(err) if fai=
l.
> + * NOTE: This function returns -EPROBE_DEFER so it may only be called fr=
om
> + * probe() functions.
>   */
>  struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  {
> @@ -876,7 +878,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *=
extcon_name)
>  		if (!strcmp(sd->name, extcon_name))
>  			goto out;
>  	}
> -	sd =3D NULL;
> +	sd =3D ERR_PTR(-EPROBE_DEFER);
>  out:
>  	mutex_unlock(&extcon_dev_list_lock);
>  	return sd;
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 0c19010da77f..685401d94d39 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -296,7 +296,7 @@ static inline void devm_extcon_unregister_notifier_al=
l(struct device *dev,
> =20
>  static inline struct extcon_dev *extcon_get_extcon_dev(const char *extco=
n_name)
>  {
> -	return ERR_PTR(-ENODEV);
> +	return NULL;
>  }
> =20
>  static inline struct extcon_dev *extcon_find_edev_by_node(struct device_=
node *node)
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp28=
8.c
> index 7c6d5857ff25..180be768c215 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -394,8 +394,8 @@ static int axp288_extcon_probe(struct platform_device=
 *pdev)
>  		if (adev) {
>  			info->id_extcon =3D extcon_get_extcon_dev(acpi_dev_name(adev));
>  			put_device(&adev->dev);
> -			if (!info->id_extcon)
> -				return -EPROBE_DEFER;
> +			if (IS_ERR(info->id_extcon))
> +				return PTR_ERR(info->id_extcon);
> =20
>  			dev_info(dev, "controlling USB role\n");
>  		} else {
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply=
/axp288_charger.c
> index ec41f6cd3f93..4acfeb52a44e 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -848,17 +848,20 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
>  	info->regmap_irqc =3D axp20x->regmap_irqc;
> =20
>  	info->cable.edev =3D extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> -	if (info->cable.edev =3D=3D NULL) {
> -		dev_dbg(dev, "%s is not ready, probe deferred\n",
> -			AXP288_EXTCON_DEV_NAME);
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(info->cable.edev)) {
> +		dev_err_probe(dev, PTR_ERR(info->cable.edev),
> +			      "extcon_get_extcon_dev(%s) failed\n",
> +			      AXP288_EXTCON_DEV_NAME);
> +		return PTR_ERR(info->cable.edev);
>  	}
> =20
>  	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>  		info->otg.cable =3D extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
> -		if (info->otg.cable =3D=3D NULL) {
> -			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(info->otg.cable)) {
> +			dev_err_probe(dev, PTR_ERR(info->otg.cable),
> +				      "extcon_get_extcon_dev(%s) failed\n",
> +				      USB_HOST_EXTCON_NAME);
> +			return PTR_ERR(info->otg.cable);
>  		}
>  		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>  	}
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index d67edb760c94..92db79400a6a 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -985,13 +985,10 @@ static int charger_extcon_init(struct charger_manag=
er *cm,
>  	cable->nb.notifier_call =3D charger_extcon_notifier;
> =20
>  	cable->extcon_dev =3D extcon_get_extcon_dev(cable->extcon_name);
> -	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
> +	if (IS_ERR(cable->extcon_dev)) {
>  		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
>  			cable->extcon_name, cable->name);
> -		if (cable->extcon_dev =3D=3D NULL)
> -			return -EPROBE_DEFER;
> -		else
> -			return PTR_ERR(cable->extcon_dev);
> +		return PTR_ERR(cable->extcon_dev);
>  	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(extcon_mapping); i++) {
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/suppl=
y/max8997_charger.c
> index 25207fe2aa68..634658adf313 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -248,13 +248,13 @@ static int max8997_battery_probe(struct platform_de=
vice *pdev)
>  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
>  	}
>  	charger->edev =3D extcon_get_extcon_dev("max8997-muic");
> -	if (IS_ERR_OR_NULL(charger->edev)) {
> -		if (!charger->edev)
> -			return -EPROBE_DEFER;
> -		dev_info(charger->dev, "couldn't get extcon device\n");
> +	if (IS_ERR(charger->edev)) {
> +		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
> +			      "couldn't get extcon device: max8997-muic\n");
> +		return PTR_ERR(charger->edev);
>  	}
> =20
> -	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
> +	if (!IS_ERR(charger->reg)) {
>  		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
>  		ret =3D devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_wo=
rk, charger);
>  		if (ret) {
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index d7f76835137f..a490f79131c1 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -454,13 +454,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc=
3 *dwc)
>  	 * This device property is for kernel internal use only and
>  	 * is expected to be set by the glue code.
>  	 */
> -	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=3D=
 0) {
> -		edev =3D extcon_get_extcon_dev(name);
> -		if (!edev)
> -			return ERR_PTR(-EPROBE_DEFER);
> -
> -		return edev;
> -	}
> +	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=3D=
 0)
> +		return extcon_get_extcon_dev(name);
> =20
>  	/*
>  	 * Try to get an extcon device from the USB PHY controller's "port"
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-ot=
g.c
> index ee0863c6553e..6e6ef8c0bc7e 100644
> --- a/drivers/usb/phy/phy-omap-otg.c
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -95,8 +95,8 @@ static int omap_otg_probe(struct platform_device *pdev)
>  		return -ENODEV;
> =20
>  	extcon =3D extcon_get_extcon_dev(config->extcon);
> -	if (!extcon)
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(extcon))
> +		return PTR_ERR(extcon);
> =20
>  	otg_dev =3D devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>  	if (!otg_dev)
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fu=
sb302.c
> index 72f9001b0792..96c55eaf3f80 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1708,8 +1708,8 @@ static int fusb302_probe(struct i2c_client *client,
>  	 */
>  	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=3D=
 0) {
>  		chip->extcon =3D extcon_get_extcon_dev(name);
> -		if (!chip->extcon)
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(chip->extcon))
> +			return PTR_ERR(chip->extcon);
>  	}
> =20
>  	chip->vbus =3D devm_regulator_get(chip->dev, "vbus");
> --=20
> 2.20.1
>=20

--qivim53f627jbwv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHTNloACgkQ2O7X88g7
+porbBAAqT56xT3BWbBzy+YTXXmNldoF9KQxtaD5H5GNwmJWfEQB091xrMW8rF8g
NNA0Xeqyq173qNaI0OF6+0ai0M20+A9QrZ3I08BXQSmBsXPegXx1mQzFPc+9i89Z
u1Cc0EDhoJmzot3DtULqMbXxC9OhGyv4cg4o+lUZTv70OQ6ibaCJ/uq3u2Ib8GTr
w7/NMDOSVz3OmXNXFVKgnotV2/hNnUkdGdfyMypQceFrnE5CdaRlDp2v/vyoyl70
yKYWsA1dOKD8DAj8puKdGMb0M+VrmNKJWe+3i+tK8YF2VYOadFsGw/j7+quJxGc/
vxoEH/l5kjeVTI2TygJOBRBPvXW8JW/NT4IN4qWrSTs4c33Jseer2EyW6nOSS9b3
p3ptCq6mPXch+elX1I7Xf12Vt/VPkAV/o5U7Dp3uwLRwhzasjfSlJtt/rSHve4OA
GQFdLourd0Cbll6MVtmhXHWRGPl5pkRaw66+VDCOI87unXZN7qnzgus4po5yEoz+
iHSFEzEmy2aMJbZL4M0QqH+uJeKgtQ1lUaoUXuFH8khNnOGDoxnR3VkpmWrU7QDL
8NIpWHGxtp0OnLgie6GWipaYJ+uW0bJIv3+p0/4TmJCYHLIxl8P4qT1CFt57n/3g
e1iJKKL4T+7AjVy70X4ImYt3q0H+I7ZD9YzhcaGtf405gmBtgOI=
=X2OH
-----END PGP SIGNATURE-----

--qivim53f627jbwv3--
