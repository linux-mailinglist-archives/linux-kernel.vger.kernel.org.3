Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576794E2E29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351269AbiCUQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351258AbiCUQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:37:43 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5FE51E7D;
        Mon, 21 Mar 2022 09:36:17 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2e5757b57caso162063357b3.4;
        Mon, 21 Mar 2022 09:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gcEWXZl7oxXy4I/zptsRAcc5tMs/kQWqSSJ68DwK/L0=;
        b=GJMYErHCKbtSaQDZnzz5EhUicjvezeRwe1YNAIYOURjIH68xgJxN12ec4couxKA7YV
         HMdwBXK/GshUliRBsdHiZWPcGsnqDyOqJj2sdro5X6og1q+Vg1+gaUW5R7hrLOyk9LrY
         5/pAXNYa+6bVXNcTIKG21wMyXvbJ6nWn3jD8RMlCuqrrF2QTeWZr0ajWTfe1OBWFx3I/
         C8kgonn0SM4nAbcqjABVdH18ROnkP2FwsLVClBlPzi78MkXAwS3DJYQfPzbdH4Y9Gp8u
         L8FjzHPQAIvsi4fPkED8TP9DoQx7vSPnmr2ab7a5TW036j19J0sBS9eIQtzYD4H2PN5+
         Ng0g==
X-Gm-Message-State: AOAM532V3tCXiJ73FM5KaQWOuaS+cDUeLEUJBUVTZ+0Mjm/ZVAagEDsX
        f7zInpnZdZSEFkWNsJa6sp2AJvOXB6TzlQ38BKiwZmv+Hf4=
X-Google-Smtp-Source: ABdhPJw8F1NAELLxNZMiF6TcZXL6m9vymaM4dVoZ09EJxVoOYQwrFxScZV5iWWpOtqIdrRvhfIWfhu1bWH2yoqpdCn0=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr25608873ywm.19.1647880576362; Mon, 21
 Mar 2022 09:36:16 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Mar 2022 17:36:05 +0100
Message-ID: <CAJZ5v0i+dDvX2J7CHfawmFXynifkNZ-0ZHYnraYv-HYJN5bdbA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
 pm-5.18-rc1

with top-most commit ec3d8b8365e9865b43099e943ec5f0bc12f28f96

 Merge branch 'pm-tools'

on top of commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3

 Linux 5.17-rc6

to receive power management updates for 5.18-rc1.

These are mostly fixes and cleanups all over the code and a new
piece of documentation for Intel uncore frequency scaling.

Functionality-wise, the intel_idle driver will support Sapphire
Rapids Xeons natively now (with some extra facilities for controlling
C-states more precisely on those systems), virtual guests will take
the ACPI S4 hardware signature into account by default, the
intel_pstate driver will take the defualt EPP value from the
firmware, cpupower utility will support the AMD P-state driver added
in the previous cycle and there is a new tracer utility for that
driver.

Specifics:

 - Allow device_pm_check_callbacks() to be called from interrupt
   context without issues (Dmitry Baryshkov).

 - Modify devm_pm_runtime_enable() to automatically handle
   pm_runtime_dont_use_autosuspend() at driver exit time (Douglas
   Anderson).

 - Make the schedutil cpufreq governor use to_gov_attr_set() instead
   of open coding it (Kevin Hao).

 - Replace acpi_bus_get_device() with acpi_fetch_acpi_dev() in the
   cpufreq longhaul driver (Rafael Wysocki).

 - Unify show() and store() naming in cpufreq and make it use
   __ATTR_XX (Lianjie Zhang).

 - Make the intel_pstate driver use the EPP value set by the firmware
   by default (Srinivas Pandruvada).

 - Re-order the init checks in the powernow-k8 cpufreq driver (Mario
   Limonciello).

 - Make the ACPI processor idle driver check for architectural
   support for LPI to avoid using it on x86 by mistake (Mario
   Limonciello).

 - Add Sapphire Rapids Xeon support to the intel_idle driver (Artem
   Bityutskiy).

 - Add 'preferred_cstates' module argument to the intel_idle driver
   to work around C1 and C1E handling issue on Sapphire Rapids (Artem
   Bityutskiy).

 - Add core C6 optimization on Sapphire Rapids to the intel_idle
   driver (Artem Bityutskiy).

 - Optimize the haltpoll cpuidle driver a bit (Li RongQing).

 - Remove leftover text from intel_idle() kerneldoc comment and fix
   up white space in intel_idle (Rafael Wysocki).

 - Fix load_image_and_restore() error path (Ye Bin).

 - Fix typos in comments in the system wakeup hadling code (Tom Rix).

 - Clean up non-kernel-doc comments in hibernation code (Jiapeng
   Chong).

 - Fix __setup handler error handling in system-wide suspend and
   hibernation core code (Randy Dunlap).

 - Add device name to suspend_report_result() (Youngjin Jang).

 - Make virtual guests honour ACPI S4 hardware signature by
   default (David Woodhouse).

 - Block power off of a parent PM domain unless child is in deepest
   state (Ulf Hansson).

 - Use dev_err_probe() to simplify error handling for generic PM
   domains (Ahmad Fatoum).

 - Fix sleep-in-atomic bug caused by genpd_debug_remove() (Shawn Guo).

 - Document Intel uncore frequency scaling (Srinivas Pandruvada).

 - Add DTPM hierarchy description (Daniel Lezcano).

 - Change the locking scheme in DTPM (Daniel Lezcano).

 - Fix dtpm_cpu cleanup at exit time and missing virtual DTPM pointer
   release (Daniel Lezcano).

 - Make dtpm_node_callback[] static (kernel test robot).

 - Fix spelling mistake "initialze" -> "initialize" in
   dtpm_create_hierarchy() (Colin Ian King).

 - Add tracer tool for the amd-pstate driver (Jinzhou Su).

 - Fix PC6 displaying in turbostat on some systems (Artem Bityutskiy).

 - Add AMD P-State support to the cpupower utility (Huang Rui).

