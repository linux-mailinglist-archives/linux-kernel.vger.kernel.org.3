Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F35841E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiG1Oky convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jul 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiG1Ok2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:40:28 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D91EAF6;
        Thu, 28 Jul 2022 07:38:23 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id e127so2819313yba.12;
        Thu, 28 Jul 2022 07:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=k45jpSrW5er3yuZp9JhSAKvAe/Lx7ZG0RRR4+n2dOdw=;
        b=61FzNlsiAhEctIGjK1yQ9CU3LdzPRM4BBhgazoSc96pZvLmqUufMyc1WI6BkNPnaUD
         bJ9hT9O0O1lXiwfVLOYqFsF/kSZ27LRsMcJL5CuKkEGUr5nCYxekG9IOzU/qtljPbvvG
         1YlzyOiTUM2erhNIbSJOVaUcQgaewDKbagceyfCcWiMCM+0nOASOdQsJj2HQivzwS9+6
         SH+4U5WNn3tmh0lzCeuBtaRfF5N3o16x/u8PDKD50TPJ8W8pmY8BsdT1zBch5bTvI1jZ
         WoKjQzJYHjOPV0qY7kOnwnh/6rPwMkQG8WNLr188C6hNqBpj+I2qh36M8nZwb8Qo7FHm
         /8ew==
X-Gm-Message-State: AJIora9is3Yrism7g0Idup4koBn07+I6h7wxHfaMttukbG3OQMyvnU7y
        x9gBnR1Q6YIH6pl3HHMFqiXAYdj1yDxJp5vgoBk=
X-Google-Smtp-Source: AGRyM1s/C/zdXog5p3pQHtr/CDWwPlqnkIBgbBfNxbkFWmaWqxfHB529s1Nj4YOYbqc8znCQAwv40lTdK4yd9M0ixgg=
X-Received: by 2002:a25:828f:0:b0:670:22f9:f7eb with SMTP id
 r15-20020a25828f000000b0067022f9f7ebmr21965352ybk.137.1659019084081; Thu, 28
 Jul 2022 07:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org> <35457e1c-fe6b-2212-9624-70369f04ef0d@linaro.org>
In-Reply-To: <35457e1c-fe6b-2212-9624-70369f04ef0d@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Jul 2022 16:37:50 +0200
Message-ID: <CAJZ5v0g5gtQGyLM2C+D5-Y-T_7+GHp4=Ptt7Reh6xgL-D77asQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/32] New thermal OF code
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Mark Brown <broonie@kernel.org>,
        damien.lemoal@opensource.wdc.com, Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        mhiramat@kernel.org, Talel Shenhar <talel@amazon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, anarsoul@gmail.com,
        Yangtao Li <tiny.windzz@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        glaroque@baylibre.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Keerthy <j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Jul 27, 2022 at 11:46 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> we are close to release v5.19.
>
> I want to send a PR this week but it would be nice if this series could
> be part of it, so the trip point rework we discussed earlier (it is a
> long series) could be merged more easily for v5.21-rc1 as it will depend
> on these changes.
>
> This series was tested on different platforms, rk3399, broadcom and
> rcar. The external drivers as ata, touchscreen, regulator, hwmon were
> acked/reviewed and some other thermal drivers reviewed also. Some others
> remain without feedback because the maintainer is unresponsive or the
> driver is orphaned, falling under the thermal framework maintenance
> umbrella. All the drivers changes are the same.
>
> I do believe it does a nice cleanup and consolidation of the OF thermal
> code and realign it with the core thermal framework.
>
> Is it ok to merge the series?

I would prefer to put it into linux-next for a few days.

Why don't you send 2 pull requests, one with all of the other material
you have for 5.20 and another one with this series (it may be on top
of the first one)?

I will be able to defer pushing the second one till the second half of
the merge window.


