Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999046881A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhLDWgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLDWgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:36:05 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9BC061751;
        Sat,  4 Dec 2021 14:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0uonSFb5ll3NkOsEORfpc5PMXzUpkEmBGaG8Mqblnr4=; b=hZ7ied3+9RriH16R7jrpuJ2VMf
        uuZrMWPs0S//H76YanW9kbV7vB9pAp6pohmJSL8yctD3HhQvmNQocAycqu+cST8d9/Adnr50AjIxh
        h8LNtkVlMLHjpWwB7E3VGOisplHUSUL06xXduGIkLeixP9X+3bXP0cXW90j8A0XOENLQ=;
Received: from p200300ccff382c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff38:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mtda8-0007at-An; Sat, 04 Dec 2021 23:32:36 +0100
Date:   Sat, 4 Dec 2021 23:32:33 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, linus.walleij@linaro.org,
        rydberg@bitmath.org,
        =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <20211204233233.6c55875c@aktux>
In-Reply-To: <20211202122021.43124-2-alistair@alistair23.me>
References: <20211202122021.43124-1-alistair@alistair23.me>
        <20211202122021.43124-2-alistair@alistair23.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu,  2 Dec 2021 22:20:18 +1000
Alistair Francis <alistair@alistair23.me> wrote:

> From: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
>=20
> This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> controllers. This driver supports only the I2C bus but it uses regmap
> so SPI support could be added later.
> The touchscreen can retrieve some defined zone that are handled as
> buttons (according to the hardware). That is why it handles
> button and multitouch events.
>=20
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
> Message-Id: <20180703094309.18514-2-mylene.josserand@bootlin.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

I finally got it working. The order of initialisation is important.
Params are copied on input_mt_init_slots() from ABS_MT* to ABS_*, so you
have to set params first.

Here is the patch i need on top of this one to make it actually work
with X (evdev and libinput is tested):

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscree=
n/cyttsp5.c
index b5d96eb71e46..3894ec85a732 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -415,19 +415,12 @@ static int cyttsp5_setup_input_device(struct device *=
dev)
 	int max_x_tmp, max_y_tmp;
 	int error;
=20
-	__set_bit(EV_REL, ts->input->evbit);
-
 	max_x_tmp =3D si->sensing_conf_data.res_x;
 	max_y_tmp =3D si->sensing_conf_data.res_y;
 	max_x =3D max_x_tmp - 1;
 	max_y =3D max_y_tmp - 1;
 	max_p =3D si->sensing_conf_data.max_z;
=20
-	error =3D input_mt_init_slots(ts->input, si->tch_abs[CY_TCH_T].max,
-		INPUT_MT_DROP_UNUSED | INPUT_MT_POINTER);
-	if (error < 0)
-		return error;
-
 	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, max_x, 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, max_y, 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, max_p, 0, 0);
@@ -435,6 +428,11 @@ static int cyttsp5_setup_input_device(struct device *d=
ev)
 	input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_TOUCH_MINOR, 0, MAX_AREA, 0, 0);
=20
+	error =3D input_mt_init_slots(ts->input, si->tch_abs[CY_TCH_T].max,
+		INPUT_MT_DROP_UNUSED | INPUT_MT_DIRECT);
+	if (error < 0)
+		return error;
+
 	error =3D input_register_device(ts->input);
 	if (error < 0)
 		dev_err(dev, "Error, failed register input device r=3D%d\n", error);
=20
