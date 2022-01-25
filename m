Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11AC49A87B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319013AbiAYDHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:07:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:13697 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3415112AbiAYCTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643077147; x=1674613147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6xLqbgqDlZUekHnaHtgQjVa+NNbsXY1WO2zG3rhTyLI=;
  b=ToCzeZ/PdqSFIeoO9kjavlr3eaSNASQejG6+GDfwfyIEAjbClNkqMKOt
   4uz7MLmQPrqsIKhUh0EUoR/UJfmEkFfCaFHi2ff7gSsrVhgS9D0hWZYmA
   d519MLkRSJRYDT9dHwG3uCy9S/+yLexIJ2TRyQSG7dHKnlgmnsO9r7NEM
   SNHmfF33d4dg/Kv0ur0JBkWFI2+WhfxHIKmuU891O1YxSE0DrATuDAX2J
   CeiAcjEaBRuLyusbwBWrkXow2iyQrpldoPoFypyS399pO5BovpqOKLRx9
   eBReJdQROvOkDlsrsJk24UXn6+4ddnhOAMUEJgc/DqDpnnGmWYwAH0GLR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233556419"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="233556419"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:11:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="534498832"
Received: from kerguder-mobl.ger.corp.intel.com (HELO localhost) ([10.249.158.133])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:11:39 -0800
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH v6 00/13] Introduce PECI subsystem
Date:   Tue, 25 Jan 2022 02:10:51 +0100
Message-Id: <20220125011104.2480133-1-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Small updates, mainly in ASPEED PECI driver.
Biggest one is replacing memcpy_toio/fromio with regular readl/writel,
to fix problems observed when PECI request/response are unaligned.

Here is the usual cover letter from the previous revision:

The Platform Environment Control Interface (PECI) is a communication
interface between Intel processors and management controllers (e.g.
Baseboard Management Controller, BMC).

This series adds a PECI subsystem and introduces drivers which run in
the Linux instance on the management controller (not the main Intel
processor) and is intended to be used by the OpenBMC [1], a Linux
distribution for BMC devices.
The information exposed over PECI (like processor and DIMM
temperature) refers to the Intel processor and can be consumed by
daemons running on the BMC to, for example, display the processor
temperature in its web interface.

The PECI bus is collection of code that provides interface support
between PECI devices (that actually represent processors) and PECI
controllers (such as the "peci-aspeed" controller) that allow to
access physical PECI interface. PECI devices are bound to PECI
drivers that provides access to PECI services. This series introduces
a generic "peci-cpu" driver that exposes hardware monitoring "cputemp"
and "dimmtemp" using the auxiliary bus.

Exposing "raw" PECI to userspace, either to write userspace drivers or
for debug/testing purpose was left out of this series to encourage
writing kernel drivers instead, but may be pursued in the future.

Introducing PECI to upstream Linux was already attempted before [2].
Since it's been over a year since last revision, and the series
changed quite a bit in the meantime, I've decided to start from v1.

I would also like to give credit to everyone who helped me with
different aspects of preliminary review:
- Pierre-Louis Bossart,
- Tony Luck, 
- Andy Shevchenko,
- Dave Hansen.

[1] https://github.com/openbmc/openbmc
[2] https://lore.kernel.org/openbmc/20191211194624.2872-1-jae.hyun.yoo@linux.intel.com/

Changes v5 -> v6:
* Added missing COMMON_CLK selection (lkp@intel.com)
* Fixed WARN_ON always evaluated to true (lkp@intel.com)
* Clean interrupt status unconditionally (Joel)
* Replaced memcpy_toio()/memcpy_fromio() with writel()/readl() to
  avoid issues when submitting unaligned PECI commands

Changes v4 -> v5:
* Added clk_aspeed_peci to express controller programming using common
  clock framework (Billy)
* Modified peci-aspeed DTS schema to match clock changes (Billy)
* Added workaround for peci-aspeed controller hang (Billy)
* Removed unnecessary "else after return" (Guenter)

