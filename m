Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038DD571038
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiGLCbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGLCbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:31:13 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEEB3336F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:31:12 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v6so5318889qkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AmIBu9eJI4O2vCJpeuCdhgJb9LGCZJQYDhsDtn3WLRU=;
        b=AmGsvlyIHhgUj9HXy2/JuS72mE/38WBicCbwWGTxyt1M3gaUQCPiYU5yoPWDTIk4Fg
         tV6PDt2i64dJGXL1dn8j58hfUVuaOXDl4Sp9IwFjgq4gV6dCd/d4rBWLAjB5FMoYkOaZ
         3/Pu4IThZUbwO151VlbJZuoiyvFz5rWCTb23AUCJGdFgwHCpZRWXkwVeT7BLD8hYxqTf
         mGi1ZjvROVrJ1VmR8Pc3ewc1sJxjeAXyjciQQraHjr4kMO6ip93eLgFRc5JnL99UHuRp
         0nbcaJHpo/DbaUVniy1rLxXestDYdJoAMKxGGep9zzIkW4u5Vld9ZIwHCblk0yhZpsF7
         YQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AmIBu9eJI4O2vCJpeuCdhgJb9LGCZJQYDhsDtn3WLRU=;
        b=DyVbPyE9Sw1/X7dV+zQyUagwP0HT9LiTuLbRrauqdMv2TZ/kSeem+R8DUFYhmhasoB
         d/fCx85nP3OYmO3QmVXkYwC0R3FrY/54O9YxcsS20mVqR6AJNKnoO+RtSb1Q1JvDZXcS
         5rD0aIqcoxkgCqEzdyen1IS1DOm+zN8o4V/w8XHrfs7JBo6U2WWRjWf3ODogj3+MzWC+
         PQKXBL4WRN8Qj/iTfAQO7xhyecosebnAmXJ6U28iwUKtEjuP5J+VVNjePsjVXs5Gp6Cw
         81tH+DrlL0MAK/ueS0KJm4IPejlyn8zz4cAqTipCH0sSOgt5Q7EaF0/GGqMJpFvW20Wc
         Z9Tw==
X-Gm-Message-State: AJIora9dmnK/JrUOuPmBanPGmDrqr9+7kFc6JFJX1b9cayK8qDW1/vDi
        Qfh5FWXAb5adSkIaGr3vMlRCFLw886eVXQ==
X-Google-Smtp-Source: AGRyM1tKTKG1peLHl78LBetPvvq8nWXRgR/nKcyIrD6QeeNC0fY5CNcs/lT6T7KXgsX5fKO4vjwPgQ==
X-Received: by 2002:a05:620a:2455:b0:6b5:797a:5d85 with SMTP id h21-20020a05620a245500b006b5797a5d85mr7829367qkn.249.1657593071977;
        Mon, 11 Jul 2022 19:31:11 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bk9-20020a05620a1a0900b006af3f3b385csm8221838qkb.98.2022.07.11.19.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:31:11 -0700 (PDT)
Date:   Mon, 11 Jul 2022 22:31:09 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: Re: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
Message-ID: <Yszc7cvyB37b8UHg@fedora>
References: <cover.1657216200.git.william.gray@linaro.org>
 <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
 <CAHp75VdM7QoBfcsQ-S4OEn2ZLnFH+0HfLY44FcRQC+_cw+UXzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eII5gPQELsvNu0az"
Content-Disposition: inline
In-Reply-To: <CAHp75VdM7QoBfcsQ-S4OEn2ZLnFH+0HfLY44FcRQC+_cw+UXzg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eII5gPQELsvNu0az
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2022 at 04:40:01PM +0200, Andy Shevchenko wrote:
> On Fri, Jul 8, 2022 at 1:16 AM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> >
> > Exposes consumer functions providing support for Intel 8255 Programmable
> > Peripheral Interface devices. A CONFIG_GPIO_I8255 Kconfig option is
> > introduced; modules wanting access to these functions should select this
> > Kconfig option.
>=20
> Spent much time with these chips in my teenage times :-)
>=20
> Very good written library, see my comments below.
>=20
> ...
>=20
> > +#include <linux/compiler_types.h>
>=20
> Should be simple types.h as you are using u8, etc.

