Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230447FADE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 09:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhL0ID4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 03:03:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38486 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhL0IDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 03:03:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA80D60DD0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 08:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76547C36AE9;
        Mon, 27 Dec 2021 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640592234;
        bh=HBzWOkjKuPCKfKM6P9L78AlKHbrk1sHPS11ryGwqNjA=;
        h=Date:From:To:Cc:Subject:From;
        b=rJRo89bVVGtLA7BsvOA9x1j03e3xvC1IoTR7QkeVr2i16r/kg2eBdhg5cJeYBE9gg
         xdonM7XE95IixtIedDTpffTVb5pxOV4x3dZ0r3nV4ihFkjO5JKLxhxjjtkQVIdKqWL
         4u3qdtHqLj2MGVZO+63/MZ6Sz7xOAJ1I8AjnWqe/0RPKDSVQte/uf6SeXLdL4veu05
         vXWHmcBKei3+qwbOFWvPEEYxAxMKPG4Wu/yset3+byNZfvR0TEQHyEgn++pcHuRSij
         QjmmuEAkVENx1pkeCPmCMeFpX9tQ0cYMN0hZgRCHbQJUzOxQr5H13HIXDWdg/s3NwH
         OkUe1GKLHeBBg==
Date:   Mon, 27 Dec 2021 10:03:50 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.17
Message-ID: <20211227080350.GA469126@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs pull request for the merge window of kernel 5.17.
It mainly enhances the driver to deal with extreme cases, such as
reset-during-reset, events during reset and allowing monitoring
applications to continue running during reset.

Full details are in the tag.

Thanks,
Oded

The following changes since commit 1bb866dcb8cf5054de88f592fc0ec1f275ad9d63:

  Merge tag 'iio-for-5.17a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2021-12-22 12:33:01 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git misc-habanalabs-next-2021-12-27

for you to fetch changes up to ce80098db2439ee44403ec6fccd3a10be21c7aff:

  habanalabs: support hard-reset scheduling during soft-reset (2021-12-26 14:42:31 +0200)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.17:

- Support reset-during-reset. In case the f/w notifies the driver
  that the f/w is going to reset the device, the driver should
  support that even if it is in the middle of doing another
  reset

- Support events from f/w that arrive during device resets.
  These events would be ignored which is bad as critical errors
  would not be reported and treated by the driver.

- Don't kill processes that hold the control device open during
  hard-reset of the device. The control device operations can't
  crash if done during hard-reset. And usually, only monitoring
  applications are using the control device, so killing them
  defies their purpose.

- Fix handling of hwmon nodes when working with legacy f/w

- Change the compute context pointer to be boolean. This pointer
  was abused by multiple code paths that wanted fast access to
  the compute context structure.

- Add uapi to fetch historical errors. This is necessary as errors
  sometimes result in hard-reset where the user application is
  being terminated.

- Optimize GAUDI's MMU cache invalidation.

- Add support for loading the latest f/w.

- Add uapi to fetch HBM replacement and pending rows information.

- Multiple bug fixes to the reset code.

- Multiple bug fixes for Multi-CS ioctl code.

- Multiple bug fixes for wait-for-interrupt ioctl code.

- Many small bug fixes and cleanups.

----------------------------------------------------------------
Bharat Jauhari (3):
      habanalabs: handle abort scenario for user interrupt
      habanalabs: rename reset flags
      habanalabs: refactor wait-for-user-interrupt function

Dani Liberman (6):
      habanalabs: change wait for interrupt timeout to 64 bit
      habanalabs: add support for fetching historic errors
      habanalabs: fix race condition in multi CS completion
      habanalabs: add SOB information to signal submission uAPI
      habanalabs: enable access to info ioctl during hard reset
      habanalabs: keep control device alive during hard reset

Guy Zadicario (1):
      habanalabs/gaudi: fix debugfs dma channel selection

Oded Gabbay (16):
      habanalabs/gaudi: recover from CPU WD event
      habanalabs: make hdev creation code more readable
      habanalabs: prevent false heartbeat message
      habanalabs: abort reset on invalid request
      habanalabs: fix soft reset accounting
      habanalabs: rename late init after reset function
      habanalabs/gaudi: return EPERM on non hard-reset
      habanalabs: free signal handle on failure
      habanalabs: remove redundant check on ctx_fini
      habanalabs: save ctx inside encaps signal
      habanalabs: fix etr asid configuration
      habanalabs: add helper to get compute context
      habanalabs: remove compute context pointer
      habanalabs: remove in_debug check in device open
      habanalabs: fix hwmon handling for legacy f/w
      habanalabs: replace some -ENOTTY with -EINVAL

