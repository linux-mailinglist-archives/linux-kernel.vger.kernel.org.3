Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECAC577604
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiGQLja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGQLj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:39:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8B13CC8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:39:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id os14so16635861ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=XEtmsNl4u66aYMzdyl3pfswTgqZQ+LbLXnL/ukMAAXE=;
        b=2OlXoPt9osA/rHTHsNopckAXaay82XQOfX6LLs5YtgIWBC6Pj6Z3VoDMEuHq7AZOp9
         i9agQxeRowK33tBJ4FQGoWGZZESD5GrobQT6WDfI39yNLhMm03JY6G9cilqbNyEZLm58
         uS8e4KKCFzyQpqAK/xWkxiNM5Q+tl+gCUJnp0i4yMCXnhPp2/BRj39XXNQ9BzIkuGTx1
         JGMAiRakZnt/tgmOBX0m6+upUkFA3R+evtlOg605NhAdUq/B3rO0PJ0hqArnWdwKePTM
         lgJMp9Ks9Nr1X2NQNezUBtVvmdCOr4bhP5Wi3PjwmH6/uXmwhHGwZZmJUysITpkeC6Kf
         Yuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=XEtmsNl4u66aYMzdyl3pfswTgqZQ+LbLXnL/ukMAAXE=;
        b=uUjMTjeGFxEr1IVk/+2+fyzFO5GQCgAdRV55lcoc6mSfpxzJbMH9Gg5ORTKRwTg4kt
         H374IEdcBjGCrCYDzg2c3GQ+IV5J4JoUmXZ1qzVrHWFrt/vW2R4P9USjWlf2MS4g0//I
         P590sPMsoieJYAHkqEitZstf4xQKrm0oPxe9XQOhjG42Lahs/XbkVgmKY43bfUWcAagq
         fm7iYh6SyXbWAG1244/iGiEkLfU7zEF0BcT63lCMLaQC/95N4ia9927Kx8xLlJlMt8qq
         KHrqnE7jl+pabhf927yBkW5Nh3DV002NNNGOsHH7O6NCeWpQfNrqCkQ+VZCzm7vOI6CE
         7jqA==
X-Gm-Message-State: AJIora/TMXL0v/Pe1RoUrXXI5KRU9LBchCC3XAQvMsxrDtOWTvbr0UXV
        uDM2VGQSpOHIIe6fpBKGrPxyotdq9QtMmQ==
X-Google-Smtp-Source: AGRyM1vNamiJ14bJI8Rl6k7vhILjQ3FuH+1BWqilQKi1z7nUGJRaZJm3jpPBFbiKHLLBcS4mpe2DnQ==
X-Received: by 2002:a17:906:8a6a:b0:72b:552e:67f0 with SMTP id hy10-20020a1709068a6a00b0072b552e67f0mr21933860ejc.733.1658057965893;
        Sun, 17 Jul 2022 04:39:25 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id z20-20020a170906715400b0070f7d1c5a18sm4246047ejj.55.2022.07.17.04.39.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 04:39:25 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
Date:   Sun, 17 Jul 2022 13:39:24 +0200
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
Message-Id: <2B145293-BAAE-40AE-B408-FCFC4A80E46D@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is _somewhat_ related to "[PATCH] regulator: core: Fix =
off-on-delay-us for always-on/boot-on regulators"
That other patch is the right solution for my specific problem, and no =
further fixes are necessary.

This change fixes an attempted "bandage" solution (adding an =
"off-on-delay-us") that we had initially tried to no avail.
While the cleanup not only reduces complexity, it may also prevent =
future code changes reintroducing the non-delayed cycling after =
registration.

from arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi:
vcc3v0_sd: vcc3v0-sd {
        compatible =3D "regulator-fixed";
        enable-active-high;
        gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&sdmmc0_pwr_h>;
        regulator-always-on; // prevents setting last_off upon =
registration
        off-on-delay-us =3D <500000>; // would not be honored upon =
regulator_register
        regulator-min-microvolt =3D <3000000>;
        regulator-max-microvolt =3D <3000000>;
        regulator-name =3D "vcc3v0_sd";
        vin-supply =3D <&vcc3v3_sys>;
};

> Am 17.07.2022 um 13:30 schrieb Christian Kohlschuetter =
<christian@kohlschuetter.com>:
>=20
> Regulators marked with "regulator-always-on" or "regulator-boot-on"
> as well as an "off-on-delay-us", may run into cycling issues that are
> hard to detect.
>=20
> This is caused by the "last_off" state not being initialized in this
> case.
>=20
> Fix the "last_off" initialization by setting it to the current kernel
> time upon initialization, regardless of always_on/boot_on state.
>=20
> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
> ---
> drivers/regulator/core.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index c4d844ffad7a..48ed33ad48c8 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1522,6 +1522,9 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
> 		}
> 	}
>=20
> +	if (rdev->desc->off_on_delay)
> +		rdev->last_off =3D ktime_get();
> +
> 	/* If the constraints say the regulator should be on at this =
point
> 	 * and we have control then make sure it is enabled.
> 	 */
> @@ -1549,8 +1552,6 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
>=20
> 		if (rdev->constraints->always_on)
> 			rdev->use_count++;
> -	} else if (rdev->desc->off_on_delay) {
> -		rdev->last_off =3D ktime_get();
> 	}
>=20
> 	print_constraints(rdev);
> --=20
> 2.36.1
>=20
>=20



--=20
Dr. Christian Kohlsch=C3=BCtter



