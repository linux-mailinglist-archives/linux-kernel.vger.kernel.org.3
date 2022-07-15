Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBAB576886
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiGOUv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGOUv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:51:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC05E12752
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:51:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id va17so11051773ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3Vcv+Zqcd+YiC3pv/6ZVpdeh0nqVlQ60ZrMu8iVPCE0=;
        b=hfpxKr79PIpiVKRB3kbWZcyibR5lAWIyCaYB6tIMOaKXIiUUN5eu2EiH5vEqDMrst1
         Smt2Kj8v1PmDvq8asPjO2YfgTbZ7sTMbghfSoW2v8jv9p1GdthIBCEJZpncO+tARqtkb
         DP1Nbp0R6UWAvkWgR66eR4osoAWPmmU/XreUBF3xzjKLPCpJaECgfaInsZOLVOIoXNZi
         Nxj4R/5uRV0cYoQjj3t56Zu2T97a17XYrvAe/2dqcfLDsk0kpBVEdbEpeBO3hynzrMok
         8FFV/GgATToM+BYaY4/KwerxRdz+ZObWPp6EooUnWXydrNx49HuGebWTsj7aFvkKkzKr
         DGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3Vcv+Zqcd+YiC3pv/6ZVpdeh0nqVlQ60ZrMu8iVPCE0=;
        b=mLv3XwEreiit6A8XFZhTbMA6ToNErLLWkWAkP4mMbbKZK4DrMR2UnvUHu4uqgLvjrI
         yixc8bRK2htpx1UV052d8GcFN82M1nL44rALb5b2Zba8970o4nIZG2YuzecTXWn7IpLs
         bXDKlQM++PBhn/vpQhcTLbEqmEGY5oZiAXGsYuXbwhnUGtzMIctFMx/zJ+2Y1Rdm1kpM
         yFujycIaTtyiySHK7VmD5MN8QbO153wofHuC7wPJM92vLQLsY+irtxSVp1wil7wT0kO/
         VC7bFgvSSeaWYPmYaHonVBPa37xOzXgLMSHIcn+VVgzcWQbdNry1pbdLIY45z8UmRTDp
         a3bA==
X-Gm-Message-State: AJIora9RrULLl8EUEjFvJc7EPsmS2liQ3N+fgFNjGoocXMk0jCRygrJB
        OCgx/6uuydUxGzm3f+ksRca1AQ==
X-Google-Smtp-Source: AGRyM1sNJTmw5My6E+UIFPxEEm5NSizCZE5yfStZxt0SI6lvyujXMl0QKBnTWcpM2xTQKS+FnyDkGw==
X-Received: by 2002:a17:906:2086:b0:715:7983:a277 with SMTP id 6-20020a170906208600b007157983a277mr15317328ejq.386.1657918314254;
        Fri, 15 Jul 2022 13:51:54 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id wj18-20020a170907051200b0072af92fa086sm2401478ejb.32.2022.07.15.13.51.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 13:51:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] regulator: core: Resolve supply name earlier to prevent
 double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <3B4AE882-0C28-41E3-9466-F8E301567627@kohlschutter.com>
Date:   Fri, 15 Jul 2022 22:51:52 +0200
Cc:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFF60E71-B8CF-43C9-B476-9216AFF0463B@kohlschutter.com>
References: <3B4AE882-0C28-41E3-9466-F8E301567627@kohlschutter.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a follow-up patch from my patch on mmc side:
[PATCH v4] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
=
https://patchwork.kernel.org/project/linux-rockchip/patch/73F9AED0-D2A8-42=
94-B6E1-1B92D2A36529@kohlschutter.com/

Thanks to Robin Murphy's help, we were able to figure out that my NanoPI =
R4S's SD-Card voltage regulator was initialized twice and that a voltage =
drop was the reason for the initialization failure.
Adding an mdelay to the init code, or =E2=80=94 surprisingly =E2=80=94 =
adding a "regulator-uv-protection-microvolt" declaration had "fixed" the =
issue in 99/100 tries.

Best,
Christian

from arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi:
vcc3v0_sd: vcc3v0-sd {
        compatible =3D "regulator-fixed";
        enable-active-high;
        gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&sdmmc0_pwr_h>;
        regulator-always-on;
        regulator-min-microvolt =3D <3000000>;
        regulator-max-microvolt =3D <3000000>;
        regulator-name =3D "vcc3v0_sd";
        vin-supply =3D <&vcc3v3_sys>;
};                                       =20

> Am 15.07.2022 um 22:32 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
> Previously, an unresolved regulator supply reference upon calling
> regulator_register on an always-on or boot-on regulator caused
> set_machine_constraints to be called twice.
>=20
> This in turn may initialize the regulator twice, leading to voltage
> glitches that are timing-dependent. A simple, unrelated configuration
> change may be enough to hide this problem, only to be surfaced by
> chance.
>=20
> One such example is the SD-Card voltage regulator in a NanoPI R4S that
> would not initialize reliably unless the registration flow was just
> complex enough to allow the regulator to properly reset between calls.
>=20
> Fix this by re-arranging regulator_register, trying resolve the
> regulator's supply early enough that set_machine_constraints does not
> need to be called twice.
>=20
> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
> ---
> drivers/regulator/core.c | 42 ++++++++++++++++++++++++++--------------
> 1 file changed, 28 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index c4d844ffad7a..728840827e9c 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5433,7 +5433,34 @@ regulator_register(const struct regulator_desc =
*regulator_desc,
> 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
> 	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
>=20
> -	/* preform any regulator specific init */
> +	/* set regulator constraints */
> +	if (init_data)
> +		rdev->constraints =3D kmemdup(&init_data->constraints,
> +					    sizeof(*rdev->constraints),
> +					    GFP_KERNEL);
> +	else
> +		rdev->constraints =3D =
kzalloc(sizeof(*rdev->constraints),
> +					    GFP_KERNEL);
> +
> +	if (init_data && init_data->supply_regulator)
> +		rdev->supply_name =3D init_data->supply_regulator;
> +	else if (regulator_desc->supply_name)
> +		rdev->supply_name =3D regulator_desc->supply_name;
> +
> +	if ((rdev->supply_name && !rdev->supply) && rdev->constraints
> +		&& (rdev->constraints->always_on || =
rdev->constraints->boot_on)) {
> +		/* Try to resolve the name of the supplying regulator =
here first
> +		 * so we prevent double-initializing the regulator, =
which may
> +		 * cause timing-specific voltage brownouts/glitches that =
are
> +		 * hard to debug.
> +		 */
> +		ret =3D regulator_resolve_supply(rdev);
> +		if (ret)
> +			rdev_dbg(rdev, "unable to resolve supply early: =
%pe\n",
> +					 ERR_PTR(ret));
> +	}
> +
> +	/* perform any regulator specific init */
> 	if (init_data && init_data->regulator_init) {
> 		ret =3D init_data->regulator_init(rdev->reg_data);
> 		if (ret < 0)
> @@ -5459,24 +5486,11 @@ regulator_register(const struct regulator_desc =
*regulator_desc,
> 		    (unsigned long) atomic_inc_return(&regulator_no));
> 	dev_set_drvdata(&rdev->dev, rdev);
>=20
> -	/* set regulator constraints */
> -	if (init_data)
> -		rdev->constraints =3D kmemdup(&init_data->constraints,
> -					    sizeof(*rdev->constraints),
> -					    GFP_KERNEL);
> -	else
> -		rdev->constraints =3D =
kzalloc(sizeof(*rdev->constraints),
> -					    GFP_KERNEL);
> 	if (!rdev->constraints) {
> 		ret =3D -ENOMEM;
> 		goto wash;
> 	}
>=20
> -	if (init_data && init_data->supply_regulator)
> -		rdev->supply_name =3D init_data->supply_regulator;
> -	else if (regulator_desc->supply_name)
> -		rdev->supply_name =3D regulator_desc->supply_name;
> -
> 	ret =3D set_machine_constraints(rdev);
> 	if (ret =3D=3D -EPROBE_DEFER) {
> 		/* Regulator might be in bypass mode and so needs its =
supply
> --=20
> 2.36.1
>=20

