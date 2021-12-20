Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB647A7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhLTK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhLTK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:56:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA26C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 02:56:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzGKm-0003hV-MP; Mon, 20 Dec 2021 11:56:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzGKl-005cCe-RY; Mon, 20 Dec 2021 11:55:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mzGKk-0002eg-Q1; Mon, 20 Dec 2021 11:55:58 +0100
Date:   Mon, 20 Dec 2021 11:55:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH V2] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <20211220105555.zwq22vip7onafrck@pengutronix.de>
References: <20211220073130.1429723-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6yqfau2sgkcnhku7"
Content-Disposition: inline
In-Reply-To: <20211220073130.1429723-1-xiaoning.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6yqfau2sgkcnhku7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[added Jun Li who reviewed the patch to Cc:]

On Mon, Dec 20, 2021 at 03:31:30PM +0800, Clark Wang wrote:
> This is a limited workaround for the PWM IP issue.
>=20
> Root cause:
> When the SAR FIFO is empty, the new write value will be directly applied
> to SAR even the current period is not over.


> If the new SAR value is less than the old one, and the counter is
> greater than the new SAR value, the current period will not filp the
> level. This will result in a pulse with a duty cycle of 100%.

I read the i.MX25 PWM chapter a few times now, and I played around a
bit. I could confirm the issue.

> Workaround:
> Add an old value SAR write before updating the new duty cycle to SAR.
> This will keep the new value is always in a not empty fifo, and can be wa=
it
> to update after a period finished.
>=20
> Limitation:
> This workaround can only solve this issue when the PWM period is longer t=
han
> 2us(or <500KHz).
>=20
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
> V2:
>  Fix the warnings when built in riscv-gcc, which is reported by kernel te=
st robot <lkp@intel.com>
> ---
>  drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index ea91a2f81a9f..3d9ca60e2baa 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -21,11 +21,13 @@
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/slab.h>
> +#include <linux/spinlock.h>
> =20
>  #define MX3_PWMCR			0x00    /* PWM Control Register */
>  #define MX3_PWMSR			0x04    /* PWM Status Register */
>  #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
>  #define MX3_PWMPR			0x10    /* PWM Period Register */
> +#define MX3_PWMCNR			0x14    /* PWM Counter Register */
> =20
>  #define MX3_PWMCR_FWM			GENMASK(27, 26)
>  #define MX3_PWMCR_STOPEN		BIT(25)
> @@ -91,6 +93,7 @@ struct pwm_imx27_chip {
>  	 * value to return in that case.
>  	 */
>  	unsigned int duty_cycle;
> +	spinlock_t lock;
>  };
> =20
>  #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip=
, chip)
> @@ -201,10 +204,10 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chi=
p *chip,
> =20
>  	sr =3D readl(imx->mmio_base + MX3_PWMSR);
>  	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
> -	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {
> +	if (fifoav >=3D MX3_PWMSR_FIFOAV_3WORDS) {
>  		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),
>  					 NSEC_PER_MSEC);
> -		msleep(period_ms);
> +		msleep(period_ms * (fifoav - 2));

This changes semantic, from "wait for at least one free FIFO slot" to
"wait for at least two FIFO slots". Maybe a comment would be good? At
least the comment above the caller of pwm_imx27_wait_fifo_slot() needs
adaption.

Also I wonder: If there is only a single free slot, there is no problem,
is there?

>  		sr =3D readl(imx->mmio_base + MX3_PWMSR);
>  		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))

The error test is wrong then. If fifoav was initially 4 and waiting only
reduced it to 3, you don't trigger a warning.

On a side note: pwm_get_period() might return a value that is too big.
This could be improved using readl_poll_timeout.

