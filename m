Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367FC577605
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiGQLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:49:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5BD14D11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:49:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id k30so11828536edk.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SC4Y9bQ5Mv3/wN6+CzaaZu23YdaRhhafcPtQU+MEiaw=;
        b=AgL9bPDO5bHJE2njG5yxdz+bkwVKdHy4FLDnj0NHavCS0Y2RlWaur1CNKXD5QZIgJE
         yerieaFIbY6jno2f1xE/Z4WqutyJVwAvZh2hc/uRUmZVHOaGeNYHuQ1mq8sp43iavUtF
         TA42IyhGe0Sn+enezgOLFDAI7KL5WZlZ54H6td8AmTNZCIGRit95xpOLnrOyNVqo5mgf
         Wc0su6Hm9hCy0yu/S4MJUBdah8eGdmqqkg4KHFGNkggHILhQaPV8RhGfIFDXI69kEYyx
         3Ti2gkO+97DYiyChZfmxp0EIIrmcOMr4CgReXHQc5WtaYhHH7439fjv+IPcb89uKboSY
         CaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SC4Y9bQ5Mv3/wN6+CzaaZu23YdaRhhafcPtQU+MEiaw=;
        b=DlSSouWn+NwUmH/hejidO12n0j5ig1v5pyUE47J4gfpeDxkQDa3fi4LbCEHLrz5jNB
         uhN8D5bRkdJolRmOsY36POgm5kisS/n2gpaEE6POcUR7qymUavSEz5pmGMjSrGUlyrk8
         OVobCY9N502M6z+P+xWnoDdqOFN9SkVINOcXd9GYxIfwuD2FaZ+zNpsj8GLrNJIp3m05
         e4OCIBiTLuIaI/7WCX4fSIlNA5+0I4ZU8A+XX1ymkuwbLjO5GHCttda0PFXXmQz1zcCT
         d+ptAlk2t+dxOPgCoiY7L8sxVBhURRymP9IafMEoO151VXXbdH1/z8sLAV2n/SQNsBjt
         GPbg==
X-Gm-Message-State: AJIora/ewAGj8BUvSzk22oa4O2KLoVQUc7QYCYWfja9vP4M4y55hE1DV
        g71YQSs4wQZKb7QsECno6tek3w==
X-Google-Smtp-Source: AGRyM1ssMaPPSAOo/F08JYKHQwJBKwm9/osf98Fy44RqnhD/F0ZVubn9Z7A5aDc39dIwZwY2xuQfwg==
X-Received: by 2002:a05:6402:270b:b0:43a:d89e:8c2d with SMTP id y11-20020a056402270b00b0043ad89e8c2dmr30993250edd.413.1658058565125;
        Sun, 17 Jul 2022 04:49:25 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id qx21-20020a170906fcd500b0072abb95c9f4sm4252027ejb.193.2022.07.17.04.49.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 04:49:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <2B145293-BAAE-40AE-B408-FCFC4A80E46D@kohlschutter.com>
Date:   Sun, 17 Jul 2022 13:49:23 +0200
Cc:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <96D772F2-16D8-49BD-A438-A827B69DB670@kohlschutter.com>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
 <2B145293-BAAE-40AE-B408-FCFC4A80E46D@kohlschutter.com>
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

+CC mmc/rockchip folks

> Am 17.07.2022 um 13:39 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
> This is _somewhat_ related to "[PATCH] regulator: core: Fix =
off-on-delay-us for always-on/boot-on regulators"
> That other patch is the right solution for my specific problem, and no =
further fixes are necessary.
>=20
> This change fixes an attempted "bandage" solution (adding an =
"off-on-delay-us") that we had initially tried to no avail.
> While the cleanup not only reduces complexity, it may also prevent =
future code changes reintroducing the non-delayed cycling after =
registration.
>=20
> from arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi:
> vcc3v0_sd: vcc3v0-sd {
>        compatible =3D "regulator-fixed";
>        enable-active-high;
>        gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
>        pinctrl-names =3D "default";
>        pinctrl-0 =3D <&sdmmc0_pwr_h>;
>        regulator-always-on; // prevents setting last_off upon =
registration
>        off-on-delay-us =3D <500000>; // would not be honored upon =
regulator_register
>        regulator-min-microvolt =3D <3000000>;
>        regulator-max-microvolt =3D <3000000>;
>        regulator-name =3D "vcc3v0_sd";
>        vin-supply =3D <&vcc3v3_sys>;
> };
>=20
>> Am 17.07.2022 um 13:30 schrieb Christian Kohlschuetter =
<christian@kohlschuetter.com>:
>>=20
>> Regulators marked with "regulator-always-on" or "regulator-boot-on"
>> as well as an "off-on-delay-us", may run into cycling issues that are
>> hard to detect.
>>=20
>> This is caused by the "last_off" state not being initialized in this
>> case.
>>=20
>> Fix the "last_off" initialization by setting it to the current kernel
>> time upon initialization, regardless of always_on/boot_on state.
>>=20
>> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
>> ---
>> drivers/regulator/core.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>> index c4d844ffad7a..48ed33ad48c8 100644
>> --- a/drivers/regulator/core.c
>> +++ b/drivers/regulator/core.c
>> @@ -1522,6 +1522,9 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
>> 		}
>> 	}
>>=20
>> +	if (rdev->desc->off_on_delay)
>> +		rdev->last_off =3D ktime_get();
>> +
>> 	/* If the constraints say the regulator should be on at this =
point
>> 	 * and we have control then make sure it is enabled.
>> 	 */
>> @@ -1549,8 +1552,6 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
>>=20
>> 		if (rdev->constraints->always_on)
>> 			rdev->use_count++;
>> -	} else if (rdev->desc->off_on_delay) {
>> -		rdev->last_off =3D ktime_get();
>> 	}
>>=20
>> 	print_constraints(rdev);
>> --=20
>> 2.36.1
>>=20
>>=20
>=20
>=20
>=20
> --=20
> Dr. Christian Kohlsch=C3=BCtter
>=20
>=20
>=20

