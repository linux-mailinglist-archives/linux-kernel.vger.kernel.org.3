Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7F4C6E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiB1Nv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiB1Nv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:51:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3207CDF3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:51:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2324613EA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5246DC340E7;
        Mon, 28 Feb 2022 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646056276;
        bh=IETDOddOFXjvnkfs3zJwg2g/A8kTkjziyY9ZwVfPiR8=;
        h=Date:From:To:Cc:Subject:From;
        b=rJ+7Wdx7/88f7zoyt2oo2PO9fKVnYCBT2xPpc5usQaXmtUdPybHVFoGnfdyg437z8
         cRkze12El+fuV56LDO0A2tsOHPT0ZAREAnrAUojL7ip2dA+MUNThfZJVGr+Q8qvBdt
         9f9fFBuz6LSUOofndhuPNszQvefaNgRXIWu7SUdtZsJewn4TbgDukHhdZfeuEalY3N
         y93BQVzssxDUuUDjYrKzi4bELCSz2nQE1dXzMxIGdDMwUn36QBuVsYxK9p0ntYU4GY
         LJC6nD4yuywz3/Oy/nnhNukoupzc0iGDX2kxxOJDgS4uc/ZqgtzXu7c9F+RULeIi6E
         Jfu8O+f5/FSSA==
Date:   Mon, 28 Feb 2022 15:51:11 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.18
Message-ID: <20220228135111.GA1174849@ogabbay-vm-u20.habana-labs.com>
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

This is habanalabs pull request for the merge window of kernel 5.18.
Although it adds small number of features, this pull request mainly
fixes multiple bugs in the code and also does some re-factoring to
better organize the code.

Full details are in the tag.

Thanks,
Oded

