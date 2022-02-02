Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C059B4A7552
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbiBBQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:03:19 -0500
Received: from foss.arm.com ([217.140.110.172]:39858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231594AbiBBQDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:03:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D467A11D4;
        Wed,  2 Feb 2022 08:03:13 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96A133F73B;
        Wed,  2 Feb 2022 08:03:11 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] coresight: Make ETM3x ETMTECR1 register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:20 +0000
Message-Id: <20220202160226.37858-11-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220202160226.37858-1-james.clark@arm.com>
References: <20220202160226.37858-1-james.clark@arm.com>
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

