Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD14E2E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351249AbiCUQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351339AbiCUQdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:33:17 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952D210E56B;
        Mon, 21 Mar 2022 09:31:51 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2e6650cde1bso9729897b3.12;
        Mon, 21 Mar 2022 09:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8eTA4Aei5sAAmyg2X+tQSmeBwLUM/TWvO5vZq9aOofo=;
        b=lPYkgt+zFCweLKaSNpMyCZQ2Ami2THesFibPkURW9m615D6ZwQx0I1vgLim54VhSDB
         Jga3RMgTbMI/JhP/vjR3JY5QIUPA7nrwEsfcCEpH/jmegbXVqbgcorbiTbTlomLPJ7DP
         X1PUxodPLOhtxtR67gSuBdBVdMarM3lV5H26Pa28c82P6KqEgfsY5vvhIBhqJjcNsu2S
         /OxkpfjkzE7EYDGdr9opKoGrSP6lZeatMUEXLMe6dk7BEqfMYl0rsoJ0OMMmg0xVF+Qa
         UzwMesb5X46j8L+vjYBOjpfkbXkPXgr62ajC0mexeFLD9ATVQibGg6xxuv99gGYGu2PY
         Zblw==
X-Gm-Message-State: AOAM532BPy8nFhRBnixAHNtKpKMo49yPo3mi1gBgRILw3t7HU61SyZp6
        Gkh2cy0EyWmBdQIYTQ4mCJucPAo+JYvNc/7zHo8=
X-Google-Smtp-Source: ABdhPJwLaPUkz9JyCUTMCCL51L7thNpGl6FC7n82qg21zUTUJDZkpCWiEih2bSt8pXh04VJ82cz9O2jZFae+X7V/cJg=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr25585295ywm.19.1647880310738; Mon, 21
 Mar 2022 09:31:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Mar 2022 17:31:39 +0100
Message-ID: <CAJZ5v0jzzwLCo5=TAntL7_GW_VO=rWJ8Hnbne=n19UNNJzdR2A@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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
 acpi-5.18-rc1

with top-most commit 1bde8bddb5db59e5bcd090b227c74d48965cedef

 Merge branch 'acpi-docs'

on top of commit 462ccc35a750f335c8456cde9120b8b593fff60f

 Revert "ACPI: scan: Do not add device IDs from _CID if _HID is not valid"

to receive ACPI updates for 5.18-rc1.

From the new functionality perspective, the most significant items
here are the new driver for the ARM Generic Diagnostic Dump and
Reset device, the extension of fine grain fan control in the ACPI
fan driver and the change making it possible to use CPPC information
to obtain CPU capacity.

There are also a few new quirks, a bunch of fixes, including the
platform-level _OSC handling change to make it actually take the
platform firmware response into account, some code and documentation
cleanups and a notable update of the ACPI device enumeration
documentation.

