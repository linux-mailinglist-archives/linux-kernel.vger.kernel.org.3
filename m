Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32230550A07
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiFSLIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiFSLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:08:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33308DEC8;
        Sun, 19 Jun 2022 04:08:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0F961028;
        Sun, 19 Jun 2022 11:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D8FC34114;
        Sun, 19 Jun 2022 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655636909;
        bh=ppU4IV4ruC5TwuyCf8TpWzcaTFcnjt9ppKTnTsjRMu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X0yjXgKI7640P/jvlI67KMiZbIdwPKxxuhLqam+dauwFP5qsVrfFylVkcARd/P8mH
         GBk8xwpKWk/72SekB0+nuCloj1DqazltHMkF+DE/DPZ1YlrSb4aLbQZGHqeaenztJP
         AeRL3fhFnkvmXr7k88xI8noeQk/3uWwMVjVf+Sp9OnuPOp3LKWVhLUWsGEb9X55IA9
         b+nKgwCzTSGohlm8yM3hneIHYM7UT2r2mQBQBhOFYXVA3JeXZBH3RmopjovaasTxNq
         H+2KsdtKU7VqAaCF+V6z5tIWUGmfZot5037cDbgFQ1TiFivBuRbsv4v3EMB9wWJBjO
         7djr7qmjcno2g==
Date:   Sun, 19 Jun 2022 12:17:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "wens@csie.org" <wens@csie.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "quic_gurus@quicinc.com" <quic_gurus@quicinc.com>,
        "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 00/16] Add support for AXP192 PMIC
Message-ID: <20220619121743.2b259153@jic23-huawei>
In-Reply-To: <CAHp75VfrzQFq4u0vMtPM7LRYNcQQC-padQ1yyFijbpWx8_LwBQ@mail.gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
        <CAHp75VfrzQFq4u0vMtPM7LRYNcQQC-padQ1yyFijbpWx8_LwBQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 00:43:07 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Saturday, June 18, 2022, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> wrote:
> 
> > Changes in v3:
> >
> > * Update pinctrl driver to address Andy Shevchenko's review comments
> >   from v1, and fix a few other  
> 
> 
> I believe I gave more comments than just against pin control driver. Even
> though, some comments are still not addressed in the series, including pin
> control. Am I mistaken?

Hi Andy,

Maybe, it's a question of clarity/misunderstanding? You had some 'global' comments
at the end of the pinctrl review. Perhaps not clear enough you meant
they should apply to the rest of the patch series (and more generally to
the driver being modified I think).

Just guessing!

Jonathan

> 
> 
> > * Add gpio-ranges property and example snippet to gpio DT bindings.
> > * Update commit message of patch 01/16 to point out that all register
> >   addresses are obtained using sub_irq_reg().
> > * Document ccc_table in axp20x_battery. Also update commit message to
> >   note a small fix that is part of that patch.
> > * Drop axp20x_adc consolidation patch in favor of using separate adc_raw
> >   functions. It's a minor code size optimization that may not be worth
> >   the effort due to implementation complexity.
> > * Use the FIELD_GET macro in axp20x_adc to further clarify intent.
> > * Fix a typo in the regulator driver where an AXP20X regulator ID was
> >   mistakenly used instead of an AXP192 regulator ID. Also carry over
> >   an Acked-by: tag from v1. Hope that's okay.
> > * Accumulate Acked-by: tags from v1 on DT patches.
> > * Accumulate Acked-by: tags from v2.
> >
> > Note that regmap maintainer Mark Brown has said the first two patches to
> > regmap-irq aren't suitable for inclusion into the kernel in their current
> > state. I'm including them for v3 so the series remains testable.
> >
> > Changes in v2:
> >
> > * Do a little cleanup of axp20x_adc suggested by Jonathan Cameron
> > * Consolidate ADC read functions in axp20x_adc
> > * Drop the axp192's read_label callback in axp20x_adc
> > * Clean up the axp192-gpio dt bindings
> > * Rewrite a problematic bit of code in axp20x_usb_power reported
> >   by kernel test robot
> > * Support AXP192 in axp20x_battery
> > * Split up regmap-irq changes to two separate patches
> >
> > Cover letter from v1:
> >
> > Hi all,
> >
> > This patch series adds support for the X-Powers AXP192 PMIC to the
> > AXP20x driver framework.
> >
> > The first patch is a small change to regmap-irq to support the AXP192's
> > unusual IRQ register layout. It isn't possible to include all of the
> > IRQ registers in one regmap-irq chip without this.
> >
> > The rest of the changes are pretty straightforward, I think the only
> > notable parts are the axp20x_adc driver where there seems to be some
> > opportunities for code reuse (the axp192 is nearly a duplicate of the
> > axp20x) and the addition of a new pinctrl driver for the axp192, since
> > the axp20x pinctrl driver was not very easy to adapt.
> >
> > Aidan MacDonald (16):
> >   regmap-irq: Use sub_irq_reg() to calculate unmask register address
> >   regmap-irq: Add get_irq_reg to support unusual register layouts
> >   dt-bindings: mfd: add bindings for AXP192 MFD device
> >   dt-bindings: iio: adc: axp209: Add AXP192 compatible
> >   dt-bindings: power: supply: axp20x: Add AXP192 compatible
> >   dt-bindings: gpio: Add AXP192 GPIO bindings
> >   dt-bindings: power: axp20x-battery: Add AXP192 compatible
> >   mfd: axp20x: Add support for AXP192
> >   regulator: axp20x: Add support for AXP192
> >   iio: adc: axp20x_adc: Minor code cleanups
> >   iio: adc: axp20x_adc: Add support for AXP192
> >   power: supply: axp20x_usb_power: Add support for AXP192
> >   pinctrl: Add AXP192 pin control driver
> >   power: axp20x_battery: Add constant charge current table
> >   power: axp20x_battery: Support battery status without fuel gauge
> >   power: axp20x_battery: Add support for AXP192
> >
> >  .../bindings/gpio/x-powers,axp192-gpio.yaml   |  68 +++
> >  .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
> >  .../bindings/mfd/x-powers,axp152.yaml         |   1 +
> >  .../x-powers,axp20x-battery-power-supply.yaml |   1 +
> >  .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
> >  drivers/base/regmap/regmap-irq.c              |  19 +-
> >  drivers/iio/adc/axp20x_adc.c                  | 359 +++++++++--
> >  drivers/mfd/axp20x-i2c.c                      |   2 +
> >  drivers/mfd/axp20x.c                          | 153 +++++
> >  drivers/pinctrl/Kconfig                       |  14 +
> >  drivers/pinctrl/Makefile                      |   1 +
> >  drivers/pinctrl/pinctrl-axp192.c              | 562 ++++++++++++++++++
> >  drivers/power/supply/axp20x_battery.c         | 143 ++++-
> >  drivers/power/supply/axp20x_usb_power.c       |  80 ++-
> >  drivers/regulator/axp20x-regulator.c          | 101 +++-
> >  include/linux/mfd/axp20x.h                    |  84 +++
> >  include/linux/regmap.h                        |   5 +
> >  17 files changed, 1529 insertions(+), 83 deletions(-)
> >  create mode 100644 Documentation/devicetree/
> > bindings/gpio/x-powers,axp192-gpio.yaml
> >  create mode 100644 drivers/pinctrl/pinctrl-axp192.c
> >
> > --
> > 2.35.1
> >
> >  
> 

