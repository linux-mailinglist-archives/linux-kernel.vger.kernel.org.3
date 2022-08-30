Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8798A5A6AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiH3RcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiH3RbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:31:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1571647E2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:28:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 897E41063;
        Tue, 30 Aug 2022 10:26:38 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.15.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51E8C3F7B4;
        Tue, 30 Aug 2022 10:26:30 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 0/5] coresight: Reduce duplicated sysfs accessors
Date:   Tue, 30 Aug 2022 18:26:08 +0100
Message-Id: <20220830172614.340962-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
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

Changes since v1:

  * Keep existing signed offset value types until the very last commit
    and then remove them all at once

  * Also split out usages of read_pair() and read32() into separate
    functions in the last commit 

  * Whitespace fixes

  * Replaced any touched scnprintf() with sysfs_emit()

======

The intent of this change is to reduce the large number identical of
functions created by macros for sysfs accessors. It's possible to re-use
the same function but pass in the register to access as an argument.
This reduces the size of the coresight modules folder by 244KB.

The first two patches are refactors to simplify and remove some dead
code, and the second two are the changes to use a shared function.

Testing
=======

No changes in any of the outputs:

  cat /sys/bus/coresight/devices/*/mgmt/* > before.txt
  cat /sys/bus/coresight/devices/*/mgmt/* > after.txt
  diff before.txt after.txt

With the following modules loaded:

  ls /sys/bus/coresight/devices/
  etm0  etm2  funnel0  funnel2  replicator0  tmc_etf0  tmc_etf2  tpiu0
  etm1  etm3  funnel1  funnel3  stm0         tmc_etf1  tmc_etr0


James Clark (5):
  coresight: Remove unused function parameter
  coresight: Simplify sysfs accessors by using csdev_access abstraction
  coresight: Re-use same function for similar sysfs register accessors
  coresight: cti-sysfs: Re-use same functions for similar sysfs register
    accessors
  coresight: Make new csdev_access offsets unsigned

 drivers/hwtracing/coresight/coresight-catu.c  |  27 +--
 drivers/hwtracing/coresight/coresight-catu.h  |   8 +-
 drivers/hwtracing/coresight/coresight-core.c  |  28 +++
 .../hwtracing/coresight/coresight-cti-sysfs.c | 213 +++++++-----------
 drivers/hwtracing/coresight/coresight-etb10.c |  28 +--
 .../coresight/coresight-etm3x-sysfs.c         |  34 +--
 drivers/hwtracing/coresight/coresight-priv.h  |  74 +++---
 .../coresight/coresight-replicator.c          |  10 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  40 +---
 .../hwtracing/coresight/coresight-tmc-core.c  |  48 ++--
 drivers/hwtracing/coresight/coresight-tmc.h   |   4 +-
 include/linux/coresight.h                     |  23 ++
 12 files changed, 227 insertions(+), 310 deletions(-)

-- 
2.28.0

