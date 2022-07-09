Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1F56CAAE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiGIQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGIQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:38:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD312AF5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 09:38:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oADT2-0005D9-65; Sat, 09 Jul 2022 18:38:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oADSx-005TSX-79; Sat, 09 Jul 2022 18:38:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oADSz-0049CW-Ln; Sat, 09 Jul 2022 18:38:01 +0200
Date:   Sat, 9 Jul 2022 18:37:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Daire.McNamara@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/4] pwm: add microchip soft ip corePWM driver
Message-ID: <20220709163758.nvsaf4jcwqenl2ax@pengutronix.de>
References: <20220708143923.1129928-1-conor.dooley@microchip.com>
 <20220708143923.1129928-4-conor.dooley@microchip.com>
 <20220709160206.cw5luo7kxdshoiua@pengutronix.de>
 <f2720cc9-be02-f457-7e8e-0d6b3845477c@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="inz2fpmccobddp6g"
Content-Disposition: inline
In-Reply-To: <f2720cc9-be02-f457-7e8e-0d6b3845477c@microchip.com>
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


--inz2fpmccobddp6g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Sat, Jul 09, 2022 at 04:21:46PM +0000, Conor.Dooley@microchip.com wrote:
> On 09/07/2022 17:02, Uwe Kleine-K=F6nig wrote:
> > On Fri, Jul 08, 2022 at 03:39:22PM +0100, Conor Dooley wrote:
> >> Add a driver that supports the Microchip FPGA "soft" PWM IP core.
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---8<---
> >> +	mchp_core_pwm_apply_duty(chip, pwm, state, prescale, period_steps);
> >> +
> >> +	/*
> >> +	 * Notify the block to update the waveform from the shadow registers.
> >> +	 * The updated values will not appear on the bus until they have been
> >> +	 * applied to the waveform at the beginning of the next period. We m=
ust
> >> +	 * write these registers and wait for them to be applied before call=
ing
> >> +	 * enable().
> >> +	 */
> >> +	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
> >> +		writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
> >> +		usleep_range(state->period, state->period * 2);
> >> +	}
> >> +
> >> +	spin_unlock(&mchp_core_pwm->lock);
> >> +
> >> +	mchp_core_pwm_enable(chip, pwm, true);
> >=20
> > I already asked in the last round: Do you really need to write the
> > SYNC_UPD register twice? I would expect that you don't?!
>=20
> Sorry, I thought that I had replied to this on Friday, didn't
> meant to ignore you.
>=20
> Yes, I do need to keep that - otherwise there are problems when
> turning on the PWM channel for the first time.

How unintuitive and unfortunate. I wonder if there is an upside of this
approach that I'm missing.

> Before writing to the enable registers, we need to make sure that
> the values have been applied since both pos and neg edge registers
> come out of reset set to 0x0.

I always like to understand the hardware, can you explain the problems
in more details?

> > Also the locking looks fishy here. It would be simpler (and maybe even
> > more robust, didn't think deeply about it) to assume in
> > mchp_core_pwm_enable() that the caller holds the lock. Then you only
> > grab the lock once during .apply() and nothing strange can happen in the
> > gap.
> >=20
> >> +	return 0;
> >> +}
> >> +
> >> +static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm=
_device *pwm,
> >> +				    struct pwm_state *state)
> >> +{
> >> +	struct mchp_core_pwm_chip *mchp_core_pwm =3D to_mchp_core_pwm(chip);
> >> +	u8 prescale, period_steps, duty_steps;
> >> +	u8 posedge, negedge;
> >> +	u16 channel_enabled;
> >> +
> >=20
> > I'd take the lock here to be sure to get a consistent return value.
> >=20
> >> +	channel_enabled =3D (((u16)readb_relaxed(mchp_core_pwm->base + MCHPC=
OREPWM_EN(1)) << 8) |
> >> +		readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0)));
> >=20
> > micro optimisation: You're reading two register values here, but only u=
se
> > one. Shadowing the enabled registers in mchp_core_pwm might also be an
> > idea.
> >=20
> >> +	if (channel_enabled & 1 << pwm->hwpwm)
> >=20
> > I'm always unsure about the associativity of & and <<, so I would have
> > written that as
> >=20
> > 	if (channel_enabled & (1 << pwm->hwpwm))
> >=20
> > I just tested that for the umpteens time and your code is fine, so this
> > is only for human readers like me.
> >=20
> >> +		state->enabled =3D true;
> >> +	else
> >> +		state->enabled =3D false;
> >> +
> >> +	prescale =3D PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOR=
EPWM_PRESCALE));
> >> +
> >> +	posedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(=
pwm->hwpwm));
> >> +	negedge =3D readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(=
pwm->hwpwm));
> >> +
> >> +	duty_steps =3D abs((s16)posedge - (s16)negedge);
> >=20
> > If duty_steps =3D=3D 0 the returned result is wrong. I suggest to fix t=
hat,
> > at least mention the problem in a comment.
>=20
> Ah right yeah, I didn't update this after changing the other logic. Sorry.
>=20
> >=20
> >> +	state->duty_cycle =3D duty_steps * prescale * NSEC_PER_SEC;
> >=20
> > Can this overflow?
> >=20
> >> +	do_div(state->duty_cycle, clk_get_rate(mchp_core_pwm->clk));
> >=20
> > What is the typical return value of clk_get_rate(mchp_core_pwm->clk)?
>=20
> It's gonna be less than 600M

An exact value would be interesting, then when I spot a rounding problem
I could give you a test case to double check.

> > You need to round up here. Did you test your driver with PWM_DEBUG on?
> > During test please do for a few fixed periods:
> >=20
> > 	for duty_cycle in [0 .. period]:
> > 		pwm_apply(mypwm, {.period =3D period, .duty_cycle =3D duty_cycle, .en=
abled =3D true, ...})
> >=20
> > 	for duty_cycle in [period .. 0]:
> > 		pwm_apply(mypwm, {.period =3D period, .duty_cycle =3D duty_cycle, .en=
abled =3D true, ...})
> >=20
> > and check there is no output claiming a miscalculation.
>=20
> I ran the stuff you gave me last time, doing something similar w/ a
> shell loop. Got no reported miscalculations.

I'm surprise, I would have expected that my test recipe would find such
an issue. Could you follow my arguing about the rounding direction?
There always the possibility that I'm wrong, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--inz2fpmccobddp6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLJruQACgkQwfwUeK3K
7Ambngf8DCGNj2gQVmcYUjNB0MdQaav0bGUsjq9z2lZv+l9hmwf3rhSbfhmJUxqS
l7YzkeTazIurESGDA9TG/SBzhwgXqjL4NLpXw/U04CbLhxebXzAXU3aWWJ6O25nu
L1+MN4E0c+eKDX/QnweAYkY8cgHn0bHtoQoMICBHt/TvdPuQtRGSYfgNNUJjigIY
f1Xadta2Ig4SSmhLEgu5YesnzX1SEcjITaaOOLcy2s0JkMftPq9WX3PZ6458TTOD
vgQ8F9MBKgYg+J2qTYhSeien9PBkma5x3TLAEdnY/1JM7CKfNnqCI2+TvGI7dVZp
TpnPaLhUXbyLWpyMrXJSmIx/ZfpWJA==
=brf2
-----END PGP SIGNATURE-----

--inz2fpmccobddp6g--
