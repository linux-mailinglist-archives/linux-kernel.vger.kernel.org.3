Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68075596C83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiHQKBo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Aug 2022 06:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiHQKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:01:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB457C32F;
        Wed, 17 Aug 2022 03:01:38 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oOFrW-0001ZB-2Q; Wed, 17 Aug 2022 12:01:22 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 2/4] regulator: sun20i: Add support for Allwinner D1 LDOs
Date:   Wed, 17 Aug 2022 12:01:21 +0200
Message-ID: <5212752.LvFx2qVVIh@diego>
In-Reply-To: <1c172085-9586-b612-8600-776e8a394f12@sholland.org>
References: <20220815043436.20170-1-samuel@sholland.org> <37742446.J2Yia2DhmK@diego> <1c172085-9586-b612-8600-776e8a394f12@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 17. August 2022, 10:28:40 CEST schrieb Samuel Holland:
> On 8/15/22 12:00 PM, Heiko Stübner wrote:
> > Am Montag, 15. August 2022, 06:34:33 CEST schrieb Samuel Holland:
> >> D1 contains two pairs of LDOs. Since they have similar bindings, and
> >> they always exist together, put them in a single driver.
> >>
> >> The analog LDOs are relatively boring, with a single linear range. Their
> >> one quirk is that a bandgap reference must be calibrated for them to
> >> produce the correct voltage.
> >>
> >> The system LDOs have the complication that their voltage step is not an
> >> integer, so a custom .list_voltage is needed to get the rounding right.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>
> >> Changes in v3:
> >>  - Adjust control flow in sun20i_regulator_get_regmap() for clarity
> >>
> >> Changes in v2:
> >>  - Use decimal numbers for .n_voltages instead of field widths
> >>  - Get the regmap from the parent device instead of a property/phandle
> >>
> >>  drivers/regulator/Kconfig            |   8 +
> >>  drivers/regulator/Makefile           |   1 +
> >>  drivers/regulator/sun20i-regulator.c | 232 +++++++++++++++++++++++++++
> >>  3 files changed, 241 insertions(+)
> >>  create mode 100644 drivers/regulator/sun20i-regulator.c
> >>
> >> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> >> index 23e3e4a35cc9..0c5727173fa0 100644
> >> --- a/drivers/regulator/Kconfig
> >> +++ b/drivers/regulator/Kconfig
> >> @@ -1262,6 +1262,14 @@ config REGULATOR_STW481X_VMMC
> >>  	  This driver supports the internal VMMC regulator in the STw481x
> >>  	  PMIC chips.
> >>  
> >> +config REGULATOR_SUN20I
> >> +	tristate "Allwinner D1 internal LDOs"
> >> +	depends on ARCH_SUNXI || COMPILE_TEST
> >> +	depends on MFD_SYSCON && NVMEM
> >> +	default ARCH_SUNXI
> >> +	help
> >> +	  This driver supports the internal LDOs in the Allwinner D1 SoC.
> >> +
> >>  config REGULATOR_SY7636A
> >>  	tristate "Silergy SY7636A voltage regulator"
> >>  	help
> >> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> >> index fa49bb6cc544..5dff112eb015 100644
> >> --- a/drivers/regulator/Makefile
> >> +++ b/drivers/regulator/Makefile
> >> @@ -148,6 +148,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
> >>  obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
> >>  obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
> >>  obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
> >> +obj-$(CONFIG_REGULATOR_SUN20I) += sun20i-regulator.o
> >>  obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
> >>  obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
> >>  obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
> >> diff --git a/drivers/regulator/sun20i-regulator.c b/drivers/regulator/sun20i-regulator.c
> >> new file mode 100644
> >> index 000000000000..46f3927d7d10
> >> --- /dev/null
> >> +++ b/drivers/regulator/sun20i-regulator.c
> >> @@ -0,0 +1,232 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +//
> >> +// Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
> >> +//
> > 
> > nit: shouldn't the comment look like
> > /*
> >  * Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
> >  */
> 
> I have had multiple requests from maintainers to use the former style because it
> is more visually consistent. `git grep '^// Copy' drivers sound` returns over
> 1500 hits. But it doesn't really matter to me.

ok ... I guess that is something that's changing then :-)

I just looked into some drivers and the coding-style rst document, but I
guess it's the maintainer's call how this should look.


