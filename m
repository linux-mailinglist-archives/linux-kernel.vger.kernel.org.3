Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7545316B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiEWTnX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 May 2022 15:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiEWTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:42:53 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B73D8;
        Mon, 23 May 2022 12:42:33 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id d137so27214592ybc.13;
        Mon, 23 May 2022 12:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Fj/OpzWZFCIbCTU6BT7NErmOvtdXQjyKLPhUjJvPsZI=;
        b=zmIKLJwzMEeX/UjLXqbPzGQBKcNmXYkUmvmJlRC6iPvZzBYuh4v58nEJwYooAlDmQu
         RwumVQ0C1PDZLk0IU7CtUtNgrYUeSYubGQwrlE94TgyzrLRvxpyVPawT3D9vxNmATj8/
         QYMQRXdW5W2PJ2qcENNheWcf9rNhyK4EGHQegSZEePO4U8vbX0iSTFxFiUCKfYKYqCGh
         RrXdZ9B2krCRiEh/km3HXYZBvoRxpqYCAQb05Lk/W9wIHw369UlmBW/yS1EUMJTd8aI3
         tx2FwNYys1+XDme106dID/d7ZJAdFkDlUr5PN5APYOfzScWaIXsQYBREPEcWOIixBn22
         TiAA==
X-Gm-Message-State: AOAM532C2KCGZ5ikYcv+ukmcuFGe7cr9V8nvCRrDZPqJ3iNW2avLBFDW
        +TISBAObUm/5efueEAS2LzAszgoiyu/JN+SMLvb+6lamWHE=
X-Google-Smtp-Source: ABdhPJzCQZdHarxpehn7z3mBO6JP5/1KETp1N8jqBF7HtQbNu+yU36E2JTRk9F7hvBk51gNrgp5oS2HdDGUi9nSniHg=
X-Received: by 2002:a25:2004:0:b0:650:740:f31d with SMTP id
 g4-20020a252004000000b006500740f31dmr3905294ybg.81.1653334953110; Mon, 23 May
 2022 12:42:33 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 May 2022 21:42:22 +0200
Message-ID: <CAJZ5v0hKBt3js65w18iKxzWoN5QuEc84_2xcM6paSv-ZHwe3Rw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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
 pm-5.19-rc1

with top-most commit 0d64482bf29917e659c556aa36cea241b17c33df

 Merge branch 'pm-tools'

on top of commit 42226c989789d8da4af1de0c31070c96726d990c

 Linux 5.18-rc7

to receive power management updates for 5.19-rc1.

These add support for "artificial" Energy Models in which power numbers
for different entities may be in different scales, add support for some
new hardware, fix bugs and clean up code in multiple places.

