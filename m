Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3350DA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiDYHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbiDYHwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:52:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182E1132
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650872953; x=1682408953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u/0y+kT6n9vRZXbAePDZZlJPYaTLFDcrNVexDRBHbmc=;
  b=cRkTfFjmCVB68KmS3TslBrl8g+l1awFynBlr/AvMne228IE8wBnhWPeu
   T9ZiNcv49R9hFziMf1oOKwK57PAxRiFC+eVKDSOaSKWHKwcQsZnwG00fe
   Qo6v0dTBoDYAotMI8yS7wDsmcw3eFGks+gdU5SUOZeG14v1xGJe1NrjIx
   sXBww6WKNRAsM5+ReSd2x2Uwbww8fDnoO91npnvs3NRtLi1QEn88DdUdR
   MyXULLQ0Rtc2YdNa3heRChjl61BS/e6BNKhdrNfKf9AL+7o6//Zl+Mz1H
   T70BbiAYpQocq77+Vl7vGMWW6czqlWbCzW5s7JVzznpuc8YwpWAiDwLOQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264973619"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264973619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557599860"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:49:09 -0700
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
Subject: [PATCH v2 00/14] GSC support for XeHP SDV and DG2 platforms 
Date:   Mon, 25 Apr 2022 10:48:47 +0300
Message-Id: <20220425074901.3991274-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
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

Add GSC support for XeHP SDV and DG2 platforms.

The series includes changes for the mei driver:
- add ability to use polling instead of interrupts
- add ability to use extended timeouts
- setup extended operational memory for GSC

The series includes changes for the i915 driver:
- allocate extended operational memory for GSC
- GSC on XeHP SDV offsets and definitions

Greg KH, please review and ACK the MEI patches.
We are pushing these patches through gfx tree as
the auxiliary device belongs there.

V2: rebase over merged DG1 series and DG2 enablement patch,
    fix commit messages

Alexander Usyskin (5):
  drm/i915/gsc: add slow_fw flag to the mei auxiliary device
  drm/i915/gsc: add slow_fw flag to the gsc device definition
  drm/i915/gsc: add GSC XeHP SDV platform definition
  mei: gsc: wait for reset thread on stop
  mei: extend timeouts on slow devices.

Daniele Ceraolo Spurio (1):
  HAX: drm/i915: force INTEL_MEI_GSC on for CI

Tomas Winkler (5):
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
 drivers/gpu/drm/i915/gt/intel_gsc.c | 119 +++++++++++++++++++++++++---
 drivers/gpu/drm/i915/gt/intel_gsc.h |   3 +
 drivers/misc/mei/bus-fixup.c        | 105 ++++++++++++++++--------
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
 drivers/misc/mei/mkhi.h             |  57 +++++++++++++
 drivers/misc/mei/pci-me.c           |   2 +-
 include/linux/mei_aux.h             |   2 +
 19 files changed, 511 insertions(+), 91 deletions(-)
 create mode 100644 drivers/misc/mei/mkhi.h

-- 
2.32.0

