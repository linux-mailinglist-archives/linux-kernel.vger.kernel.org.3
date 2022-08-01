Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E837F5871CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiHATxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiHATxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:53:36 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6762E1;
        Mon,  1 Aug 2022 12:53:35 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-32269d60830so120390717b3.2;
        Mon, 01 Aug 2022 12:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=0v6TbsxxrY2rW0RsMJwBCQ0Z1bJeBDSjf5C1NGUUv9U=;
        b=SSPU9nqGBUlS6JqwE81fs4R9cJuMwE5u6Fz3HW7nGqS457phkOO/zQE3I15xY5YkGf
         wi+quFAEmiuiiiZINgOjeVPOU5WADlTfll9G+fUm+m97SZpaRHmuGj70RO8Z2XnGXYJj
         l6Gxak6K+IjuvhlIhkx6CLu4K8kVblyL71QRWCDyicmY6j9RN8yEh/xsj0mM+VZikQjD
         SPeCFN/uuG7ycljoUH317JabJlqrYtU9P/oqszaySRfoE40TPpZuXxT3EbLSDJ70dD/o
         KBFAsZj0CrBmvsgI9hmmE3dN0remzLDrEcyzDN4aGCRe1fTm+0Pm/QmtyHtVIKq9V9Sl
         m9NQ==
X-Gm-Message-State: ACgBeo0VfJix8MUUsrK159SoNW9k9n0eC537yBBFXC3Cf/at3R3MNd8I
        KSoD1Ij45HanMxDr0g51Se/hn73k3TGAu03I9JwytxsAVpU/5w==
X-Google-Smtp-Source: AA6agR5qyI2WP0GnZStHyUT2dYQho0ujsdtPbdORfj58jWveOLDhl8yZTBFUO5/t/v6dgIJSl7fWAxFnyFnkxSSTGaw=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr14333553ywb.326.1659383614932; Mon, 01
 Aug 2022 12:53:34 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Aug 2022 21:53:19 +0200
Message-ID: <CAJZ5v0hX=o5nCmYgLekz_XMRfQcdPyFjC+=+BqEAvetNGD3ASw@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.20-rc1

with top-most commit da9d01794e31714a90a38e395c14723fb46f90b0

 Merge tag 'thermal-v5.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit 32346491ddf24599decca06190ebca03ff9de7f8

 Linux 5.19-rc6

to receive thermal control updates for 5.20-rc1.

These start a rework of the handling of trip points in the thermal
core, improve the cpufreq/devfreq cooling device handling, update
some thermal control drivers and the tmon utility and clean up code.

Specifics:

 - Consolidate the thermal core code by beginning to move the thermal
   trip structure from the thermal OF code as a generic structure to be
   used by the different sensors when registering a thermal zone
   (Daniel Lezcano).

 - Make per cpufreq / devfreq cooling device ops instead of using a
   global variable, fix comments and rework the trace information
   (Lukasz Luba).

 - Add the include/dt-bindings/thermal.h under the area covered by the
   thermal maintainer in the MAINTAINERS file (Lukas Bulwahn).

 - Improve the error output by giving the sensor identification when a
   thermal zone failed to initialize, the DT bindings by changing the
   positive logic and adding the r8a779f0 support on the rcar3 (Wolfram
   Sang).

 - Convert the QCom tsens DT binding to the dtsformat format (Krzysztof
   Kozlowski).

 - Remove the pointless get_trend() function in the QCom, Ux500 and
   tegra thermal drivers, along with the unused DROP_FULL and
   RAISE_FULL trends definitions. Simplify the code by using clamp()
   macros (Daniel Lezcano).

 - Fix ref_table memory leak at probe time on the k3_j72xx bandgap
   (Bryan Brattlof).

 - Fix array underflow in prep_lookup_table (Dan Carpenter).

 - Add static annotation to the k3_j72xx_bandgap_j7* data structure
   (Jin Xiaoyun).

 - Fix typos in comments detected on sun8i by Coccinelle (Julia
   Lawall).

 - Fix typos in comments on rzg2l (Biju Das).

 - Remove as unnecessary call to dev_err() as the error is already
   printed by the failing function on u8500 (Yang Li).

 - Register the thermal zones as hwmon sensors for the Qcom thermal
   sensors (Dmitry Baryshkov).

 - Fix 'tmon' tool compilation issue by adding phtread.h include
   (Markus Mayer).

 - Fix typo in the comments for the 'tmon' tool (Slark Xiao).

 - Make the thermal core use ida_alloc()/free() directly instead of
   ida_simple_get()/ida_simple_remove() that have been deprecated
   (keliu).

 - Drop ACPI_FADT_LOW_POWER_S0 check from the Intel PCH thermal control
   driver (Rafael Wysocki).

Thanks!


---------------

Biju Das (1):
      thermal/drivers/rzg2l: Fix comments

Bryan Brattlof (1):
      thermal/drivers/k3_j72xx_bandgap: Fix ref_table memory leak during probe

Dan Carpenter (1):
      thermal/drivers/k3_j72xx_bandgap: Fix array underflow in
