Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139852FC41
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiEULxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiEULxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:53:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E4606E5
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 04:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BB0AB81706
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10437C385A9;
        Sat, 21 May 2022 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653134010;
        bh=Nuha3hJoHlLCjB7VUgxtbrEtLUTdFgw7Zdxa2enI9Pc=;
        h=Date:From:To:Cc:Subject:From;
        b=qCUIPTNKpp4WJe5GfTfjOkC+uyM3igbLnSdwhbCPsjCfaSUub7/YgEWHdBrdsgYQN
         9etzGFPcEIrt9ksfW+uuLV6sZIXrAuocpMFCwCRAKX0gopFxugkf+4ESsnXzS2D8Ag
         kdEOrgayBSvP7ybebMWqHX9YGzGmymFXCFpEIGD5webQD3MIMm2lhQckmD/3qpDpW/
         ixUPr3ClR0ZfL2GfnP+fzjbCEnly5X5Zx93BcZJEW2agK4exODVbX9h+avuWuQoSj/
         K4iZAbHGL+zIwTUSY0VdxMk2GXy+s96clD6SCt9o6B1ucZ6rywAUSpOtFGFr6wWbCl
         chTQXLrVo4m8g==
Date:   Sat, 21 May 2022 14:53:25 +0300
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.19
Message-ID: <20220521115325.GA1965670@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is habanalabs pull request for the merge window of kernel 5.19.
We added a few minor features, such as support eventfd registration
for device events, and the ability to scrub the device memory
through debugfs. 

We did some refactoring such as adding a centralized memory
manager inside the driver for allocating mmapable memory and tracking
it, so we can remove different code paths that basically duplicated
that functionality.

And, as usual, there are multiple bug fixes.

Full details are in the tag.

Thanks,
Oded

