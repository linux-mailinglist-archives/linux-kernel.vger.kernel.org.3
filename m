Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08D4469A38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbhLFPGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:06:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55310 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbhLFPF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:05:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B869F61316;
        Mon,  6 Dec 2021 15:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33784C341C5;
        Mon,  6 Dec 2021 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638802917;
        bh=keaKIEhln380CNsov3DQ8XzQWoqnycdYWDxhiyr9KDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k3EWoUYXlO6gnRcdC6o6SOvjr7V4wSWwbrgd3aioLcWvwZrfMU5t87Ogc+0S37i3T
         Z9yBFf7nyNRD5hDxHlsbMP6iltmT5f68sIhF4ISrePJ6B9EOHSIHZVFo87i8L15N2+
         Ga651i5XN8G2h7cRjtypRSPdqqZzMbQSFTpvegsEkO5XQQCyF8nEPM+uqvuvmBnVt6
         2vp8coPzsdES3GK0mHW9LS681kX7jobgk8hXiI2j0SC8XXDyvd3GF4bleDjf8369bB
         09KNdJaAiJ318A3xWqKSAKM5VT4v/7nWk2Yq4wJ/EwiprLSRxJTUaNeZaLgQLgaWhi
         +cnlnxXy3VuUg==
Date:   Mon, 6 Dec 2021 16:01:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     rkardell <rkardell@mida.se>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dvb: qt1010, change i2c read buffer from stack,
 to kernel space
Message-ID: <20211206160153.120aefab@coco.lan>
In-Reply-To: <ccc99e48-de4f-045e-0fe4-61e3118e3f74@mida.se>
References: <ccc99e48-de4f-045e-0fe4-61e3118e3f74@mida.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is broken on so many ways:

1. your e-mailer converted spaces and tabs into UTF spaces (0xa0);
2. it is not checking if allocation failed;
3. it doesn't fix the write function, which also uses stack;
4. you need your real name on your from and SoB.

Besides that, there's no issue on using the stack for I2C transfers.
The issue, is actually to use stack for USB transfers.=20

So, the right fix should be, instead, at the bridge driver, and not
on tuner. It seems that Mega Sky 580 USB DVB is supportd by m920x driver.
Right?

If so, the enclosed patch should fix the issue.

Please test.

Regards,
Mauro

Em Thu, 7 Oct 2021 14:29:00 +0200
rkardell <rkardell@mida.se> escreveu:

> Solve problem with initialization of Mega Sky 580 USB DVB (and other=20
> using mt352), error when reading i2c id.
>=20
>=20
> Signed-off-by: rkl099 <rkardell@mida.se>
> ---
>  =C2=A0drivers/media/tuners/qt1010.c | 6 +++++-
>  =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/tuners/qt1010.c b/drivers/media/tuners/qt1010.c
> index 3853a3d43..1bc0756f7 100644
> --- a/drivers/media/tuners/qt1010.c
> +++ b/drivers/media/tuners/qt1010.c
> @@ -11,18 +11,22 @@
>  =C2=A0/* read single register */
>  =C2=A0static int qt1010_readreg(struct qt1010_priv *priv, u8 reg, u8 *va=
l)
>  =C2=A0{
> +=C2=A0=C2=A0=C2=A0 u8 *b1=3Dkmalloc(1,GFP_KERNEL);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct i2c_msg msg[2] =3D {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 { .addr =3D priv->cfg->i2c_address,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D 0, .buf =3D &reg, .len =3D 1 },
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 { .addr =3D priv->cfg->i2c_address,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D I2C_M_RD, .buf =3D val, .len =3D 1 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D I2C_M_RD, .buf =3D b1, .len =3D 1 },
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i2c_transfer(priv->i2c, m=
sg, 2) !=3D 2) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_warn(&priv->i2c->dev, "%s: i2c rd failed reg=3D%02x\=
n",
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KBUILD_MODNAME, reg);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(b1);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EREMOTEIO;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val=3Db1[0];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(b1);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>  =C2=A0}
>=20

Thanks,
Mauro

[PATCH] media: m920x: don't use stack on USB reads

Using stack-allocated pointers for USB message data don't work.
This driver is almost OK with that, except for the I2C read
logic.

Fix it by using a temporary read buffer, just like on all other
calls to m920x_read().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-usb/=
m920x.c
index 4bb5b82599a7..691e05833db1 100644
--- a/drivers/media/usb/dvb-usb/m920x.c
+++ b/drivers/media/usb/dvb-usb/m920x.c
@@ -274,6 +274,13 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, st=
ruct i2c_msg msg[], int nu
 			/* Should check for ack here, if we knew how. */
 		}
 		if (msg[i].flags & I2C_M_RD) {
+			char *read =3D kmalloc(1, GFP_KERNEL);
+			if (!read) {
+				ret =3D -ENOMEM;
+				kfree(read);
+				goto unlock;
+			}
+
 			for (j =3D 0; j < msg[i].len; j++) {
 				/* Last byte of transaction?
 				 * Send STOP, otherwise send ACK. */
@@ -281,9 +288,12 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, st=
ruct i2c_msg msg[], int nu
=20
 				if ((ret =3D m920x_read(d->udev, M9206_I2C, 0x0,
 						      0x20 | stop,
-						      &msg[i].buf[j], 1)) !=3D 0)
+						      read, 1)) !=3D 0)
 					goto unlock;
+				msg[i].buf[j] =3D read[0];
 			}
+
+			kfree(read);
 		} else {
 			for (j =3D 0; j < msg[i].len; j++) {
 				/* Last byte of transaction? Then send STOP. */

