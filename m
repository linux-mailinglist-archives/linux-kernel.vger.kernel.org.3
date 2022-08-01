Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6125871C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiHATvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiHATvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:51:41 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9768C62E1;
        Mon,  1 Aug 2022 12:51:39 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31f443e276fso120358557b3.1;
        Mon, 01 Aug 2022 12:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=nPsLNYIUg1ggMzEIvSypkzhyScCPp43k8SbtEA8OLl0=;
        b=b9x0IV2pFXbQz6JD94rV0F4OdSCx2PkIJfcS++DHxOJ6q0gMmWF4In0QhnC8D3nOaf
         UHcH2JNu7gj4UsJx5eof3QK6kaedsgRH03J0hzQ0pzV/gShP8VIqXw7M7XnbGuFtMqLp
         y5qbnG81vWoMFC0SUqTiF+M9OGvQ3tlYThB7wf4/iRUrUX/24IYs9OaoMr+UmP9294Zu
         AOqaus0nSBhNYf67HxtYo0AsRI0AzH3wJdiYtkp87klXlcde/TsODwm0g2a75DF3vtsF
         TCRjFi3gIw7qTE8dl0r2HgGjXlyqFX7TAGjTk35ltqZqAjfpEWORTB8vbbLPYMx6IovE
         lpXQ==
X-Gm-Message-State: ACgBeo0wBnkpnoV8rPUiT+Py7mihUs2NY0a9FWcFVFRAgIV/RJlbdusV
        U3jDbuX1CbXjRol+nOyymFh/GZ/7HQuuUN5TV0HgUkW0+p2I4w==
X-Google-Smtp-Source: AA6agR7S28RkcbsBF7caylSQde7WSPCvfXQUpAaGvmJYLJRZymyJ4DoYSv2HByxTcoYibvOS75tSrXXmExM1mme3D6w=
X-Received: by 2002:a0d:d694:0:b0:325:1881:6a52 with SMTP id
 y142-20020a0dd694000000b0032518816a52mr3168507ywd.149.1659383498712; Mon, 01
 Aug 2022 12:51:38 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Aug 2022 21:51:23 +0200
Message-ID: <CAJZ5v0hLRoevo3sOqLjDoAU82CVbvE7-dica+8_+_LfHAPb=YQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.20-rc1

with top-most commit aa727b7b4b67dba2a6cfebdd98767c455c2b3d69

 Merge branches 'pm-devfreq', 'pm-qos', 'pm-tools' and 'pm-docs'

on top of commit d295ad34f236c3518634fb6403d4c0160456e470

 intel_idle: Fix false positive RCU splats due to incorrect hardirqs state

to receive power management updates for 5.20-rc1.

These mostly are minor improvements all over including new CPU IDs
for the Intel RAPL driver, an Energy Model rework to use micro-Watt
as the power unit, cpufreq fixes and cleanus, cpuidle updates,
devfreq updates, documentation cleanups and a new version of the
pm-graph suite of utilities.

Specifics:

 - Make cpufreq_show_cpus() more straightforward (Viresh Kumar).

 - Drop unnecessary CPU hotplug locking from store() used by cpufreq
   sysfs attributes (Viresh Kumar).

 - Make the ACPI cpufreq driver support the boost control interface on
   Zhaoxin/Centaur processors (Tony W Wang-oc).

 - Print a warning message on attempts to free an active cpufreq policy
   which should never happen (Viresh Kumar).

 - Fix grammar in the Kconfig help text for the loongson2 cpufreq
   driver (Randy Dunlap).

 - Use cpumask_var_t for an on-stack CPU mask in the ondemand cpufreq
   governor (Zhao Liu).

 - Add trace points for guest_halt_poll_ns grow/shrink to the haltpoll
   cpuidle driver (Eiichi Tsukata).

 - Modify intel_idle to treat C1 and C1E as independent idle states on
   Sapphire Rapids (Artem Bityutskiy).

 - Extend support for wakeirq to callback wrappers used during system
   suspend and resume (Ulf Hansson).

 - Defer waiting for device probe before loading a hibernation image
   till the first actual device access to avoid possible deadlocks
   reported by syzbot (Tetsuo Handa).

 - Unify device_init_wakeup() for PM_SLEEP and !PM_SLEEP (Bjorn
   Helgaas).

 - Add Raptor Lake-P to the list of processors supported by the Intel
   RAPL driver (George D Sworo).

 - Add Alder Lake-N and Raptor Lake-P to the list of processors for
   which Power Limit4 is supported in the Intel RAPL driver (Sumeet
   Pawnikar).

 - Make pm_genpd_remove() check genpd_debugfs_dir against NULL before
   attempting to remove it (Hsin-Yi Wang).

 - Change the Energy Model code to represent power in micro-Watts and
   adjust its users accordingly (Lukasz Luba).

 - Add new devfreq driver for Mediatek CCI (Cache Coherent
   Interconnect) (Johnson Wang).

 - Convert the Samsung Exynos SoC Bus bindings to DT schema of
   exynos-bus.c (Krzysztof Kozlowski).

 - Address kernel-doc warnings by adding the description for unused
   function parameters in devfreq core (Mauro Carvalho Chehab).

 - Use NULL to pass a null pointer rather than zero according to the
   function prototype in imx-bus.c (Colin Ian King).

 - Print error message instead of error integer value in
   tegra30-devfreq.c (Dmitry Osipenko).

 - Add checks to prevent setting negative frequency QoS limits for
   CPUs (Shivnandan Kumar).

 - Update the pm-graph suite of utilities to the latest revision 5.9
   including multiple improvements (Todd Brandt).

 - Drop pme_interrupt reference from the PCI power management
   documentation (Mario Limonciello).

