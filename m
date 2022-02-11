Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A04B2DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352960AbiBKTnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:43:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiBKTne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:43:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90713A;
        Fri, 11 Feb 2022 11:43:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CD45F1F47143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644608610;
        bh=As73ym/aV+pjwsn6mCNrhbhoxQhxBpG74aEyHd8d/3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvm3JrOXlbXw5I1mMgC9iGFUeNIrOiodOTzIXlUqlkjOUjZ0XnNGlOipCEHt2Bq6t
         LL8MBeEqWTaI1TGUN8Snyfirs8zj0iMxs+XiHR6ACHRhNOsC0JSwUHQT0HncM6D2DU
         61WnUW87ZRaaa38ovBpKKGaXIRDnvBBRbut7LiAws/WyTYu5cU3w52Jw5tNVRAKyaU
         108myr07u/tFtLcywkuSzN60OkVJTI7IG3jnNRfYuWBaE1VAXQtW/bLKm3rB0SHT7X
         6ntbhXSQqJC/bwzRTPIk0B/57tQhN1qqPFcaLpuIFxhRuV5Hc9grDkYjLyUmisYO1H
         SkJ0bLti+uMWw==
Received: by mercury (Postfix, from userid 1000)
        id 8D6A21060908; Fri, 11 Feb 2022 20:43:28 +0100 (CET)
Date:   Fri, 11 Feb 2022 20:43:28 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] power: supply: PCHG: Use MKBP for device event
 handling
Message-ID: <20220211194328.u2psgdktkdehemoj@mercury.elektranox.org>
References: <20220126180413.2565825-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sarpifditf5hu3o5"
Content-Disposition: inline
In-Reply-To: <20220126180413.2565825-1-dnojiri@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sarpifditf5hu3o5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 26, 2022 at 10:04:10AM -0800, Daisuke Nojiri wrote:
> This change makes the PCHG driver receive device events through
> MKBP protocol since CrOS EC switched to deliver all peripheral
> charge events to the MKBP protocol. This will unify PCHG event
> handling on X86 and ARM.
>=20
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---

Thanks, queued.

-- Sebastian

