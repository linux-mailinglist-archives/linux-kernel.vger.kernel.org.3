Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61E587305
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiHAVXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiHAVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:23:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604B524971
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r128-20020a1c4486000000b003a3a22178beso36372wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=nlr5DiqSwUBzMobFburBin5swGT5jHJIFr6QWOR1Bdw=;
        b=DPPc3TMQDxRe5Hosr+9ffIuhZhS/+cu8qD9qyMdtACp4cl50Z3Zl2NGAeIqyYzqkXU
         KODTVSWmMq6oaGQ5KBaUnkQagdIYAQF/QHQ0KcZoFXG12mCMeYzzKnjSDUcP9i2wLU0K
         BHtcoozKnSTU4zghgDuKOYnx/MfY3yS5v/C2/CM+mSwi9cPcbe15q+llUIAzXLK7Avh+
         z66OmeZ+x4htX5jqipEn1ikoALHFuM8FZ5rKJza+d6HxGeu1amZNh2a6CfOGpcPe6pFk
         t2t4pBGBJKcdIUr1WucS564yh0GAugjn2uH2o79IgvuM21cWzXMkNvSZUHmaWVNUtYdk
         Um6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=nlr5DiqSwUBzMobFburBin5swGT5jHJIFr6QWOR1Bdw=;
        b=vSK/zqPdol97vZv+z9HpCu2FMz8BwzqS3sk6xkpWCJekP8Bssjx4dm7vBVEZTiLBis
         1QlHE0p1pLXBgr8VIHwgBLlQVLgs/vj9v+MkiPVTaYXaMFCqByGmBhrG05RHMx5aSsPk
         cgs0tyt8m0Qqm+GDlInBtSg6gJowVpZgpXtK29Z31WG3Eh4Zb0DG3hb56KqoP5m0gLV3
         rG+l7DSrgFE+D74fhQmZiJwaz7HjO+l1ttynvySc4MjbT3/sHTgdH6d+gtI+n9weMPjt
         CeZuMcdUVS0MsJSW154KxmJqpCUap7t1g+2sdJuMVTw5KrFF6GsiZbPiC975vpkxDvSp
         pdqw==
X-Gm-Message-State: AJIora8u3bREBs70tm91fQRg/u6f3KicPDKITKJh2rwMgNBgYHZBAh+z
        p/VjPCO9oKqiycNBMrWsocNl5g==
X-Google-Smtp-Source: AGRyM1uo6NmBt6J5p+n74GcdRwMpnEONLSPZ8kFgCPJLMPu9bcqyMI1z2wtwgxmBJPsS1uXXa1NE7g==
X-Received: by 2002:a05:600c:218a:b0:3a3:276b:7a17 with SMTP id e10-20020a05600c218a00b003a3276b7a17mr12354188wme.15.1659388979874;
        Mon, 01 Aug 2022 14:22:59 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:22:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com
Subject: [PATCH v4] New thermal OF code
Date:   Mon,  1 Aug 2022 23:22:12 +0200
Message-Id: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes are depending on:

 - 20220722200007.1839356-1-daniel.lezcano@linexp.org

which are present in the thermal/linux-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

The series introduces a new thermal OF code. The patch description gives
a detailed explanation of the changes. Basically we write new OF parsing
functions, we migrate all the users of the old thermal OF API to the new
one and then we finish by removing the old OF code.

That is the second step to rework the thermal OF code. More patches will
come after that to remove the duplication of the trip definitions in the
different drivers which will result in more code duplication removed and
consolidation of the core thermal framework.

Thanks for those who tested the series on their platform and
investigated the regression with the disabled by default thermal zones.

Changelog:
 v4:
   - Fixed a compilation error when THERMAL_OF=n
   - Collected more tags
 v3:
   - Rebased on the right branch as reported by Niklas Söderlund
   - Collected more tags
 v2:
   - Changed the code in the register thermal zone function to prevent
     the 'const' annotation being removed in the different drivers
   - Collected the tags and adding Cc for more context
   - Changed the first line patch description to comply to the 'input'
     subsystem format
   - Give a more detailed description in the changelog for the drivers
   - Remove pointless calls to unregister as the devm version is used
     instead
   - Moved dummy functions from one patch to another to prevent git
     bisecting issue when THERMAL_OF=n
   - Fixed thermal zone disabled by default

