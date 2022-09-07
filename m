Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA35B0F76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIGVvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIGVvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:51:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD0111A03
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662587492; x=1694123492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zbCB9QQSadXdZ9hP5LoqtD9fS0+b9caxbiyydbhi+a0=;
  b=b4m67TB4wP4qN2iOqTLbONkOT6Md6iOVgmcohXVVT/exZBiRUMb704DN
   INYyaq65guN+u3dkdZQk2byKgGhdvyTNLKvhRi0/kyIr3kbuI+1MWKfli
   ZUE2zpT4+afpsrQijZxfRMqWyrh/UajN+ujb7lcMkAc72b4/9rmt5AcVJ
   T5JvOfXOq+rKRMhVlGuD4hM276n5hWsIT1KOtYhiTe88QOat3ysPsoJhk
   DdiIiopl+ZLt+ZQPGbT6K+nJl+uwh7W4N8yXbsEt2pr0VY9r7zbp1gtjE
   wRM33iBkjgl2ObW+NLjD4MHNQTxeEuz0/4aM0sfObOEUT3a6gCP2fSSS4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295740253"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295740253"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:51:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="790207815"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:51:28 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
Subject: [PATCH v8 00/16] GSC support for XeHP SDV and DG2
Date:   Thu,  8 Sep 2022 00:50:57 +0300
Message-Id: <20220907215113.1596567-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This patch set should be merged via gfx tree as
the auxiliary device belongs there.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

V2: rebase over merged DG1 series and DG2 enablement patch,
    fix commit messages

V3: rebase over latest tip

V4: add missed changelog in pxp dbugfs patch

V5: rebase over latest tip
    fix changelog in pxp dbugfs patch
    put HAX patch last to the ease of merging
    reorder patches in the series

V6: change prefix from 'drm/i915/gsc:' to 'mei' in patch:
        mei: add slow_fw flag to the mei auxiliary device
    Address following checkpatch warnings:
        CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
        FILE: drivers/misc/mei/mkhi.h:54:
        +	uint32_t flags; 
        
        -:51: CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'cldev->bus->pxp_mode != MEI_DEV_PXP_INIT'
        #51: FILE: drivers/misc/mei/bus-fixup.c:257:
        +	if (!cldev->bus->fw_f_fw_ver_supported &&
        +	    (cldev->bus->pxp_mode != MEI_DEV_PXP_INIT)
    
    Remove some spurious code formatting changes in:
    drm/i915/gsc: allocate extended operational memory in LMEM

V7: Add new patch to add kdoc for mei_aux_device structure.
    Rename slow_fw to slow_firmware flag.
    Use drm_dbg/err() functions instead of dev_dbg/err() in i195
    codebase.

V8:
   1. Update copyright dates
   1. Add kdoc and comments to mei_me_polling_thread()
   2. Fix pgi->d0i3 timeout in mei_me_d0i3_enter_sync()
   3. <linux/types.h> is enough for mkhi header.
   4. drop MCHI_GROUP_ID definition it is not used
   5. Setup default PXP state
   6. Add PXP mode kdoc
   7. Add new patch mei: drop ready bits check after start
V9:
   1. Fix pgi->d0i3 timeout in mei_me_d0i3_exit_sync()
   2. Fix mismatch in the patch "mei: mkhi: add memory ready command"
   3. Use I915_BO_ALLOC_CPU_CLEAR to clear the allocated memory

Alexander Usyskin (5):
  drm/i915/gsc: add slow_firmware flag to the gsc device definition
  drm/i915/gsc: add GSC XeHP SDV platform definition
  mei: gsc: wait for reset thread on stop
  mei: extend timeouts on slow devices
  mei: drop ready bits check after start

Daniele Ceraolo Spurio (1):
  HAX: drm/i915: force INTEL_MEI_GSC on for CI

Tomas Winkler (7):
  mei: add kdoc for struct mei_aux_device
  mei: add slow_firmware flag to the mei auxiliary device
  mei: gsc: use polling instead of interrupts
  mei: mkhi: add memory ready command
  mei: gsc: setup gsc extended operational memory
  mei: debugfs: add pxp mode to devstate in debugfs
  drm/i915/gsc: allocate extended operational memory in LMEM

Vitaly Lubart (3):
  drm/i915/gsc: skip irq initialization if using polling
  mei: bus: export common mkhi definitions into a separate header
  mei: gsc: add transition to PXP mode in resume flow

 drivers/gpu/drm/i915/Kconfig.debug  |   1 +
 drivers/gpu/drm/i915/gt/intel_gsc.c | 106 +++++++++++++++++++--
 drivers/gpu/drm/i915/gt/intel_gsc.h |   3 +
 drivers/misc/mei/bus-fixup.c        | 106 ++++++++++++++-------
 drivers/misc/mei/client.c           |  16 ++--
 drivers/misc/mei/debugfs.c          |  19 +++-
 drivers/misc/mei/gsc-me.c           |  77 ++++++++++++++--
 drivers/misc/mei/hbm.c              |  14 +--
 drivers/misc/mei/hw-me-regs.h       |   9 +-
 drivers/misc/mei/hw-me.c            | 138 ++++++++++++++++++++++++----
 drivers/misc/mei/hw-me.h            |  17 +++-
 drivers/misc/mei/hw-txe.c           |   4 +-
 drivers/misc/mei/hw.h               |   7 +-
 drivers/misc/mei/init.c             |  35 ++++---
 drivers/misc/mei/main.c             |   4 +-
 drivers/misc/mei/mei_dev.h          |  35 ++++++-
 drivers/misc/mei/mkhi.h             |  55 +++++++++++
 drivers/misc/mei/pci-me.c           |   4 +-
 include/linux/mei_aux.h             |  12 +++
 19 files changed, 548 insertions(+), 114 deletions(-)
 create mode 100644 drivers/misc/mei/mkhi.h

-- 
2.37.2

