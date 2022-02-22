Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D94BF694
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiBVKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiBVKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:49:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EDDD5556
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645526956; x=1677062956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YpzkHInk1JdMvGDlbPDx+MfCePhgDZ7p6g/YywoiwfQ=;
  b=n+F0hUZWWZd3doAGeX5+YnxCGHpI/ItCFzsdR3eBHntw5QcVfGzpL0Bs
   mXiBTdVjZvKTPjgqzNNuYc+totqyQc6jxqNEFn1Y1C+Bn4bkLkqUunrtO
   jjXGt0hl3IbTE/x2Un93aBK23nI0DJHWVBhzHMLt+lQrgDqHssdIhY/4G
   6blWDsdzz1g/h8MPXbjo1hFzYt3kQYtjo9D6kImTZRj8VjtZVKWBiKuej
   ljzIr/Kd8MKPYaGTLwMAegm1ei7hvrDG0Set6gbDTEpoUps+0gJOeROww
   dKCuUs3oiEffKR5Zo29ZSgfawSwAs9XZGQfok9xHj5yf2x3fEWPlJNKFX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232288526"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="232288526"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 02:49:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="706569520"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 02:49:13 -0800
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
Subject: [PATCH 0/7] add support for GSC in XeHP SDV platform
Date:   Tue, 22 Feb 2022 12:48:47 +0200
Message-Id: <20220222104854.3188643-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
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

Add support for GSC in XeHP SDV (Intel(R) dGPU without display).
 
XeHP SDV GSC controller uses the same hardware settings as DG1, but uses
polling instead of interrupts and runs the firmware in slow pace due to
hardware limitations.

This series should be applied over "Add driver for GSC controller"
patch series.

Greg KH, please review and ACK the MEI patches.
We are pushing all through gfx tree as the device belongs there.

Alexander Usyskin (5):
  drm/i915/gsc: add slow_fw flag to the mei auxiliary device
  drm/i915/gsc: add slow_fw flag to the gsc device definition
  drm/i915/gsc: add GSC XeHP SDV platform definition
  mei: gsc: wait for reset thread on stop
  mei: extend timeouts on slow devices.

Tomas Winkler (1):
  mei: gsc: use polling instead of interrupts

Vitaly Lubart (1):
  drm/i915/gsc: skip irq initialization if using polling

 drivers/gpu/drm/i915/gt/intel_gsc.c | 34 +++++++++--
 drivers/misc/mei/bus-fixup.c        |  3 +-
 drivers/misc/mei/client.c           | 14 ++---
 drivers/misc/mei/gsc-me.c           | 44 ++++++++++++---
 drivers/misc/mei/hbm.c              | 12 ++--
 drivers/misc/mei/hw-me.c            | 88 +++++++++++++++++++++++------
 drivers/misc/mei/hw-me.h            | 14 ++++-
 drivers/misc/mei/hw-txe.c           |  2 +-
 drivers/misc/mei/hw.h               |  5 ++
 drivers/misc/mei/init.c             | 21 ++++++-
 drivers/misc/mei/main.c             |  2 +-
 drivers/misc/mei/mei_dev.h          | 16 ++++++
 drivers/misc/mei/pci-me.c           |  2 +-
 include/linux/mei_aux.h             |  1 +
 14 files changed, 208 insertions(+), 50 deletions(-)

-- 
2.32.0

