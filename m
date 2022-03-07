Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E64CFCBE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbiCGL0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbiCGL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:26:33 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5B140B9;
        Mon,  7 Mar 2022 03:01:25 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1ED4724000C;
        Mon,  7 Mar 2022 11:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646650884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XWbbNsrv7GMCfFzHUP9mF4raG8jWPE48CJX7NCXbrE=;
        b=QwMwiTgnayAOQIqvLlmJ5VUuCZAxupgu7UH2Hbedv5hewEGJODRZmTdHpnxQcLg9fMYTJl
        MtTSIXrxd1FILOX9L+bzGdHre+USlg7xe8q1mzCgHIPbJ/rRb9jIBfK+ZDPejbMwAVDBog
        9BvAOu5LI1fHSBeY47a8VxGGqhghj8bACUyDQadPQMyh03gLDJ2rfvpHFoPn8zHQvMx4eO
        kGC+LUpoL1G+DhG52AuP8sqTE9BpHYZJwIeDoTf+DwmRt3qxaY+foj8tyjNdvBEKnPwYER
        rMUI0O433+EOcyT7bjtQ71yoqP/zcOf9O/DehI1GYgeKCAEz9/cWd0/khNAyKA==
Date:   Mon, 7 Mar 2022 12:00:00 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] rtc: optee: add RTC driver for OP-TEE RTC PTA
Message-ID: <20220307120000.49f88c8b@fixe.home>
In-Reply-To: <CAHUa44FJEsd1wc=E0p+4pHU1=31z7JTgNDyz9Vxx77N11B8RKg@mail.gmail.com>
References: <20220307094042.48446-1-clement.leger@bootlin.com>
        <CAHUa44FJEsd1wc=E0p+4pHU1=31z7JTgNDyz9Vxx77N11B8RKg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, 7 Mar 2022 11:40:38 +0100,
Jens Wiklander <jens.wiklander@linaro.org> a =C3=A9crit :

> On Mon, Mar 7, 2022 at 10:42 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@bo=
otlin.com> wrote:
> >
> > This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
> > This PTA allows to query RTC information, set/get time and set/get
> > offset depending on the supported features.
> >
> > [1] https://github.com/OP-TEE/optee_os/pull/5179
> >
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> >
> > Changes in v2: =20
>=20
> Hmm, this seems to be a second v2.

Hmpf, I answered to Etienne questions on V1 and forgot I already sent a
V2.

>=20
> >  - Rebased over tee-shm-for-v5.18
> >  - Switch to tee_shm_alloc_kernel_buf()
> >  - Use export_uuid() to copy uuid
> >  - Fix warnings reported by checkpatch
> >  - Free SHM in error exit path
> >  - Fix error messages to include ret value and fix wrong IOCTL names
> >  - Use 100 columns char limit =20
>=20
> From bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning"=
):
>     Yes, staying withing 80 columns is certainly still _preferred_.  But
>     it's not the hard limit that the checkpatch warnings imply, and other
>     concerns can most certainly dominate.
>=20
>     Increase the default limit to 100 characters.  Not because 100
>     characters is some hard limit either, but that's certainly a "what are
>     you doing" kind of value and less likely to be about the occasional
>     slightly longer lines.

Ok.

> > +
> > +       if (param[0].u.memref.size !=3D sizeof(*optee_tm)) {
> > +               dev_err(dev, "Invalid read size from OPTEE\n");
> > +               return -EPROTO;
> > +       } =20
>=20
> The dev_err() prints above are basically covering "can't happen"
> cases. Robust code should certainly do the checks, but I'm not so sure
> about how useful the prints are.

Agreed, if it fails, this is likely to be due to protocol changes and
thus, the developer will probably know where to search for the error.

[...]

> > +static int optee_rtc_probe(struct device *dev)
> > +{
> > +       struct tee_client_device *rtc_device =3D to_tee_client_device(d=
ev);
> > +       struct tee_ioctl_open_session_arg sess_arg;
> > +       struct optee_rtc *priv;
> > +       struct rtc_device *rtc;
> > +       struct tee_shm *shm;
> > +       int ret, err;
> > +
> > +       memset(&sess_arg, 0, sizeof(sess_arg));
> > +
> > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       rtc =3D devm_rtc_allocate_device(dev);
> > +       if (IS_ERR(rtc))
> > +               return PTR_ERR(rtc);
> > +
> > +       /* Open context with TEE driver */
> > +       priv->ctx =3D tee_client_open_context(NULL, optee_ctx_match, NU=
LL, NULL);
> > +       if (IS_ERR(priv->ctx))
> > +               return -ENODEV;
> > +
> > +       /* Open session with rtc Trusted App */
> > +       export_uuid(sess_arg.uuid, &rtc_device->id.uuid);
> > +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > +
> > +       ret =3D tee_client_open_session(priv->ctx, &sess_arg, NULL);
> > +       if (ret < 0 || sess_arg.ret !=3D 0) {
> > +               dev_err(dev, "tee_client_open_session failed, err: %x\n=
", sess_arg.ret); =20
>=20
> This print is the most useful print in the driver. This is typically
> reached if the PTA doesn't exist.

If the PTA does not exists, is the driver even probed ? I thought it
was based on the UUID matching.

>=20
> > +               err =3D -EINVAL;
> > +               goto out_ctx;
> > +       }
> > +       priv->session_id =3D sess_arg.session;
> > +
> > +       shm =3D tee_shm_alloc_kernel_buf(priv->ctx, sizeof(struct optee=
_rtc_info));
> > +       if (IS_ERR(shm)) {
> > +               dev_err(priv->dev, "tee_shm_alloc_kernel_buf failed\n");
> > +               err =3D PTR_ERR(shm);
> > +               goto out_sess;
> > +       }
> > +
> > +       priv->shm =3D shm;
> > +       priv->dev =3D dev;
> > +       dev_set_drvdata(dev, priv);
> > +
> > +       rtc->ops =3D &optee_rtc_ops;
> > +
> > +       err =3D optee_rtc_read_info(dev, rtc, &priv->features);
> > +       if (err) {
> > +               dev_err(dev, "Failed to get RTC features from OP-TEE\n"=
); =20
>=20
> This print could also be worth keeping, but the rest are in my opinion
> of limited interest.
>=20
> It's a tradeoff with the prints, no big deal if you'd like to keep more.

I'm ok with that statement. The runtime errors are less likely (if not
totally unlikely) to happen. I'll sent a new version (V4 this time...)
with theses modifications.

Thanks,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
