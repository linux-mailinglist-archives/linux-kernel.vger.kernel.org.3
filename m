Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890854B3AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiBMKci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:32:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiBMKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:32:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82735D197
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644748352; x=1676284352;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qsj3cN0svAa5+INjWCMJ8VFAtqlZqT7rv64xhdOQ0QM=;
  b=a78VohSqeyDMPpF20Onl6F2Mytif6WTE3lHkeyNMojCI9vDBZJ6XBgjr
   aWVbU4MB3Y2mC0nm1iewQEavzWYkOUoc3iZ+lhmLRUsgY/ahQA9DMzs4K
   dC58sdfax2Ox8gqZLUeYIwxTuEVfz1492TflAhXoddbTI5qOGM8exPxFf
   B8RS+LJw5oH6Vkd1MQMPFdP/WbfEh26vDGimRn/OyRKy3ccIJXlzclD0G
   GUCgkA5JPWeog744+akTIPH3iz+NjcndAcEnUZWhuAyjgb49AKPFqpFe2
   A+6qtLCz30ghJw0AN8COTVIYbpTCwtjxMzNgEUa8lkjOCSCviG0OdsGuJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="247532536"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="247532536"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 02:32:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="527474240"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 02:32:29 -0800
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
Subject: [PATCH v7 0/5] Add driver for GSC controller
Date:   Sun, 13 Feb 2022 12:32:10 +0200
Message-Id: <20220213103215.2440248-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSC is a graphics system controller, it provides
a chassis controller for graphics discrete cards.

There are two MEI interfaces in GSC: HECI1 and HECI2.

This series includes instantiation of the auxiliary devices for HECI2
and mei-gsc auxiliary device driver that binds to the auxiliary device.

In v2 the platform device was replaced by the auxiliary device.
v3 is the rebase over drm-tip to make public CI running.
In v4 the not needed debug prints and empty line were removed,
      'select' were replaced by 'depends on' in MEI Kconfig,
      the new include file now listed in the MAINTATINERS file. 
V5, rebase and add Greg KH Reviewed-by
V6, rebase and drop redundant assignments found by the kernel test robot.
V7, add Greg KH Reviewed-by to the individual patches

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Alexander Usyskin (2):
  mei: gsc: setup char driver alive in spite of firmware handshake
    failure
  mei: gsc: retrieve the firmware version

Tomas Winkler (3):
  drm/i915/gsc: add gsc as a mei auxiliary device
  mei: add support for graphics system controller (gsc) devices
  mei: gsc: add runtime pm handlers

 MAINTAINERS                              |   1 +
 drivers/gpu/drm/i915/Kconfig             |   1 +
 drivers/gpu/drm/i915/Makefile            |   3 +
 drivers/gpu/drm/i915/gt/intel_gsc.c      | 196 ++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gsc.h      |  37 ++++
 drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
 drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  13 ++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h  |   1 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
 drivers/gpu/drm/i915/i915_drv.h          |   8 +
 drivers/gpu/drm/i915/i915_pci.c          |   3 +-
 drivers/gpu/drm/i915/i915_reg.h          |   2 +
 drivers/gpu/drm/i915/intel_device_info.h |   2 +
 drivers/misc/mei/Kconfig                 |  14 ++
 drivers/misc/mei/Makefile                |   3 +
 drivers/misc/mei/bus-fixup.c             |  25 +++
 drivers/misc/mei/gsc-me.c                | 252 +++++++++++++++++++++++
 drivers/misc/mei/hw-me.c                 |  29 ++-
 drivers/misc/mei/hw-me.h                 |   2 +
 include/linux/mei_aux.h                  |  19 ++
 21 files changed, 618 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
 create mode 100644 drivers/misc/mei/gsc-me.c
 create mode 100644 include/linux/mei_aux.h

-- 
2.32.0

