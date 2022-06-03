Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA2553C946
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbiFCL2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbiFCL2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:28:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAD3289A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DACAEB822CD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34840C385A9;
        Fri,  3 Jun 2022 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654255722;
        bh=rCWQ8h4iZROohf/eePeMEeIAZ9OUn6bSM0M1Fgg4guA=;
        h=Date:From:To:Cc:Subject:From;
        b=TjWA7a1EJQdDGcPbW0X6Jf+rEPOoq2wzFz7hSbvShyFG5L8ZTeJxsjJJxesif5hZO
         Cy24ChfTFyRzfYt76xldZD/vuVaTuAL8ypBpKIQTMS25qaqPAbkVgSyG4ma6xjASIp
         n23yskSsuNNuhBJ6+PaDPoe1ae9UuMlJ8k+W4Tpw=
Date:   Fri, 3 Jun 2022 13:28:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 5.19-rc1
Message-ID: <YpnwZ/Q5yTKRDBOD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.19-rc1

for you to fetch changes up to b232b02bf3c205b13a26dcec08e53baddd8e59ed:

  driver core: fix deadlock in __device_attach (2022-05-19 19:37:08 +0200)

----------------------------------------------------------------
Driver core changes for 5.19-rc1

Here is the set of driver core changes for 5.19-rc1.

Note, I'm not really happy with this pull request as-is, see below for
details, but overall this is all good for everything but a small set of
systems, which we have a fix for already.

Lots of tiny driver core changes and cleanups happened this cycle,
but the two major things were:

	- firmware_loader reorganization and additions including the
	  ability to have XZ compressed firmware images and the ability
	  for userspace to initiate the firmware load when it needs to,
	  instead of being always initiated by the kernel. FPGA devices
	  specifically want this ability to have their firmware changed
	  over the lifetime of the system boot, and this allows them to
	  work without having to come up with yet-another-custom-uapi
	  interface for loading firmware for them.
	- physical location support added to sysfs so that devices that
	  know this information, can tell userspace where they are
	  located in a common way.  Some ACPI devices already support
	  this today, and more bus types should support this in the
	  future.

Smaller changes included:
	- driver_override api cleanups and fixes
	- error path cleanups and fixes
	- get_abi script fixes
	- deferred probe timeout changes.

It's that last change that I'm the most worried about.  It has been
reported to cause boot problems for a number of systems, and I have a
tested patch series that resolves this issue.  But I didn't get it
merged into my tree before 5.18-final came out, so it has not gotten any
linux-next testing.

I'll send the fixup patches (there are 2) as a follow-on series to this
pull request if you want to take them directly, _OR_ I can just revert
the probe timeout changes and they can wait for the next -rc1 merge
cycle.  Given that the fixes are tested, and pretty simple, I'm leaning
toward that choice.  Sorry this all came at the end of the merge window,
I should have resolved this all 2 weeks ago, that's my fault as it was
in the middle of some travel for me.

All have been tested in linux-next for weeks, with no reported issues
other than the above-mentioned boot time outs.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bagas Sanjaya (2):
      Documentation: dd: Use ReST lists for return values of driver_deferred_probe_check_state()
      firmware_loader: describe 'module' parameter of firmware_upload_register()

Christophe JAILLET (1):
      drivers/base/memory: Fix an unlikely reference counting issue in __add_memory_block()

Dan Carpenter (2):
      driver core: location: Check for allocations failure
      test_firmware: fix end of loop test in upload_read_show()

Dietmar Eggemann (1):
      topology: Remove unused cpu_cluster_mask()

Greg Kroah-Hartman (3):
      Revert "firmware_loader: use kernel credentials when reading firmware"
      Merge 5.18-rc5 into driver-core-next
      export: fix string handling of namespace in EXPORT_SYMBOL_NS

Hao Luo (1):
      kernfs: Separate kernfs_pr_cont_buf and rename_lock.