The following changes since commit 085686fb8491a7cbf6a7260d5b9d4169a041c340:

  Merge 5.17-rc6 into char-misc-next (2022-02-28 07:30:32 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-02-28

for you to fetch changes up to 655221c56739058ae73a7aabd90847a024dabff6:

  habanalabs: remove deprecated firmware states (2022-02-28 14:34:50 +0200)

----------------------------------------------------------------
This tag contains habanalabs driver changes for v5.18:

- Add new feature of recording time-stamp when a completion
  queue counter reaches a target value as determined by the
  userspace application. This is used by the graph compiler
  to accurately measure the time it takes for certain workloads
  to execute, which helps to fine-tune future compilations.

- Add two new attributes to sysfs that expose the VRM and
  f/w OS version

- Add a delay to the reset path that allows the driver to
  receive and handle additional events from the f/w before
  doing the reset. This can help when debugging why a reset
  event was received from the f/w.

- Re-factor some of the sysfs code in the driver. Mainly,
  move functions from hwmgr.c to more relevant files and
  totally remove hwmgr.c file.

- Fix multiple bugs such as races, use-after-free, ignoring
  error codes, etc.

- As usual, multiple minor changes and small fixes.

----------------------------------------------------------------
Dan Carpenter (1):
      habanalabs: silence an uninitialized variable warning

Dani Liberman (2):
      habanalabs: fix soft reset flow in case of failure
      habanalabs: fix race when waiting on encaps signal

Jiasheng Jiang (1):
      habanalabs: Add check for pci_enable_device

Oded Gabbay (26):
      habanalabs/gaudi: disable CGM permanently
      habanalabs: remove ASIC functions of clock gating
      habanalabs: sysfs functions should be in sysfs.c
      habanalabs: get clk is common function
      habanalabs: remove hwmgr.c
      habanalabs: move more f/w functions to firmware_if.c
      habanalabs: remove asic callback set_pll_profile()
      habanalabs: rename dev_attr_grp to dev_clk_attr_grp
      habanalabs: add vrm version to sysfs
      habanalabs: remove power9 workaround for dma support
      habanalabs: use common wrapper for MMU cache invalidation
      habanalabs: there is no kernel TDR in future ASICs
      habanalabs: don't free phys_pg_pack inside lock
      habanalabs: update to latest f/w specs
      habanalabs: expose number of user interrupts
      habanalabs: reject host map with mmu disabled
      habanalabs: fix user interrupt wait when timeout is 0
      habanalabs: fix race between wait and irq
      habanalabs: remove duplicate print
      habanalabs: fix spelling mistake
      habanalabs: rephrase error messages in PCI initialization
      habanalabs: fix use-after-free bug
      habanalabs: add missing include of vmalloc.h
      habanalabs: change function to static
      habanalabs/gaudi: handle axi errors from NIC engines
      habanalabs/gaudi: add missing handling of NIC related events

Ofir Bitton (1):
      habanalabs: remove deprecated firmware states

Ohad Sharabi (6):
      habanalabs: fix possible memory leak in MMU DR fini
      habanalabs: make some MMU functions common
      habanalabs: duplicate HOP table props to MMU props
      habanalabs: use kernel-doc for memory ioctl documentation
      habanalabs: allow user to set allocation page size
      habanalabs: make sure device mem alloc is page aligned

Rajaravi Krishna Katta (1):
      habanalabs: sysfs support for fw os version

Tomer Tayar (10):
      habanalabs: check the return value of hl_cs_poll_fences()
      habanalabs: avoid copying pll data if pll_info_get fails
      habanalabs: add missing error check in sysfs clk_freq_mhz_show
      habanalabs: add missing error check in sysfs max_power_show
      habanalabs: prevent false heartbeat failure during soft-reset
      habanalabs: enable stop-on-error debugfs setting per ASIC
      habanalabs: use proper max_power variable for device utilization
      habanalabs: set max power on device init per ASIC
      habanalabs: avoid using an uninitialized variable
      habanalabs: add an option to delay a device reset

farah kassabri (2):
      habanalabs: Timestamps buffers registration
      habanalabs: Fix reset upon device release bug

 .../ABI/testing/debugfs-driver-habanalabs          |  20 +-
 Documentation/ABI/testing/sysfs-driver-habanalabs  |  16 +-
 drivers/misc/habanalabs/common/Makefile            |   2 +-
 drivers/misc/habanalabs/common/command_buffer.c    |   4 +-
 .../misc/habanalabs/common/command_submission.c    | 265 +++++++++---
 drivers/misc/habanalabs/common/debugfs.c           |  40 +-
 drivers/misc/habanalabs/common/device.c            |  53 ++-
 drivers/misc/habanalabs/common/firmware_if.c       | 152 ++++++-
 drivers/misc/habanalabs/common/habanalabs.h        | 209 +++++++---
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   3 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |  13 +-
 drivers/misc/habanalabs/common/hwmgr.c             | 117 ------
 drivers/misc/habanalabs/common/irq.c               | 127 +++++-
 drivers/misc/habanalabs/common/memory.c            | 360 ++++++++++++++--
 drivers/misc/habanalabs/common/mmu/mmu.c           |  55 +++
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |  47 +--
 drivers/misc/habanalabs/common/pci/pci.c           |   9 +-
 drivers/misc/habanalabs/common/sysfs.c             | 176 ++++----
 drivers/misc/habanalabs/gaudi/gaudi.c              | 462 +++++++--------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   8 +-
 drivers/misc/habanalabs/goya/goya.c                |  45 +-
 drivers/misc/habanalabs/goya/goyaP.h               |   6 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |  67 +--
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   2 +
 .../misc/habanalabs/include/common/hl_boot_if.h    |   5 +
 .../habanalabs/include/gaudi/gaudi_async_events.h  |  10 +
 include/uapi/misc/habanalabs.h                     | 146 ++++---
 27 files changed, 1504 insertions(+), 915 deletions(-)
 delete mode 100644 drivers/misc/habanalabs/common/hwmgr.c
