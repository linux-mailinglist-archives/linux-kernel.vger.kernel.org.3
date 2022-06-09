Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841075455EE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345248AbiFIUrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiFIUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:47:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9321153B44;
        Thu,  9 Jun 2022 13:47:51 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 266CE6601752;
        Thu,  9 Jun 2022 21:47:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654807670;
        bh=KzK0yIWBvTo55qjdkN6IybgLP9WYqoc50joejUXPTSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+LHpjpvAibRPCVJ4gUGIE3LTtsL7+aUzSSv7K0E14iTtbfY/c88ZbkBh0BCFdk+q
         /VkHBRov2yNDgDKWfL5cSTa8KxwxI9RdKx7nj6IePAufQx/gb4cO79CvBtyrb4HsuH
         zX9E9QXGGQ0agI0RoRfano5/Cj/7Iim06oXFZl3NojHjp22vTmOwGX5vSFldBKIW3o
         fyi57oVg4l2iDyrkz4A7fKQpos7bg2FBrzUOEuA7KJFWoUM/mBptfnn95XToneamjM
         gFFRWZxcdoSorkjvy05j21r75dfg9CVZceQNQg6IZ1Qg5mviL1udaeCPBfOVhCHNBR
         D/7wbBx9Yhiyg==
Received: by mercury (Postfix, from userid 1000)
        id A0F2510605B9; Thu,  9 Jun 2022 22:47:47 +0200 (CEST)
Date:   Thu, 9 Jun 2022 22:47:47 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] power: reset: at91-reset: add
 reset_controller_dev support
Message-ID: <20220609204747.dbsawvw5gvrmkbng@mercury.elektranox.org>
References: <20220608083942.1584087-1-claudiu.beznea@microchip.com>
 <20220608083942.1584087-8-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s4tt47g5dxkb455c"