Specifics:

 - Update the Energy Model support code to allow the Energy Model to be
   artificial, which means that the power values may not be on a uniform
   scale with other devices providing power information, and update the
   cpufreq_cooling and devfreq_cooling thermal drivers to support
   artificial Energy Models (Lukasz Luba).

 - Make DTPM check the Energy Model type (Lukasz Luba).

 - Fix policy counter decrementation in cpufreq if Energy Model is in
   use (Pierre Gondois).

 - Add CPU-based scaling support to passive devfreq governor (Saravana
   Kannan, Chanwoo Choi).

 - Update the rk3399_dmc devfreq driver (Brian Norris).

 - Export dev_pm_ops instead of suspend() and resume() in the IIO
   chemical scd30 driver (Jonathan Cameron).

 - Add namespace variants of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and
   PM-runtime counterparts (Jonathan Cameron).

 - Move symbol exports in the IIO chemical scd30 driver into the
   IIO_SCD30 namespace (Jonathan Cameron).

 - Avoid device PM-runtime usage count underflows (Rafael Wysocki).

 - Allow dynamic debug to control printing of PM messages  (David
   Cohen).

 - Fix some kernel-doc comments in hibernation code (Yang Li, Haowen
   Bai).

 - Preserve ACPI-table override during hibernation (Amadeusz Sławiński).

 - Improve support for suspend-to-RAM for PSCI OSI mode (Ulf Hansson).

 - Make Intel RAPL power capping driver support the RaptorLake and
   AlderLake N processors (Zhang Rui, Sumeet Pawnikar).

 - Remove redundant store to value after multiply in the RAPL power
   capping driver (Colin Ian King).

 - Add AlderLake processor support to the intel_idle driver (Zhang Rui).

 - Fix regression leading to no genpd governor in the PSCI cpuidle
   driver and fix the riscv-sbi cpuidle driver to allow a genpd
   governor to be used (Ulf Hansson).

 - Fix cpufreq governor clean up code to avoid using kfree() directly
   to free kobject-based items (Kevin Hao).

 - Prepare cpufreq for powerpc's asm/prom.h cleanup (Christophe Leroy).

 - Make intel_pstate notify frequency invariance code when no_turbo is
   turned on and off (Chen Yu).

 - Add Sapphire Rapids OOB mode support to intel_pstate (Srinivas
   Pandruvada).

 - Make cpufreq avoid unnecessary frequency updates due to mismatch
   between hardware and the frequency table (Viresh Kumar).

 - Make remove_cpu_dev_symlink() clear the real_cpus mask to simplify
   code (Viresh Kumar).

 - Rearrange cpufreq_offline() and cpufreq_remove_dev() to make the
   calling convention for some driver callbacks consistent (Rafael
   Wysocki).

 - Avoid accessing half-initialized cpufreq policies from the show()
   and store() sysfs functions (Schspa Shi).

 - Rearrange cpufreq_offline() to make the calling convention for some
   driver callbacks consistent (Schspa Shi).

 - Update CPPC handling in cpufreq (Pierre Gondois).

 - Extend dev_pm_domain_detach() doc (Krzysztof Kozlowski).

 - Move genpd's time-accounting to ktime_get_mono_fast_ns() (Ulf
   Hansson).

 - Improve the way genpd deals with its governors (Ulf Hansson).

 - Update the turbostat utility to version 2022.04.16 (Len Brown,
   Dan Merillat, Sumeet Pawnikar, Zephaniah E. Loss-Cutler-Hull, Chen
   Yu).

Thanks!


---------------

Amadeusz Sławiński (1):
      x86/ACPI: Preserve ACPI-table override during hibernation

Brian Norris (15):
      dt-bindings: devfreq: rk3399_dmc: Convert to YAML
      dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant properties
      dt-bindings: devfreq: rk3399_dmc: Fix Hz units
      dt-bindings: devfreq: rk3399_dmc: Specify idle params in nanoseconds
      dt-bindings: devfreq: rk3399_dmc: Add more disable-freq properties
      PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
      PM / devfreq: rk3399_dmc: Drop excess timing properties
      PM / devfreq: rk3399_dmc: Use bitfield macro definitions for ODT_PD
      PM / devfreq: rk3399_dmc: Support new disable-freq properties
      PM / devfreq: rk3399_dmc: Support new *-ns properties
      PM / devfreq: rk3399_dmc: Disable edev on remove()
      PM / devfreq: rk3399_dmc: Use devm_pm_opp_of_add_table()
      PM / devfreq: rk3399_dmc: Avoid static (reused) profile
      soc: rockchip: power-domain: Manage resource conflicts with firmware
      PM / devfreq: rk3399_dmc: Block PMU during transitions

Chanwoo Choi (4):
      PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
      PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
      PM / devfreq: passive: Keep cpufreq_policy for possible cpus
      PM / devfreq: passive: Return non-error when not-supported event
is required

Chen Yu (2):
      cpufreq: intel_pstate: Handle no_turbo in frequency invariance
      tools/power turbostat: Support thermal throttle count print

Christophe Leroy (1):
      cpufreq: Prepare cleanup of powerpc's asm/prom.h

Colin Ian King (1):
      powercap: intel_rapl: remove redundant store to value after multiply

Dan Merillat (1):
      tools/power turbostat: fix dump for AMD cpus

David Cohen (2):
      PM: sleep: Narrow down -DDEBUG on kernel/power/ files
      PM: sleep: enable dynamic debug support within pm_pr_dbg()

Haowen Bai (1):
      PM: hibernate: Don't mark comment as kernel-doc

Jonathan Cameron (3):
      iio: chemical: scd30: Export dev_pm_ops instead of suspend() and resume()
      PM: core: Add NS varients of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and
