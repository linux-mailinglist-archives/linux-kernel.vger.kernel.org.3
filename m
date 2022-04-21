Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603A650AAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441949AbiDUVZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441932AbiDUVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3047E4CD77
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650576130; x=1682112130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ggz6ux8d0cuk4Hf+sirCSautlfvOxuAL4mI2VfqoJL8=;
  b=bknHG5NYB/PU03DmkjrLZHDm/SEhw2FFefFMJXwMLW9aiuEba80bGBib
   Evtu0Tms4XziiHItqXoxpkwmxGEtnqLBlfdgzSlj8sdotR4+n5HdtBds2
   CS6XjvpYM7a/RQXvgoNABcaX5OlCU//rsvX60DCFUoZtuedvIPYBGxFT+
   v6okixbqb9E4EIFeEyO/52uMqlYCYQPBkWjjEv2qkluMquQ6S7/IZagV3
   ZXeverdjuZpx8TSMnKF/IjiaMQZBvkt001/Akiv70SrURcR1MKlnuM7G8
   FyfsoH1twuJ24AxlNheaDtj+mchlM9YrZq6U9SgoNxPoMu5fljkQBBy3o
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350924989"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="350924989"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 14:22:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="658704065"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.56.239])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 14:22:07 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v5 0/8] Extend FW framework for user FW uploads
Date:   Thu, 21 Apr 2022 14:21:56 -0700
Message-Id: <20220421212204.36052-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the firmware loader subsystem to support a persistent sysfs
interface that userspace may use to initiate a firmware update. For
example, FPGA based PCIe cards automatically load firmware and FPGA images
from local FLASH when the card boots. The images in FLASH may be updated
with new images that are uploaded by the user.

