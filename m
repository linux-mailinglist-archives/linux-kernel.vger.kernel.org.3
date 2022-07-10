Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5D156D15E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGJVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGJVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:24:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9D8DEEC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o8so2053255wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMUxAvEIW9c3LzBfDuZjW6+onx8HkZpX6WPcbxnZtrI=;
        b=Pz+se65lH/rHwqY8bL7owPmekL+jkhARWzJdRLt6p4W9dL+sCzPUmHctMa1+oYzNHC
         REARmARCh4QgvllgK2poYk6aLeIPTKSCGPuvqCjkYblnxWFzn834c9BI8gnWph25swKl
         rcYkuBr+uJCVmJ7kMREZjXh9eEZmOR6jSvKR3frBXvHULO9CceeIwp3fLSBXxYIhtbDR
         l6kaYaHFf8v19tLVUIbyX47j8sEHMzeqLCMkbm8sH4lE19mnlGC6fIA/HgJ9d6Gm05+n
         TrShvTn4yNcODErfzB3B1CMBRNj1LQsHap11nuqs8C3T4+zfGhtoqUDWSAYP1YzqePO1
         VYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMUxAvEIW9c3LzBfDuZjW6+onx8HkZpX6WPcbxnZtrI=;
        b=r+OBHUctlZCoGVBvAHw4r87cp9WuhdoOeIJ1PpjEZE5VCqAaivAqswP26uT6qkedJ1
         XBEL/C2EO5qS8Kp9iy0ljrkgcNW+2BiRFafsw1e54YXyv8hlDbzd+xhSdrizYT/xRP1i
         0e4KEpvb6Af5rvhjB3qgC1N88gCeUmIVF+l2WqbvJ1zowJVXk+lAF1l0T78fwqL5UwG4
         QhYJm3pyhRU71xhmEKxL5Q4BtwKpIkTkCZVExaclbRZ7SY08N2SGRlLzW/RA7qyqyLhR
         8Z4MfeZnnw0959qgva9rcy8cq4yEbHhxL57QSUeYrT+iTIe7QFXqHADNTu84JuHYrbtK
         w4CQ==
X-Gm-Message-State: AJIora8UQQbXbfzCUT7/x1b+CEtWQrwZU85hd7VK+gbFVHpCILGPFc4c
        mHdpBCbW5kBjkN4JWkh367A7nCmCfM/Q3Q==
X-Google-Smtp-Source: AGRyM1v3dkR7/3/sMRvxTEQGhnfZe0t1/2rK5XitFdT1iyhoSABJSs/6RyOkbhJOS5MAkyYvqtcICw==
X-Received: by 2002:a7b:c2b1:0:b0:3a2:e07b:827f with SMTP id c17-20020a7bc2b1000000b003a2e07b827fmr10626133wmk.44.1657488275491;
        Sun, 10 Jul 2022 14:24:35 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 00/33] New thermal OF code
Date:   Sun, 10 Jul 2022 23:23:50 +0200
Message-Id: <20220710212423.681301-1-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes are depending on:

https://lore.kernel.org/lkml/20220710123512.1714714-1-daniel.lezcano@linexp.org/

The series introduces a new thermal OF code. The patch description gives
a detailed explanation of the changes. Basically we write new OF parsing
functions, we migrate all the users of the old thermal OF API to the new
one and then we finish by removing the old OF code.

That is the second step to rework the thermal OF code. More patches will
come after that to remove the duplication of the trip definitions in the
different drivers which will result in more code duplication removed and
consolidation of the core thermal framework.

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
  hwmon/drivers: Switch to new of thermal API
  iio/drivers/sun4i_gpadc: Switch to new of thermal API
  input/drivers/touchscreen_sun4i: Switch to new of thermal API
  regulator/drivers/max8976: Switch to new of thermal API
  thermal/drivers/bcm2835: Switch to new of thermal API
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
 drivers/thermal/samsung/exynos_tmu.c          |   20 +-
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
 drivers/thermal/thermal_of.c                  | 1134 ++++++-----------
 drivers/thermal/thermal_sysfs.c               |    5 +-
 .../ti-soc-thermal/ti-thermal-common.c        |   16 +-
 drivers/thermal/uniphier_thermal.c            |   10 +-
 include/linux/thermal.h                       |   89 +-
 45 files changed, 708 insertions(+), 1136 deletions(-)

-- 
2.25.1