> @@ -215,13 +218,15 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chi=
p *chip,
>  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   const struct pwm_state *state)
>  {
> -	unsigned long period_cycles, duty_cycles, prescale;
> +	unsigned long period_cycles, duty_cycles, prescale, counter_check, flag=
s;
>  	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> +	void __iomem *reg_sar =3D imx->mmio_base + MX3_PWMSAR;
> +	__force u32 sar_last, sar_current;
>  	struct pwm_state cstate;
>  	unsigned long long c;
>  	unsigned long long clkrate;
>  	int ret;
> -	u32 cr;
> +	u32 cr, timeout =3D 1000;
> =20
>  	pwm_get_state(pwm, &cstate);
> =20
> @@ -262,7 +267,57 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		pwm_imx27_sw_reset(chip);
>  	}
> =20
> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	/*
> +	 * This is a limited workaround. When the SAR FIFO is empty, the new
> +	 * write value will be directly applied to SAR even the current period
> +	 * is not over.

	When the SAR FIFO is empty, a new SAR value will be applied directly
	instead of waiting for the current period to complete.

is grammatically better (at least with my German sense for English
grammar) and might be better to understand.

> +	 * If the new SAR value is less than the old one, and the counter is
> +	 * greater than the new SAR value, the current period will not filp

s/filp/flip/

> +	 * the level. This will result in a pulse with a duty cycle of 100%.
> +	 * So, writing the current value of the SAR to SAR here before updating
> +	 * the new SAR value can avoid this issue.

This can be expressed a bit easier (and more correct) I think:=20

	If the SAR value is decreased over the counter value, there is
	no compare event in the current period resulting in a 100%
	period.

(This is more correct because decreasing the SAR from 200 to 100 if the
counter is already at 300 doesn't result in the problem.)

> +	 * Add a spin lock and turn off the interrupt to ensure that the

The usual term is "turn off interrupts" because not only the PWM irq is
disabled, but all are. I wonder if just disabling irqs serves the same
purpose.

> +	 * real-time performance can be guaranteed as much as possible when

Disabling interrupts is never good for real-time performance.

Having said that I think I'd go for a solution without irq disabling.

> +	 * operating the following operations.
> +	 *
> +	 * 1. Add a threshold of 1.5us. If the time T between the read current
> +	 * count value CNR and the end of the cycle is less than 1.5us, wait
> +	 * for T to be longer than 1.5us before updating the SAR register.
> +	 * This is to avoid the situation that when the first SAR is written,
> +	 * the current cycle just ends and the SAR FIFO that just be written
> +	 * is emptied again.
> +	 *
> +	 * 2. Use __raw_writel() to minimize the interval between two writes to
> +	 * the SAR register to increase the fastest pwm frequency supported.
> +	 *
> +	 * When the PWM period is longer than 2us(or <500KHz), this workaround
> +	 * can solve this problem.
> +	 */
> +	if (duty_cycles < imx->duty_cycle) {
> +		c =3D clkrate * 1500;
> +		do_div(c, NSEC_PER_SEC);
> +		counter_check =3D c;

This needs to account for PWMCR.PRESCALER.

> +		sar_last =3D (__force u32) cpu_to_le32(imx->duty_cycle);
> +		sar_current =3D (__force u32) cpu_to_le32(duty_cycles);

If endianess conversion is necessary, please apply it to the complete
driver in a separate patch. Doing this only in one place and skipping
several others is just irritating.

> +		spin_lock_irqsave(&imx->lock, flags);
> +		if (state->period >=3D 2000) {

This checks the new period value that doesn't have to do anything with
the hardware state yet. So this check isn't sensible, is it?

> +			while ((period_cycles -
> +				readl_relaxed(imx->mmio_base + MX3_PWMCNR))
> +				< counter_check) {

period_cycles is the new overflow value.  If the current overflow value
is lower, the loop might terminate immediately. If however the current
overflow value is higher than period_cycles, the subtraction might
overflow resulting in the check to be true. In both cases there isn't
any relation to the next overflow event.

> +				if (!--timeout)
> +					break;

On a fast machine with a long period this might end in a timeout before
the rollover.

> +			};
> +		}
> +		if (!(MX3_PWMSR_FIFOAV &
> +		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
> +			__raw_writel(sar_last, reg_sar);

Why not use FIELD_GET for consistency here?

> +		__raw_writel(sar_current, reg_sar);
> +		spin_unlock_irqrestore(&imx->lock, flags);
> +	} else
> +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);

This violates the coding style. If one branch of an if needs braces, all
branches should use them.

> +
>  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);

Changing the period value resets the counter. So to minimize the effect
of the mitigation (i.e. a busy loop for up to 1.5=B5s with irqs off) I
suggest to do the wait and write SAR twice only if period doesn't change
and SAR is actually decreased over the current counter value.
=20
>  	/*
> @@ -323,6 +378,8 @@ static int pwm_imx27_probe(struct platform_device *pd=
ev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
>  				     "failed to get peripheral clock\n");
> =20
> +	spin_lock_init(&imx->lock);
> +	imx->duty_cycle =3D 0;

duty_cycle is already 0 here, so there is no need to initialize it.

>  	imx->chip.ops =3D &pwm_imx27_ops;
>  	imx->chip.dev =3D &pdev->dev;
>  	imx->chip.npwm =3D 1;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6yqfau2sgkcnhku7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHAYTgACgkQwfwUeK3K
7AlSigf9GYB2O8+rGvT01uvcW6nZQaPKzKyy63o7QiZgVnzEwt+ZOPzOH5r8GuwX
6x3rE7E9VfKoJit7ufHhOHOA9B89k+Rr0dN4UZTFzf2vRrI9CI9V7s024stiCePQ
olK/aEfUVNbuJjO/fIchzo2exkZmzVkAMF/Z0YaYgfqdFyN1c40zN2hpuOL3r/eU
23Pva4MYTUdqtP06cBHeJ6ZvS0hKZkXqaEonKsMrIOOUsU10RFsaoFGGpEYhVYCD
gX2b6TjmOP7R5Zd4QG5jxrrZ6leE203QXQ/WA8nhhRgCNV6I3kywh5s2DtoUk1UR
eAy0mNsGrLGFEFweOdRsAM/4uenB4w==
=cVev
-----END PGP SIGNATURE-----

--6yqfau2sgkcnhku7--