Ack.

> > +#include <linux/err.h>
> > +#include <linux/export.h>
>=20
> > +#include <linux/gpio/i8255.h>
>=20
> gpio/driver.h ?
>=20
> And since it belongs to GPIO, I would group them and move after all
> other include/* to emphasize the relationship.
>=20
> Also, why is it in the global header folder? Do you expect some
> drivers outside of drivers/gpio/? Maybe we can move after when the
> user comes?

I think gpio/driver.h does make more sense for now since all the users
of library are located under drivers/gpio/. I'll move the header code
into gpio/driver.h then and adjust the includes accordingly.

> > +#include <linux/io.h>
> > +#include <linux/module.h>
>=20
> ...
>=20
> > +#define I8255_CONTROL_PORTCLOWER_DIRECTION BIT(0)
> > +#define I8255_CONTROL_PORTCUPPER_DIRECTION BIT(3)
>=20
> Missed underscore.

Ack.

> ...
>=20
> > +static u8 i8255_direction_mask(const unsigned long offset)
> > +{
> > +       const unsigned long io_port =3D offset / 8;
> > +       const unsigned long ppi_port =3D io_port % 3;
> > +
> > +       switch (ppi_port) {
> > +       case I8255_PORTA:
> > +               return I8255_CONTROL_PORTA_DIRECTION;
> > +       case I8255_PORTB:
> > +               return I8255_CONTROL_PORTB_DIRECTION;
> > +       case I8255_PORTC:
> > +               /* Port C can be configured by nibble */
>=20
> > +               if (offset % 8 > 3)
>=20
> I would move it to the local definition block close to offset/8. On
> some architectures this may give one assembly instruction for two
> variables.

Ack.

> > +                       return I8255_CONTROL_PORTCUPPER_DIRECTION;
> > +               return I8255_CONTROL_PORTCLOWER_DIRECTION;
> > +       default:
> > +               /* Should never reach this path */
> > +               return 0;
> > +       }
> > +}
>=20
> > +void i8255_direction_input(struct i8255 __iomem *const ppi,
> > +                          u8 *const control_state, const unsigned long=
 offset)
> > +{
> > +       const unsigned long io_port =3D offset / 8;
> > +       const unsigned long group =3D io_port / 3;
> > +
> > +       control_state[group] |=3D I8255_CONTROL_MODE_SET;
> > +       control_state[group] |=3D i8255_direction_mask(offset);
> > +
> > +       iowrite8(control_state[group], &ppi[group].control);
>=20
> No I/O serialization? Can this be accessed during interrupt? (It may
> be that the code is correct, but please go through it and check with a
> question "can this register be accessed during IRQ and if yes, will
> the user get the correct / meaningful data?")

Writing to the 8255 control register for the device shouldn't be a
problem, but we do have a race condition with the control_state[group]
value. This value is accessed and modified in other functions (e.g. the
i8255_direction_output() right below) so if an interrupt occurs the
value could end up clobbered before it's written.

I'm not sure what the best approach would be here. In the subsequent
patches I have the GPIO drivers take a lock before calling these i8255_*
functions in order to synchronize access to those state arrays. Do you
think it would be better to move the sychronization lock acquisition
internally to the i8255_* functions here?

> > +}
> > +EXPORT_SYMBOL_GPL(i8255_direction_input);
>=20
> Make it with a namespace. Ditto for the rest.

Ack.

William Breathitt Gray

> --=20
> With Best Regards,
> Andy Shevchenko

--eII5gPQELsvNu0az
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYszc7QAKCRC1SFbKvhIj
K46yAQC1oTzg124TYsWDbLzyTHSPNZUL+J0wxtKJ8zAAQ4h6RgD/SkAQxFs0yRNd
UlNDP4cEmMuWJqRQ4v2owveUeyXy0g4=
=WTnk
-----END PGP SIGNATURE-----

--eII5gPQELsvNu0az--
