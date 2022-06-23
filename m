Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415E3557A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiFWMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFWMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:48:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B1DFBCAD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:47:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CB7312FC;
        Thu, 23 Jun 2022 05:47:58 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5824C3F534;
        Thu, 23 Jun 2022 05:47:57 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        f.fainelli@gmail.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/5] Introduce SCMI System Power Control driver
Date:   Thu, 23 Jun 2022 13:47:37 +0100
Message-Id: <20220623124742.2492164-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a respin of an old series[0] parked for a while waiting for
a required SCMI specification change to be published.

The series, building on top of the SCMI System Power Protocol, adds a new 
SCMI driver which, registering for SystemPower notifications, takes care to
satisfy SCMI plaform system-transitions graceful requests like shutdown or
reboot involving userspace interactions as needed.

Interaction with userspace boils down to the same orderly_ Kernel methods
used by ACPI to handle similar shutdown requests.

The latest SCMI v3.1 specification [1], which adds a new timeout field to
the graceful notifications payload, let the platform advertise for how long
it will possibly wait for the requested system state transition to happen
before forcibly enforcing it.

As a part of the series, patch 2/3 enforces, at the SCMI core level, the
creation of one single SCMI SystemPower device, to avoid promoting the
design of systems in which multiple SCMI platforms can advertise the
concurrent support of SystemPower protocol: when multiple SCMI platform
are defined, only one of them should be in charge of SystemPower comms
with the OSPM, so only one such SystemPower device across all platforms
is allowed to be created.

Thanks,
Cristian

[0]:https://lore.kernel.org/linux-arm-kernel/20210204165913.42582-1-cristian.marussi@arm.com/
[1]:https://developer.arm.com/documentation/den0056/d/?lang=en

Cristian Marussi (5):
  firmware: arm_scmi: Remove deprecated ida_simple_ calls
  firmware: arm_scmi: Support only one single SystemPower device
  firmware: arm_scmi: Add SCMIv3.1 SystemPower extensions
  firmware: arm_scmi: Add devm_protocol_acquire helper
  firmware: arm_scmi: Add SCMI System Power Control driver

 drivers/firmware/arm_scmi/Kconfig             |  12 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 drivers/firmware/arm_scmi/bus.c               |  37 +-
 drivers/firmware/arm_scmi/driver.c            |  70 +++-
 .../firmware/arm_scmi/scmi_power_control.c    | 362 ++++++++++++++++++
 drivers/firmware/arm_scmi/system.c            |  17 +-
 include/linux/scmi_protocol.h                 |   7 +
 7 files changed, 486 insertions(+), 20 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_power_control.c

-- 
2.32.0

