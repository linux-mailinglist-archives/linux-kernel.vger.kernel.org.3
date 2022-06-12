Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E374547AE8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiFLP5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiFLP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:57:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0C4249C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:57:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o0PxR-0001Jc-9s; Sun, 12 Jun 2022 17:56:57 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C355B933A8;
        Sun, 12 Jun 2022 15:56:54 +0000 (UTC)
Date:   Sun, 12 Jun 2022 17:56:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v8] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220612155654.ij53kpw7cscj53nk@pengutronix.de>
References: <20220612152601.142314-1-max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u6qlpetz6nkzhgo7"
Content-Disposition: inline
In-Reply-To: <20220612152601.142314-1-max@enpas.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u6qlpetz6nkzhgo7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2022 17:26:01, Max Staudt wrote:
> This is the can327 driver. It does a surprisingly good job at turning
> ELM327 based OBD-II interfaces into cheap CAN interfaces for simple
> homebrew projects.
>=20
> Please see the included documentation for details and limitations:
> Documentation/networking/device_drivers/can/can327.rst
>=20
> Cc: linux-can <linux-can@vger.kernel.org>
> Signed-off-by: Max Staudt <max@enpas.org>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> After a through review (thanks to Vincent Mailhol), this is hopefully
> the last version of the can327 upstreaming patch.
>=20
> Thanks to everyone involved!

\o/

> diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
> index 9d0f06bfbac3..68aeae2addec 100644
> --- a/include/uapi/linux/tty.h
> +++ b/include/uapi/linux/tty.h
> @@ -38,8 +38,9 @@
>  #define N_NULL		27	/* Null ldisc used for error handling */
>  #define N_MCTP		28	/* MCTP-over-serial */
>  #define N_DEVELOPMENT	29	/* Manual out-of-tree testing */
> +#define N_CAN327	30	/* ELM327 based OBD-II interfaces */
> =20
>  /* Always the newest line discipline + 1 */
> -#define NR_LDISCS	30
> +#define NR_LDISCS	31
> =20
>  #endif /* _UAPI_LINUX_TTY_H */

Greg, do you want the include/uapi/linux/tty.h changes in a separate
patch and upstream it?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u6qlpetz6nkzhgo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKmDMMACgkQrX5LkNig
012Nhgf/d0YMmHkDyx7CJmUOEBa12XbaZdC4RDWbnlswO0wEafxHLjSedwnSZTjR
Vigoe2+XwN0RL6u4Fx1HtCGri4uoKMlpdYYNzeRmwvCMR+RdxhYLyPGSTgsfPGvX
V82lCaHFsdCCrBr0T72Da+ttD6LHU/QKINudFeyakXNDPhzJ1gaDPW7afD2ut8TX
SqNx0waQZeloVZKmvH+Uu0UaEtdGMJXh2ZDwAUHThmfMkAAW90/KCPdxADCztQDM
+X3eEetjaeKZ/LfclTHGa8UHaZgPITp+/EkTBYpU5QiteZKXy/pDaTBLhT26el0q
ydfm6Oe+TFNq5DxcZFhZ4+4MLLLE7Q==
=tNBg
-----END PGP SIGNATURE-----

--u6qlpetz6nkzhgo7--
