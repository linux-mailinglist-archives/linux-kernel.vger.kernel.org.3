Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3AA58B56D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiHFM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiHFM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:27:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F17C11143
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659788833; x=1691324833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kggDSyps8TO2AFz5L6p7Om5TDm4C37TCEL5uj7zwCpE=;
  b=Ys7xJe1VM9g1p4FkoJynyXsacnPsRlhK5Gj+Cw493LHQEihBW6GKI5qh
   7ENZCePb2mI3W43B34aesVIE4x2MnOSwqdIr1ikD62IYa1TqLNCdcbcqs
   AAqVlGuG//u29e8h4viXeBwWp530UXl4ZJvrxLI1E7HfpyWbqmwGJaekU
   cudXsSriGwHbRB4wPWFCpDqvr5NKIFK03MeOm7dkx66zHvG/Kp/QflL1J
   XKSHOp+CQiGh0S82xU3cjeEFfLuOWojdd803SpmiA8UBNkj0oHMYdeKRB
   sV+7w/bjiQezUj9bD1TxdcTdkpfhMRUGAMnhM4CZ5tdEoFFI/LF7+b/MN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289121860"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="289121860"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="632329018"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 05:27:09 -0700
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
Subject: [PATCH v7 00/15] GSC support for XeHP SDV and DG2
Date:   Sat,  6 Aug 2022 15:26:21 +0300
Message-Id: <20220806122636.43068-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Greg, your ACK is required for the drives/misc/mei code base,
please review the patches.


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


Alexander Usyskin (4):
  drm/i915/gsc: add slow_firmware flag to the gsc device definition
  drm/i915/gsc: add GSC XeHP SDV platform definition
  mei: gsc: wait for reset thread on stop
  mei: extend timeouts on slow devices.

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
 drivers/gpu/drm/i915/gt/intel_gsc.c | 118 +++++++++++++++++++++++++---
 drivers/gpu/drm/i915/gt/intel_gsc.h |   3 +
 drivers/misc/mei/bus-fixup.c        | 104 ++++++++++++++++--------
 drivers/misc/mei/client.c           |  14 ++--
 drivers/misc/mei/debugfs.c          |  17 ++++
 drivers/misc/mei/gsc-me.c           |  77 +++++++++++++++---
 drivers/misc/mei/hbm.c              |  12 +--
 drivers/misc/mei/hw-me-regs.h       |   7 ++
 drivers/misc/mei/hw-me.c            | 116 ++++++++++++++++++++++-----
 drivers/misc/mei/hw-me.h            |  14 +++-
 drivers/misc/mei/hw-txe.c           |   2 +-
 drivers/misc/mei/hw.h               |   5 ++
 drivers/misc/mei/init.c             |  21 ++++-
 drivers/misc/mei/main.c             |   2 +-
 drivers/misc/mei/mei_dev.h          |  26 ++++++
 drivers/misc/mei/mkhi.h             |  57 ++++++++++++++
 drivers/misc/mei/pci-me.c           |   2 +-
 include/linux/mei_aux.h             |  12 +++
 19 files changed, 519 insertions(+), 91 deletions(-)
 create mode 100644 drivers/misc/mei/mkhi.h

-- 
2.37.1

