Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8B51E707
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383887AbiEGM6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiEGM6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:58:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFD440A0B
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:54:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u3so13446072wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qLNqRHvGThMnKCh8JxH+zMKQlY3uNLQAnfUyMgDeJ0=;
        b=tyVJyu1og+k8qz+Q0Yp4FF1vz1lZIa7YVQExpwHYljQuHEUITYRKaSu9lwUanHwWmn
         EmrXNgYq3h+JSV/yDYMkwpB/LVnkRlFHnHIfXGT50ej/hQHeEUXsvnFFMaBBpU7J4CHu
         PGzXTbPU/a28lLiEQoJix1MCJc9Csaj4liwipVnA1Q/ZQkHoABcCR1vbj+KFByICL+UT
         s+vKWs3dsbJGTKOJ5NA0EgCuPDbXo1PHKk3x5UTHg78Pft7pRnKzU+oAZcV/VKx/RAwp
         kgP6OVHxwW8wmLdY12f6oiCloXXIJPtGbjpAFRtQK6wpV1LatpKFcZ5knwUW7BD//7tg
         cNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qLNqRHvGThMnKCh8JxH+zMKQlY3uNLQAnfUyMgDeJ0=;
        b=k5GyhlTPB4Q8ye+Ie/31EcJKiPMo0WQ4TXh5qqQMYM2apCZWBs13n4UM+DHaTVw9+3
         ij2HYONOVidcLZZpdfFirQ0h2KMA3jA2/mlkA+Ry1hHGWjL4Fkj3E9bEB9BoymPou7f0
         c97wA826hrAUJsH/WJfjkrpv37TmWpdq4tulU9hxEKWFkdzIAIEoamT2cNYaCVjzev2V
         3DfVl3U3AAbRZPIsV1M1ndwZfLagIn/I+hb6L6zVyvOVeyETF0JXje/WQHpY1elQjxcx
         BaqVhs+7tQuA+yrlBAGQG5azi9wyYg3fkkeiTxjbOQQ8w8TAMNQyVq+58oZ3D7raLGPt
         mMIw==
X-Gm-Message-State: AOAM530/wLPTa+kfMKe7Y5VHEU3nGgEd7lQeUwR5O5qYbcIFiGBhC6Z0
        Gr2y/ubyw5R1xmSJxs2TRhPJSw==
X-Google-Smtp-Source: ABdhPJylh6922PCoagUrF2YYaK7DCbeMrGccC2W/GwcT01UroYD73UMX9Yz386A2CCvCT4A1wkJ+eg==
X-Received: by 2002:a05:6000:86:b0:20a:d7be:e09b with SMTP id m6-20020a056000008600b0020ad7bee09bmr6403590wrx.398.1651928086156;
        Sat, 07 May 2022 05:54:46 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:54:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] thermal OF rework
Date:   Sat,  7 May 2022 14:54:28 +0200
Message-Id: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

As there could be a large number of changes, this first series provide
some steps forward for a simpler device tree initialization.

Changelog:
 - V2:
   - Drop patch 1/15 which contains too many changes for a simple
     structure renaming. This could be addressed in a separate series as
     it is not necessary for the OF rework
     
   - Fixed of_node_put with gchild not initialized as reported by
     kbuild and Dan Carpenter

 - V1:
   - Initial post

Daniel Lezcano (14):
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

 .../driver-api/thermal/sysfs-api.rst          |   2 +-
 drivers/acpi/thermal.c                        |   6 +-
 .../ethernet/chelsio/cxgb4/cxgb4_thermal.c    |   2 +-
 .../ethernet/mellanox/mlxsw/core_thermal.c    |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   2 +-
 drivers/platform/x86/acerhdf.c                |   2 +-
 drivers/power/supply/power_supply_core.c      |   2 +-
 drivers/thermal/armada_thermal.c              |   2 +-
 drivers/thermal/broadcom/bcm2835_thermal.c    |   2 +-
 drivers/thermal/da9062-thermal.c              |   2 +-
 drivers/thermal/dove_thermal.c                |   2 +-
 drivers/thermal/gov_bang_bang.c               |   6 +-
 drivers/thermal/gov_fair_share.c              |  10 +-
 drivers/thermal/gov_power_allocator.c         |  22 +-
 drivers/thermal/gov_step_wise.c               |   4 +-
 drivers/thermal/imx_thermal.c                 |   2 +-
 .../intel/int340x_thermal/int3400_thermal.c   |   2 +-
 .../int340x_thermal/int340x_thermal_zone.c    |   6 +-
 .../int340x_thermal/int340x_thermal_zone.h    |   4 +-
 .../processor_thermal_device.c                |   4 +-
 .../processor_thermal_device_pci.c            |   2 +-
 drivers/thermal/intel/intel_pch_thermal.c     |   2 +-
 .../thermal/intel/intel_quark_dts_thermal.c   |   2 +-
 drivers/thermal/intel/intel_soc_dts_iosf.c    |   2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |   2 +-
 drivers/thermal/kirkwood_thermal.c            |   2 +-
 drivers/thermal/rcar_gen3_thermal.c           |   6 +-
 drivers/thermal/rcar_thermal.c                |   4 +-
 drivers/thermal/samsung/exynos_tmu.c          |   6 +-
 drivers/thermal/spear_thermal.c               |   2 +-
 drivers/thermal/st/st_thermal.c               |   2 +-
 drivers/thermal/tegra/soctherm.c              |  10 +-
 drivers/thermal/tegra/tegra30-tsensor.c       |   6 +-
 drivers/thermal/thermal_core.c                | 102 ++++----
 drivers/thermal/thermal_core.h                |  25 +-
 drivers/thermal/thermal_helpers.c             |  35 ++-
 drivers/thermal/thermal_hwmon.c               |   4 +-
 drivers/thermal/thermal_netlink.c             |  10 +-
 drivers/thermal/thermal_of.c                  | 221 ++++++++++--------
 drivers/thermal/thermal_sysfs.c               |  62 ++---
 include/linux/thermal.h                       |  34 ++-
 41 files changed, 341 insertions(+), 290 deletions(-)

-- 
2.25.1

