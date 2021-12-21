Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9247BDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhLUJvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLUJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:51:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12750C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:51:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzbnN-0000la-F4; Tue, 21 Dec 2021 10:50:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzbnN-005nDX-70; Tue, 21 Dec 2021 10:50:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzbnM-00015w-6D; Tue, 21 Dec 2021 10:50:56 +0100
Date:   Tue, 21 Dec 2021 10:50:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH V2] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <20211221095053.uz4qbnhdqziftymw@pengutronix.de>
References: <20211220073130.1429723-1-xiaoning.wang@nxp.com>
 <20211220105555.zwq22vip7onafrck@pengutronix.de>
 <AM6PR04MB5623CF67F7F7404852F6ABAAF37C9@AM6PR04MB5623.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qhb5vy7wuijloi5a"
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5623CF67F7F7404852F6ABAAF37C9@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qhb5vy7wuijloi5a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clark,

On Tue, Dec 21, 2021 at 07:11:15AM +0000, Clark Wang wrote:
> > On Mon, Dec 20, 2021 at 03:31:30PM +0800, Clark Wang wrote:
> > > Workaround:
> > > Add an old value SAR write before updating the new duty cycle to SAR.
> > > This will keep the new value is always in a not empty fifo, and can b=
e wait
> > > to update after a period finished.
> > >
> > > Limitation:
> > > This workaround can only solve this issue when the PWM period is long=
er than
> > > 2us(or <500KHz).
> > >
> > > Reviewed-by: Jun Li <jun.li@nxp.com>
> > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > > ---
> > > V2:
> > >  Fix the warnings when built in riscv-gcc, which is reported by kerne=
l test robot
> > <lkp@intel.com>
> > > ---
> > >  drivers/pwm/pwm-imx27.c | 67
> > ++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 62 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > index ea91a2f81a9f..3d9ca60e2baa 100644
> > > --- a/drivers/pwm/pwm-imx27.c
> > > +++ b/drivers/pwm/pwm-imx27.c
> > > @@ -21,11 +21,13 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pwm.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > >
> > >  #define MX3_PWMCR			0x00    /* PWM Control Register */
> > >  #define MX3_PWMSR			0x04    /* PWM Status Register */
> > >  #define MX3_PWMSAR			0x0C    /* PWM Sample
> > Register */
> > >  #define MX3_PWMPR			0x10    /* PWM Period Register */
> > > +#define MX3_PWMCNR			0x14    /* PWM Counter
> > Register */
> > >
> > >  #define MX3_PWMCR_FWM			GENMASK(27, 26)
> > >  #define MX3_PWMCR_STOPEN		BIT(25)
> > > @@ -91,6 +93,7 @@ struct pwm_imx27_chip {
> > >  	 * value to return in that case.
> > >  	 */
> > >  	unsigned int duty_cycle;
> > > +	spinlock_t lock;
> > >  };
> > >
> > >  #define to_pwm_imx27_chip(chip)	container_of(chip, struct
> > pwm_imx27_chip, chip)
> > > @@ -201,10 +204,10 @@ static void pwm_imx27_wait_fifo_slot(struct
> > pwm_chip *chip,
> > >
> > >  	sr =3D readl(imx->mmio_base + MX3_PWMSR);
> > >  	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
> > > -	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {
> > > +	if (fifoav >=3D MX3_PWMSR_FIFOAV_3WORDS) {
> > >  		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),
> > >  					 NSEC_PER_MSEC);
> > > -		msleep(period_ms);
> > > +		msleep(period_ms * (fifoav - 2));
> >=20
> > This changes semantic, from "wait for at least one free FIFO slot" to
> > "wait for at least two FIFO slots". Maybe a comment would be good? At
> > least the comment above the caller of pwm_imx27_wait_fifo_slot() needs
> > adaption.
>=20
> [Clark] OK, I will add a comment here.
> The reason for waiting for at least two empty FIFO slots here is to ensur=
e as much as possible that the SAR will not fail because the FIFO is full w=
hen writing to the SAR twice.

However if there are still 3 pending SAR values you don't need to write
twice. So waiting for a single free slot should be good enough.
=20
> > Also I wonder: If there is only a single free slot, there is no problem,
> > is there?
>=20
> [Clark] In most cases, this situation is fine. As long as the FIFO is not=
 empty when the SAR is updated, this problem will not be triggered.
>=20
> >=20
> > >  		sr =3D readl(imx->mmio_base + MX3_PWMSR);
> > >  		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))
> >=20
> > The error test is wrong then. If fifoav was initially 4 and waiting only
> > reduced it to 3, you don't trigger a warning.
>=20
> [Clark] Yes, Thanks. I will change it to " if (FIELD_GET(MX3_PWMSR_FIFOAV=
, sr) < MX3_PWMSR_FIFOAV_3WORDS)"

