Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EEF4AA7B9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359232AbiBEIld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiBEIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:41:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E56C061346;
        Sat,  5 Feb 2022 00:41:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id h7so26480592ejf.1;
        Sat, 05 Feb 2022 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dfr7M0AeK8Njo4LUOwu13Tv8hTi2VCyRlACqCCCkWa8=;
        b=WZxoCWvSJMJiFY0Hzb6tQoThu56rBOj6DVk6x8j+GjqdKcTye/f77DG5CqhkJ1VwuF
         sEs0L6s5kcx9pbmWeQDb6Gi1QLVCKR/CnvK4G0krmfuFakoUoZJmSaHl7umSL8ZcmKPs
         iIKs70cMPTSFQNrW6C1nglzSsC86d2TTpPHvatKeukwm591RX0Me2Q7ZJh7sgDZBHtB9
         wVCgArJuwEpBrwp8SGNAnQDSI8juRx6YOs18PvfgIMv/cYBu9aICQACiL2/lP9af5Oj3
         vI7jIDqEAs9Dm4+5vI1hjhDtidb6TSXFPQ0XiraLHWdzMDdjSzVJ3d2h8qFoAagR+gUJ
         11yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dfr7M0AeK8Njo4LUOwu13Tv8hTi2VCyRlACqCCCkWa8=;
        b=Nl7+mSpDDP8xm9CUdkZLitKVqjTseg7stnlYelae8344PVZ+kOZngaubm90F41YMSe
         JXQiWgEomroIhalEmmSOdjbUj5o7WTrTnd0bqy2PBUU3I4/HH2g8/mGwiwO45e22vZov
         n5XaIOA1TuAcX+cwL2HGULhl1gleSkVRL+Gq0gkjEgZWcZ7wSmgccCQ/zf3j9/HKRqBj
         MOGE1vO4rSjJUPGEEiX69dxY8Pg7eQgnunLxe9srzCFQ4tkFGlmdLAitS8qk/v3zRGcL
         ewq4b0Le7GPM1VlEZ4w77Q7yas8iDhLVLWkFAQDEGMH9IcEdm2asKloChfgYp0gaquR5
         GjHg==
X-Gm-Message-State: AOAM531QpawozoTitUcs6qAyfv4MmPKZD1qfj1opGb4D8Rb+2D3XFe7l
        AOOousrz66ue2jWLUYNhTPw=
X-Google-Smtp-Source: ABdhPJyTEak6VYi8HwnTV7gPdcOaIBVy/Lydaf3MLByd2DaQFPzZTOKd/taFWJ+Bko+z//SHqD3HNg==
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr2275687ejc.430.1644050486880;
        Sat, 05 Feb 2022 00:41:26 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id u1sm1414899ejj.215.2022.02.05.00.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 00:41:26 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, wens@csie.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: cedrus: Add watchdog for job completion
