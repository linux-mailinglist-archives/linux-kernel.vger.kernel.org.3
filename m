Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C728E58067D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiGYV0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbiGYV0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:26:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010832315A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:26:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso4429136wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSTDZhNWu94fb7Dl5Y72bWhB6a1jNF2UJdjaWf10fts=;
        b=Pw0G43QyErozbi9UHmoSWLnIHg92Zt/OLZ4S1plD/E9y6XWr3oDt4UVpNP6XZvfxKA
         0dXc3JN8N50E4KFsBTQ7Luc1dcecejExnyU+AhSu9eVg95Bd3jd7HbV+vVuTmrzDJ+iO
         Q3ct5SwRBKPD5cA8ucAZOVggb8rmDoFcgjPF9oGA/wuJSG3OKXMOpCLQPU+S5I7UZTyy
         l8ykkGhYQY70upJ7fS9uiTPyJJGYemE6khCg0DBkvfH+Q4ZT/d0OXC+SY4Rr8trGdTCY
         sj0ojxkI0v0TZkTFF7QuztU5+wY4rRM3ZzuFUUK1uwvapC/vF5hAndw9bpymXz5sJUqL
         FVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSTDZhNWu94fb7Dl5Y72bWhB6a1jNF2UJdjaWf10fts=;
        b=jpkHybB/liFTb0JxiaTlKiHbJR/CRyfM5TiMRlNjsNkyoZrRjrbL89G9RggAbGdrmZ
         BwP2BgZqQx2rgmRhSI1KnKuB/IJFLP/4iB7h/oOoalLqaTZgZwui8SDi3/2ZJu0hG5+D
         T5IGNuICo7L7atS2EY0tupUCvJRrvVcZJh9044sVYXw/5hH+b0wbP+I0bAtNb7XAbljU
         gh6QmfS16joINt5nmpc2FEXd2kq+pihjKFNbKBDO8WtCLJ89k3wCxDvBdsclUxiksMcW
         cCielDuCvIrSXpdCYi5SRmdT0J58vulCuiZHU+QcjmbbyJS/S/AJlXNOrli+MabRdjtT
         ZEXA==
X-Gm-Message-State: AJIora/tqBypNPL3d49PTH8w3MF1gPNlaWYMe5uy+H/9X+IzWxg37aui
        PUER8NYYzFUaLUIf9KQwzmowAQ==
X-Google-Smtp-Source: AGRyM1urbOVv5MziOD8ZSt275KMb2E2uBKmNBQ12CZRvzfhAHLLnDMnFKfzn5FMxXg1StKHnGCGc8Q==
X-Received: by 2002:a1c:2783:0:b0:3a2:fd82:bf46 with SMTP id n125-20020a1c2783000000b003a2fd82bf46mr22259312wmn.29.1658784410340;
        Mon, 25 Jul 2022 14:26:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:26:49 -0700 (PDT)
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
Subject: [PATCH v2 00/32] New thermal OF code
Date:   Mon, 25 Jul 2022 23:26:05 +0200
Message-Id: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
 drivers/thermal/db8500_thermal.c              |   12 +-
 drivers/thermal/hisi_thermal.c                |   14 +-
 drivers/thermal/imx8mm_thermal.c              |   14 +-
 drivers/thermal/imx_sc_thermal.c              |   14 +-
 drivers/thermal/k3_bandgap.c                  |   12 +-
 drivers/thermal/k3_j72xx_bandgap.c            |   12 +-
 drivers/thermal/max77620_thermal.c            |    8 +-
 drivers/thermal/mtk_thermal.c                 |   10 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   19 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |   12 +-
 drivers/thermal/qcom/tsens.c                  |   20 +-
 drivers/thermal/qoriq_thermal.c               |   12 +-
 drivers/thermal/rcar_gen3_thermal.c           |   16 +-
 drivers/thermal/rcar_thermal.c                |   13 +-
 drivers/thermal/rockchip_thermal.c            |   14 +-
 drivers/thermal/rzg2l_thermal.c               |   10 +-
 drivers/thermal/samsung/exynos_tmu.c          |   24 +-
 drivers/thermal/sprd_thermal.c                |   18 +-
 drivers/thermal/st/stm_thermal.c              |   16 +-
 drivers/thermal/sun8i_thermal.c               |   14 +-
 drivers/thermal/tegra/soctherm.c              |   27 +-
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
 include/linux/thermal.h                       |   89 +-
 45 files changed, 715 insertions(+), 1139 deletions(-)

-- 
2.25.1

