Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A475305B8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbiEVUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbiEVUA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCCAB17074
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653249652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=65yngFJvnnQqqOwfUBbSYy1+4Fg8XNSTTcdX6vdvhU8=;
        b=euKiFaCPRgkIrAgsAHARNF0dRijLRJH113QUfs6PC6PsY2h8WG9SyecdcwEJ1PmPH7gsvi
        lRbQIPiyqFr4/+Rf3DfDLdbrgkX4MUCOE+xcLkU4qRAAsyVAnbRdVzUG+OGg8X3NgVmwtZ
        XNTMW2OywvhlZuCRvtBBupz40LOQNPs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-uWe-usd_MLGaZ_RNmdjOlQ-1; Sun, 22 May 2022 16:00:49 -0400
X-MC-Unique: uWe-usd_MLGaZ_RNmdjOlQ-1
Received: by mail-ed1-f71.google.com with SMTP id y1-20020a056402170100b0042aa8f679fdso9328367edu.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=65yngFJvnnQqqOwfUBbSYy1+4Fg8XNSTTcdX6vdvhU8=;
        b=Y1dn3i6ndWtltEE5oWWRyTcaw2UwXCz2EaHV0HEG/cSg2VbrIfLtbSbz4jMlUiyF3+
         5sTRocd2XcKx5yyls7M/83ZfrL0qHHgaeh2qtvMnqWABdNays1G7Q5rWVS6ELofsQsoE
         P4lkeesFRLJAfaGiVzuyO+htmqvOp+3upDriJRTGYWsWbL4fNcB8HejQN6oI7saDdnua
         CiJqYwKXx9uFO72mtJBqHriO2hPxq6b3QLWfJNIy849pPMaHdvdwyW5KI+4eiWaSnqIh
         CmNXAN/sI+jpa+r+5TSkWO1z105A/ufbntx9yhCnLJErFuS9KVlPoSfgOztdVqh1kq6Y
         0K2w==
X-Gm-Message-State: AOAM532xzeK8lHAeYD9GcCcxPpbgcTlgHOBLE2cMGyhPryyx+5k5Vq9S
        TKuxZ4ILT1EJUgr2uizZPtzeXT8Kk/6tUis7PQDOAas3d7mjPi9JPYxi+t0hcXWxYaQG1gPqd8L
        TrpmsB0K/ksAOKP6osNrI/G7W
X-Received: by 2002:a17:907:97d5:b0:6fe:af07:65a with SMTP id js21-20020a17090797d500b006feaf07065amr10351520ejc.20.1653249648077;
        Sun, 22 May 2022 13:00:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdiCV7I7kTYqr+d4c18JxNm9pLqVMJqiJiwjPB31vFee2VaqegqV0SNw6z7Yd2+SZdg5T/9A==
X-Received: by 2002:a17:907:97d5:b0:6fe:af07:65a with SMTP id js21-20020a17090797d500b006feaf07065amr10351496ejc.20.1653249647788;
        Sun, 22 May 2022 13:00:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ca7-20020aa7cd67000000b0042617ba63absm7260362edb.53.2022.05.22.13.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 13:00:47 -0700 (PDT)
Message-ID: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
Date:   Sun, 22 May 2022 22:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.19-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.19.

Note this includes some small changes to kernel/stop_machine.c
and arch/x86 which are deps of the new Intel IFS support.
Merging these deps through the pdx86 tree was suggested
by the TIP tree maintainers and these have a Reviewed-by
from tglx.

Highlights:
 -  New drivers:
    -  Intel "In Field Scan" (IFS) support
    -  Winmate FM07/FM07P buttons
    -  Mellanox SN2201 support
 -  AMD PMC driver enhancements
 -  Lots of various other small fixes and hardware-id additions

Regards,

Hans


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-1

