Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD84A95C1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbiBDJKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:10:00 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46181 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiBDJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:09:59 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1BEFF1BF208;
        Fri,  4 Feb 2022 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643965798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQNFORm6P/ChtVEc+oIxo/ZWXAzYeY/tidTMnqXEPN8=;
        b=mMHXCPDh7aQdEazpbAVuOdkBkkQWLu4OHzPPU+dd1t0a3XYdck/CdRoqVO7/Abj0hOPu2i
        UXuUuk+/gUBBJiO3ADBNws9KX6fMVTk+pypF4EhUf5L7KnFh/BaS0u/GMTtvOX+r52or4h
        p8aTtzaoKMe7SbHMvI9BerX6GgAsqAuxXO6P2DLLlhOaL6bnodx4RB2U+IhImtgAKFAdbI
        7dz5M+654GEU9pv5rO+9tt0SGGRcMvcnUaQfulHbEh4V4e0rzAHV0u2hbBYLEW7fUqhinM
        5V58GuMqd0xU1wmgh99Tel59m6OLH06ZYfsm5RshdciU9duOI3p/kdRmVit+7Q==
Date:   Fri, 4 Feb 2022 10:09:56 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, wens@csie.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: cedrus: Add watchdog for job completion
Message-ID: <YfztZE8ymJ5RERTq@aptenodytes>
References: <20220201183324.493542-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rNkL9ELB/7A37cXF"
Content-Disposition: inline
In-Reply-To: <20220201183324.493542-1-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rNkL9ELB/7A37cXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Tue 01 Feb 22, 19:33, Jernej Skrabec wrote:
> Currently, if job is not completed for whatever reason, userspace
> application can hang on ioctl and thus become unkillable.
>=20
> In order to prevent that, implement watchdog, which will complete job
> after 2 seconds with error state.
>=20
> Concept is borrowed from hantro driver.

Good idea to implement a watchdog here, thanks!
See comments below.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  2 ++
>  drivers/staging/media/sunxi/cedrus/cedrus.h   |  3 +++
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  4 +++
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    | 25 +++++++++++++++++++
>  .../staging/media/sunxi/cedrus/cedrus_hw.h    |  2 ++
>  5 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.c
> index 4a4b714b0f26..68b3dcdb5df3 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -439,6 +439,8 @@ static int cedrus_probe(struct platform_device *pdev)
> =20
>  	mutex_init(&dev->dev_mutex);
> =20
> +	INIT_DELAYED_WORK(&dev->watchdog_work, cedrus_watchdog);
> +
>  	ret =3D v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register V4L2 device\n");
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.h
> index c345f2984041..3bc094eb497f 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -24,6 +24,7 @@
> =20
>  #include <linux/iopoll.h>
>  #include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> =20
>  #define CEDRUS_NAME			"cedrus"
> =20
> @@ -194,6 +195,8 @@ struct cedrus_dev {
>  	struct reset_control	*rstc;
> =20
>  	unsigned int		capabilities;
> +
> +	struct delayed_work	watchdog_work;
>  };
> =20
>  extern struct cedrus_dec_ops cedrus_dec_ops_mpeg2;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/st=
aging/media/sunxi/cedrus/cedrus_dec.c
> index a16c1422558f..9c7200299465 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -97,4 +97,8 @@ void cedrus_device_run(void *priv)
>  		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
> =20
>  	dev->dec_ops[ctx->current_codec]->trigger(ctx);
> +
> +	/* Start the watchdog timer. */
> +	schedule_delayed_work(&dev->watchdog_work,
> +			      msecs_to_jiffies(2000));
>  }
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index 2d7663726467..a6470a89851e 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -118,6 +118,13 @@ static irqreturn_t cedrus_irq(int irq, void *data)
>  	enum vb2_buffer_state state;
>  	enum cedrus_irq_status status;
> =20
> +	/*
> +	 * If cancel_delayed_work returns false it means watchdog already
> +	 * executed and finished the job.
> +	 */
> +	if (!cancel_delayed_work(&dev->watchdog_work))
> +		return IRQ_HANDLED;
> +
>  	ctx =3D v4l2_m2m_get_curr_priv(dev->m2m_dev);
>  	if (!ctx) {
>  		v4l2_err(&dev->v4l2_dev,
> @@ -143,6 +150,24 @@ static irqreturn_t cedrus_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> +void cedrus_watchdog(struct work_struct *work)
> +{
> +	struct cedrus_dev *dev;
> +	struct cedrus_ctx *ctx;
> +
> +	dev =3D container_of(to_delayed_work(work),
> +			   struct cedrus_dev, watchdog_work);
> +
> +	ctx =3D v4l2_m2m_get_curr_priv(dev->m2m_dev);
> +	if (!ctx)
> +		return;
> +
> +	v4l2_err(&dev->v4l2_dev, "frame processing timed out!\n");
> +	reset_control_reset(dev->rstc);

I don't think playing with the reset is the right approach here.
First we don't really know if the reset is shared or not, so this might have
no effect. Then even if it does, wouldn't this just reset the state of the
registers to an unconfigured state, making it impossible to decode any
future frame in the same context?

Honestly I'm not sure what a good process would be to get back on track
here so I would be tempted to just do nothing an return errors.

That's already better than being stuck.

Paul

> +	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
> +					 VB2_BUF_STATE_ERROR);
> +}
> +
>  int cedrus_hw_suspend(struct device *device)
>  {
>  	struct cedrus_dev *dev =3D dev_get_drvdata(device);
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.h
> index 45f641f0bfa2..7c92f00e36da 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> @@ -28,4 +28,6 @@ int cedrus_hw_resume(struct device *device);
>  int cedrus_hw_probe(struct cedrus_dev *dev);
>  void cedrus_hw_remove(struct cedrus_dev *dev);
> =20
> +void cedrus_watchdog(struct work_struct *work);
> +
>  #endif
> --=20
> 2.35.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--rNkL9ELB/7A37cXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmH87WQACgkQ3cLmz3+f
v9FEygf9ELqISAJMpYQfIPsNzffDE6J4ucm8HGIGmNXZJoNWImPwRlT+ogKNw1KI
qtO+mYw4gk/poTEO0t4GSTmbED0aF+KRiG5aDsn/UIJyF8tEpqnCI58U1TOwWn0a
qWXhIshB2bh8z89WKMXU4gGpVx6+4AKU8OvGuJi62T1IaZ1SxonbPoJUhU9Abg2Q
2vFiUa5n8lXsJosuw8c5XK3VJ9PRZdus+ExpwJRcyR8xB4S4KSeOKP0IYn3e4Hso
59rrYeyb8j1UnDo+EgRg42UdM1/oengWRqMWbXr5DsAZZKycXLnrkolPhV3N7D1z
Z7Rs3WcTfrSRE4AINainkDBJc+sWVA==
=Qpj0
-----END PGP SIGNATURE-----

--rNkL9ELB/7A37cXF--
