Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C934E3F05
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiCVNBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiCVNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:01:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF265EBF2;
        Tue, 22 Mar 2022 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647954010; x=1679490010;
  h=from:to:cc:subject:date:message-id;
  bh=W6HrUcctbXcPAIYg27em+LKpxhgknfKqvMEsQfwhYmg=;
  b=BMeQkIIdzOvxwkha3tT98WSjSWcXA+2MzdbKaAk4tt9jB16ltB3DSjmX
   yJ6MZy67Rw4/QngCWSC9h6g4nkjNCd9XjgtJGOnuPEm4zPWDf/q2I+6+3
   uA62QyDvfOkEPtfxY/HEujo3LPzpRyTp+ld3KMpzBFpzolHJbwBBoTg8m
   eF2UkPlzN1+bebSGkDMaH0Z0PsRFvXTvwWR+4mt3ec17SL/mq1r9pP5Ba
   tJ5iaidBGzWMqHWJF/142b7/DZqJBwy0P5HFi8/pCGQvdzmYEpyvxORMx
   kYMT72fpGQ4aIyG/qbuQDK3QDMpwYVO83OB8mklTcSlAttoKyqzqF+Q4/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282645693"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="282645693"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 06:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="552087563"
Received: from gio-01395267463.iind.intel.com ([10.49.4.124])
  by fmsmga007.fm.intel.com with ESMTP; 22 Mar 2022 06:00:06 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v10 0/2] Add the driver for Intel Keem Bay SoC timer block
Date:   Tue, 22 Mar 2022 18:30:03 +0530
Message-Id: <20220322130005.16045-1-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

The timer block supports 1 64-bit free running counter
and 8 32-bit general purpose timers.

Patch 1 holds the device tree binding documentation.
Patch 2 holds the device driver.

This driver is tested on the Keem Bay evaluation module board.

Changes since v9:
- Updated the error message with the macro FW_BUG wherever applicable.

Changes since v8:
- The clockevent stucture has been declared as a global static variable,
  rather than allocating memory using kzalloc during probing.
- Updated the print statement indicating the configuration missing as the FW Bug.
- Updated the comments in the function keembay_timer_isr().
- Updated the dt-binding to remove 'oneOf' as there is only 1 entry.
- Updated the dt-binding description clearly indicating that
  the descrption is about the undelying HW.

Changes since v7:
- Added back the compatible string "intel,keembay-gpt-creg"
  as an enum to the mfd device node in the device tree bindings.
- As the timer is used as a broadcast timer during CPU idle,
  only one timer is needed. Hence updated the driver accordingly
  incorporating the review comments.

Changes since v6:
- Removed the unused compatible string from the mfd device node
  to fix the error thrown by the make dt-binding command.

Changes since v5:
- Created a MFD device for the common configuration register
  in the device tree bindings.
- Updated the timer driver with the MFD framework to access the
  common configuration register.

Changes since v4:
- Updated the description in the device tree bindings.
- Updated the unit address of all the timers and counter
  in the device tree binding.

Changes since v3:
- Update in KConfig file to support COMPILE_TEST for Keem Bay timer.
- Update in device tree bindings to remove status field.
- Update in device tree bindings to remove 64-bit address space for
  the child nodes by using non-empty ranges.

Changes since v2:
- Add multi timer support.
- Update in the device tree binding to support multi timers.
- Code optimization.

Changes since v1:
- Add support for KEEMBAY_TIMER to get selected through Kconfig.platforms.
- Add CLOCK_EVT_FEAT_DYNIRQ as part of clockevent feature.
- Avoid overlapping reg regions across 2 device nodes.
- Simplify 2 device nodes as 1 because both are from same IP block.
- Adapt the driver code according to the new simplified devicetree.

Shruthi Sanil (2):
  dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
  clocksource: Add Intel Keem Bay timer support

 .../bindings/timer/intel,keembay-timer.yaml   | 125 ++++++++++
 MAINTAINERS                                   |   6 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-keembay.c           | 226 ++++++++++++++++++
 5 files changed, 369 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
 create mode 100644 drivers/clocksource/timer-keembay.c


base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
2.17.1