(However this request is void if you stick to waiting for a single free
slot.)

> > On a side note: pwm_get_period() might return a value that is too big.
> > This could be improved using readl_poll_timeout.
>=20
> [Clark] Yes, this is a good idea! I can change to use readl_poll_timeout =
to wait fifoav < 3.

In a separate patch please (and as above, wait for fifoav < 4 only).=20

> > > @@ -215,13 +218,15 @@ static void pwm_imx27_wait_fifo_slot(struct
> > pwm_chip *chip,
> > >  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > >  			   const struct pwm_state *state)
> > >  {
> > > -	unsigned long period_cycles, duty_cycles, prescale;
> > > +	unsigned long period_cycles, duty_cycles, prescale, counter_check,
> > flags;
> > >  	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> > > +	void __iomem *reg_sar =3D imx->mmio_base + MX3_PWMSAR;
> > > +	__force u32 sar_last, sar_current;
> > >  	struct pwm_state cstate;
> > >  	unsigned long long c;
> > >  	unsigned long long clkrate;
> > >  	int ret;
> > > -	u32 cr;
> > > +	u32 cr, timeout =3D 1000;
> > >
> > >  	pwm_get_state(pwm, &cstate);
> > >
> > > @@ -262,7 +267,57 @@ static int pwm_imx27_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,
> > >  		pwm_imx27_sw_reset(chip);
> > >  	}
> > >
> > > -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > +	/*
> > > +	 * This is a limited workaround. When the SAR FIFO is empty, the new
> > > +	 * write value will be directly applied to SAR even the current per=
iod
> > > +	 * is not over.
> >=20
> > 	When the SAR FIFO is empty, a new SAR value will be applied directly
> > 	instead of waiting for the current period to complete.
> >=20
> > is grammatically better (at least with my German sense for English
> > grammar) and might be better to understand.
>=20
> [Clark] OK. My description may be a bit verbose.
>=20
> >=20
> > > +	 * If the new SAR value is less than the old one, and the counter is
> > > +	 * greater than the new SAR value, the current period will not filp
> >=20
> > s/filp/flip/
> >=20
> > > +	 * the level. This will result in a pulse with a duty cycle of 100%.
> > > +	 * So, writing the current value of the SAR to SAR here before upda=
ting
> > > +	 * the new SAR value can avoid this issue.
> >=20
> > This can be expressed a bit easier (and more correct) I think:
> >=20
> > 	If the SAR value is decreased over the counter value, there is
> > 	no compare event in the current period resulting in a 100%
> > 	period.
> >=20
> > (This is more correct because decreasing the SAR from 200 to 100 if the
> > counter is already at 300 doesn't result in the problem.)
>=20
> [Clark] Thank you for your detailed comments, I will revise it in the nex=
t edition.
>=20
> >=20
> > > +	 * Add a spin lock and turn off the interrupt to ensure that the
> >=20
> > The usual term is "turn off interrupts" because not only the PWM irq is
> > disabled, but all are. I wonder if just disabling irqs serves the same
> > purpose.
>=20
> [Clark] Our purpose here is to turn off all interrupts. I will modify the=
 description here.
>=20
> >=20
> > > +	 * real-time performance can be guaranteed as much as possible when
> >=20
> > Disabling interrupts is never good for real-time performance.
> >=20
> > Having said that I think I'd go for a solution without irq disabling.
>=20
>=20
> [Clark]
> The two necessary conditions that cause this problem are:
> a) SAR FIFO is empty
> b) New SAR<CNR<Old SAR
>=20
> Code in the following "if (duty_cycles <imx->duty_cycle) {}" is to preven=
t the problem from recurring even if SAR is written twice in the following =
situations:
> 1. The pwm period is set at will. Our logic is to directly update the new=
 SAR value when the FIFO is not empty to avoid this issue. But if after we =
read FIFO =3D=3D 1, the time to the end of the current cycle is less than t=
he time used by writing to the SAR twice, the second updated SAR value is s=
till equivalent to being written in the empty FIFO. This may cause this iss=
ue again.
> 2. The PWM period is extremely small (such as 2us). When the FIFO itself =
is empty, if the total time of two SAR writes cannot be guaranteed to be wi=
thin 2us, then the second updated SAR value is still equivalent to being wr=
itten in the empty FIFO. Because the first updated SAR value is updated to =
the on-going SAR register, the SAR FIFO is empty again when write the secon=
d SAR value.
> So in order to avoid the above two situations, we must ensure that:
> a) The total time for writing two SARs is as small as possible.
> b) The two SAR writes need to be completed within one PWM cycle.
>=20
> I did an experiment:
> On imx8mp, set the PWM period to 50us.
> When spin_lock_irqsave() is not added, a 100% high level period can still=
 be observed with a high probability even write SAR twice.
> After spin_lock_irqsave() is added, there is a very small probability tha=
t a 100% high level period will appear. (This avoids the second situation d=
escribed above.)
> At the same time, add counter_check to ensure that the end of the current=
 period is greater than 1.5us. Then quickly write the SAR twice. Period gre=
ater than 2us can no longer reproduce this problem. (This avoids the first =
situation described above.)
>=20
> From the experimental results, adding spin_lock_irqsave() can effectively=
 guarantee the code running time during the period.

Did you test with local_irq_save() instead of the spin_lock?=20

> If you have a better way, we can discuss. :)

Maybe disable the PWM on reconfiguration? That is, clear the enable bit,
then the counter stops (and output freezes). Then you can check for a
word in the fifo, add one or two and reenable the PWM.

Then you don't have to disable irqs at all and only increase the current
period by by the time you need to setup the new settings.

> > > +		sar_last =3D (__force u32) cpu_to_le32(imx->duty_cycle);
> > > +		sar_current =3D (__force u32) cpu_to_le32(duty_cycles);
> >=20
> > If endianess conversion is necessary, please apply it to the complete
> > driver in a separate patch. Doing this only in one place and skipping
> > several others is just irritating.
>=20
> [Clark] Sorry. But the endianess conversion here is the step before the v=
alue is actually written into the register in marco writel_relaxed().
> #define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)

Ah I see. I suggest to mention that in a comment.
=20
> The purpose of doing the endianess conversion here in advance is to ensur=
e that the writing INTERVAL of the next two SAR updates is as short as poss=
ible.
> 	__raw_writel(sar_last, reg_sar);
> 	=E2=86=91 The INTERVAL between these two lines. =E2=86=93
> 	__raw_writel(sar_current, reg_sar);

Did you verify that the compiler understood your wish and that splitting
the call to writel_relaxed() indeed improves the situation?

> [Clark]
>=20
> >=20
> > > +		spin_lock_irqsave(&imx->lock, flags);
> > > +		if (state->period >=3D 2000) {
> >=20
> > This checks the new period value that doesn't have to do anything with
> > the hardware state yet. So this check isn't sensible, is it?
>=20
> [Clark] No, this check is useful.
> Because we add counter_check to ensure that the end of the current period=
 is greater than 1.5us. This workaround can only fix situations when the pe=
riod is set greater than 1.5us.

You didn't get what I wanted to point out here. Consider the PWM is
currently running with period =3D 100 ns. Then .apply is called,
requesting period =3D 3000 ns. Your code then does the wait dance because
the new value is big enough. However it's the currently configured value
that should be considered to judge if the dance is required.

> If the PWM period set by user is shorter than 1.5us, then the 1.5us
> counter_check will never be true. This is why this check is added.

The check is sound, however your suggested implementation is wrong.

> > > +			while ((period_cycles -
> > > +				readl_relaxed(imx->mmio_base +
> > MX3_PWMCNR))
> > > +				< counter_check) {
> >=20
> > period_cycles is the new overflow value.  If the current overflow value
> > is lower, the loop might terminate immediately. If however the current
> > overflow value is higher than period_cycles, the subtraction might
> > overflow resulting in the check to be true. In both cases there isn't
> > any relation to the next overflow event.
>=20
> [Clark] Using signed numbers here may solve the problem you raised. Thank=
s.

uah, no. Please stick to unsigned and just fix the test.

> > > +				if (!--timeout)
> > > +					break;
> >=20
> > On a fast machine with a long period this might end in a timeout before
> > the rollover.
>=20
> [Clark]
> No.=20
> If it is a long period, as long as the absolute time from the end of the =
current period is greater than 1.5us. The while loop above will finish. Wil=
l not cause a timeout.=20

If the currently running period lasts 1.4 =C2=B5s at function entry you
intend to wait for 1.4 =C2=B5s, right? You check up to 1000 times if the
1.4=C2=B5s are already over. If each check takes 1 ns, you only wait 1=C2=
=B5s.
While this probably doesn't happen because in the future a check will
take longer than 1.5ns for quite some time, it's bad style and a bad
template for someone implementing something similar on a different
machine where the timings are different.

> If the time from the end of the current period is less than 1.5us, after =
waiting for 1.5us, it will enter the next new long period, which must meet =
counter_check > 1.5us, and will also finish the while loop.
> [Clark]
>=20
> >=20
> > > +			};
> > > +		}
> > > +		if (!(MX3_PWMSR_FIFOAV &
> > > +		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
> > > +			__raw_writel(sar_last, reg_sar);
> >=20
> > Why not use FIELD_GET for consistency here?
>=20
> [Clark] In order to ensure that the interval between two SAR writes is as=
 short as possible. This allows this workaround to support shorter PWM peri=
od.

I would expect that using FIELD_GET does result in the same code being
generated. So the only effect is to make this more readable to a human
reader.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qhb5vy7wuijloi5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHBo3oACgkQwfwUeK3K
7Any4Af/VZyTB+qlCD7MY6zcjhhCQseBUgqJ7pTsnMJpJeB0DECFUyjLvADeMmOJ
tx/IqPY6pXw/nmIWpMK9nHKRtZGZaU4SR6OhRE3TXtBHEFMNm8qr35cCCVWwTPg7
fI8ad28HizPqZn6o/atGjjlhNRnqcGqPB7LcxtP81QOGYTil5QVK6B8icls4PozE
nV9kk3laNpm6LE7OxlzBcQvNL2Q4RXsyv9e0JoTPTBeZRk9lpamHOKTRr47dOZN3
vzhWusho9k5IeWCgfAtAtcGuOqBJ2Zt0GwMvByKPRoqjtW1+VlSJBDHVYualK38y
Lq+uXymBx+TK90MVIBvU9I/Zs5SY7A==
=BEWf
-----END PGP SIGNATURE-----

--qhb5vy7wuijloi5a--
