Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EFA4A838E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350532AbiBCMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:06:55 -0500
Received: from foss.arm.com ([217.140.110.172]:42642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232343AbiBCMGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:06:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B8A11D4;
        Thu,  3 Feb 2022 04:06:43 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.13.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BDC03F774;
        Thu,  3 Feb 2022 04:06:42 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/15] coresight: Make ETM4x TRCSSPCICRn register accesses consistent with sysreg.h
Date:   Thu,  3 Feb 2022 12:06:01 +0000
Message-Id: <20220203120604.128396-14-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h       | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 7d9372ba1168..682819467755 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1843,7 +1843,7 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;
-	config->ss_pe_cmp[idx] = val & GENMASK(7, 0);
+	config->ss_pe_cmp[idx] = val & (TRCSSPCICRn_PC_MASK << TRCSSPCICRn_PC_SHIFT);
 	/* must clear bit 31 in related status register on programming */
 	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
 	spin_unlock(&drvdata->spinlock);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9c22a5b0777f..9d0978540338 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -251,6 +251,9 @@
 #define TRCSSCCRn_SAC_ARC_RST_SHIFT		0
 #define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
 
+#define TRCSSPCICRn_PC_SHIFT			0
+#define TRCSSPCICRn_PC_MASK			GENMASK(7, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