runtime pm equiv
      iio: chemical: scd30: Move symbol exports into IIO_SCD30 namespace

Kevin Hao (1):
      cpufreq: governor: Use kobject release() method to free dbs_data

Krzysztof Kozlowski (1):
      PM: domains: Extend dev_pm_domain_detach() doc

Len Brown (5):
      tools/power turbostat: tweak --show and --hide capability
      tools/power turbostat: fix ICX DRAM power numbers
      tools/power turbostat: be more useful as non-root
      tools/power turbostat: No build warnings with -Wextra
      tools/power turbostat: version 2022.04.16

Lukasz Luba (7):
      PM: EM: Add .get_cost() callback
      PM: EM: Use the new .get_cost() callback while registering EM
      PM: EM: Change the order of arguments in the .active_power() callback
      PM: EM: Remove old debugfs files and print all 'flags'
      Documentation: EM: Add artificial EM registration description
      thermal: cooling: Check Energy Model type in cpufreq_cooling and
devfreq_cooling
      powercap: DTPM: Check for Energy Model type

Pierre Gondois (9):
      PM: EM: Add artificial EM flag
      cpufreq: CPPC: Add per_cpu efficiency_class
      cpufreq: CPPC: Register EM based on efficiency class information
      PM: EM: Decrement policy counter
      ACPI: CPPC: Check _OSC for flexible address space
      ACPI: bus: Set CPPC _OSC bits for all and when CPPC_LIB is supported
      ACPI: CPPC: Assume no transition latency if no PCCT
      cpufreq: CPPC: Enable fast_switch
      cpufreq: CPPC: Enable dvfs_possible_from_any_cpu

Rafael J. Wysocki (4):
      PM: runtime: Avoid device usage count underflows
      cpufreq: Reorganize checks in cpufreq_offline()
      cpufreq: Split cpufreq_offline()
      cpufreq: Rearrange locking in cpufreq_remove_dev()

Saravana Kannan (1):
      PM / devfreq: Add cpu based scaling support to passive governor

Schspa Shi (3):
      cpufreq: Fix possible race in cpufreq online error path
      cpufreq: Abort show()/store() for half-initialized policies
      cpufreq: make interface functions and lock holding state clear

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Support Sapphire Rapids OOB mode

Sumeet Pawnikar (3):
      tools/power turbostat: Add Power Limit4 support
      tools/power turbostat: print power values upto three decimal
      powercap: RAPL: Add Power Limit4 support for RaptorLake

Ulf Hansson (19):
      PM: runtime: Allow to call __pm_runtime_set_status() from atomic context
      cpuidle: PSCI: Improve support for suspend-to-RAM for PSCI OSI mode
      PM: domains: Move genpd's time-accounting to ktime_get_mono_fast_ns()
      cpuidle: psci: Fix regression leading to no genpd governor
      cpuidle: riscv-sbi: Fix code to allow a genpd governor to be used
      PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
      PM: domains: Drop redundant code for genpd always-on governor
      PM: domains: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
      PM: domains: Rename irq_safe_dev_in_no_sleep_domain() in genpd
      PM: domains: Skip another warning in irq_safe_dev_in_sleep_domain()
      PM: domains: Allocate gpd_timing_data dynamically based on governor
      PM: domains: Move the next_wakeup variable into the struct gpd_timing_data
      PM: domains: Measure suspend/resume latencies in genpd based on governor
      PM: domains: Fixup QoS latency measurements for IRQ safe devices in genpd
      PM: domains: Fix initialization of genpd's next_wakeup
      PM: domains: Clean up some code in pm_genpd_init() and genpd_remove()
      PM: domains: Allocate governor data dynamically based on a genpd governor
      PM: domains: Measure power-on/off latencies in genpd based on a governor
      PM: domains: Trust domain-idle-states from DT to be correct by genpd

Viresh Kumar (3):
      cpufreq: Avoid unnecessary frequency updates due to mismatch
      Revert "cpufreq: Fix possible race in cpufreq online error path"
      cpufreq: Clear real_cpus mask from remove_cpu_dev_symlink()

Yang Li (1):
      PM: hibernate: Fix some kernel-doc comments

