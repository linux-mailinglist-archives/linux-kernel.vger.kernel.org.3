Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C764C3F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbiBYHhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiBYHhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:37:37 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB4B458A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:37:03 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id E25395FDF7;
        Fri, 25 Feb 2022 08:37:01 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: atc260x has broken locking
Date:   Fri, 25 Feb 2022 08:36:55 +0100
Message-ID: <2559722.y8k8t1CynJ@mobilepool36.emlix.com>
In-Reply-To: <20220224231403.GA539966@ubuntu2004>
References: <16136311.TfV2VxeR0u@mobilepool36.emlix.com> <20220224231403.GA539966@ubuntu2004>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9572629.16VhR7YS1E"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9572629.16VhR7YS1E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: atc260x has broken locking
Date: Fri, 25 Feb 2022 08:36:55 +0100
Message-ID: <2559722.y8k8t1CynJ@mobilepool36.emlix.com>
In-Reply-To: <20220224231403.GA539966@ubuntu2004>
References: <16136311.TfV2VxeR0u@mobilepool36.emlix.com> <20220224231403.GA539966@ubuntu2004>

Am Freitag, 25. Februar 2022, 00:14:03 CET schrieb Cristian Ciocaltea:
> Hi Eike,
>=20
> On Wed, Feb 23, 2022 at 12:07:48PM +0100, Rolf Eike Beer wrote:
> > When looking at this functions I found the locking to be broken for the
> > atomic case (comments stripped):
> >=20
> > static void regmap_lock_mutex(void *__mutex)
> > {
> >=20
> > 	struct mutex *mutex =3D __mutex;
> > =09
> > 	if (system_state > SYSTEM_RUNNING && irqs_disabled())
> > =09
> > 		mutex_trylock(mutex);
> > =09
> > 	else
> > =09
> > 		mutex_lock(mutex);
> >=20
> > }
> >=20
> > static void regmap_unlock_mutex(void *__mutex)
> > {
> >=20
> > 	struct mutex *mutex =3D __mutex;
> > =09
> > 	mutex_unlock(mutex);
> >=20
> > }
> >=20
> > When the mutex is already locked and the atomic context is hit then the
> > lock will not be acquired, this is never noticed, and it afterwards is
> > unlocked anyway.
> >=20
> > The comment says this is inspired from i2c_in_atomic_xfer_mode() to det=
ect
> > the atomic case, but the important caller __i2c_lock_bus_helper()
> > actually does check and pass on the return value of mutex_trylock(),
> > which is missing here.
> This is indeed a limitation of the current implementation because the
> main goal was to offer initial support for SBC poweroff and reboot
> use cases, which were the only cases where the atomic context kicks in.
>=20
> Hence it was more important to make sure those operations are triggered
> rather than failing due to an error condition which is hard to be
> handled properly - e.g. getting a behaviour similar with the '-EGAIN'
> scenario in the I2C implementation.

Which makes sense as the unlock is in fact never reached then I guess becau=
se=20
the system reboots or shuts down before. Maybe this should end up as commen=
t=20
somewhere in the code.

> Out of pure curiosity, on which hardware do you plan to use this, if you
> haven't already?

On no hardware. I annotated mutex_trylock() as __must_check and this was th=
e=20
only place that broke the build afterwards.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart9572629.16VhR7YS1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYhiHFwAKCRCr5FH7Xu2t
/NqwA/9lGFTqTaidrRkpcluKuP1HK/9BJBwh3mVplH26JSJan9qhzx7400qfod6U
ZC6C8WDLqytZdeobOP4hJHGiy35kxno53K/+c1dKJ1oj46JyzhNyQzzeGPc3oyF6
ebk6ZycqVe27qLVrKmAz7E0XQ6ExIOGXYoYebEvH9jvvjO9/rg==
=u//R
-----END PGP SIGNATURE-----

--nextPart9572629.16VhR7YS1E--



