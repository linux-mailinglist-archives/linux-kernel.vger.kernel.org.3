Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC74C2DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiBXOPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiBXOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:14:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DAC27909E;
        Thu, 24 Feb 2022 06:14:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x5so3003377edd.11;
        Thu, 24 Feb 2022 06:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FBkptmrbjgcyXNexB1zWqSeWZWCGxggPHix7hH53JHk=;
        b=oTmm8LPK0MzPhXymI8PYrIMyp4RSZdfYJC2P0ZpWpdUtLI9GerBu57MELgq5/RfArW
         F7zIJw8srBE0v4xMi/F+FGGimFFJCEqyVwyRG0y/b+cEnJsd5IuYRoMEmubfGKHOJWBm
         rMAnXBKF7OHfREcTkb/JBSHXmhBkQWfuPkeheqxZwTh5iItauF/3Tc5NfRluxDJH/Vt4
         x0DBLLKju2pazAgxYSKd5oDi/SHxKPcr3wmD0b9+hDyGhzjK1A3jPmLHFgbwY61QYEq6
         6vARtmsfFC+X0/jZ2aSAp/moDFX/HMrR16cJRv7NXo67Pcs+eTU0xLiKltNfCMMnxndx
         shCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FBkptmrbjgcyXNexB1zWqSeWZWCGxggPHix7hH53JHk=;
        b=I63A8z/WQhowiH9V5EG40CrPgFp0YTsjM9emjHQb5u3/3RYW5v2q1xz/oFFn0VFIVD
         bFWoIHya5Ro8s4q0oznh3EDUwvx7h7EK/aLg8tBaBWxrlfO/iMF+J+QQ2iFvMM2dWhSE
         btbGsJ22YBsho0ghEExxu0kWmE0bFc2//6K7/XMXqlcfeO3ej7Ddjf0mEMleJiiBamHJ
         +/dvT1LZCZmWsBsRB/p+//MiLfxzN/gzgdzBDmwDjxczaY8wDSwtvXBO9lNCni/+Xxym
         LV1BCMQXDoE6Ov9/ZE0LSvH1+VO54Trly1TiepaA81BMkBQoxra/zd14o8xPErFG++Xz
         cNGg==
X-Gm-Message-State: AOAM533Y4YCYQ7gLBfiibyvmQhG4QEduTR7a5Rba3VTE+k2zTdEhrPaI
        PNXcRSsC48bQJD9X/lA81/qWzHXN1B8=
X-Google-Smtp-Source: ABdhPJzli2R+4X+vn4xujVlJDjmhXJKwXpQs0fSFu+hxDc0tLOcxs/g5o/a0F8RRxr4Jb3jpC+zwWA==
X-Received: by 2002:a05:6402:492:b0:404:c4bf:8b7e with SMTP id k18-20020a056402049200b00404c4bf8b7emr2462100edv.318.1645712065532;
        Thu, 24 Feb 2022 06:14:25 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m7sm1392562eds.104.2022.02.24.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 06:14:24 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:14:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v13 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <YheSvtwqaL5mDmre@orome>
References: <20220218183116.2261770-1-bjorn.andersson@linaro.org>
 <20220218183116.2261770-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="31AA9bs7Oglvh3xm"
