Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044A3588E58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiHCOQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiHCOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458C6373
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92302615E6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90351C433D6;
        Wed,  3 Aug 2022 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659536178;
        bh=ZhQONk2oHcq1lG5FDvFuyW/DNrB2rdcTEJ+X6432EwE=;
        h=Date:From:To:Cc:Subject:From;
        b=NZiq1L4GNbvB2F+KeXtP5ryPI42fs2k0P8OE1+qi01EhBdyVo3RN8kV1z4pZrEofQ
         jtElH7HFGob9uFf/VPxDEArWIWrT72IdgwmdIXkddHU4JYIrYsHHzQ1c5urWQ8dFcO
         HSrFKUTFS72yBcLgJTXnyXV+6mZJRT6eAGvd9Yxo=
Date:   Wed, 3 Aug 2022 16:16:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.0-rc1
Message-ID: <YuqDMLF2AQyj4+N1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc1

for you to fetch changes up to 273aaa24369cb8d0f246bb16f7122b91a1ef5188:

  docs: embargoed-hardware-issues: fix invalid AMD contact email (2022-07-29 16:10:04 +0200)

----------------------------------------------------------------
Driver core / kernfs changes for 6.0-rc1

Here is the set of driver core and kernfs changes for 6.0-rc1.

"biggest" thing in here is some scalability improvements for kernfs for
large systems.  Other than that, included in here are:
	- arch topology and cache info changes that have been reviewed
	  and discussed a lot.
	- potential error path cleanup fixes
	- deferred driver probe cleanups
	- firmware loader cleanups and tweaks
	- documentation updates
	- other small things

All of these have been in the linux-next tree for a while with no
reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      driver core: Introduce device_find_any_child() helper
      spi: Use device_find_any_child() instead of custom approach

Dave Airlie (1):
      docs: driver-api: firmware: add driver firmware guidelines. (v3)

Duoming Zhou (2):
      devcoredump: remove the useless gfp_t parameter in dev_coredumpv and dev_coredumpm
      mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv

Fabio M. De Francesco (1):
      firmware_loader: Replace kmap() with kmap_local_page()

Florian Fainelli (1):
      MAINTAINERS: Change mentions of mpm to olivia

Greg Kroah-Hartman (4):
      Revert "mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv"
      Revert "devcoredump: remove the useless gfp_t parameter in dev_coredumpv and dev_coredumpm"
      Merge tag 'arch-cache-topo-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into driver-core-next
      docs: embargoed-hardware-issues: fix invalid AMD contact email

Imran Khan (5):
      kernfs: make ->attr.open RCU protected.
      kernfs: Change kernfs_notify_list to llist.
      kernfs: Introduce interface to access global kernfs_open_file_mutex.
      kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
      Revert "kernfs: Change kernfs_notify_list to llist."

Ionela Voinescu (1):
      arch_topology: Limit span of cpu_clustergroup_mask()

Lee Jones (2):
      docs: ABI: sysfs-class-pwm: Update Lee Jones' email address
      docs: ABI: sysfs-devices-soc: Update Lee Jones' email address

Liang He (1):
      firmware: Hold a reference for of_find_compatible_node()

Lin Feng (1):
      kernfs/file.c: remove redundant error return counter assignment

Mauro Carvalho Chehab (1):
      ABI: testing/sysfs-devices-system-cpu: remove duplicated core_id

Nick Desaulniers (1):
      Documentation/process: Add embargoed HW contact for LLVM

Phil Auld (1):
      drivers/base: fix userspace break from using bin_attributes for cpumap and cpulist

Randy Dunlap (1):
      kobject: fix Kconfig.debug "its" grammar

Saravana Kannan (11):
      PM: domains: Delete usage of driver_deferred_probe_check_state()
      pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
      net: mdio: Delete usage of driver_deferred_probe_check_state()
      driver core: Add wait_for_init_devices_probe helper function
      net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
      Revert "driver core: Set default deferred_probe_timeout back to 0."
      driver core: Set fw_devlink.strict=1 by default
      iommu/of: Delete usage of driver_deferred_probe_check_state()
      driver core: Delete driver_deferred_probe_check_state()
      driver core: fw_devlink: Allow firmware to mark devices as best effort
      of: base: Avoid console probe delay when fw_devlink.strict=1

Slark Xiao (2):
      kernfs: Fix typo 'the the' in comment
      sysfs docs: ABI: Fix typo in comment

