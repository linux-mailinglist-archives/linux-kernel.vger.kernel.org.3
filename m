Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976FC58F143
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiHJRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiHJRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:10:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A461105
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:10:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oLpE9-0002Xs-K0; Wed, 10 Aug 2022 19:10:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oLpE0-002wXh-Dx; Wed, 10 Aug 2022 19:10:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oLpE1-00Apoz-VT; Wed, 10 Aug 2022 19:10:33 +0200
Date:   Wed, 10 Aug 2022 19:10:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "m.shams" <m.shams@samsung.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com
Subject: Re: [PATCH] pwm: removes period check from pwm_apply_state()
Message-ID: <20220810171033.bfkzkdipw2v5yorh@pengutronix.de>
References: <CGME20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea@epcas5p2.samsung.com>
 <20220805101125.47955-1-m.shams@samsung.com>
 <20220805155509.edqwxcvyoqfic4pn@pengutronix.de>
 <019701d8ab31$94c86d60$be594820$@samsung.com>
 <20220808174842.jiato34jzqstchdn@pengutronix.de>
 <004301d8acad$e31fee70$a95fcb50$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xn5bz6e35anxywuy"
Content-Disposition: inline
In-Reply-To: <004301d8acad$e31fee70$a95fcb50$@samsung.com>
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


--xn5bz6e35anxywuy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 10, 2022 at 05:09:30PM +0530, m.shams wrote:
> > I fixed up the quoting for you in this mail. Please fix your mailer to =
not
> break
> > quotes, this is quite annoying. (Looking at the headers of your mail
> you're using
> > Outlook. Then your only viable option is to switch to a saner client.)
> >=20
>=20
> Sorry for the inconvenience. I have fixed my mailer.

No you didn't.

> > On Mon, Aug 08, 2022 at 07:47:03PM +0530, m.shams wrote:
> > > On Fri, Aug 05, 2022 at 03:41:25PM +0530, Tamseel Shams wrote:
> > > > > There may be situation when PWM is exported using sysfs, but at
> > > > > that point PWM period is not set. At this situation if we issue a
> > > > > system suspend, it calls pwm_class_suspend which in turn calls
> > > > > pwm_apply_state, where PWM period value is checked which returns
> > > > > an invalid argument error casuing Kernel to panic. So, check for
> > > > > PWM period value is removed so as to fix the kernel panic observed
> > > > > during suspend.
> > > >
> > > > This looks and sounds wrong. One thing I would accept is:
> > > >
> > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c index
> > > > 0e042410f6b9..075bbcdad6c1 100644
> > > > --- a/drivers/pwm/core.c
> > > > +++ b/drivers/pwm/core.c
> > > > @@ -557,8 +557,8 @@ int pwm_apply_state(struct pwm_device *pwm,
> > const struct pwm_state *state)
> > > > 	 */
> > > > 	might_sleep();
> > > >
> > > > -	if (!pwm || !state || !state->period ||
> > > > -	    state->duty_cycle > state->period)
> > > > +	if (!pwm || !state || state->enabled && (!state->period ||
> > > > +	    state->duty_cycle > state->period))
> > > >  		return -EINVAL;
> > > >
> > > > 	chip =3D pwm->chip;
> > > >
> > > > That is, don't refuse calling pwm_apply_state() for state->period =
=3D
> > > > 0 and even state->duty_cycle > state->period if the > > PWM is not
> enabled.
> > >
> > > By this do you mean doing it following way?
> > >
> > > if (!pwm || !state || (pwm && !state->period) ||
> > > 	    (pwm && state->duty_cycle > state->period))
> > > 		return -EINVAL;
> >=20
> > No. Your expression is logically equivalent to what we already have. I
> > meant:
> >=20
> > 	if (!pwm || !state || state->enabled && (!state->period ||
> > 	    state->duty_cycle > state->period))
> > 		return -EINVAL;
> >=20
> > Learning to read diffs (maybe Outlook scrambled the view for you, too?)=
 is
