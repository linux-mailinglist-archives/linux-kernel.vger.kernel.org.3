Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D140B48C549
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353800AbiALNzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353765AbiALNzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:55:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2292C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:55:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4062E60DCE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 13:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F03C36AEA;
        Wed, 12 Jan 2022 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641995735;
        bh=Z5lhLj7cTxwb580kLBdUVXd7cpZo5KXwzpQUv1nnKvg=;
        h=Date:From:To:Cc:Subject:From;
        b=Tjb7GQnB5O4aEO/COOApWpi70TYhoWErs7MYlEqMHdRiEaxtOrgGkxdB3aYOyXRKD
         Ld82lKhp1T+cGYJbMW1tkLr5YNIetHLG/yTfnmDHbwj7m6ZgZV2ydcSFVWjN23fGcW
         1LaYFznR8U4BaqLAx7CIjAGmetKc2teAXbrWkn/g=
Date:   Wed, 12 Jan 2022 14:55:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 5.17-rc1
Message-ID: <Yd7d1E/0k0IIEl0G@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.17-rc1

for you to fetch changes up to c9512fd032acfe6f5198c30b6e7e52e0a7df5d31:

  kobject documentation: remove default_attrs information (2022-01-07 11:23:37 +0100)

----------------------------------------------------------------
driver core changes for 5.17-rc1

Here is the set of changes for the driver core for 5.17-rc1.

Lots of little things here, including:
	- kobj_type cleanups
	- auxiliary_bus documentation updates
	- auxiliary_device conversions for some drivers (relevant
	  subsystems all have provided acks for these)
	- kernfs lock contention reduction for some workloads
	- other tiny cleanups and changes.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      kobject: Replace kernel.h with the necessary inclusions
      kernfs: Replace kernel.h with the necessary inclusions

Cai Huoqing (1):
      driver core: platform: Make use of the helper function dev_err_probe()

Daniel Scally (1):
      device property: Check fwnode->secondary when finding properties

David E. Box (7):
      PCI: Add #defines for accessing PCIe DVSEC fields
      driver core: auxiliary bus: Add driver data helpers
      platform/x86/intel: Move intel_pmt from MFD to Auxiliary Bus
      RDMA/irdma: Use auxiliary_device driver data helpers
      soundwire: intel: Use auxiliary_device driver data helpers
      net/mlx5e: Use auxiliary_device driver data helpers
      vdpa/mlx5: Use auxiliary_device driver data helpers

Greg Kroah-Hartman (8):
      kobject: remove kset from struct kset_uevent_ops callbacks
      nilfs2: use default_groups in kobj_type
      sh: sq: use default_groups in kobj_type
      firmware: memmap: use default_groups in kobj_type
      qemu_fw_cfg: use default_groups in kobj_type
      firmware: dmi-sysfs: use default_groups in kobj_type
      firmware: edd: remove empty default_attrs array
      kobject documentation: remove default_attrs information

Heiko Carstens (4):
      topology/sysfs: export die attributes only if an architectures has support
      topology/sysfs: export cluster attributes only if an architectures has support
      topology/sysfs: rework book and drawer topology ifdefery
      topology/sysfs: get rid of htmldoc warning

Ingo Molnar (1):
      headers/uninline: Uninline single-use function: kobject_has_children()

Ira Weiny (7):
      Documentation/auxiliary_bus: Clarify auxiliary_device creation
      Documentation/auxiliary_bus: Clarify match_name
      Documentation/auxiliary_bus: Update Auxiliary device lifespan
      Documentation/auxiliary_bus: Clarify __auxiliary_driver_register
      Documentation/auxiliary_bus: Add example code for module_auxiliary_driver()
      Documentation/auxiliary_bus: Clarify the release of devices from find device
      Documentation/auxiliary_bus: Move the text into the code

Johan Hovold (1):
      driver core: platform: document registration-failure requirement

Kees Cook (1):
      devtmpfs: mount with noexec and nosuid

Kohei Tarumizu (2):
      docs: document the sysfs ABI for "nohz_full"
      docs: document the sysfs ABI for "isolated"

Lu Baolu (2):
      driver core: Move driver_sysfs_remove() after driver_sysfs_add()
      driver core: Make bus notifiers in right order in really_probe()

