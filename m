Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3D49AD90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353151AbiAYHZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:25:17 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:10452 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1443994AbiAYHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:21:50 -0500
IronPort-SDR: 7FO1CR197B17Bzj+cC0TpmaljhJrRBAp2M9d1F5TiNllwDmuiUZl2tHM23qS+uF7YbHYP8bklX
 5CY4W5flWzWjgiBL6K+Ek3kjmYtW5luAk680HB8HKFT7SUBt4VqII68E3WyHyvIVnjjSnGkE7G
 1GlgLZUtMRbcpoaKWylTx+K9Doy7OJidJwArkCHdg9TMTvZgPFmpps2KeeaHBwTgOaIvnkOEfM
 ZMZP7fsXug0MueLQMJdqzge+3tTM0419hoT5lTC4oGlwk0WnH85vXOs3QV9pT4kkQtq2vTodfq
 WbO11nF/p7dWXTMcILH2I9aj
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="60495799"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="60495799"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:09 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C816ECA245
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:08 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D8D42FF50
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:07 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 83AAB4007ED71;
        Tue, 25 Jan 2022 16:14:07 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 0/8] Add hardware prefetch control driver for arm64 and x86
Date:   Tue, 25 Jan 2022 16:14:06 +0900
Message-Id: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add sysfs interface to control CPU's hardware
prefetch behavior for performance tuning from userspace for arm64 and
x86 (on supported CPU).

[Background]
============
A64FX and some Intel processors have implementation-dependent register
for controlling CPU's hardware prefetch behavior. A64FX has
IMP_PF_STREAM_DETECT_CTRL_EL0[1], and Intel processors have MSR 0x1a4
(MSR_MISC_FEATURE_CONTROL)[2]. These registers cannot be accessed from
userspace.

[1]https://github.com/fujitsu/A64FX/tree/master/doc/
   A64FX_Specification_HPC_Extension_v1_EN.pdf

[2]https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
    Volume 4

The advantage of using this is improved performance. As an example of
performance improvements, the results of running the Stream benchmark
on the A64FX are described in section [Merit].

For MSR 0x1a4, it is also possible to change the value from userspace
via the MSR driver. However, using MSR driver is not recommended, so
it needs a proper kernel interface[3].

[3]https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about/

For these reasons, we provide a new proper kernel interface to control
both IMP_PF_STREAM_DETECT_CTRL_EL0 and MSR 0x1a4.

[Overall design]
================
The following changes have been made based on feedback received in
earlier RFC PATCH[4].

[4]https://lore.kernel.org/lkml/20211104052122.553868-1-tarumizu.kohei@fujitsu.com/

- create attribute file under
  /sys/devices/system/cpu/cpu*/cache/index[0,2]
- provide a one-to-one option to control all the tunable parameters
  the CPU provides.
- use x86_match_cpu() to identify the kind of model

The source code for this driver is divided into common parts
(driver/base/pfctl.c) and architecture parts (arch/XXX/XXX/pfctl.c).
Common parts is described architecture-independent processing, such as
creating sysfs.
Architecture parts is described architecture-dependent processing. It
must contain at least the what type of hardware prefetcher is supported
and how to read/write to the register. These information are set
through registration function in common parts.

This driver creates an attribute file named "prefetch_control”in
every CPU's cache/index[0,2] directory, if CPU supports hardware
prefetch control behavior. Each attribute file corresponds to the
cache level of the parent index directory. The attribute file can be
used to modify one or more options by writing a string.

Detailed description of this sysfs interface is in
Documentation/ABI/testing/sysfs-devices-system-cpu (patch8).

This driver needs cache sysfs directory and cache level/type
information. In ARM processor, these information can be obtained
from registers even without ACPI PPTT.
We add processing to create a cache/index directory using only the
information from the register if the machine does not support ACPI
PPTT and Kconfig for hardware prefetch control (CONFIG_HWPF_CONTROL)
is true in patch5.
This action caused a problem and is described in [Known problem].

[Examples]
==========
As an example of dealing with multiple options, the x86's model of
INTEL_FAM6_BROADWELL_X defines the register specifications as follows:

[0]    L2 Hardware Prefetcher Disable (R/W)
[1]    L2 Adjacent Cache Line Prefetcher Disable (R/W)
[2]    DCU Hardware Prefetcher Disable (R/W)
[3]    DCU IP Prefetcher Disable (R/W)
[63:4] Reserved

In this case, index0 (L1d cache) corresponds to bit[2,3] and index2
(L2 cache) corresponds to bit [0,1]. If you would like to disable the
setting of "L2 Adjacent Cache Line Prefetcher Disable (R/W)" in CPU1,
do the following:

```
# echo "adjacent_cache_line_prefetcher_enable=disable" > /sys/devices/system/cpu/cpu1/cache/index2/prefetch_control
```

When this attribute file is read, the current settings of the available
parameters are output as follows:

```
# cat /sys/devices/system/cpu/cpu1/cache/index2/prefetch_control

hardware_prefetcher_enable=enable
adjacent_cache_line_prefetcher_enable=disable
```

