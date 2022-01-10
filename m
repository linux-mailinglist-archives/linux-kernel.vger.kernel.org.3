Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02848A000
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbiAJTQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:16:43 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:33624 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiAJTQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:16:41 -0500
Received: by mail-qk1-f178.google.com with SMTP id b127so5446874qkd.0;
        Mon, 10 Jan 2022 11:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=715mf0IoeIH7IwYf/E3qVJpnqkm0zOIzT2GiFjhzg08=;
        b=IFeq4DJnSfyknmga3forMRvc8ejb3LFGeJxYPW5/6PjieehyJ2qHxFmTx1hSYEfN3l
         vgiGqejOQ8HuYfK/wGUj/wLx2uaAuJWUCD7hoj8ScpTytQrhhAK1lwVJvm6bAfK/ZQYn
         vXIHaZb2iSsPJyVD2lAUSUBr0PBRwbjFnViCefE0ep9wRsmMzYvfeeOVEAsnOWkNijtI
         fGCa6oVSe9VGWdkyKGr7L8Q6iBkb0Q/Fe7+YLQm6oTkFSzCRjbhp2KgXt9N4hvsQ064F
         U1dwAdxYhbnaWDwxNorFAXTe2cKtsRr0sbNN3SnG4Z/qay44w/DKfJoc/GJbNdAxvLxm
         3b3g==
X-Gm-Message-State: AOAM530O5Ph8ujmBT0MvZbLS4AEKvuCJBhgMTfFSC7o8aDcWIvRxXCBz
        u0eIEf9KZuU8uViHLvhjSf2dVgzC7UpCcHoA6bljPV8pvlw=
X-Google-Smtp-Source: ABdhPJwa6Wq43oRWqoj1MEQkS/8HsVSSNy/JCK8wfWR0ZoQ/9r7PWgyK/2EfxsZGCzSfGjMSqgGlZQ2f1XVhZncRaOw=
X-Received: by 2002:a05:620a:2001:: with SMTP id c1mr900944qka.374.1641842200763;
 Mon, 10 Jan 2022 11:16:40 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Jan 2022 20:16:29 +0100
Message-ID: <CAJZ5v0jHk1fP=V_iDGKVOeYg4xt-EEdgi5UUtQA4_qrQvUibNA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.17-rc1

with top-most commit 78e6e4dfd8f0cbb477a6f9571123edcbd5873c28

 Merge branches 'pm-opp', 'pm-devfreq' and 'powercap'

on top of commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48

 Linux 5.16-rc8

to receive power management updates for 5.17-rc1.

The most signigicant change here is the addition of a new cpufreq
"P-state" driver for AMD processors as a better replacement for
the venerable acpi-cpufreq driver.  There are also other cpufreq
updates (in the core, intel_pstate, ARM drivers), PM core updates
(mostly related to adding new macros for declaring PM operations
which should make the lives of driver developers somewhat easier),
and a bunch of assorted fixes and cleanups.

Specifics:

 - Add new P-state driver for AMD processors (Huang Rui).

 - Fix initialization of min and max frequency QoS requests in the
   cpufreq core (Rafael Wysocki).

 - Fix EPP handling on Alder Lake in intel_pstate (Srinivas Pandruvada).

 - Make intel_pstate update cpuinfo.max_freq when notified of HWP
   capabilities changes and drop a redundant function call from that
   driver (Rafael Wysocki).

 - Improve IRQ support in the Qcom cpufreq driver (Ard Biesheuvel,
   Stephen Boyd, Vladimir Zapolskiy).

 - Fix double devm_remap() in the Mediatek cpufreq driver (Hector Yuan).

 - Introduce thermal pressure helpers for cpufreq CPU cooling (Lukasz
   Luba).

 - Make cpufreq use default_groups in kobj_type (Greg Kroah-Hartman).

 - Make cpuidle use default_groups in kobj_type (Greg Kroah-Hartman).

 - Fix two comments in cpuidle code (Jason Wang, Yang Li).

 - Allow model-specific normal EPB value to be used in the intel_epb
   sysfs attribute handling code (Srinivas Pandruvada).

 - Simplify locking in pm_runtime_put_suppliers() (Rafael Wysocki).

 - Add safety net to supplier device release in the runtime PM core
   code (Rafael Wysocki).

 - Capture device status before disabling runtime PM for it (Rafael
   Wysocki).

 - Add new macros for declaring PM operations to allow drivers to
   avoid guarding them with CONFIG_PM #ifdefs or __maybe_unused and
   update some drivers to use these macros (Paul Cercueil).

 - Allow ACPI hardware signature to be honoured during restore from
   hibernation (David Woodhouse).

 - Update outdated operating performance points (OPP) documentation
   (Tang Yizhou).

 - Reduce log severity for informative message regarding frequency
   transition failures in devfreq (Tzung-Bi Shih).

 - Add DRAM frequency controller devfreq driver for Allwinner sunXi
   SoCs (Samuel Holland).

 - Add missing COMMON_CLK dependency to sun8i devfreq driver (Arnd
   Bergmann).

 - Add support for new layout of Psys PowerLimit Register on SPR to
   the Intel RAPL power capping driver (Zhang Rui).

 - Fix typo in a comment in idle_inject.c (Jason Wang).

 - Remove unused function definition from the DTPM (Dynamit Thermal
   Power Management) power capping framework (Daniel Lezcano).

 - Reduce DTPM trace verbosity (Daniel Lezcano).

