Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6654A8388
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbiBCMGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:06:44 -0500
Received: from foss.arm.com ([217.140.110.172]:42592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350462AbiBCMGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:06:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11DE41396;
        Thu,  3 Feb 2022 04:06:36 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.13.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89BC23F774;
        Thu,  3 Feb 2022 04:06:34 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/15] coresight: Make ETM3x ETMTECR1 register accesses consistent with sysreg.h
Date:   Thu,  3 Feb 2022 12:05:58 +0000
Message-Id: <20220203120604.128396-11-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220203120604.128396-1-james.clark@arm.com>
References: <20220203120604.128396-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a no-op change for style and consistency and has no effect on the
binary produced by gcc-11.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c  | 2 +-
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index cf64ce73a741..35e4bdee848c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -204,7 +204,7 @@ void etm_set_default(struct etm_config *config)
 	 *  set all bits in register 0x007, the ETMTECR2, to 0
 	 *  set register 0x008, the ETMTEEVR, to 0x6F (TRUE).
 	 */
-	config->enable_ctrl1 = BIT(24);
+	config->enable_ctrl1 = ETMTECR1_INC_EXC;
 	config->enable_ctrl2 = 0x0;
 	config->enable_event = ETM_HARD_WIRE_RES_A;
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index e8c7649f123e..68fcbf4ce7a8 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -474,7 +474,7 @@ static ssize_t addr_start_store(struct device *dev,
 	config->addr_val[idx] = val;
 	config->addr_type[idx] = ETM_ADDR_TYPE_START;
 	config->startstop_ctrl |= (1 << idx);
-	config->enable_ctrl1 |= BIT(25);
+	config->enable_ctrl1 |= ETMTECR1_START_STOP;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
-- 
2.28.0