Mark-PK Tsai (1):
      driver core: Simplify async probe test code by using ktime_ms_delta()

Miaoqian Lin (1):
      drivers/firmware: Add missing platform_device_put() in sysfb_create_simplefb

Michal Suchanek (1):
      debugfs: lockdown: Allow reading debugfs files that are not world readable

Minchan Kim (2):
      kernfs: switch global kernfs_rwsem lock to per-fs lock
      kernfs: prevent early freeing of root node

Wedson Almeida Filho (1):
      driver core: make kobj_type constant.

 Documentation/ABI/testing/sysfs-devices-system-cpu |  15 +
 Documentation/admin-guide/cputopology.rst          |  25 +-
 Documentation/core-api/kobject.rst                 |  16 +-
 Documentation/driver-api/auxiliary_bus.rst         | 236 ++----------
 .../translations/zh_CN/core-api/kobject.rst        |  12 +-
 MAINTAINERS                                        |  12 +-
 arch/sh/kernel/cpu/sh4/sq.c                        |   3 +-
 drivers/base/Kconfig                               |  11 +
 drivers/base/auxiliary.c                           | 152 +++++++-
 drivers/base/bus.c                                 |   4 +-
 drivers/base/core.c                                |  30 +-
 drivers/base/dd.c                                  |   7 +-
 drivers/base/devtmpfs.c                            |  10 +-
 drivers/base/platform.c                            |   9 +-
 drivers/base/property.c                            |  13 +-
 drivers/base/test/test_async_driver_probe.c        |  14 +-
 drivers/base/topology.c                            |  28 +-
 drivers/dma-buf/dma-buf-sysfs-stats.c              |   2 +-
 drivers/firmware/dmi-sysfs.c                       |   7 +-
 drivers/firmware/edd.c                             |   9 -
 drivers/firmware/memmap.c                          |   3 +-
 drivers/firmware/qemu_fw_cfg.c                     |   5 +-
 drivers/firmware/sysfb_simplefb.c                  |   8 +-
 drivers/infiniband/hw/irdma/main.c                 |   4 +-
 drivers/infiniband/hw/mlx5/main.c                  |   8 +-
 drivers/mfd/Kconfig                                |  10 -
 drivers/mfd/Makefile                               |   1 -
 drivers/mfd/intel_pmt.c                            | 261 -------------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   8 +-
 drivers/platform/x86/intel/Kconfig                 |  11 +
 drivers/platform/x86/intel/Makefile                |   2 +
 drivers/platform/x86/intel/pmt/Kconfig             |   4 +-
 drivers/platform/x86/intel/pmt/class.c             |  21 +-
 drivers/platform/x86/intel/pmt/class.h             |   5 +-
 drivers/platform/x86/intel/pmt/crashlog.c          |  47 +--
 drivers/platform/x86/intel/pmt/telemetry.c         |  46 +--
 drivers/platform/x86/intel/vsec.c                  | 408 +++++++++++++++++++++
 drivers/platform/x86/intel/vsec.h                  |  43 +++
 drivers/soundwire/intel.c                          |   8 +-
 drivers/soundwire/intel_init.c                     |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   4 +-
 fs/debugfs/file.c                                  |   2 +-
 fs/dlm/lockspace.c                                 |   3 +-
 fs/gfs2/sys.c                                      |   3 +-
 fs/kernfs/dir.c                                    | 118 +++---
 fs/kernfs/file.c                                   |   6 +-
 fs/kernfs/inode.c                                  |  22 +-
 fs/kernfs/mount.c                                  |  15 +-
 fs/kernfs/symlink.c                                |   5 +-
 fs/nilfs2/sysfs.c                                  |  13 +-
 include/linux/auxiliary_bus.h                      | 174 +++++++++
 include/linux/kernfs.h                             |   6 +-
 include/linux/kobject.h                            |  34 +-
 include/linux/topology.h                           |  25 ++
 include/uapi/linux/pci_regs.h                      |   4 +
 kernel/params.c                                    |   4 +-
 lib/kobject.c                                      |   8 +-
 lib/kobject_uevent.c                               |   6 +-
 58 files changed, 1217 insertions(+), 755 deletions(-)
 delete mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel/vsec.c
 create mode 100644 drivers/platform/x86/intel/vsec.h
