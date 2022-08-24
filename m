Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4621759F8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiHXLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHXLix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:38:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165A82779
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:38:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so20449807wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=tyoz+ZZrSGkvHCpO1cyzSxybU5YP0IGbdq84Bsreb+U=;
        b=U9QH3s5/uC4/RmR7JSDanjlRAvwmVrlrdOHKThue/tPlRPhwxv+O7W/LCP/4bhzczX
         21hq5Q4ChNCjSOQikLFEjlrYPJKBYAQkoQUsvrZ8i4sWh+vxsFk++2rWy6NCd/fwM2OQ
         s6kCD8bhhcTY/ieEhqLYQyv5aFTZSYVYXlG+7Tgpjpejway3hUBOVQGV8xeakcRbTdGa
         a6vBdkeu20qqiqQdQAPKEQdb6dJVbevssWInkEkf+rvzdl63pQRywbklHXq+27wLRfCS
         ynErhiXW8hcYgJqH29U/tVLqO9yzle3JYgr8A9hkvwP+0rS7XWu+hfEHh9u5qaNMNWwT
         5p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=tyoz+ZZrSGkvHCpO1cyzSxybU5YP0IGbdq84Bsreb+U=;
        b=ducnSnNSWpJ6c36oGCal85tbIk+w+pngZQFWCZI+To9onenGTqak/gAk7nmNDlSAd7
         Q8GFUV2FMSKcCZ8NlyJIfCZwHJPi5nmV6+1qoS2ts1++kxmdsTenf/abgy5l4N+hKqTO
         8H8ZXg9luT+YyzSpCymhT26JYyeco28UM9vgB6rz1bXIerbWtrpOfd1YVGhaldpftaaH
         SM6XuiVv1+nMy3NGaoBykXyozedo18/r07eZuPPt3nh7hqIK3VhVlzNyFMPBr6KU7oAj
         Jiqd/MwY5z9JG4Qp9ZYqwI2vKs7KQpnz/BoqVDjcYiX6LO+Cd83vtoDpthRUdty2Ogf7
         t64g==
X-Gm-Message-State: ACgBeo1B7OV2a7+8WHaC865kftZ1H39DqTNf3sKUTShMiW79yawA17eH
        MFodJ320uyKxHC/FfXjQpAXd3A==
X-Google-Smtp-Source: AA6agR7O1DuCbTb1dxVtsN2dH5krfG3+E6gm2xuG/xAiILrkhRy3l9IDQgN3rg0Dn8dZFDSJzcuaKg==
X-Received: by 2002:a5d:64ca:0:b0:225:48a0:d9cb with SMTP id f10-20020a5d64ca000000b0022548a0d9cbmr11121690wri.399.1661341130369;
        Wed, 24 Aug 2022 04:38:50 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h188-20020a1c21c5000000b003a63a3b55c3sm1642503wmh.14.2022.08.24.04.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 04:38:50 -0700 (PDT)
Message-ID: <0fc7062d-696a-0794-8730-48ef08bcb8bd@linaro.org>
Date:   Wed, 24 Aug 2022 13:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] early thermal changes for v6.1-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

this cycle will contain certainly a higher number of changes than the 
previous ones. That will come from the rework of the thermal trip 
handling / consolidation which is still WIP but where the drivers 
changes are partly acked-by the different maintainers. The result will 
be great IMO in terms of cleanup, encapsulation and maintainability.

The thermal OF cleanup and rework have been consolidated meanwhile.

In order to not have a huge pull request at the end of the v6.1 
development cycle, I propose to send early but smaller pull requests 
(release often, release early), so hopefully that will make the changes 
smooth and may be hit the potential bugs for those who are sticking to 
linux-pm instead of linux-next.

This pull request is the first one and has been in the linux-next branch 
since a couple of weeks.

It includes the thermal OF rework, with the corresponding fixes and the 
monitoring locking scheme path changes.

Thanks
   -- Daniel

