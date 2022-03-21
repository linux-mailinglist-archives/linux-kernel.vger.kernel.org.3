Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4454E2E38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351308AbiCUQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiCUQlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:41:21 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3D17E18;
        Mon, 21 Mar 2022 09:39:55 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2e5757b57caso162188437b3.4;
        Mon, 21 Mar 2022 09:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q2bbu0FlI0bjoAu2DyU2tLEct1K2WT3Nwkj0AnRIr48=;
        b=GUhwGqwI7E1/9Coni0FmKD7WWeVcXGHm4+T2KqIv/qs9ODbfHmh7iWTv6pID7znr3e
         hs7lINy2y5G+78pNeEKmnNbKC2juML9SruScmyqZu90PdLJWF7Bzl3IfoBR4S4a29rha
         YcLPEMOPQuJ2UU4PkVo1v6SSJNuYPYFxSd+1Xob6rNLpGm5iO1K9pOf/D4z3yL59jbom
         QsvGTZPI7b2UY1hhM69kofdU9NLv+cuV7FIVi1bjbQIYve7zhgxVVWfaeCdiza6TGf/6
         CDlGIivgaGQFGxgLoBXs9Va1Z6ojZeml0KyYQqhqPJR/IrqaTtAS/3A8W9awDmgtUGbs
         X59w==
X-Gm-Message-State: AOAM5300YjMv85Jsmd8CjRerHEe1JrQB2uIvljAmhTSZTrJdZO5jAlbI
        fsauNgktTHaLny1ni04GmQQrn1WHDNa2MSZ0V5k=
X-Google-Smtp-Source: ABdhPJz2BdoNoNPYGxapeQ55Ogncfc3A7a6RAv/xKxM8OfgNimI4flRGmVJ1RWxaw2GT5+2UHqr6A+gf/94/yzomQS0=
X-Received: by 2002:a81:5cf:0:b0:2e5:7477:168e with SMTP id
 198-20020a8105cf000000b002e57477168emr24630650ywf.149.1647880794783; Mon, 21
 Mar 2022 09:39:54 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Mar 2022 17:39:44 +0100
Message-ID: <CAJZ5v0gzkr8k3u6ZdKnsAOgk569Gf-HF5u2AShXdznEE4+UYGw@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.18-rc1

with top-most commit 31035f3e20af4ede5f1c8162068327ea0b35a96e

 Merge branch 'thermal-hfi'

on top of commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3

 Linux 5.17-rc6

to receive thermal control updates for 5.18-rc1.

As far as new functionality is concerned, there is a new thermal
driver for the Intel Hardware Feedback Interface (HFI) along with
some intel-speed-select utility changes to support it.  There are
also new DT compatible strings for a couple of platforms and
thermal zones on some platforms will be registered as HWmon
sensors now.

Apart from the above, some drivers are updated (fixes mostly) and
there is a new piece of documentation for the Intel DPTF (Dynamic
Power and Thermal Framework) sysfs interface.

Specifics:

 - Add a new thermal driver for the Intel Hardware Feedback Interface
   (HFI) including the HFI initialization, HFI notification interrupt
   handling and sending CPU capabilities change messages to user
   space via the thermal netlink interface (Ricardo Neri, Srinivas
   Pandruvada, Nathan Chancellor, Randy Dunlap).

 - Extend the intel-speed-select utility to handle out-of-band CPU
   configuration changes and add support for the CPU capabilities
   change messages sent over the thermal netlink interface by the new
   HFI thermal driver to it (Srinivas Pandruvada).

 - Convert the DT bindings to yaml format for the Exynos platform
   and fix and update the MAINTAINERS file for this driver (Krzysztof
   Kozlowski).

 - Register the thermal zones as HWmon sensors for the QCom's
   Tsens driver and TI thermal platforms (Dmitry Baryshkov, Romain
   Naour).

 - Add the msm8953 compatible documentation in the bindings (Luca
   Weiss).

 - Add the sm8150 platform support to the QCom LMh driver's DT
   binding (Thara Gopinath).

 - Check the command result from the IPC command to the BPMP in the
   Tegra driver (Mikko Perttunen).

 - Silence the error for normal configuration where the interrupt
   is optional in the Broadcom thermal driver (Florian Fainelli).

 - Remove remaining dead code from the TI thermal driver (Yue
   Haibing).

 - Don't use bitmap_weight() in end_power_clamp() in the powerclamp
   driver (Yury Norov).

 - Update the OS policy capabilities handshake in the int340x thermal
   driver (Srinivas Pandruvada).

 - Increase the policies bitmap size in int340x (Srinivas Pandruvada).

 - Replace acpi_bus_get_device() with acpi_fetch_acpi_dev() in the
   int340x thermal driver (Rafael Wysocki).

 - Check for NULL after calling kmemdup() in int340x (Jiasheng Jiang).

 - Add Intel Dynamic Power and Thermal Framework (DPTF) kernel interface
   documentation (Srinivas Pandruvada).

 - Fix bullet list warning in the thermal documentation (Randy Dunlap).