for you to fetch changes up to badb81a58b9e66ca8c15405476f5134e45b57dee:

  platform/x86/intel/ifs: Add CPU_SUP_INTEL dependency (2022-05-19 19:46:25 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.19-1

Highlights:
 -  New drivers:
    -  Intel "In Field Scan" (IFS) support
    -  Winmate FM07/FM07P buttons
    -  Mellanox SN2201 support
 -  AMD PMC driver enhancements
 -  Lots of various other small fixes and hardware-id additions

The following is an automated git shortlog grouped by driver:

Documentation:
 -  In-Field Scan

Documentation/ABI:
 -  Add new attributes for mlxreg-io sysfs interfaces
 -  sysfs-class-firmware-attributes: Misc. cleanups
 -  sysfs-class-firmware-attributes: Fix Sphinx errors
 -  sysfs-driver-intel_sdsi: Fix sphinx warnings

acerhdf:
 -  Cleanup str_starts_with()

amd-pmc:
 -  Fix build error unused-function
 -  Shuffle location of amd_pmc_get_smu_version()
 -  Avoid reading SMU version at probe time
 -  Move FCH init to first use
 -  Move SMU logging setup out of init
 -  Fix compilation without CONFIG_SUSPEND

amd_hsmp:
 -  Add HSMP protocol version 5 messages

asus-nb-wmi:
 -  Add keymap for MyASUS key

asus-wmi:
 -  Update unknown code message
 -  Use kobj_to_dev()
 -  Fix driver not binding when fan curve control probe fails
 -  Potential buffer overflow in asus_wmi_evaluate_method_buf()

barco-p50-gpio:
 -  Fix duplicate included linux/io.h

dell-laptop:
 -  Add quirk entry for Latitude 7520

gigabyte-wmi:
 -  Add support for Z490 AORUS ELITE AC and X570 AORUS ELITE WIFI
 -  added support for B660 GAMING X DDR4 motherboard

hp-wmi:
 -  Correct code style related issues

intel-hid:
 -  fix _DSM function index handling

intel-uncore-freq:
 -  Prevent driver loading in guests

intel_cht_int33fe:
 -  Set driver data

platform/mellanox:
 -  Add support for new SN2201 system

platform/surface:
 -  aggregator: Fix initialization order when compiling as builtin module
 -  gpe: Add support for Surface Pro 8

platform/x86/dell:
 -  add buffer allocation/free functions for SMI calls

platform/x86/intel:
 -  Fix 'rmmod pmt_telemetry' panic
 -  pmc/core: Use kobj_to_dev()
 -  pmc/core: change pmc_lpm_modes to static

platform/x86/intel/ifs:
 -  Add CPU_SUP_INTEL dependency
 -  add ABI documentation for IFS
 -  Add IFS sysfs interface
 -  Add scan test support
 -  Authenticate and copy to secured memory
 -  Check IFS Image sanity
 -  Read IFS firmware image
 -  Add stub driver for In-Field Scan

platform/x86/intel/sdsi:
 -  Fix bug in multi packet reads
 -  Poll on ready bit for writes
 -  Handle leaky bucket

platform_data/mlxreg:
 -  Add field for notification callback

pmc_atom:
 -  dont export pmc_atom_read - no modular users
 -  remove unused pmc_atom_write()

samsung-laptop:
 -  use kobj_to_dev()
 -  Fix an unsigned comparison which can never be negative

stop_machine:
 -  Add stop_core_cpuslocked() for per-core operations

think-lmi:
 -  certificate support clean ups

thinkpad_acpi:
 -  Correct dual fan probe
 -  Add a s2idle resume quirk for a number of laptops
 -  Convert btusb DMI list to quirks

tools/power/x86/intel-speed-select:
 -  Fix warning for perf_cap.cpu
 -  Display error on turbo mode disabled
 -  fix build failure when using -Wl,--as-needed

toshiba_acpi:
 -  use kobj_to_dev()

trace:
 -  platform/x86/intel/ifs: Add trace point to track Intel IFS operations

winmate-fm07-keys:
 -  Winmate FM07/FM07P buttons

wmi:
 -  replace usage of found with dedicated list iterator variable

x86/microcode/intel:
 -  Expose collect_cpu_info_early() for IFS

x86/msr-index:
 -  Define INTEGRITY_CAPABILITIES MSR

----------------------------------------------------------------
Borislav Petkov (1):
      platform/x86/intel/ifs: Add CPU_SUP_INTEL dependency

Dan Carpenter (1):
      platform/x86: asus-wmi: Potential buffer overflow in asus_wmi_evaluate_method_buf()

Daniel Beer (1):
      platform/x86: winmate-fm07-keys: Winmate FM07/FM07P buttons

Darryn Anton Jordan (1):
      platform/x86: gigabyte-wmi: added support for B660 GAMING X DDR4 motherboard

David E. Box (3):
      platform/x86/intel/sdsi: Handle leaky bucket
      platform/x86/intel/sdsi: Poll on ready bit for writes
      platform/x86/intel/sdsi: Fix bug in multi packet reads

Frank Crawford (1):
      platform/x86: gigabyte-wmi: Add support for Z490 AORUS ELITE AC and X570 AORUS ELITE WIFI

Gabriele Mazzotta (1):
      platform/x86: dell-laptop: Add quirk entry for Latitude 7520

Hans de Goede (4):
      Documentation/ABI: sysfs-driver-intel_sdsi: Fix sphinx warnings
      Documentation/ABI: sysfs-class-firmware-attributes: Fix Sphinx errors
      Documentation/ABI: sysfs-class-firmware-attributes: Misc. cleanups
      platform/x86: asus-wmi: Fix driver not binding when fan curve control probe fails

Haowen Bai (1):
      platform/x86: barco-p50-gpio: Fix duplicate included linux/io.h

Heikki Krogerus (1):
      platform/x86: intel_cht_int33fe: Set driver data

Herton R. Krzesinski (1):
      tools/power/x86/intel-speed-select: fix build failure when using -Wl,--as-needed

Jakob Koschel (1):
      platform/x86: wmi: replace usage of found with dedicated list iterator variable

Jiapeng Chong (1):
      platform/x86: samsung-laptop: Fix an unsigned comparison which can never be negative

Jithu Joseph (7):
      x86/microcode/intel: Expose collect_cpu_info_early() for IFS
      platform/x86/intel/ifs: Read IFS firmware image
      platform/x86/intel/ifs: Check IFS Image sanity
      platform/x86/intel/ifs: Authenticate and copy to secured memory
      platform/x86/intel/ifs: Add scan test support
      platform/x86/intel/ifs: Add IFS sysfs interface
      platform/x86/intel/ifs: add ABI documentation for IFS

Jorge Lopez (1):
      platform/x86: hp-wmi: Correct code style related issues

Juergen Gross (1):
      platform/x86/dell: add buffer allocation/free functions for SMI calls

Luca Stefani (2):
      platform/x86: asus-wmi: Update unknown code message
      platform/x86: asus-nb-wmi: Add keymap for MyASUS key

Mario Limonciello (6):
      platform/x86: amd-pmc: Fix compilation without CONFIG_SUSPEND
      platform/x86: amd-pmc: Move SMU logging setup out of init
      platform/x86: amd-pmc: Move FCH init to first use
      platform/x86: amd-pmc: Avoid reading SMU version at probe time
      platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks
      platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of laptops

Mark Pearson (2):
      platform/x86: think-lmi: certificate support clean ups
      platform/x86: thinkpad_acpi: Correct dual fan probe

Maximilian Luz (2):
      platform/surface: gpe: Add support for Surface Pro 8
      platform/surface: aggregator: Fix initialization order when compiling as builtin module

Michael Niewöhner (1):
      platform/x86: intel-hid: fix _DSM function index handling

Michael Shych (3):
      platform_data/mlxreg: Add field for notification callback
      platform/mellanox: Add support for new SN2201 system
      Documentation/ABI: Add new attributes for mlxreg-io sysfs interfaces

Minghao Chi (4):
      platform/x86/intel: pmc/core: Use kobj_to_dev()
      platform/x86: asus-wmi: Use kobj_to_dev()
      platform/x86: samsung-laptop: use kobj_to_dev()
      platform/x86: toshiba_acpi: use kobj_to_dev()

Nathan Chancellor (1):
      platform/x86: amd-pmc: Shuffle location of amd_pmc_get_smu_version()

Paul Gortmaker (2):
      platform/x86: pmc_atom: remove unused pmc_atom_write()
      platform/x86: pmc_atom: dont export pmc_atom_read - no modular users

Peter Zijlstra (1):
      stop_machine: Add stop_core_cpuslocked() for per-core operations

Prarit Bhargava (1):
      platform/x86/intel: Fix 'rmmod pmt_telemetry' panic

Ren Zhijie (1):
      platform/x86: amd-pmc: Fix build error unused-function

Srinivas Pandruvada (3):
      platform/x86: intel-uncore-freq: Prevent driver loading in guests
      tools/power/x86/intel-speed-select: Display error on turbo mode disabled
      tools/power/x86/intel-speed-select: Fix warning for perf_cap.cpu

Suma Hegde (1):
      amd_hsmp: Add HSMP protocol version 5 messages

Tom Rix (1):
      platform/x86/intel: pmc/core: change pmc_lpm_modes to static

Tony Luck (4):
      x86/msr-index: Define INTEGRITY_CAPABILITIES MSR
      platform/x86/intel/ifs: Add stub driver for In-Field Scan
      trace: platform/x86/intel/ifs: Add trace point to track Intel IFS operations
      Documentation: In-Field Scan

Wei Li (1):
      platform/x86: acerhdf: Cleanup str_starts_with()

 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |   36 +
 .../ABI/testing/sysfs-class-firmware-attributes    |   48 +-
 Documentation/ABI/testing/sysfs-driver-intel_sdsi  |   18 +-
 Documentation/ABI/testing/sysfs-platform-intel-ifs |   39 +
 Documentation/x86/ifs.rst                          |    2 +
 Documentation/x86/index.rst                        |    1 +
 MAINTAINERS                                        |    8 +
 arch/x86/include/asm/cpu.h                         |   18 +
 arch/x86/include/asm/msr-index.h                   |    7 +
 arch/x86/include/uapi/asm/amd_hsmp.h               |  114 +-
 arch/x86/kernel/cpu/intel.c                        |   32 +
 arch/x86/kernel/cpu/microcode/intel.c              |   59 +-
 drivers/platform/mellanox/Kconfig                  |   17 +
 drivers/platform/mellanox/Makefile                 |    1 +
 drivers/platform/mellanox/nvsw-sn2201.c            | 1261 ++++++++++++++++++++
 drivers/platform/surface/aggregator/core.c         |    2 +-
 drivers/platform/surface/surface_gpe.c             |    8 +
 drivers/platform/x86/Kconfig                       |    8 +
 drivers/platform/x86/Makefile                      |    3 +
 drivers/platform/x86/acerhdf.c                     |   21 +-
 drivers/platform/x86/amd-pmc.c                     |  161 ++-
 drivers/platform/x86/asus-nb-wmi.c                 |    1 +
 drivers/platform/x86/asus-wmi.c                    |   19 +-
 drivers/platform/x86/barco-p50-gpio.c              |    1 -
 drivers/platform/x86/dell/dcdbas.c                 |  127 +-
 drivers/platform/x86/dell/dcdbas.h                 |    9 +
 drivers/platform/x86/dell/dell-laptop.c            |   13 +
 drivers/platform/x86/dell/dell-smbios-smm.c        |   14 +-
 drivers/platform/x86/gigabyte-wmi.c                |    3 +
 drivers/platform/x86/hp-wmi.c                      |    8 +
 drivers/platform/x86/intel/Kconfig                 |    1 +
 drivers/platform/x86/intel/Makefile                |    1 +
 drivers/platform/x86/intel/chtwc_int33fe.c         |    2 +
 drivers/platform/x86/intel/hid.c                   |    2 +-
 drivers/platform/x86/intel/ifs/Kconfig             |   13 +
 drivers/platform/x86/intel/ifs/Makefile            |    3 +
 drivers/platform/x86/intel/ifs/core.c              |   73 ++
 drivers/platform/x86/intel/ifs/ifs.h               |  234 ++++
 drivers/platform/x86/intel/ifs/load.c              |  266 +++++
 drivers/platform/x86/intel/ifs/runtest.c           |  252 ++++
 drivers/platform/x86/intel/ifs/sysfs.c             |  149 +++
 drivers/platform/x86/intel/pmc/core.c              |    2 +-
 drivers/platform/x86/intel/pmc/core.h              |    2 +-
 drivers/platform/x86/intel/pmt/telemetry.c         |    2 +-
 drivers/platform/x86/intel/sdsi.c                  |   44 +-
 .../x86/intel/uncore-frequency/uncore-frequency.c  |    3 +
 drivers/platform/x86/pmc_atom.c                    |   13 -
 drivers/platform/x86/samsung-laptop.c              |    4 +-
 drivers/platform/x86/think-lmi.c                   |   44 +-
 drivers/platform/x86/think-lmi.h                   |    1 -
 drivers/platform/x86/thinkpad_acpi.c               |  175 ++-
 drivers/platform/x86/toshiba_acpi.c                |    2 +-
 drivers/platform/x86/winmate-fm07-keys.c           |  189 +++
 drivers/platform/x86/wmi.c                         |   13 +-
 include/linux/platform_data/mlxreg.h               |    4 +
 include/linux/platform_data/x86/pmc_atom.h         |    1 -
 include/linux/stop_machine.h                       |   16 +
 include/trace/events/intel_ifs.h                   |   41 +
 kernel/stop_machine.c                              |   21 +
 tools/power/x86/intel-speed-select/Makefile        |    2 +-
 tools/power/x86/intel-speed-select/hfi-events.c    |    2 +-
 tools/power/x86/intel-speed-select/isst-config.c   |    6 +
 62 files changed, 3312 insertions(+), 330 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs
 create mode 100644 Documentation/x86/ifs.rst
 create mode 100644 drivers/platform/mellanox/nvsw-sn2201.c
 create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
 create mode 100644 drivers/platform/x86/intel/ifs/Makefile
 create mode 100644 drivers/platform/x86/intel/ifs/core.c
 create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
 create mode 100644 drivers/platform/x86/intel/ifs/load.c
 create mode 100644 drivers/platform/x86/intel/ifs/runtest.c
 create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
 create mode 100644 drivers/platform/x86/winmate-fm07-keys.c
 create mode 100644 include/trace/events/intel_ifs.h

