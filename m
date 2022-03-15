Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237584D9BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348545AbiCONN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbiCONN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:13:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D855131C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647349960; x=1678885960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8kSTGNt92MPePE6+N6MXdn5ThlvMy6OUBfTyuCuK37s=;
  b=aYo1fpfE3rL2MJRCw1kc0XabEsuwl5kGgeY45nYnNTisyAUp5XucsVNt
   QjXMQBf3son1c3748eaHhj5budcdlFunh5eurMyxNRwkD7ydO8y2lZWUu
   vOio7jLlnDY+kMjSYUnt3NknJ0uEz+gARGPJmk3L+msoQvk9Ed+3blpLG
   /tIH6lOtKIGdnhHZkrVo3lHHtutR1pnfNp9amyoBC++G1Ndu2rN5H362m
   2p7+r7dgI3x/10u2Q8JXM1lXH8GaKgDXpKLA37lmJoxMIAb/YTlL+EShu
   mUXiVpmqOIrVDvdxk1kapiMhLH4FUH9x/9BWLNpg+B2hrqNKaeV8d2MNE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253852988"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="253852988"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:12:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="556919993"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:12:37 -0700
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
Subject: [PATCH v11 0/5] Add driver for GSC controller
Date:   Tue, 15 Mar 2022 15:11:52 +0200
Message-Id: <20220315131157.3972238-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

The prinicpal user of this interface is the
Intel Graphics System Controller Firmware Update Library (IGSC FU)
(https://github.com/intel/igsc)

In v2 the platform device was replaced by the auxiliary device.
v3 is the rebase over drm-tip to make public CI running.
In v4 the not needed debug prints and empty line were removed,
      'select' were replaced by 'depends on' in MEI Kconfig,
      the new include file now listed in the MAINTATINERS file. 
V5, rebase and add Greg KH Reviewed-by
V6, rebase and drop redundant assignments found by the kernel test
robot.
V7, add Greg KH Reviewed-by to the individual patches
V8, address Tvrtko comments for i915
V9, rebase and address more Tvrtko comments, use drm error printing
V10, rebase
V11, address Rodrigo comments about code style,
     set missed mask in the interrupt config,
     add explicit devm_irq_free to error and remove flows

Tomas, please look at the devm_irq_free part.

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
 drivers/gpu/drm/i915/gt/intel_gsc.c      | 204 ++++++++++++++++++
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
 drivers/misc/mei/gsc-me.c                | 259 +++++++++++++++++++++++
 drivers/misc/mei/hw-me.c                 |  29 ++-
 drivers/misc/mei/hw-me.h                 |   2 +
 include/linux/mei_aux.h                  |  19 ++
 21 files changed, 633 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
 create mode 100644 drivers/misc/mei/gsc-me.c
 create mode 100644 include/linux/mei_aux.h

-- 
2.32.0

