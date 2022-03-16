Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7363B4DB929
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354158AbiCPUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbiCPUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:07:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D486E366
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:05:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUZtr-0007qn-8A; Wed, 16 Mar 2022 21:05:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUZto-00178f-FM; Wed, 16 Mar 2022 21:05:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nUZtm-009cMX-CG; Wed, 16 Mar 2022 21:05:34 +0100
Date:   Wed, 16 Mar 2022 21:05:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alex Elder <elder@linaro.org>
Cc:     Alex Elder <elder@ieee.org>, Song Chen <chensong_2000@189.cn>,
        johan@kernel.org, elder@kernel.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [greybus-dev] Re: [PATCH v5] staging: greybus: introduce
 pwm_ops::apply
Message-ID: <20220316200533.yuduet3gluvrmgcb@pengutronix.de>
References: <1647397285-30061-1-git-send-email-chensong_2000@189.cn>
 <49f18070-0215-8475-907b-487d1e01c15c@ieee.org>
 <20220316162903.kwkfefyznvopvr5g@pengutronix.de>
 <a1074d55-c5ee-ced5-b9f7-0e1d023e1fea@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zicekud7pynt6tb4"
Content-Disposition: inline
In-Reply-To: <a1074d55-c5ee-ced5-b9f7-0e1d023e1fea@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zicekud7pynt6tb4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2022 at 12:20:11PM -0500, Alex Elder wrote:
> On 3/16/22 11:29 AM, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 16, 2022 at 10:14:30AM -0500, Alex Elder wrote:
> > > On 3/15/22 9:21 PM, Song Chen wrote:
> > > > diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybu=
s/pwm.c
> > > > index 891a6a672378..3add3032678b 100644
> > > > --- a/drivers/staging/greybus/pwm.c
> > > > +++ b/drivers/staging/greybus/pwm.c
> > > > @@ -204,43 +204,54 @@ static void gb_pwm_free(struct pwm_chip *chip=
, struct pwm_device *pwm)
> > > >    	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
> > > >    }
> > > > -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > > > -			 int duty_ns, int period_ns)
> > > > +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > > > +			const struct pwm_state *state)
> > > >    {
> > > > +	int err;
> > > > +	bool enabled =3D pwm->state.enabled;
> > > > +	u64 period =3D state->period;
> > > > +	u64 duty_cycle =3D state->duty_cycle;
> > >=20
> > > The use of local variables here is inconsistent, and that
> > > can be confusing.  Specifically, the "enabled" variable
> > > represents the *current* state, while the "period" and
> > > "duty_cycle" variables represent the *desired* state.  To
> > > avoid confusion, if you're going to use local variables
> > > like that, they should all represent *either* the current
> > > state *or* the new state.  Please update your patch to
> > > do one or the other.
> >=20
> > IMHO that it overly picky. I'm ok with the usage as is.
>=20
> I see the "enabled" flag is used in a way that I didn't
> notice before.  Changing its name to "disabled" (to mean
> "we have disabled the device within this function already")
> would allow it to be used in the same way, but would make
> it more obvious it's not just a copy of "old" device state.
>=20
> > > >    	struct gb_pwm_chip *pwmc =3D pwm_chip_to_gb_pwm_chip(chip);
> > > > -	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_=
ns);
> > > > -};
> > > > +	/* set polarity */
> > > > +	if (state->polarity !=3D pwm->state.polarity) {
> > > > +		if (enabled) {
> > > > +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> > > > +			enabled =3D false;
> > > > +		}
> > > > +		err =3D gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->p=
olarity);
> > > > +		if (err)
> > > > +			return err;
> > > > +	}
> > > > -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> > > > -			       enum pwm_polarity polarity)
> > > > -{
> > > > -	struct gb_pwm_chip *pwmc =3D pwm_chip_to_gb_pwm_chip(chip);
> > > > +	if (!state->enabled) {
> > > > +		if (enabled)
> > > > +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> > > > +		return 0;
> > >=20
> > > If you are disabling the device, you return without updating the
> > > period and duty cycle.  But you *do* set polarity.  Is that
> > > required by the PWM API?  (I don't actually know.)  Or can the
> > > polarity setting be simply ignored as well if the new state is
> > > disabled?
> >=20
> > All is well here. A disabled PWM is expected to emit the inactive level.
> > So polarity matters, duty and period don't.
>=20
> Thanks for clarifying that.  I did not know what was expected.
>=20
> > > Also, if the polarity changed, the device will have already been
> > > disabled above, so there's no need to do so again (and perhaps
> > > it might be a bad thing to do twice?).
> >=20
> > That won't happen, because if the device was disabled for the polarity
> > change, enabled =3D false. In fact that is the purpose of the local
> > variable.
>=20
> Now I see, yes, the local variable gets changed when the
> disable occurred above.
>=20
> > > > +	}
> > > > -	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
> > > > -};
> > >=20
> > > Since you're clamping the values to 32 bits here, your comment
> > > should explain why (because Greybus uses 32-bit values here,
> > > while the API supports 64 bit values).  That would be a much
> > > more useful piece of information than "set period and duty cycle".
> > >=20
> > > > +	/* set period and duty cycle*/
> > >=20
> > > Include a space before "*/" in your comments.
> >=20
> > ack
> >=20
> > > > +	if (period > U32_MAX)
> > > > +		period =3D U32_MAX;
> > > > -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device =
*pwm)
> > > > -{
> > > > -	struct gb_pwm_chip *pwmc =3D pwm_chip_to_gb_pwm_chip(chip);
> > > > +	if (duty_cycle > period)
> > > > +		duty_cycle =3D period;
> > > > -	return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
> > > > -};
> > > > +	err =3D gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, per=
iod);
> > > > +	if (err)
> > > > +		return err;
> > >=20
> > > What if the new state set usage_power to true?  It would
> > > be ignored here.  Is it OK to silently ignore it?  Even
> > > if it is, a comment about that would be good to see, so
> > > we know it's intentional.
> >=20
> > ignoring usage_power is OK. All but a single driver do it that way.
>=20
> I don't actually see anything that sets usage_power to true,
> although "pwm-pca9685.c" tests its value.
>=20
> I guess it's an advisory parameter that's passed to the apply
> callback function.  It's described as optional, but--not being
> a "PWM person"--this isn't obvious to me.  Maybe the comments
> describing the field or the apply callback could define the
> semantics a little better at some point.