Thanks!


---------------

Artem Bityutskiy (1):
      intel_idle: make SPR C1 and C1E be independent

Bjorn Helgaas (1):
      PM: wakeup: Unify device_init_wakeup() for PM_SLEEP and !PM_SLEEP

Colin Ian King (1):
      PM / devfreq: imx-bus: use NULL to pass a null pointer rather than zero

Dmitry Osipenko (1):
      PM / devfreq: tegra30: Add error message for devm_devfreq_add_device()

Eiichi Tsukata (1):
      cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink

George D Sworo (1):
      powercap: intel_rapl: Add support for RAPTORLAKE_P

Hsin-Yi Wang (1):
      PM: domains: Ensure genpd_debugfs_dir exists before remove

Johnson Wang (2):
      dt-bindings: interconnect: Add MediaTek CCI dt-bindings
      PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: samsung,exynos-bus: convert to dtschema

Lukasz Luba (4):
      PM: EM: convert power field to micro-Watts precision and align drivers
      Documentation: EM: Switch to micro-Watts scale
      firmware: arm_scmi: Get detailed power scale from perf
      cpufreq: scmi: Support the power scale in micro-Watts in SCMI v3.1

Mario Limonciello (1):
      Documentation: PM: Drop pme_interrupt reference

Mauro Carvalho Chehab (1):
      PM / devfreq: shut up kernel-doc warnings

Randy Dunlap (1):
      cpufreq: loongson2: fix Kconfig "its" grammar

Shivnandan Kumar (1):
      PM: QoS: Add check to make sure CPU freq is non-negative

Sumeet Pawnikar (1):
      powercap: RAPL: Add Power Limit4 support for Alder Lake-N and
Raptor Lake-P

Tetsuo Handa (1):
      PM: hibernate: defer device probing when resuming from hibernation

Todd Brandt (1):
      pm-graph v5.9

Tony W Wang-oc (1):
      cpufreq: ACPI: Add Zhaoxin/Centaur turbo boost control interface support

Ulf Hansson (1):
      PM: runtime: Extend support for wakeirq for force_suspend|resume

Viresh Kumar (3):
      cpufreq: Optimize cpufreq_show_cpus()
      cpufreq: Drop unnecessary cpus locking from store()
      cpufreq: Warn users while freeing active policy

Zhao Liu (1):
      cpufreq: ondemand: Use cpumask_var_t for on-stack cpu mask

---------------

 .../devicetree/bindings/devfreq/exynos-bus.txt     | 488 -------------------
 .../bindings/interconnect/mediatek,cci.yaml        | 141 ++++++
 .../bindings/interconnect/samsung,exynos-bus.yaml  | 290 ++++++++++++
 Documentation/power/energy-model.rst               |  14 +-
 Documentation/power/pci.rst                        |   2 +-
 MAINTAINERS                                        |   3 +-
 drivers/base/power/domain.c                        |   3 +
 drivers/base/power/runtime.c                       |   6 +
 drivers/base/power/wakeup.c                        |  30 --
 drivers/cpufreq/Kconfig                            |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   4 +
 drivers/cpufreq/cpufreq.c                          |  37 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |  13 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c              |   7 +-
 drivers/cpufreq/scmi-cpufreq.c                     |  15 +-
 drivers/cpuidle/governors/haltpoll.c               |   3 +
 drivers/devfreq/Kconfig                            |  10 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/devfreq.c                          |   4 +
 drivers/devfreq/imx-bus.c                          |   2 +-
 drivers/devfreq/mtk-cci-devfreq.c                  | 440 +++++++++++++++++
 drivers/devfreq/tegra30-devfreq.c                  |   4 +-
 drivers/firmware/arm_scmi/perf.c                   |  18 +-
 drivers/idle/intel_idle.c                          |  24 +-
 drivers/opp/of.c                                   |  15 +-
 drivers/powercap/dtpm_cpu.c                        |   5 +-
 drivers/powercap/intel_rapl_common.c               |   1 +
 drivers/powercap/intel_rapl_msr.c                  |   2 +
 drivers/thermal/cpufreq_cooling.c                  |  13 +-
 drivers/thermal/devfreq_cooling.c                  |  19 +-
 include/linux/energy_model.h                       |  54 ++-
 include/linux/pm_wakeup.h                          |  31 +-
 include/linux/scmi_protocol.h                      |   8 +-
 include/trace/events/power.h                       |  29 ++
 kernel/power/energy_model.c                        |  24 +-
 kernel/power/qos.c                                 |   4 +-
 kernel/power/user.c                                |  13 +-
 tools/power/pm-graph/README                        |   6 +-
 tools/power/pm-graph/bootgraph.py                  |  20 +-
 .../pm-graph/config/custom-timeline-functions.cfg  |   2 +-
 tools/power/pm-graph/sleepgraph.py                 | 518 ++++++++++++++-------
 41 files changed, 1498 insertions(+), 827 deletions(-)
