Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715E452044B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiEISSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbiEISSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:18:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B115A748;
        Mon,  9 May 2022 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1652120038; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q08TgslIn6eORzOBSw1hAVwzwQyEcKAc7I4FfWcW9U8=;
        b=XlgMzX49aN+IcfB28mMSy7oQaPsYX+vLvJo9a/o1HEoaIUjNEFKdsOKQIRnOuGpty5YLjx
        PukijtE/cS9ziOHmw3xP38S5GeHzhDF7IkvK5M1kANVQbopmExcjOVvZfRnJ5KTQo47jHQ
        YIqy9G63Aw/2vCMvJBs7qibxslg9VAA=
Date:   Mon, 09 May 2022 19:13:47 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Question about SC16IS752 device tree.
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     jringle@gridpoint.com, shc_work@mail.ru,
        Rob Herring <robh@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-serial@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <ZYNMBR.VDVV3VHFQBMO1@crapouillou.net>
In-Reply-To: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
References: <7c89db86-4055-90b5-6a67-611410f5759f@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le mar., mai 10 2022 at 02:08:28 +0800, Zhou Yanjie=20
<zhouyanjie@wanyeetech.com> a =E9crit :
> Hi folks,
>=20
> I encountered a problem when using the SC16IS752 to expand the serial=20
> port.
> I connected two Bluetooth modules to the two serial ports extended by=20
> the
> SC16IS752. The device tree is as follows:
>=20
> &ssi0 {
>     status =3D "okay";
>=20
>     num-cs =3D <2>;
>=20
>     pinctrl-names =3D "default";
>     pinctrl-0 =3D <&pins_ssi0>;
>=20
>     sc16is752: expander@0 {
>         compatible =3D "nxp,sc16is752";
>         reg =3D <0>; /* CE0 */
>=20
>         spi-rx-bus-width =3D <1>;
>         spi-tx-bus-width =3D <1>;
>         spi-max-frequency =3D <6000000>;
>=20
>         clocks =3D <&exclk_sc16is752>;
>=20
>         interrupt-parent =3D <&gpb>;
>         interrupts =3D <18 IRQ_TYPE_EDGE_FALLING>;
>=20
>         gpio-controller;
>         #gpio-cells =3D <2>;
>=20
>         bluetooth@0 {
>             compatible =3D "brcm,bcm43438-bt";
>             max-speed =3D <1000000>;
>=20
>             device-wakeup-gpios =3D <&gpc 26 GPIO_ACTIVE_HIGH>;
>             reset-gpios =3D <&gpb 17 GPIO_ACTIVE_LOW>;
>         };
>=20
>         bluetooth@1 {
>             compatible =3D "brcm,bcm43438-bt";
>=20
>             device-wakeup-gpios =3D <&gpc 28 GPIO_ACTIVE_HIGH>;
>             reset-gpios =3D <&gpb 19 GPIO_ACTIVE_LOW>;
>         };
>     };
> };
>=20
>=20
>=20
> There are the following error messages after startup:
>=20
> [    0.548417] serial serial0-0: controller busy
> [    0.553572] serial serial0-0: failure adding device. status -EBUSY
> [    0.559764] serial serial0: tty port ttySC0 registered
> [    0.565545] spi0.0: ttySC1 at I/O 0x1 (irq =3D 18, base_baud =3D=20
> 3000000) is a SC16IS752
> [    0.573987] serial serial1-0: controller busy
> [    0.578351] serial serial1-0: failure adding device. status -EBUSY
> [    0.585003] serial serial1: tty port ttySC1 registered
>=20
> And only the module connected to the first serial port (ttySC0) can=20
> work normally.

I can't say for sure that it's your problem, but your bluetooth nodes=20
are missing "reg" properties.

Cheers,
-Paul

>=20
>=20
>=20
> If I change the device tree to:
>=20
> &ssi0 {
>     status =3D "okay";
>=20
>     num-cs =3D <2>;
>=20
>     pinctrl-names =3D "default";
>     pinctrl-0 =3D <&pins_ssi0>;
>=20
>     sc16is752: expander@0 {
>         compatible =3D "nxp,sc16is752";
>         reg =3D <0>; /* CE0 */
>=20
>         spi-rx-bus-width =3D <1>;
>         spi-tx-bus-width =3D <1>;
>         spi-max-frequency =3D <6000000>;
>=20
>         clocks =3D <&exclk_sc16is752>;
>=20
>         interrupt-parent =3D <&gpb>;
>         interrupts =3D <18 IRQ_TYPE_EDGE_FALLING>;
>=20
>         gpio-controller;
>         #gpio-cells =3D <2>;
>=20
>         bluetooth@0 {
>             compatible =3D "brcm,bcm43438-bt";
>             max-speed =3D <1000000>;
>=20
>             device-wakeup-gpios =3D <&gpc 26 GPIO_ACTIVE_HIGH>;
>             reset-gpios =3D <&gpb 17 GPIO_ACTIVE_LOW>;
>         };
>     };
> };
>=20
> Then there will be no error message, and the module connected to the=20
> first
> serial port (ttySC0) can also work normally.
>=20
>=20
>=20
> After tracing, the problem seems to be in "serdev_device_add()" (line=20
> 111) of
> "drivers/tty/serdev/core.c":
>=20
> int serdev_device_add(struct serdev_device *serdev)
> {
>     struct serdev_controller *ctrl =3D serdev->ctrl;
>     struct device *parent =3D serdev->dev.parent;
>     int err;
>=20
>     dev_set_name(&serdev->dev, "%s-%d", dev_name(parent), serdev->nr);
>=20
>     /* Only a single slave device is currently supported. */
>     if (ctrl->serdev) {
>         dev_err(&serdev->dev, "controller busy\n");
>         return -EBUSY;
>     }
>     ctrl->serdev =3D serdev;
>=20
>     err =3D device_add(&serdev->dev);
>     if (err < 0) {
>         dev_err(&serdev->dev, "Can't add %s, status %pe\n",
>             dev_name(&serdev->dev), ERR_PTR(err));
>         goto err_clear_serdev;
>     }
>=20
>     dev_dbg(&serdev->dev, "device %s registered\n",=20
> dev_name(&serdev->dev));
>=20
>     return 0;
>=20
> err_clear_serdev:
>     ctrl->serdev =3D NULL;
>     return err;
> }
> EXPORT_SYMBOL_GPL(serdev_device_add);
>=20
>=20
>=20
> Is there any way to correctly describe the device mounted on the=20
> second
> serial port (ttySC1) in the device tree? Or how do I need to modify=20
> the
> "drivers/tty/serdev/core.c" to make the SC16IS752 still work properly
> with two child nodes mounted?
>=20
> Thanks and beset regards!