The following changes since commit 8c596324232d22e19f8df59ba03410b9b5b0f3d7:

   dt-bindings: thermal: Fix missing required property (2022-08-15 
20:38:40 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.1-rc1

for you to fetch changes up to 06f36055121769b9eb9b7d28c7499d1cc8269dc3:

   Revert "mlxsw: core: Add the hottest thermal zone detection" 
(2022-08-17 20:32:27 +0200)

----------------------------------------------------------------
- Rework the device tree initialization, convert the drivers to the
   new API and remove the old OF code (Daniel Lezcano)

- Fix return value to -ENODEV when searching for a specific thermal
   zone which does not exist (Daniel Lezcano)

- Fix the return value inspection in of_thermal_zone_find() (Dan
   Carpenter)

- Fix kernel panic when kasan is enabled as it detects an use after
   free when unregistering a thermal zone (Daniel Lezcano)

- Move the set_trip ops inside the thermal sysfs code (Daniel Lezcano)

- Remove unnecessary error message as it is already showed in the
   underlying function (Jiapeng Chong)

- Rework the monitoring path and move the locks upper in the call
   stack to fix some potentials race windows (Daniel Lezcano)

- Fix lockdep_assert() warning introduced by the lock rework (Daniel
   Lezcano)

- Revert the Mellanox 'hotter thermal zone' feature because it is
   already handled in the thermal framework core code (Daniel Lezcano)

----------------------------------------------------------------
Dan Carpenter (1):
       thermal/of: Fix error code in of_thermal_zone_find()

Daniel Lezcano (42):
       thermal/of: Rework the thermal device tree initialization
       thermal/of: Return -ENODEV instead of -EINVAL if registration fails
       thermal/of: Fix free after use in thermal_of_unregister()
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
       hwmon: pm_bus: core: Switch to new of thermal API
       hwmon/drivers/core: Switch to new of thermal API
       iio/drivers/sun4i_gpadc: Switch to new of thermal API
       Input: sun4i-ts - switch to new of thermal API
       regulator/drivers/max8976: Switch to new of thermal API
       thermal/drivers/samsung: Switch to new of thermal API
       thermal/core: Move set_trip_temp ops to the sysfs code
       thermal/of: Remove old OF code
       thermal/core: Rearm the monitoring only one time
       thermal/core: Rework the monitoring a bit
       thermal/governors: Group the thermal zone lock inside the 
throttle function
       thermal/core: Move the thermal zone lock out of the governors
       thermal/core: Move the mutex inside the 
thermal_zone_device_update() function
       thermal/core: Fix lockdep_assert() warning
       Revert "mlxsw: core: Add the hottest thermal zone detection"

Jiapeng Chong (1):
       thermal/drivers/qcom/spmi-adc-tm5: Remove unnecessary print 
function dev_err()

  drivers/ata/ahci_imx.c                             |   15 +-
  drivers/hwmon/hwmon.c                              |   14 +-
  drivers/hwmon/pmbus/pmbus_core.c                   |   10 +-
  drivers/hwmon/scpi-hwmon.c                         |   14 +-
  drivers/iio/adc/sun4i-gpadc-iio.c                  |   14 +-
  drivers/input/touchscreen/sun4i-ts.c               |   10 +-
  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |   77 +-
  drivers/regulator/max8973-regulator.c              |   10 +-
  drivers/thermal/amlogic_thermal.c                  |   16 +-
  drivers/thermal/armada_thermal.c                   |   12 +-
  drivers/thermal/broadcom/bcm2711_thermal.c         |   14 +-
  drivers/thermal/broadcom/bcm2835_thermal.c         |   14 +-
  drivers/thermal/broadcom/brcmstb_thermal.c         |   20 +-
  drivers/thermal/broadcom/ns-thermal.c              |   50 +-
  drivers/thermal/broadcom/sr-thermal.c              |   16 +-
  drivers/thermal/db8500_thermal.c                   |    8 +-
  drivers/thermal/gov_bang_bang.c                    |   10 +-
  drivers/thermal/gov_fair_share.c                   |    3 +-
  drivers/thermal/gov_power_allocator.c              |   20 +-
  drivers/thermal/gov_step_wise.c                    |   10 +-
  drivers/thermal/hisi_thermal.c                     |   14 +-
  drivers/thermal/imx8mm_thermal.c                   |   14 +-
  drivers/thermal/imx_sc_thermal.c                   |   14 +-
  drivers/thermal/k3_bandgap.c                       |   12 +-
  drivers/thermal/k3_j72xx_bandgap.c                 |   12 +-
  drivers/thermal/max77620_thermal.c                 |    8 +-
  drivers/thermal/mtk_thermal.c                      |   10 +-
  drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   23 +-
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   12 +-
  drivers/thermal/qcom/tsens.c                       |   16 +-
  drivers/thermal/qoriq_thermal.c                    |   12 +-
  drivers/thermal/rcar_gen3_thermal.c                |   16 +-
  drivers/thermal/rcar_thermal.c                     |   13 +-
  drivers/thermal/rockchip_thermal.c                 |   14 +-
  drivers/thermal/rzg2l_thermal.c                    |   10 +-
  drivers/thermal/samsung/exynos_tmu.c               |   24 +-
  drivers/thermal/sprd_thermal.c                     |   18 +-
  drivers/thermal/st/stm_thermal.c                   |   18 +-
  drivers/thermal/sun8i_thermal.c                    |   14 +-
  drivers/thermal/tegra/soctherm.c                   |   21 +-
  drivers/thermal/tegra/tegra-bpmp-thermal.c         |   19 +-
  drivers/thermal/tegra/tegra30-tsensor.c            |   12 +-
  drivers/thermal/thermal-generic-adc.c              |   10 +-
  drivers/thermal/thermal_core.c                     |   63 +-
  drivers/thermal/thermal_core.h                     |    4 +-
  drivers/thermal/thermal_helpers.c                  |   73 +-
  drivers/thermal/thermal_mmio.c                     |   17 +-
  drivers/thermal/thermal_of.c                       | 1148 
+++++++-------------
  drivers/thermal/thermal_sysfs.c                    |   11 +-
  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   16 +-
  drivers/thermal/uniphier_thermal.c                 |   10 +-
  include/linux/thermal.h                            |   85 +-
  52 files changed, 796 insertions(+), 1324 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