Thanks!


---------------

Ard Biesheuvel (1):
      cpufreq: qcom-cpufreq-hw: Avoid stack buffer for IRQ name

Arnd Bergmann (1):
      PM / devfreq: sun8i: addd COMMON_CLK dependency

Daniel Lezcano (2):
      powercap/drivers/dtpm: Remove unused function definition
      powercap/drivers/dtpm: Reduce trace verbosity

David Woodhouse (1):
      PM: hibernate: Allow ACPI hardware signature to be honoured

Greg Kroah-Hartman (2):
      cpufreq: use default_groups in kobj_type
      cpuidle: use default_groups in kobj_type

Hector.Yuan (1):
      cpufreq: mediatek-hw: Fix double devm_remap in hotplug case

Huang Rui (13):
      x86/cpufeatures: Add AMD Collaborative Processor Performance
Control feature flag
      x86/msr: Add AMD CPPC MSR definitions
      cpufreq: amd-pstate: Introduce a new AMD P-State driver to
support future processors
      cpufreq: amd-pstate: Add fast switch function for AMD P-State
      cpufreq: amd-pstate: Introduce the support for the processors
with shared memory solution
      cpufreq: amd-pstate: Add trace for AMD P-State module
      cpufreq: amd-pstate: Add boost mode support for AMD P-State
      cpufreq: amd-pstate: Add AMD P-State frequencies attributes
      cpufreq: amd-pstate: Add AMD P-State performance attributes
      Documentation: amd-pstate: Add AMD P-State driver introduction
      MAINTAINERS: Add AMD P-State driver maintainer entry
      cpufreq: amd-pstate: Fix Kconfig dependencies for AMD P-State
      x86, sched: Fix undefined reference to
init_freq_invariance_cppc() build error

Jason Wang (2):
      cpuidle: menu: Fix typo in a comment
      powercap: fix typo in a comment in idle_inject.c

Jinzhou Su (1):
      ACPI: CPPC: Add CPPC enable register function

Lukasz Luba (5):
      arch_topology: Introduce thermal pressure update function
      thermal: cpufreq_cooling: Use new thermal pressure update function
      cpufreq: qcom-cpufreq-hw: Update offline CPUs per-cpu thermal pressure
      cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function
      arch_topology: Remove unused topology_set_thermal_pressure() and related

Mario Limonciello (1):
      ACPI: CPPC: Check present CPUs for determining _CPC is valid

Paul Cercueil (5):
      r8169: Avoid misuse of pm_ptr() macro
      PM: core: Redefine pm_ptr() macro
      PM: core: Add new *_PM_OPS macros, deprecate old ones
      mmc: jz4740: Use the new PM macros
      mmc: mxc: Use the new PM macros

Rafael J. Wysocki (6):
      PM: runtime: Capture device status before disabling runtime PM
      PM: runtime: Add safety net to supplier device release
      cpufreq: intel_pstate: Drop redundant intel_pstate_get_hwp_cap() call
      cpufreq: Fix initialization of min and max frequency QoS requests
      cpufreq: intel_pstate: Update cpuinfo.max_freq on HWP_CAP changes
      PM: runtime: Simplify locking in pm_runtime_put_suppliers()

Samuel Holland (1):
      PM / devfreq: Add a driver for the sun8i/sun50i MBUS

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Update EPP for AlderLake mobile
      x86: intel_epb: Allow model specific normal EPB value

Stephen Boyd (1):
      cpufreq: qcom-hw: Use optional irq API

