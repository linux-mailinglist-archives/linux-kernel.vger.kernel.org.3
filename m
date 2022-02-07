Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E834AB6D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbiBGIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349547AbiBGIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:33:40 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F7C0401E4;
        Mon,  7 Feb 2022 00:33:34 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C7779240004;
        Mon,  7 Feb 2022 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644222812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84zL46lVab32mc8aiSykPGlMX0OG+D4m1dmzME3ih7o=;
        b=eEI/wnbRqbnC03wKfL84Qy5u+zXH7f2LnN3A1RZ0uApGs6fHduyBnRD6Q5DTxxFJ1ncLvD
        8O+Zwu2iZ7LPhYjF1PLkN3yowpi7Vc6VxbeQxUHiRf3YFwbsknGNHoyRbuH9bBi3jCHCEq
        YbIdp24M3k1n59ERtwAno2km1oW5oxR7MACsUSCznlpqvKY12rq3I8tbGrut5zL6fGqZLf
        pCkl5+hSZrXzOZ8HopVoTCy9/NdRc5Jvzn16mrcEUpB3/V9SE2z1BqCNeWcv4c/URgPQk+
        1aJCezHlh1NPt7iYMU+Yoa/twd4Yyvq/UMKAC304//NLJYjgp/qX2dIO+hYdKw==
Date:   Mon, 7 Feb 2022 09:33:30 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, wens@csie.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: cedrus: Add watchdog for job completion
Message-ID: <YgDZWvgA0blNM7qm@aptenodytes>
References: <20220201183324.493542-1-jernej.skrabec@gmail.com>
 <YfztZE8ymJ5RERTq@aptenodytes>
 <12946098.uLZWGnKmhe@jernej-laptop>
 <3150370.aeNJFYEL58@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RYiUA+TN+21sHBz2"