> v1 -> v2
> * Make the patch description concise.
> * Change the order of if-conditions in cros_ec_notify.
> v2 -> v3
> * Style changes. No functional change is made.
> * 'This patch' -> 'This change' in the patch description.
> ---
>  .../power/supply/cros_peripheral_charger.c    | 37 ++---------
>  .../linux/platform_data/cros_ec_commands.h    | 64 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/pow=
er/supply/cros_peripheral_charger.c
> index 305f10dfc06d1b..9fe6d826148db9 100644
> --- a/drivers/power/supply/cros_peripheral_charger.c
> +++ b/drivers/power/supply/cros_peripheral_charger.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/stringify.h>
>  #include <linux/types.h>
> +#include <asm/unaligned.h>
> =20
>  #define DRV_NAME		"cros-ec-pchg"
>  #define PCHG_DIR_PREFIX		"peripheral"
> @@ -237,46 +238,22 @@ static int cros_pchg_event(const struct charger_dat=
a *charger,
>  	return NOTIFY_OK;
>  }
> =20
> -static u32 cros_get_device_event(const struct charger_data *charger)
> -{
> -	struct ec_params_device_event req;
> -	struct ec_response_device_event rsp;
> -	struct device *dev =3D charger->dev;
> -	int ret;
> -
> -	req.param =3D EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS;
> -	ret =3D cros_pchg_ec_command(charger, 0, EC_CMD_DEVICE_EVENT,
> -				   &req, sizeof(req), &rsp, sizeof(rsp));
> -	if (ret < 0) {
> -		dev_warn(dev, "Unable to get device events (err:%d)\n", ret);
> -		return 0;
> -	}
> -
> -	return rsp.event_mask;
> -}
> -
>  static int cros_ec_notify(struct notifier_block *nb,
>  			  unsigned long queued_during_suspend,
>  			  void *data)
>  {
> -	struct cros_ec_device *ec_dev =3D (struct cros_ec_device *)data;
> -	u32 host_event =3D cros_ec_get_host_event(ec_dev);
> +	struct cros_ec_device *ec_dev =3D data;
>  	struct charger_data *charger =3D
>  			container_of(nb, struct charger_data, notifier);
> -	u32 device_event_mask;
> +	u32 host_event;
> =20
> -	if (!host_event)
> +	if (ec_dev->event_data.event_type !=3D EC_MKBP_EVENT_PCHG ||
> +			ec_dev->event_size !=3D sizeof(host_event))
>  		return NOTIFY_DONE;
> =20
> -	if (!(host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_DEVICE)))
> -		return NOTIFY_DONE;
> +	host_event =3D get_unaligned_le32(&ec_dev->event_data.data.host_event);
> =20
> -	/*
> -	 * todo: Retrieve device event mask in common place
> -	 * (e.g. cros_ec_proto.c).
> -	 */
> -	device_event_mask =3D cros_get_device_event(charger);
> -	if (!(device_event_mask & EC_DEVICE_EVENT_MASK(EC_DEVICE_EVENT_WLC)))
> +	if (!(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
>  		return NOTIFY_DONE;
> =20
>  	return cros_pchg_event(charger, host_event);
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/lin=
ux/platform_data/cros_ec_commands.h
> index 271bd87bff0a25..95e7e5667291b7 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3386,6 +3386,9 @@ enum ec_mkbp_event {
>  	/* Send an incoming CEC message to the AP */
>  	EC_MKBP_EVENT_CEC_MESSAGE =3D 9,
> =20
> +	/* Peripheral device charger event */
> +	EC_MKBP_EVENT_PCHG =3D 12,
> +
>  	/* Number of MKBP events */
>  	EC_MKBP_EVENT_COUNT,
>  };
> @@ -5527,6 +5530,67 @@ enum pchg_state {
>  	[PCHG_STATE_CONNECTED] =3D "CONNECTED", \
>  	}
> =20
> +/*
> + * Update firmware of peripheral chip
> + */
> +#define EC_CMD_PCHG_UPDATE 0x0136
> +
> +/* Port number is encoded in bit[28:31]. */
> +#define EC_MKBP_PCHG_PORT_SHIFT		28
> +/* Utility macro for converting MKBP event to port number. */
> +#define EC_MKBP_PCHG_EVENT_TO_PORT(e)	(((e) >> EC_MKBP_PCHG_PORT_SHIFT) =
& 0xf)
> +/* Utility macro for extracting event bits. */
> +#define EC_MKBP_PCHG_EVENT_MASK(e)	((e) \
> +					& GENMASK(EC_MKBP_PCHG_PORT_SHIFT-1, 0))
> +
> +#define EC_MKBP_PCHG_UPDATE_OPENED	BIT(0)
> +#define EC_MKBP_PCHG_WRITE_COMPLETE	BIT(1)
> +#define EC_MKBP_PCHG_UPDATE_CLOSED	BIT(2)
> +#define EC_MKBP_PCHG_UPDATE_ERROR	BIT(3)
> +#define EC_MKBP_PCHG_DEVICE_EVENT	BIT(4)
> +
> +enum ec_pchg_update_cmd {
> +	/* Reset chip to normal mode. */
> +	EC_PCHG_UPDATE_CMD_RESET_TO_NORMAL =3D 0,
> +	/* Reset and put a chip in update (a.k.a. download) mode. */
> +	EC_PCHG_UPDATE_CMD_OPEN,
> +	/* Write a block of data containing FW image. */
> +	EC_PCHG_UPDATE_CMD_WRITE,
> +	/* Close update session. */
> +	EC_PCHG_UPDATE_CMD_CLOSE,
> +	/* End of commands */
> +	EC_PCHG_UPDATE_CMD_COUNT,
> +};
> +
> +struct ec_params_pchg_update {
> +	/* PCHG port number */
> +	uint8_t port;
> +	/* enum ec_pchg_update_cmd */
> +	uint8_t cmd;
> +	/* Padding */
> +	uint8_t reserved0;
> +	uint8_t reserved1;
> +	/* Version of new firmware */
> +	uint32_t version;
> +	/* CRC32 of new firmware */
> +	uint32_t crc32;
> +	/* Address in chip memory where <data> is written to */
> +	uint32_t addr;
> +	/* Size of <data> */
> +	uint32_t size;
> +	/* Partial data of new firmware */
> +	uint8_t data[];
> +} __ec_align4;
> +
> +BUILD_ASSERT(EC_PCHG_UPDATE_CMD_COUNT
> +	     < BIT(sizeof(((struct ec_params_pchg_update *)0)->cmd)*8));
> +
> +struct ec_response_pchg_update {
> +	/* Block size */
> +	uint32_t block_size;
> +} __ec_align4;
> +
> +
>  /***********************************************************************=
******/
>  /* Voltage regulator controls */
> =20
> --=20
> 2.31.0
>=20

--sarpifditf5hu3o5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGvF0ACgkQ2O7X88g7
+poXHBAAg2seFaeVHADEKLEozp/haE+p2Ms2MzLq3Dc0pJfA5v16+54FaF85e3l0
h3A/pqJMhv4iI8iS/nMNvZoj5tovRMCJqpLZVlmoE5k1oLMsoNhdq19drwCH1CKE
EuNCkbOiF+vUo8mOr9agWUcE1Z8J4rgrONdAHvOmEPKBY9XzInllyLdJICgUeeta
9J2IQbuKwNGAEOSmPwxjnKaPwLF0tjpxLFE2FuKNbdXx6xPVakuomk+6sZR4GojH
/USG1pmdH4WKjigeb8HC/quAZZkmKVcNnjA95dDNxMUevQprOxzpKcjBQI0S8MyM
fcStNLT8UvFIB+eqx9ipjqBYu5HVwhZSUaAeEdhaUUqFehkSPlRUC3RKb1E5/8tZ
DwuTQqeRpqnbNxef6zNcR7G1KWh+k+27yjEHMUuLMPWk+GJIMtoPPBfsXGpoif0E
7gHqsfrTcaH78DrMjFSjn24CvdI6hCdOp7iY6UB4oTpQBUvPtlAjTsadOpqgqr3H
NsJgJKrfgG2JmpFUOfQxtvuMsOQV2Yjy6g+bT8pIkcx8C40pLlAs5Epyq9RZtRvo
Tf8EhWlL9Ifq2z7npK5TrewtpqwZ/jF0ll5K+euJaBbNgM6p9mI2hMKA8dCsu3a8
bHHY4TFslubHiSaaFQdWw+t7uHrDIElPTnFaWjsnET3Sl4UJyzU=
=WSdC
-----END PGP SIGNATURE-----

--sarpifditf5hu3o5--
