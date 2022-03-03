Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8814CC8D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiCCW0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiCCW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:26:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA55C10CF22
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:25:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPttM-0000xB-0x; Thu, 03 Mar 2022 23:25:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPttL-002Ugn-HZ; Thu, 03 Mar 2022 23:25:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPttK-006nUd-1x; Thu, 03 Mar 2022 23:25:46 +0100
Date:   Thu, 3 Mar 2022 23:25:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v13 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <20220303222542.6ytwfp3bvm62igyy@pengutronix.de>
References: <20220204180106.154000-1-sean.anderson@seco.com>
 <20220204180106.154000-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2xupj2groypst2wu"
Content-Disposition: inline
In-Reply-To: <20220204180106.154000-2-sean.anderson@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
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


--2xupj2groypst2wu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just a few minor things left for me to criticise:

On Fri, Feb 04, 2022 at 01:01:06PM -0500, Sean Anderson wrote:
> [...]
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	state->period =3D xilinx_timer_get_period(priv, tlr0, tcsr0);
> +	state->duty_cycle =3D xilinx_timer_get_period(priv, tlr1, tcsr1);
> +	state->enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	/*
> +	 * 100% duty cycle results in constant low output. This may be slightly
> +	 * wrong if rate >=3D 1GHz, so fix this if you have such hardware :)
> +	 */

I'd drop "slightly" here. If the bug happens (e.g. tlr0 =3D 999999999,
tlr1 =3D 999999998, clkrate =3D 1000000001 Hz) then you diagnose a nearly
100% relative duty cycle as 0%. Also s/>=3D 1GHz/> 1 GHz/.

> [...]
> +	if (one_timer)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Two timers required for PWM mode\n");
> +
> +

One empty line here would be enough.

> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/tim=
er-xilinx.h
> new file mode 100644
> index 000000000000..1f7757b84a5e
> --- /dev/null
> +++ b/include/clocksource/timer-xilinx.h
> @@ -0,0 +1,91 @@
> [...]
> +/**
> + * xilinx_timer_common_init() - Perform common initialization for Xilinx
> + *                              AXI timer drivers.
> + * @priv: The timer's private data
> + * @np: The devicetree node for the timer
> + * @one_timer: Set to %1 if there is only one timer
> + *
> + * This performs common initialization, such as detecting endianness,
> + * and parsing devicetree properties. @priv->regs must be initialized
> + * before calling this function. This function initializes @priv->read,
> + * @priv->write, and @priv->width.
> + *
> + * Return: 0, or negative errno
> + */
> +int xilinx_timer_common_init(struct device_node *np,
> +			     struct xilinx_timer_priv *priv,
> +			     u32 *one_timer);

This function is gone, so the prototype should go away, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2xupj2groypst2wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIhQGEACgkQwfwUeK3K
7AmcjQf/a7MAlCMNM5lvqiaw7OpFD0g8pNPNzdwtn4NNqLHkrBGt8g9ChE0ykucL
l5cAGL1emH4+fkZvvpN98Iu5rGqQBm/KdudQVBDzEdgRM4BkryUkg8bBxrYmBVZE
7Ztg2o+k4XI8ojlEKJgI+YiNOXyKkjgoKzkbkjUkObCkCOpjfXDjtMFP4oUAIJJF
GMCVZ9Ft+s3uzr7LOdh1TsSlJlPTGh/+Byt5V+wAI0uQlNGgTH/a1P8QyjusA1tm
Pd2bnCZQORHEX9pnG/iagl1mZ6AHTbSAi5HrZWoN/uJuNEk+maRcrUsBdPR5cKEp
XFQR/odrOWusqXXFu9i8MVQ+gA/nvg==
=VoZb
-----END PGP SIGNATURE-----

--2xupj2groypst2wu--
