Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE81759BBBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiHVIhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiHVIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:36:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834A2BB30;
        Mon, 22 Aug 2022 01:36:55 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:aff1:6187:b5e5:cd67] (unknown [IPv6:2a00:23c6:c311:3401:aff1:6187:b5e5:cd67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0565A6600357;
        Mon, 22 Aug 2022 09:36:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661157413;
        bh=q2cob7vZa8oaQ/85iPX5mKBKU2Xr2jvMDFEVAB1HqZU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jQ9hVK91IJ5aDT8BV1h6YPYJE9/EmNvjaFna2ks1o9gHqGKLttP/iePIkClgHpEos
         KUyQZzxWp8iIpD4jY03EH5letv1Ma/liCfwQ4+H5wcIUQKT4/aZrmWMIEuTHjlViV2
         FuTSZFMTSaA9TNNq5hwR4FdeFHGg2FDGcR5Y9/PwzszPT8AEnvM8waG6DONldwz6O/
         XNo4DIpdNr8cxcIgYt4Nf/c8W295pCQs+Sh6UBTff8sIgDdnkba5M1NKEQXqvLhcYa
         VbHzZEbKYrrtk4RQz6L5FZucEQNshGM+CC8AcBmgk3x4/sTPNvRBPC1UV8c+XJ1hFZ
         2TlyLHqxHl9uw==
Message-ID: <370beac7c85da4f1b57d8d78715d2a0676d19cf9.camel@collabora.com>
Subject: Re: [RFC PATCH] gpio: pca953x: Support for pcal6534
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Collabora Kernel ML <kernel@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 22 Aug 2022 09:36:52 +0100
In-Reply-To: <CAHp75Vc1bnUGt66LYRAVuJP+OnhLTaU=AN1JdvfiH44O9_eO8g@mail.gmail.com>
References: <20220817112818.787771-1-martyn.welch@collabora.com>
         <CAHp75Vc1bnUGt66LYRAVuJP+OnhLTaU=AN1JdvfiH44O9_eO8g@mail.gmail.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-08-20 at 01:35 +0300, Andy Shevchenko wrote:
> On Wed, Aug 17, 2022 at 2:29 PM Martyn Welch
> <martyn.welch@collabora.com> wrote:
> >=20
> > The pcal6534[1] is a 34-bit I/O expander with more than a passing
> > resemblance to the pcal6524[2] currently supported by the gpio-
> > pca953x
> > driver, however whilst the registers seem to functionally match
> > perfectly, the alignment of the register banks in the chips address
> > space do not follow the pattern expected by the existing driver.
> > For
>=20
> does not
>=20
> > instance, as the chip provides 34 I/O, which requires bannks of 5
> > 8-bit
> > registers to provide input state, output state, etc. as do the 40
> > I/O
> > variants, however the 40 I/O variants layout the banks of registers
> > on
> > 8-byte boundaries, whilst the pcal6534 does not space out the banks
> > at
> > all. Additionally the extended functionality starts at 30h rather
> > than
> > 40h and I suspect there will be other similar differences that I've
> > not
> > yet discovered.
>=20
> The below shouldn't be in the commit message, but rather in the
> comments (after the cutter '---' line below). And due to these two
> paragraphs I consider this as an RFC (and it is luckily marked like
> this), so, Bart, please do not apply this, we need more eyes and
> datasheet reading before going on this.
>=20

Yep, not even close to mergeable, sent to the list mainly for comment
on whether to try and cram this into this driver or create a separate
driver for it.

> > I suspect that this may add some additional complexity to the
> > driver and
> > I'm not sure whether this will be welcome. I've done a few cursory
> > searches to see if there are other chips which follow the pattern
> > of the
> > pcal6534 and have so far only found the pi4ioe5v6534q[3], which
> > appears
> > to be funcitonaly identical to the pcal6534.
> >=20
> > I'm currently wondering whether a submission to extend the pcal6534
> > is likely to be deemed acceptable. If so whether something like the
>=20
> so, whether
>=20
> > attached approach would be OK, or whether anyone has better ideas
> > on how
> > to achieve this. Alternatively I'd be happy to create a new driver
> > to
> > support the pcal6534 if that's deemed more appropriate.
>=20
> > [1] https://www.nxp.com/docs/en/data-sheet/PCAL6534.pdf
> > [2] https://www.nxp.com/docs/en/data-sheet/PCAL6524.pdf
> > [3] https://www.diodes.com/assets/Datasheets/PI4IOE5V6534Q.pdf
>=20
> Convert these to Datasheet: tags.
>=20
> ...
>=20
> > =C2=A0#define PCA957X_TYPE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BIT(13)
> > =C2=A0#define PCA_TYPE_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 GENMASK(15, 12)
> >=20
> > +#define PCAL6534_ALIGN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 BIT(16)
>=20
> I believe it should be a chip TYPE.
>=20

I didn't do this as functionality wise it seems to basically be
PCA953X_TYPE, just with the alignment of the registers being very
different. I could add a PCAL6534_TYPE if you prefer.

> ...
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "xra1202", 8=C2=A0 | PCA95=
3X_TYPE },
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "pi4ioe5v6534q", 34 | PCA953X_T=
YPE | PCA_LATCH_INT |
> > PCAL6534_ALIGN, },
>=20
> What's this and why is it not ordered?
>=20