Thanks!


---------------

Ahmad Fatoum (1):
      PM: domains: use dev_err_probe() to simplify error handling

Andreas Rammhold (1):
      tools: cpupower: fix typo in cpupower-idle-set(1) manpage

Artem Bityutskiy (4):
      intel_idle: add SPR support
      intel_idle: add 'preferred_cstates' module argument
      intel_idle: add core C6 optimization for SPR
      turbostat: fix PC6 displaying on some systems

Colin Ian King (1):
      powercap: DTPM: Fix spelling mistake "initialze" -> "initialize"

Daniel Lezcano (12):
      powercap/drivers/dtpm: Convert the init table section to a simple array
      powercap/drivers/dtpm: Add hierarchy creation
      powercap/drivers/dtpm: Add CPU DT initialization support
      powercap/drivers/dtpm: Add dtpm devfreq with energy model support
      rockchip/soc/drivers: Add DTPM description for rk3399
      powercap/dtpm: Change locking scheme
      powercap/dtpm_cpu: Reset per_cpu variable in the release function
      powercap/dtpm: Fixup kfree for virtual node
      powercap/dtpm: Destroy hierarchy function
      powercap/dtpm: Move the 'root' reset place
      powercap/dtpm_cpu: Add exit function
      dtpm/soc/rk3399: Add the ability to unload the module

David Woodhouse (1):
      PM: hibernate: Honour ACPI hardware signature by default for
virtual guests

Dmitry Baryshkov (1):
      PM: core: keep irq flags in device_pm_check_callbacks()

Douglas Anderson (1):
      PM: runtime: Have devm_pm_runtime_enable() handle
pm_runtime_dont_use_autosuspend()

Huang Rui (10):
      cpupower: Add AMD P-State capability flag
      cpupower: Add the function to check AMD P-State enabled
      cpupower: Initial AMD P-State capability
      cpupower: Add the function to get the sysfs value from specific table
      cpupower: Introduce ACPI CPPC library
      cpupower: Add AMD P-State sysfs definition and access helper
      cpupower: Enable boost state support for AMD P-State module
      cpupower: Move print_speed function into misc helper
      cpupower: Add function to print AMD P-State performance capabilities
      cpupower: Add "perf" option to print AMD P-State information

Jiapeng Chong (1):
      PM: hibernate: Clean up non-kernel-doc comments

Jinzhou Su (4):
      cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
      tools/power/x86/intel_pstate_tracer: make tracer as a module
      tools/power/x86/amd_pstate_tracer: Add tracer tool for AMD P-state
      Documentation: amd-pstate: add tracer tool introduction

Kevin Hao (2):
      cpufreq: Move to_gov_attr_set() to cpufreq.h
      cpufreq: schedutil: Use to_gov_attr_set() to get the gov_attr_set

Li RongQing (1):
      cpuidle: haltpoll: Call cpuidle_poll_state_init() later

Lianjie Zhang (1):
      cpufreq: unify show() and store() naming and use __ATTR_XX

Mario Limonciello (3):
      cpuidle: PSCI: Move the `has_lpi` check to the beginning of the function
      ACPI: processor idle: Check for architectural support for LPI
      cpufreq: powernow-k8: Re-order the init checks

Rafael J. Wysocki (3):
      cpufreq: longhaul: Replace acpi_bus_get_device()
      cpuidle: intel_idle: Update intel_idle() kerneldoc comment
      cpuidle: intel_idle: Drop redundant backslash at line end

Randy Dunlap (2):
      PM: hibernate: fix __setup handler error handling
      PM: suspend: fix return value of __setup handler

Shawn Guo (1):
      PM: domains: Fix sleep-in-atomic bug caused by genpd_debug_remove()

Srinivas Pandruvada (2):
      Documentation: admin-guide: pm: Document uncore frequency scaling
      cpufreq: intel_pstate: Use firmware default EPP