Haowen Bai (1):
      firmware: edd: Remove redundant condition

Imran Khan (2):
      kernfs: Remove reference counting for kernfs_open_node.
      kernfs: Rename kernfs_put_open_node to kernfs_unlink_open_file.

Krzysztof Kozlowski (14):
      driver: platform: Add helper for safer setting of driver_override
      amba: Use driver_set_override() instead of open-coding
      fsl-mc: Use driver_set_override() instead of open-coding
      hv: Use driver_set_override() instead of open-coding
      PCI: Use driver_set_override() instead of open-coding
      s390/cio: Use driver_set_override() instead of open-coding
      spi: Use helper for safer setting of driver_override
      vdpa: Use helper for safer setting of driver_override
      clk: imx: scu: Fix kfree() of static memory on setting driver_override
      slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
      rpmsg: Constify local variable in field store macro
      rpmsg: Fix kfree() of static memory on setting driver_override
      rpmsg: Fix calling device_lock() on non-initialized device
      rpmsg: use local 'dev' variable

Luis Chamberlain (1):
      MAINTAINERS: add Russ Weight as a firmware loader maintainer

Lukasz Luba (1):
      arch_topology: Trace the update thermal pressure

Mark-PK Tsai (1):
      driver core: Prevent overriding async driver of a device before it probe

Miaohe Lin (1):
      drivers/base/node.c: fix compaction sysfs file leak

Russ Weight (10):
      firmware_loader: Clear data and size in fw_free_paged_buf
      firmware_loader: Check fw_state_is_done in loading_store
      firmware_loader: Split sysfs support from fallback
      firmware_loader: Add firmware-upload support
      firmware_loader: Add sysfs nodes to monitor fw_upload
      test_firmware: Add test support for firmware upload
      test_firmware: Error injection for firmware upload
      selftests: firmware: Add firmware upload selftests
      firmware_loader: Fix configs for sysfs split
      firmware_loader: Move definitions from sysfs_upload.h to sysfs.h

Saravana Kannan (2):
      driver core: Add "*" wildcard support to driver_async_probe cmdline param
      driver core: Extend deferred probe timeout on driver registration

Schspa Shi (1):
      driver: base: fix UAF when driver_attach failed

SeongJae Park (1):
      scripts/get_abi: Fix wrong script file name in the help message

Sergey Shtylyov (1):
      platform: finally disallow IRQ0 in platform_get_irq() and its ilk

Takashi Iwai (5):
      firmware: Add the support for ZSTD-compressed firmware files
      selftests: firmware: Use smaller dictionary for XZ compression
      selftests: firmware: Fix the request_firmware_into_buf() test for XZ format
      selftests: firmware: Simplify test patterns
      selftests: firmware: Add ZSTD compressed file tests

Thiébaud Weksteen (1):
      firmware_loader: use kernel credentials when reading firmware

Won Chung (3):
      driver core: Add sysfs support for physical location of a device
      driver core: location: Free struct acpi_pld_info *pld
      driver core: location: Add "back" as a possible output for panel

