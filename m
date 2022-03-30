Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048254EC7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347819AbiC3PIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347797AbiC3PIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4512E98F7A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1E8C23A;
        Wed, 30 Mar 2022 08:06:28 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A28163F73B;
        Wed, 30 Mar 2022 08:06:27 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 00/22] SCMIv3.1 Miscellaneous changes 
Date:   Wed, 30 Mar 2022 16:05:29 +0100
Message-Id: <20220330150551.2573938-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series introduces a bunch of SCMIv3.1 miscellaneous changes to support
basically all the SCMIv3.1 specification [1] addition with the exclusion of
the Powercap protocol and driver which will be introduced later on in
another series.

Most notably the series adds:

 - supports across all protocols for long resources naming using *_NAME_GET
   dedicated new commands
 - Clock protocol Rate change pre and post notifications
 - Voltage protocol asynchronous voltage level set command
   (VOLTAGE_LEVEL_SET_COMPLETE delayed response)
 - Perf protocol power-cost in micro-watts (only internal support)
 - Perf protocol PERFORMANCE_LIMITS_SET	new checks

Beside this, the series starts with a few general fixes (01-08/22) and a
couple of refactoring:

 - one (09/22) simply to split out of common.h into a new protocols.h all
   the  structures needed only by protocol code, so that the protocol
   implementation can include such reduced header instead of the whole
   common.h which was growing insanely

 - another around the handling of multi-part commands.
   SCMI already allowed to issue some commands using a multi-message scheme
   through which a particularly big response, which could possibly not fit
   the underlying transport max payload size, could have been split into
   multiple chunks.
   Such logic, though, was scattered all across various protocols, leading
   to a lot of code duplication, so, before adding even more duplication
   with SCMIv3.1, I split out the common logic to a couple of helpers to
   handle such mechanism in a common way through some abstract iterators
   (13/22) and then ported all the protocols users of such mechanism to the
   common iterators (14,16-18/22).

SCMIv3.1 new features have been tested with an emulated backend server,
while refactoring has been chekced against a standard SCMI stack running
on a JUNO.

The series is based on sudeep/for-next/scmi/updates [2] on top of

commit 38a0e5b735d6 ("clk: scmi: Support atomic clock enable/disable API")

Any feedback very welcome,

Thanks,
Cristian


[1]: https://developer.arm.com/documentation/den0056/d/?lang=en
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi/updates
---

Cristian Marussi (22):
  firmware: arm_scmi: Fix sorting of retrieved clock rates
  firmware: arm_scmi: Make protocols init fail on basic errors
  firmware: arm_scmi: Fix Base list protocols enumeration
  firmware: arm_scmi: Validate BASE_DISCOVER_LIST_PROTOCOLS reply
  firmware: arm_scmi: Dynamically allocate protocols array
  firmware: arm_scmi: Make name_get operations return a const
  firmware: arm_scmi: Check CLOCK_RATE_SET_COMPLETE async reply
  firmware: arm_scmi: Remove unneeded NULL termination of clk name
  firmware: arm_scmi: Split protocol specific definitions in a dedicated
    header
  firmware: arm_scmi: Introduce a common SCMIv3.1 .extended_name_get
    helper
  firmware: arm_scmi: Add SCMIv3.1 extended names protocols support
  firmware: arm_scmi: Parse clock_enable_latency conditionally
  firmware: arm_scmi: Add iterators for multi-part commands
  firmware: arm_scmi: Use common iterators in Sensor protocol
  firmware: arm_scmi: Add SCMIv3.1 SENSOR_AXIS_NAME_GET support
  firmware: arm_scmi: Use common iterators in Clock protocol
  firmware: arm_scmi: Use common iterators in Voltage protocol
  firmware: arm_scmi: Use common iterators in Perf protocol
  firmware: arm_scmi: Add SCMIv3.1 Clock notifications
  firmware: arm_scmi: Add SCMIv3.1 VOLTAGE_LEVEL_SET_COMPLETE
  firmware: arm_scmi: Add SCMI v3.1 Perf power-cost in microwatts
  firmware: arm_scmi: Add SCMIv3.1 PERFORMANCE_LIMITS_SET checks

 drivers/firmware/arm_scmi/base.c      |  43 +-
 drivers/firmware/arm_scmi/clock.c     | 337 +++++++++++---
 drivers/firmware/arm_scmi/common.h    | 225 +--------
 drivers/firmware/arm_scmi/driver.c    | 165 ++++++-
 drivers/firmware/arm_scmi/perf.c      | 162 ++++---
 drivers/firmware/arm_scmi/power.c     |  44 +-
 drivers/firmware/arm_scmi/protocols.h | 318 +++++++++++++
 drivers/firmware/arm_scmi/reset.c     |  40 +-
 drivers/firmware/arm_scmi/sensors.c   | 645 +++++++++++++++-----------
 drivers/firmware/arm_scmi/system.c    |   9 +-
 drivers/firmware/arm_scmi/voltage.c   | 218 ++++++---
 include/linux/scmi_protocol.h         |  31 +-
 12 files changed, 1495 insertions(+), 742 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/protocols.h

-- 
2.32.0