Content-Disposition: inline
In-Reply-To: <3150370.aeNJFYEL58@jernej-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RYiUA+TN+21sHBz2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat 05 Feb 22, 09:41, Jernej =C5=A0krabec wrote:
> Dne sobota, 05. februar 2022 ob 08:40:21 CET je Jernej =C5=A0krabec napis=
al(a):
> > Dne petek, 04. februar 2022 ob 10:09:56 CET je Paul Kocialkowski napisa=
l(a):
> > > Hi Jernej,
> > >=20
> > > On Tue 01 Feb 22, 19:33, Jernej Skrabec wrote:
> > > > Currently, if job is not completed for whatever reason, userspace
> > > > application can hang on ioctl and thus become unkillable.
> > > >=20
> > > > In order to prevent that, implement watchdog, which will complete j=
ob
> > > > after 2 seconds with error state.
> > > >=20
> > > > Concept is borrowed from hantro driver.
> > >=20
> > > Good idea to implement a watchdog here, thanks!
> > > See comments below.
> > >=20
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > ---
> > > >=20
> > > >  drivers/staging/media/sunxi/cedrus/cedrus.c   |  2 ++
> > > >  drivers/staging/media/sunxi/cedrus/cedrus.h   |  3 +++
> > > >  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  4 +++
> > > >  .../staging/media/sunxi/cedrus/cedrus_hw.c    | 25 +++++++++++++++=
++++
> > > >  .../staging/media/sunxi/cedrus/cedrus_hw.h    |  2 ++
> > > >  5 files changed, 36 insertions(+)
> > > >=20
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus.c index
> > > > 4a4b714b0f26..68b3dcdb5df3 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> > > > @@ -439,6 +439,8 @@ static int cedrus_probe(struct platform_device
> > > > *pdev)
> > > >=20
> > > >  	mutex_init(&dev->dev_mutex);
> > > >=20
> > > > +	INIT_DELAYED_WORK(&dev->watchdog_work, cedrus_watchdog);
> > > > +
> > > >=20
> > > >  	ret =3D v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> > > >  	if (ret) {
> > > >  =09
> > > >  		dev_err(&pdev->dev, "Failed to register V4L2
> >=20
> > device\n");
> >=20
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus.h index
> > > > c345f2984041..3bc094eb497f 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > > @@ -24,6 +24,7 @@
> > > >=20
> > > >  #include <linux/iopoll.h>
> > > >  #include <linux/platform_device.h>
> > > >=20
> > > > +#include <linux/workqueue.h>
> > > >=20
> > > >  #define CEDRUS_NAME			"cedrus"
> > > >=20
> > > > @@ -194,6 +195,8 @@ struct cedrus_dev {
> > > >=20
> > > >  	struct reset_control	*rstc;
> > > >  =09
> > > >  	unsigned int		capabilities;
> > > >=20
> > > > +
> > > > +	struct delayed_work	watchdog_work;
> > > >=20
> > > >  };
> > > > =20
> > > >  extern struct cedrus_dec_ops cedrus_dec_ops_mpeg2;
> > > >=20
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c index
> > > > a16c1422558f..9c7200299465 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > > > @@ -97,4 +97,8 @@ void cedrus_device_run(void *priv)
> > > >=20
> > > >  		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
> > > >  =09
> > > >  	dev->dec_ops[ctx->current_codec]->trigger(ctx);
> > > >=20
> > > > +
> > > > +	/* Start the watchdog timer. */
> > > > +	schedule_delayed_work(&dev->watchdog_work,
> > > > +			      msecs_to_jiffies(2000));
> > > >=20
> > > >  }
> > > >=20
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c index
> > > > 2d7663726467..a6470a89851e 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > > > @@ -118,6 +118,13 @@ static irqreturn_t cedrus_irq(int irq, void *d=
ata)
> > > >=20
> > > >  	enum vb2_buffer_state state;
> > > >  	enum cedrus_irq_status status;
> > > >=20
> > > > +	/*
> > > > +	 * If cancel_delayed_work returns false it means watchdog already
> > > > +	 * executed and finished the job.
> > > > +	 */
> > > > +	if (!cancel_delayed_work(&dev->watchdog_work))
> > > > +		return IRQ_HANDLED;
> > > > +
> > > >=20
> > > >  	ctx =3D v4l2_m2m_get_curr_priv(dev->m2m_dev);
> > > >  	if (!ctx) {
> > > >  =09
> > > >  		v4l2_err(&dev->v4l2_dev,
> > > >=20
> > > > @@ -143,6 +150,24 @@ static irqreturn_t cedrus_irq(int irq, void *d=
ata)
> > > >=20
> > > >  	return IRQ_HANDLED;
> > > > =20
> > > >  }
> > > >=20
> > > > +void cedrus_watchdog(struct work_struct *work)
> > > > +{
> > > > +	struct cedrus_dev *dev;
> > > > +	struct cedrus_ctx *ctx;
> > > > +
> > > > +	dev =3D container_of(to_delayed_work(work),
> > > > +			   struct cedrus_dev, watchdog_work);
> > > > +
> > > > +	ctx =3D v4l2_m2m_get_curr_priv(dev->m2m_dev);
> > > > +	if (!ctx)
> > > > +		return;
> > > > +
> > > > +	v4l2_err(&dev->v4l2_dev, "frame processing timed out!\n");
> > > > +	reset_control_reset(dev->rstc);
> > >=20
> > > I don't think playing with the reset is the right approach here.
> > > First we don't really know if the reset is shared or not, so this mig=
ht
> > > have no effect.
> >=20
> > AFAIK only few reset lines are shared in all Allwinner SoC, never for C=
edrus
> > and even then, this is considered as HW issue. So, I'm good with using
> > reset line. This principle is also taken from Hantro driver.
> >=20
> > > Then even if it does, wouldn't this just reset the state of the
> > > registers to an unconfigured state, making it impossible to decode any
> > > future frame in the same context?
> >=20
> > Being stateless core, all context is held in auxiliary buffers, referen=
ce
> > frames and controls, which are not reset with pulsing reset line, so no,
> > state is not lost. Anyway, if decoding fails, you're generally screwed
> > until next key frame. You'll have to deal with decoding issues/artefacts
> > nevertheless.

Ah right, it's true that we fully configure the hardware on each slice
so indeed, it should be able to bring it back up on the next one.

> > > Honestly I'm not sure what a good process would be to get back on tra=
ck
> > > here so I would be tempted to just do nothing an return errors.
> > >=20
> > > That's already better than being stuck.
> >=20
> > Doing nothing will solve only current job, but HW will still be stuck in
> > decoding state. I doubt reprogramming registers and triggering new deco=
ding
> > will actually do anything.
> >=20
> > I'll check BSP lib sources again. Maybe selecting non-existing decoding=
 mode
> > would reset the core. That is already suggested as good thing to do in
> > order to put core in low power mode.
>=20
> BSP kernel driver also pulses reset line:
> https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-4.9-sun=
50iw9/drivers/media/cedar-ve/cedar_ve.c#L848-L851
>=20
> I still think this is the way to go.

Okay so that's probably the right thing to do then, my comment doesn't stan=
d!

So the change looks good to me at this point:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Thanks!

Paul

> Best regards,
> Jernej
>=20
> >=20
> > IMO we have to do something. Doing nothing will probably just lock up t=
he
> > core until next reboot or maybe until trying different decoding mode.
> >=20
> > Anyway, I have to find another way to cause decoding job to time out.
> > Currently I'm doing this with IOMMU on H6, but that brings down several
> > other things, which requires reboot anyway.
> >=20
> > Best regards,
> > Jernej
> >=20
> > > Paul
> > >=20
> > > > +	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx-
> > >
> > >fh.m2m_ctx,
> > >
> > > > +					 VB2_BUF_STATE_ERROR);
> > > > +}
> > > > +
> > > >=20
> > > >  int cedrus_hw_suspend(struct device *device)
> > > >  {
> > > > =20
> > > >  	struct cedrus_dev *dev =3D dev_get_drvdata(device);
> > > >=20
> > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > > > b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h index
> > > > 45f641f0bfa2..7c92f00e36da 100644
> > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > > > @@ -28,4 +28,6 @@ int cedrus_hw_resume(struct device *device);
> > > >=20
> > > >  int cedrus_hw_probe(struct cedrus_dev *dev);
> > > >  void cedrus_hw_remove(struct cedrus_dev *dev);
> > > >=20
> > > > +void cedrus_watchdog(struct work_struct *work);
> > > > +
> > > >=20
> > > >  #endif
>=20
>=20
>=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--RYiUA+TN+21sHBz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIA2VoACgkQ3cLmz3+f
v9F7sAf/ZRWcitUz+WNGX+uyDStZx3p+7XWEQ8zHMOGdouvfc4P6t++lfBgvehkA
kNmD3iCNmR097YkfmDOiDaa04Yqv7nRbzu2i9C3OGBq9WCg/Wvhug+BnkqY3gu+5
fn86awwghNTRAkkCO0wFfTlBxQ+2jnWUcmamG9xXML73tBnTEqu/9aHGIUuCNk69
5R0R9XkxPVH4AvKUyBvoicLvlw114qM+h/vn5AaPOW+7TLGpEmxMVvblcuDAA1z7
eO3tgdmO3VvvJodTPXOncSqSwWz3vZ7i2lujBMFdNmgvhZ8QT0E5wjG/cXxzDUGi
FySSwwRn0nDn4ZOy2wjQOJUyvkwWDQ==
=aWX/
-----END PGP SIGNATURE-----

--RYiUA+TN+21sHBz2--