Daniel Lezcano (32):
  thermal/of: Rework the thermal device tree initialization
  thermal/of: Make new code and old code co-exist
  thermal/drivers/rockchip: Switch to new of API
  thermal/drivers/uniphier: Switch to new of API
  thermal/drivers/generic-adc: Switch to new of API
  thermal/drivers/mmio: Switch to new of API
  thermal/drivers/tegra: Switch to new of API
  thermal/drivers/sun8i: Switch to new of API
  thermal/drivers/sprd: Switch to new of API
  thermal/drivers/broadcom: Switch to new of API
  thermal/drivers/qcom: Switch to new of API
  thermal/drivers/st: Switch to new of API
  thermal/drivers/amlogic: Switch to new of API
  thermal/drivers/armada: Switch to new of API
  thermal/drivers/db8500: Switch to new of API
  thermal/drivers/imx: Switch to new of API
  thermal/drivers/rcar: Switch to new of API
  thermal/drivers/rzg2l: Switch to new of API
  thermal/drivers/qoriq: Switch to new of API
  thermal/drivers/mtk: Switch to new of API
  thermal/drivers/banggap: Switch to new of API
  thermal/drivers/maxim: Switch to new of API
  thermal/drivers/hisilicon: Switch to new of API
  thermal/drivers/ti-soc: Switch to new of API
  ata/drivers/ahci_imx: Switch to new of thermal API
  hwmon/drivers: Switch to new of thermal API
  iio/drivers/sun4i_gpadc: Switch to new of thermal API
  Input: sun4i-ts - switch to new of thermal API
  regulator/drivers/max8976: Switch to new of thermal API
  thermal/drivers/samsung: Switch to new of thermal API
  thermal/core: Move set_trip_temp ops to the sysfs code
  thermal/of: Remove old OF code

 drivers/ata/ahci_imx.c                        |   15 +-
 drivers/hwmon/hwmon.c                         |   14 +-
 drivers/hwmon/scpi-hwmon.c                    |   14 +-
 drivers/iio/adc/sun4i-gpadc-iio.c             |   12 +-
 drivers/input/touchscreen/sun4i-ts.c          |   10 +-
 drivers/regulator/max8973-regulator.c         |   10 +-
 drivers/thermal/amlogic_thermal.c             |   16 +-
 drivers/thermal/armada_thermal.c              |   12 +-
 drivers/thermal/broadcom/bcm2711_thermal.c    |   14 +-
 drivers/thermal/broadcom/bcm2835_thermal.c    |   14 +-
 drivers/thermal/broadcom/brcmstb_thermal.c    |   20 +-
 drivers/thermal/broadcom/ns-thermal.c         |   50 +-
 drivers/thermal/broadcom/sr-thermal.c         |   16 +-
 drivers/thermal/db8500_thermal.c              |    8 +-
 drivers/thermal/hisi_thermal.c                |   14 +-
 drivers/thermal/imx8mm_thermal.c              |   14 +-
 drivers/thermal/imx_sc_thermal.c              |   14 +-
 drivers/thermal/k3_bandgap.c                  |   12 +-
 drivers/thermal/k3_j72xx_bandgap.c            |   12 +-
 drivers/thermal/max77620_thermal.c            |    8 +-
 drivers/thermal/mtk_thermal.c                 |   10 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   19 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |   12 +-
 drivers/thermal/qcom/tsens.c                  |   16 +-
 drivers/thermal/qoriq_thermal.c               |   12 +-
 drivers/thermal/rcar_gen3_thermal.c           |   16 +-
 drivers/thermal/rcar_thermal.c                |   13 +-
 drivers/thermal/rockchip_thermal.c            |   14 +-
 drivers/thermal/rzg2l_thermal.c               |   10 +-
 drivers/thermal/samsung/exynos_tmu.c          |   24 +-
 drivers/thermal/sprd_thermal.c                |   18 +-
 drivers/thermal/st/stm_thermal.c              |   16 +-
 drivers/thermal/sun8i_thermal.c               |   14 +-
 drivers/thermal/tegra/soctherm.c              |   21 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c    |   19 +-
 drivers/thermal/tegra/tegra30-tsensor.c       |   12 +-
 drivers/thermal/thermal-generic-adc.c         |   10 +-
 drivers/thermal/thermal_core.c                |    6 -
 drivers/thermal/thermal_core.h                |    2 -
 drivers/thermal/thermal_mmio.c                |   17 +-
 drivers/thermal/thermal_of.c                  | 1140 ++++++-----------
 drivers/thermal/thermal_sysfs.c               |    5 +-
 .../ti-soc-thermal/ti-thermal-common.c        |   16 +-
 drivers/thermal/uniphier_thermal.c            |   10 +-
 include/linux/thermal.h                       |   85 +-
 45 files changed, 703 insertions(+), 1133 deletions(-)

-- 
2.25.1