> On 27/07/2022 23:02, Daniel Lezcano wrote:
> > The following changes are depending on:
> >
> >   - 20220722200007.1839356-1-daniel.lezcano@linexp.org
> >
> > which are present in the thermal/linux-next branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
> >
> > The series introduces a new thermal OF code. The patch description gives
> > a detailed explanation of the changes. Basically we write new OF parsing
> > functions, we migrate all the users of the old thermal OF API to the new
> > one and then we finish by removing the old OF code.
> >
> > That is the second step to rework the thermal OF code. More patches will
> > come after that to remove the duplication of the trip definitions in the
> > different drivers which will result in more code duplication removed and
> > consolidation of the core thermal framework.
> >
> > Thanks for those who tested the series on their platform and
> > investigated the regression with the disabled by default thermal zones.
> >
> > Changelog:
> >   v3:
> >     - Rebased on the right branch as reported by Niklas Söderlund
> >     - Collected more tags
> >   v2:
> >     - Changed the code in the register thermal zone function to prevent
> >       the 'const' annotation being removed in the different drivers
> >     - Collected the tags and adding Cc for more context
> >     - Changed the first line patch description to comply to the 'input'
> >       subsystem format
> >     - Give a more detailed description in the changelog for the drivers
> >     - Remove pointless calls to unregister as the devm version is used
> >       instead
> >     - Moved dummy functions from one patch to another to prevent git
> >       bisecting issue when THERMAL_OF=n
> >     - Fixed thermal zone disabled by default
> >
> > Daniel Lezcano (32):
> >    thermal/of: Rework the thermal device tree initialization
> >    thermal/of: Make new code and old code co-exist
> >    thermal/drivers/rockchip: Switch to new of API
> >    thermal/drivers/uniphier: Switch to new of API
> >    thermal/drivers/generic-adc: Switch to new of API
> >    thermal/drivers/mmio: Switch to new of API
> >    thermal/drivers/tegra: Switch to new of API
> >    thermal/drivers/sun8i: Switch to new of API
> >    thermal/drivers/sprd: Switch to new of API
> >    thermal/drivers/broadcom: Switch to new of API
> >    thermal/drivers/qcom: Switch to new of API
> >    thermal/drivers/st: Switch to new of API
> >    thermal/drivers/amlogic: Switch to new of API
> >    thermal/drivers/armada: Switch to new of API
> >    thermal/drivers/db8500: Switch to new of API
> >    thermal/drivers/imx: Switch to new of API
> >    thermal/drivers/rcar: Switch to new of API
> >    thermal/drivers/rzg2l: Switch to new of API
> >    thermal/drivers/qoriq: Switch to new of API
> >    thermal/drivers/mtk: Switch to new of API
> >    thermal/drivers/banggap: Switch to new of API
> >    thermal/drivers/maxim: Switch to new of API
> >    thermal/drivers/hisilicon: Switch to new of API
> >    thermal/drivers/ti-soc: Switch to new of API
> >    ata/drivers/ahci_imx: Switch to new of thermal API
> >    hwmon/drivers: Switch to new of thermal API
> >    iio/drivers/sun4i_gpadc: Switch to new of thermal API
> >    Input: sun4i-ts - switch to new of thermal API
> >    regulator/drivers/max8976: Switch to new of thermal API
> >    thermal/drivers/samsung: Switch to new of thermal API
> >    thermal/core: Move set_trip_temp ops to the sysfs code
> >    thermal/of: Remove old OF code
> >
> >   drivers/ata/ahci_imx.c                        |   15 +-
> >   drivers/hwmon/hwmon.c                         |   14 +-
> >   drivers/hwmon/scpi-hwmon.c                    |   14 +-
> >   drivers/iio/adc/sun4i-gpadc-iio.c             |   12 +-
> >   drivers/input/touchscreen/sun4i-ts.c          |   10 +-
> >   drivers/regulator/max8973-regulator.c         |   10 +-
> >   drivers/thermal/amlogic_thermal.c             |   16 +-
> >   drivers/thermal/armada_thermal.c              |   12 +-
> >   drivers/thermal/broadcom/bcm2711_thermal.c    |   14 +-
> >   drivers/thermal/broadcom/bcm2835_thermal.c    |   14 +-
> >   drivers/thermal/broadcom/brcmstb_thermal.c    |   20 +-
> >   drivers/thermal/broadcom/ns-thermal.c         |   50 +-
> >   drivers/thermal/broadcom/sr-thermal.c         |   16 +-
> >   drivers/thermal/db8500_thermal.c              |    8 +-
> >   drivers/thermal/hisi_thermal.c                |   14 +-
> >   drivers/thermal/imx8mm_thermal.c              |   14 +-
> >   drivers/thermal/imx_sc_thermal.c              |   14 +-
> >   drivers/thermal/k3_bandgap.c                  |   12 +-
> >   drivers/thermal/k3_j72xx_bandgap.c            |   12 +-
> >   drivers/thermal/max77620_thermal.c            |    8 +-
> >   drivers/thermal/mtk_thermal.c                 |   10 +-
> >   drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   19 +-
> >   drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |   12 +-
> >   drivers/thermal/qcom/tsens.c                  |   16 +-
> >   drivers/thermal/qoriq_thermal.c               |   12 +-
> >   drivers/thermal/rcar_gen3_thermal.c           |   16 +-
> >   drivers/thermal/rcar_thermal.c                |   13 +-
> >   drivers/thermal/rockchip_thermal.c            |   14 +-
> >   drivers/thermal/rzg2l_thermal.c               |   10 +-
> >   drivers/thermal/samsung/exynos_tmu.c          |   24 +-
> >   drivers/thermal/sprd_thermal.c                |   18 +-
> >   drivers/thermal/st/stm_thermal.c              |   16 +-
> >   drivers/thermal/sun8i_thermal.c               |   14 +-
> >   drivers/thermal/tegra/soctherm.c              |   21 +-
> >   drivers/thermal/tegra/tegra-bpmp-thermal.c    |   19 +-
> >   drivers/thermal/tegra/tegra30-tsensor.c       |   12 +-
> >   drivers/thermal/thermal-generic-adc.c         |   10 +-
> >   drivers/thermal/thermal_core.c                |    6 -
> >   drivers/thermal/thermal_core.h                |    2 -
> >   drivers/thermal/thermal_mmio.c                |   17 +-
> >   drivers/thermal/thermal_of.c                  | 1140 ++++++-----------
> >   drivers/thermal/thermal_sysfs.c               |    5 +-
> >   .../ti-soc-thermal/ti-thermal-common.c        |   16 +-
> >   drivers/thermal/uniphier_thermal.c            |   10 +-
> >   include/linux/thermal.h                       |   89 +-
> >   45 files changed, 709 insertions(+), 1131 deletions(-)
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
