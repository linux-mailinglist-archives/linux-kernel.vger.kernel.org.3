Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C284BF535
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiBVJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBVJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:57:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388EE434BF;
        Tue, 22 Feb 2022 01:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645523818; x=1677059818;
  h=from:to:cc:subject:date:message-id;
  bh=zCWGZm+hLkjPW3qAHOxo7E74y6G0l0RwblNkTmSEMag=;
  b=n39xo5AG47v2ACi5P1KD0fGWMNG5kZeL6ajOJB9j58DyaLu+vUi5OXK2
   mEpDfMVx2wJH0MGhuoYSEh6eTAH/OJ+SdDfuTaL52y9YhI/+b9W2WUKzE
   3KQPk4w2/tdB73EvrxX5RF49nc2V5vwywyByR1EWKOUmT7fRpt8JtkzYX
   Heal6p1ejfsI6cNv/r/mGhaYmZJfW6R5NuU00lq1tX4opf8bzoy08f1IX
   58vFWL66ZdEXaa/iMv5zE0iaj8V+ZMP9+iDNXIFbKGVtECPea2VxRlT/Z
   GGsmnWA0z7b3S2QuR5r3NvbeyG0meIyV21dWYxhCZPliphxU6WquJy6Oy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250478860"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="250478860"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:56:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="591248136"
Received: from gio-01395267462.iind.intel.com ([10.49.4.124])
  by fmsmga008.fm.intel.com with ESMTP; 22 Feb 2022 01:56:55 -0800
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v8 0/2] Add the driver for Intel Keem Bay SoC timer block
Date:   Tue, 22 Feb 2022 15:26:52 +0530
Message-Id: <20220222095654.9097-1-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

 .../bindings/timer/intel,keembay-timer.yaml   | 128 ++++++++++
 MAINTAINERS                                   |   6 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-keembay.c           | 230 ++++++++++++++++++
 5 files changed, 376 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
 create mode 100644 drivers/clocksource/timer-keembay.c


base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.17.1