Date:   Sat, 05 Feb 2022 09:41:25 +0100
Message-ID: <3150370.aeNJFYEL58@jernej-laptop>
In-Reply-To: <12946098.uLZWGnKmhe@jernej-laptop>
References: <20220201183324.493542-1-jernej.skrabec@gmail.com> <YfztZE8ymJ5RERTq@aptenodytes> <12946098.uLZWGnKmhe@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 05. februar 2022 ob 08:40:21 CET je Jernej =C5=A0krabec napisal=
(a):
> Dne petek, 04. februar 2022 ob 10:09:56 CET je Paul Kocialkowski napisal(=
a):
> > Hi Jernej,
> >=20
> > On Tue 01 Feb 22, 19:33, Jernej Skrabec wrote:
> > > Currently, if job is not completed for whatever reason, userspace
> > > application can hang on ioctl and thus become unkillable.
> > >=20
> > > In order to prevent that, implement watchdog, which will complete job
> > > after 2 seconds with error state.
> > >=20
> > > Concept is borrowed from hantro driver.
> >=20
> > Good idea to implement a watchdog here, thanks!
> > See comments below.
> >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >=20
> > >  drivers/staging/media/sunxi/cedrus/cedrus.c   |  2 ++
> > >  drivers/staging/media/sunxi/cedrus/cedrus.h   |  3 +++
> > >  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  4 +++
> > >  .../staging/media/sunxi/cedrus/cedrus_hw.c    | 25 +++++++++++++++++=
++
> > >  .../staging/media/sunxi/cedrus/cedrus_hw.h    |  2 ++
> > >  5 files changed, 36 insertions(+)
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c
> > > b/drivers/staging/media/sunxi/cedrus/cedrus.c index
> > > 4a4b714b0f26..68b3dcdb5df3 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> > > @@ -439,6 +439,8 @@ static int cedrus_probe(struct platform_device
> > > *pdev)
> > >=20
> > >  	mutex_init(&dev->dev_mutex);
> > >=20
> > > +	INIT_DELAYED_WORK(&dev->watchdog_work, cedrus_watchdog);
> > > +
> > >=20
> > >  	ret =3D v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> > >  	if (ret) {
> > >  =09
> > >  		dev_err(&pdev->dev, "Failed to register V4L2
>=20
> device\n");
>=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > b/drivers/staging/media/sunxi/cedrus/cedrus.h index
> > > c345f2984041..3bc094eb497f 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> > > @@ -24,6 +24,7 @@
> > >=20
> > >  #include <linux/iopoll.h>
> > >  #include <linux/platform_device.h>
> > >=20
> > > +#include <linux/workqueue.h>
> > >=20
> > >  #define CEDRUS_NAME			"cedrus"
> > >=20
> > > @@ -194,6 +195,8 @@ struct cedrus_dev {
> > >=20
> > >  	struct reset_control	*rstc;
> > >  =09
> > >  	unsigned int		capabilities;
> > >=20
> > > +
> > > +	struct delayed_work	watchdog_work;
> > >=20
> > >  };
> > > =20
> > >  extern struct cedrus_dec_ops cedrus_dec_ops_mpeg2;
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > > b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c index
> > > a16c1422558f..9c7200299465 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > > @@ -97,4 +97,8 @@ void cedrus_device_run(void *priv)
> > >=20
> > >  		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
> > >  =09
> > >  	dev->dec_ops[ctx->current_codec]->trigger(ctx);
> > >=20
> > > +
> > > +	/* Start the watchdog timer. */
> > > +	schedule_delayed_work(&dev->watchdog_work,
> > > +			      msecs_to_jiffies(2000));
> > >=20
> > >  }
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > > b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c index
> > > 2d7663726467..a6470a89851e 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > > @@ -118,6 +118,13 @@ static irqreturn_t cedrus_irq(int irq, void *dat=
a)
> > >=20
> > >  	enum vb2_buffer_state state;
> > >  	enum cedrus_irq_status status;
> > >=20
> > > +	/*
> > > +	 * If cancel_delayed_work returns false it means watchdog already
> > > +	 * executed and finished the job.
> > > +	 */
> > > +	if (!cancel_delayed_work(&dev->watchdog_work))
> > > +		return IRQ_HANDLED;
> > > +
> > >=20
> > >  	ctx =3D v4l2_m2m_get_curr_priv(dev->m2m_dev);
> > >  	if (!ctx) {
> > >  =09
> > >  		v4l2_err(&dev->v4l2_dev,
> > >=20
> > > @@ -143,6 +150,24 @@ static irqreturn_t cedrus_irq(int irq, void *dat=
a)
> > >=20
> > >  	return IRQ_HANDLED;
> > > =20
> > >  }
> > >=20
> > > +void cedrus_watchdog(struct work_struct *work)
> > > +{
> > > +	struct cedrus_dev *dev;
> > > +	struct cedrus_ctx *ctx;
> > > +
> > > +	dev =3D container_of(to_delayed_work(work),
> > > +			   struct cedrus_dev, watchdog_work);
> > > +
> > > +	ctx =3D v4l2_m2m_get_curr_priv(dev->m2m_dev);
> > > +	if (!ctx)
> > > +		return;
> > > +
> > > +	v4l2_err(&dev->v4l2_dev, "frame processing timed out!\n");
> > > +	reset_control_reset(dev->rstc);
> >=20
> > I don't think playing with the reset is the right approach here.
> > First we don't really know if the reset is shared or not, so this might
> > have no effect.
>=20
> AFAIK only few reset lines are shared in all Allwinner SoC, never for Ced=
rus
> and even then, this is considered as HW issue. So, I'm good with using
> reset line. This principle is also taken from Hantro driver.
>=20
> > Then even if it does, wouldn't this just reset the state of the
> > registers to an unconfigured state, making it impossible to decode any
> > future frame in the same context?
>=20
> Being stateless core, all context is held in auxiliary buffers, reference
> frames and controls, which are not reset with pulsing reset line, so no,
> state is not lost. Anyway, if decoding fails, you're generally screwed
> until next key frame. You'll have to deal with decoding issues/artefacts
> nevertheless.
> > Honestly I'm not sure what a good process would be to get back on track
> > here so I would be tempted to just do nothing an return errors.
> >=20
> > That's already better than being stuck.
>=20
> Doing nothing will solve only current job, but HW will still be stuck in
> decoding state. I doubt reprogramming registers and triggering new decodi=
ng
> will actually do anything.
>=20
> I'll check BSP lib sources again. Maybe selecting non-existing decoding m=
ode
> would reset the core. That is already suggested as good thing to do in
> order to put core in low power mode.

BSP kernel driver also pulses reset line:
https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-4.9-sun50=
iw9/drivers/media/cedar-ve/cedar_ve.c#L848-L851

I still think this is the way to go.

Best regards,
Jernej

>=20
> IMO we have to do something. Doing nothing will probably just lock up the
> core until next reboot or maybe until trying different decoding mode.
>=20
> Anyway, I have to find another way to cause decoding job to time out.
> Currently I'm doing this with IOMMU on H6, but that brings down several
> other things, which requires reboot anyway.
>=20
> Best regards,
> Jernej
>=20
> > Paul
> >=20
> > > +	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx-
> >
> >fh.m2m_ctx,
> >
> > > +					 VB2_BUF_STATE_ERROR);
> > > +}
> > > +
> > >=20
> > >  int cedrus_hw_suspend(struct device *device)
> > >  {
> > > =20
> > >  	struct cedrus_dev *dev =3D dev_get_drvdata(device);
> > >=20
> > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > > b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h index
> > > 45f641f0bfa2..7c92f00e36da 100644
> > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > > @@ -28,4 +28,6 @@ int cedrus_hw_resume(struct device *device);
> > >=20
> > >  int cedrus_hw_probe(struct cedrus_dev *dev);
> > >  void cedrus_hw_remove(struct cedrus_dev *dev);
> > >=20
> > > +void cedrus_watchdog(struct work_struct *work);
> > > +
> > >=20
> > >  #endif




