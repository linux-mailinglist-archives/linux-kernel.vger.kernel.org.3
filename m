Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97FB493DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356003AbiASP6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:58:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:54069 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355867AbiASP6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642607911; x=1674143911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cDRiiEMae0y01/dfGR7VUKUBvn+ql8+R1oS404YU00U=;
  b=WQ0gdNKySJg0+Twiat30ew/F/3W+sYckX6XBuguOflEBSZ3HmaoVwsWg
   5TLDlOOojMFp6cV+Am22SXpA82hzTee3tKtuQtXPn79tyEk8u0EsxqcZv
   srEqMi+YPElgj8AVKIRi0DwT9zQOohTeomo8GpJimlpMMB2Us5or1WRIJ
   7kl8St43Jo0NGZANiO/JqZhqewc6wryhCVPgA7zGyEqTLsu6qlELyF0ae
   sweHxmkA9BP1iHQeGN/VtJUHfIk66cBp4bjr7sRenXiMaRiWijV1w4BA4
   7WIKMgN9+Xwx2An2jeUruoLDcIZLxiHm7qC/g9u8/bJa2l3ceSPm782UG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="245294812"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="245294812"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:58:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="477420115"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:58:26 -0800
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
Subject: [PATCH v2 0/5] Add driver for GSC controller
Date:   Wed, 19 Jan 2022 17:58:02 +0200
Message-Id: <20220119155807.222657-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSC is a graphics system controller, it provides
a chassis controller for graphics discrete cards.

There are two MEI interfaces in GSC: HECI1 and HECI2.

This series includes instantiation of the auxiliary devices for HECI2
and mei-gsc auxiliary device driver that binds to the auxiliary device.

In v2 the platform device was replaced by the auxiliary device.

Greg KH, please review and ACK the MEI patches.
We are pushing all through gfx tree as the auxiliary device belongs there.

Alexander Usyskin (2):
  mei: gsc: setup char driver alive in spite of firmware handshake
    failure
  mei: gsc: retrieve the firmware version

Tomas Winkler (3):
  drm/i915/gsc: add gsc as a mei auxiliary device
  mei: add support for graphics system controller (gsc) devices
  mei: gsc: add runtime pm handlers

 drivers/gpu/drm/i915/Kconfig             |   1 +
 drivers/gpu/drm/i915/Makefile            |   3 +
 drivers/gpu/drm/i915/gt/intel_gsc.c      | 200 +++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gsc.h      |  37 ++++
 drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
 drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  13 ++
 drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
 drivers/gpu/drm/i915/i915_drv.h          |   8 +
 drivers/gpu/drm/i915/i915_pci.c          |   3 +-
 drivers/gpu/drm/i915/i915_reg.h          |   3 +
 drivers/gpu/drm/i915/intel_device_info.h |   2 +
 drivers/misc/mei/Kconfig                 |  14 ++
 drivers/misc/mei/Makefile                |   3 +
 drivers/misc/mei/bus-fixup.c             |  25 +++
 drivers/misc/mei/gsc-me.c                | 271 +++++++++++++++++++++++
 drivers/misc/mei/hw-me.c                 |  29 ++-
 drivers/misc/mei/hw-me.h                 |   2 +
 include/linux/mei_aux.h                  |  19 ++
 19 files changed, 640 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
 create mode 100644 drivers/misc/mei/gsc-me.c
 create mode 100644 include/linux/mei_aux.h

-- 
2.32.0