Steven Noonan (1):
      ACPI: CPPC: Implement support for SystemIO registers

Tang Yizhou (1):
      Documentation: power: Update outdated contents in opp.rst

Tzung-Bi Shih (1):
      PM / devfreq: Reduce log severity for informative message

Vladimir Zapolskiy (2):
      cpufreq: qcom-hw: Fix probable nested interrupt handling
      cpufreq: qcom-hw: Set CPU affinity of dcvsh interrupts

Yang Li (2):
      cpuidle: Fix cpuidle_remove_state_sysfs() kerneldoc comment
      cpufreq: amd-pstate: Fix struct amd_cpudata kernel-doc comment

Zhang Rui (1):
      powercap: intel_rapl: support new layout of Psys PowerLimit
Register on SPR

---------------

 Documentation/admin-guide/acpi/cppc_sysfs.rst   |   2 +
 Documentation/admin-guide/kernel-parameters.txt |  15 +-
 Documentation/admin-guide/pm/amd-pstate.rst     | 382 ++++++++++++++
 Documentation/admin-guide/pm/working-state.rst  |   1 +
 Documentation/power/opp.rst                     |  14 +-
 Documentation/power/runtime_pm.rst              |  14 +-
 MAINTAINERS                                     |   7 +
 arch/arm/include/asm/topology.h                 |   2 +-
 arch/arm64/include/asm/topology.h               |   2 +-
 arch/x86/include/asm/cpufeatures.h              |   1 +
 arch/x86/include/asm/msr-index.h                |  17 +
 arch/x86/include/asm/topology.h                 |   2 +-
 arch/x86/kernel/acpi/sleep.c                    |   4 +-
 arch/x86/kernel/cpu/intel_epb.c                 |  45 +-
 drivers/acpi/cppc_acpi.c                        |  99 +++-
 drivers/acpi/sleep.c                            |  26 +-
 drivers/base/arch_topology.c                    |  42 +-
 drivers/base/core.c                             |   3 +-
 drivers/base/power/runtime.c                    |  98 ++--
 drivers/cpufreq/Kconfig.x86                     |  17 +
 drivers/cpufreq/Makefile                        |   5 +
 drivers/cpufreq/amd-pstate-trace.c              |   2 +
 drivers/cpufreq/amd-pstate-trace.h              |  77 +++
 drivers/cpufreq/amd-pstate.c                    | 645 ++++++++++++++++++++++++
 drivers/cpufreq/cpufreq.c                       |   9 +-
 drivers/cpufreq/cpufreq_conservative.c          |   5 +-
 drivers/cpufreq/cpufreq_ondemand.c              |   5 +-
 drivers/cpufreq/intel_pstate.c                  | 121 +++--
 drivers/cpufreq/mediatek-cpufreq-hw.c           |  33 +-
 drivers/cpufreq/qcom-cpufreq-hw.c               |  39 +-
 drivers/cpuidle/governors/menu.c                |   2 +-
 drivers/cpuidle/sysfs.c                         |   8 +-
 drivers/devfreq/Kconfig                         |   9 +
 drivers/devfreq/Makefile                        |   1 +
 drivers/devfreq/devfreq.c                       |   4 +-
 drivers/devfreq/sun8i-a33-mbus.c                | 511 +++++++++++++++++++
 drivers/mmc/host/jz4740_mmc.c                   |   8 +-
 drivers/mmc/host/mxcmmc.c                       |   6 +-
 drivers/net/ethernet/realtek/r8169_main.c       |   4 +-
 drivers/powercap/dtpm.c                         |   6 +-
 drivers/powercap/idle_inject.c                  |   2 +-
 drivers/powercap/intel_rapl_common.c            |  61 ++-
 drivers/thermal/cpufreq_cooling.c               |   6 +-
 include/acpi/cppc_acpi.h                        |   5 +
 include/linux/acpi.h                            |   2 +-
 include/linux/arch_topology.h                   |   4 +-
 include/linux/dtpm.h                            |   2 -
 include/linux/intel_rapl.h                      |   6 +
 include/linux/pm.h                              |  82 +--
 include/linux/pm_runtime.h                      |   3 +
 include/linux/sched/topology.h                  |   6 +-
 include/linux/suspend.h                         |   1 +
 init/Kconfig                                    |   2 +-
 kernel/power/power.h                            |   1 +
 kernel/power/swap.c                             |  16 +-
 55 files changed, 2274 insertions(+), 218 deletions(-)
