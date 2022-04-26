Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C53510BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355674AbiDZWSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiDZWSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:18:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9BB289A8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u9-20020a05600c00c900b00393e729e655so167562wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yy7WWv+wo0N+N8WMs6A4Tlr4aeP0/wiZ8RqZd5hVwfs=;
        b=F2+JGo/wJF1EjVyDmctuLU061kYEMD2S7WtwDPO2wsKkjLHekoih0n6fi1adLvK0il
         5fAJH+B2CpCxnFx4A+AnVJDbZrf1c6pEaav0la3KsQcLBUpmiVIpbr6ASRF3ZgBVLw8p
         9BagWguYajSUsQeEZelJdy/BaBIn8m7dlCI7hz4+eIU/FTG8996GG2oiQCCLRV8aHd8E
         62C3NIKTPmiTJElWBC1jamIZv+CceSNC+YF4DaafdBeSxv4Xe6TrBG++N8cBDoQhSVTg
         kEjdMJJ4tUfbBy4nRcYo2EDkMKIX5kx/N9XGoyADbpuYjyZuWse7gEcpM4AeYe/GHHpX
         RhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yy7WWv+wo0N+N8WMs6A4Tlr4aeP0/wiZ8RqZd5hVwfs=;
        b=WLgzXWZQ03QuRZK1Xc/9wITvz+OxA78QMBBNv04nJ/N0R4hJcapXtotAmVC0Dkvpcm
         yidFbYIiuStRze5+Lwc+Xp944FAUeBQnuhd+uHrqDsnAj/HarUhMbxMd3NdqRgh+0D1K
         AdFV62sBQvKhnSSN/petnDhxQ3yFOgOr9OW9w5RPG3uO5dkYk6MC8nawTQBC7BH3Dtcb
         alR+ns7T3879qhzQgzX2TsZbDfchS1vlDTcT7xREQRREpAg1nDyI5o2umPuLYsxjEsmZ
         mbGO2dDP+YxUszdiuDyGT56RCoXH5mcY67TbTlp2s3ORApIooqxd71DiWaNqSXs4MMu8
         MLQQ==
X-Gm-Message-State: AOAM531uT54DCpEgcyb9zSD61GdYCuoEKzVHzgYLqEeLtttsujL+g2qQ
        v/r14A06uXfKdVHkUSehEBKvcQ==
X-Google-Smtp-Source: ABdhPJzpAwqgNJfBy4dQzMSc05Coc/72uF8qk2nF5I0kDHLYNIcxipbS5oxJsKFhBiueWbDuLYsaUA==
X-Received: by 2002:a05:600c:600c:b0:38e:cb2f:318b with SMTP id az12-20020a05600c600c00b0038ecb2f318bmr23074902wmb.121.1651011335140;
        Tue, 26 Apr 2022 15:15:35 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] thermal OF rework
Date:   Wed, 27 Apr 2022 00:15:08 +0200
Message-Id: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
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

The thermal framework initialization with the device tree appears to
be complicated and hard to make it to evolve.

It contains duplication of almost the same thermal generic structures
and has an assymetric initialization making hard any kind of serious
changes for more complex features. One of them is the multiple sensors
support per thermal zone.

In order to set the scene for the aforementioned feature with generic
code, we need to cleanup and rework the device tree initialization.

However this rework is not obvious because of the multiple components
entering in the composition of a thermal zone and being initialized at
different moments. For instance, a cooling device can be initialized
before a sensor, so the thermal zones must exist before the cooling
device as well as the sensor. This asynchonous initialization forces
the thermal zone to be created with fake ops because they are
mandotory and build a list of cooling devices which is used to lookup
afterwards when the cooling device driver is registering itself.

Actually, the correct behavior IMHO, would be having a sensor
registration resulting in the thermal zone creation. If the cooling
device is registered before, it won't find the thermal zone and should
return -EPROBE_DEFER.

As there could be a large number of changes, this first series provide
some steps forward for a simpler device tree initialization.

The first patch could appear scary as it touches a big number of files
but it is actually just renaming a structure name

