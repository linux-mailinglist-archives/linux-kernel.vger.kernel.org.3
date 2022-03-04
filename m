Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E234CDA1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbiCDRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiCDRU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 187071520C2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:20:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D97C51424;
        Fri,  4 Mar 2022 09:20:01 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 425303F73D;
        Fri,  4 Mar 2022 09:20:00 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] coresight: etm4x: Cleanup TRCRSCTLRn register accesses
Date:   Fri,  4 Mar 2022 17:19:12 +0000
Message-Id: <20220304171913.2292458-16-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220304171913.2292458-1-james.clark@arm.com>
References: <20220304171913.2292458-1-james.clark@arm.com>
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

This is a no-op change for style and consistency and has no effect on
the binary output by the compiler. In sysreg.h fields are defined as
the register name followed by the field name and then _MASK. This
allows for grepping for fields by name rather than using magic numbers.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 7 +++++--
 drivers/hwtracing/coresight/coresight-etm4x.h       | 7 +++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 3ae6f4432646..6ea8181816fc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1726,8 +1726,11 @@ static ssize_t res_ctrl_store(struct device *dev,
 	/* For odd idx pair inversal bit is RES0 */
 	if (idx % 2 != 0)
 		/* PAIRINV, bit[21] */
-		val &= ~BIT(21);
-	config->res_ctrl[idx] = val & GENMASK(21, 0);
+		val &= ~TRCRSCTLRn_PAIRINV;
+	config->res_ctrl[idx] = val & (TRCRSCTLRn_PAIRINV |
+				       TRCRSCTLRn_INV |
+				       TRCRSCTLRn_GROUP_MASK |
+				       TRCRSCTLRn_SELECT_MASK);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 15704982357f..2c412841b126 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -223,6 +223,13 @@
 #define TRCBBCTLR_MODE				BIT(8)
 #define TRCBBCTLR_RANGE_MASK			GENMASK(7, 0)
 
+#define TRCRSCTLRn_PAIRINV			BIT(21)
+#define TRCRSCTLRn_INV				BIT(20)
+#define TRCRSCTLRn_GROUP_MASK			GENMASK(19, 16)
+#define TRCRSCTLRn_SELECT_MASK			GENMASK(15, 0)
+
+
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