Changes v3 -> v4:
* Fixed an issue where peci doesn't work after host shutdown (Zev)
* Replaced kill_device() with peci_device_del_lock (Greg)
* Fixed dts_valid() parameter type (Guenter)
* Removed Jae from MAINTAINERS file (Jae)

Changes v2 -> v3:

* Dropped x86/cpu patches (Boris)
* Dropped pr_fmt() for PECI module (Dan)
* Fixed releasing peci controller device flow (Dan) 
* Improved peci-aspeed commit-msg and Kconfig help (Dan)
* Fixed aspeed_peci_xfer() to use the proper spin_lock function (Dan) 
* Wrapped print_hex_dump_bytes() in CONFIG_DYNAMIC_DEBUG (Dan)
* Removed debug status logs from aspeed_peci_irq_handler() (Dan)
* Renamed functions using devres to start with "devm" (Dan)
* Changed request to be allocated on stack in peci_detect (Dan)
* Removed redundant WARN_ON on invalid PECI addr (Dan)
* Changed peci_device_create() to use device_initialize() + device_add() pattern (Dan)
* Fixed peci_device_destroy() to use kill_device() avoiding double-free (Dan)
* Renamed functions that perform xfer using "peci_xfer_*" prefix (Dan) 
* Renamed peci_request_data_dib(temp) -> peci_request_dib(temp)_read (Dan)
* Fixed thermal margin readings for older Intel processors (Zev) 
* Misc hwmon simplifications (Guenter)
* Used BIT_PER_TYPE to verify macro value constrains (Guenter)
* Improved WARN_ON message to print chan_rank_max and idx_dimm_max (Guenter)
* Improved dimmtemp to not reattempt probe if no dimms are populated

Changes v1 -> v2:

Biggest changes when it comes to diffstat are locking in HWMON
(I decided to clean things up a bit while adding it), switching to
devres usage in more places and exposing sysfs interface in separate patch.

* Moved extending X86 ARCHITECTURE MAINTAINERS earlier in series (Dan)
* Removed "default n" for GENERIC_LIB_X86 (Dan)
* Added vendor prefix for peci-aspeed specific properties (Rob)
* Refactored PECI to use devres consistently (Dan)
* Added missing sysfs documentation and excluded adding peci-sysfs to
  separate patch (Dan)
* Used module_init() instead of subsys_init() for peci module initialization (Dan)
* Removed redundant struct peci_device member (Dan)
* Improved PECI Kconfig help (Randy/Dan)
* Fixed/removed log messages (Dan, Guenter)
* Refactored peci-cputemp and peci-dimmtemp and added missing locks (Guenter)
* Removed unused dev_set_drvdata() in peci-cputemp and peci-dimmtemp (Guenter)
* Fixed used types, names, fixed broken and added additional comments
  to peci-hwmon (Guenter, Zev)
* Refactored peci-dimmtemp to not return -ETIMEDOUT (Guenter)
* Added sanity check for min_peci_revision in peci-hwmon drivers (Zev)
* Added assert for DIMM_NUMS_MAX and additional warning in peci-dimmtemp (Zev)
* Fixed macro names in peci-aspeed (Zev)
* Refactored peci-aspeed sanitizing properties to a single helper function (Zev)
* Fixed peci_cpu_device_ids definition for Broadwell Xeon D (David)
* Refactor peci_request to use a single allocation (Zev)
* Used min_t() to improve code readability (Zev)
* Added macro for PECI_RDENDPTCFG_MMIO_WR_LEN_BASE and fixed adev type
  array name to more descriptive (Zev)
* Fixed peci-hwmon commit-msg and documentation (Zev)

Thanks
-Iwona

