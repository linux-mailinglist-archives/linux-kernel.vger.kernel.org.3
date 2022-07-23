Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613857F08F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiGWRNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:13:09 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24541D33C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:13:08 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id BB0842FFA4F;
        Sat, 23 Jul 2022 19:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658596385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKK7a1PN/YKYpUqDEeTRDDqS96t1AmDyA3VfF8HJIZw=;
        b=Fpzxw9guAucICfENjFlgA4WWFQkQIDR1gadyhVbO5/FmbKnp6U6QF6wDgv94ob1JFo9qOp
        +OVE/+r37OXJFWl0KCNogrtj5imlb6oJ/kqqII43fw61eo6XlDyCSLr8M1Jd+ChsmNHww2
        YT5wSwJL4vcs8jGYpZxSbxOUIX+DxAgIhpD50wLKBDUYk53XPDFf0dxs79VjDtC6qIB6Ie
        iJag+f8v4j9AaAoAzDLGuW45Ax/V5HalImqS3O8mLWL5Ne5fkZVDZZOs34nmpm3vIFq+Yy
        AdmiJzBXY6ZRZUhv6TwySNbwTkld7fRv3Drwq8ntS/YNtpGsksjLVbNGAY7VWA==
Message-ID: <684ad4afc66e6c6cdd1a3acc1ced3e78a4c00714.camel@svanheule.net>
Subject: Re: [PATCH v1] gpio: realtek-otto: switch to 32-bit I/O
From:   Sander Vanheule <sander@svanheule.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Sat, 23 Jul 2022 19:13:02 +0200
In-Reply-To: <CAHp75Vf2p_N=c0fg5aqkLgxE-E=NG5+Ui-sgB0_hPKJKOX84+Q@mail.gmail.com>
References: <20220723094957.73880-1-sander@svanheule.net>
         <CAHp75Vf2p_N=c0fg5aqkLgxE-E=NG5+Ui-sgB0_hPKJKOX84+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Looks like you sent your reply as HTML, so replying back in plaintext.

On Sat, 2022-07-23 at 18:07 +0200, Andy Shevchenko wrote:
>=20
>=20
> On Saturday, July 23, 2022, Sander Vanheule <sander@svanheule.net> wrote:
> > By using 16-bit I/O on the GPIO peripheral, which is apparently not saf=
e
> > on MIPS, the IMR can end up containing garbage. This then results in
> > interrupt triggers for lines that don't have an interrupt source
> > associated. The irq_desc lookup fails, and the ISR will not be cleared,
> > keeping the CPU busy until reboot, or until another IMR operation
> > restores the correct value. This situation appears to happen very
> > rarely, in < 0.5% of IMR writes.
> >=20
> > Instead of using 8-bit or 16-bit I/O operations on the 32-bit memory
> > mapped peripheral registers, switch to using 32-bit I/O only. This
> > allows to put all the GPIO lines in-order for 8-bit port values. For
> > 16-bit values, stick to manual (un)packing of per-port values.
> >=20
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> > =C2=A0drivers/gpio/gpio-realtek-otto.c | 122 ++++++++++++++++++--------=
-----
> > =C2=A01 file changed, 73 insertions(+), 49 deletions(-)

[..]

> > +static void realtek_gpio_port_write16be(void __iomem *reg, unsigned in=
t
> > port, u16 value)
> > +{
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int shift =3D (port % 2) * 16;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 reg_val;
> > +
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg +=3D 4 * (port / 2);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val =3D ioread32be(reg) & ~(GENMASK(15,=
 0) << shift);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val |=3D swab16(value) << shift;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0iowrite32be(reg_val, reg);
> > =C2=A0}

[..]

> > +static void realtek_gpio_port_write16(void __iomem *reg, unsigned int =
port,
> > u16 value)
> > +{
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int shift =3D (port % 2) * 16;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 reg_val;
> > +
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg +=3D 4 * (port / 2);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val =3D ioread32(reg) & ~(GENMASK(15, 0=
) << shift);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0reg_val |=3D value << shift;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0iowrite32(reg_val, reg);
> > =C2=A0}
> >=20
> > +
> > =C2=A0static void realtek_gpio_write_imr(struct realtek_gpio_ctrl *ctrl=
,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int port, u16 irq_type, u16 irq_ma=
sk)
> > =C2=A0{
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0iowrite16(irq_type & irq_mask,
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl->base + RE=
ALTEK_GPIO_REG_IMR + ctrl-
> > >port_offset_u16(port));
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl->port_write16(ctrl->base + REALTEK_GPI=
O_REG_IMR, port, irq_type
> > & irq_mask);
> > =C2=A0}

[..]

> > @@ -307,16 +328,17 @@ static int realtek_gpio_irq_set_affinity(struct
> > irq_data *data,
> > =C2=A0static int realtek_gpio_irq_init(struct gpio_chip *gc)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct realtek_gpio_ctrl *ctrl =3D gpiochip=
_get_data(gc);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 mask_all =3D GENMASK(gc->ngpio, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int port;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cpu;
> >=20
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0for (port =3D 0; (port * 8) < gc->ngpio; po=
rt++) {
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (port =3D 0; (port * 8) < gc->ngpio; po=
rt++)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 realtek_gpio_wr=
ite_imr(ctrl, port, 0, 0);
> >=20
>=20
>=20
> port++ ??? Is it correct code? Logically it seems you do 8 writes to the =
same
> port. Maybe this is the real issue?

port will go up to at most 3, since there is a limit on ngpio of 32. For th=
e
initialisation, this means the driver will do at most 4 RMW operations inst=
ead
of 2 writes, but this way I can use realtek_gpio_write_imr() consistently f=
or
all IMR changes.

The issue really is trying to use 16-bit (and 8-bit) writes on 32-bit MMIO
registers. iowrite16() works most of the time though, which is why I didn't=
 spot
this issue initially. I've tested this by writing and reading back the IMR
values many times. With 16-bit I/O, it fails for ~35 iterations out of 1000=
0.
With 32-bit I/O the IMR port-value comes back as what was written to it eve=
ry
single time. ioread16() seems to give correct results, but iowrite16() may =
cause
the other half of the register to turn into garbage.

I've changed the IRQ operations on the four 8-bit port values into a single=
 32-
bit operation, which is also what happens inside gpio-mmio for the gpio par=
t.
The IMR registers contain two bits per GPIO line, which why I've kept this
different implementation, manipulating the 8-pin ports instead of the entir=
e 32-
pin bank in one go.

We can discuss the way 32-bit I/O is implemented, but AFAICT the driver sim=
ply
cannot use iowrite16() reliably.

Best,
Sander