> a
> > nice capability you should master.
> >=20
> > > > But anyhow, even without that the kernel should not panic. So I ask
> > > > you to research and provide some more info about > > the problem.
> > > > (Which hardware does it affect? Where does it panic? ...)
> > >
> > > Observing Kernel panic in exynos SoC when we issue system suspend.
> > > Following is the snippet of error:
> > >
> > > # echo mem > /sys/power/state
> > > [   29.224784] 010: Kernel panic - not syncing: pwm pwmchip0:
> > > dpm_run_callback failure
> > > [   29.240134] 010: Call trace:
> > > [   29.242993] 010:  dump_backtrace+0x0/0x1b8
> > > [   29.247067] 010:  show_stack+0x24/0x30
> > > [   29.250793] 010:  dump_stack+0xb8/0x114
> > > [   29.254606] 010:  panic+0x180/0x398
> > > [   29.258073] 010:  dpm_run_callback+0x270/0x278
> > > [   29.262493] 010:  __device_suspend+0x15c/0x628
> > > [   29.266913] 010:  dpm_suspend+0x124/0x3b0
> > > [   29.270899] 010:  dpm_suspend_start+0xa0/0xa8
> > > [   29.275233] 010:  suspend_devices_and_enter+0x110/0x968
> > > [   29.280433] 010:  pm_suspend+0x308/0x3d8
> > > [   29.284333] 010:  state_store+0x8c/0x110
> > > [   29.288233] 010:  kobj_attr_store+0x14/0x28
> > > [   29.292393] 010:  sysfs_kf_write+0x5c/0x78
> > > [   29.296466] 010:  kernfs_fop_write+0x10c/0x220
> > > [   29.300886] 010:  __vfs_write+0x48/0x90
> > > [   29.304699] 010:  vfs_write+0xb8/0x1c0
> > > [   29.308426] 010:  ksys_write+0x74/0x100
> > > [   29.312240] 010:  __arm64_sys_write+0x24/0x30
> > > [   29.316573] 010:  el0_svc_handler+0x110/0x1b8
> > > [   29.320906] 010:  el0_svc+0x8/0x1bc
> > > [   29.324374] 010: SMP: stopping secondary CPUs
> > > [   29.328711] 010: Kernel Offset: disabled
> > > [   29.332607] 010: CPU features: 0x0002,00006008
> > > [   29.337026] 010: Memory Limit: none
> > > [   29.343949] 010: Rebooting in 1 seconds..
> > > [   30.344539] 010: Disabling non-boot CPUs ...
> >=20
> > Just locking at that and starring at drivers/base/power/main.c for a wh=
ile
> > doesn't make this clearer to me. Are you using a mainline kernel?
> > Which version?
> >=20
>=20
> Looks like I had some local patch which was causing the error to trigger
> Kernel Panic (sorry about that).
> On removing those local changes, I do not observe kernel panic, but obser=
ve
> following error and then suspend fails.
>=20
> [   63.963063] pwm pwmchip0: PM: dpm_run_callback ():
> pwm_class_suspend+0x0/0xf8 returns -22
> [   63.963079] pwm pwmchip0: PM: failed to suspend: error -22
>=20
> So, as to fix this issue I will post a new version of patch containing
> change suggested by you.

Note that my suggestion only covers you problem, it doesn't solve it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xn5bz6e35anxywuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLz5oYACgkQwfwUeK3K
7AnY0Af46xmtdTjGrjOkFSUni5VLOUegNhk1SyZ8TOS8GalH3qkkxHGa/p2MtRFp
/BDaUemgATG03nz/aKy3mzfaXzD27a3D2QShE/PpIBZM08/drce9i1t1WD7MxAjz
jC4VCjLxMr2t218ReXzSij0bRsLWn7Jl5kEVaQRE3H8cTxaIs1gU/hSsUyUaaUsa
N08IE0mb2288Qn+WzGZ8FDT+anyjzWogV4CFdRhfIONYSfoPQKkFRwB1M99SuggT
BqUWT+eyW6hV0qZOd+3zylUnDZWzQdDjk8BlSiPl5Xwr16iTlZVXDegLn8hfL+Ul
PsqN9GGvi8zYC4ho2lQPSEFuer2u
=md01
-----END PGP SIGNATURE-----

--xn5bz6e35anxywuy--
