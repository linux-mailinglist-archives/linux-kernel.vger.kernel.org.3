Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE04830E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiACMPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiACMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:15:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41ECC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 04:15:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4MEr-0006ch-Vp; Mon, 03 Jan 2022 13:14:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4MEq-008Dw2-A4; Mon, 03 Jan 2022 13:14:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4MEp-0001nn-6F; Mon, 03 Jan 2022 13:14:55 +0100
Date:   Mon, 3 Jan 2022 13:14:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     vishakha.joshi@intel.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        vijayakannan.ayyathurai@intel.com, bala.senthil@intel.com,
        tamal.saha@intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v1 1/2] pwm: Add count to sysfs for Intel PWM driver
Message-ID: <20220103121454.rduz4jftean4hkaw@pengutronix.de>
References: <20220103081610.6656-1-vishakha.joshi@intel.com>
 <20220103081610.6656-2-vishakha.joshi@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apinchpx3uxehcnj"
Content-Disposition: inline
In-Reply-To: <20220103081610.6656-2-vishakha.joshi@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--apinchpx3uxehcnj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jan 03, 2022 at 01:46:09PM +0530, vishakha.joshi@intel.com wrote:
> From: Vishakha Joshi <vishakha.joshi@intel.com>
>=20
> The number of cycles in the PWM waveform is generated according to the
> count value configured in the sysfs interface.
> This helps to control the duration of the PWM waveform in the KeemBay
> SoC.
> In case of default count value which is zero, the PWM waveform repeats
> indefinitely.
>=20
> Signed-off-by: Vishakha Joshi <vishakha.joshi@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-pwm |  8 ++++++
>  drivers/pwm/sysfs.c                       | 34 +++++++++++++++++++++++
>  include/linux/pwm.h                       |  2 ++
>  3 files changed, 44 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-pwm b/Documentation/AB=
I/testing/sysfs-class-pwm
> index 3d65285bcd5f..dde57b5a359f 100644
> --- a/Documentation/ABI/testing/sysfs-class-pwm
> +++ b/Documentation/ABI/testing/sysfs-class-pwm
> @@ -86,3 +86,11 @@ Description:
>  		Capture information about a PWM signal. The output format is a
>  		pair unsigned integers (period and duty cycle), separated by a
>  		single space.
> +
> +What:		/sys/class/pwm/pwmchip<N>/pwmX/count
> +Date:		December 2021
> +KernelVersion:  5.17
> +Contact:	Vishakha Joshi <vishakha.joshi@intel.com>
> +Description:
> +		The PWM repeat count of the number of cycles in the waveform.
> +		The default value for the count is zero with infinite repetition.
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 9903c3a7eced..4d8fbd134f1d 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -215,11 +215,44 @@ static ssize_t capture_show(struct device *child,
>  	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
>  }
> =20
> +static ssize_t count_store(struct device *child, struct device_attribute=
 *attr, const char *buf,
> +			   size_t size)
> +{
> +	struct pwm_export *export =3D child_to_pwm_export(child);
> +	struct pwm_device *pwm =3D export->pwm;
> +	struct pwm_state state;
> +	unsigned int count;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 0, &count);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&export->lock);
> +	pwm_get_state(pwm, &state);
> +	state.count =3D count;
> +	ret =3D pwm_apply_state(pwm, &state);
> +	mutex_unlock(&export->lock);
> +
> +	return ret ?: size;
> +}
> +
> +static ssize_t count_show(struct device *child, struct device_attribute =
*attr, char *buf)
> +{
> +	const struct pwm_device *pwm =3D child_to_pwm_device(child);
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +
> +	return sysfs_emit(buf, "%d\n", state.count);
> +}
> +
>  static DEVICE_ATTR_RW(period);
>  static DEVICE_ATTR_RW(duty_cycle);
>  static DEVICE_ATTR_RW(enable);
>  static DEVICE_ATTR_RW(polarity);
>  static DEVICE_ATTR_RO(capture);
> +static DEVICE_ATTR_RW(count);
> =20
>  static struct attribute *pwm_attrs[] =3D {
>  	&dev_attr_period.attr,
> @@ -227,6 +260,7 @@ static struct attribute *pwm_attrs[] =3D {
>  	&dev_attr_enable.attr,
>  	&dev_attr_polarity.attr,
>  	&dev_attr_capture.attr,
> +	&dev_attr_count.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(pwm);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index e6dac95e4960..dc0612867e65 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -52,6 +52,7 @@ enum {
>   * struct pwm_state - state of a PWM channel
>   * @period: PWM period (in nanoseconds)
>   * @duty_cycle: PWM duty cycle (in nanoseconds)
> + * @count: PWM repeat count
>   * @polarity: PWM polarity
>   * @enabled: PWM enabled status
>   * @usage_power: If set, the PWM driver is only required to maintain the=
 power
> @@ -62,6 +63,7 @@ enum {
>  struct pwm_state {
>  	u64 period;
>  	u64 duty_cycle;
> +	u32 count;
>  	enum pwm_polarity polarity;
>  	bool enabled;
>  	bool usage_power;

This needs more documentation about what the semantic should be. E.g.
what should .get_state return?

Also I doubt this is a good idea given that most controllers cannot
implement it.

If we really want to support a count, I request that all drivers that
don't support it get updated to refuse a request with count !=3D 0.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--apinchpx3uxehcnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHS6LsACgkQwfwUeK3K
7AlZlgf+M3DJy4yxT8qmlYpVvZud9vLt0iyq/gQNczGntf6CPM/XnKU4SuAKiswo
yM9tv71uclkrsoEvKMG5HKwAaSKJiwp1CH25YqxsBqBwl083hPr52d8GzcCpcQ1b
vnqsdaHNNhP+QrvZ5dOgLtYQKRq/0slduov85FhBGPxPr5ELqXIVTldGdnkllL1q
UVTXFI6T0OetIM8W5QTAi9pQn/KeCkBlH3hfbPAOxNnz7hbSuqxa/GbHIGekpL0i
+IyhU7PHFqprGJoY35XqtXcjJRomar3YHRSvB5deCyFJ3lZfLQ4A8RkD/CLhgLyM
P875JDFRBWCly1cgjV5oNVqtwxU9Dw==
=bns1
-----END PGP SIGNATURE-----

--apinchpx3uxehcnj--
