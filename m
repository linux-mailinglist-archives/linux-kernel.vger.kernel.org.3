Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D184A808C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349552AbiBCImY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:42:24 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56149 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBCImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:42:20 -0500
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFXWR-0006Rb-VP; Thu, 03 Feb 2022 09:31:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFXWF-00EEGw-Pj; Thu, 03 Feb 2022 09:31:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFXWE-005E44-Cl; Thu, 03 Feb 2022 09:31:06 +0100
Date:   Thu, 3 Feb 2022 09:31:03 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v11 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220203083103.mqwkjxkgy22jaies@pengutronix.de>
References: <20220129005429.754727-1-bjorn.andersson@linaro.org>
 <20220129005429.754727-2-bjorn.andersson@linaro.org>
 <20220202162930.24zcediw44t2jzqf@pengutronix.de>
 <Yfr6RQwJMZY5RZGr@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pmrswpjw2cmgksco"
Content-Disposition: inline
In-Reply-To: <Yfr6RQwJMZY5RZGr@ripper>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pmrswpjw2cmgksco
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Wed, Feb 02, 2022 at 01:40:21PM -0800, Bjorn Andersson wrote:
> On Wed 02 Feb 08:29 PST 2022, Uwe Kleine-K?nig wrote:
> > did you consider my earlier feedback "It would also be good if the PWM
> > code could live in drivers/pwm"?
> > (https://lore.kernel.org/r/20210505051958.e5lvwfxuo2skdu2q@pengutronix.=
de)
>=20
> Yes, I did consider this. Because the downstream driver is (at least was
> when I looked at it originally) split like that.
>=20
> We have a number of different Qualcomm PMICs containing the LPG modules,
> which consists of N PWM channels, a pattern lookup table and a set of
> current sinks.
>=20
> Each PWM channel can either be used as a traditional PWM, a LED or be
> grouped together with other channels to form a multicolor LED. So we
> need a design that allows different boards using a particular PMIC to
> freely use the N channels according to one of these three operational
> modes.
>=20
> The pattern lookup table is a shared resource containing duty cycle
> values and each of the PWM channels can be configured to have their duty
> cycle modified from the lookup table on some configured cadence.
>=20
> In the even that multiple PWM channels are ganged together to form a
> multicolor LED, which is driven by a pattern, the pattern generator for
> the relevant channels needs to be synchronized.

Is this some material for the commit log to motivate the design
decision?

> If we consider the PWM channel to be the basic primitive we need some
> mechanism to configure the pattern properties for each of the channels
> and we need some mechanism to synchronize the pattern generators for
> some subset of the PWM channels.
>=20
>=20
> In other words we need some custom API between the LED driver part and
> the PWM driver, to configure these properties. This was the design
> of the downstream driver when I started looking at this driver.
>=20
>=20
> Another alternative that has been considered is to create two
> independent drivers - for the same hardware. This would allow the system
> integrator to pick the right driver for each of the channels.
>=20
> One problem with this strategy is that the DeviceTree description of the
> LPG hardware will have to be modified depending on the use case. In
> particular this prevents me from writing a platform dtsi describing the
> LPG hardware and then describe the LEDs and pwm channels in a board dts.
>=20
> And we can't express the individual channels, because the multicolor
> definition needs to span multiple channels.
>=20
>=20
> So among all the options, implementing the pwm_chip in the LED driver
> makes it possible for us to describe the LPG as one entity, with
> board-specific LEDs and a set of PWM channels.

ok.

> > At least splitting in two patches would be good IMHO.
>=20
> I guess I can split out the parts related to the pwmchip in a separate
> patch. Seems to be a rather small portion of the code though. Is that
> what you have in mind?

I didn't try to understand the pattern part. I know that for PWMs there
is no pattern support, wasn't aware it's a thing for LEDs.

Anyhow, not a hard requirement to split from my side.

> > > +/*
> > > + * Limitations:
> > > + * - Updating both duty and period is not done atomically, so the ou=
tput signal
> > > + *   will momentarily be a mix of the settings.
> >=20
> > Is the PWM well-behaved? (i.e. does it emit the inactive level when
> > disabled?)
>=20
> Yes, a disabled channel outputs a logical 0.

Please add this to the Limitations section. It's not actually a
limitation, but still this is a good place to put this information.

> > Does it complete a period before switching to the new
> > setting?
>=20
> I see nothing indicating the answer to this, in either direction...

Can you test that? It's as easy as configuring a long period with 0%
relative duty cycle and then immediately a 100% relative duty cycle.

> > > +static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > > +			      struct pwm_state *state)
> > > +{
> > > +	struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> > > +	struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> > > +	u64 duty =3D DIV_ROUND_UP_ULL(chan->pwm_value * chan->period, LPG_R=
ESOLUTION - 1);
> > > +
> > > +	state->period =3D chan->period;
> > > +	state->duty_cycle =3D duty;
> > > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > > +	state->enabled =3D chan->enabled;
> >=20
> > This doesn't work if .get_state() is called before .apply() was called,
> > does it?
> >=20
>=20
> You mean that I would return some bogus state and not the actual
> hardware state?

Yes. At least I only found lpg_calc_freq() assigning chan->period and
chan->enabled. And unless I missed something this isn't called before
the pwm core calls .get_state().

> > > +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pmrswpjw2cmgksco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmH7ksQACgkQwfwUeK3K
7AlI0wf8CMVIXyyyf7L5TUXfdVoY1v8vu1oPMUeS38RJC1HNbRoSKLZdgBk5boZR
b3+Of5faEST0BAQ/wf9W4Wef+7GBOV2PgZ9ZJuUu8Xz5/NH3WO3p9Tcy1mDTHR4W
epKHfi2m558q3j0rg44NfY/Dvw25cE2Sz6kPdM7/H6ux/yTEUfQdKP3Me/VVYs08
8rn92ceqp+EedjgzzBcCDpE89wqygiwMOzPv2KjlAla96p+0pilpGuWBN/i/sjLc
v3uh8XAH1yq1yKs1Hsh6GPGX+Q/SSxdWEONUqK7ipNmzTq8y4XAsXWPol9rU19nH
TnVwfLxfIRKXoRCStc6QHMJHjzYfew==
=7hTI
-----END PGP SIGNATURE-----

--pmrswpjw2cmgksco--