Iwona Winiarska (11):
  dt-bindings: Add generic bindings for PECI
  dt-bindings: Add bindings for peci-aspeed
  ARM: dts: aspeed: Add PECI controller nodes
  peci: Add core infrastructure
  peci: Add device detection
  peci: Add sysfs interface for PECI bus
  peci: Add support for PECI device drivers
  peci: Add peci-cpu driver
  hwmon: peci: Add cputemp driver
  hwmon: peci: Add dimmtemp driver
  docs: Add PECI documentation

Jae Hyun Yoo (2):
  peci: Add peci-aspeed controller driver
  docs: hwmon: Document PECI drivers

 Documentation/ABI/testing/sysfs-bus-peci      |  16 +
 .../devicetree/bindings/peci/peci-aspeed.yaml |  72 ++
 .../bindings/peci/peci-controller.yaml        |  33 +
 Documentation/hwmon/index.rst                 |   2 +
 Documentation/hwmon/peci-cputemp.rst          |  90 +++
 Documentation/hwmon/peci-dimmtemp.rst         |  57 ++
 Documentation/index.rst                       |   1 +
 Documentation/peci/index.rst                  |  16 +
 Documentation/peci/peci.rst                   |  51 ++
 MAINTAINERS                                   |  26 +
 arch/arm/boot/dts/aspeed-g4.dtsi              |  11 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |  11 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  11 +
 drivers/Kconfig                               |   3 +
 drivers/Makefile                              |   1 +
 drivers/hwmon/Kconfig                         |   2 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/peci/Kconfig                    |  31 +
 drivers/hwmon/peci/Makefile                   |   7 +
 drivers/hwmon/peci/common.h                   |  58 ++
 drivers/hwmon/peci/cputemp.c                  | 592 ++++++++++++++++
 drivers/hwmon/peci/dimmtemp.c                 | 630 ++++++++++++++++++
 drivers/peci/Kconfig                          |  36 +
 drivers/peci/Makefile                         |  10 +
 drivers/peci/controller/Kconfig               |  18 +
 drivers/peci/controller/Makefile              |   3 +
 drivers/peci/controller/peci-aspeed.c         | 599 +++++++++++++++++
 drivers/peci/core.c                           | 236 +++++++
 drivers/peci/cpu.c                            | 343 ++++++++++
 drivers/peci/device.c                         | 252 +++++++
 drivers/peci/internal.h                       | 136 ++++
 drivers/peci/request.c                        | 482 ++++++++++++++
 drivers/peci/sysfs.c                          |  82 +++
 include/linux/peci-cpu.h                      |  40 ++
 include/linux/peci.h                          | 112 ++++
 35 files changed, 4071 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-peci
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml
 create mode 100644 Documentation/devicetree/bindings/peci/peci-controller.yaml
 create mode 100644 Documentation/hwmon/peci-cputemp.rst
 create mode 100644 Documentation/hwmon/peci-dimmtemp.rst
 create mode 100644 Documentation/peci/index.rst
 create mode 100644 Documentation/peci/peci.rst
 create mode 100644 drivers/hwmon/peci/Kconfig
 create mode 100644 drivers/hwmon/peci/Makefile
 create mode 100644 drivers/hwmon/peci/common.h
 create mode 100644 drivers/hwmon/peci/cputemp.c
 create mode 100644 drivers/hwmon/peci/dimmtemp.c
 create mode 100644 drivers/peci/Kconfig
 create mode 100644 drivers/peci/Makefile
 create mode 100644 drivers/peci/controller/Kconfig
 create mode 100644 drivers/peci/controller/Makefile
 create mode 100644 drivers/peci/controller/peci-aspeed.c
 create mode 100644 drivers/peci/core.c
 create mode 100644 drivers/peci/cpu.c
 create mode 100644 drivers/peci/device.c
 create mode 100644 drivers/peci/internal.h
 create mode 100644 drivers/peci/request.c
 create mode 100644 drivers/peci/sysfs.c
 create mode 100644 include/linux/peci-cpu.h
 create mode 100644 include/linux/peci.h

-- 
2.31.1

