Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1458CD08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbiHHRt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiHHRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:49:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF6C192BF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:48:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL6rz-0000Q7-JR; Mon, 08 Aug 2022 19:48:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL6rq-002Xvr-7w; Mon, 08 Aug 2022 19:48:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL6rr-00APNG-QM; Mon, 08 Aug 2022 19:48:43 +0200
Date:   Mon, 8 Aug 2022 19:48:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "m.shams" <m.shams@samsung.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com
Subject: Re: [PATCH] pwm: removes period check from pwm_apply_state()
Message-ID: <20220808174842.jiato34jzqstchdn@pengutronix.de>
References: <CGME20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea@epcas5p2.samsung.com>
 <20220805101125.47955-1-m.shams@samsung.com>
 <20220805155509.edqwxcvyoqfic4pn@pengutronix.de>
 <019701d8ab31$94c86d60$be594820$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3ccmj6mewpavh5f"
Content-Disposition: inline
In-Reply-To: <019701d8ab31$94c86d60$be594820$@samsung.com>
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


--h3ccmj6mewpavh5f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I fixed up the quoting for you in this mail. Please fix your mailer to
not break quotes, this is quite annoying. (Looking at the headers of
your mail you're using Outlook. Then your only viable option is to
switch to a saner client.)

On Mon, Aug 08, 2022 at 07:47:03PM +0530, m.shams wrote:
> On Fri, Aug 05, 2022 at 03:41:25PM +0530, Tamseel Shams wrote:
> > > There may be situation when PWM is exported using sysfs, but at that=
=20
> > > point PWM period is not set. At this situation if we issue a system=
=20
> > > suspend, it calls pwm_class_suspend which in turn calls=20
> > > pwm_apply_state, where PWM period value is checked which returns an=
=20
> > > invalid argument error casuing Kernel to panic. So, check for PWM=20
> > > period value is removed so as to fix the kernel panic observed during=
=20
> > > suspend.
> >
> > This looks and sounds wrong. One thing I would accept is:
> >
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 0e042410f6b9..075bbcdad6c1 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -557,8 +557,8 @@ int pwm_apply_state(struct pwm_device *pwm, const s=
truct pwm_state *state)
> > 	 */
> > 	might_sleep();
> >=20
> > -	if (!pwm || !state || !state->period ||
> > -	    state->duty_cycle > state->period)
> > +	if (!pwm || !state || state->enabled && (!state->period ||
> > +	    state->duty_cycle > state->period))
> >  		return -EINVAL;
> >=20
> > 	chip =3D pwm->chip;
> >
> > That is, don't refuse calling pwm_apply_state() for state->period =3D 0=
 and
> > even state->duty_cycle > state->period if the > > PWM is not enabled.
>=20
> By this do you mean doing it following way?
>=20
> if (!pwm || !state || (pwm && !state->period) ||
> 	    (pwm && state->duty_cycle > state->period))
> 		return -EINVAL;

No. Your expression is logically equivalent to what we already have. I
meant:

	if (!pwm || !state || state->enabled && (!state->period ||
	    state->duty_cycle > state->period))
		return -EINVAL;

Learning to read diffs (maybe Outlook scrambled the view for you, too?)
is a nice capability you should master.

> > But anyhow, even without that the kernel should not panic. So I ask you
> > to research and provide some more info about > > the problem. (Which
> > hardware does it affect? Where does it panic? ...)
>=20
> Observing Kernel panic in exynos SoC when we issue system suspend. Follow=
ing
> is the snippet of error:
>=20
> # echo mem > /sys/power/state
> [   29.224784] 010: Kernel panic - not syncing: pwm pwmchip0:
> dpm_run_callback failure
> [   29.240134] 010: Call trace:
> [   29.242993] 010:  dump_backtrace+0x0/0x1b8
> [   29.247067] 010:  show_stack+0x24/0x30
> [   29.250793] 010:  dump_stack+0xb8/0x114
> [   29.254606] 010:  panic+0x180/0x398
> [   29.258073] 010:  dpm_run_callback+0x270/0x278
> [   29.262493] 010:  __device_suspend+0x15c/0x628
> [   29.266913] 010:  dpm_suspend+0x124/0x3b0
> [   29.270899] 010:  dpm_suspend_start+0xa0/0xa8
> [   29.275233] 010:  suspend_devices_and_enter+0x110/0x968
> [   29.280433] 010:  pm_suspend+0x308/0x3d8
> [   29.284333] 010:  state_store+0x8c/0x110
> [   29.288233] 010:  kobj_attr_store+0x14/0x28
> [   29.292393] 010:  sysfs_kf_write+0x5c/0x78
> [   29.296466] 010:  kernfs_fop_write+0x10c/0x220
> [   29.300886] 010:  __vfs_write+0x48/0x90
> [   29.304699] 010:  vfs_write+0xb8/0x1c0
> [   29.308426] 010:  ksys_write+0x74/0x100
> [   29.312240] 010:  __arm64_sys_write+0x24/0x30
> [   29.316573] 010:  el0_svc_handler+0x110/0x1b8
> [   29.320906] 010:  el0_svc+0x8/0x1bc
> [   29.324374] 010: SMP: stopping secondary CPUs
> [   29.328711] 010: Kernel Offset: disabled
> [   29.332607] 010: CPU features: 0x0002,00006008
> [   29.337026] 010: Memory Limit: none
> [   29.343949] 010: Rebooting in 1 seconds..
> [   30.344539] 010: Disabling non-boot CPUs ...

Just locking at that and starring at drivers/base/power/main.c for a
while doesn't make this clearer to me. Are you using a mainline kernel?
Which version?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h3ccmj6mewpavh5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLxTHcACgkQwfwUeK3K
7AnRqwf/T0HURo/59d7Says04pIjzt0PFI9frzTB4sYkj4zbhpAUei2YGxqVR4qt
F83CgOS25CQ9neDBa8QHf1I30ZgzTV3iWslBI8za3QCQ692DYFYsJzebbue9atvY
u3qBPG3nV53RUy1GX35GbQlwyp5b95RXSbj/E7guahQmy/QcYSaeC8tIGC2tXrdo
eVK/FYy8IFP0+zkwyQpmOZiT++ANsmnfnQRn9A3IUWa+nGDztGdfFAdnW7ximUDF
obRGY2SXHHdASGtmk3SHKkSJRgHFv5O2Zw4GNRinkMdC/6mp2ZgEIYf1Zl89qu8I
RB3MGLWNnPzXAt+9Cr1TqYZCrDegYA==
=VMIQ
-----END PGP SIGNATURE-----

--h3ccmj6mewpavh5f--