A device driver may call firmware_upload_register() to expose persistent
"loading" and "data" sysfs files at /sys/class/firmware/<NAME>/*. These
files are used in the same way as the fallback sysfs "loading" and "data"
files. However, when 0 is written to "loading" to complete the write of
firmware data, the data is also transferred to the lower-level driver
using pre-registered call-back functions. The data transfer is done in
the context of a kernel worker thread.

Additional sysfs nodes are added in the same location as "loading" and
"data" to monitor the transfer of the image data to the device using
callback functions provided by the lower-level device driver and to allow
the data transfer to be cancelled.

Example usage:

$ pwd
/sys/class/firmware/secure-update.1
$ ls
cancel  device  loading  remaining_size  subsystem
data    error   power    status          uevent
$ echo 1 > loading
$ cat /tmp/firmware.bin > data
$ echo 0 > loading
$ while :; do cat status; cat remaining_size ; sleep 3; done
preparing
44590080
<--snip-->
transferring
44459008
transferring
44311552
<--snip-->
transferring
173056
<--snip-->
programming
0
<--snip-->
idle
0
^C
$ cat error

The first two patches in this set make minor changes to enable the
fw_priv data structure and the sysfs interfaces to be used multiple times
during the existence of the device driver instance. The third patch is
mostly a reorganization of existing code in preparation for sharing common
code with the firmware-upload support. The fourth and fifth patches provide
the code for user-initiated firmware uploads. The final 3 patches extend
selftest support to test firmware-upload functionality.

The first driver to use firmware-upload is being submitted _soon_ under the
title of "Intel MAX10 BMC Secure Update Driver".

Changelog v4 -> v5:
  - Added Tested-by tag
  - More cleanup for "#ifdef CONFIG_FW_LOADER_USER_HELPER". Error reported
      by the kernel test robot <lkp@intel.com>.

Changelog v3 -> v4:
  - Added Reviewed-by tag
  - Fixed errors reported by the kernel test robot <lkp@intel.com> by
    adjusting the functions that are bound by
    "#ifdef CONFIG_FW_LOADER_USER_HELPER".

Changelog v2 -> v3:
  - Added Reviewed-by tag
  - Added kdoc support for enum fw_upload_prog progress codes

Changelog v1 -> v2:
  - Rebased to 5.18-rc2.
  - It was discovered that the new function in v1, fw_state_is_done(), is
    equivalent to the existing fw_sysfs_done() function. Renamed
    fw_sysfs_done() and fw_sysfs_loading() to fw_state_is_done() and
    fw_state_is_loading() respectively, and placed them along side
    companion functions in drivers/base/firmware_loader/firmware.h.
  - Removed the "if !fw_sysfs_done(fw_priv))" condition in switch case 1 of
    firmware_loading_store(). It is rendered unnecessary by other changes
    to the function.
  - Updated documentation Date and KernelVersion fields to July 2022
    and 5.19.
  - Unconditionally set fw_priv->is_paged_buf to true in
    firmware_upload_register();

Changelog RFC -> v1:
  - Renamed files fw_sysfs.c and fw_sysfs.h to sysfs.c and sysfs.h
  - Moved "MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);" from sysfs.c to
    sysfs.h to address an error identified by the kernel test robot
    <lkp@intel.com>
  - renamed fw_upload_register() and fw_upload_unregister() to
    firmware_upload_register() and fw_upload_unregister().
  - Moved ifdef'd section of code out of firmware_loading_store() in
    sysfs.c into a new function, fw_upload_start(), in sysfs_upload.c.
  - Changed #defines to enums for error codes and progress states
  - Added additional kernel-doc supported symbols into the documentation.
    Some rewording in documentation as well.
  - Added module reference counting for the parent module in the
    firmware_upload_register() and firmware_upload_unregister() functions
    to fix problems found when testing with test_firmware module.
  - Removed unnecessary module reference counting for THIS_MODULE.
  - Added a new patch to modify the test_firmware module to support
    testing of the firmware upload mechanism.
  - Added a new patch to modify the test_firmware module to support
    error injection for firmware upload.
  - Added a new patch to extend the existing firmware selftests to cover
    firmware upload.

Russ Weight (8):
  firmware_loader: Clear data and size in fw_free_paged_buf
  firmware_loader: Check fw_state_is_done in loading_store
  firmware_loader: Split sysfs support from fallback
  firmware_loader: Add firmware-upload support
  firmware_loader: Add sysfs nodes to monitor fw_upload
  test_firmware: Add test support for firmware upload
  test_firmware: Error injection for firmware upload
  selftests: firmware: Add firmware upload selftests

 .../ABI/testing/sysfs-class-firmware          |  77 ++++
 .../driver-api/firmware/fw_upload.rst         | 126 +++++
 Documentation/driver-api/firmware/index.rst   |   1 +
 drivers/base/firmware_loader/Kconfig          |  18 +
 drivers/base/firmware_loader/Makefile         |   2 +
 drivers/base/firmware_loader/fallback.c       | 430 ------------------
 drivers/base/firmware_loader/fallback.h       |  46 +-
 drivers/base/firmware_loader/firmware.h       |  16 +
 drivers/base/firmware_loader/main.c           |  18 +-
 drivers/base/firmware_loader/sysfs.c          | 425 +++++++++++++++++
 drivers/base/firmware_loader/sysfs.h          | 100 ++++
 drivers/base/firmware_loader/sysfs_upload.c   | 397 ++++++++++++++++
 drivers/base/firmware_loader/sysfs_upload.h   |  54 +++
 include/linux/firmware.h                      |  82 ++++
 lib/test_firmware.c                           | 378 +++++++++++++++
 tools/testing/selftests/firmware/Makefile     |   2 +-
 tools/testing/selftests/firmware/config       |   1 +
 tools/testing/selftests/firmware/fw_lib.sh    |   7 +
 .../selftests/firmware/fw_run_tests.sh        |   4 +
 tools/testing/selftests/firmware/fw_upload.sh | 214 +++++++++
 20 files changed, 1912 insertions(+), 486 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
 create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
 create mode 100644 drivers/base/firmware_loader/sysfs.c
 create mode 100644 drivers/base/firmware_loader/sysfs.h
 create mode 100644 drivers/base/firmware_loader/sysfs_upload.c
 create mode 100644 drivers/base/firmware_loader/sysfs_upload.h
 create mode 100755 tools/testing/selftests/firmware/fw_upload.sh

-- 
2.25.1