The following changes since commit cafada1fe932ce761d6c0bc1d56967e27abe4cff:

  Revert "speakup: Generate speakupmap.h automatically" (2022-05-20 21:07:05 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-05-21

for you to fetch changes up to 93f742b13260b070a695f44d6b6ff696cb5cbcd8:

  habanalabs: use separate structure info for each error collect data (2022-05-21 14:42:17 +0300)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.19:

- Add memory manager that can be used by various features in the driver.
  The memory manager provides common framework to allocate memory and track
  its usage, export its handle to the userspace and support mmaping it.

- Add debugfs entry to scrub device memory.

- Add support for doing prefetch when adding new entries to MMU pgt.

- Add support for notifying userspace on device events through eventfd.
  Until now, events were only printed to dmesg. This change will allow
  the user application to register on events and perform specific
  actions per events.

- Refactor kernel log messages to reduce spamming of log

- Unify debugfs code for accessing device's memory/registers. This is
  necessary as the number of supported ASICs grow and the code is
  mostly the same between all ASICs.

- Allow userspace to inquire id device is currently acquired by a user.

- Support different page sizes for device memory's MMU and allow user to
  choose which page size to use.

- Fix multiple bugs such as race in device fini, wrong kapi used to
  acquire pid, too small timeouts, losing information after device
  reset, returning correct error codes and more.

----------------------------------------------------------------
Dafna Hirschfeld (6):
      habanalabs/gaudi: Use correct sram size macro for debugfs
      habanalabs: add callback and field to be used for debugfs refactor
      habanalabs: unify code for memory access from debugfs
      habanalabs: enforce alignment upon registers access through debugfs
      habanalabs: remove debugfs read/write callbacks
      habanalabs: add device memory scrub ability through debugfs

Dani Liberman (2):
      habanalabs: use get_task_pid() to take PID
      habanalabs: handle race in driver fini

Jakob Koschel (1):
      habanalabs: replace usage of found with dedicated list iterator variable

Moti Haimovski (1):
      habanalabs: support debugfs Byte access to device DRAM

Oded Gabbay (7):
      habanalabs: remove redundant info print
      habanalabs: change a reset print to debug level
      habanalabs: don't print normal reset operations
      habanalabs: remove user interrupt debug print
      habanalabs: update firmware header
      habanalabs: use NULL for eventfd
      habanalabs: return -EFAULT on copy_to_user error

Ofir Bitton (6):
      habanalabs: add new return code to device fd open
      habanalabs: expose compute ctx status through info ioctl
      habanalabs/gaudi: increase submission resources
      habanalabs: parse full firmware versions
      habanalabs: save f/w preboot major version
      habanalabs/gaudi: set arbitration timeout to a high value

Ohad Sharabi (13):
      habanalabs: set non-0 value in dram default page size
      habanalabs: add DRAM default page size to HW info
      habanalabs: change mmu_get_real_page_size to be ASIC-specific
      habanalabs: convert all MMU masks/shifts to arrays
      habanalabs: add user API to get valid DRAM page sizes
      habanalabs: add MMU prefetch to ASIC-specific code
      habanalabs: rephrase device out-of-memory message
      habanalabs/gaudi: add debugfs to fetch internal sync status
      habanalabs: refactor HOP functions in MMU V1
      habanalabs: use for_each_sgtable_dma_sg for dma sgt
      habanalabs: add prefetch flag to the MAP operation
      habanalabs: do MMU prefetch as deferred work
      habanalabs: remove hdev from hl_ctx_get args

Rajaravi Krishna Katta (2):
      habanalabs: fix comments according to kernel-doc
      habanalabs/gaudi: use lower_32_bits() for casting

Robin Murphy (1):
      habanalabs: Stop using iommu_present()

Tal Cohen (2):
      habanalabs: add support for notification via eventfd
      habanalabs: use separate structure info for each error collect data

Tomer Tayar (2):
      habanalabs/gaudi: avoid resetting max power in hard reset
      habanalabs: modify dma_mask to be ASIC specific property

Yuri Nudelman (10):
      habanalabs: unified memory manager infrastructure
      habanalabs: convert ts to use unified memory manager
      habanalabs: wrong handle removal in memory manager
      habanalabs: hide memory manager page shift
      habanalabs: add put by handle method to memory manager
      habanalabs: unified memory manager new code for CB flow
      habanalabs: use unified memory manager for CB flow
      habanalabs: add topic to memory manager buffer
      habanalabs: order memory manager messages
      habanalabs: fix missing handle shift during mmap

farah kassabri (1):
      habanalabs: Add separate poll interval value for protocol

kernel test robot (1):
      habanalabs: hl_ts_behavior can be static

 .../ABI/testing/debugfs-driver-habanalabs          |  38 ++
 drivers/misc/habanalabs/common/Makefile            |   2 +-
 drivers/misc/habanalabs/common/command_buffer.c    | 413 +++++++-------------
 .../misc/habanalabs/common/command_submission.c    |  89 +++--
 drivers/misc/habanalabs/common/context.c           |   4 +-
 drivers/misc/habanalabs/common/debugfs.c           | 304 +++++++++++----
 drivers/misc/habanalabs/common/device.c            | 280 +++++++++++++-
 drivers/misc/habanalabs/common/firmware_if.c       |  86 ++++-
 drivers/misc/habanalabs/common/habanalabs.h        | 415 +++++++++++++--------
 drivers/misc/habanalabs/common/habanalabs_drv.c    |  44 ++-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  | 108 +++++-
 drivers/misc/habanalabs/common/irq.c               |  14 +-
 drivers/misc/habanalabs/common/memory.c            | 289 ++++----------
 drivers/misc/habanalabs/common/memory_mgr.c        | 349 +++++++++++++++++
 drivers/misc/habanalabs/common/mmu/mmu.c           | 296 ++++++++-------
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        | 297 +++++----------
 drivers/misc/habanalabs/common/pci/pci.c           |  10 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 412 ++++++--------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   4 +-
 drivers/misc/habanalabs/goya/goya.c                | 363 +++---------------
 drivers/misc/habanalabs/include/common/cpucp_if.h  |  70 +++-
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |  10 +
 include/uapi/misc/habanalabs.h                     |  87 +++--
 23 files changed, 2158 insertions(+), 1826 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/memory_mgr.c