Content-Disposition: inline
In-Reply-To: <20220608083942.1584087-8-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s4tt47g5dxkb455c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 08, 2022 at 11:39:40AM +0300, Claudiu Beznea wrote:
> SAMA7G5 reset controller has 5 extra lines that goes to different devices
> (3 lines to USB PHYs, 1 line to DDR controller, 1 line to DDR PHY
> controller). These reset lines could be requested by different controller
> drivers (e.g. USB PHY driver) and these controllers' drivers could
> assert/deassert these lines when necessary. Thus add support for
> reset_controller_dev which brings this functionality.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/power/reset/at91-reset.c | 106 +++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index 1b2aca3f490d..e25d8d38a2f8 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -17,10 +17,13 @@
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
> +#include <linux/reset-controller.h>
> =20
>  #include <soc/at91/at91sam9_ddrsdr.h>
>  #include <soc/at91/at91sam9_sdramc.h>
> =20
> +#include <dt-bindings/reset/sama7g5-reset.h>
> +
>  #define AT91_RSTC_CR	0x00		/* Reset Controller Control Register */
>  #define AT91_RSTC_PROCRST	BIT(0)		/* Processor Reset */
>  #define AT91_RSTC_PERRST	BIT(2)		/* Peripheral Reset */
> @@ -65,7 +68,10 @@ enum reset_type {
>   * struct at91_reset - AT91 reset specific data structure
>   * @rstc_base:		base address for system reset
>   * @ramc_base:		array with base addresses of RAM controllers
> + * @dev_base:		base address for devices reset
>   * @sclk:		slow clock
> + * @rcdev:		reset controller device
> + * @lock:		lock for devices reset register access
>   * @nb:			reset notifier block
>   * @args:		SoC specific system reset arguments
>   * @ramc_lpr:		SDRAM Controller Low Power Register
> @@ -73,12 +79,17 @@ enum reset_type {
>  struct at91_reset {
>  	void __iomem *rstc_base;
>  	void __iomem *ramc_base[2];
> +	void __iomem *dev_base;
>  	struct clk *sclk;
> +	struct reset_controller_dev rcdev;
> +	spinlock_t lock;
>  	struct notifier_block nb;
>  	u32 args;
>  	u32 ramc_lpr;
>  };
> =20
> +#define to_at91_reset(r)	container_of(r, struct at91_reset, rcdev)
> +
>  /**
>   * struct at91_reset_data - AT91 reset data
>   * @reset_args:		SoC specific system reset arguments
> @@ -216,6 +227,87 @@ static const struct of_device_id at91_reset_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, at91_reset_of_match);
> =20
> +static int at91_reset_update(struct reset_controller_dev *rcdev,
> +			     unsigned long id, bool assert)
> +{
> +	struct at91_reset *reset =3D to_at91_reset(rcdev);
> +	unsigned long flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(&reset->lock, flags);
> +	val =3D readl_relaxed(reset->dev_base);
> +	if (assert)
> +		val |=3D BIT(id);
> +	else
> +		val &=3D ~BIT(id);
> +	writel_relaxed(val, reset->dev_base);
> +	spin_unlock_irqrestore(&reset->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int at91_reset_assert(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
> +{
> +	return at91_reset_update(rcdev, id, true);
> +}
> +
> +static int at91_reset_deassert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	return at91_reset_update(rcdev, id, false);
> +}
> +
> +static int at91_reset_dev_status(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
> +{
> +	struct at91_reset *reset =3D to_at91_reset(rcdev);
> +	u32 val;
> +
> +	val =3D readl_relaxed(reset->dev_base);
> +
> +	return !!(val & BIT(id));
> +}
> +
> +static const struct reset_control_ops at91_reset_ops =3D {
> +	.assert =3D at91_reset_assert,
> +	.deassert =3D at91_reset_deassert,
> +	.status =3D at91_reset_dev_status,
> +};
> +
> +static int at91_reset_of_xlate(struct reset_controller_dev *rcdev,
> +			       const struct of_phandle_args *reset_spec)
> +{
> +	if (reset_spec->args[0] < SAMA7G5_RESET_USB_PHY1 ||
> +	    reset_spec->args[0] > SAMA7G5_RESET_USB_PHY3)
> +		return -EINVAL;

Can you move the min/max info to the devce info struct, so that
this stays as generic as the name suggests (and is prepared for
future devices)?

-- Sebastian

> +	return reset_spec->args[0];
> +}
> +
> +static int at91_rcdev_init(struct at91_reset *reset,
> +			   const struct at91_reset_data *data,
> +			   struct platform_device *pdev)
> +{
> +	if (!data->n_device_reset)
> +		return 0;
> +
> +	reset->dev_base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 1,
> +					NULL);
> +	if (IS_ERR(reset->dev_base))
> +		return -ENODEV;
> +
> +	spin_lock_init(&reset->lock);
> +	reset->rcdev.ops =3D &at91_reset_ops;
> +	reset->rcdev.owner =3D THIS_MODULE;
> +	reset->rcdev.of_node =3D pdev->dev.of_node;
> +	reset->rcdev.nr_resets =3D data->n_device_reset;
> +	reset->rcdev.of_reset_n_cells =3D 1;
> +	reset->rcdev.of_xlate =3D at91_reset_of_xlate;
> +
> +	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
> +}
> +
>  static int __init at91_reset_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> @@ -269,6 +361,10 @@ static int __init at91_reset_probe(struct platform_d=
evice *pdev)
> =20
>  	platform_set_drvdata(pdev, reset);
> =20
> +	ret =3D at91_rcdev_init(reset, data, pdev);
> +	if (ret)
> +		goto disable_clk;
> +
>  	if (of_device_is_compatible(pdev->dev.of_node, "microchip,sam9x60-rstc"=
)) {
>  		u32 val =3D readl(reset->rstc_base + AT91_RSTC_MR);
> =20
> @@ -277,14 +373,16 @@ static int __init at91_reset_probe(struct platform_=
device *pdev)
>  	}
> =20
>  	ret =3D register_restart_handler(&reset->nb);
> -	if (ret) {
> -		clk_disable_unprepare(reset->sclk);
> -		return ret;
> -	}
> +	if (ret)
> +		goto disable_clk;
> =20
>  	at91_reset_status(pdev, reset->rstc_base);
> =20
>  	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(reset->sclk);
> +	return ret;
>  }
> =20
>  static int __exit at91_reset_remove(struct platform_device *pdev)
> --=20
> 2.33.0
>=20

--s4tt47g5dxkb455c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiXHAACgkQ2O7X88g7
+po1Kg//buj+or26FD76L8KzrHPgJPEa9utL+Uj0dB3YZEQG1iBxdYnffShIIXqm
3hz4b12LIyXDHyP517GHDthtcb2MUv00pOdqbbtrp9I3rEgbg88gDvv9MDQMshfA
rvwLBNJMxTBdljZPSZZw8Zs1og6VyBkp40D5kW4j5knHoMuCqFXJXOfpR82HjJp5
CU2Ivbsk+B7ZLJ7N+fzzqnmUuIiOiD/ZTEPkf10CyFVKgP/KOQtL5V7OPMAADBNh
CwB8iDrQ6splVOlsTMopGT2jnv2d7zXNMW3pOXxovTMaLWvRBKOwsVeiSGthA0gy
4zqnrZ4XBS0HjABcxJBjqh8HEvG7+9Gy/o4o//rt2L3pUScctyzBk9gd0EmbyE4e
NWMOmNzGn23KJ5VhubYur3ztM9mbNATPnSFa5ne7Qb8L8CpwrjYFd5fRrJsTrhCs
Ry6EYiIiHUW6wOHKQ4A93hpIyETGbNBIcBjXH8PMP4+nFFnpT+we3+VM15883lPd
sVa9nFW2Jh5a/oA4EHO8ViTGijnwL7gl6/ilFTkayNnNzbecw0jkdT4HFgya55vb
cVhwBIddDX8Q/Hs477pFrBjIP70lcpiAhV11dRlOgnAZHvuIWhK9gvRZVvoPVfcu
xMQH2Ql+FC2/gTZ+dk7vjq5MbUouns2yOCb3/CW/LqCS/YTJnKo=
=Omrx
-----END PGP SIGNATURE-----

--s4tt47g5dxkb455c--
