Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA6D5710A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiGLDHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiGLDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:06:43 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862331239
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:06:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b2so2784554qkk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOfzzS/NAq/eRmLGRpw95xaiIHsu/LwIwpnwcG9ELxU=;
        b=UINuF0a1aRcsNC6pElpGLcfasWKxHi7dvgXrpT26/5mMqb2z+XY0DwpYkmpG/InjOe
         dNwYb6lZ3ZssTJI2Yt7jkUkzE7/4BmTSQmJwq6aV4ZF57eXWvtB1ucLQo/8PiRxY9X3R
         yFUSdiEQSjT9YZGWvFCr2b4BQKf+byu+blakhZq128t/nTtCrvErMkVFNVj/yX9+B1wT
         pnnuwG7f0+YBM9pBLG3n0XV4vXjtydocRFmU1Z27YuTpm5JNgOd4yIA3258CjNL3CLBu
         kn7uNu/w3eS/ElUuNN9RN83wx2Vbbk5bnYmt6wwnshw+fGd0JmtPl0JjcfuPAL6++BeY
         f0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOfzzS/NAq/eRmLGRpw95xaiIHsu/LwIwpnwcG9ELxU=;
        b=nuRQHEfd/78zW7/u1MTP+ajzI9b2T7cvAqGDVzWXj5ifLR0iwP40ALTzuTqxO1fXIA
         A6YobaQfUGep4CF6RHy5+bu6WDqaIZr48cnf+x56TA8WXMZQFG4adlcD7B8jIS3bkLg0
         yOK/zbDGa8X6iw4Pb4sRyafORbWu+jKkvQYT4saTfKXARwS99sYxb8n7V6wgzDLScNFR
         LPV1LvZsRTnOqLTB7iTpf6xRLHNOekQoHLiakKs3UE1jKPOPINchh/iuzka2Y8pMD6VF
         OXQDXEItePex9poMcNrNCRNNgrHvUY/IuGHZt+RvaXpoa7QDuHEekLB5t5uhCUfJZDYA
         TUuA==
X-Gm-Message-State: AJIora8SxVbrmlxtkOV115aaZEDKR8IcQcQ4WoEJMTtf02/KFA7CWs1/
        FdDOpul0sS+ost/z2HwYBekjyw==
X-Google-Smtp-Source: AGRyM1vJ/aNhWX/Az5F7+pr4yZOi+nHAKaRaeGJKkClK6+nT9OyU9sdlqt/nE+bEM5AAmyoDMd/SRA==
X-Received: by 2002:a37:9fd2:0:b0:6b5:7642:5ee0 with SMTP id i201-20020a379fd2000000b006b576425ee0mr8854420qke.452.1657595201307;
        Mon, 11 Jul 2022 20:06:41 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b0031eb0bb5c3csm5144501qtb.28.2022.07.11.20.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 20:06:40 -0700 (PDT)
Date:   Mon, 11 Jul 2022 23:06:39 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: Re: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
Message-ID: <YszlP1+sBhxvz3Fo@fedora>
References: <cover.1657216200.git.william.gray@linaro.org>
 <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
 <CACRpkdZn-PV6H+uBcoONt=SThGBAODy-YG=rkx5OX-rcpeE+aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fPnMJIDMmtvaXDMm"
Content-Disposition: inline
In-Reply-To: <CACRpkdZn-PV6H+uBcoONt=SThGBAODy-YG=rkx5OX-rcpeE+aw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fPnMJIDMmtvaXDMm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2022 at 03:02:10PM +0200, Linus Walleij wrote:
> On Fri, Jul 8, 2022 at 1:16 AM William Breathitt Gray
> <william.gray@linaro.org> wrote:
>=20
> > Exposes consumer functions providing support for Intel 8255 Programmable
> > Peripheral Interface devices. A CONFIG_GPIO_I8255 Kconfig option is
> > introduced; modules wanting access to these functions should select this
> > Kconfig option.
> >
> > Tested-by: Fred Eckert <Frede@cmslaser.com>
> > Cc: John Hentges <jhentges@accesio.com>
> > Cc: Jay Dolan <jay.dolan@accesio.com>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> This chip is like 50 years old, but so am I and I am not obsolete, it's a=
bout
> time that we implement a proper driver for it!
>=20
> But I suppose you are not really using the actual discrete i8255 componen=
t?
> This is certainly used as integrated into some bridge or so? (Should be
> mentioned in the commit.)

Interestingly, there are some PC/104 devices out there that use actual
i8255 components (e.g. Diamond Systems Onyx-MM with its 82C55 chips),
but honestly the majority of devices I come across are simply emulating
the i8255 interface in an FPGA or similar.

I'll adjust the commit to make it clearer that this is a library for
i8255-compatible interfaces rather than support for any physical Intel
8255 chip in particular.

> > +config GPIO_I8255
> > +       tristate
>=20
> That's a bit terse :D Explain that this is a Intel 8255 PPI chip first de=
veloped
> in the first half of the 1970ies.

Ack.

> > +++ b/include/linux/gpio/i8255.h
>=20
> You need to provide a rationale for the separate .h file in the commit
> message even if it is clear
> how it is used in the following patches.
>=20
> Yours,
> Linus Walleij

I think I'll move this to gpio/driver.h as per Andy Shevchenko's
suggestion. For now only a few drivers under drivers/gpio/ use this
library, so it probably doesn't need to be separate just yet.

William Breathitt Gray

--fPnMJIDMmtvaXDMm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYszlPwAKCRC1SFbKvhIj
K6XQAPsGMPk87IYm745/bAEVZHWvSsrlNwY4SzSB5oTrN+AIZQD8DzVx0wrQCj2q
T0ZU22f9J/0Q9p1IMNMCxTcJ9+zJIAs=
=v5f6
-----END PGP SIGNATURE-----

--fPnMJIDMmtvaXDMm--