One of the problems I see with usage_power is that it's not well
defined. The idea is that when usage_power is true, the driver is free
to implement any setting that just matches the relative duty_cycle of
the request. So if you call pwm_apply with

	.duty_cycle =3D 2000
	.period =3D 10000
	.usage_power =3D true
	.polarity =3D PWM_POLARITY_NORMAL

you can program the hardware to implement

	.duty_cycle =3D 200
	.period =3D 1000
	.polarity =3D PWM_POLARITY_NORMAL

or

	.duty_cycle =3D 8000000
	.period =3D 10000000
	.polarity =3D PWM_POLARITY_INVERTED

The expectation is however to only deviate in a sensible manner from the
request, whatever that might mean.

I don't see much value in that field, there is only one implementing
driver and no mainline user. If you're interested you can reread the
discussions about it in the archives.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zicekud7pynt6tb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIyQwoACgkQwfwUeK3K
7AlO1Af+P7X4ob1VHBq63vI9wb9jQLXGLT6oydYIJSHPalDOukXd8anEw6Jpn+mv
V2YwTrjYQr2wjfLzq8OGiO6dexD5FZjyEjhGTkyzDoA9pjy0w1dLSB48aSct9UK8
v2oWdSHitZYA6sHr+SLnHwK8qXDn4WSCr9JE2tyXTd1ERjLTFvQw9h1q/0XSah3x
wSx4vKuxvASebXuOcCTvsNquDGYthH5BjYf07vt78zbp122/9zzTaPjdqhjvfrZF
FW0F0szkXkxOOClBU2jqoDN5JEhLNynUmtwc9ghyFUtdIOuvHAdL0x+J0+Io4Jsy
tgTPBZ6hGTZOoB+7cCgla8lDe8ohDA==
=pyHU
-----END PGP SIGNATURE-----

--zicekud7pynt6tb4--