The entries in pca953x_id[] appear to be ordered in the same order as
pca953x_dt_ids[], where the entries are grouped by manufacturer. This
chip is manufactured by diodes (as mentioned in the commit message), so
put it in it's own block following president. The manufacturers weren't
ordered alphabetically, so assumed ordered by when they were added.

> ...
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bank_shift =3D pca953x_bank_s=
hift(chip);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bank =3D (reg & REG_ADDR_MASK=
) >> bank_shift;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset =3D reg & (BIT(bank_sh=
ift) - 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bank;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (chip->driver_data & PCAL6534_=
ALIGN) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bank =3D (reg & REG_ADDR_MASK) / NBANK(chip);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offset =3D reg - (bank * NBANK(chip));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int bank_shift =3D pca953x_bank_shift(chip);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bank =3D (reg & REG_ADDR_MASK) >> bank_shift;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offset =3D reg & (BIT(bank_shift) - 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> I'm wondering if it can be moved to bank_shift()=C2=A0 and possibly a new
> helper to get an offset.
>=20

Due to the different register spacing, I don't think these chips obey
any offset based rules. For the record, I've done a bit more work here
to get it returning the correct values for all the extended registers.
What I currently have is this (which I don't particularly like and
would be open to alternative implementations):


 static u8 pca953x_recalc_addr(struct pca953x_chip *chip, int reg, int
off)
 {
-       int bank_shift =3D pca953x_bank_shift(chip);
-       int addr =3D (reg & PCAL_GPIO_MASK) << bank_shift;
-       int pinctrl =3D (reg & PCAL_PINCTRL_MASK) << 1;
-       u8 regaddr =3D pinctrl | addr | (off / BANK_SZ);
+       int bank_shift;
+       int addr;
+       int pinctrl;
+       u8 regaddr;
+
+       if (chip->driver_data & PCAL6534_ALIGN) {
+               addr =3D (reg & PCAL_GPIO_MASK) * NBANK(chip);
+
+               switch(reg) {
+               case PCAL953X_OUT_STRENGTH:
+               case PCAL953X_IN_LATCH:
+               case PCAL953X_PULL_EN:
+               case PCAL953X_PULL_SEL:
+               case PCAL953X_INT_MASK:
+               case PCAL953X_INT_STAT:
+               case PCAL953X_OUT_CONF:
+                       pinctrl =3D ((reg & PCAL_PINCTRL_MASK) >> 1) +
0x20;
+                       break;
+               case PCAL6524_INT_EDGE:
+               case PCAL6524_INT_CLR:
+               case PCAL6524_IN_STATUS:
+               case PCAL6524_OUT_INDCONF:
+               case PCAL6524_DEBOUNCE:
+                       pinctrl =3D ((reg & PCAL_PINCTRL_MASK) >> 1) +
0x1c;
+                       break;
+               }
+               regaddr =3D pinctrl + addr + (off / BANK_SZ);
+       } else {
+               bank_shift =3D pca953x_bank_shift(chip);
+               addr =3D (reg & PCAL_GPIO_MASK) << bank_shift;
+               pinctrl =3D (reg & PCAL_PINCTRL_MASK) << 1;
+               regaddr =3D pinctrl | addr | (off / BANK_SZ);
+       }
=20
        return regaddr;
 }

As I said, whilst the functionality of this chip seems to closely match
some of the others driven by this driver, the register offsets are
quite different and hard to incorporate cleanly in this driver due to
the way it determines register locations.

> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < NBANK(chip); i+=
+) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 value[i] =3D bitmap_get_value8(val, i * BANK_SZ);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 dev_err(&chip->client->dev, "value[%d] =3D %x\n", i,
> > value[i]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&chip->client->dev, "rega=
ddr: %x\n", regaddr);
>=20
> dev_err() ?!
>=20

Quick and dirty debug. The code was included in RFC to help show the
path I was taking to include support for this device and is definitely
not ready for merging.

> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "diodes,pi4ioe5=
v6534q", .data =3D OF_953X(34,
> > PCA_LATCH_INT | PCAL6534_ALIGN), },
>=20
> As per above.
>=20