In the case of index0 at BROADWELL_X:

```
# cat /sys/devices/system/cpu/cpu1/cache/index0/prefetch_control

hardware_prefetcher_enable=enable
ip_prefetcher_enable=enable
```

In the case of index0 at A64FX:

```
# cat /sys/devices/system/cpu/cpu1/cache/index0/prefetch_control

stream_detect_prefetcher_enable=enable
stream_detect_prefetcher_dist=auto
stream_detect_prefetcher_strong=strong
```

[Patch organizations]
=====================
This patch series add hardware prefetch control core driver for ARM64
and x86. Also, we add support for FUJITSU_CPU_PART_A64FX at ARM64 and
BROADWELL_X at x86.

- patch1: Add hardware prefetch core driver

  This driver provides a register/unregister function to create the
  sysfs interface with attribute "prefetch_control".
  If the architecture has control of the CPU's hardware prefetch
  behavior, use this function to create sysfs. When registering, it
  is necessary to provide what type of Hardware Prefetcher is
  supported and how to read/write to the register.

- patch2: Add Kconfig/Makefile to build hardware prefetch control core driver

- patch3: Add support for ARM64

  This adds module init/exit code, and creates sysfs attribute file
  "prefetch_control" for ARM64. This driver works only if part number is
  FUJITSU_CPU_PART_A64FX at this point.

- patch4: Add Kconfig/Makefile to build driver for arm64

- patch5: Create cache sysfs directory without ACPI PPTT for hardware prefetch control

  Hardware Prefetch control driver needs cache sysfs directory and cache
  level/type information. In ARM processor, these information can be
  obtained from registers even without PPTT. Therefore, we set the
  cpu_map_populated to true to create cache sysfs directory, if the
  machine doesn't have PPTT.

- patch6: Add support for x86

  This adds module init/exit code, and creates sysfs attribute file
  "prefetch_control" for x86. This driver works only if the model is
  INTEL_FAM6_BROADWELL_X at this point.

- patch7: Add Kconfig/Makefile to build driver for x86

- patch8: Add documentation for the new sysfs interface


[Known problem]
===============
- `lscpu` command terminates with -ENOENT because cache/index directory
  is exists but shared_cpu_map file does not exist. This is due to
  patch5, which creates a cache/index directory containing only level
  and type without ACPI PPTT.

[Merit]
=======
For reference, here is the result of STREAM Triad when tuning with
the "s file in L1 and L2 cache on A64FX.

| dist combination  | Pattern A   | Pattern B   |
|-------------------|-------------|-------------|
| L1:256,  L2:1024  | 234505.2144 | 114600.0801 |
| L1:1536, L2:1024  | 279172.8742 | 118979.4542 |
| L1:256,  L2:10240 | 247716.7757 | 127364.1533 |
| L1:1536, L2:10240 | 283675.6625 | 125950.6847 |

In pattern A, we set the size of the array to 174720, which is about
half the size of the L1d cache. In pattern B, we set the size of the
array to 10485120, which is about twice the size of the L2 cache.

In pattern A, a change of dist at L1 has a larger effect. On the other
hand, in pattern B, the change of dist at L2 has a larger effect.
As described above, the optimal dist combination depends on the
characteristics of the application. Therefore, such a sysfs interface
is useful for performance tuning.

Best regards,
Kohei Tarumizu

Kohei Tarumizu (8):
  drivers: base: Add hardware prefetch control core driver
  drivers: base: Add Kconfig/Makefile to build hardware prefetch control
    core driver
  arm64: Add hardware prefetch control support for ARM64
  arm64: Add Kconfig/Makefile to build hardware prefetch control driver
  arm64: Create cache sysfs directory without ACPI PPTT for hardware
    prefetch control
  x86: Add hardware prefetch control support for x86
  x86: Add Kconfig/Makefile to build hardware prefetch control driver
  docs: ABI: Add sysfs documentation interface of hardware prefetch
    control driver

 .../ABI/testing/sysfs-devices-system-cpu      |  93 +++
 MAINTAINERS                                   |   8 +
 arch/arm64/Kconfig                            |   8 +
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/cacheinfo.c                 |  29 +
 arch/arm64/kernel/pfctl.c                     | 324 +++++++++++
 arch/x86/Kconfig                              |   7 +
 arch/x86/kernel/cpu/Makefile                  |   2 +
 arch/x86/kernel/cpu/pfctl.c                   | 292 ++++++++++
 drivers/base/Kconfig                          |  13 +
 drivers/base/Makefile                         |   1 +
 drivers/base/pfctl.c                          | 541 ++++++++++++++++++
 include/linux/pfctl.h                         |  42 ++
 13 files changed, 1361 insertions(+)
 create mode 100644 arch/arm64/kernel/pfctl.c
 create mode 100644 arch/x86/kernel/cpu/pfctl.c
 create mode 100644 drivers/base/pfctl.c
 create mode 100644 include/linux/pfctl.h

-- 
2.27.0