Specifics:

 - Use uintptr_t and offsetof() in the ACPICA code to avoid compiler
   warnings regarding NULL pointer arithmetic (Rafael Wysocki).

 - Fix possible NULL pointer dereference in acpi_ns_walk_namespace()
   when passed "acpi=off" in the command line (Rafael Wysocki).

 - Fix and clean up acpi_os_read/write_port() (Rafael Wysocki).

 - Introduce acpi_bus_for_each_dev() and use it for walking all ACPI
   device objects in the Type C code (Rafael Wysocki).

 - Fix the _OSC platform capabilities negotioation and prevent CPPC
   from being used if the platform firmware indicates that it not
   supported via _OSC (Rafael Wysocki).

 - Use ida_alloc() instead of ida_simple_get() for ACPI enumeration
   of devices (Rafael Wysocki).

 - Add AGDI and CEDT to the list of known ACPI table signatures (Ilkka
   Koskinen, Robert Kiraly).

 - Add power management debug messages related to suspend-to-idle in
   two places (Rafael Wysocki).

 - Fix __acpi_node_get_property_reference() return value and clean up
   that function (Andy Shevchenko, Sakari Ailus).

 - Fix return value of the __setup handler in the ACPI PM timer clock
   source driver (Randy Dunlap).

 - Clean up double words in two comments (Tom Rix).

 - Add "skip i2c clients" quirks for Lenovo Yoga Tablet 1050F/L and
   Nextbook Ares 8 (Hans de Goede).

 - Clean up frequency invariance handling on x86 in the ACPI CPPC
   library (Huang Rui).

 - Work around broken XSDT on the Advantech DAC-BJ01 board (Mark
   Cilissen).

 - Make wakeup events checks in the ACPI EC driver more
   straightforward and clean up acpi_ec_submit_event() (Rafael
   Wysocki).

 - Make it possible to obtain the CPU capacity with the help of CPPC
   information (Ionela Voinescu).

 - Improve fine grained fan control in the ACPI fan driver and
   document it (Srinivas Pandruvada).

 - Add device HID and quirk for Microsoft Surface Go 3 to the ACPI
   battery driver (Maximilian Luz).

 - Make the ACPI driver for Intel SoCs (LPSS) let the SPI driver know
   the exact type of the controller (Andy Shevchenko).

 - Force native backlight mode on Clevo NL5xRU and NL5xNU (Werner
   Sembach).

 - Fix return value of __setup handlers in the APEI code (Randy
   Dunlap).

 - Add Arm Generic Diagnostic Dump and Reset device driver (Ilkka
   Koskinen).

 - Limit printable size of BERT table data (Darren Hart).

 - Fix up HEST and GHES initialization (Shuai Xue).

 - Update the ACPI device enumeration documentation and unify the ASL
   style in GPIO-related examples (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (12):
      ACPI: property: Get rid of redundant 'else'
      ACPI: platform: Constify properties parameter in
acpi_create_platform_device()
      ACPI: LPSS: Constify properties member in struct lpss_device_desc
      ACPI: LPSS: Provide an SSP type to the driver
      ACPI: docs: enumeration: Discourage to use custom _DSM methods
      ACPI: docs: enumeration: Update UART serial bus resource documentation
      ACPI: docs: enumeration: Remove redundant .owner assignment
      ACPI: docs: enumeration: Amend PWM enumeration ASL example
      ACPI: docs: enumeration: Drop ugly ifdeffery from the examples
      ACPI: docs: enumeration: Drop comma for terminator entry
      ACPI: docs: enumeration: Unify Package () for properties
      ACPI: docs: gpio-properties: Unify ASL style for GPIO examples

Darren Hart (1):
      ACPI/APEI: Limit printable size of BERT table data

Hans de Goede (2):
      ACPI / x86: Add skip i2c clients quirk for Nextbook Ares 8
      ACPI / x86: Add skip i2c clients quirk for Lenovo Yoga Tablet 1050F/L

Huang Rui (4):
      x86/ACPI: CPPC: Rename cppc_msr.c to cppc.c
      x86/ACPI: CPPC: Move AMD maximum frequency ratio setting
function into x86 CPPC
      x86: Expose init_freq_invariance() to topology header
      x86/ACPI: CPPC: Move init_freq_invariance_cppc() into x86 CPPC

Ilkka Koskinen (2):
      ACPI: tables: Add AGDI to the list of known table signatures
      ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device

Ionela Voinescu (3):
      x86, ACPI: rename init_freq_invariance_cppc() to
arch_init_invariance_cppc()
      arch_topology: obtain cpu capacity using information from CPPC
      arm64, topology: enable use of init_cpu_capacity_cppc()

Mark Cilissen (1):
      ACPI / x86: Work around broken XSDT on Advantech DAC-BJ01 board

Maximilian Luz (1):
      ACPI: battery: Add device HID and quirk for Microsoft Surface Go 3

Rafael J. Wysocki (12):
      ACPICA: Use uintptr_t and offsetof() in Linux kernel builds
      ACPI: OSL: Fix and clean up acpi_os_read/write_port()
      ACPI: PM: Print additional debug message in acpi_s2idle_wake()
      ACPI: EC / PM: Print additional debug message in acpi_ec_dispatch_gpe()
      ACPI: EC: Do not return result from advance_transaction()
      ACPI: EC: Reduce indentation level in acpi_ec_submit_event()
      ACPI: EC: Rearrange code in acpi_ec_submit_event()
      ACPI: scan: Use ida_alloc() instead of ida_simple_get()
      ACPI: bus: Introduce acpi_bus_for_each_dev()
      ACPICA: Avoid walking the ACPI Namespace if it is not there
      Revert "ACPI: Pass the same capabilities to the _OSC regardless
of the query flag"
      ACPI: bus: Avoid using CPPC if not supported by firmware

Randy Dunlap (2):
      ACPI: APEI: fix return value of __setup handlers
      clocksource: acpi_pm: fix return value of __setup handler

Robert Kiraly (1):
      ACPI: tables: Add CEDT signature to the list of known tables

Sakari Ailus (1):
      ACPI: properties: Consistently return -ENOENT if there are no
more references

Shuai Xue (2):
      ACPI: APEI: explicit init of HEST and GHES in apci_init()
      ACPI: APEI: rename ghes_init() with an "acpi_" prefix

Srinivas Pandruvada (6):
      ACPI: fan: Fix error reporting to user space
      ACPI: fan: Separate file for attributes creation
      ACPI: fan: Optimize struct acpi_fan_fif
      ACPI: fan: Properly handle fine grain control
      ACPI: fan: Add additional attributes for fine grain control
      Documentation/admin-guide/acpi: Add documentation for fine grain control

Tom Rix (1):
      ACPI: clean up double words in two comments

Werner Sembach (1):
      ACPI: video: Force backlight native for Clevo NL5xRU and NL5xNU

---------------

 .../admin-guide/acpi/fan_performance_states.rst    |  28 +++
 Documentation/driver-api/gpio/board.rst            |  21 +--
 Documentation/firmware-guide/acpi/enumeration.rst  | 111 +++++------
 .../firmware-guide/acpi/gpio-properties.rst        |  26 +--
 arch/arm64/include/asm/topology.h                  |   4 +
 arch/x86/include/asm/topology.h                    |  15 +-
 arch/x86/kernel/acpi/Makefile                      |   2 +-
 arch/x86/kernel/acpi/boot.c                        |  24 +++
 arch/x86/kernel/acpi/cppc.c                        | 103 +++++++++++
 arch/x86/kernel/acpi/cppc_msr.c                    |  49 -----
 arch/x86/kernel/smpboot.c                          |  72 +-------
 drivers/acpi/Kconfig                               |   2 +-
 drivers/acpi/Makefile                              |   3 +
 drivers/acpi/acpi_lpss.c                           |  33 +++-
 drivers/acpi/acpi_platform.c                       |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   3 +
 drivers/acpi/apei/bert.c                           |  10 +-
 drivers/acpi/apei/erst.c                           |   2 +-
 drivers/acpi/apei/ghes.c                           |  19 +-
 drivers/acpi/apei/hest.c                           |   2 +-
 drivers/acpi/arm64/Kconfig                         |  10 +
 drivers/acpi/arm64/Makefile                        |   1 +
 drivers/acpi/arm64/agdi.c                          | 116 ++++++++++++
 drivers/acpi/battery.c                             |  12 ++
 drivers/acpi/bus.c                                 |  46 ++++-
 drivers/acpi/cppc_acpi.c                           |   9 +-
 drivers/acpi/ec.c                                  |  90 ++++-----
 drivers/acpi/fan.h                                 |  44 +++++
 drivers/acpi/fan_attr.c                            | 137 ++++++++++++++
 drivers/acpi/{fan.c => fan_core.c}                 | 204 +++++++++------------
 drivers/acpi/internal.h                            |   2 -
 drivers/acpi/osl.c                                 |  19 +-
 drivers/acpi/pci_link.c                            |   2 +-
 drivers/acpi/pci_root.c                            |   3 -
 drivers/acpi/property.c                            |  29 +--
 drivers/acpi/scan.c                                |   5 +-
 drivers/acpi/sleep.c                               |   2 +
 drivers/acpi/tables.c                              |   2 +-
 drivers/acpi/video_detect.c                        |  75 ++++++++
 drivers/acpi/x86/utils.c                           |  21 +++
 drivers/base/arch_topology.c                       |  45 ++++-
 drivers/clocksource/acpi_pm.c                      |   6 +-
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/arm_sdei.c                        |  13 +-
 drivers/usb/typec/port-mapper.c                    |   2 +-
 include/acpi/acpi_bus.h                            |   2 +
 include/acpi/actypes.h                             |   4 +
 include/acpi/apei.h                                |   4 +-
 include/acpi/platform/aclinux.h                    |   5 +
 include/linux/acpi.h                               |   5 +-
 include/linux/acpi_agdi.h                          |  13 ++
 include/linux/arch_topology.h                      |   4 +
 include/linux/arm_sdei.h                           |   2 +
 53 files changed, 1007 insertions(+), 459 deletions(-)
