Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1324CFCFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbiCGLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbiCGLdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:33:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB738BD;
        Mon,  7 Mar 2022 03:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646652712; x=1678188712;
  h=from:to:cc:subject:date:message-id;
  bh=taJVbOkbq4815jJx0zsLc1Ta5cZzXXrOBZt48RQsYOI=;
  b=NC4esr4QQHrJAR7Ku6N2vY8Zo/7VJ0X7nUNfzNCEZ+m6r9uM/BKQAcvC
   2dPlAWF9sHkyAi6b+g1lDdIBlYBjN7yph1IqYQaNRnVVyQZYBjGMtQR2t
   CTWuVcVPhrNEuFd3XHuv0Ta4agiM/iJuZ3gKFRK++mSfExVIcAl6hw0bG
   RYRSpg6rem7ZyKRyTXa7i3wJGm/jH4/we3m4skVmF85/j3yUnScp+dzqB
   8mqOG4ij4pr78KJMFI13LLW6K9iNV8wj9HBg9GwKjhsnTYr9YqAH87TdK
   4+Dh/AaCL3ypLINtJc54lXNJOJE6BYrd5JrFmu5NbrA5cce+MXSC90b7g
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="234324453"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="234324453"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 03:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643212644"
Received: from gio-01395267462.iind.intel.com ([10.49.4.124])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 03:31:48 -0800
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v9 0/2] Add the driver for Intel Keem Bay SoC timer block
Date:   Mon,  7 Mar 2022 17:01:45 +0530
Message-Id: <20220307113147.19496-1-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/clocksource/timer-keembay.c           | 227 ++++++++++++++++++
 5 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
 create mode 100644 drivers/clocksource/timer-keembay.c


base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
2.17.1

