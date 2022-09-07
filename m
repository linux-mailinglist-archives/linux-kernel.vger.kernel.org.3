Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA65B095E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIGP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiIGP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:59:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3AA8A7D9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662566353; x=1694102353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xxygWsm5AUUOaRGbBHQWjvhLG2/0eVCA9vCpC6pnZEQ=;
  b=YW9Udfw9HRcQXbGsTlagFBx11FLjwB9l3SqQXDuQk2ydm2/DNr1UXLdA
   yrP/okQ2ixmx3ntG8TWePM3wACEBjZ3HgkCk48dEfXkt9Ajvi4PjkjZ3d
   BpoXC0yjQJDjIRn9mTCNuHIY4YNE0bnv9MCvt0UMDm7jSv0Uhn97wMEU1
   9B4OyTzRFjN/0KRy/ZeK/04wWNm4Ll9M8fWTcIy/rMAhyh5hL/3R/A2Mu
   JvYBka7F+XZpCmzqXPUNsYIgghLpUpJzlplDulzZWokdj5j4rVJmqgu25
   611hzuTAmqNMPrFCDvirkAt5r36kq3vzedqq9kPfG4YEBBcRXyeGAKqTU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="294501370"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="294501370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:58:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676247450"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 08:58:36 -0700
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
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v8 00/16] GSC support for XeHP SDV and DG2
Date:   Wed,  7 Sep 2022 18:57:57 +0300
Message-Id: <20220907155813.1427526-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>


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


Alexander Usyskin (5):
  drm/i915/gsc: add slow_firmware flag to the gsc device definition
  drm/i915/gsc: add GSC XeHP SDV platform definition
  mei: gsc: wait for reset thread on stop
  mei: extend timeouts on slow devices.
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
 drivers/gpu/drm/i915/gt/intel_gsc.c | 118 ++++++++++++++++++++++--
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
 drivers/misc/mei/mkhi.h             |  69 ++++++++++++++
 drivers/misc/mei/pci-me.c           |   4 +-
 include/linux/mei_aux.h             |  12 +++
 19 files changed, 574 insertions(+), 114 deletions(-)
 create mode 100644 drivers/misc/mei/mkhi.h

-- 
2.37.2

