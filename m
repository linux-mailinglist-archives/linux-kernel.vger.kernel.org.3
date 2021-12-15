Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF99475A12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbhLON5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:57:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:35784 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243052AbhLON5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639576655; x=1671112655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sYQZOcYKkLCf4U93VwrcF6eIEI2TqWRtbMABg3VriLQ=;
  b=mo05Ozn62kFepVUrDLxz2yMG3C3rhkk8bpUFj+nJJDxGcgK1Fi8kZc2d
   at+a4NLigCtDj98HLqcz/PDzVGzYd6OhU5AEojXQz4fETf8bEiDO9sF7N
   lXwoiQILdTzJ/yk0WXALm/O4CPbOwH+s1dXCq2rQK3SuSeFTpDPcIZUeC
   lZq6cgzFyI2JTOGcnlkMeg3FXmJGAcQGwldI2HQ9Xm41pdhZYmRUppFJe
   dLi6B+8jXDDNoONNeQ1RhCvs2hr/oa7qxWQ7GlJFtb/xI/YmxGIbVThsH
   AWmqVFnO8MusnJR7y1Wux2qUKMXLAGTp+oYXC2nenlZBAc1s5FmEEtRY7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226511423"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226511423"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="682502711"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:31 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add driver for GSC controller
Date:   Wed, 15 Dec 2021 15:56:17 +0200
Message-Id: <20211215135622.1060229-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSC is a graphics system controller, based on CSE, it provides
a chassis controller for graphics discrete cards, as well as it
supports media protection (HDCP 2.2) on selected devices.

There are two MEI interfaces in GSC: HECI1, the one that provides media
protection and HECI2 the one that provides firmware interface.

This series includes instantiation of the platform devices for HECIs
and mei-gsc platform device driver that binds to the platform device.

Greg KH, please review and ACK the MEI patches.
We are pushing all through gfx tree as the platform device belongs there.

Alexander Usyskin (2):
  mei: gsc: setup char driver alive in spite of firmware handshake
    failure
  mei: gsc: retrieve the firmware version

Tomas Winkler (3):
  drm/i915/gsc: add gsc as a mei platform device
  mei: add gsc driver
  mei: gsc: add runtime pm handlers

 drivers/gpu/drm/i915/Kconfig             |   1 +
 drivers/gpu/drm/i915/Makefile            |   3 +
 drivers/gpu/drm/i915/gt/intel_gsc.c      | 156 ++++++++++++
 drivers/gpu/drm/i915/gt/intel_gsc.h      |  35 +++
 drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
 drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  14 ++
 drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
 drivers/gpu/drm/i915/i915_driver.c       |  10 +
 drivers/gpu/drm/i915/i915_drv.h          |   8 +
 drivers/gpu/drm/i915/i915_pci.c          |   3 +-
 drivers/gpu/drm/i915/i915_reg.h          |   3 +
 drivers/gpu/drm/i915/intel_device_info.h |   2 +
 drivers/misc/mei/Kconfig                 |  12 +
 drivers/misc/mei/Makefile                |   3 +
 drivers/misc/mei/bus-fixup.c             |  25 ++
 drivers/misc/mei/gsc-me.c                | 293 +++++++++++++++++++++++
 drivers/misc/mei/hw-me.c                 |  29 ++-
 drivers/misc/mei/hw-me.h                 |   2 +
 19 files changed, 606 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
 create mode 100644 drivers/misc/mei/gsc-me.c

-- 
2.32.0