Sudeep Holla (23):
      ACPI: PPTT: Use table offset as fw_token instead of virtual address
      cacheinfo: Use of_cpu_device_node_get instead cpu_dev->of_node
      cacheinfo: Add helper to access any cache index for a given CPU
      cacheinfo: Move cache_leaves_are_shared out of CONFIG_OF
      cacheinfo: Add support to check if last level cache(LLC) is valid or shared
      cacheinfo: Allow early detection and population of cache attributes
      cacheinfo: Use cache identifiers to check if the caches are shared if available
      cacheinfo: Align checks in cache_shared_cpu_map_{setup,remove} for readability
      arch_topology: Add support to parse and detect cache attributes
      arch_topology: Use the last level cache information from the cacheinfo
      arm64: topology: Remove redundant setting of llc_id in CPU topology
      arch_topology: Drop LLC identifier stash from the CPU topology
      arch_topology: Set thread sibling cpumask only within the cluster
      arch_topology: Check for non-negative value rather than -1 for IDs validity
      arch_topology: Avoid parsing through all the CPUs once a outlier CPU is found
      arch_topology: Don't set cluster identifier as physical package identifier
      arch_topology: Set cluster identifier in each core/thread from /cpu-map
      arch_topology: Add support for parsing sockets in /cpu-map
      arch_topology: Warn that topology for nested clusters is not supported
      ACPI: Remove the unused find_acpi_cpu_cache_topology()
      cacheinfo: Use atomic allocation for percpu cache attributes
      ACPI: PPTT: Leave the table mapped for the runtime usage
      arch_topology: Fix cache attributes detection in the CPU hotplug path

Yangxi Xiang (1):
      devtmpfs: fix the dangling pointer of global devtmpfsd thread

Yushan Zhou (1):
      kernfs: fix potential NULL dereference in __kernfs_remove

Zhang Wensheng (1):
      driver core: fix potential deadlock in __driver_attach

 Documentation/ABI/stable/sysfs-module              |   2 +-
 Documentation/ABI/testing/sysfs-class-pwm          |   2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-client  |   2 +-
 Documentation/ABI/testing/sysfs-class-rtrs-server  |   2 +-
 .../ABI/testing/sysfs-devices-platform-ACPI-TAD    |   2 +-
 Documentation/ABI/testing/sysfs-devices-power      |   2 +-
 Documentation/ABI/testing/sysfs-devices-soc        |  14 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |   7 +-
 Documentation/driver-api/firmware/core.rst         |   1 +
 .../firmware/firmware-usage-guidelines.rst         |  44 +++++
 .../process/embargoed-hardware-issues.rst          |   5 +-
 .../zh_CN/process/embargoed-hardware-issues.rst    |   2 +-
 .../zh_TW/process/embargoed-hardware-issues.rst    |   2 +-
 MAINTAINERS                                        |   4 +-
 arch/arm64/kernel/topology.c                       |  14 --
 drivers/acpi/pptt.c                                | 142 +++++---------
 drivers/base/arch_topology.c                       | 100 +++++++---
 drivers/base/base.h                                |   1 +
 drivers/base/cacheinfo.c                           | 145 +++++++++------
 drivers/base/core.c                                | 123 ++++++++++++-
 drivers/base/dd.c                                  |  59 +++---
 drivers/base/devtmpfs.c                            |   1 +
 drivers/base/firmware_loader/main.c                |   4 +-
 drivers/base/firmware_loader/sysfs.c               |  10 +-
 drivers/base/node.c                                |   4 +-
 drivers/base/power/domain.c                        |   2 +-
 drivers/base/topology.c                            |  32 ++--
 drivers/iommu/of_iommu.c                           |   2 +-
 drivers/net/mdio/fwnode_mdio.c                     |   4 +-
 drivers/of/base.c                                  |   2 +
 drivers/pinctrl/devicetree.c                       |   2 +-
 drivers/spi/spi.c                                  |   9 +-
 fs/kernfs/dir.c                                    |   7 +-
 fs/kernfs/file.c                                   | 205 ++++++++++++++-------
 fs/kernfs/kernfs-internal.h                        |   4 +
 fs/kernfs/mount.c                                  |  19 ++
 include/linux/acpi.h                               |   5 -
 include/linux/arch_topology.h                      |   1 -
 include/linux/cacheinfo.h                          |   3 +
 include/linux/cpumask.h                            |  18 ++
 include/linux/device.h                             |   2 +
 include/linux/device/driver.h                      |   2 +-
 include/linux/firmware/trusted_foundations.h       |   8 +-
 include/linux/fwnode.h                             |   4 +
 include/linux/kernfs.h                             |  59 +++++-
 lib/Kconfig.debug                                  |   2 +-
 net/ipv4/ipconfig.c                                |   6 +
 47 files changed, 718 insertions(+), 374 deletions(-)
 create mode 100644 Documentation/driver-api/firmware/firmware-usage-guidelines.rst