Zephaniah E. Loss-Cutler-Hull (2):
      tools/power turbostat: Allow -e for all names.
      tools/power turbostat: Allow printing header every N iterations

Zhang Rui (3):
      powercap: intel_rapl: add support for RaptorLake
      intel_idle: Add AlderLake support
      powercap: intel_rapl: add support for ALDERLAKE_N

---------------

 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 212 --------
 .../memory-controllers/rockchip,rk3399-dmc.yaml    | 384 +++++++++++++
 Documentation/power/energy-model.rst               |  24 +-
 arch/arm64/kernel/smp.c                            |   1 +
 arch/x86/include/asm/msr-index.h                   |   1 +
 arch/x86/kernel/acpi/boot.c                        |   2 +-
 drivers/acpi/bus.c                                 |  34 +-
 drivers/acpi/cppc_acpi.c                           |  44 +-
 drivers/base/power/common.c                        |   8 +-
 drivers/base/power/domain.c                        | 278 ++++++----
 drivers/base/power/domain_governor.c               |  65 +--
 drivers/base/power/runtime.c                       |  53 +-
 drivers/cpufreq/cppc_cpufreq.c                     | 211 ++++++++
 drivers/cpufreq/cpufreq.c                          | 112 ++--
 drivers/cpufreq/cpufreq_governor.c                 |  20 +-
 drivers/cpufreq/cpufreq_governor.h                 |   1 +
 drivers/cpufreq/intel_pstate.c                     |   2 +
 drivers/cpufreq/mediatek-cpufreq-hw.c              |   4 +-
 drivers/cpufreq/pasemi-cpufreq.c                   |   1 -
 drivers/cpufreq/pmac32-cpufreq.c                   |   2 +-
 drivers/cpufreq/pmac64-cpufreq.c                   |   2 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c                  |   1 -
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c              |   2 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   4 +-
 drivers/cpuidle/cpuidle-psci-domain.c              |   4 +-
 drivers/cpuidle/cpuidle-psci.c                     |  46 ++
 drivers/cpuidle/cpuidle-riscv-sbi.c                |   4 +-
 drivers/devfreq/devfreq.c                          |  20 +-
 drivers/devfreq/governor.h                         |  27 +
 drivers/devfreq/governor_passive.c                 | 403 +++++++++++---
 drivers/devfreq/rk3399_dmc.c                       | 312 +++++------
 drivers/idle/intel_idle.c                          | 133 +++++
 drivers/iio/chemical/scd30.h                       |   5 +-
 drivers/iio/chemical/scd30_core.c                  |  10 +-
 drivers/iio/chemical/scd30_i2c.c                   |   3 +-
 drivers/iio/chemical/scd30_serial.c                |   3 +-
 drivers/opp/of.c                                   |   6 +-
 drivers/powercap/dtpm_cpu.c                        |   2 +-
 drivers/powercap/intel_rapl_common.c               |   4 +-
 drivers/powercap/intel_rapl_msr.c                  |   1 +
 drivers/soc/rockchip/pm_domains.c                  | 118 ++++
 drivers/thermal/cpufreq_cooling.c                  |   2 +-
 drivers/thermal/devfreq_cooling.c                  |   8 +-
 include/acpi/cppc_acpi.h                           |   5 +
 include/linux/acpi.h                               |   2 +
 include/linux/devfreq.h                            |  17 +-
 include/linux/energy_model.h                       |  35 +-
 include/linux/pm.h                                 |  14 +-
 include/linux/pm_domain.h                          |  24 +-
 include/linux/pm_runtime.h                         |  10 +-
 include/linux/suspend.h                            |  44 +-
 include/soc/rockchip/pm_domains.h                  |  25 +
 kernel/power/Makefile                              |   6 +-
 kernel/power/energy_model.c                        |  65 ++-
 kernel/power/main.c                                |  29 -
 kernel/power/process.c                             |   3 -
 kernel/power/snapshot.c                            |  12 +-
 tools/power/x86/turbostat/Makefile                 |   2 +-
 tools/power/x86/turbostat/turbostat.8              |   2 +-
 tools/power/x86/turbostat/turbostat.c              | 594 +++++++++++++--------
 60 files changed, 2463 insertions(+), 1005 deletions(-)