Daniel Lezcano (15):
  thermal/core: Rename thermal_zone_device to thermal_zone
  thermal/core: Change thermal_zone_ops to thermal_sensor_ops
  thermal/core: Add a thermal sensor structure in the thermal zone
  thermal/core: Remove duplicate information when an error occurs
  thermal/of: Replace device node match with device node search
  thermal/of: Remove the device node pointer for thermal_trip
  thermal/of: Move thermal_trip structure to thermal.h
  thermal/core: Remove unneeded EXPORT_SYMBOLS
  thermal/core: Move thermal_set_delay_jiffies to static
  thermal/core: Rename trips to ntrips
  thermal/core: Add thermal_trip in thermal_zone
  thermal/core: Register with the trip points
  thermal/of: Store the trips in the thermal zone
  thermal/of: Use thermal trips stored in the thermal zone
  thermal/of: Initialize trip points separately

 .../driver-api/thermal/power_allocator.rst    |  10 +-
 .../driver-api/thermal/sysfs-api.rst          |  28 +-
 drivers/acpi/thermal.c                        |  46 +--
 drivers/gpu/drm/tiny/repaper.c                |   2 +-
 drivers/hwmon/hwmon.c                         |   6 +-
 drivers/hwmon/scpi-hwmon.c                    |   2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c             |   2 +-
 drivers/input/touchscreen/sun4i-ts.c          |   2 +-
 drivers/mmc/host/sdhci-omap.c                 |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_thermal.c    |  16 +-
 .../ethernet/mellanox/mlxsw/core_thermal.c    |  78 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  20 +-
 drivers/platform/x86/acerhdf.c                |  30 +-
 drivers/platform/x86/gpd-pocket-fan.c         |   4 +-
 drivers/power/supply/power_supply_core.c      |  12 +-
 drivers/regulator/max8973-regulator.c         |   6 +-
 drivers/thermal/amlogic_thermal.c             |   2 +-
 drivers/thermal/armada_thermal.c              |  24 +-
 drivers/thermal/broadcom/bcm2711_thermal.c    |   4 +-
 drivers/thermal/broadcom/bcm2835_thermal.c    |   8 +-
 drivers/thermal/broadcom/brcmstb_thermal.c    |   6 +-
 drivers/thermal/broadcom/ns-thermal.c         |   2 +-
 drivers/thermal/broadcom/sr-thermal.c         |   2 +-
 drivers/thermal/da9062-thermal.c              |  22 +-
 drivers/thermal/db8500_thermal.c              |   6 +-
 drivers/thermal/dove_thermal.c                |  16 +-
 drivers/thermal/gov_bang_bang.c               |  12 +-
 drivers/thermal/gov_fair_share.c              |  18 +-
 drivers/thermal/gov_power_allocator.c         |  44 +--
 drivers/thermal/gov_step_wise.c               |  12 +-
 drivers/thermal/gov_user_space.c              |   6 +-
 drivers/thermal/hisi_thermal.c                |  10 +-
 drivers/thermal/imx8mm_thermal.c              |   2 +-
 drivers/thermal/imx_sc_thermal.c              |   2 +-
 drivers/thermal/imx_thermal.c                 |  36 +--
 .../intel/int340x_thermal/int3400_thermal.c   |  14 +-
 .../intel/int340x_thermal/int3402_thermal.c   |   2 +-
 .../intel/int340x_thermal/int3403_thermal.c   |   4 +-
 .../int340x_thermal/int340x_thermal_zone.c    |  26 +-
 .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
 .../processor_thermal_device.c                |   8 +-
 .../processor_thermal_device_pci.c            |  26 +-
 .../thermal/intel/intel_bxt_pmic_thermal.c    |   4 +-
 drivers/thermal/intel/intel_menlow.c          |   2 +-
 drivers/thermal/intel/intel_pch_thermal.c     |  20 +-
 .../thermal/intel/intel_quark_dts_thermal.c   |  28 +-
 drivers/thermal/intel/intel_soc_dts_iosf.c    |  20 +-
 drivers/thermal/intel/intel_soc_dts_iosf.h    |   2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  26 +-
 drivers/thermal/k3_bandgap.c                  |   2 +-
 drivers/thermal/kirkwood_thermal.c            |  16 +-
 drivers/thermal/max77620_thermal.c            |   4 +-
 drivers/thermal/mtk_thermal.c                 |   2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   6 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |   6 +-
 drivers/thermal/qcom/tsens.c                  |   6 +-
 drivers/thermal/qcom/tsens.h                  |   2 +-
 drivers/thermal/qoriq_thermal.c               |   2 +-
 drivers/thermal/rcar_gen3_thermal.c           |  16 +-
 drivers/thermal/rcar_thermal.c                |  22 +-
 drivers/thermal/rockchip_thermal.c            |  10 +-
 drivers/thermal/rzg2l_thermal.c               |   4 +-
 drivers/thermal/samsung/exynos_tmu.c          |  22 +-
 drivers/thermal/spear_thermal.c               |  20 +-
 drivers/thermal/sprd_thermal.c                |   8 +-
 drivers/thermal/st/st_thermal.c               |  16 +-
 drivers/thermal/st/st_thermal.h               |   2 +-
 drivers/thermal/st/st_thermal_memmap.c        |   2 +-
 drivers/thermal/st/stm_thermal.c              |   6 +-
 drivers/thermal/sun8i_thermal.c               |   4 +-
 drivers/thermal/tegra/soctherm.c              |  38 +--
 drivers/thermal/tegra/tegra-bpmp-thermal.c    |   6 +-
 drivers/thermal/tegra/tegra30-tsensor.c       |  20 +-
 drivers/thermal/thermal-generic-adc.c         |   2 +-
 drivers/thermal/thermal_core.c                | 246 ++++++++-------
 drivers/thermal/thermal_core.h                |  59 ++--
 drivers/thermal/thermal_helpers.c             |  51 ++--
 drivers/thermal/thermal_hwmon.c               |  26 +-
 drivers/thermal/thermal_hwmon.h               |  12 +-
 drivers/thermal/thermal_mmio.c                |   2 +-
 drivers/thermal/thermal_netlink.c             |  18 +-
 drivers/thermal/thermal_of.c                  | 286 ++++++++++--------
 drivers/thermal/thermal_sysfs.c               | 116 +++----
 .../ti-soc-thermal/ti-thermal-common.c        |  10 +-
 drivers/thermal/uniphier_thermal.c            |   4 +-
 include/linux/power/charger-manager.h         |   2 +-
 include/linux/power_supply.h                  |   2 +-
 include/linux/thermal.h                       | 144 +++++----
 include/trace/events/thermal.h                |   4 +-
 .../trace/events/thermal_power_allocator.h    |   4 +-
 92 files changed, 988 insertions(+), 938 deletions(-)

-- 
2.25.1