Zhang Wensheng (1):
      driver core: fix deadlock in __device_attach

 Documentation/ABI/testing/sysfs-class-firmware     |  77 ++++
 .../ABI/testing/sysfs-devices-physical_location    |  42 ++
 Documentation/admin-guide/kernel-parameters.txt    |  11 +-
 Documentation/driver-api/firmware/fw_upload.rst    | 126 ++++++
 Documentation/driver-api/firmware/index.rst        |   1 +
 MAINTAINERS                                        |   1 +
 drivers/amba/bus.c                                 |  28 +-
 drivers/base/Makefile                              |   1 +
 drivers/base/arch_topology.c                       |   5 +
 drivers/base/base.h                                |   1 +
 drivers/base/bus.c                                 |   4 +-
 drivers/base/core.c                                |  15 +
 drivers/base/dd.c                                  |  44 ++-
 drivers/base/driver.c                              |  70 ++++
 drivers/base/firmware_loader/Kconfig               |  42 +-
 drivers/base/firmware_loader/Makefile              |   2 +
 drivers/base/firmware_loader/fallback.c            | 430 ---------------------
 drivers/base/firmware_loader/fallback.h            |  46 +--
 drivers/base/firmware_loader/firmware.h            |  16 +
 drivers/base/firmware_loader/main.c                |  94 ++++-
 drivers/base/firmware_loader/sysfs.c               | 422 ++++++++++++++++++++
 drivers/base/firmware_loader/sysfs.h               | 117 ++++++
 drivers/base/firmware_loader/sysfs_upload.c        | 397 +++++++++++++++++++
 drivers/base/firmware_loader/sysfs_upload.h        |  41 ++
 drivers/base/memory.c                              |   5 +-
 drivers/base/node.c                                |   1 +
 drivers/base/physical_location.c                   | 143 +++++++
 drivers/base/physical_location.h                   |  16 +
 drivers/base/platform.c                            |  34 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  25 +-
 drivers/clk/imx/clk-scu.c                          |   7 +-
 drivers/firmware/edd.c                             |   3 +-
 drivers/hv/vmbus_drv.c                             |  28 +-
 drivers/pci/pci-sysfs.c                            |  28 +-
 drivers/rpmsg/rpmsg_core.c                         |  42 +-
 drivers/rpmsg/rpmsg_internal.h                     |   5 +-
 drivers/rpmsg/rpmsg_ns.c                           |   4 +-
 drivers/s390/cio/cio.h                             |   6 +-
 drivers/s390/cio/css.c                             |  28 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |  13 +-
 drivers/spi/spi.c                                  |  26 +-
 drivers/vdpa/vdpa.c                                |  29 +-
 fs/kernfs/dir.c                                    |  31 +-
 fs/kernfs/file.c                                   |  47 ++-
 include/linux/amba/bus.h                           |   6 +-
 include/linux/device.h                             |  73 ++++
 include/linux/device/driver.h                      |   2 +
 include/linux/export.h                             |   7 +-
 include/linux/firmware.h                           |  82 ++++
 include/linux/fsl/mc.h                             |   6 +-
 include/linux/hyperv.h                             |   6 +-
 include/linux/pci.h                                |   6 +-
 include/linux/platform_device.h                    |   6 +-
 include/linux/rpmsg.h                              |  14 +-
 include/linux/spi/spi.h                            |   2 +
 include/linux/topology.h                           |   7 -
 include/linux/vdpa.h                               |   4 +-
 include/trace/events/thermal_pressure.h            |  29 ++
 lib/test_firmware.c                                | 381 ++++++++++++++++++
 scripts/get_abi.pl                                 |   4 +-
 tools/testing/selftests/firmware/Makefile          |   2 +-
 tools/testing/selftests/firmware/config            |   1 +
 tools/testing/selftests/firmware/fw_filesystem.sh  | 170 ++++----
 tools/testing/selftests/firmware/fw_lib.sh         |  19 +-
 tools/testing/selftests/firmware/fw_run_tests.sh   |   4 +
 tools/testing/selftests/firmware/fw_upload.sh      | 214 ++++++++++
 66 files changed, 2736 insertions(+), 863 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
 create mode 100644 Documentation/ABI/testing/sysfs-devices-physical_location
 create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
 create mode 100644 drivers/base/firmware_loader/sysfs.c
 create mode 100644 drivers/base/firmware_loader/sysfs.h
 create mode 100644 drivers/base/firmware_loader/sysfs_upload.c
 create mode 100644 drivers/base/firmware_loader/sysfs_upload.h
 create mode 100644 drivers/base/physical_location.c
 create mode 100644 drivers/base/physical_location.h
 create mode 100644 include/trace/events/thermal_pressure.h
 create mode 100755 tools/testing/selftests/firmware/fw_upload.sh