Thanks!


---------------

Dmitry Baryshkov (1):
      thermal/drivers/tsens: register thermal zones as hwmon sensors

Florian Fainelli (1):
      thermal/drivers/brcmstb_thermal: Interrupt is optional

Jiasheng Jiang (1):
      thermal: int340x: Check for NULL after calling kmemdup()

Krzysztof Kozlowski (3):
      dt-bindings: thermal: samsung: Convert to dtschema
      MAINTAINERS: thermal: samsung: Drop obsolete properties
      MAINTAINERS: thermal: samsung: update Krzysztof Kozlowski's email

Luca Weiss (1):
      dt-bindings: thermal: tsens: Add msm8953 compatible

Mikko Perttunen (1):
      thermal: tegra-bpmp: Handle errors in BPMP response

Nathan Chancellor (1):
      thermal: netlink: Fix parameter type of
thermal_genl_cpu_capability_event() stub

Nicolas Cavallari (1):
      thermal: core: Fix TZ_GET_TRIP NULL pointer dereference

Rafael J. Wysocki (1):
      thermal: Replace acpi_bus_get_device()

Randy Dunlap (2):
      thermal: fix Documentation bullet list warning
      thermal: intel: hfi: INTEL_HFI_THERMAL depends on NET

Ricardo Neri (5):
      x86/Documentation: Describe the Intel Hardware Feedback Interface
      x86/cpu: Add definitions for the Intel Hardware Feedback Interface
      thermal: intel: hfi: Minimally initialize the Hardware Feedback Interface
      thermal: intel: hfi: Handle CPU hotplug events
      thermal: intel: hfi: Enable notification interrupt

Romain Naour (1):
      drivers/thermal/ti-soc-thermal: Add hwmon support

Srinivas Pandruvada (8):
      thermal: netlink: Add a new event to notify CPU capabilities change
      thermal: intel: hfi: Notify user space for HFI events
      tools/power/x86/intel-speed-select: OOB daemon mode
      tools/power/x86/intel-speed-select: HFI support
      tools/power/x86/intel-speed-select: v1.12 release
      Documentation: thermal: DPTF Documentation
      thermal: int340x: Increase bitmap size
      thermal: int340x: Update OS policy capability handshake

Thara Gopinath (2):
      thermal/drivers/qcom/lmh: Add support for sm8150
      dt-bindings: thermal: Add sm8150 compatible string for LMh

YueHaibing (1):
      thermal/drivers/ti-soc-thermal: Remove unused function
ti_thermal_get_temp()

Yury Norov (1):
      thermal: intel_powerclamp: don't use bitmap_weight() in end_power_clamp()

---------------

 Documentation/ABI/testing/sysfs-class-thermal      |   2 +-
 .../devicetree/bindings/thermal/exynos-thermal.txt | 106 ----
 .../devicetree/bindings/thermal/qcom-lmh.yaml      |   1 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../bindings/thermal/samsung,exynos-thermal.yaml   | 184 +++++++
 Documentation/driver-api/thermal/index.rst         |   1 +
 Documentation/driver-api/thermal/intel_dptf.rst    | 272 ++++++++++
 Documentation/x86/index.rst                        |   1 +
 Documentation/x86/intel-hfi.rst                    |  72 +++
 MAINTAINERS                                        |   7 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/msr-index.h                   |   6 +
 drivers/thermal/broadcom/brcmstb_thermal.c         |   2 +-
 drivers/thermal/intel/Kconfig                      |  14 +
 drivers/thermal/intel/Makefile                     |   1 +
 .../intel/int340x_thermal/acpi_thermal_rel.c       |  23 +-
 .../intel/int340x_thermal/int3400_thermal.c        | 153 ++++--
 drivers/thermal/intel/intel_hfi.c                  | 569 +++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h                  |  17 +
 drivers/thermal/intel/intel_powerclamp.c           |   9 +-
 drivers/thermal/intel/therm_throt.c                |  22 +
 drivers/thermal/qcom/lmh.c                         |  62 ++-
 drivers/thermal/qcom/tsens.c                       |   5 +
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |  13 +-
 drivers/thermal/thermal_netlink.c                  |  58 ++-
 drivers/thermal/thermal_netlink.h                  |  14 +
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  12 +-
 include/uapi/linux/thermal.h                       |   6 +-
 tools/power/x86/intel-speed-select/Build           |   2 +-
 tools/power/x86/intel-speed-select/Makefile        |  10 +-
 tools/power/x86/intel-speed-select/hfi-events.c    | 309 +++++++++++
 tools/power/x86/intel-speed-select/isst-config.c   |  54 +-
 tools/power/x86/intel-speed-select/isst-daemon.c   | 244 +++++++++
 tools/power/x86/intel-speed-select/isst.h          |  13 +
 34 files changed, 2029 insertions(+), 237 deletions(-)
