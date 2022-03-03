Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC54CB889
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiCCISM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiCCISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:18:08 -0500
X-Greylist: delayed 61704 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Mar 2022 00:17:22 PST
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DC21712A5;
        Thu,  3 Mar 2022 00:17:21 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1896F10000A;
        Thu,  3 Mar 2022 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646295440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPdBi3iOFzlIxLH7YgLMapDRpuJSUwPhFhA++7F0EBQ=;
        b=ZNhwxOBOSXvEIkqnQ6Tfqxn1i/0MXr2h7r0aDkBG5iiosv1l24mmsJ/AoffETofn4sECA8
        Jig9k6pJBnnVBQNPtvUHa5hXH093Pi4q+lN5SYPXDo2pN6uMCabUrzMGoLfaS97ZmXNQtK
        jWP9dN+HxftR31xWLnqkPo/2w4ZU+maTSEYGPganp9MT1Q9XP3MOiy6Pn+JzKtZr09stJ0
        najljp419/e0EM7Fmgz22zd4TH+wxVyw5A16SzIxx6DP8byfAFmaRbd7iMQjwBAvzpNg2c
        gD6oVjeHp74IJbQR+vRpJWqGoS0gZNBX3h58ITazizyqQXZvDS7fzmSyM9jn3Q==
Date:   Thu, 3 Mar 2022 09:15:55 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] rtc: optee: add RTC driver for OP-TEE RTC PTA
Message-ID: <20220303091555.7a0298b9@fixe.home>
In-Reply-To: <CAHUa44H4d2QdXSY5e5VqrGh5sQPhRuFBaBvsy_mTErQQmxJo6w@mail.gmail.com>
References: <20220302150717.11193-1-clement.leger@bootlin.com>
        <CAHUa44H4d2QdXSY5e5VqrGh5sQPhRuFBaBvsy_mTErQQmxJo6w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, 3 Mar 2022 08:35:17 +0100,
Jens Wiklander <jens.wiklander@linaro.org> a =C3=A9crit :

Hi Jens, looks like you forgot to "Reply All".

> > +
> > +       /* Fill invoke cmd params */
> > +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > +       param[0].u.memref.shm =3D priv->entropy_shm_pool;
> > +       param[0].u.memref.size =3D sizeof(struct optee_rtc_time);
> > +       param[0].u.memref.shm_offs =3D 0;
> > +
> > +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> > +       if ((ret < 0) || (inv_arg.ret !=3D 0)) { =20
>=20
> if (ret < 0 || inv_arg.ret) looks easier to me. Please check the patch
> with checkpatch --strict do catch all these and other trivial checks.

Acked, the rng-optee driver might not be a good starting point :/ Will
check that.

> > +static int optee_rtc_read_info(struct device *dev, struct rtc_device *=
rtc,
> > +                              u64 *features)
> > +{
> > +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> > +       struct tee_ioctl_invoke_arg inv_arg =3D {0};
> > +       struct tee_param param[4] =3D {0};
> > +       struct optee_rtc_info *info;
> > +       struct optee_rtc_time *tm;
> > +       int ret =3D 0;
> > +
> > +       inv_arg.func =3D TA_CMD_RTC_GET_INFO;
> > +       inv_arg.session =3D priv->session_id;
> > +       inv_arg.num_params =3D 4;
> > +
> > +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > +       param[0].u.memref.shm =3D priv->entropy_shm_pool;
> > +       param[0].u.memref.size =3D sizeof(*info);
> > +       param[0].u.memref.shm_offs =3D 0;
> > +
> > +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> > +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > +               dev_err(dev, "TA_CMD_RTC_GET_RNG_INFO invoke err: %x\n",
> > +                       inv_arg.ret);
> > +               return -EINVAL;
> > +       }
> > +
> > +       info =3D tee_shm_get_va(priv->entropy_shm_pool, 0);
> > +       if (IS_ERR(info)) {
> > +               dev_err(dev, "tee_shm_get_va failed\n");
> > +               return PTR_ERR(info);
> > +       }
> > +
> > +       if (param[0].u.memref.size < sizeof(*info)) {
> > +               dev_err(dev, "Invalid read size from OPTEE\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (info->version !=3D RTC_INFO_VERSION) {
> > +               dev_err(dev, "Unsupported information version %llu\n",
> > +                             info->version);
> > +               return -EINVAL;
> > +       }
> > +
> > +       *features =3D info->features;
> > +
> > +       tm =3D &info->range_min;
> > +       rtc->range_min =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_mda=
y,
> > +                                 tm->tm_hour, tm->tm_min, tm->tm_sec);
> > +       tm =3D &info->range_max;
> > +       rtc->range_max =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_mda=
y,
> > +                                 tm->tm_hour, tm->tm_min, tm->tm_sec);=
 =20
>=20
> If this is the only thing we're going to do with the returned min and
> max, how come this wasn't done on the OP-TEE side already? Without
> these large structs we could have defined an ABI without the need for
> shared memory.

mktime64 converts the time range to the number of seconds elapsed since
1970. I thought it would be better not to assess anything about the way
the time is stored on OP-TEE side and thus return the full time struct.
If you think it's acceptable to suppose that, then, we can still switch
to using timestamps as the ABI with OP-TEE RTC PTA. The same could be
done to get/set time if needed in this case.

> > +
> > +static int optee_rtc_probe(struct device *dev)
> > +{
> > +       struct tee_client_device *rtc_device =3D to_tee_client_device(d=
ev);
> > +       struct tee_ioctl_open_session_arg sess_arg;
> > +       struct tee_shm *entropy_shm_pool =3D NULL;
> > +       int ret =3D 0, err =3D -ENODEV; =20
>=20
> There is generally no need to initialize these here.
>=20
> > +       struct optee_rtc *priv;
> > +       struct rtc_device *rtc;
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
LL,
> > +                                              NULL);
> > +       if (IS_ERR(priv->ctx))
> > +               return -ENODEV;
> > +
> > +       /* Open session with rtc Trusted App */
> > +       memcpy(sess_arg.uuid, rtc_device->id.uuid.b, TEE_IOCTL_UUID_LEN=
); =20
>=20
> Perhaps uuid_copy() would be better.

Ok, I will use export_uuid() then.

>=20
> > +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > +       sess_arg.num_params =3D 0;
> > +
> > +       ret =3D tee_client_open_session(priv->ctx, &sess_arg, NULL);
> > +       if ((ret < 0) || (sess_arg.ret !=3D 0)) {
> > +               dev_err(dev, "tee_client_open_session failed, err: %x\n=
",
> > +                       sess_arg.ret);
> > +               err =3D -EINVAL;
> > +               goto out_ctx;
> > +       }
> > +       priv->session_id =3D sess_arg.session;
> > +
> > +       entropy_shm_pool =3D tee_shm_alloc(priv->ctx,
> > +                                        sizeof(struct optee_rtc_info),
> > +                                        TEE_SHM_MAPPED | TEE_SHM_DMA_B=
UF); =20
>=20
> tee_shm_alloc() is about to be removed. Please rebase on
> https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=3Dtee-s=
hm-for-v5.18

Acked.

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