Content-Disposition: inline
In-Reply-To: <20220218183116.2261770-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--31AA9bs7Oglvh3xm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 18, 2022 at 10:31:16AM -0800, Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> with their output being routed to various other components, such as
> current sinks or GPIOs.
>=20
> Each LPG instance can operate on fixed parameters or based on a shared
> lookup-table, altering the duty cycle over time. This provides the means
> for hardware assisted transitions of LED brightness.
>=20
> A typical use case for the fixed parameter mode is to drive a PWM
> backlight control signal, the driver therefor allows each LPG instance
> to be exposed to the kernel either through the LED framework or the PWM
> framework.
>=20
> A typical use case for the LED configuration is to drive RGB LEDs in
> smartphones etc, for which the driver supports multiple channels to be
> ganged up to a MULTICOLOR LED. In this configuration the pattern
> generators will be synchronized, to allow for multi-color patterns.
>=20
> The idea of modelling this as a LED driver ontop of a PWM driver was
> considered, but setting the properties related to patterns does not fit
> in the PWM API. Similarly the idea of just duplicating the lower bits in
> a PWM and LED driver separately was considered, but this would not allow
> the PWM channels and LEDs to be configured on a per-board basis. The
> driver implements the more complex LED interface, and provides a PWM
> interface on the side of that, in the same driver.
>=20
> Tested-by: Luca Weiss <luca@z3ntu.xyz>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> Changes since v12:
> - Initialize ret in lpg_pwm_apply()
>=20
> Changes since v11:
> - Extended commit message to cover decision to put pwm_chip in the LED dr=
iver
> - Added Documentation, in particular for the hw_pattern format
> - Added a lock to synchronize requests from LED and PWM frameworks
> - Turned out that the 9bit selector differs per channel in some PMICs, so
>   replaced bitmask in lpg_data with lookup based on QPNP SUBTYPE
> - Fixed kerneldoc for the struct device pointer in struct lpg
> - Rewrote conditional in lut_free() to make it easier to read
> - Corrected and deduplicated max_period expression in lpg_calc_freq()
> - Extended nom/dom to numerator/denominator in lpg_calc_freq()
> - Replaced 1 << 9 with LPG_RESOLUTION in one more place in lpg_calc_freq()
> - Use FIELD_PREP() in lpg_apply_freq() as masks was introduced for readin=
g the
>   same in get_state()
> - Cleaned up the pattern format, to allow specifying both low and high pa=
use
>   with and without pingpong mode.
> - Only update frequency and pwm_value if PWM channel is enabled in lpg_pw=
m_apply
> - Make lpg_pwm_get_state() read the hardware state, in order to pick up e=
=2Eg.
>   bootloader backlight configuration
> - Use devm_bitmap_zalloc() to allocate the lut_bitmap
> - Use dev_err_probe() in lpg_probe()
> - Extended Kconfig help text to mention module name and satisfy checkpatch
>=20
>  Documentation/leds/leds-qcom-lpg.rst |   76 ++
>  drivers/leds/Kconfig                 |    3 +
>  drivers/leds/Makefile                |    3 +
>  drivers/leds/rgb/Kconfig             |   18 +
>  drivers/leds/rgb/Makefile            |    3 +
>  drivers/leds/rgb/leds-qcom-lpg.c     | 1401 ++++++++++++++++++++++++++
>  6 files changed, 1504 insertions(+)
>  create mode 100644 Documentation/leds/leds-qcom-lpg.rst
>  create mode 100644 drivers/leds/rgb/Kconfig
>  create mode 100644 drivers/leds/rgb/Makefile
>  create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c

Looks good to me from a PWM point of view:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--31AA9bs7Oglvh3xm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXkr4ACgkQ3SOs138+
s6FG6g//ad/JahWMr3wxO69qvnHidSEWsS28DQ/xb0qlzM+TSGk8x6lRI/NlMYZ3
EIrULOy7VZz0kNjmuQ3OlKKplnlk5l7SXKYD9b7MmMrYJvs5oivlJUQzXO192qHz
RVkm2NupYyxbQeQTdiTeWBVwBVAvW/WOjx6Tcd+uqmkrCqnBjbLRZYjcYcMExozZ
lzDVhu5x/OeusETYUsa0LY+AGIoKW585x3uO0n/nAHeETfsjHsyyKscKlJD8XdVQ
WqCQB3el2k7Nmr48mVKM/JTBggadBVYrIovefP29fJoSRrvy+IXtvNc2tSvL5U0v
lRGljrInbXqCjB2OgjL71fZCDNKW0J2IdDidaNDhZFayGUTtj+dnGdnb1ujgRGXY
m5cOSsGYR0bk63IqfImOjU5K9FkGwQiCfudIQxMdRteez+erEGAySSG3F6Lg5fSr
Qk4PTaM8sFlb6IvV+Lew1LusK0DTKlX+cALb9Ee4VoiMykvpN+I6hnsRlwbWksG4
+omgWoSI3rP5J5M3VlfjqnU3W31Oo9cT53bnlOKbATwV+Zxmsbtj+p65RFn5ETXX
f6glLJvmQksc9X4zeOBdaT5SaH4dK1SIP2ZpmQ3LYjgBPb7WWkZKcZ8SfPAB3ctN
9AX1EvXj0P7DG9Q16/GhVrYBmdI+GnVauu2RyY4YXmoMqobBPMw=
=MNBh
-----END PGP SIGNATURE-----

--31AA9bs7Oglvh3xm--