Ofir Bitton (18):
      habanalabs: expand clock throttling information uAPI
      habanalabs: debugfs support for larger I2C transactions
      habanalabs: handle device TPM boot error as warning
      habanalabs: fix possible deadlock in cache invl failure
      habanalabs: move device boot warnings to the correct location
      habanalabs: add more info ioctls support during reset
      habanalabs: change misleading IRQ warning during reset
      habanalabs: handle events during soft-reset
      habanalabs: return correct clock throttling period
      habanalabs: add current PI value to cpu packets
      habanalabs: sysfs support for two infineon versions
      habanalabs: expose soft reset sysfs nodes for inference ASIC
      habanalabs: modify cpu boot status error print
      habanalabs: fix endianness when reading cpld version
      habanalabs: fix comments according to kernel-doc
      habanalabs: refactor reset information variables
      habanalabs: add a lock to protect multiple reset variables
      habanalabs: support hard-reset scheduling during soft-reset

Ohad Sharabi (11):
      habanalabs: modify wait for boot fit in dynamic FW load
      habanalabs: revise and document use of boot status flags
      habanalabs: adding indication of boot fit loaded
      habanalabs: use variable poll interval for fw loading
      habanalabs: don't clear previous f/w indications
      habanalabs: skip PLL freq fetch
      habanalabs: skip read fw errors if dynamic descriptor invalid
      habanalabs: wait again for multi-CS if no CS completed
      habanalabs: clean MMU headers definitions
      habanalabs: prevent wait if CS in multi-CS list completed
      habanalabs: handle skip multi-CS if handling not done

Rajaravi Krishna Katta (2):
      habanalabs: add dedicated message towards f/w to set power
      habanalabs: Move frequency change thread to goya_late_init

Tomer Tayar (5):
      habanalabs: align debugfs documentation to alphabetical order
      habanalabs: add power information type to POWER_GET packet
      habanalabs: pass reset flags to reset thread
      habanalabs: add missing kernel-doc comments for hl_device fields
      habanalabs: add CPU-CP packet for engine core ASID cfg

Yuri Nudelman (5):
      habanalabs: print va_range in vm node debugfs
      habanalabs: wrong VA size calculation
      habanalabs: make last_mask an MMU property
      habanalabs: add enum mmu_op_flags
      habanalabs: partly skip cache flush when in PMMU map flow

farah kassabri (3):
      habanalabs/gaudi: Fix collective wait bug
      habanalabs: add new opcodes for INFO IOCTL
      habanalabs: change wait_for_interrupt implementation

 .../ABI/testing/debugfs-driver-habanalabs          |  23 +-
 drivers/misc/habanalabs/common/command_buffer.c    |  46 ++-
 .../misc/habanalabs/common/command_submission.c    | 389 +++++++++++++++------
 drivers/misc/habanalabs/common/context.c           |  39 ++-
 drivers/misc/habanalabs/common/debugfs.c           |  97 +++--
 drivers/misc/habanalabs/common/device.c            | 387 ++++++++++----------
 drivers/misc/habanalabs/common/firmware_if.c       | 253 ++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h        | 301 +++++++++++-----
 drivers/misc/habanalabs/common/habanalabs_drv.c    | 150 ++++----
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  | 195 +++++++++--
 drivers/misc/habanalabs/common/hw_queue.c          |   5 +-
 drivers/misc/habanalabs/common/hwmon.c             | 209 +++++++++--
 drivers/misc/habanalabs/common/irq.c               |  14 +-
 drivers/misc/habanalabs/common/memory.c            |  78 +++--
 drivers/misc/habanalabs/common/mmu/mmu.c           |  25 ++
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |  18 +-
 drivers/misc/habanalabs/common/sysfs.c             |  56 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 313 ++++++++++++-----
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   4 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |   4 +-
 drivers/misc/habanalabs/goya/goya.c                | 165 +++++++--
 drivers/misc/habanalabs/goya/goyaP.h               |  14 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |   4 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |  31 +-
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  62 +++-
 .../misc/habanalabs/include/common/hl_boot_if.h    |   4 +
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |  19 +-
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |  18 +-
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h   |  20 +-
 include/uapi/misc/habanalabs.h                     | 166 +++++++--
 30 files changed, 2185 insertions(+), 924 deletions(-)
