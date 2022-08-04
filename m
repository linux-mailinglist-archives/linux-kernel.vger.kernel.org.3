Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE3F58A36B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiHDWv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHDWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:51:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9DE31238
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:51:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so1370966wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pznRh7mSZnRSGOsJjKLdAY7waBRS/asCiUcfzryOWi0=;
        b=0ebtnK/y24MmBsXTmBaxlpeTrQb9Xeuc98Q4ZuIFGK0LAQNxjJeDYG8k7e/RRLF6pC
         E7r2FianE7MBL3q9LwyTsDnRtDqkrfI563ODr6oiy9AlouokuCH9J3vlTPc4poO/1oia
         amJTk6uY4+kunwOCRELBa5s9GdiQrXDu3l2zmvVqXMwKRe+fA8pSS41Vj1v394J5u9jz
         7GHTZxRxX54ltsTHaZwtu3cfXEz8gFqJKM7hJypVyJnyNmH7spGSHtx8W/wcyJK/nrLM
         uyMPIs5E7HqjcY8uU8TQPO8eCk2iIaYzyFYghNfzDaHXyYOCk5KtlElMHWYw0luAnLsS
         bg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pznRh7mSZnRSGOsJjKLdAY7waBRS/asCiUcfzryOWi0=;
        b=FVKuklrmsGwWqHNU3DgwYZr5LBlMTOzHigKTlbcJ0yxVUV1+y9+0nFWQvpO7PnNtUP
         FsUpX8Sqni4MSu3zVRTIDohYTjSWLPdGCNC1EJ52COnkF9LDMaZlhHcUYdBUmqWME+4u
         3p6hRSLt1xfgTO0HlQUPF0O/4EvJN8pMWJoFL9V0YUMvk6oaiuAVKJAT1Q0jmw0sFIXI
         suA13lhGkbbe0zB98LwL50gqwLdqKEka6hSnvfYP1bU5trff5HKD2r66yDvnZlek0Sui
         d8oGPZR6se6coEBAAEnMV9OwrJb++IoVTz6NFt7UR0x7hZOf4OYeD+DIOXBAcWB4Har2
         Vg3A==
X-Gm-Message-State: ACgBeo2nGaaH6o24SfaWs+7609ceboqygD2UELTuzdjLGZ69ykqibTRQ
        vMMW4T2wmEl1sdvuNXGKwRJSRA==
X-Google-Smtp-Source: AA6agR6xlUrCJZRalcLrOlbeA+kMgLim+vxdzaOp3Np77E5iu6trJdNx7e2SaIRCrcLZLbpJxZAV0Q==
X-Received: by 2002:a5d:548d:0:b0:21e:e704:94e4 with SMTP id h13-20020a5d548d000000b0021ee70494e4mr2470875wrv.87.1659653510622;
        Thu, 04 Aug 2022 15:51:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:51:50 -0700 (PDT)
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
Subject: [PATCH v5 00/33] New thermal OF code
Date:   Fri,  5 Aug 2022 00:43:16 +0200
Message-Id: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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
 v5:
   - Fixed st, exynos_tmu and adc iio sun4i compilation issue when
     THERMAL_EMULATION or THERMAL_OF are not set
   - Add the pmbus_core.c API conversion which was missing
   - Collected more tags
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


Daniel Lezcano (33):
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
  hwmon/drivers/pm_bus: Switch to new of thermal API
  hwmon/drivers/core: Switch to new of thermal API
  iio/drivers/sun4i_gpadc: Switch to new of thermal API
  Input: sun4i-ts - switch to new of thermal API
  regulator/drivers/max8976: Switch to new of thermal API
  thermal/drivers/samsung: Switch to new of thermal API
  thermal/core: Move set_trip_temp ops to the sysfs code
  thermal/of: Remove old OF code

 drivers/ata/ahci_imx.c                        |   15 +-
 drivers/hwmon/hwmon.c                         |   14 +-
 drivers/hwmon/pmbus/pmbus_core.c              |   10 +-
 drivers/hwmon/scpi-hwmon.c                    |   14 +-
 drivers/iio/adc/sun4i-gpadc-iio.c             |   14 +-
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
 drivers/thermal/st/stm_thermal.c              |   18 +-
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
 46 files changed, 708 insertions(+), 1142 deletions(-)

-- 
2.25.1

