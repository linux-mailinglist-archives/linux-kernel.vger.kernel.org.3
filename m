Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7610952B262
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiERGbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiERGb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:31:28 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FAA65DF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:31:24 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="51998538"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="51998538"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 15:31:21 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 19A296C969
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:21 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B2E5E0CDB
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:20 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id AC5054007E8A3;
        Wed, 18 May 2022 15:31:19 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, mchehab+huawei@kernel.org, eugenis@google.com,
        tony.luck@intel.com, pcc@google.com, peterz@infradead.org,
        marcos@orca.pet, conor.dooley@microchip.com,
        nicolas.ferre@microchip.com, marcan@marcan.st,
        linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v4 0/8] Add hardware prefetch control driver for A64FX and x86
Date:   Wed, 18 May 2022 15:30:24 +0900
Message-Id: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
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

Changes from v3: https://lore.kernel.org/lkml/20220420030223.689259-1-tarumizu.kohei@fujitsu.com/
  - remove hardware-dependent code from core driver
    (driver/base/pfctl.c)
  - simplifies implementation of register bit operations
  - extract the pseudo_lock patch as a separate patch
    https://lore.kernel.org/lkml/20220518045517.2066518-1-tarumizu.kohei@fujitsu.com/

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
The source code for this driver is divided into common parts
(driver/base/pfctl.c) and hardware dependent parts
(arch/x86/kernel/cpu/x86-pfctl.c and drivers/soc/fujitsu/a64fx-pfctl.c).
Architecture parts is described hardware-dependent processing. It must
create attributes for a specific cache level/type.
Common part is described hardware-independent processing. It create
sysfs using the attributes from architecture part.

This driver creates "prefetch_control" directory and some attributes
in every CPU's cache/indexX directory, if CPU supports hardware
prefetch control behavior.

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
This patch series add hardware prefetch control core driver for A64FX
and x86. Also, we add support for A64FX and BROADWELL_X at x86.

- patch1: Add hardware prefetch core driver

  Adds a register/unregister function to provide sysfs interface to
  control CPU's hardware prefetch behavior. It creates the
  "prefetch_control" sysfs directory and some attributes.

- patch2: Add Kconfig/Makefile to build hardware prefetch control core
  driver

- patch3: Add support for A64FX

  Adds module init/exit code to create sysfs attributes for A64FX with
  "stream_detect_prefetcher_enable", "stream_detect_prefetcher_strong"
  and "stream_detect_prefetcher_dist".

- patch4: Add Kconfig/Makefile to build driver for A64FX

- patch5: Create cache sysfs directory without ACPI PPTT for hardware
  prefetch control

  Hardware Prefetch control driver needs cache sysfs directory and cache
  level/type information. In ARM processor, these information can be
  obtained from register(CLIDR_EL1) even without PPTT. Therefore, we
  set the cpu_map_populated to true to create cache sysfs directory, if
  the machine doesn't have PPTT.

- patch6: Add support for x86

  Adds module init/exit code to create sysfs attributes for x86 with
  "hardware_prefetcher_enable", "ip_prefetcher_enable" and
  "adjacent_cache_line_prefetcher_enable".

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
  soc: fujitsu: Add hardware prefetch control support for A64FX
  soc: fujitsu: Add Kconfig/Makefile to build hardware prefetch control
    driver
  arm64: Create cache sysfs directory without ACPI PPTT for hardware
    prefetch control
  x86: Add hardware prefetch control support for x86
  x86: Add Kconfig/Makefile to build hardware prefetch control driver
  docs: ABI: Add sysfs documentation interface of hardware prefetch
    control driver

 .../ABI/testing/sysfs-devices-system-cpu      |  98 +++++
 MAINTAINERS                                   |   8 +
 arch/arm64/kernel/cacheinfo.c                 |  29 ++
 arch/x86/Kconfig                              |   6 +
 arch/x86/kernel/cpu/Makefile                  |   2 +
 arch/x86/kernel/cpu/x86-pfctl.c               | 258 ++++++++++++
 drivers/base/Kconfig                          |   9 +
 drivers/base/Makefile                         |   1 +
 drivers/base/pfctl.c                          | 180 +++++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/fujitsu/Kconfig                   |  11 +
 drivers/soc/fujitsu/Makefile                  |   2 +
 drivers/soc/fujitsu/a64fx-pfctl.c             | 373 ++++++++++++++++++
 include/linux/pfctl.h                         |  14 +
 15 files changed, 993 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/x86-pfctl.c
 create mode 100644 drivers/base/pfctl.c
 create mode 100644 drivers/soc/fujitsu/Kconfig
 create mode 100644 drivers/soc/fujitsu/Makefile
 create mode 100644 drivers/soc/fujitsu/a64fx-pfctl.c
 create mode 100644 include/linux/pfctl.h

-- 
2.27.0

