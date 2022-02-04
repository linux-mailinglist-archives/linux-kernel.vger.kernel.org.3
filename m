Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167654A9163
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356109AbiBDADd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:03:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:8517 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230428AbiBDADa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643933010; x=1675469010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4rqfnTqkIsHPK3qi3BiaI2xAP079K/WE+/AVeqlB8lc=;
  b=ISu8C1ugnrDg1hV8XZLbpLuT9c2zEWfglVqOh6TcIzCxpojdISJCrcRl
   WPICvmEuHR0UOeEVNEHXYYQCh6XpdF94HkTmwhqPsj6hbeMfxLDScFE6t
   rlPIAHtQPvWswagTIYUXlcIGF8qakUNct7foISWuzwsN3vRP9FSFJZmpy
   joK6esxgiFLf0/07fMtvEL7cTa+OacjrSM8DOpi7LbBxOC4LqpFj1mUWz
   roj+MoeCBO6o2Ya/sE7epntEDmzva/8YbH0RNbj35ho3spgZJFcf4sR64
   2OjmcBrSd9Xl18vaFTjRa7x1p5QfheNqB5wzQcuXBypftvTJJuhdpYH7o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="272779952"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="272779952"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 16:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="620684664"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Feb 2022 16:03:30 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/4] platform/x86/intel/uncore-freq: Enhance HW interface
Date:   Thu,  3 Feb 2022 16:03:02 -0800
Message-Id: <20220204000306.2517447-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uncore frequency scaling is getting used by more customers to either
have a deterministic performance or control power consumption.
The uncore frequency scaling depends on non architecture MSRs, format of
those MSR can be different on different generations of CPUs.
This series prepares for easy addition of new HW interface.

There are no functional changes done except adding a new addition to
read uncore frequency.

- The first patch creates a separate folder for uncore-freq.
- The second patch uses sysfs groups to create attributes.
- The third patch adds capability to read current uncore frequency.
- The fourth patch splits common and enumeration part. The enumeration
part will be specific to each HW interface.

Srinivas Pandruvada (4):
  platform/x86/intel/uncore-freq: Move to uncore-frequency folder
  platform/x86/intel/uncore-freq: Use sysfs API to create attributes
  platform/x86/intel/uncore-freq: Display uncore current frequency
  platform/x86/intel-uncore-freq: Split common and enumeration part

 drivers/platform/x86/intel/Kconfig            |  14 +-
 drivers/platform/x86/intel/Makefile           |   4 +-
 drivers/platform/x86/intel/uncore-frequency.c | 452 ------------------
 .../x86/intel/uncore-frequency/Kconfig        |  21 +
 .../x86/intel/uncore-frequency/Makefile       |   9 +
 .../uncore-frequency-common.c                 | 252 ++++++++++
 .../uncore-frequency-common.h                 |  62 +++
 .../intel/uncore-frequency/uncore-frequency.c | 272 +++++++++++
 8 files changed, 620 insertions(+), 466 deletions(-)
 delete mode 100644 drivers/platform/x86/intel/uncore-frequency.c
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/Kconfig
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/Makefile
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
 create mode 100644 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c

-- 
2.31.1

