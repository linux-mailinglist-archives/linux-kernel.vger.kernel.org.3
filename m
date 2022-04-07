Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218544F7FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245596AbiDGNBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiDGNBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:01:09 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B3D15F55C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649336348; x=1680872348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fVflh9163ARtWVSbkYTnkp1tPSrgpN3ELr+z5BL6/Qc=;
  b=QfyK86zKkAHitQn3Ej9x8XzvMIBUoee32hSRfaHD+FLjjIpYt7Dxyh/V
   8sK8YqmhNdgtXh57Qk/CpYfiNrhYqCEhzmAeekaBdOvVbbtOiqIbgWNHe
   sh2moDyHpL8wT6kBcZFD9MDk3FQxZu/NMHJ734KhWnxFPBSVxJk0k1lTI
   GdSE+roh+JQAaaoR1ZsjqHzXWNhL8MbS/ZftA1iLpuTis5gef6Sg4APcE
   FpZQe1LfRlin6hx/1qxpdbwow0yc+Ag6Oik3gX9bcfK0IrglAcEb1DDO5
   FQIU8O7jopqA7zSjW3dAa/wL8skZYFDXV1ZP9Rj/gzWVx3MUO+nVTHHFH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="322006006"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="322006006"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 05:59:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571040707"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 05:59:04 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/20] GSC support for XeHP SDV and DG2 platforms
Date:   Thu,  7 Apr 2022 15:58:19 +0300
Message-Id: <20220407125839.1479249-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GSC support for XeHP SDV and DG2 platforms.

The series includes changes for the mei driver:
- add ability to use polling instead of interrupts
- add ability to use extended timeouts
- setup extended operational memory for GSC

The series includes changes for the i915 driver:
- allocate extended operational memory for GSC
- GSC on XeHP SDV offsets and definitions
- GSC on DG2 offsets and definitions

The first six patches of the series are copied from the
already reviewed series [1] to provide series that
can be built in CI.
This series will be rebased and merged only after
series [1] merge.

Greg KH, please review and ACK the MEI patches.
We are pushing these patches through gfx tree as
the auxiliary device belongs there.

[1] https://patchwork.freedesktop.org/series/102160/

Alexander Usyskin (7):
  mei: gsc: setup char driver alive in spite of firmware handshake
    failure
  mei: gsc: retrieve the firmware version
  drm/i915/gsc: add slow_fw flag to the mei auxiliary device
  drm/i915/gsc: add slow_fw flag to the gsc device definition
  drm/i915/gsc: add GSC XeHP SDV platform definition
  mei: gsc: wait for reset thread on stop
  mei: extend timeouts on slow devices.

Daniele Ceraolo Spurio (1):
  HAX: drm/i915: force INTEL_MEI_GSC on for CI

Tomas Winkler (9):
  drm/i915/gsc: add gsc as a mei auxiliary device
  mei: add support for graphics system controller (gsc) devices
  mei: gsc: add runtime pm handlers
  mei: gsc: use polling instead of interrupts
  drm/i915/dg2: add gsc with special gsc bar offsets
  mei: mkhi: add memory ready command
  mei: gsc: setup gsc extended operational memory
  mei: debugfs: add pxp mode to devstate in debugfs
  drm/i915/gsc: allocate extended operational memory in LMEM

Vitaly Lubart (3):
  drm/i915/gsc: skip irq initialization if using polling
  mei: bus: export common mkhi definitions into a separate header
  mei: gsc: add transition to PXP mode in resume flow

 MAINTAINERS                              |   1 +
 drivers/gpu/drm/i915/Kconfig             |   1 +
 drivers/gpu/drm/i915/Kconfig.debug       |   1 +
 drivers/gpu/drm/i915/Makefile            |   3 +
 drivers/gpu/drm/i915/gt/intel_gsc.c      | 323 +++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gsc.h      |  40 +++
 drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
 drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  13 +
 drivers/gpu/drm/i915/gt/intel_gt_regs.h  |   1 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
 drivers/gpu/drm/i915/i915_drv.h          |   8 +
 drivers/gpu/drm/i915/i915_pci.c          |   4 +-
 drivers/gpu/drm/i915/i915_reg.h          |   4 +
 drivers/gpu/drm/i915/intel_device_info.h |   2 +
 drivers/misc/mei/Kconfig                 |  14 +
 drivers/misc/mei/Makefile                |   3 +
 drivers/misc/mei/bus-fixup.c             | 128 ++++++---
 drivers/misc/mei/client.c                |  14 +-
 drivers/misc/mei/debugfs.c               |  17 ++
 drivers/misc/mei/gsc-me.c                | 316 ++++++++++++++++++++++
 drivers/misc/mei/hbm.c                   |  12 +-
 drivers/misc/mei/hw-me-regs.h            |   7 +
 drivers/misc/mei/hw-me.c                 | 145 ++++++++--
 drivers/misc/mei/hw-me.h                 |  16 +-
 drivers/misc/mei/hw-txe.c                |   2 +-
 drivers/misc/mei/hw.h                    |   5 +
 drivers/misc/mei/init.c                  |  21 +-
 drivers/misc/mei/main.c                  |   2 +-
 drivers/misc/mei/mei_dev.h               |  26 ++
 drivers/misc/mei/mkhi.h                  |  57 ++++
 drivers/misc/mei/pci-me.c                |   2 +-
 include/linux/mei_aux.h                  |  21 ++
 33 files changed, 1146 insertions(+), 73 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
 create mode 100644 drivers/misc/mei/gsc-me.c
 create mode 100644 drivers/misc/mei/mkhi.h
 create mode 100644 include/linux/mei_aux.h

-- 
2.32.0

