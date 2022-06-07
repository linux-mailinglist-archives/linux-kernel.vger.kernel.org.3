Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2636953FE50
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbiFGMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbiFGMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:30 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061971FA76
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:07:24 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="63351129"
X-IronPort-AV: E=Sophos;i="5.91,283,1647270000"; 
   d="scan'208";a="63351129"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Jun 2022 21:07:22 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C1ADD3EB0;
        Tue,  7 Jun 2022 21:07:21 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9C17CF89E;
        Tue,  7 Jun 2022 21:07:20 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 36B3D4007A996;
        Tue,  7 Jun 2022 21:07:20 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org,
        eugenis@google.com, tony.luck@intel.com, pcc@google.com,
        peterz@infradead.org, marcos@orca.pet, marcan@marcan.st,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        conor.dooley@microchip.com, arnd@arndb.de, ast@kernel.org,
        peter.chen@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and x86
Date:   Tue,  7 Jun 2022 21:05:24 +0900
Message-Id: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add sysfs interface to control CPU's hardware
prefetch behavior for performance tuning from userspace for the
processor A64FX and x86 (on supported CPU).

Changes from v4:
  - remove core driver
  - fix to use attribute_group instead of attribute (patch 1, 4)
  - fix to store a pointer of CPU number in driver_data when the
    initialization of sysfs (patch 1, 4)
  - move #if in .c file to .h file (patch 3)
  - fix drivers to be loaded automatically (patch 1, 4)
    - for x86, it is tied to the discovery of a specific CPU model
    - for A64FX, it is tied to the discovery of a specific ACPI device
  - add Kconfig description (patch 2, 5)
https://lore.kernel.org/lkml/20220518063032.2377351-1-tarumizu.kohei@fujitsu.com/

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

The advantage of using these is improved performance. As an example of
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
This driver creates "prefetch_control" directory and some attributes
in every CPU's cache/indexX directory, if CPU supports hardware
prefetch control behavior.

Detailed description of this sysfs interface is in
Documentation/ABI/testing/sysfs-devices-system-cpu (patch6).

This driver needs cache sysfs directory and cache level/type
information. In ARM processor, these information can be obtained
from registers even without ACPI PPTT.
We add processing to create a cache/index directory using only the
information from the register if the machine does not support ACPI
PPTT and CONFIG_ALLOW_INCOMPLETE_CACHE_SYSFS is true in patch3.
This action caused a problem and is described in [Known problem].

[Examples]
==========
This section provides an example of using this sysfs interface at the
x86's model of INTEL_FAM6_BROADWELL_X.

This model has the following register specifications:

[0]    L2 Hardware Prefetcher Disable (R/W)
[1]    L2 Adjacent Cache Line Prefetcher Disable (R/W)
[2]    DCU Hardware Prefetcher Disable (R/W)
[3]    DCU IP Prefetcher Disable (R/W)
[63:4] Reserved

In this case, index0 (L1d cache) corresponds to bit[2,3] and index2
(L2 cache) corresponds to bit [0,1]. A list of attribute files of
index0 and index2 in CPU1 at BROADWELL_X is following:

```
# ls /sys/devices/system/cpu/cpu1/cache/index0/prefetch_control/

hardware_prefetcher_enable
ip_prefetcher_enable

# ls /sys/devices/system/cpu/cpu1/cache/index2/prefetch_control/

adjacent_cache_line_prefetcher_enable
hardware_prefetcher_enable
```

If user would like to disable the setting of "L2 Adjacent Cache Line
Prefetcher Disable (R/W)" in CPU1, do the following:

```
# echo 0 >
# /sys/devices/system/cpu/cpu1/cache/index2/prefetch_control/adjacent_cache_line_prefetcher_enable
```

In another example, a list of index0 at A64FX is following:

```
# ls /sys/devices/system/cpu/cpu1/cache/index0/prefetch_control/

stream_detect_prefetcher_dist
stream_detect_prefetcher_enable
stream_detect_prefetcher_strength
stream_detect_prefetcher_strength_available
```

[Patch organizations]
=====================
This patch series add hardware prefetch control driver for A64FX
and x86.

- patch1: Add hardware prefetch control driver for A64FX

  Adds module init/exit code to create sysfs attributes for A64FX with
  "stream_detect_prefetcher_enable", "stream_detect_prefetcher_strong"
  and "stream_detect_prefetcher_dist".

- patch2: Add Kconfig/Makefile to build driver for A64FX

- patch3: Create cache sysfs directory without ACPI PPTT for hardware
  prefetch control

  Hardware Prefetch control driver needs cache sysfs directory and cache
  level/type information. In ARM processor, these information can be
  obtained from register(CLIDR_EL1) even without PPTT. Therefore, we
  set the cpu_map_populated to true to create cache sysfs directory, if
  the machine doesn't have PPTT.

- patch4: Add hardware prefetch control driver for x86

  Adds module init/exit code to create sysfs attributes for x86 with
  "hardware_prefetcher_enable", "ip_prefetcher_enable" and
  "adjacent_cache_line_prefetcher_enable".

- patch5: Add Kconfig/Makefile to build driver for x86

- patch6: Add documentation for the new sysfs interface

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

Kohei Tarumizu (6):
  soc: fujitsu: Add hardware prefetch control driver for A64FX
  soc: fujitsu: Add Kconfig/Makefile to build hardware prefetch control
    driver
  arm64: Create cache sysfs directory without ACPI PPTT for hardware
    prefetch control
  x86: Add hardware prefetch control driver for x86
  x86: Add Kconfig/Makefile to build hardware prefetch control driver
  docs: ABI: Add sysfs documentation interface of hardware prefetch
    control driver

 .../ABI/testing/sysfs-devices-system-cpu      |  98 ++++
 MAINTAINERS                                   |   6 +
 arch/arm64/kernel/cacheinfo.c                 |  27 +
 arch/x86/Kconfig                              |  17 +
 arch/x86/kernel/cpu/Makefile                  |   2 +
 arch/x86/kernel/cpu/x86-pfctl.c               | 363 +++++++++++++
 drivers/acpi/pptt.c                           |  18 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/fujitsu/Kconfig                   |  26 +
 drivers/soc/fujitsu/Makefile                  |   2 +
 drivers/soc/fujitsu/a64fx-pfctl.c             | 484 ++++++++++++++++++
 include/linux/acpi.h                          |   5 +
 include/linux/cacheinfo.h                     |  10 +
 14 files changed, 1060 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/x86-pfctl.c
 create mode 100644 drivers/soc/fujitsu/Kconfig
 create mode 100644 drivers/soc/fujitsu/Makefile
 create mode 100644 drivers/soc/fujitsu/a64fx-pfctl.c

-- 
2.27.0