prep_lookup_table()

Daniel Lezcano (16):
      thermal/drivers/qcom: Remove get_trend function
      thermal/drivers/tegra: Remove get_trend function
      thermal/drivers/u8500: Remove the get_trend function
      thermal/core: Use clamp() helper in the stepwise governor
      thermal/core: Remove DROP_FULL and RAISE_FULL
      thermal/core: Avoid calling ->get_trip_temp() unnecessarily
      thermal/core: Remove duplicate information when an error occurs
      thermal/of: Replace device node match with device node search
      thermal/of: Remove the device node pointer for thermal_trip
      thermal/of: Move thermal_trip structure to thermal.h
      thermal/core: Remove unneeded EXPORT_SYMBOLS
      thermal/core: Move thermal_set_delay_jiffies to static
      thermal/core: Rename 'trips' to 'num_trips'
      thermal/core: Add thermal_trip in thermal_zone
      thermal/of: Use thermal trips stored in the thermal zone
      thermal/of: Initialize trip points separately

Dmitry Baryshkov (2):
      thermal/drivers/qcom/temp-alarm: Register thermal zones as hwmon sensors
      thermal/drivers/qcom/spmi-adc-tm5: Register thermal zones as hwmon sensors

Jason Wang (1):
      thermal/ti-soc-thermal: Fix comment typo

Jiang Jian (1):
      thermal: intel: x86_pkg_temp_thermal: Drop duplicate 'is' from comment

Jin Xiaoyun (1):
      thermal/drivers/k3_j72xx_bandgap: Make
k3_j72xx_bandgap_j721e_data and k3_j72xx_bandgap_j7200_data static

Julia Lawall (1):
      thermal/drivers/sun8i: Fix typo in comment

Krzysztof Kozlowski (1):
      dt-bindings: thermal: qcom,spmi-temp-alarm: convert to dtschema

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/thermal to THERMAL

Lukasz Luba (4):
      drivers/thermal/cpufreq_cooling: Use private callback ops for
each cooling device
      drivers/thermal/cpufreq_cooling : Refactor
thermal_power_cpu_get_power tracing
      drivers/thermal/cpufreq_cooling: Update outdated comments
      drivers/thermal/devfreq_cooling: Extend the
devfreq_cooling_device with ops

Markus Mayer (1):
      thermal/tools/tmon: Include pthread and time headers in tmon.h

Rafael J. Wysocki (1):
      intel: thermal: PCH: Drop ACPI_FADT_LOW_POWER_S0 check

Slark Xiao (1):
      thermal/tools/tmon: Fix typo 'the the' in comment

Wolfram Sang (3):
      drivers/thermal/rcar_gen3_thermal: Improve logging during probe
      dt-bindings: thermal: rcar-gen3-thermal: use positive logic
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a779f0 support

Yang Li (1):
      thermal/drivers/u8500: Remove unnecessary print function dev_err()

keliu (1):
      thermal: Directly use ida_alloc()/free()

---------------

 .../bindings/thermal/qcom,spmi-temp-alarm.yaml     |  85 +++++++++
 .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  51 ------
 .../bindings/thermal/rcar-gen3-thermal.yaml        |  36 ++--
 MAINTAINERS                                        |   1 +
 drivers/thermal/cpufreq_cooling.c                  |  77 +++-----
 drivers/thermal/db8500_thermal.c                   |  34 +---
 drivers/thermal/devfreq_cooling.c                  |  27 +--
 drivers/thermal/gov_fair_share.c                   |   6 +-
 drivers/thermal/gov_power_allocator.c              |   4 +-
 drivers/thermal/gov_step_wise.c                    |  26 +--
 drivers/thermal/intel/intel_pch_thermal.c          |   8 -
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c                 |  13 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   5 +
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   5 +
 drivers/thermal/qcom/tsens.c                       |  12 --
 drivers/thermal/qcom/tsens.h                       |   2 -
 drivers/thermal/rcar_gen3_thermal.c                |   4 +-
 drivers/thermal/rzg2l_thermal.c                    |  18 +-
 drivers/thermal/sun8i_thermal.c                    |   2 +-
 drivers/thermal/tegra/soctherm.c                   |  32 ----
 drivers/thermal/tegra/tegra30-tsensor.c            |   2 +-
 drivers/thermal/thermal_core.c                     |  79 ++++----
 drivers/thermal/thermal_core.h                     |  15 --
 drivers/thermal/thermal_helpers.c                  |  13 +-
 drivers/thermal/thermal_netlink.c                  |   2 +-
 drivers/thermal/thermal_of.c                       | 201 ++++++++++++---------
 drivers/thermal/thermal_sysfs.c                    |  22 +--
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
 include/linux/thermal.h                            |  26 ++-
 include/trace/events/thermal.h                     |  28 +--
 tools/thermal/tmon/pid.c                           |   2 +-
 tools/thermal/tmon/tmon.h                          |   3 +
 33 files changed, 397 insertions(+), 448 deletions(-)
