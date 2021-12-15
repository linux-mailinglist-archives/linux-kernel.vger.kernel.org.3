Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD9475780
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhLOLMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:12:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:63314 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234229AbhLOLMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639566730; x=1671102730;
  h=from:to:cc:subject:date:message-id;
  bh=TRlsb41I8vxysckuqEL/0Yn2c/OFDd+/6zTgE3nAHDw=;
  b=dwna7M0xKfeF2i8TK3lNbrkyo8IyyaXRgRU3yakBeTPbfjIJCRnhKvEY
   y90fF46FuOhuayhTt4mUxSFhLYEr8r5SqZEfSAd81N6u64C1BNRhhiH89
   1BKEafBrRMIcMid/1GuIhR7yJVlTtXwtCjJk/AyIBo8hxcNdTmUio5c1+
   7hGveqyXGhEzvaaM8NHTWJDjT/jFrIy+H7Mun/ygAxfp108iedBTSwI9N
   wBuGFGvHVKhp0JjtssJIURtopCo0XI12bMyfTnsUCjgV2ZJkhvRT/FvO5
   K28+UDVC2yGv4ctA+gOEKMKvT7alJdOXbIYfpblIlHLqw8FVj9mbm81qi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239424541"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239424541"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 03:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="661891524"
Received: from ipu5-build.bj.intel.com ([10.238.232.188])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2021 03:12:08 -0800
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        rafael@kernel.org
Cc:     shawnx.tu@intel.com, chiranjeevi.rapolu@intel.com,
        tfiga@chromium.org, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, bingbu.cao@linux.intel.com
Subject: [PATCH v2 0/6] Support device probe in non-zero ACPI D state
Date:   Wed, 15 Dec 2021 19:08:57 +0800
Message-Id: <1639566543-8561-1-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many use cases where the chip is part of a camera module, and the camera
module is wired together with a privacy LED, powering on the device during
probe will cause the LED blink, it is undesireable as the privacy LED concern.

Sakari's change - 
https://lore.kernel.org/lkml/20211018121729.6357-1-sakari.ailus@linux.intel.com/
which add the support device probe in non-zero ACPI D state.

This following patch add support probe in non-zero ACPI D state for more camera
sensors: ov2740, ov5670, ov5675, ov8856, imx208 and hi556.

--

This patch series is based on linux-next branch of Rafael J. Wysocki's
linux-pm git repository:
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

--

Bingbu Cao (5):
  media: ov8856: support device probe in non-zero ACPI D state
  media: ov2740: support device probe in non-zero ACPI D state
  media: imx208: Support device probe in non-zero ACPI D state
  media: ov5675: Support device probe in non-zero ACPI D state
  media: hi556: Support device probe in non-zero ACPI D state

Sakari Ailus (1):
  media: ov5670: Support device probe in non-zero ACPI D state

 drivers/media/i2c/hi556.c  |  70 +++++++++++++-------
 drivers/media/i2c/imx208.c |  82 +++++++++++++++--------
 drivers/media/i2c/ov2740.c |  69 ++++++++++++-------
 drivers/media/i2c/ov5670.c |  78 +++++++++++++---------
 drivers/media/i2c/ov5675.c |  71 +++++++++++++-------
 drivers/media/i2c/ov8856.c | 162 +++++++++++++++++++++++++--------------------
 6 files changed, 324 insertions(+), 208 deletions(-)

-- 
2.7.4

