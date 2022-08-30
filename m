Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBBD5A6ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiH3Rcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiH3Rbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:31:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CB14D8B3C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:28:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0121042;
        Tue, 30 Aug 2022 10:26:41 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.15.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4DE33F7B4;
        Tue, 30 Aug 2022 10:26:33 -0700 (PDT)
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
Subject: [PATCH v2 1/5] coresight: Remove unused function parameter
Date:   Tue, 30 Aug 2022 18:26:09 +0100
Message-Id: <20220830172614.340962-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220830172614.340962-1-james.clark@arm.com>
References: <20220830172614.340962-1-james.clark@arm.com>
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

The ability to use a custom function in this sysfs show function isn't
used so remove it.

No functional changes.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index ff1dd2092ac5..f2458b794ef3 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -40,31 +40,23 @@
 #define ETM_MODE_EXCL_KERN	BIT(30)
 #define ETM_MODE_EXCL_USER	BIT(31)
 
-typedef u32 (*coresight_read_fn)(const struct device *, u32 offset);
-#define __coresight_simple_func(type, func, name, lo_off, hi_off)	\
+#define __coresight_simple_show(type, name, lo_off, hi_off)		\
 static ssize_t name##_show(struct device *_dev,				\
 			   struct device_attribute *attr, char *buf)	\
 {									\
 	type *drvdata = dev_get_drvdata(_dev->parent);			\
-	coresight_read_fn fn = func;					\
 	u64 val;							\
 	pm_runtime_get_sync(_dev->parent);				\
-	if (fn)								\
-		val = (u64)fn(_dev->parent, lo_off);			\
-	else								\
-		val = coresight_read_reg_pair(drvdata->base,		\
-						 lo_off, hi_off);	\
+	val = coresight_read_reg_pair(drvdata->base, lo_off, hi_off);	\
 	pm_runtime_put_sync(_dev->parent);				\
 	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", val);		\
 }									\
 static DEVICE_ATTR_RO(name)
 
-#define coresight_simple_func(type, func, name, offset)			\
-	__coresight_simple_func(type, func, name, offset, -1)
 #define coresight_simple_reg32(type, name, offset)			\
-	__coresight_simple_func(type, NULL, name, offset, -1)
+	__coresight_simple_show(type, name, offset, -1)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
-	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
+	__coresight_simple_show(type, name, lo_off, hi_off)
 
 extern const u32 coresight_barrier_pkt[4];
 #define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
-- 
2.28.0