Tom Rix (1):
      PM: sleep: wakeup: Fix typos in comments

Ulf Hansson (1):
      PM: domains: Prevent power off for parent unless child is in deepest state

Ye Bin (1):
      PM: hibernate: fix load_image_and_restore() error path

Youngjin Jang (1):
      PM: sleep: Add device name to suspend_report_result()

kernel test robot (1):
      powercap: DTPM: dtpm_node_callback[] can be static

ozkanonur (1):
      tools/power/cpupower/{ToDo => TODO}: Rename the todo file

---------------

 Documentation/admin-guide/pm/amd-pstate.rst        |  26 ++
 .../pm/intel_uncore_frequency_scaling.rst          |  60 ++++
 Documentation/admin-guide/pm/working-state.rst     |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm64/kernel/cpuidle.c                        |   6 +-
 arch/x86/kernel/acpi/sleep.c                       |  23 +-
 drivers/acpi/processor_idle.c                      |  15 +-
 drivers/acpi/sleep.c                               |  11 +-
 drivers/base/power/domain.c                        |  42 ++-
 drivers/base/power/main.c                          |  16 +-
 drivers/base/power/runtime.c                       |   5 +
 drivers/base/power/wakeirq.c                       |   2 +-
 drivers/base/power/wakeup.c                        |   4 +-
 drivers/cpufreq/amd-pstate-trace.h                 |  22 +-
 drivers/cpufreq/amd-pstate.c                       |  59 +++-
 drivers/cpufreq/cpufreq_conservative.c             |  10 +-
 drivers/cpufreq/cpufreq_governor.c                 |   6 +-
 drivers/cpufreq/cpufreq_governor.h                 |  12 +-
 drivers/cpufreq/cpufreq_governor_attr_set.c        |   5 -
 drivers/cpufreq/cpufreq_ondemand.c                 |  10 +-
 drivers/cpufreq/intel_pstate.c                     |  38 ++-
 drivers/cpufreq/longhaul.c                         |   4 +-
 drivers/cpufreq/powernow-k8.c                      |   6 +-
 drivers/cpuidle/cpuidle-haltpoll.c                 |   4 +-
 drivers/idle/intel_idle.c                          | 111 ++++++-
 drivers/pci/pci-driver.c                           |  14 +-
 drivers/pnp/driver.c                               |   2 +-
 drivers/powercap/Kconfig                           |   8 +
 drivers/powercap/Makefile                          |   1 +
 drivers/powercap/dtpm.c                            | 333 ++++++++++++++-----
 drivers/powercap/dtpm_cpu.c                        |  55 +++-
 drivers/powercap/dtpm_devfreq.c                    | 203 ++++++++++++
 drivers/powercap/dtpm_subsys.h                     |  22 ++
 drivers/soc/rockchip/Kconfig                       |   8 +
 drivers/soc/rockchip/Makefile                      |   1 +
 drivers/soc/rockchip/dtpm.c                        |  65 ++++
 drivers/usb/core/hcd-pci.c                         |   4 +-
 include/asm-generic/vmlinux.lds.h                  |  11 -
 include/linux/acpi.h                               |   2 +-
 include/linux/cpufreq.h                            |   5 +
 include/linux/dtpm.h                               |  36 +--
 include/linux/pm.h                                 |   8 +-
 include/linux/pm_runtime.h                         |   4 +
 kernel/power/hibernate.c                           |   6 +-
 kernel/power/suspend_test.c                        |   8 +-
 kernel/power/swap.c                                |   8 +-
 kernel/sched/cpufreq_schedutil.c                   |   2 +-
 tools/power/cpupower/Makefile                      |   6 +-
 tools/power/cpupower/{ToDo => TODO}                |   0
 tools/power/cpupower/lib/acpi_cppc.c               |  59 ++++
 tools/power/cpupower/lib/acpi_cppc.h               |  21 ++
 tools/power/cpupower/lib/cpufreq.c                 |  23 +-
 tools/power/cpupower/lib/cpufreq.h                 |  12 +
 tools/power/cpupower/man/cpupower-frequency-info.1 |   3 +
 tools/power/cpupower/man/cpupower-idle-set.1       |   2 +-
 tools/power/cpupower/utils/cpufreq-info.c          |  87 ++---
 tools/power/cpupower/utils/helpers/amd.c           |  77 +++++
 tools/power/cpupower/utils/helpers/cpuid.c         |  13 +
 tools/power/cpupower/utils/helpers/helpers.h       |  22 ++
 tools/power/cpupower/utils/helpers/misc.c          |  60 ++++
 .../x86/amd_pstate_tracer/amd_pstate_trace.py      | 354 +++++++++++++++++++++
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py | 260 ++++++++-------
 tools/power/x86/turbostat/turbostat.c              |   2 +-
 63 files changed, 1888 insertions(+), 418 deletions(-)
