Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1534A8FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355261AbiBCVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:31:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:32971 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355186AbiBCVa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643923858; x=1675459858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8K/8FE59HHxuTutcM3wLOa58kMUSPfrQoyCSTsffdP4=;
  b=WVm3TV0Bdu3SCkOqLe+KSqZ/KbIt+aWsHsxZEeBel7qX8rYcRkHXs2jo
   1YViNeq3eUlSXhp0ZWnFSKjqtvkv5CSWzYkXOEYIZGW+2+6kVjia2pqzo
   5+7P3BELYnN650QipRVAVbuh5pQ01e1QqzMC8wKClH5E4292huIyayEzr
   yEhfKTgKBfWMkZWWtNg+eQVICOWl9y3OxR2VpogBTfW8tl4y5N6If+LCm
   I7utVavdL1pBctBNYS2ztFlUw2t0jzeYHgyFPUg+1hF8g0FUrBxk2aNm+
   7aQohnSdnNsb90iw2M3fb49JOaMt+HMqlThNk9CpIER+cYHdDLe0+dmkA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334633970"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="334633970"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 13:30:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="583931498"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.6.75])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 13:30:57 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH 0/5] Extend FW framework for user FW uploads
Date:   Thu,  3 Feb 2022 14:30:47 -0700
Message-Id: <20220203213053.360190-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the firmware loader subsystem to support a persistent sysfs
interface that userspace may use to initiate a firmware update. For
example, FPGA based PCIe cards automatically load firmware and FPGA images
from local FLASH when the card boots. The images in FLASH may be updated
with new images that are uploaded by the user.

A device driver may call fw_upload_register() to expose persistent
"loading" and "data" sysfs files at /sys/class/firmare/<NAME>/*. These
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
/sys/class/firmware/n3000bmc-sec-update.8
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
<snip>
transferring
173056
<--snip-->
programming
0
<--snip-->
idle
0
^C

The first two patches in this set make minor changes to enable the
fw_priv data structure and the sysfs interfaces to be used multiple times
during the existence of the device driver instance. The third patch is
mostly a reorganization of existing code in preparation for sharing common
code with the firmware-upload support. The final two patches provide the
code for user-initiated firmware uploads.

This driver was previously submitted in the context of the FPGA sub-
system as the "FPGA Image Load Framework", but the framework is generic
enough to support other devices as well. The previous submission of this
patch-set can be viewed here:

https://marc.info/?l=linux-kernel&m=163295640216820&w=2

The n3000bmc-sec-update driver is the first driver to use the Firmware
Upload API. A recent version of these patches can be viewed here:

https://marc.info/?l=linux-kernel&m=163295697217095&w=2

- Russ

Russ Weight (5):
  firmware_loader: Clear data and size in fw_free_paged_buf
  firmware_loader: Check fw_state_is_done in loading_store
  firmware_loader: Split fw_sysfs support from fallback
  firmware_loader: Add firmware-upload support
  firmware_loader: Add sysfs nodes to monitor fw_upload

 .../ABI/testing/sysfs-class-firmware          |  77 +++
 .../driver-api/firmware/fw_upload.rst         | 103 ++++
 Documentation/driver-api/firmware/index.rst   |   1 +
 drivers/base/firmware_loader/Kconfig          |  18 +
 drivers/base/firmware_loader/Makefile         |   2 +
 drivers/base/firmware_loader/fallback.c       | 430 ----------------
 drivers/base/firmware_loader/fallback.h       |  46 +-
 drivers/base/firmware_loader/firmware.h       |  11 +
 drivers/base/firmware_loader/fw_sysfs.c       | 468 ++++++++++++++++++
 drivers/base/firmware_loader/fw_sysfs.h       |  98 ++++
 drivers/base/firmware_loader/fw_upload.c      | 348 +++++++++++++
 drivers/base/firmware_loader/fw_upload.h      |  29 ++
 drivers/base/firmware_loader/main.c           |  18 +-
 include/linux/firmware.h                      |  72 +++
 14 files changed, 1236 insertions(+), 485 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
 create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
 create mode 100644 drivers/base/firmware_loader/fw_sysfs.c
 create mode 100644 drivers/base/firmware_loader/fw_sysfs.h
 create mode 100644 drivers/base/firmware_loader/fw_upload.c
 create mode 100644 drivers/base/firmware_loader/fw_upload.h

-- 
2.25.1

